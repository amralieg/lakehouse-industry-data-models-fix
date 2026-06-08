-- Schema for Domain: compliance | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`compliance` COMMENT 'Manages regulatory compliance obligations, audit schedules, loot box probability disclosure requirements, GDPR/COPPA data subject requests, age rating certification tracking, and jurisdictional regulatory reporting across all territories where games are published.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory compliance obligation record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Every regulatory obligation is scoped to a specific legal jurisdiction (e.g., GDPR applies to EU, COPPA to US, loot box laws to Belgium/Netherlands). Without this FK, regulatory_obligation has no stru',
    `parent_regulatory_obligation_id` BIGINT COMMENT 'Self-referencing FK on regulatory_obligation (parent_regulatory_obligation_id)',
    `applicable_platforms` STRING COMMENT 'Comma-separated list of gaming platforms to which this obligation applies (e.g., PC, Console, Mobile, Steam, Epic Games Store, PlayStation, Xbox, Nintendo Switch, iOS, Android).',
    `audit_frequency` STRING COMMENT 'Required or planned frequency of compliance audits for this obligation.. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc|continuous`',
    `compliance_owner` STRING COMMENT 'Name or identifier of the individual or team responsible for ensuring compliance with this obligation.',
    `compliance_status` STRING COMMENT 'Current compliance status of Gaming with respect to this obligation.. Valid values are `compliant|non_compliant|in_progress|not_applicable|under_review|remediation_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days that data must be retained to satisfy this obligation. NULL if not applicable or variable.',
    `documentation_url` STRING COMMENT 'URL or file path to the official regulatory documentation, guidance, or internal compliance procedures for this obligation.',
    `effective_date` DATE COMMENT 'Date when this regulatory obligation became or will become enforceable.',
    `enforcement_mechanism` STRING COMMENT 'Primary enforcement action that the governing body can take for non-compliance.. Valid values are `statutory_penalty|platform_delisting|certification_revocation|injunction|consent_decree|administrative_fine`',
    `estimated_implementation_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD to implement the systems, processes, and controls required to meet this obligation.',
    `expiration_date` DATE COMMENT 'Date when this regulatory obligation ceases to be enforceable. NULL if obligation is ongoing.',
    `governing_body` STRING COMMENT 'Name of the regulatory authority or governing body that mandates this obligation (e.g., ESRB, PEGI, FTC, European Commission, GDPR Supervisory Authority).',
    `implementation_deadline` DATE COMMENT 'Internal or regulatory deadline by which compliance implementation must be completed.',
    `implementation_status` STRING COMMENT 'Current status of the technical or operational implementation required to meet this obligation.. Valid values are `not_started|planning|in_development|testing|deployed|verified`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this regulatory obligation is currently active and enforceable. False if obligation has been superseded or is no longer applicable.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit of compliance with this obligation.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty amount in USD for non-compliance. NULL if penalty is not monetary or is variable.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit of this obligation.',
    `next_reporting_deadline` DATE COMMENT 'Next scheduled deadline for submitting compliance reports to the governing body.',
    `notes` STRING COMMENT 'Additional notes, context, or special considerations related to this regulatory obligation.',
    `obligation_code` STRING COMMENT 'Unique business identifier code for the regulatory obligation (e.g., GDPR-ART17, COPPA-CONSENT, LOOTBOX-DISC-EU).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of what the regulatory obligation requires Gaming to do or refrain from doing.',
    `obligation_name` STRING COMMENT 'Full descriptive name of the regulatory obligation (e.g., Right to Erasure, Parental Consent Requirement, Loot Box Probability Disclosure).',
    `obligation_type` STRING COMMENT 'Category of regulatory obligation defining the compliance domain.. Valid values are `data_privacy|consumer_protection|content_rating|financial_reporting|tax_compliance|platform_certification`',
    `penalty_description` STRING COMMENT 'Description of the financial, operational, or reputational penalties for non-compliance (e.g., fines up to 4% of global revenue, platform removal, criminal liability).',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance status must be reported to the governing body or internal stakeholders.. Valid values are `annual|semi_annual|quarterly|monthly|event_driven|none`',
    `requires_age_verification` BOOLEAN COMMENT 'Indicates whether this obligation requires age verification mechanisms (e.g., COPPA age gate, ESRB age rating enforcement).',
    `requires_data_portability` BOOLEAN COMMENT 'Indicates whether this obligation grants players the right to receive their data in a portable format (GDPR Article 20).',
    `requires_data_retention` BOOLEAN COMMENT 'Indicates whether this obligation mandates specific data retention periods.',
    `requires_disclosure` BOOLEAN COMMENT 'Indicates whether this obligation requires public disclosure (e.g., loot box probability disclosure, privacy policy publication).',
    `requires_player_consent` BOOLEAN COMMENT 'Indicates whether this obligation requires explicit player consent (e.g., GDPR consent, COPPA parental consent).',
    `requires_right_to_erasure` BOOLEAN COMMENT 'Indicates whether this obligation grants players the right to request deletion of their personal data (GDPR Article 17).',
    `risk_level` STRING COMMENT 'Assessed risk level of non-compliance based on likelihood and impact (financial, operational, reputational).. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was last modified.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master catalog of all regulatory compliance obligations applicable to Gaming across jurisdictions — covering GDPR, COPPA, loot box disclosure laws, age rating mandates, digital goods VAT, esports betting regulations, and platform-specific compliance requirements. Each record defines the obligation type, governing body, applicable territories, enforcement mechanism, and current compliance status. Serves as the authoritative registry that all other compliance activities reference.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`jurisdiction` (
    `jurisdiction_id` BIGINT COMMENT 'Unique identifier for the legal and regulatory jurisdiction. Primary key.',
    `parent_jurisdiction_id` BIGINT COMMENT 'Reference to the parent jurisdiction for hierarchical relationships. For example, California (US-CA) would reference United States (US). Null for top-level jurisdictions.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether Gaming currently publishes or distributes games in this jurisdiction. True if active, false if the jurisdiction is no longer served or is under embargo.',
    `advertising_restrictions` STRING COMMENT 'Summary of advertising and marketing restrictions applicable to game promotion in this jurisdiction (e.g., restrictions on advertising to minors, disclosure requirements for in-game purchases, influencer marketing rules). Free-text field for compliance reference.',
    `age_verification_required_flag` BOOLEAN COMMENT 'Indicates whether age verification is legally required for game access or monetization features in this jurisdiction (e.g., for mature-rated content or in-app purchases).',
    `consumer_protection_framework` STRING COMMENT 'Name or reference to the primary consumer protection legal framework governing game sales, refunds, and player rights in this jurisdiction (e.g., EU Consumer Rights Directive, FTC Act, national consumer protection acts).',
    `content_censorship_level` STRING COMMENT 'Degree of government-mandated content censorship or restriction for game content in this jurisdiction. None (no censorship), moderate (some content restrictions, e.g., violence or political themes), strict (extensive censorship or pre-approval required).. Valid values are `none|moderate|strict`',
    `coppa_applicable_flag` BOOLEAN COMMENT 'Indicates whether COPPA (Childrens Online Privacy Protection Act) applies in this jurisdiction. True for United States and territories where COPPA is enforced by the FTC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was first created in the system. Audit trail for data lineage and compliance tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary currency used in this jurisdiction (e.g., USD, EUR, GBP, JPY, KRW).. Valid values are `^[A-Z]{3}$`',
    `data_breach_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the company is legally required to notify players and/or regulators in the event of a data breach in this jurisdiction. True for jurisdictions with mandatory breach notification laws.',
    `data_localization_required_flag` BOOLEAN COMMENT 'Indicates whether player data must be stored or processed within the jurisdictions borders (data residency requirement). True for jurisdictions with data localization laws (e.g., Russia, China).',
    `digital_goods_vat_rate` DECIMAL(18,2) COMMENT 'Standard VAT or sales tax rate (as a percentage) applicable to digital goods and services (games, DLC, MTX) sold in this jurisdiction. Null if no VAT/sales tax applies.',
    `dispute_resolution_mechanism` STRING COMMENT 'Primary legal mechanism for resolving player disputes in this jurisdiction. Arbitration (binding arbitration clauses enforceable), litigation (court-based resolution), ombudsman (government or industry ombudsman available), mediation (alternative dispute resolution preferred).. Valid values are `arbitration|litigation|ombudsman|mediation`',
    `effective_date` DATE COMMENT 'Date from which this jurisdiction record became effective for compliance and operational purposes. Represents when Gaming began recognizing this jurisdiction in its compliance framework.',
    `embargo_status` STRING COMMENT 'Trade embargo or sanctions status affecting game distribution in this jurisdiction. None (no embargo), partial (restricted distribution or content), full (complete embargo, no distribution allowed).. Valid values are `none|partial|full`',
    `esports_gambling_regulated_flag` BOOLEAN COMMENT 'Indicates whether esports betting and gambling activities are regulated or restricted in this jurisdiction. True if esports gambling is subject to gaming/gambling laws.',
    `expiration_date` DATE COMMENT 'Date on which this jurisdiction record expires or is no longer applicable. Null for currently active jurisdictions. Used when a jurisdiction is deprecated, merged, or Gaming ceases operations there.',
    `gdpr_applicable_flag` BOOLEAN COMMENT 'Indicates whether GDPR (General Data Protection Regulation) applies to player data processing in this jurisdiction. True for EU/EEA member states and territories where GDPR is in force.',
    `jurisdiction_code` STRING COMMENT 'Standardized code for the jurisdiction. ISO 3166-1 alpha-2 or alpha-3 for countries (e.g., US, USA, DE, DEU), ISO 3166-2 for subdivisions (e.g., US-CA, DE-BY), or custom codes for supranational regions (e.g., EU, EEA).. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{1,3})?$`',
    `jurisdiction_name` STRING COMMENT 'Full legal name of the jurisdiction (e.g., United States, California, European Union).',
    `jurisdiction_type` STRING COMMENT 'Classification of the jurisdiction: country (sovereign nation), state/province/territory (subdivision of a country), supranational (multi-country region such as EU or EEA).. Valid values are `country|state|province|territory|region|supranational`',
    `loot_box_regulatory_status` STRING COMMENT 'Regulatory treatment of loot boxes and randomized monetization mechanics in this jurisdiction. Unrestricted (no specific regulation), disclosure_required (probability disclosure mandated), restricted (age or spending limits apply), prohibited (loot boxes banned), under_review (pending legislation).. Valid values are `unrestricted|disclosure_required|restricted|prohibited|under_review`',
    `minimum_age_for_monetization` STRING COMMENT 'Minimum age (in years) at which a player may engage in in-app purchases (IAP) or microtransactions (MTX) without parental consent in this jurisdiction. Null if no specific age restriction applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was last modified. Audit trail for tracking regulatory updates and compliance changes.',
    `notes` STRING COMMENT 'Free-text field for additional compliance notes, special regulatory considerations, or operational guidance specific to this jurisdiction. Used by compliance and legal teams for context and edge cases.',
    `online_service_license_required_flag` BOOLEAN COMMENT 'Indicates whether a special license or permit is required to operate online gaming services (GaaS, multiplayer, live operations) in this jurisdiction. True for jurisdictions with online service licensing requirements (e.g., China ICP license).',
    `pci_dss_enforcement_level` STRING COMMENT 'Level of PCI DSS (Payment Card Industry Data Security Standard) enforcement for payment processing in this jurisdiction. Standard (normal PCI DSS compliance required), enhanced (additional local requirements), not_applicable (jurisdiction does not enforce PCI DSS or does not support card payments).. Valid values are `standard|enhanced|not_applicable`',
    `platform_certification_required_flag` BOOLEAN COMMENT 'Indicates whether games must pass platform-specific certification (TRC/TCR - Technical Requirements Checklist/Technical Certification Requirements) to be published in this jurisdiction. True for jurisdictions where console manufacturers or app stores enforce certification.',
    `rating_authority` STRING COMMENT 'The primary game content rating authority applicable in this jurisdiction. ESRB (Entertainment Software Rating Board) for North America, PEGI (Pan European Game Information) for Europe, USK (Unterhaltungssoftware Selbstkontrolle) for Germany, CERO (Computer Entertainment Rating Organization) for Japan, GRAC (Game Rating and Administration Committee) for South Korea, ACB (Australian Classification Board) for Australia, IARC (International Age Rating Coalition) for multi-territory digital distribution. [ENUM-REF-CANDIDATE: ESRB|PEGI|USK|CERO|GRAC|ACB|IARC — 7 candidates stripped; promote to reference product]',
    `right_to_be_forgotten_applicable_flag` BOOLEAN COMMENT 'Indicates whether players have a legal right to request deletion of their personal data (right to erasure / right to be forgotten) in this jurisdiction. True for GDPR jurisdictions and others with similar data subject rights.',
    CONSTRAINT pk_jurisdiction PRIMARY KEY(`jurisdiction_id`)
) COMMENT 'Reference master for all legal and regulatory jurisdictions in which Gaming publishes or distributes games — countries, states/provinces, and supranational regions (EU, EEA). Captures jurisdiction code, jurisdiction name, governing legal framework, applicable rating authority (ESRB, PEGI, USK, CERO, GRAC, ACB), loot box regulatory status, GDPR applicability flag, COPPA applicability flag, digital goods VAT rate, and currency. Used by all compliance, billing, and title domain products to resolve territory-specific rules.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`age_rating_cert` (
    `age_rating_cert_id` BIGINT COMMENT 'Unique identifier for the age rating certificate record. Primary key.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that received this age rating certificate.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Age rating certificates are issued by jurisdiction-specific rating authorities. Replacing string-based territory_code with proper FK to jurisdiction master for referential integrity and to enable join',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Age rating certifications fulfill specific regulatory obligations (e.g., PEGI certification fulfills EU age rating requirements, ESRB fulfills North American requirements). This FK links each certific',
    `superseded_age_rating_cert_id` BIGINT COMMENT 'Self-referencing FK on age_rating_cert (superseded_age_rating_cert_id)',
    `approval_date` DATE COMMENT 'The date on which the rating authority approved the game and assigned the rating category.',
    `certificate_document_url` STRING COMMENT 'URL or storage path to the official certificate document or PDF issued by the rating authority.',
    `certificate_number` STRING COMMENT 'The official certificate number or identifier issued by the rating authority upon approval.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the age rating certificate. Pending: submitted but not yet approved; Approved: approved but not yet active; Active: currently valid; Expired: validity period has ended; Revoked: withdrawn by authority; Suspended: temporarily invalid.. Valid values are `pending|approved|active|expired|revoked|suspended`',
    `compliance_notes` STRING COMMENT 'Internal notes regarding compliance obligations, special conditions, or follow-up actions required for this certificate.',
    `content_descriptor_drugs` BOOLEAN COMMENT 'Flag indicating whether the certificate includes a content descriptor for drug or alcohol use or references.',
    `content_descriptor_fear` BOOLEAN COMMENT 'Flag indicating whether the certificate includes a content descriptor for fear, horror, or frightening content.',
    `content_descriptor_gambling` BOOLEAN COMMENT 'Flag indicating whether the certificate includes a content descriptor for gambling, simulated gambling, or loot box mechanics.',
    `content_descriptor_language` BOOLEAN COMMENT 'Flag indicating whether the certificate includes a content descriptor for strong language or profanity.',
    `content_descriptor_sexual` BOOLEAN COMMENT 'Flag indicating whether the certificate includes a content descriptor for sexual content, nudity, or sexual themes.',
    `content_descriptor_violence` BOOLEAN COMMENT 'Flag indicating whether the certificate includes a content descriptor for violence (e.g., blood, gore, intense violence).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this age rating certificate record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which the age rating certificate becomes valid and the game may be published under this rating in the applicable territory.',
    `expiry_date` DATE COMMENT 'The date on which the age rating certificate expires and is no longer valid. Nullable for certificates with indefinite validity or those requiring renewal tracking.',
    `interactive_element_location_sharing` BOOLEAN COMMENT 'Flag indicating whether the certificate notes that the game shares user location data.',
    `interactive_element_online` BOOLEAN COMMENT 'Flag indicating whether the certificate notes that the game includes online interaction with other players (e.g., Users Interact, Online Interactions Not Rated by the ESRB).',
    `interactive_element_purchases` BOOLEAN COMMENT 'Flag indicating whether the certificate notes that the game includes in-game purchases, microtransactions (MTX), or in-app purchases (IAP).',
    `interactive_element_ugc` BOOLEAN COMMENT 'Flag indicating whether the certificate notes that the game includes user-generated content (UGC) that may not be rated.',
    `issue_date` DATE COMMENT 'The date on which the rating authority officially issued the age rating certificate.',
    `loot_box_disclosure_required` BOOLEAN COMMENT 'Flag indicating whether the game is required to disclose loot box probabilities or mechanics under the rating authoritys or jurisdictional regulations.',
    `loot_box_probability_disclosed` BOOLEAN COMMENT 'Flag indicating whether loot box probabilities have been disclosed to the rating authority and are included in the certificate documentation.',
    `platform_code` STRING COMMENT 'The gaming platform for which this certificate was issued (e.g., PS5, XBOX_SERIES_X, SWITCH, PC, IOS, ANDROID). [ENUM-REF-CANDIDATE: PS5|PS4|XBOX_SERIES_X|XBOX_ONE|SWITCH|PC|IOS|ANDROID|STADIA|LUNA — promote to reference product]',
    `rating_category` STRING COMMENT 'The age rating category assigned by the authority (e.g., E, E10+, T, M, AO for ESRB; PEGI 3, PEGI 7, PEGI 12, PEGI 16, PEGI 18 for PEGI; equivalent categories for other authorities). [ENUM-REF-CANDIDATE: E|E10+|T|M|AO|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18|USK_0|USK_6|USK_12|USK_16|USK_18|CERO_A|CERO_B|CERO_C|CERO_D|CERO_Z|GRAC_ALL|GRAC_12|GRAC_15|GRAC_18|ACB_G|ACB_PG|ACB_M|ACB_MA15|ACB_R18|ACB_RC — promote to reference product]',
    `rating_summary` STRING COMMENT 'A textual summary provided by the rating authority describing the content and reasons for the assigned rating category.',
    `renewal_date` DATE COMMENT 'The date on which the certificate was renewed or re-certified, if applicable. Nullable for certificates that do not require renewal.',
    `revocation_date` DATE COMMENT 'The date on which the certificate was revoked by the rating authority, if applicable. Nullable for active certificates.',
    `revocation_reason` STRING COMMENT 'The reason provided by the rating authority for revoking the certificate (e.g., content violation, misrepresentation, regulatory non-compliance).',
    `submission_date` DATE COMMENT 'The date on which the game was submitted to the rating authority for certification review.',
    `submission_reference_number` STRING COMMENT 'The unique reference or tracking number assigned by the rating authority when the game was submitted for certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this age rating certificate record was last updated in the system.',
    CONSTRAINT pk_age_rating_cert PRIMARY KEY(`age_rating_cert_id`)
) COMMENT 'Master record for each official age rating certificate issued to a game title by a recognized rating authority (ESRB, PEGI, USK, CERO, GRAC, ACB, IARC). Captures rating authority, rating category (E, T, M, AO / PEGI 3–18), content descriptors (violence, language, gambling, in-game purchases), interactive elements flags, submission reference number, certificate issue date, certificate expiry date, applicable territory, and current certificate status. Distinct from title.content_rating (which is the title-level rating snapshot) — this is the compliance domains authoritative certificate lifecycle record including renewal and revocation tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` (
    `loot_box_disclosure_id` BIGINT COMMENT 'Unique identifier for the loot box disclosure record. Primary key for the loot box disclosure entity.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this loot box disclosure applies. Links to the game title master record in the Game Title domain.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Loot box disclosure requirements are jurisdiction-mandated. Replacing string-based jurisdiction_code with proper FK to jurisdiction master to link to regulatory framework, loot_box_regulatory_status, ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Loot box disclosures implement internal compliance policies governing probability disclosure requirements. This FK links each disclosure record to the internal policy framework that mandates it, enabl',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Loot box disclosure is mandated by regulatory obligations in various jurisdictions. Currently has regulation_name (STRING); should FK to regulatory_obligation for normalization.',
    `superseded_loot_box_disclosure_id` BIGINT COMMENT 'Self-referencing FK on loot_box_disclosure (superseded_loot_box_disclosure_id)',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Seasonal loot box pools (battle pass seasons) require distinct disclosure filings per season, as odds and item pools change each season. Regulators in Belgium, Netherlands, and UK require per-season d',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to title.title_sku. Business justification: Loot box disclosures apply to the specific SKU that enables loot box purchases. The SKU is the unit of sale that triggers disclosure requirements in regulated jurisdictions. loot_box_disclosure has ga',
    `age_rating` STRING COMMENT 'Age rating assigned to the game title by the jurisdictions rating authority (e.g., ESRB E10+, PEGI 12, CERO B). Relevant because some jurisdictions impose stricter loot box disclosure requirements for games accessible to minors.',
    `audit_trail_notes` STRING COMMENT 'Free-text field for compliance team notes, audit findings, regulatory correspondence references, or historical context related to this disclosure. Used for internal compliance documentation and audit preparation.',
    `compliance_status` STRING COMMENT 'Current compliance status of this loot box disclosure. Indicates whether the published disclosure meets the jurisdictions regulatory requirements and whether any discrepancies or remediation actions are in progress.. Valid values are `compliant|non-compliant|pending review|under remediation|exempt|not applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loot box disclosure record was first created in the system. Part of the audit trail for compliance tracking and regulatory reporting.',
    `data_retention_period_days` STRING COMMENT 'Number of days this disclosure record must be retained for regulatory compliance and audit purposes. Based on the jurisdictions data retention requirements and internal compliance policies.',
    `disclosed_item_probabilities` STRING COMMENT 'JSON or structured text representation of the item probabilities disclosed to players, including item names, rarity tiers, and percentage drop rates. This is the published, player-facing version of the odds.',
    `disclosure_effective_date` DATE COMMENT 'Date when this loot box disclosure became effective and enforceable under the jurisdictions regulation. Represents when the disclosure obligation started.',
    `disclosure_expiration_date` DATE COMMENT 'Date when this disclosure version expires or is superseded by a new disclosure. Null if the disclosure remains current and has no planned end date.',
    `disclosure_format` STRING COMMENT 'Required format for publishing loot box probabilities as mandated by the jurisdiction. Specifies where and how odds must be disclosed to players.. Valid values are `in-game odds display|website posting|app store label|in-app notice|regulatory filing|combined`',
    `disclosure_language` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) for the language in which the disclosure is published (e.g., en-US, zh-CN, nl-NL). Jurisdictions typically require disclosures in the local language.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `disclosure_url` STRING COMMENT 'Public URL where the loot box probabilities are published for player access, such as a dedicated disclosure page on the game website or app store listing. Required for website posting and app store label formats.. Valid values are `^https?://.*$`',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies between disclosed odds and actual gacha pool configuration, including which items or probabilities differ. Null if odds_match_flag is true. Used for remediation tracking and audit documentation.',
    `enforcement_action_description` STRING COMMENT 'Detailed description of any regulatory enforcement action, including the nature of the violation, penalties imposed, and remediation requirements. Null if enforcement_action_flag is false.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any regulatory enforcement action, warning, or penalty has been issued related to this loot box disclosure. True if enforcement action has occurred, false otherwise.',
    `in_game_display_location` STRING COMMENT 'Description of where the loot box odds are displayed within the game client (e.g., store menu, loot box preview screen, help section). Applicable when disclosure_format includes in-game odds display.',
    `last_updated_by` STRING COMMENT 'User ID or name of the individual who last modified this disclosure record. Used for accountability and audit trail purposes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the disclosure record was last modified, including updates to probabilities, URLs, or compliance status. Critical for audit trail and regulatory reporting.',
    `monetization_model` STRING COMMENT 'Monetization model of the game title for which this disclosure applies. Relevant because F2P (Free-to-Play) games with MTX (Microtransactions) face stricter loot box scrutiny in many jurisdictions.. Valid values are `F2P|premium|subscription|hybrid`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this disclosure to ensure continued accuracy and regulatory compliance. Part of the ongoing compliance audit schedule.',
    `odds_match_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the disclosed item probabilities match the actual gacha pool configuration in the monetization domain. False indicates a discrepancy requiring remediation to ensure truth in advertising and regulatory compliance.',
    `pity_system_disclosed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the disclosure includes information about any pity or guaranteed drop mechanics (e.g., guaranteed rare item after X attempts). Some jurisdictions require disclosure of pity systems as part of transparent odds communication.',
    `platform_code` STRING COMMENT 'Gaming platform or distribution channel for which this disclosure applies (e.g., PC, PS5, iOS, Android). Some jurisdictions require platform-specific disclosures due to different app store policies or certification requirements. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|IOS|ANDROID|WEB|MULTI — 10 candidates stripped; promote to reference product]',
    `player_complaint_count` STRING COMMENT 'Number of player complaints or support tickets received related to loot box odds transparency or perceived discrepancies for this game title and jurisdiction. Used to identify potential compliance risks and player trust issues.',
    `regulatory_contact_email` STRING COMMENT 'Email address of the regulatory authority contact or compliance officer responsible for this jurisdictions loot box disclosure requirements. Used for regulatory correspondence and audit inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_submission_reference` STRING COMMENT 'Reference number or identifier for the formal submission of this disclosure to the regulatory authority, if required by the jurisdiction. Used for tracking compliance filings and audit responses.',
    `remediation_due_date` DATE COMMENT 'Target date by which any identified discrepancies or compliance issues must be resolved. Null if no remediation is required. Used for compliance project management and regulatory deadline tracking.',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual, team, or role responsible for maintaining this disclosure and ensuring compliance (e.g., Compliance Manager, Legal Team, Live Ops Producer). Used for accountability and escalation.',
    `version_number` STRING COMMENT 'Version number of this disclosure record. Incremented each time the disclosure is updated, allowing tracking of disclosure history and changes over time for audit and regulatory purposes.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this disclosure record. Used for accountability and audit trail purposes.',
    CONSTRAINT pk_loot_box_disclosure PRIMARY KEY(`loot_box_disclosure_id`)
) COMMENT 'Master record governing the loot box and gacha probability disclosure requirements for each game title per jurisdiction. Captures game title reference, jurisdiction, disclosure regulation name (e.g., Belgium Gaming Commission, Netherlands KSA, China MoC Article 73), required disclosure format (in-game odds display, website posting, app store label), disclosed item probabilities, disclosure effective date, last updated date, disclosure URL, regulatory submission reference, and compliance status. Tracks whether the published odds match the gacha_pool configuration in the monetization domain and flags discrepancies for remediation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`consent_policy` (
    `consent_policy_id` BIGINT COMMENT 'Unique identifier for the consent policy configuration. Primary key. Inferred role: MASTER_AGREEMENT (versioned policy governing data collection/processing). This is the authoritative policy definition that player consent snapshots reference.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Consent policies are jurisdiction-specific instruments (GDPR consent differs from CCPA consent). The existing applicable_jurisdictions STRING is a multi-value denormalized field. A structured FK to th',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Consent_policy is a specialized type of policy and should reference the parent policy table for policy hierarchy. This enables modeling consent policies as a subtype of the general policy framework.',
    `primary_superseded_by_policy_consent_policy_id` BIGINT COMMENT 'Foreign key reference to the consent_policy_id that supersedes this policy version. Null for active policies. Enables tracking policy evolution and version chains.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Consent policies are created specifically to fulfill regulatory obligations (e.g., a GDPR consent policy fulfills the GDPR data processing consent obligation). This FK establishes the traceability cha',
    `allows_withdrawal` BOOLEAN COMMENT 'Boolean flag indicating whether players can withdraw consent under this policy (true) or consent is irrevocable (false). GDPR Article 7(3) mandates withdrawal must be as easy as giving consent.',
    `applicable_game_titles` STRING COMMENT 'Comma-separated list of game title identifiers or names to which this consent policy applies. Null if policy_scope is platform_wide or corporate_wide. Enables game-specific consent management.',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or regional codes (e.g., USA,CAN,MEX or EU,GBR,JPN) where this consent policy applies. Enables jurisdiction-specific consent management for GDPR, COPPA, CCPA compliance.',
    `applicable_platforms` STRING COMMENT 'Comma-separated list of platforms where this consent policy applies (e.g., PC,PlayStation,Xbox,Nintendo_Switch,iOS,Android,Web). Platform-specific consent requirements may vary (e.g., Apple App Store privacy labels).',
    `approval_status` STRING COMMENT 'Internal approval workflow status tracking legal and compliance review. Policies must be approved before activation to ensure regulatory compliance.. Valid values are `not_submitted|pending_legal_review|pending_compliance_review|approved|rejected|conditional_approval`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this consent policy version received final approval. Critical for audit trail and regulatory reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the legal/compliance officer who approved this consent policy version. Required for audit trail and accountability.',
    `automated_decision_making` BOOLEAN COMMENT 'Boolean flag indicating whether this policy covers automated decision-making or profiling (e.g., AI-driven content recommendations, dynamic pricing, matchmaking algorithms). GDPR Article 22 grants players rights regarding automated decisions.',
    `consent_categories` STRING COMMENT 'Comma-separated list of consent categories this policy governs (e.g., marketing,analytics,personalization,third_party_sharing,age_verification,cross_game_tracking). Defines the scope of data processing activities covered.',
    `contact_email` STRING COMMENT 'Email address for players to contact regarding consent, privacy inquiries, or data subject rights requests (e.g., privacy@company.com, dpo@company.com). Required per GDPR Article 13(1)(a).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent policy record was first created in the system. Audit trail for policy lifecycle tracking.',
    `cross_border_transfer_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this policy permits transferring player data outside the originating jurisdiction (e.g., EU to USA). GDPR Chapter V requires adequate safeguards for international transfers.',
    `data_retention_period_days` STRING COMMENT 'Maximum number of days player data collected under this consent policy will be retained. After this period, data must be anonymized or deleted per GDPR Article 5(1)(e) storage limitation principle. Null for indefinite retention (must be justified).',
    `data_subject_rights_summary` STRING COMMENT 'Summary of player rights under this consent policy (e.g., Right to access, rectification, erasure, restriction, portability, objection per GDPR Articles 15-21). Must be communicated clearly per GDPR Article 12.',
    `dpo_name` STRING COMMENT 'Name of the Data Protection Officer responsible for overseeing compliance with this consent policy. GDPR Article 37 mandates DPO appointment for certain organizations.',
    `effective_date` DATE COMMENT 'Date when this consent policy version becomes binding and enforceable. Players consenting on or after this date are bound to this policy version.',
    `expiry_date` DATE COMMENT 'Date when this consent policy version ceases to be active. Nullable for open-ended policies. After expiry, policy is typically superseded by a newer version.',
    `legal_basis` STRING COMMENT 'Primary legal basis under GDPR Article 6 justifying data processing under this policy. Consent requires explicit opt-in, legitimate_interest balances business needs with player rights, contract supports service delivery, legal_obligation for regulatory compliance.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `loot_box_disclosure_required` BOOLEAN COMMENT 'Boolean flag indicating whether this policy mandates disclosure of loot box drop rates and probabilities. Required in many jurisdictions (China, Japan, EU, USA states) for consumer protection and gambling regulation compliance.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age (in years) required to provide valid consent under this policy. Varies by jurisdiction: COPPA requires 13+ in USA, GDPR allows member states to set 13-16. Null if no age restriction applies.',
    `modified_by` STRING COMMENT 'Identifier or name of the user/system that last modified this consent policy record. Tracks responsibility for policy changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consent policy record was last modified. Tracks policy updates and version changes for audit and compliance purposes.',
    `notes` STRING COMMENT 'Free-text field for internal notes, rationale for policy changes, legal review comments, or implementation guidance. Not displayed to players.',
    `parental_consent_required` BOOLEAN COMMENT 'Boolean flag indicating whether parental or guardian consent is required for players below the minimum age threshold. COPPA and GDPR Article 8 mandate parental consent for children.',
    `policy_document_url` STRING COMMENT 'Fully qualified URL to the published consent policy document (privacy policy, terms of service, consent notice) that players review before consenting. Must be accessible and archived for audit purposes.',
    `policy_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the policy document content at policy_document_url. Ensures document integrity and detects unauthorized modifications for audit and compliance verification.',
    `policy_language` STRING COMMENT 'ISO 639-1 two-letter language code (e.g., en, fr, de, ja) indicating the language of the policy document. Supports multi-language consent compliance.',
    `policy_name` STRING COMMENT 'Human-readable name of the consent policy configuration (e.g., Global Player Data Consent 2024, EU GDPR Marketing Consent). Business identifier for the policy.',
    `policy_scope` STRING COMMENT 'Scope of applicability for this consent policy. Single_game policies apply to one title, game_franchise covers a series, all_games spans the publishers portfolio, platform_wide for gaming platforms, corporate_wide for entire organization including non-gaming services.. Valid values are `single_game|game_franchise|all_games|platform_wide|corporate_wide`',
    `policy_status` STRING COMMENT 'Current lifecycle status of the consent policy. Draft policies are under development, pending_approval awaiting legal review, active policies are in force, superseded policies replaced by newer versions, retired policies no longer applicable, withdrawn policies revoked.. Valid values are `draft|pending_approval|active|superseded|retired|withdrawn`',
    `policy_version` STRING COMMENT 'Version identifier for this consent policy (e.g., 1.0, 2.3, v2024.1). Enables tracking of policy evolution and player consent to specific versions.',
    `profiling_purposes` STRING COMMENT 'Comma-separated list of purposes for which player profiling is conducted under this policy (e.g., personalized_content,targeted_advertising,churn_prediction,fraud_detection). Must be disclosed per GDPR Article 13(2)(f).',
    `requires_explicit_consent` BOOLEAN COMMENT 'Boolean flag indicating whether this policy requires explicit opt-in consent (true) or allows implied consent (false). GDPR and COPPA typically require explicit consent for sensitive data processing.',
    `supervisory_authority` STRING COMMENT 'Name of the regulatory supervisory authority with jurisdiction over this consent policy (e.g., Irish Data Protection Commission, California Attorney General, FTC). Players have the right to lodge complaints per GDPR Article 77.',
    `third_party_categories` STRING COMMENT 'Comma-separated list of third-party categories with whom data may be shared under this policy (e.g., advertising_networks,analytics_providers,payment_processors,cloud_infrastructure). Required for GDPR Article 13 transparency.',
    `third_party_sharing_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this policy permits sharing player data with third parties (advertisers, analytics providers, partners). Must be disclosed per GDPR Article 13(1)(e).',
    `transfer_mechanism` STRING COMMENT 'Legal mechanism enabling cross-border data transfers under GDPR Chapter V. Standard contractual clauses (SCCs) are most common, adequacy_decision for approved countries (e.g., EU-US Data Privacy Framework), binding_corporate_rules for intra-group transfers.. Valid values are `standard_contractual_clauses|binding_corporate_rules|adequacy_decision|consent|not_applicable`',
    `withdrawal_mechanism` STRING COMMENT 'Description of how players can withdraw consent (e.g., In-game settings menu, Email to privacy@company.com, Account portal). Required for GDPR Article 7(3) compliance.',
    `created_by` STRING COMMENT 'Identifier or name of the user/system that created this consent policy record. Required for audit trail and accountability.',
    CONSTRAINT pk_consent_policy PRIMARY KEY(`consent_policy_id`)
) COMMENT 'Master record defining the versioned consent policy configurations governing player data collection and processing across all game titles and platforms. Captures policy name, policy version, effective date, expiry date, applicable jurisdiction(s), consent categories covered (marketing, analytics, personalization, third-party sharing, age verification), legal basis (consent, legitimate interest, contract, legal obligation), policy document URL, and approval status. Distinct from player.consent_snapshot (which records individual player consent states) — this is the authoritative policy definition that consent snapshots reference.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`compliance_incident` (
    `compliance_incident_id` BIGINT COMMENT 'Unique identifier for the compliance incident record. Primary key for the compliance incident entity.',
    `player_account_id` BIGINT COMMENT 'Foreign key linking to player.player_account. Business justification: Many compliance incidents involve specific player accounts (unauthorized account access, data breach affecting player, consent violation). Essential for player notification obligations (GDPR Article 3',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Compliance incidents can relate to age rating certification violations (e.g., distributing content in a jurisdiction without proper age rating certification, or content exceeding the certified rating)',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title associated with the compliance incident. Links the incident to the specific game product where the violation occurred.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Incidents (data breach, undisclosed loot box odds) may violate agreement terms (data protection clauses, transparency requirements). Real process: incident investigation checks contract compliance; le',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Compliance incidents occur within a primary jurisdiction (the regulators territory where the breach is reportable). The existing affected_jurisdictions STRING field is a multi-value denormalized list',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Compliance incidents often involve specific licensed IP (IP misuse, unauthorized content, brand guideline violations). Direct link needed for IP-specific incident tracking and licensor notification be',
    `loot_box_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.loot_box_disclosure. Business justification: Compliance incidents can be triggered by loot box disclosure violations (e.g., incorrect probability disclosure, missing disclosure). Linking incidents directly to the specific loot box disclosure rec',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Compliance incidents represent violations of specific internal policies (e.g., a data breach incident violates the data protection policy). Linking incidents to the violated policy enables policy-leve',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance incident represents breach or violation of regulatory obligations. Should FK to the specific regulatory_obligation that was violated to enable tracking which obligations are most frequently',
    `root_cause_compliance_incident_id` BIGINT COMMENT 'Self-referencing FK on compliance_incident (root_cause_compliance_incident_id)',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: Compliance incidents can arise from spend limit control breaches (e.g., a player exceeding mandatory spending limits without proper enforcement). Linking incidents to the specific spend limit control ',
    `storefront_id` BIGINT COMMENT 'Identifier of the gaming platform where the compliance incident occurred. Links to console, PC, mobile, or web platform master data.',
    `title_release_id` BIGINT COMMENT 'Foreign key linking to title.title_release. Business justification: Compliance incidents can be triggered by a specific release event — e.g., a release that went live in a region without valid age rating cert, or a release that violated an embargo. Linking incident to',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to title.title_sku. Business justification: Compliance incidents are often triggered by a specific SKU (e.g., a loot box SKU sold in a banned jurisdiction, an age-gated SKU sold without verification). SKU-level incident attribution is required ',
    `actual_financial_impact` DECIMAL(18,2) COMMENT 'Actual realized financial cost of the compliance incident after resolution, including confirmed regulatory fines, remediation expenses, legal settlements, and quantified business losses. Expressed in USD.',
    `affected_jurisdictions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing territories where affected players reside. Determines which regulatory authorities must be notified and which compliance frameworks apply.',
    `affected_player_count` BIGINT COMMENT 'Total number of players whose data or rights were impacted by the compliance incident. Critical metric for determining regulatory notification obligations and assessing incident severity.',
    `audit_trail` STRING COMMENT 'Chronological log of all actions taken during the incident lifecycle including investigation steps, communications, decisions, and status changes. Provides complete audit trail for regulatory review.',
    `containment_actions_taken` STRING COMMENT 'Description of immediate actions taken to contain the compliance incident and prevent further harm. Includes technical remediation, player notifications, service suspensions, or data access restrictions implemented as first response.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance incident record was first created in the system. Represents when the incident was formally logged for tracking and investigation.',
    `data_categories_affected` STRING COMMENT 'Comma-separated list of personal data categories impacted by the incident such as player names, email addresses, payment information, gameplay data, or chat logs. Used for assessing breach severity and notification requirements.',
    `discovery_channel` STRING COMMENT 'Source or method through which the compliance incident was detected. Identifies whether the incident was found proactively through internal controls or reactively through external notification.. Valid values are `internal_audit|regulator_notification|player_complaint|automated_monitoring|third_party_report|whistleblower`',
    `discovery_date` DATE COMMENT 'Date when the compliance incident was first identified or became known to the organization. Critical for calculating regulatory notification deadlines such as GDPR 72-hour breach notification requirement.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the compliance incident was first identified. Used for accurate timeline reconstruction and regulatory reporting where hour-level precision is required.',
    `escalation_level` STRING COMMENT 'Organizational level to which the compliance incident has been escalated. Critical and high-severity incidents typically require executive or board-level awareness and oversight.. Valid values are `team|manager|director|executive|board`',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated total financial cost of the compliance incident including potential regulatory fines, remediation costs, legal fees, and business disruption. Expressed in USD for consistent reporting.',
    `external_counsel_engaged_flag` BOOLEAN COMMENT 'Indicates whether external legal counsel has been retained to advise on the compliance incident. True for incidents with significant legal exposure or complex regulatory implications.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the compliance incident, including what occurred, how it was discovered, and the circumstances surrounding the breach or violation. Used for internal investigation and regulatory reporting.',
    `incident_number` STRING COMMENT 'Externally-visible unique business identifier for the compliance incident, used for tracking and reporting to regulators and internal stakeholders.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the compliance incident. Tracks progression from discovery through investigation, containment, resolution, and closure.. Valid values are `open|investigating|contained|resolved|closed`',
    `incident_type` STRING COMMENT 'Classification of the compliance incident by regulatory domain. Identifies the nature of the breach or violation across all regulatory frameworks applicable to gaming operations.. Valid values are `data_breach|coppa_violation|loot_box_disclosure|age_gate_bypass|unauthorized_data_transfer|sanctions_violation`',
    `insurance_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether a claim has been filed with cyber liability or errors and omissions insurance for the compliance incident. True when financial impact exceeds deductible thresholds.',
    `insurance_claim_number` STRING COMMENT 'Reference number assigned by the insurance carrier for the compliance incident claim. Used for tracking insurance recovery and coordinating with carrier investigation.',
    `lessons_learned` STRING COMMENT 'Summary of key insights and organizational learnings from the compliance incident. Captures what went well, what could be improved, and recommendations for preventing similar incidents in the future.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance incident record was last updated. Tracks the most recent change to any field in the incident record for audit and change management purposes.',
    `notification_deadline` TIMESTAMP COMMENT 'Date and time by which regulatory notification must be completed. Calculated based on discovery timestamp and applicable regulatory framework requirements such as GDPR 72-hour breach notification rule.',
    `notification_sent_date` DATE COMMENT 'Date when formal notification was sent to the applicable regulatory authority. Used to verify compliance with mandatory notification deadlines and document regulatory communication.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Precise date and time when regulatory notification was transmitted. Provides audit trail for demonstrating timely compliance with notification obligations.',
    `player_notification_required_flag` BOOLEAN COMMENT 'Indicates whether affected players must be directly notified of the compliance incident. True when the incident poses high risk to player rights and freedoms under GDPR or when COPPA parental notification is required.',
    `player_notification_sent_date` DATE COMMENT 'Date when notification communications were sent to affected players. Documents compliance with player notification obligations under data protection regulations.',
    `regulator_reference_number` STRING COMMENT 'Case or reference number assigned by the regulatory authority upon receipt of the incident notification. Used for tracking regulatory correspondence and investigation status.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the compliance incident meets the threshold for mandatory notification to regulatory authorities. True for incidents requiring GDPR breach notification, COPPA violation reporting, or other jurisdictional reporting obligations.',
    `remediation_completion_date` DATE COMMENT 'Date when all remediation actions were completed and verified. Marks the point at which corrective measures have been fully implemented and the incident is considered resolved from a technical perspective.',
    `remediation_plan` STRING COMMENT 'Detailed plan for addressing the compliance incident and preventing recurrence. Includes corrective actions, process improvements, system enhancements, and training initiatives to be implemented.',
    `resolution_date` DATE COMMENT 'Date when the compliance incident was formally resolved and closed. Indicates that all investigation, remediation, notification, and regulatory obligations have been satisfied.',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying cause of the compliance incident. Identifies process failures, system vulnerabilities, or human errors that led to the breach or violation.',
    `severity_rating` STRING COMMENT 'Business impact severity classification of the compliance incident. Critical incidents require immediate executive notification and regulatory reporting; low severity incidents may be handled through standard remediation processes.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_compliance_incident PRIMARY KEY(`compliance_incident_id`)
) COMMENT 'Transactional record for each compliance breach, violation, or near-miss event identified across all regulatory domains. Captures incident type (data breach, COPPA violation, undisclosed loot box odds, age gate bypass, unauthorized data transfer, sanctions violation), discovery date, discovery channel (internal audit, regulator notification, player complaint, automated monitoring), affected player count, affected jurisdictions, severity rating, incident description, immediate containment actions taken, regulatory notification obligation flag, notification deadline (GDPR 72-hour breach notification), notification sent date, and incident resolution status.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`remediation_action` (
    `remediation_action_id` BIGINT COMMENT 'Unique identifier for the remediation action record. Primary key for the remediation action entity.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title affected by the compliance issue and remediation action. Null if action is enterprise-wide or not game-specific.',
    `player_account_id` BIGINT COMMENT 'Foreign key linking to player.player_account. Business justification: Some remediation actions target specific player accounts (restore erroneously deleted data, correct consent record, reinstate wrongly banned account). Essential for player rights restoration, incident',
    `compliance_incident_id` BIGINT COMMENT 'Reference to the compliance incident that triggered this remediation action. Links to the source incident requiring corrective measures.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Remediation actions may specifically address consent policy violations (e.g., remediating improper data collection by updating consent policies). This FK links remediation actions to the consent polic',
    `escalated_remediation_action_id` BIGINT COMMENT 'Self-referencing FK on remediation_action (escalated_remediation_action_id)',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Remediation may require contract amendment or licensee notification (update loot box disclosure clause, notify licensor of breach). Real process: corrective action tied to agreement terms.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Remediation actions must comply with jurisdiction-specific regulatory requirements. Replacing string-based affected_jurisdiction field with proper FK to jurisdiction master to link to regulatory frame',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Remediation actions often target IP-specific violations (remove infringing content, update IP usage, modify licensed assets). Direct link needed for IP-specific remediation tracking and licensor coord',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Remediation action may be driven by internal policy violations (in addition to incidents/findings/directives which are already FKd). Should FK to policy table when remediation is policy-driven. Note:',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Remediation actions address violations of specific regulatory obligations. The existing regulatory_framework STRING field is a denormalized text description; a structured FK to regulatory_obligation e',
    `action_description` STRING COMMENT 'Detailed description of the remediation action plan, including specific steps, scope, and expected outcomes. Provides full context for execution.',
    `action_number` STRING COMMENT 'Business-facing unique identifier for the remediation action, used for tracking and reporting. Format: REM-NNNNNN.. Valid values are `^REM-[0-9]{6,10}$`',
    `action_title` STRING COMMENT 'Short descriptive title summarizing the remediation action. Used for quick identification in dashboards and reports.',
    `actual_completion_date` DATE COMMENT 'Date when the remediation action was actually completed and closed. Null if action is still open or in progress.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to complete the remediation action. Null if action is not yet completed or cost not yet finalized.',
    `assigned_department` STRING COMMENT 'Business department or functional area responsible for executing the remediation action (e.g., Legal, IT Security, Player Support, Game Operations).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated and actual costs (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the remediation action record was first created in the system. Represents the moment the action was formally logged.',
    `escalation_date` DATE COMMENT 'Date when the remediation action was escalated to senior leadership or board. Null if no escalation occurred.',
    `escalation_required` BOOLEAN COMMENT 'Boolean flag indicating whether the remediation action requires executive or board-level escalation due to severity, cost, or regulatory impact.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the remediation action, including labor, technology, legal, and operational expenses. Used for budgeting and risk assessment.',
    `evidence_document_reference` STRING COMMENT 'Reference identifier or URI to the supporting documentation that evidences completion of the remediation action (e.g., policy document version, system change ticket, training completion report, payment receipt).',
    `external_consultant_engaged` BOOLEAN COMMENT 'Boolean flag indicating whether external legal, compliance, or technical consultants were engaged to support the remediation action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the remediation action record was last updated. Tracks the most recent change to any field in the record.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the remediation action. Used for collaboration and knowledge capture.',
    `priority` STRING COMMENT 'Business priority level for completing the remediation action, reflecting urgency and risk exposure. Critical actions require immediate attention, high within days, medium within weeks, low within months.. Valid values are `critical|high|medium|low`',
    `recurrence_prevention_plan` STRING COMMENT 'Description of measures implemented to prevent recurrence of the compliance issue, including process changes, controls, and monitoring enhancements.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard governing this remediation action: GDPR (General Data Protection Regulation), COPPA (Childrens Online Privacy Protection Act), ESRB (Entertainment Software Rating Board), PEGI (Pan European Game Information), CERO (Computer Entertainment Rating Organization), FTC (Federal Trade Commission), PCI_DSS (Payment Card Industry Data Security Standard), CCPA (California Consumer Privacy Act), or other. [ENUM-REF-CANDIDATE: GDPR|COPPA|ESRB|PEGI|CERO|FTC|PCI_DSS|CCPA|other — 9 candidates stripped; promote to reference product]',
    `remediation_action_status` STRING COMMENT 'Current lifecycle status of the remediation action: open (not yet started), in_progress (work underway), completed (action finished but not yet verified), verified (completion confirmed by compliance team), cancelled (action no longer required), overdue (past target completion date).. Valid values are `open|in_progress|completed|verified|cancelled|overdue`',
    `remediation_type` STRING COMMENT 'Classification of the remediation action by the nature of the corrective measure: process change (operational procedure update), technical control (system or security enhancement), policy update (documentation or governance change), player notification (communication to affected users), regulatory payment (fine or penalty settlement), or training (staff education program).. Valid values are `process_change|technical_control|policy_update|player_notification|regulatory_payment|training`',
    `risk_level_after` STRING COMMENT 'Assessed risk level of the compliance issue after remediation action was completed and verified. Null if action not yet verified.. Valid values are `critical|high|medium|low|mitigated`',
    `risk_level_before` STRING COMMENT 'Assessed risk level of the compliance issue before remediation action was implemented. Used to measure risk reduction effectiveness.. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'Planned or mandated date by which the remediation action must be completed. May be set by regulatory authority or internal risk assessment.',
    `verification_date` DATE COMMENT 'Date when the remediation action completion was verified and confirmed by the compliance team or auditor. Null if not yet verified.',
    `verification_method` STRING COMMENT 'Method used to verify and confirm completion of the remediation action: document_review (evidence documentation), system_audit (technical validation), process_observation (operational walkthrough), stakeholder_confirmation (business sign-off), regulatory_inspection (external authority review), testing (functional or security testing).. Valid values are `document_review|system_audit|process_observation|stakeholder_confirmation|regulatory_inspection|testing`',
    CONSTRAINT pk_remediation_action PRIMARY KEY(`remediation_action_id`)
) COMMENT 'Master record for each formal remediation action plan created in response to a compliance incident, audit finding, or regulatory directive. Captures the source reference (incident or finding), action title, action description, remediation type (process change, technical control, policy update, player notification, regulatory payment), assigned owner, target completion date, actual completion date, remediation status (open, in-progress, completed, verified), verification method, and evidence document reference. Provides the compliance teams authoritative action tracking register.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`processing_activity` (
    `processing_activity_id` BIGINT COMMENT 'Unique identifier for the data processing activity record in the Records of Processing Activities (RoPA) register maintained under GDPR Article 30.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Processing activity has legal_basis (STRING) which may be consent. Should FK to the consent_policy that governs the processing when legal basis is consent. Note: legal_basis is kept as it may have o',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: GDPR Article 30 controller mapping: processing activities must be attributed to the data controller (game studio) responsible for them. processing_activity has business_unit as a plain string — this i',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: GDPR Article 30 records of processing activities must be scoped to specific games (each title processes different data categories, has different third-party integrations, different retention periods).',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Data processing activities are regulated by jurisdiction-specific privacy laws (GDPR, CCPA, COPPA, etc.). Replacing string-based regulatory_jurisdiction field with proper FK to jurisdiction master to ',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Processing activities describe data flows from licensed IP (analytics SDK, ad network, cloud save middleware). Real process: GDPR Article 30 record of processing; DPO maps activities to IP.',
    `parent_processing_activity_id` BIGINT COMMENT 'Self-referencing FK on processing_activity (parent_processing_activity_id)',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Processing activities are governed by internal data protection policies. This FK links each processing activity to the internal policy framework that authorizes and governs it, enabling policy-level d',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: GDPR Article 30 processing activities are documented specifically to fulfill regulatory obligations (GDPR, CCPA, etc.). This FK links each processing activity record to the regulatory obligation that ',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Each game season introduces new data processing activities (new analytics pipelines, battle pass tracking, seasonal player profiling). GDPR Record of Processing Activities (RoPA) must capture season-s',
    `activity_code` STRING COMMENT 'Standardized code identifier for the processing activity following the format PA-[DOMAIN]-[NUMBER] (e.g., PA-PLR-0001 for player registration).. Valid values are `^PA-[A-Z]{3}-[0-9]{4}$`',
    `activity_name` STRING COMMENT 'The business-friendly name of the data processing activity (e.g., Player Registration, In-Game Analytics Collection, Marketing Campaign Management).',
    `activity_owner` STRING COMMENT 'Name or role of the individual accountable for ensuring compliance of this processing activity with data protection regulations.',
    `automated_decision_logic` STRING COMMENT 'If automated decision-making is used, this field provides meaningful information about the logic involved and the significance and envisaged consequences for the data subject.',
    `automated_decision_making_flag` BOOLEAN COMMENT 'Indicates whether the processing activity involves automated decision-making, including profiling, that produces legal or similarly significant effects.',
    `ccpa_applicable_flag` BOOLEAN COMMENT 'Indicates whether this processing activity is subject to CCPA requirements due to processing of California resident data.',
    `children_data_flag` BOOLEAN COMMENT 'Indicates whether the processing activity involves personal data of children, triggering additional protections under GDPR Article 8 and COPPA compliance requirements.',
    `controller_processor_role` STRING COMMENT 'Indicates whether Gaming acts as a data controller, processor, or joint controller for this processing activity under GDPR definitions.. Valid values are `controller|processor|joint_controller`',
    `coppa_applicable_flag` BOOLEAN COMMENT 'Indicates whether this processing activity is subject to COPPA requirements due to processing of data from children under 13 years of age.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this processing activity record was first created in the Records of Processing Activities register.',
    `data_categories` STRING COMMENT 'Comma-separated list of categories of personal data processed (e.g., identification data, contact details, gameplay behavior, payment information, device identifiers, location data).',
    `data_protection_officer_contact` STRING COMMENT 'Contact information for the Data Protection Officer responsible for overseeing this processing activity and handling data subject requests.',
    `data_source` STRING COMMENT 'Description of where personal data originates (e.g., directly from data subject, from third-party data brokers, from public sources, from platform SDKs).',
    `data_subject_categories` STRING COMMENT 'Comma-separated list of categories of data subjects whose data is processed (e.g., players, employees, job applicants, business contacts, minors under 13, minors 13-16).',
    `data_subject_rights_procedure` STRING COMMENT 'Description of the procedure by which data subjects can exercise their rights (access, rectification, erasure, restriction, portability, objection) in relation to this processing activity.',
    `dpia_completion_date` DATE COMMENT 'The date on which the DPIA for this processing activity was completed and approved by the Data Protection Officer.',
    `dpia_required_flag` BOOLEAN COMMENT 'Indicates whether a Data Protection Impact Assessment is required for this processing activity due to high risk to data subject rights and freedoms.',
    `international_transfer_flag` BOOLEAN COMMENT 'Indicates whether personal data is transferred to third countries or international organizations outside the European Economic Area (EEA).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this processing activity record was last modified, capturing any updates to processing purposes, legal basis, recipients, or other material changes.',
    `last_review_date` DATE COMMENT 'The date on which this processing activity record was last reviewed and validated for accuracy and compliance by the Data Protection Officer or designated compliance team.',
    `legal_basis` STRING COMMENT 'The lawful basis under GDPR Article 6 that justifies the processing activity (consent, contract performance, legal obligation, vital interests, public task, or legitimate interests).. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `legitimate_interest_description` STRING COMMENT 'If legal basis is legitimate interests, this field documents the specific legitimate interest pursued and the balancing test performed against data subject rights.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this processing activity to ensure ongoing compliance with data protection regulations.',
    `notes` STRING COMMENT 'Free-text field for additional context, compliance notes, audit findings, or special considerations related to this processing activity.',
    `organizational_security_measures` STRING COMMENT 'Description of organizational security measures implemented (e.g., staff training, access authorization procedures, incident response plan, data protection impact assessments).',
    `privacy_notice_url` STRING COMMENT 'URL link to the public-facing privacy notice or policy that discloses this processing activity to data subjects.',
    `processing_activity_status` STRING COMMENT 'Current operational status of the processing activity indicating whether it is actively processing data, temporarily suspended, permanently discontinued, or under compliance review.. Valid values are `active|suspended|discontinued|under_review`',
    `processing_purpose` STRING COMMENT 'Detailed description of the specific, explicit, and legitimate purpose for which personal data is processed (e.g., to provide game services, to process payments, to deliver targeted advertising).',
    `recipient_categories` STRING COMMENT 'Comma-separated list of categories of recipients to whom personal data may be disclosed (e.g., cloud service providers, payment processors, analytics vendors, advertising networks, platform holders, law enforcement).',
    `retention_period` STRING COMMENT 'The time period for which personal data will be retained, or the criteria used to determine that period (e.g., 3 years after account closure, duration of contract plus 6 years for legal claims).',
    `retention_period_days` STRING COMMENT 'Numeric representation of the retention period in days for automated retention policy enforcement and data lifecycle management.',
    `scc_version` STRING COMMENT 'If Standard Contractual Clauses are used, this field documents the version and date of the SCCs in place (e.g., EU Commission SCCs 2021/914).',
    `special_category_data_flag` BOOLEAN COMMENT 'Indicates whether the processing activity involves special categories of personal data under GDPR Article 9 (e.g., health data, biometric data, data revealing racial or ethnic origin).',
    `special_category_legal_basis` STRING COMMENT 'If special category data is processed, this field documents the specific legal basis under GDPR Article 9(2) that permits such processing.',
    `technical_security_measures` STRING COMMENT 'Description of technical security measures implemented to protect personal data (e.g., encryption at rest and in transit, access controls, pseudonymization, secure key management).',
    `transfer_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes to which personal data is transferred (e.g., USA, JPN, SGP).',
    `transfer_safeguard_mechanism` STRING COMMENT 'The legal mechanism used to safeguard international data transfers (e.g., EU Commission adequacy decision, Standard Contractual Clauses, Binding Corporate Rules).. Valid values are `adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|code_of_conduct|not_applicable`',
    CONSTRAINT pk_processing_activity PRIMARY KEY(`processing_activity_id`)
) COMMENT 'Master record for each data processing activity documented in Gamings GDPR Article 30 Records of Processing Activities (RoPA). Captures processing activity name, controller/processor role, purpose of processing, legal basis, data categories processed, data subject categories, recipient categories (third parties, processors, international transfers), retention period, international transfer safeguards (SCCs, adequacy decision), and last review date. Serves as the authoritative RoPA maintained by the Data Protection Officer and referenced during regulatory inspections.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`spend_limit_control` (
    `spend_limit_control_id` BIGINT COMMENT 'Unique identifier for the spend limit control record.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Spend limit controls often require explicit player consent and acknowledgment (player_acknowledgment_required flag exists on spend_limit_control). The governing consent policy defines the legal basis ',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Spend limits can be title-specific (per-game spending caps for minors, title-specific regulatory requirements). Essential for title-level monetization controls, youth protection compliance, and regula',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Spending limit controls are mandated by jurisdiction-specific gambling and consumer protection regulations. Replacing string-based jurisdiction_code with proper FK to jurisdiction master to link to re',
    `player_account_id` BIGINT COMMENT 'Reference to the player account subject to this spending limit control.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Spend limit controls are mandated by internal compliance policies (e.g., responsible gambling policy, player protection policy). This FK links each spend limit control to the internal policy that mand',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Spend limit control is mandated by regulatory obligations (e.g., gambling regulations requiring spending limits). Currently has regulatory_authority and regulation_reference as STRING fields; should F',
    `superseded_spend_limit_control_id` BIGINT COMMENT 'Self-referencing FK on spend_limit_control (superseded_spend_limit_control_id)',
    `applicable_game_titles` STRING COMMENT 'Comma-separated list of game title identifiers or codes to which this spending limit applies. Null or ALL indicates the limit applies across all titles.',
    `applicable_mtx_categories` STRING COMMENT 'Comma-separated list of microtransaction or in-app purchase (IAP) categories subject to this limit (e.g., loot_boxes, virtual_currency, cosmetics, battle_pass). Null or ALL indicates all MTX types are covered.',
    `applicable_platforms` STRING COMMENT 'Comma-separated list of platform codes (e.g., iOS, Android, PC, Console) to which this spending limit applies. Null or ALL indicates cross-platform enforcement.',
    `audit_trail_url` STRING COMMENT 'URL or reference to the detailed audit trail or documentation supporting this spending limit control for regulatory compliance and audit purposes.',
    `breach_count` STRING COMMENT 'Number of times the player has attempted to exceed this spending limit, used for compliance monitoring and escalation.',
    `control_reference_number` STRING COMMENT 'External reference number or code assigned to this spending limit control for tracking and audit purposes.',
    `control_source` STRING COMMENT 'Origin or authority that established this spending limit: regulatory mandate, player self-set preference, parental control, platform policy, court order, or third-party exclusion program (e.g., GamStop).. Valid values are `regulatory_mandate|player_self_set|parental_control|platform_policy|court_order|third_party_exclusion`',
    `control_type` STRING COMMENT 'Classification of the spending limit control mechanism: mandatory regulatory cap imposed by law, voluntary self-exclusion set by player, parental spending limit for minor accounts, platform-imposed cap, temporary cooling-off period, or permanent exclusion.. Valid values are `mandatory_regulatory_cap|voluntary_self_exclusion|parental_spending_limit|platform_imposed_cap|temporary_cooling_off|permanent_exclusion`',
    `cooling_off_period_days` STRING COMMENT 'Number of days the player must wait before a self-imposed spending limit can be increased or removed, as required by responsible gaming regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spending limit control record was first created in the system.',
    `current_period_spend` DECIMAL(18,2) COMMENT 'Total amount spent by the player within the current limit period, used to track proximity to the limit threshold.',
    `effective_date` DATE COMMENT 'Date when the spending limit control becomes active and enforceable.',
    `enforcement_status` STRING COMMENT 'Current enforcement state of the spending limit control: active and enforced, suspended temporarily, expired, revoked, pending activation, or in cooling-off period.. Valid values are `active|suspended|expired|revoked|pending_activation|cooling_off`',
    `expiry_date` DATE COMMENT 'Date when the spending limit control expires or is scheduled to end. Null for permanent or indefinite controls.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this spending limit control record is currently active and in use.',
    `last_breach_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent attempt to breach the spending limit.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum spending amount allowed within the specified limit period, expressed in the local currency of the jurisdiction.',
    `limit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the limit amount (e.g., EUR, GBP, USD).. Valid values are `^[A-Z]{3}$`',
    `limit_period` STRING COMMENT 'Time period over which the spending limit is enforced: daily, weekly, monthly, quarterly, annual, lifetime, or per-session. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annual|lifetime|per_session — 7 candidates stripped; promote to reference product]',
    `modification_effective_date` DATE COMMENT 'Date when a requested modification to the spending limit will take effect, accounting for any mandatory cooling-off period.',
    `modification_request_date` DATE COMMENT 'Date when the player requested a modification to the spending limit (increase, decrease, or removal).',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the spending limit control, including special circumstances, player requests, or compliance considerations.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether a notification has been sent to the player informing them of the spending limit control.',
    `notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the player was notified about the spending limit control.',
    `override_authorized_by` STRING COMMENT 'Name or identifier of the authorized personnel who approved any override or exception to the spending limit control.',
    `override_reason` STRING COMMENT 'Explanation or justification for any override or exception granted to the spending limit control.',
    `override_timestamp` TIMESTAMP COMMENT 'Timestamp when an override or exception to the spending limit control was authorized and applied.',
    `period_end_date` DATE COMMENT 'End date of the current limit period, after which the spend counter resets for recurring periods.',
    `period_start_date` DATE COMMENT 'Start date of the current limit period for tracking spend accumulation.',
    `player_acknowledgment_required` BOOLEAN COMMENT 'Indicates whether the player is required to explicitly acknowledge and accept the spending limit control.',
    `player_acknowledgment_timestamp` TIMESTAMP COMMENT 'Timestamp when the player acknowledged the spending limit control.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this spending limit control record was last modified or updated.',
    CONSTRAINT pk_spend_limit_control PRIMARY KEY(`spend_limit_control_id`)
) COMMENT 'Master record defining mandatory and voluntary player spending limit controls required by gambling and consumer protection regulations across jurisdictions — covering Belgium, Netherlands, UK GamStop, and emerging loot box spend cap regulations. Captures player account reference, jurisdiction, control type (mandatory regulatory cap, voluntary self-exclusion, parental spending limit), limit period (daily, weekly, monthly), limit amount in local currency, effective date, expiry date, control source (regulatory mandate, player self-set, parental control), and current enforcement status. Distinct from parental_control (player.parental_control) which covers broader parental settings.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Internal compliance policies are often jurisdiction-specific (e.g., a GDPR data retention policy applies to EU jurisdictions, a COPPA policy to US). Linking policy to jurisdiction enables jurisdiction',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Internal compliance policies are written to implement specific regulatory obligations. This FK establishes the traceability from internal policy to the external regulatory mandate it fulfills — essent',
    `superseded_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (superseded_policy_id)',
    `applicable_business_units` STRING COMMENT 'Comma-separated list or description of business units, studios, or divisions to which this policy applies (e.g., All Studios, Publishing Division, Live Ops, Esports).',
    `applicable_game_titles` STRING COMMENT 'Comma-separated list of specific game titles or franchises to which this policy applies, or All Titles if universally applicable.',
    `applicable_platforms` STRING COMMENT 'Comma-separated list of gaming platforms to which this policy applies (e.g., Console, PC, Mobile, VR, All Platforms).',
    `approval_authority` STRING COMMENT 'Governing body or executive role with formal authority to approve or ratify the policy.. Valid values are `board_of_directors|executive_committee|compliance_committee|general_counsel|ceo`',
    `approval_date` DATE COMMENT 'Date when the policy was formally approved by the designated approval authority.',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which compliance with this policy is formally audited by internal audit or compliance teams.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days that data subject to this policy must be retained before eligible for deletion. Null if no specific retention period applies.',
    `document_url` STRING COMMENT 'URL link to the authoritative policy document stored in the document management system or intranet.. Valid values are `^https?://.*`',
    `effective_date` DATE COMMENT 'Date when the policy becomes enforceable and binding across applicable business units and territories.',
    `enforcement_mechanism` STRING COMMENT 'Description of how the policy is enforced internally (e.g., automated controls, manual audits, training requirements, disciplinary procedures).',
    `estimated_implementation_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in USD to implement the policy, including technology, process changes, training, and compliance infrastructure. Business-confidential financial data.',
    `expiration_date` DATE COMMENT 'Date when the policy ceases to be active, typically when superseded by a new version or retired. Nullable for policies without a defined end date.',
    `implementation_deadline` DATE COMMENT 'Target date by which the policy must be fully implemented and operational. May be driven by regulatory deadlines or internal governance timelines.',
    `implementation_status` STRING COMMENT 'Current status of the operational implementation of the policy across systems, processes, and business units.. Valid values are `not_started|in_progress|completed|partially_implemented|deferred`',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit conducted for this policy.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the policy by the policy owner or governance committee.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit of this policy. Calculated based on last audit date and audit frequency.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory policy review. Calculated based on last review date and review cycle.',
    `notes` STRING COMMENT 'Free-text field for additional context, implementation notes, exceptions, or special considerations related to the policy.',
    `owner_name` STRING COMMENT 'Full name of the individual currently serving as the policy owner. Business-confidential organizational information.',
    `owner_role` STRING COMMENT 'Executive or senior management role responsible for the policys content, enforcement, and updates (e.g., DPO for data protection, General Counsel for legal compliance).. Valid values are `dpo|general_counsel|chief_compliance_officer|ciso|cfo|ceo`',
    `penalty_for_non_compliance` STRING COMMENT 'Description of internal or external penalties for policy violations (e.g., disciplinary action, fines, suspension of operations, regulatory sanctions).',
    `policy_category` STRING COMMENT 'High-level classification of the policy type. Aligns with major regulatory and ethical compliance domains in gaming.. Valid values are `data_protection|loot_box_disclosure|age_rating_compliance|anti_bribery_corruption|sanctions_compliance|responsible_gaming`',
    `policy_code` STRING COMMENT 'Unique business identifier code for the compliance policy, typically following a structured format (e.g., GDPR-DPP-001, LOOT-DSC-002).. Valid values are `^[A-Z]{2,4}-[A-Z]{3}-[0-9]{3,5}$`',
    `policy_description` STRING COMMENT 'Detailed narrative description of the policys purpose, scope, and key provisions. Provides business context and intent.',
    `policy_name` STRING COMMENT 'Full official name of the compliance policy (e.g., Data Protection Policy, Loot Box Disclosure Policy, Age Rating Compliance Policy).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the compliance policy. Tracks progression from draft through approval to active enforcement and eventual retirement.. Valid values are `draft|under_review|approved|active|superseded|retired`',
    `requires_age_verification` BOOLEAN COMMENT 'Indicates whether this policy mandates age verification mechanisms to comply with child protection regulations (e.g., COPPA, GDPR for minors).',
    `requires_data_portability` BOOLEAN COMMENT 'Indicates whether this policy mandates support for data subject right to data portability under GDPR or similar regulations.',
    `requires_data_retention` BOOLEAN COMMENT 'Indicates whether this policy mandates specific data retention periods for compliance or audit purposes.',
    `requires_disclosure` BOOLEAN COMMENT 'Indicates whether this policy requires public or player-facing disclosure (e.g., loot box probability disclosure, privacy notice publication).',
    `requires_player_consent` BOOLEAN COMMENT 'Indicates whether this policy mandates obtaining explicit player consent (e.g., for data processing under GDPR, for marketing communications).',
    `requires_right_to_erasure` BOOLEAN COMMENT 'Indicates whether this policy mandates support for data subject right to erasure (right to be forgotten) under GDPR or similar regulations.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the policy must be reviewed and revalidated (e.g., 12 for annual review, 24 for biennial).',
    `risk_level` STRING COMMENT 'Assessment of the business and regulatory risk associated with non-compliance with this policy. Critical policies require highest priority enforcement.. Valid values are `critical|high|medium|low`',
    `training_frequency_months` STRING COMMENT 'Frequency in months at which employees must complete refresher training on this policy. Null if one-time training only.',
    `training_required` BOOLEAN COMMENT 'Indicates whether employees in applicable business units must complete formal training on this policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was last modified in the system.',
    `version` STRING COMMENT 'Version number of the policy document following semantic versioning (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master record for all internal compliance policies, codes of conduct, and regulatory compliance frameworks formally adopted by Gaming. Covers data protection policy, loot box disclosure policy, age rating compliance policy, anti-bribery and corruption policy, sanctions compliance policy, and responsible gaming policy. Captures policy name, policy category, policy version, effective date, review cycle, policy owner (DPO, General Counsel, Chief Compliance Officer), approval authority, applicable business units, and current status. Provides the governance backbone linking regulatory obligations to internal operational controls.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`data_subject_request` (
    `data_subject_request_id` BIGINT COMMENT 'Primary key for data_subject_request',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Data subject requests (erasure, portability, access) are processed under the governing consent policy that defined the original data collection. Linking DSRs to the applicable consent policy enables p',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: GDPR/CCPA data subject requests (erasure, access) are scoped to a specific game titles data. Compliance teams need direct title attribution on DSRs for GDPR response SLA tracking and title-level data',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Data subject requests are jurisdiction-specific (GDPR DSRs in EU, CCPA requests in California, etc.). The existing jurisdiction_code STRING is a denormalized value that becomes redundant once a struct',
    `original_data_subject_request_id` BIGINT COMMENT 'Self-referencing FK on data_subject_request (original_data_subject_request_id)',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who submitted the data subject request.',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Data subject request fulfillment requires identifying which processing activities are affected by the request (e.g., erasure request must identify all processing activities handling the subjects data',
    `applicable_regulation` STRING COMMENT 'Primary data protection regulation governing this request: GDPR (EU General Data Protection Regulation), CCPA (California Consumer Privacy Act), LGPD (Brazilian General Data Protection Law), PIPEDA (Canadian Personal Information Protection), APPI (Japanese Act on Protection of Personal Information), UK_GDPR (UK GDPR).',
    `audit_trail_notes` STRING COMMENT 'Detailed audit trail and processing notes documenting all actions taken, decisions made, and communications sent during the lifecycle of this data subject request.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the data subject request was fully completed and the response was delivered to the requestor.',
    `cost_recovery_applicable_flag` BOOLEAN COMMENT 'Indicates whether the request is manifestly unfounded or excessive, allowing the organization to charge a reasonable fee for processing under GDPR Article 12.5.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this data subject request record was first created in the compliance management system.',
    `data_categories_affected` STRING COMMENT 'Comma-separated list of personal data categories affected by this request (e.g., account_data, gameplay_data, purchase_history, communication_logs, device_identifiers).',
    `data_export_file_path` STRING COMMENT 'Secure file system path or cloud storage location where the exported personal data package is stored for delivery to the data subject (for access and portability requests).',
    `data_export_format` STRING COMMENT 'Format in which personal data was exported and delivered to the data subject: JSON, CSV, XML, PDF, or other machine_readable format.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the data subject request must be fulfilled (typically 30 days from submission under GDPR, 45 days under CCPA).',
    `erasure_executed_flag` BOOLEAN COMMENT 'Indicates whether personal data erasure (right to be forgotten) has been executed across all relevant systems for this request.',
    `erasure_timestamp` TIMESTAMP COMMENT 'Date and time when personal data erasure was executed across all systems in response to a right to be forgotten request.',
    `extended_due_date` DATE COMMENT 'New deadline if an extension has been granted, typically up to 60 additional days under GDPR or 45 additional days under CCPA.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether an extension to the standard response deadline has been granted due to complexity or volume of the request.',
    `extension_reason` STRING COMMENT 'Justification for granting an extension to the standard response deadline, such as request complexity or high volume of concurrent requests.',
    `fee_charged_amount` DECIMAL(18,2) COMMENT 'Administrative fee charged to the data subject for processing a manifestly unfounded or excessive request, in the organizations base currency.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the identity of the data subject requestor: account_credentials, government_id, knowledge_based (security questions), multi_factor (MFA), manual_review, not_verified.',
    `identity_verification_timestamp` TIMESTAMP COMMENT 'Date and time when the requestors identity was successfully verified.',
    `identity_verified_flag` BOOLEAN COMMENT 'Indicates whether the identity of the data subject requestor has been successfully verified through the required authentication process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this data subject request record was last updated or modified.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this data subject request is subject to a legal hold or litigation preservation order that may override erasure rights.',
    `legal_hold_reason` STRING COMMENT 'Explanation of the legal basis for placing a hold on data erasure, such as pending litigation, regulatory investigation, or legal compliance obligation.',
    `minor_flag` BOOLEAN COMMENT 'Indicates whether the data subject is a minor (under age of digital consent), requiring special handling under COPPA, GDPR Article 8, or other child protection regulations.',
    `parental_consent_verified_flag` BOOLEAN COMMENT 'Indicates whether parental or guardian consent has been verified for data subject requests submitted on behalf of minors.',
    `priority_level` STRING COMMENT 'Priority level assigned to the data subject request based on regulatory deadlines, complexity, and risk factors.',
    `records_retrieved_count` STRING COMMENT 'Total number of data records retrieved and reviewed to fulfill this data subject request.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the data subject request was rejected, including legal basis for denial (e.g., manifestly unfounded, excessive, identity not verified, legal obligation to retain data).',
    `request_number` STRING COMMENT 'Externally-visible unique business identifier for the data subject request, used in communications with the data subject and regulatory authorities.',
    `request_scope_description` STRING COMMENT 'Detailed description of the scope of the data subject request, including specific data categories, time periods, or systems requested by the data subject.',
    `request_status` STRING COMMENT 'Current lifecycle status of the data subject request: submitted (initial receipt), under_review (compliance team reviewing), identity_verification (verifying requestor identity), in_progress (actively processing), completed (fulfilled), rejected (denied with justification), withdrawn (requestor cancelled).',
    `request_type` STRING COMMENT 'Type of data subject request: access (right to access personal data), rectification (right to correct inaccurate data), erasure (right to be forgotten), portability (right to data portability), restriction (right to restrict processing), objection (right to object to processing).',
    `requestor_email` STRING COMMENT 'Email address of the individual submitting the data subject request, used for communication and identity verification.',
    `requestor_name` STRING COMMENT 'Full legal name of the individual submitting the data subject request.',
    `response_delivery_method` STRING COMMENT 'Method used to deliver the response to the data subject: email, secure_portal, postal_mail, in_app notification, or api (for automated integrations).',
    `submission_channel` STRING COMMENT 'Channel through which the data subject request was submitted: web_portal, mobile_app, email, postal_mail, phone, in_game.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the data subject request was originally submitted by the player or their authorized representative.',
    `systems_accessed` STRING COMMENT 'Comma-separated list of internal systems and databases accessed to fulfill this data subject request (e.g., player_database, payment_system, analytics_platform, customer_support_crm).',
    `third_party_notification_required_flag` BOOLEAN COMMENT 'Indicates whether third-party data processors or recipients must be notified of this data subject request (e.g., for erasure or rectification requests).',
    `third_party_notification_status` STRING COMMENT 'Status of notifications sent to third-party data processors or recipients regarding this data subject request.',
    CONSTRAINT pk_data_subject_request PRIMARY KEY(`data_subject_request_id`)
) COMMENT 'Master reference table for data_subject_request. Referenced by dsr_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_parent_regulatory_obligation_id` FOREIGN KEY (`parent_regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_superseded_age_rating_cert_id` FOREIGN KEY (`superseded_age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_superseded_loot_box_disclosure_id` FOREIGN KEY (`superseded_loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_primary_superseded_by_policy_consent_policy_id` FOREIGN KEY (`primary_superseded_by_policy_consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_root_cause_compliance_incident_id` FOREIGN KEY (`root_cause_compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_escalated_remediation_action_id` FOREIGN KEY (`escalated_remediation_action_id`) REFERENCES `gaming_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_parent_processing_activity_id` FOREIGN KEY (`parent_processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_superseded_spend_limit_control_id` FOREIGN KEY (`superseded_spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_superseded_policy_id` FOREIGN KEY (`superseded_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_original_data_subject_request_id` FOREIGN KEY (`original_data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `gaming_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `parent_regulatory_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `applicable_platforms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platforms');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc|continuous');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|not_applicable|under_review|remediation_required');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_value_regex' = 'statutory_penalty|platform_delisting|certification_revocation|injunction|consent_decree|administrative_fine');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Cost');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `implementation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|planning|in_development|testing|deployed|verified');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_reporting_deadline` SET TAGS ('dbx_business_glossary_term' = 'Next Reporting Deadline');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'data_privacy|consumer_protection|content_rating|financial_reporting|tax_compliance|platform_certification');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|event_driven|none');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `requires_age_verification` SET TAGS ('dbx_business_glossary_term' = 'Requires Age Verification');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `requires_data_portability` SET TAGS ('dbx_business_glossary_term' = 'Requires Data Portability');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `requires_data_retention` SET TAGS ('dbx_business_glossary_term' = 'Requires Data Retention');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `requires_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Requires Disclosure');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `requires_player_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Player Consent');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `requires_right_to_erasure` SET TAGS ('dbx_business_glossary_term' = 'Requires Right to Erasure');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction ID');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `parent_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Jurisdiction ID');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `advertising_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Advertising Restrictions');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `age_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `consumer_protection_framework` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Framework');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `content_censorship_level` SET TAGS ('dbx_business_glossary_term' = 'Content Censorship Level');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `content_censorship_level` SET TAGS ('dbx_value_regex' = 'none|moderate|strict');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `data_breach_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Notification Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `data_localization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Localization Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `digital_goods_vat_rate` SET TAGS ('dbx_business_glossary_term' = 'Digital Goods Value-Added Tax (VAT) Rate');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|ombudsman|mediation');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `embargo_status` SET TAGS ('dbx_business_glossary_term' = 'Embargo Status');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `embargo_status` SET TAGS ('dbx_value_regex' = 'none|partial|full');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `esports_gambling_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Esports Gambling Regulated Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{1,3})?$');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'country|state|province|territory|region|supranational');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `loot_box_regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Regulatory Status');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `loot_box_regulatory_status` SET TAGS ('dbx_value_regex' = 'unrestricted|disclosure_required|restricted|prohibited|under_review');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `minimum_age_for_monetization` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age for Monetization');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `online_service_license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Service License Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `pci_dss_enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Enforcement Level');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `pci_dss_enforcement_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|not_applicable');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `platform_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `rating_authority` SET TAGS ('dbx_business_glossary_term' = 'Rating Authority');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `right_to_be_forgotten_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Right to be Forgotten Applicable Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Certificate ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `superseded_age_rating_cert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'pending|approved|active|expired|revoked|suspended');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `content_descriptor_drugs` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor - Drugs');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `content_descriptor_fear` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor - Fear');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `content_descriptor_gambling` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor - Gambling');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `content_descriptor_language` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor - Language');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `content_descriptor_sexual` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor - Sexual Content');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `content_descriptor_violence` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor - Violence');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `interactive_element_location_sharing` SET TAGS ('dbx_business_glossary_term' = 'Interactive Element - Location Sharing');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `interactive_element_online` SET TAGS ('dbx_business_glossary_term' = 'Interactive Element - Online Interaction');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `interactive_element_purchases` SET TAGS ('dbx_business_glossary_term' = 'Interactive Element - In-Game Purchases');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `interactive_element_ugc` SET TAGS ('dbx_business_glossary_term' = 'Interactive Element - User-Generated Content (UGC)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `loot_box_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Required');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `loot_box_probability_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Probability Disclosed');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `rating_category` SET TAGS ('dbx_business_glossary_term' = 'Rating Category');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `rating_summary` SET TAGS ('dbx_business_glossary_term' = 'Rating Summary');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure ID');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `superseded_loot_box_disclosure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Title Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `age_rating` SET TAGS ('dbx_business_glossary_term' = 'Age Rating');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending review|under remediation|exempt|not applicable');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosed_item_probabilities` SET TAGS ('dbx_business_glossary_term' = 'Disclosed Item Probabilities');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Expiration Date');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_format` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Format');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_format` SET TAGS ('dbx_value_regex' = 'in-game odds display|website posting|app store label|in-app notice|regulatory filing|combined');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_language` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Language');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_url` SET TAGS ('dbx_business_glossary_term' = 'Disclosure URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `disclosure_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `enforcement_action_description` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Description');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `in_game_display_location` SET TAGS ('dbx_business_glossary_term' = 'In-Game Display Location');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model (Free-to-Play, Premium, Subscription, Hybrid)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'F2P|premium|subscription|hybrid');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `odds_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Odds Match Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `pity_system_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Pity System Disclosed Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `player_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Player Complaint Count');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy ID');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `primary_superseded_by_policy_consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Consent Policy ID');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `allows_withdrawal` SET TAGS ('dbx_business_glossary_term' = 'Allows Consent Withdrawal Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `applicable_game_titles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Game Titles');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `applicable_platforms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platforms');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Approval Status');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_legal_review|pending_compliance_review|approved|rejected|conditional_approval');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Approval Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Approved By');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `automated_decision_making` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision-Making Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_categories` SET TAGS ('dbx_business_glossary_term' = 'Consent Categories Covered');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Privacy Contact Email Address');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `cross_border_transfer_allowed` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Data Transfer Allowed Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `data_subject_rights_summary` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Rights Summary');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `dpo_name` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Name');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `dpo_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Expiry Date');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `loot_box_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Probability Disclosure Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Modified By');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `parental_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Document URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_hash` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Document Hash');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Language');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Name');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Scope');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_scope` SET TAGS ('dbx_value_regex' = 'single_game|game_franchise|all_games|platform_wide|corporate_wide');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Status');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|retired|withdrawn');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `profiling_purposes` SET TAGS ('dbx_business_glossary_term' = 'Profiling Purposes');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `requires_explicit_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Explicit Consent Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `supervisory_authority` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `third_party_categories` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Recipient Categories');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `third_party_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Allowed Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_value_regex' = 'standard_contractual_clauses|binding_corporate_rules|adequacy_decision|consent|not_applicable');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `withdrawal_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Created By');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident ID');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Player Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `root_cause_compliance_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `title_release_id` SET TAGS ('dbx_business_glossary_term' = 'Title Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Title Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `actual_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Actual Financial Impact');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `actual_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `affected_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Affected Jurisdictions');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `affected_player_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Player Count');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `audit_trail` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `containment_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Containment Actions Taken');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `containment_actions_taken` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `data_categories_affected` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Affected');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `data_categories_affected` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `discovery_channel` SET TAGS ('dbx_business_glossary_term' = 'Discovery Channel');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `discovery_channel` SET TAGS ('dbx_value_regex' = 'internal_audit|regulator_notification|player_complaint|automated_monitoring|third_party_report|whistleblower');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'team|manager|director|executive|board');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `external_counsel_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Engaged Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|investigating|contained|resolved|closed');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'data_breach|coppa_violation|loot_box_disclosure|age_gate_bypass|unauthorized_data_transfer|sanctions_violation');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `insurance_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Filed Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Notification Deadline');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `player_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `player_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Sent Date');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `regulator_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulator Reference Number');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `regulator_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Resolution Date');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Player Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `escalated_remediation_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Description');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Number');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^REM-[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Title');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Cost');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `external_consultant_engaged` SET TAGS ('dbx_business_glossary_term' = 'External Consultant Engaged Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Remediation Priority');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `recurrence_prevention_plan` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Prevention Plan');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Status');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|verified|cancelled|overdue');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_type` SET TAGS ('dbx_business_glossary_term' = 'Remediation Type');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_type` SET TAGS ('dbx_value_regex' = 'process_change|technical_control|policy_update|player_notification|regulatory_payment|training');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `risk_level_after` SET TAGS ('dbx_business_glossary_term' = 'Risk Level After Remediation');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `risk_level_after` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|mitigated');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `risk_level_before` SET TAGS ('dbx_business_glossary_term' = 'Risk Level Before Remediation');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `risk_level_before` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|system_audit|process_observation|stakeholder_confirmation|regulatory_inspection|testing');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity ID');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `parent_processing_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Code');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^PA-[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Name');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_owner` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Owner');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `automated_decision_logic` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision Logic Description');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `automated_decision_making_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision Making Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `ccpa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Applicable Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `children_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Children Data Processing Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `controller_processor_role` SET TAGS ('dbx_business_glossary_term' = 'Controller or Processor Role');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `controller_processor_role` SET TAGS ('dbx_value_regex' = 'controller|processor|joint_controller');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `data_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Processed');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `data_protection_officer_contact` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Contact');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `data_protection_officer_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `data_protection_officer_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `data_subject_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Categories');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `data_subject_rights_procedure` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Rights Exercise Procedure');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `dpia_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Completion Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `dpia_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `international_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'International Transfer Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `legitimate_interest_description` SET TAGS ('dbx_business_glossary_term' = 'Legitimate Interest Description');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `organizational_security_measures` SET TAGS ('dbx_business_glossary_term' = 'Organizational Security Measures');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `privacy_notice_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `processing_activity_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Status');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `processing_activity_status` SET TAGS ('dbx_value_regex' = 'active|suspended|discontinued|under_review');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Processing');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `recipient_categories` SET TAGS ('dbx_business_glossary_term' = 'Recipient Categories');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `retention_period` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Days');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `scc_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Contractual Clauses (SCC) Version');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `special_category_legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Special Category Legal Basis');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `technical_security_measures` SET TAGS ('dbx_business_glossary_term' = 'Technical Security Measures');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `transfer_countries` SET TAGS ('dbx_business_glossary_term' = 'Transfer Destination Countries');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `transfer_safeguard_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Transfer Safeguard Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `transfer_safeguard_mechanism` SET TAGS ('dbx_value_regex' = 'adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|code_of_conduct|not_applicable');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control ID');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `superseded_spend_limit_control_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `applicable_game_titles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Game Titles');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `applicable_mtx_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Microtransaction (MTX) Categories');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `applicable_platforms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platforms');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `audit_trail_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail URL');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `control_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Control Reference Number');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `control_source` SET TAGS ('dbx_business_glossary_term' = 'Control Source');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `control_source` SET TAGS ('dbx_value_regex' = 'regulatory_mandate|player_self_set|parental_control|platform_policy|court_order|third_party_exclusion');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'mandatory_regulatory_cap|voluntary_self_exclusion|parental_spending_limit|platform_imposed_cap|temporary_cooling_off|permanent_exclusion');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `cooling_off_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cooling-Off Period Days');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `current_period_spend` SET TAGS ('dbx_business_glossary_term' = 'Current Period Spend');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_activation|cooling_off');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `last_breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Amount');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Limit Currency Code');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `limit_period` SET TAGS ('dbx_business_glossary_term' = 'Limit Period');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `modification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `modification_request_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Request Date');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `player_acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Player Acknowledgment Required');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `player_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Player Acknowledgment Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Identifier (ID)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `superseded_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `applicable_business_units` SET TAGS ('dbx_business_glossary_term' = 'Applicable Business Units');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `applicable_game_titles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Game Titles');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `applicable_platforms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platforms');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'board_of_directors|executive_committee|compliance_committee|general_counsel|ceo');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Document URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Cost');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `implementation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|partially_implemented|deferred');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Name');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Role');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `owner_role` SET TAGS ('dbx_value_regex' = 'dpo|general_counsel|chief_compliance_officer|ciso|cfo|ceo');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_value_regex' = 'data_protection|loot_box_disclosure|age_rating_compliance|anti_bribery_corruption|sanctions_compliance|responsible_gaming');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[A-Z]{3}-[0-9]{3,5}$');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|retired');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `requires_age_verification` SET TAGS ('dbx_business_glossary_term' = 'Requires Age Verification Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `requires_data_portability` SET TAGS ('dbx_business_glossary_term' = 'Requires Data Portability Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `requires_data_retention` SET TAGS ('dbx_business_glossary_term' = 'Requires Data Retention Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `requires_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Requires Disclosure Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `requires_player_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Player Consent Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `requires_right_to_erasure` SET TAGS ('dbx_business_glossary_term' = 'Requires Right to Erasure Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency (Months)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `original_data_subject_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `data_export_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `legal_hold_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
