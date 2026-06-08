-- Schema for Domain: compliance | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`compliance` COMMENT 'Manages regulatory compliance obligations, audit schedules, loot box probability disclosure requirements, GDPR/COPPA data subject requests, age rating certification tracking, and jurisdictional regulatory reporting across all territories where games are published.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory compliance obligation record.',
    `regulatory_directive_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_directive. Business justification: Regulatory obligations are derived from regulatory directives. Should FK to the regulatory_directive that creates the obligation. Currently has regulation_name and regulation_reference as STRING field',
    `parent_regulatory_obligation_id` BIGINT COMMENT 'Self-referencing FK on regulatory_obligation (parent_regulatory_obligation_id)',
    `applicable_game_titles` STRING COMMENT 'Comma-separated list of game title identifiers or SKUs to which this obligation specifically applies. NULL if obligation applies to all titles.',
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
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Jurisdiction should reference the primary regulatory_authority that governs it. Currently has regulatory_contact_email (STRING) but no FK to the authority master table. Adding FK enables proper normal',
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
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Age rating certificates are issued by regulatory authorities (ESRB, PEGI, etc.). Currently has rating_authority_code (STRING) but should FK to regulatory_authority master table for normalization and t',
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
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Loot box disclosures reference certification_authority (STRING) for the authority that certified the disclosure. Should FK to regulatory_authority master table for normalization. Note: certification_a',
    `gacha_pool_id` BIGINT COMMENT 'Reference to the gacha pool configuration in the monetization domain that defines the actual drop rates and item probabilities for this loot box. Used to validate that disclosed odds match configured odds.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this loot box disclosure applies. Links to the game title master record in the Game Title domain.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Disclosures fulfill agreement-mandated transparency (licensor requires odds publication for branded content). Real process: disclosure workflow references contract requirements; legal teams verify com',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Loot box disclosure requirements are jurisdiction-mandated. Replacing string-based jurisdiction_code with proper FK to jurisdiction master to link to regulatory framework, loot_box_regulatory_status, ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Loot box disclosure is mandated by regulatory obligations in various jurisdictions. Currently has regulation_name (STRING); should FK to regulatory_obligation for normalization.',
    `superseded_loot_box_disclosure_id` BIGINT COMMENT 'Self-referencing FK on loot_box_disclosure (superseded_loot_box_disclosure_id)',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` (
    `dsr_fulfillment_step_id` BIGINT COMMENT 'Unique identifier for the DSR fulfillment step. Primary key for this transactional record capturing each discrete action taken to satisfy a data subject request under GDPR, COPPA, or other privacy regulations.',
    `data_subject_request_id` BIGINT COMMENT 'Reference to the parent data subject request that this fulfillment step belongs to. Links this step to the overarching DSR case.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Data Subject Request fulfillment must comply with jurisdiction-specific privacy laws (GDPR right to erasure, CCPA right to deletion, etc.). Replacing string-based jurisdiction field with proper FK to ',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Each DSR fulfillment step may target specific processing activities (e.g., erase data from marketing processing activity, export data from analytics processing activity). Should FK to the processi',
    `prerequisite_dsr_fulfillment_step_id` BIGINT COMMENT 'Self-referencing FK on dsr_fulfillment_step (prerequisite_dsr_fulfillment_step_id)',
    `assigned_team_member` STRING COMMENT 'Name or identifier of the employee or team member assigned to execute this fulfillment step. Provides accountability and contact point for step-level issues.',
    `audit_log_reference` STRING COMMENT 'Reference identifier or URI to detailed audit logs or system logs generated during execution of this step. Enables deep-dive investigation and regulatory evidence retrieval.',
    `blocker_description` STRING COMMENT 'Free-text description of any blockers, exceptions, or issues encountered during execution of this step. Captures obstacles that prevent or delay step completion for audit and resolution purposes.',
    `blocker_resolution_timestamp` TIMESTAMP COMMENT 'Date and time when a blocker or exception was resolved, allowing the step to proceed. Nullable if no blocker occurred or if blocker remains unresolved.',
    `compliance_deadline` TIMESTAMP COMMENT 'Regulatory deadline by which this fulfillment step must be completed to remain compliant. Derived from parent DSR deadline and step dependencies. Enables proactive escalation of at-risk steps.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment step record was first created in the system. Marks the initiation of the step in the DSR workflow orchestration.',
    `data_volume_processed` BIGINT COMMENT 'Number of records, files, or data objects processed during this fulfillment step. Provides quantitative measure of step scope and complexity for audit and capacity planning.',
    `data_volume_unit` STRING COMMENT 'Unit of measurement for the data volume processed (e.g., records, files, megabytes). Provides context for interpreting the data_volume_processed metric.. Valid values are `records|files|megabytes|gigabytes`',
    `error_code` STRING COMMENT 'System-generated error code if this step failed or encountered an exception. Enables categorization and root-cause analysis of fulfillment failures.',
    `error_message` STRING COMMENT 'Human-readable error message providing details about any failure or exception encountered during step execution. Supports troubleshooting and incident resolution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment step record was last updated. Tracks the most recent change to step status, assignment, or other attributes.',
    `notes` STRING COMMENT 'Free-text notes or comments added by the assigned team member during step execution. Captures context, decisions, or observations relevant to this specific step.',
    `player_notification_sent` BOOLEAN COMMENT 'Indicates whether the data subject (player) was notified of the completion or status of this fulfillment step. Required for transparency and regulatory compliance.',
    `player_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the player notification was sent. Documents compliance with obligation to inform data subjects of actions taken on their requests.',
    `responsible_system` STRING COMMENT 'Name of the system, platform, or data domain responsible for executing this fulfillment step (e.g., player, billing, analytics, marketing, community, Salesforce CRM, GameAnalytics, Zendesk). Identifies the technical boundary where action must be taken.',
    `retry_count` STRING COMMENT 'Number of times this fulfillment step has been retried due to failures or exceptions. Indicates step complexity and potential systemic issues requiring attention.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether this fulfillment step was completed within the defined SLA target. Nullable until step is completed. Used for operational performance reporting.',
    `sla_target_hours` STRING COMMENT 'Internal service level agreement target for completion of this step type, measured in hours. Used for operational performance tracking and escalation triggers.',
    `step_completion_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment step was successfully completed or terminated. Nullable until step reaches a terminal state. Used to calculate step duration and overall DSR fulfillment time.',
    `step_number` STRING COMMENT 'Sequential order of this fulfillment step within the parent DSR workflow. Enables chronological tracking and orchestration of multi-step DSR processes.',
    `step_start_timestamp` TIMESTAMP COMMENT 'Date and time when work on this fulfillment step began. Marks the initiation of the step in the DSR workflow and enables duration tracking.',
    `step_status` STRING COMMENT 'Current lifecycle state of this fulfillment step. Tracks progress through the step workflow and identifies steps requiring attention or intervention.. Valid values are `pending|in_progress|completed|failed|blocked|skipped`',
    `step_type` STRING COMMENT 'Category of fulfillment action being performed in this step. Defines the nature of the work required to satisfy the DSR obligation.. Valid values are `data_extraction|data_deletion|data_portability_package_generation|third_party_notification|player_notification|consent_withdrawal`',
    `third_party_name` STRING COMMENT 'Name of the third-party organization notified during this step (e.g., payment processor, analytics vendor, marketing platform). Nullable if no third-party notification was required.',
    `third_party_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the third-party notification was sent. Provides audit evidence of timely downstream notification as required by privacy regulations.',
    `third_party_notified` BOOLEAN COMMENT 'Indicates whether a third-party data processor or partner was notified as part of this fulfillment step. Required for DSR types that mandate downstream notification (e.g., erasure requests).',
    `verification_method` STRING COMMENT 'Method used to verify successful completion and accuracy of this fulfillment step. Ensures quality control and regulatory defensibility of DSR fulfillment process.. Valid values are `manual_review|automated_validation|sampling|third_party_audit`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when verification of this step was completed. Nullable if verification has not yet occurred or is not required for this step type.',
    `verified_by` STRING COMMENT 'Name or identifier of the person or system that performed verification of this step. Provides accountability for quality assurance in the DSR fulfillment process.',
    CONSTRAINT pk_dsr_fulfillment_step PRIMARY KEY(`dsr_fulfillment_step_id`)
) COMMENT 'Transactional record capturing each discrete fulfillment step executed to satisfy a data subject request. Tracks the DSR reference, step sequence number, step type (data extraction, data deletion, data portability package generation, third-party notification, player notification), responsible system or domain (player, billing, analytics, marketing), step status, assigned team member, step start timestamp, step completion timestamp, and any blockers or exceptions encountered. Enables end-to-end DSR workflow orchestration and provides granular audit evidence for regulatory inspections.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`consent_policy` (
    `consent_policy_id` BIGINT COMMENT 'Unique identifier for the consent policy configuration. Primary key. Inferred role: MASTER_AGREEMENT (versioned policy governing data collection/processing). This is the authoritative policy definition that player consent snapshots reference.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Consent_policy is a specialized type of policy and should reference the parent policy table for policy hierarchy. This enables modeling consent policies as a subtype of the general policy framework.',
    `regulatory_directive_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_directive. Business justification: Consent policies are mandated by regulatory directives (e.g., GDPR, COPPA). Should FK to the regulatory_directive that mandates the consent policy framework.',
    `superseded_by_policy_consent_policy_id` BIGINT COMMENT 'Foreign key reference to the consent_policy_id that supersedes this policy version. Null for active policies. Enables tracking policy evolution and version chains.',
    `superseded_consent_policy_id` BIGINT COMMENT 'Self-referencing FK on consent_policy (superseded_consent_policy_id)',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`audit_schedule` (
    `audit_schedule_id` BIGINT COMMENT 'Unique identifier for the audit schedule record. Primary key.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio that is the subject of this audit, if the audit is studio-specific (e.g., IP licensing audit for a particular studio). Null for enterprise-wide audits.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title that is the subject of this audit, if the audit is title-specific (e.g., loot box disclosure audit for a particular game). Null for enterprise-wide audits.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Audit schedules target specific agreements for periodic review (royalty accuracy, usage compliance). Real process: audit planning tied to high-value or high-risk contracts; schedule references agreeme',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Compliance audits are often jurisdiction-specific (e.g., GDPR audit for EU jurisdictions). Replacing string-based jurisdiction field with proper FK to jurisdiction master to link to regulatory framewo',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Audit schedules may be driven by internal policy requirements (in addition to regulatory obligations which are already FKd). Should FK to the policy that mandates the audit.',
    `regulatory_obligation_id` BIGINT COMMENT 'Reference to the specific regulatory obligation or compliance requirement that this audit schedule is designed to fulfill.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) that is the subject of this audit, if the audit is platform-specific (e.g., platform certification audit). Null for cross-platform audits.',
    `recurring_audit_schedule_id` BIGINT COMMENT 'Self-referencing FK on audit_schedule (recurring_audit_schedule_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether executive or board-level approval is required before this audit can proceed. True for high-risk or high-cost audits.',
    `approval_status` STRING COMMENT 'Current approval status for audits requiring executive authorization. Tracks the approval workflow state.. Valid values are `pending|approved|rejected|not_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or authority who approved this audit schedule. Null if approval is not required or still pending.',
    `approved_date` DATE COMMENT 'The date when the audit schedule received formal approval. Null if approval is not required or still pending.',
    `audit_criteria` STRING COMMENT 'The set of policies, procedures, standards, or regulations against which the audit will evaluate compliance (e.g., GDPR Articles 12-22, ESRB Marketing Guidelines).',
    `audit_lead_contact_email` STRING COMMENT 'Email address of the audit lead contact for coordination and communication purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `audit_lead_contact_name` STRING COMMENT 'Name of the primary contact person leading the audit engagement on behalf of the auditor.',
    `audit_name` STRING COMMENT 'The official name or title of the scheduled audit (e.g., Q1 2024 GDPR Compliance Audit, Annual Loot Box Disclosure Review).',
    `audit_objectives` STRING COMMENT 'A detailed description of the specific objectives and goals of this audit engagement, defining what the audit aims to verify or assess.',
    `audit_scope` STRING COMMENT 'The regulatory or compliance domain(s) covered by this audit. Defines the boundaries and focus areas of the audit engagement. [ENUM-REF-CANDIDATE: gdpr|coppa|loot_box|age_rating|financial|platform_certification|ip_licensing|pci_dss|esrb|pegi|usk|cero|grac|multi_domain — 14 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit by its nature and origin. Determines the audit framework and stakeholders involved.. Valid values are `internal_compliance|external_regulatory|third_party_ip_licensing|platform_certification|data_protection_authority_inspection|financial`',
    `auditor_type` STRING COMMENT 'Classification of the auditor as internal staff, external regulatory body, or third-party independent auditor.. Valid values are `internal|external|third_party`',
    `budget_allocated` DECIMAL(18,2) COMMENT 'The financial budget allocated for this audit engagement, covering auditor fees, travel, and related expenses. Stored in the organizations base currency.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the audit was cancelled or postponed, if applicable. Null for active or completed audits.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audit schedule record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget_allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimated_duration_days` STRING COMMENT 'The estimated number of business days required to complete the audit engagement, from start to final report delivery.',
    `internal_coordinator_email` STRING COMMENT 'Email address of the internal coordinator for audit scheduling and document exchange.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `internal_coordinator_name` STRING COMMENT 'Name of the internal compliance or legal team member responsible for coordinating the audit on behalf of the organization.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified this audit schedule record. Audit trail field.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this audit schedule record was most recently updated. Audit trail field.',
    `last_occurrence_date` DATE COMMENT 'For recurring audits, the date when the most recent occurrence of this audit was completed. Null for first-time audits.',
    `next_occurrence_date` DATE COMMENT 'For recurring audits, the calculated date when the next occurrence of this audit is scheduled, based on the recurrence_pattern.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context relevant to this audit schedule.',
    `notification_sent_date` DATE COMMENT 'The date when formal audit notification was sent to relevant stakeholders and auditees, initiating the audit process.',
    `preparation_start_date` DATE COMMENT 'The date when internal audit preparation activities (document gathering, pre-audit reviews) are scheduled to begin, typically preceding the scheduled_start_date.',
    `recurrence_pattern` STRING COMMENT 'The frequency with which this audit is scheduled to repeat. Determines whether the audit is a recurring obligation or a one-time engagement.. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc|one_time`',
    `rescheduled_from_date` DATE COMMENT 'The original scheduled start date, if this audit was rescheduled. Null for audits that have not been rescheduled.',
    `responsible_auditor` STRING COMMENT 'Name of the internal team or external audit firm responsible for conducting the audit (e.g., Internal Compliance Team, Deloitte LLP, KPMG).',
    `risk_level` STRING COMMENT 'The assessed risk level associated with the compliance area being audited. Determines audit priority and resource allocation.. Valid values are `critical|high|medium|low`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the audit schedule. Tracks the audit from planning through execution to completion. [ENUM-REF-CANDIDATE: draft|scheduled|in_progress|completed|cancelled|postponed|rescheduled — 7 candidates stripped; promote to reference product]',
    `scheduled_end_date` DATE COMMENT 'The planned date when the audit engagement is scheduled to conclude. Defines the audit window and reporting deadline.',
    `scheduled_start_date` DATE COMMENT 'The planned date when the audit engagement is scheduled to begin. Used for audit calendar planning and resource allocation.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this audit schedule record. Audit trail field.',
    CONSTRAINT pk_audit_schedule PRIMARY KEY(`audit_schedule_id`)
) COMMENT 'Master record for all planned compliance audit schedules across regulatory domains — internal compliance audits, external regulatory audits, third-party IP licensing audits, platform certification audits, and data protection authority inspections. Captures audit name, audit type, audit scope (GDPR, COPPA, loot box, age rating, financial), responsible auditor (internal team or external firm), scheduled start date, scheduled end date, recurrence pattern (annual, semi-annual, ad-hoc), associated regulatory obligation, and current schedule status. Drives the compliance calendar and audit preparation workflows.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`audit_engagement` (
    `audit_engagement_id` BIGINT COMMENT 'Unique identifier for the audit engagement record. Primary key.',
    `audit_schedule_id` BIGINT COMMENT 'Reference to the scheduled audit plan that triggered this engagement. Links to the audit schedule master record.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title under audit, if the engagement is scoped to a single title. Null for enterprise-wide audits.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Engagements audit specific agreements (royalty calculations, territory restrictions). Real process: audit execution scoped to contract terms; engagement references agreement for evidence gathering.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Audit engagements are conducted within specific jurisdictions and must comply with local audit standards. Replacing string-based territory_code with proper FK to jurisdiction master to link to regulat',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Audit engagements (SOX, GDPR, age rating compliance audits) are conducted on specific legal entities. Gaming companies with multiple subsidiaries must track which entity is under audit for financial s',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Audit engagement has regulatory_authority (STRING) field identifying the authority being audited for. Should FK to regulatory_authority master table for normalization.',
    `follow_up_audit_engagement_id` BIGINT COMMENT 'Self-referencing FK on audit_engagement (follow_up_audit_engagement_id)',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the audit engagement, including auditor fees, travel expenses, and internal resource costs. Expressed in the companys reporting currency.',
    `audit_end_date` DATE COMMENT 'Date when the audit fieldwork and evidence collection activities concluded. Null if audit is still in progress.',
    `audit_firm_name` STRING COMMENT 'Name of the auditing organization or firm conducting the engagement (e.g., Big Four firm, specialized compliance consultancy, internal audit department, regulatory body).',
    `audit_opinion` STRING COMMENT 'Overall auditor conclusion on compliance status: unqualified (clean, no material issues), qualified (generally compliant with noted exceptions), adverse (material non-compliance), disclaimer (insufficient evidence to form opinion).. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `audit_scope` STRING COMMENT 'Primary compliance domain or regulatory area under examination in this engagement (e.g., GDPR compliance, COPPA compliance, loot box probability disclosure, age rating certification, PCI DSS payment security, data retention policies, platform certification requirements). [ENUM-REF-CANDIDATE: gdpr_compliance|coppa_compliance|loot_box_disclosure|age_rating|payment_security|data_retention|platform_certification|esrb_rating|pegi_rating|financial_controls|revenue_recognition|mtx_fairness|player_data_privacy — promote to reference product]. Valid values are `gdpr_compliance|coppa_compliance|loot_box_disclosure|age_rating|payment_security|data_retention|[ENUM-REF-CANDIDATE: gdpr_compliance|coppa_compliance|loot_box_disclosure|age_rating|payment_security|data_retention|platform_certification|esrb_rating|pegi_rating|financial_controls|revenue_recognition|mtx_fairness|player_data_privacy — promote to reference product]`',
    `audit_start_date` DATE COMMENT 'Date when the audit fieldwork and evidence collection activities commenced.',
    `audit_status` STRING COMMENT 'Current lifecycle state of the audit engagement: scheduled (planned but not started), in_progress (active fieldwork), fieldwork_complete (evidence gathering done), report_draft (auditor preparing findings), management_review (company reviewing draft), finalized (report issued), closed (all follow-up complete). [ENUM-REF-CANDIDATE: scheduled|in_progress|fieldwork_complete|report_draft|management_review|finalized|closed — 7 candidates stripped; promote to reference product]',
    `audit_team_size` STRING COMMENT 'Number of auditors and specialists assigned to the engagement team.',
    `board_presentation_date` DATE COMMENT 'Date when audit results were presented to the board of directors or audit committee for governance oversight. Null if board presentation not required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit engagement record was first created in the compliance management system.',
    `critical_findings_count` STRING COMMENT 'Number of critical or high-severity findings that represent material compliance failures or significant risk exposures requiring immediate remediation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `engagement_number` STRING COMMENT 'Externally-known unique business identifier for the audit engagement, formatted as AE-YYYY-NNNNNN for tracking and reporting purposes.. Valid values are `^AE-[0-9]{4}-[0-9]{6}$`',
    `engagement_type` STRING COMMENT 'Classification of the audit engagement by origin and purpose: internal (company-initiated), external (third-party), regulatory (mandated by authority), certification (for standards compliance), follow-up (remediation verification), or special (ad-hoc investigation).. Valid values are `internal|external|regulatory|certification|follow_up|special`',
    `evidence_items_reviewed` STRING COMMENT 'Total count of documents, records, system logs, and other evidence items examined during the audit fieldwork.',
    `fieldwork_duration_days` STRING COMMENT 'Total number of calendar days spent on active audit fieldwork and evidence gathering, calculated from start to end date.',
    `final_report_document_reference` STRING COMMENT 'Document management system reference, URI, or file path to the final signed audit report document for retrieval and archival purposes.',
    `findings_count` STRING COMMENT 'Total number of audit findings, observations, or non-conformities identified during the engagement across all severity levels.',
    `follow_up_deadline` DATE COMMENT 'Target date by which follow-up audit or remediation verification must be completed. Null if no follow-up is required.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a follow-up audit or verification engagement is required to confirm remediation of findings. True if follow-up is mandated, False if no follow-up needed.',
    `interviews_conducted` STRING COMMENT 'Number of formal interviews or meetings conducted with personnel during the audit engagement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit engagement record was most recently updated, reflecting the latest change to any field.',
    `lead_auditor_name` STRING COMMENT 'Full name of the principal auditor responsible for conducting the engagement and signing the final audit opinion.',
    `major_findings_count` STRING COMMENT 'Number of major or medium-severity findings that represent notable compliance gaps or control weaknesses requiring timely remediation.',
    `management_response_date` DATE COMMENT 'Date when management formally submitted their response to the audit findings and recommendations.',
    `management_response_summary` STRING COMMENT 'Executive summary of managements formal response to audit findings, including acceptance, dispute, or planned corrective actions.',
    `minor_findings_count` STRING COMMENT 'Number of minor or low-severity findings that represent opportunities for improvement or minor procedural deviations.',
    `opinion_rationale` STRING COMMENT 'Textual explanation of the basis for the audit opinion, summarizing key evidence, findings, and reasoning that led to the auditors conclusion.',
    `record_source_system` STRING COMMENT 'Name of the operational system or compliance management platform from which this audit engagement record originated (e.g., Jira, SAP GRC, custom compliance portal).',
    `regulatory_filing_date` DATE COMMENT 'Date when audit results were submitted to the regulatory authority. Null if no regulatory filing required.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether audit results must be filed with or reported to a regulatory authority. True if regulatory filing is mandated, False otherwise.',
    `report_issued_date` DATE COMMENT 'Date when the final audit report was formally issued to management and stakeholders.',
    `scope_narrative` STRING COMMENT 'Detailed textual description of the audit boundaries, including specific game titles, territories, business processes, systems, and time periods examined during the engagement.',
    `systems_tested` STRING COMMENT 'Number of IT systems, platforms, or applications subjected to audit testing and control evaluation.',
    CONSTRAINT pk_audit_engagement PRIMARY KEY(`audit_engagement_id`)
) COMMENT 'Transactional record for each executed compliance audit engagement, representing the actual conduct of a scheduled or ad-hoc audit. Captures audit schedule reference, audit engagement number, lead auditor name and firm, audit start date, audit end date, audit scope narrative, number of findings, overall audit opinion (clean, qualified, adverse), management response summary, follow-up required flag, follow-up deadline, and final report document reference. Provides the authoritative record of audit outcomes for regulatory reporting and board-level governance.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key for the audit finding entity.',
    `audit_engagement_id` BIGINT COMMENT 'Reference to the parent audit engagement or audit project under which this finding was identified.',
    `employee_id` BIGINT COMMENT 'Reference to the auditor or audit team member who identified and documented this finding.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title to which this finding applies, if the finding is game-specific rather than enterprise-wide.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Findings reference the agreement where non-compliance was discovered (under-reported revenue, unauthorized sublicensing). Real process: remediation tracking tied to contract; legal teams assess breach',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Audit findings are often jurisdiction-specific compliance violations. Replacing string-based jurisdiction_code with proper FK to jurisdiction master to link to applicable regulatory framework, enforce',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the previous audit finding record if this is a recurrence, enabling trend analysis and escalation.',
    `primary_audit_employee_id` BIGINT COMMENT 'Reference to the employee or team assigned responsibility for implementing the remediation action and closing the finding.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Audit finding identifies non-conformance with regulatory obligations. Should FK to the specific regulatory_obligation that the finding relates to for proper categorization and tracking.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) to which this finding applies, if the finding is platform-specific.',
    `related_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on audit_finding (related_audit_finding_id)',
    `closure_evidence` STRING COMMENT 'Description or reference to the evidence provided to demonstrate that the finding has been remediated (e.g., updated policy document, system configuration screenshot, training completion records).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date when the finding was escalated to executive leadership or the board.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this finding has been escalated to executive leadership or the board due to severity or lack of remediation progress.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact or potential loss associated with the finding if not remediated, expressed in the companys reporting currency.',
    `finding_category` STRING COMMENT 'Severity classification of the audit finding indicating the level of risk or non-conformance: critical (immediate action required), major (significant non-conformance), minor (isolated issue), observation (improvement opportunity).. Valid values are `critical|major|minor|observation`',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit finding, including the specific non-conformance, observation, or control deficiency identified during the audit.',
    `finding_number` STRING COMMENT 'Business identifier for the finding within the audit engagement, typically a sequential or hierarchical code (e.g., AUD-2024-001-F01).',
    `finding_title` STRING COMMENT 'Concise summary title of the audit finding for quick identification and reporting purposes.',
    `identified_date` DATE COMMENT 'Date when the finding was first identified during the audit engagement.',
    `management_response` STRING COMMENT 'Formal response from management acknowledging the finding and committing to remediation actions, including any alternative approaches or risk acceptance decisions.',
    `recommended_remediation_action` STRING COMMENT 'Auditors recommended corrective or preventive action to address the finding and prevent recurrence.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this finding is a recurrence of a previously identified and closed finding, signaling potential systemic control weakness.',
    `regulatory_area` STRING COMMENT 'The regulatory domain or compliance framework to which this finding relates, such as GDPR (General Data Protection Regulation), COPPA (Childrens Online Privacy Protection Act), loot box disclosure requirements, age rating certification (ESRB, PEGI), financial reporting standards, PCI DSS (Payment Card Industry Data Security Standard), or platform-specific compliance requirements. [ENUM-REF-CANDIDATE: gdpr|coppa|loot_box|age_rating|financial_reporting|pci_dss|esrb|pegi|data_protection|consumer_protection|advertising_standards|platform_compliance — 12 candidates stripped; promote to reference product]',
    `remediation_completion_date` DATE COMMENT 'Actual date when the remediation action was completed by the remediation owner, prior to verification.',
    `remediation_due_date` DATE COMMENT 'Target date by which the remediation action must be completed and the finding closed, based on severity and regulatory requirements.',
    `remediation_status` STRING COMMENT 'Current lifecycle status of the remediation effort: open (not started), in_progress (work underway), pending_verification (awaiting audit review), closed (remediation verified and accepted), overdue (past due date), deferred (postponed with justification).. Valid values are `open|in_progress|pending_verification|closed|overdue|deferred`',
    `risk_rating` STRING COMMENT 'Overall risk assessment of the finding based on likelihood and impact, used for prioritization and executive reporting.. Valid values are `critical|high|medium|low`',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause(s) that led to the finding, identifying systemic issues, process gaps, or control weaknesses.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was last modified, supporting change tracking and audit trail requirements.',
    `verification_date` DATE COMMENT 'Date when the auditor or compliance team verified and accepted the remediation action as complete and effective.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record for each individual finding, non-conformance, or observation raised during a compliance audit engagement. Captures audit engagement reference, finding number, finding category (critical, major, minor, observation), regulatory area (GDPR, COPPA, loot box, age rating, financial reporting), finding description, root cause analysis, recommended remediation action, assigned remediation owner, remediation due date, remediation status, and evidence of closure. Drives the compliance remediation workflow and tracks open risk items for executive reporting.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key.',
    `amendment_of_filing_id` BIGINT COMMENT 'Identifier of the original filing that this filing amends or supersedes. Null if this is an original filing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory filings (age rating submissions, loot box disclosures, esports betting licenses) incur costs that must be allocated to cost centers for budgeting and variance analysis. Gaming studios track',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title to which this regulatory filing pertains. Null if the filing is corporate-level or not title-specific.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Filings reference the agreement requiring the submission (loot box disclosure for licensed IP, age rating for co-published title). Real process: filing preparation references contract obligations.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Regulatory filings are submitted to jurisdiction-specific authorities. Replacing string-based jurisdiction_code with proper FK to jurisdiction master for referential integrity and to enable joining to',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (subsidiary, studio, or corporate entity) on whose behalf this filing was made.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Regulatory filings relate to specific profit centers (game titles, platforms, studios) for segment reporting and profitability analysis. Gaming companies must allocate compliance costs and track regul',
    `regulatory_authority_id` BIGINT COMMENT 'Identifier of the regulatory authority, rating board, or government body to which this filing was submitted (e.g., ESRB, PEGI, FTC, national gambling commission, GDPR supervisory authority).',
    `regulatory_directive_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_directive. Business justification: Regulatory filing is submitted to satisfy specific regulatory directives. Currently has compliance_framework (STRING) but should FK to regulatory_directive that mandates the filing for proper normaliz',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filing is submitted to satisfy specific regulatory obligations. Should FK to the regulatory_obligation being fulfilled to enable tracking obligation compliance status.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or compliance officer responsible for preparing and submitting this filing.',
    `storefront_id` BIGINT COMMENT 'Identifier of the platform (console, PC, mobile) for which this filing was made. Null if the filing is platform-agnostic or corporate-level.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Regulatory filings for esports betting licenses, prize pool disclosures, and tournament compliance requirements should reference specific tournaments. Many jurisdictions require tournament-specific fi',
    `amended_regulatory_filing_id` BIGINT COMMENT 'Self-referencing FK on regulatory_filing (amended_regulatory_filing_id)',
    `acknowledgement_receipt_date` DATE COMMENT 'Date on which the regulatory authority formally acknowledged receipt of the filing. Null if not yet acknowledged.',
    `age_rating_assigned` STRING COMMENT 'Age rating or content classification assigned by the rating board (e.g., ESRB: E, E10+, T, M, AO; PEGI: 3, 7, 12, 16, 18; CERO: A, B, C, D, Z). Null if filing is not an age rating submission or if not yet assigned.',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority approved the filing or granted the requested certification/rating. Null if not yet approved or if rejected.',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content descriptors or warning labels assigned by the rating board (e.g., Violence, Blood, Strong Language, In-Game Purchases). Null if not applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was first created in the system.',
    `data_subject_request_count` STRING COMMENT 'Number of data subject access requests, erasure requests, or portability requests covered by this filing (relevant for GDPR Article 30 or COPPA filings). Null if not applicable.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the filing must be submitted. Null if no specific deadline applies.',
    `esports_betting_license_number` STRING COMMENT 'License or permit number issued by a gambling or gaming authority for esports betting operations. Null if filing is not esports betting compliance-related.',
    `external_audit_flag` BOOLEAN COMMENT 'Boolean indicator of whether this filing has been reviewed by an external auditor or third-party compliance assessor. True if externally audited, False otherwise.',
    `filing_description` STRING COMMENT 'Detailed textual description of the filing content, purpose, and scope. May include summary of disclosures, data subject request details, or certification scope.',
    `filing_document_url` STRING COMMENT 'Internal or external URL or storage path to the official filing document, submission package, or evidence bundle. Confidential.',
    `filing_period_end_date` DATE COMMENT 'End date of the reporting or compliance period covered by this filing. Null if the filing is event-based rather than period-based.',
    `filing_period_start_date` DATE COMMENT 'Start date of the reporting or compliance period covered by this filing. Null if the filing is event-based rather than period-based.',
    `filing_reference_number` STRING COMMENT 'External reference number or tracking identifier assigned by the regulatory authority or internal compliance system for this filing.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing (e.g., draft, submitted, under review, acknowledged, approved, rejected, withdrawn, amended). [ENUM-REF-CANDIDATE: draft|submitted|under_review|acknowledged|approved|rejected|withdrawn|amended — 8 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'Category of regulatory filing. Indicates the nature of the submission (e.g., loot box probability disclosure, GDPR Article 30 records of processing, COPPA verifiable parental consent, age rating submission to ESRB/PEGI/USK/CERO, financial regulatory disclosure, esports betting compliance).. Valid values are `loot_box_disclosure|gdpr_article_30|coppa_parental_consent|age_rating_submission|financial_disclosure|esports_betting_compliance`',
    `internal_audit_flag` BOOLEAN COMMENT 'Boolean indicator of whether this filing has been reviewed and validated by internal audit or compliance review. True if audited, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was last updated or modified.',
    `loot_box_disclosure_url` STRING COMMENT 'Public URL where loot box probability disclosures are published, as required by certain jurisdictions. Null if filing is not a loot box disclosure or if not yet published.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal of this filing or certification. Null if no periodic review is required.',
    `parental_consent_method` STRING COMMENT 'Method used to obtain verifiable parental consent for COPPA compliance (e.g., credit card verification, government ID check, video conference, signed consent form). Null if filing is not COPPA-related.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of any fine or penalty imposed by the regulatory authority in connection with this filing. Null if no penalty was imposed.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP, JPY). Null if no penalty was imposed.. Valid values are `^[A-Z]{3}$`',
    `penalty_imposed_flag` BOOLEAN COMMENT 'Boolean indicator of whether a penalty, fine, or sanction was imposed as a result of this filing or related non-compliance. True if penalty imposed, False otherwise.',
    `regulatory_response_text` STRING COMMENT 'Textual content of the official response, feedback, or decision issued by the regulatory authority. Null if no response has been received.',
    `rejection_date` DATE COMMENT 'Date on which the regulatory authority rejected the filing. Null if not rejected.',
    `submission_date` DATE COMMENT 'Date on which the filing was formally submitted to the regulatory authority.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Transactional record for each formal regulatory filing or submission made by Gaming to a government body, regulatory authority, or rating board. Covers loot box probability disclosures to national gambling commissions, GDPR Article 30 records of processing submissions, COPPA verifiable parental consent filings, age rating submissions (ESRB, PEGI, USK, CERO), financial regulatory disclosures, and esports betting compliance filings. Captures filing type, regulatory authority, jurisdiction, filing reference number, submission date, filing period, filing status, acknowledgement receipt date, and any regulatory response or penalty.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`compliance_incident` (
    `compliance_incident_id` BIGINT COMMENT 'Unique identifier for the compliance incident record. Primary key for the compliance incident entity.',
    `player_account_id` BIGINT COMMENT 'Foreign key linking to player.player_account. Business justification: Many compliance incidents involve specific player accounts (unauthorized account access, data breach affecting player, consent violation). Essential for player notification obligations (GDPR Article 3',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance incidents (data breaches, loot box violations, age verification failures) incur remediation costs that must be allocated to cost centers for budget impact analysis. Gaming studios track inc',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Compliance incidents may be triggered by data subject requests (e.g., DSR reveals data breach, DSR cannot be fulfilled within SLA). Should FK to the originating data_subject_request when incident is D',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title associated with the compliance incident. Links the incident to the specific game product where the violation occurred.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Incidents (data breach, undisclosed loot box odds) may violate agreement terms (data protection clauses, transparency requirements). Real process: incident investigation checks contract compliance; le',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer or legal team member responsible for managing the incident investigation and resolution. Links to internal workforce user master data.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance incident represents breach or violation of regulatory obligations. Should FK to the specific regulatory_obligation that was violated to enable tracking which obligations are most frequently',
    `storefront_id` BIGINT COMMENT 'Identifier of the gaming platform where the compliance incident occurred. Links to console, PC, mobile, or web platform master data.',
    `root_cause_compliance_incident_id` BIGINT COMMENT 'Self-referencing FK on compliance_incident (root_cause_compliance_incident_id)',
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
    `audit_finding_id` BIGINT COMMENT 'Reference to the audit finding that necessitated this remediation action. Links to formal audit observations requiring response.',
    `compliance_incident_id` BIGINT COMMENT 'Reference to the compliance incident that triggered this remediation action. Links to the source incident requiring corrective measures.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Remediation may require contract amendment or licensee notification (update loot box disclosure clause, notify licensor of breach). Real process: corrective action tied to agreement terms.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Remediation actions must comply with jurisdiction-specific regulatory requirements. Replacing string-based affected_jurisdiction field with proper FK to jurisdiction master to link to regulatory frame',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Remediation action may be driven by internal policy violations (in addition to incidents/findings/directives which are already FKd). Should FK to policy table when remediation is policy-driven. Note:',
    `employee_id` BIGINT COMMENT 'Reference to the employee or team responsible for executing and completing the remediation action. Accountable party for delivery.',
    `quaternary_remediation_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified the remediation action record. Provides audit trail for changes.',
    `regulatory_directive_id` BIGINT COMMENT 'Reference to the regulatory directive or order that mandated this remediation action. Links to formal regulatory requirements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Remediation actions have actual costs (estimated_cost, actual_cost fields present) that must be allocated to cost centers for financial tracking. Gaming companies budget for compliance remediation and',
    `tertiary_remediation_created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created the remediation action record. Provides accountability for action initiation.',
    `escalated_remediation_action_id` BIGINT COMMENT 'Self-referencing FK on remediation_action (escalated_remediation_action_id)',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` (
    `privacy_impact_assessment_id` BIGINT COMMENT 'Unique identifier for the privacy impact assessment record. Primary key for DPIA/PIA tracking under GDPR Article 35.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Privacy Impact Assessment evaluates data processing activities that are governed by consent policies. Should FK to the applicable consent_policy to link the assessment to the consent framework being e',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this privacy impact assessment was conducted. Links to the game title master data.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Privacy Impact Assessments (PIAs/DPIAs) are required by jurisdiction-specific privacy regulations. Replacing string-based jurisdiction field with proper FK to jurisdiction master to link to gdpr_appli',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: PIAs assess IP-specific data processing (game engine telemetry, voice chat SDK, analytics middleware). Real process: privacy review per integrated technology; DPO evaluates IP-level risks.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Privacy Impact Assessments may be mandated by internal policies (in addition to regulatory requirements). Should FK to the policy that requires the PIA to be conducted.',
    `superseded_privacy_impact_assessment_id` BIGINT COMMENT 'Self-referencing FK on privacy_impact_assessment (superseded_privacy_impact_assessment_id)',
    `assessment_date` DATE COMMENT 'Date when the privacy impact assessment was formally conducted or completed by the assessment team.',
    `assessment_methodology` STRING COMMENT 'Framework or methodology used to conduct the privacy impact assessment (e.g., ICO DPIA template, CNIL methodology, ISO 29134).',
    `assessment_number` STRING COMMENT 'Business identifier or reference number assigned to this privacy impact assessment for tracking and audit purposes.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the privacy impact assessment in the review and approval workflow. [ENUM-REF-CANDIDATE: Draft|Under_Review|DPO_Review|Approved|Rejected|Consultation_Required|Completed — 7 candidates stripped; promote to reference product]',
    `assessment_team_members` STRING COMMENT 'Comma-separated list of team members who participated in conducting this privacy impact assessment, including roles (e.g., Product Manager, Legal Counsel, Security Architect).',
    `assessment_title` STRING COMMENT 'Descriptive title of the privacy impact assessment, identifying the feature, processing activity, or integration being assessed.',
    `assessment_type` STRING COMMENT 'Type of privacy impact assessment conducted: Data Protection Impact Assessment (DPIA) under GDPR, Privacy Impact Assessment (PIA) for other jurisdictions, or updates to existing assessments.. Valid values are `DPIA|PIA|DPIA_Update|PIA_Update`',
    `children_data_involved` BOOLEAN COMMENT 'Indicates whether the processing involves personal data of children, triggering additional protections under GDPR Article 8 and COPPA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy impact assessment record was first created in the system.',
    `cross_border_transfer` BOOLEAN COMMENT 'Indicates whether the processing involves cross-border transfer of personal data outside the EEA, requiring additional safeguards under GDPR Chapter V.',
    `data_categories` STRING COMMENT 'Comma-separated list or description of the categories of personal data involved in the processing activity (e.g., player identifiers, behavioral data, payment information, location data).',
    `data_retention_period` STRING COMMENT 'Planned retention period for the personal data collected through this processing activity, in compliance with data minimization principles.',
    `data_subject_categories` STRING COMMENT 'Categories of data subjects affected by the processing activity (e.g., adult players, child players under 13, EU residents, California residents).',
    `dpo_reviewer_email` STRING COMMENT 'Email address of the Data Protection Officer who reviewed this assessment for contact and audit trail purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `dpo_reviewer_name` STRING COMMENT 'Full name of the Data Protection Officer who reviewed this privacy impact assessment.',
    `dpo_sign_off_date` DATE COMMENT 'Date when the Data Protection Officer formally approved and signed off on the privacy impact assessment.',
    `identified_privacy_risks` STRING COMMENT 'Detailed description of the privacy risks identified during the assessment, including potential impacts on data subjects rights and freedoms.',
    `initial_risk_level` STRING COMMENT 'Initial privacy risk level assessed before mitigating controls are applied, based on the nature and scope of the processing activity.. Valid values are `Low|Medium|High|Critical`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this privacy impact assessment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy impact assessment record was last updated or modified.',
    `legal_basis` STRING COMMENT 'Legal basis under GDPR Article 6 for the data processing activity being assessed (e.g., consent, contract performance, legitimate interest).. Valid values are `Consent|Contract|Legitimate_Interest|Legal_Obligation|Vital_Interest|Public_Task`',
    `mitigating_controls` STRING COMMENT 'Description of the technical and organizational measures implemented or planned to mitigate the identified privacy risks.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this privacy impact assessment to reassess risks and controls.',
    `platform_feature` STRING COMMENT 'Specific platform feature or system component being assessed (e.g., matchmaking system, in-game chat, player analytics, third-party SDK integration).',
    `processing_activity_description` STRING COMMENT 'Detailed description of the data processing activity, feature, or third-party integration that triggered the need for this privacy impact assessment.',
    `residual_risk_level` STRING COMMENT 'Privacy risk level remaining after mitigating controls have been applied. Determines whether supervisory authority consultation is required.. Valid values are `Low|Medium|High|Critical`',
    `review_frequency` STRING COMMENT 'Scheduled frequency for reviewing and updating this privacy impact assessment to ensure ongoing compliance as processing activities evolve.. Valid values are `Annual|Biannual|Quarterly|On_Change|One_Time`',
    `special_category_data_involved` BOOLEAN COMMENT 'Indicates whether the processing involves special categories of personal data under GDPR Article 9 (e.g., biometric data, health data).',
    `stakeholder_consultation_notes` STRING COMMENT 'Notes from consultations with relevant stakeholders, including data subjects where appropriate, as required under GDPR Article 35(9).',
    `supervisory_authority_consultation_date` DATE COMMENT 'Date when the supervisory authority was consulted regarding this high-risk processing activity, if consultation was required.',
    `supervisory_authority_consultation_required` BOOLEAN COMMENT 'Indicates whether consultation with the supervisory authority is required under GDPR Article 36 due to high residual risk that cannot be adequately mitigated.',
    `supervisory_authority_name` STRING COMMENT 'Name of the GDPR supervisory authority consulted (e.g., ICO, CNIL, BfDI) for this privacy impact assessment.',
    `supervisory_authority_response_date` DATE COMMENT 'Date when the supervisory authority provided their response or guidance following consultation.',
    `third_party_integration` STRING COMMENT 'Name of the third-party service, SDK, or data processor being integrated that triggered this privacy impact assessment.',
    `transfer_mechanism` STRING COMMENT 'Legal mechanism used for cross-border data transfers if applicable (e.g., Standard Contractual Clauses, Adequacy Decision, Binding Corporate Rules).. Valid values are `Standard_Contractual_Clauses|Adequacy_Decision|Binding_Corporate_Rules|Certification|Derogation|Not_Applicable`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this privacy impact assessment record.',
    CONSTRAINT pk_privacy_impact_assessment PRIMARY KEY(`privacy_impact_assessment_id`)
) COMMENT 'Master record for each Data Protection Impact Assessment (DPIA) or Privacy Impact Assessment (PIA) conducted for a new game feature, data processing activity, or third-party integration. Required under GDPR Article 35 for high-risk processing. Captures assessment title, associated game title or platform feature, processing activity description, data categories involved, assessment date, DPO reviewer, risk level (low, medium, high), identified privacy risks, mitigating controls, residual risk rating, DPO sign-off date, and supervisory authority consultation flag. Authoritative record for GDPR Article 35 compliance.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`processing_activity` (
    `processing_activity_id` BIGINT COMMENT 'Unique identifier for the data processing activity record in the Records of Processing Activities (RoPA) register maintained under GDPR Article 30.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Processing activity has legal_basis (STRING) which may be consent. Should FK to the consent_policy that governs the processing when legal basis is consent. Note: legal_basis is kept as it may have o',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: GDPR Article 30 records of processing activities must be scoped to specific games (each title processes different data categories, has different third-party integrations, different retention periods).',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Data processing activities are regulated by jurisdiction-specific privacy laws (GDPR, CCPA, COPPA, etc.). Replacing string-based regulatory_jurisdiction field with proper FK to jurisdiction master to ',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Processing activities describe data flows from licensed IP (analytics SDK, ad network, cloud save middleware). Real process: GDPR Article 30 record of processing; DPO maps activities to IP.',
    `privacy_impact_assessment_id` BIGINT COMMENT 'Reference identifier linking to the full DPIA document stored in the data protection documentation repository.',
    `parent_processing_activity_id` BIGINT COMMENT 'Self-referencing FK on processing_activity (parent_processing_activity_id)',
    `activity_code` STRING COMMENT 'Standardized code identifier for the processing activity following the format PA-[DOMAIN]-[NUMBER] (e.g., PA-PLR-0001 for player registration).. Valid values are `^PA-[A-Z]{3}-[0-9]{4}$`',
    `activity_name` STRING COMMENT 'The business-friendly name of the data processing activity (e.g., Player Registration, In-Game Analytics Collection, Marketing Campaign Management).',
    `activity_owner` STRING COMMENT 'Name or role of the individual accountable for ensuring compliance of this processing activity with data protection regulations.',
    `automated_decision_logic` STRING COMMENT 'If automated decision-making is used, this field provides meaningful information about the logic involved and the significance and envisaged consequences for the data subject.',
    `automated_decision_making_flag` BOOLEAN COMMENT 'Indicates whether the processing activity involves automated decision-making, including profiling, that produces legal or similarly significant effects.',
    `business_unit` STRING COMMENT 'The business unit or department responsible for this processing activity (e.g., Live Operations, Marketing, Player Support, Game Development).',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`third_party_processor` (
    `third_party_processor_id` BIGINT COMMENT 'Unique identifier for the third-party data processor or sub-processor record.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Processors are often licensees (cloud hosting provider, analytics vendor, payment processor). Real process: DPA execution with licensee acting as processor; compliance teams track processor relationsh',
    `parent_third_party_processor_id` BIGINT COMMENT 'Self-referencing FK on third_party_processor (parent_third_party_processor_id)',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'The total annual contract value in USD for services provided by this processor.',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or region codes where this processor handles player data (e.g., USA, GBR, DEU, JPN, KOR, AUS, BRA).',
    `audit_report_url` STRING COMMENT 'URL or document reference to the most recent audit report or security assessment for this processor.',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether the processor is contractually committed to CCPA compliance for processing California resident data.',
    `contract_end_date` DATE COMMENT 'The date on which the service contract with this processor expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'The date on which the service contract with this processor became effective.',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether the processor is certified or contractually committed to COPPA compliance for processing data of children under 13.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this processor record was first created in the system.',
    `data_breach_notification_email` STRING COMMENT 'Dedicated email address for receiving data breach notifications from this processor as required by GDPR Article 33.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_categories_shared` STRING COMMENT 'Comma-separated list of personal data categories shared with this processor (e.g., player identifiers, device IDs, gameplay telemetry, payment information, support tickets, email addresses).',
    `data_processing_location` STRING COMMENT 'Primary geographic location or region where the processor stores and processes player data (e.g., EU, USA, Asia-Pacific). Critical for GDPR transfer mechanism compliance.',
    `data_retention_period_days` STRING COMMENT 'The maximum number of days the processor retains player data as specified in the DPA.',
    `dpa_execution_date` DATE COMMENT 'The date on which the Data Processing Agreement was signed and became effective.',
    `dpa_expiry_date` DATE COMMENT 'The date on which the Data Processing Agreement expires or requires renewal. Null if the agreement is perpetual or tied to service contract.',
    `dpa_reference` STRING COMMENT 'Reference number or identifier of the executed Data Processing Agreement (DPA) or Data Processing Addendum governing the processor relationship.',
    `dpo_email` STRING COMMENT 'Email address of the Data Protection Officer at the processor organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `dpo_name` STRING COMMENT 'Full name of the Data Protection Officer at the processor organization, if designated.',
    `dsr_response_sla_hours` STRING COMMENT 'The contractual Service Level Agreement (SLA) in hours for the processor to respond to Data Subject Requests.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the processor is contractually committed to GDPR compliance for processing EU player data.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this processor record is currently active and in use for data processing operations.',
    `last_audit_date` DATE COMMENT 'The date of the most recent compliance or security audit conducted on this processor.',
    `last_due_diligence_date` DATE COMMENT 'The date of the most recent due diligence review or security assessment conducted on this processor.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next compliance or security audit of this processor.',
    `next_due_diligence_date` DATE COMMENT 'The scheduled date for the next due diligence review or security assessment of this processor.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this processor relationship, due diligence findings, or compliance considerations.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person at the processor organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the processor organization for data protection and compliance matters.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the processor organization.',
    `privacy_policy_url` STRING COMMENT 'URL to the processors public privacy policy or data protection documentation.',
    `processor_code` STRING COMMENT 'Internal unique code or identifier assigned to the processor for reference in contracts and systems.',
    `processor_name` STRING COMMENT 'The legal business name of the third-party data processor or sub-processor organization.',
    `processor_risk_rating` STRING COMMENT 'The assessed risk level of this processor based on data sensitivity, volume, jurisdictional risk, and security posture.. Valid values are `low|medium|high|critical`',
    `processor_status` STRING COMMENT 'Current lifecycle status of the processor relationship.. Valid values are `active|inactive|suspended|under_review|terminated`',
    `processor_type` STRING COMMENT 'The category of service provided by the processor. [ENUM-REF-CANDIDATE: analytics_sdk|ad_network|cloud_provider|payment_processor|customer_support_platform|marketing_automation|cdn|drm_provider|anti_cheat_service|email_service|sms_gateway|push_notification_service|crash_reporting|ab_testing_platform — promote to reference product]',
    `requires_player_consent` BOOLEAN COMMENT 'Indicates whether sharing data with this processor requires explicit player consent under applicable privacy regulations.',
    `security_certification` STRING COMMENT 'Comma-separated list of security and compliance certifications held by the processor (e.g., ISO 27001, SOC 2 Type II, PCI DSS, ISO 27018, CSA STAR).',
    `services_provided` STRING COMMENT 'Detailed description of the data processing services provided by this processor (e.g., player behavior analytics, payment processing, cloud hosting, customer support ticketing).',
    `sub_processor_list_url` STRING COMMENT 'URL to the processors publicly available or contractually provided list of sub-processors they engage to process player data.',
    `supports_data_portability` BOOLEAN COMMENT 'Indicates whether the processor can export player data in a structured, commonly used, and machine-readable format to support GDPR data portability rights.',
    `supports_dsr` BOOLEAN COMMENT 'Indicates whether the processor has technical and operational capability to support Data Subject Requests (access, erasure, portability) as required by GDPR.',
    `transfer_mechanism` STRING COMMENT 'The legal mechanism used for international data transfers to this processor (e.g., EU Adequacy Decision, Standard Contractual Clauses, Binding Corporate Rules).. Valid values are `adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this processor record was last updated in the system.',
    CONSTRAINT pk_third_party_processor PRIMARY KEY(`third_party_processor_id`)
) COMMENT 'Master record for all third-party data processors and sub-processors engaged by Gaming that handle personal data of players — analytics SDKs, ad networks, cloud providers, payment processors, customer support platforms, and marketing automation tools. Captures processor name, processor type, services provided, data categories shared, applicable jurisdictions, DPA (Data Processing Agreement) reference, DPA execution date, DPA expiry date, sub-processor list URL, security certification (ISO 27001, SOC 2), last due diligence review date, and processor risk rating. Required for GDPR Article 28 compliance and supply chain data risk management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`age_verification_event` (
    `age_verification_event_id` BIGINT COMMENT 'Unique identifier for the age verification event. Primary key.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Failed age verification or fraudulent age verification attempts may trigger compliance incidents (e.g., minor accessing age-restricted content). Should FK to compliance_incident if an incident was cre',
    `device_id` BIGINT COMMENT 'The unique device identifier (IDFA, GAID, console ID, or other platform-specific identifier) from which the verification was performed. Restricted PII as it is trackable to a person.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title context in which the age verification was triggered. Nullable if verification is account-level rather than game-specific.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Age verification requirements vary by jurisdiction (COPPA in US, GDPR in EU, etc.). Replacing string-based jurisdiction_code with proper FK to jurisdiction master to link to age_verification_required_',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Verification events are triggered by IP-specific age requirements (middleware SDK requires parental consent, licensed brand restricts under-13 access). Real process: age gate enforcement per IP terms.',
    `player_account_id` BIGINT COMMENT 'Reference to the player account undergoing age verification. Links to the player master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Age verification event is performed to satisfy regulatory obligations (COPPA, age rating requirements). Currently has regulatory_framework (STRING); should FK to regulatory_obligation for normalizatio',
    `session_id` BIGINT COMMENT 'The game session or login session identifier during which the age verification event occurred. Used for event correlation and analytics.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform (console, PC, mobile) on which the age verification event occurred.',
    `reverification_age_verification_event_id` BIGINT COMMENT 'Self-referencing FK on age_verification_event (reverification_age_verification_event_id)',
    `age_requirement` STRING COMMENT 'The minimum age required for the player to access the game or feature without parental consent, as determined by the jurisdiction and game rating (e.g., 13 for COPPA in USA, 16 for GDPR in EU, 18 for M-rated games).',
    `audit_log_reference` STRING COMMENT 'A reference identifier linking this age verification event to the broader audit log or compliance tracking system for regulatory reporting and audit trail purposes.',
    `consent_given` BOOLEAN COMMENT 'Boolean flag indicating whether the player (or parent/guardian) provided explicit consent for data processing as part of the age verification process. True if consent was given, False otherwise.',
    `consent_timestamp` TIMESTAMP COMMENT 'The date and time when consent was provided, in ISO 8601 format. Nullable if consent was not required or not given.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this age verification event record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage.',
    `date_of_birth` DATE COMMENT 'The players date of birth as provided during the verification process, in yyyy-MM-dd format. Restricted PII. Nullable if verification method did not require DOB entry.',
    `failure_reason` STRING COMMENT 'A textual description of why the age verification failed, if applicable (e.g., Player under minimum age, Invalid date of birth, Third-party service error, Parental consent not obtained). Nullable if verification passed.',
    `game_rating` STRING COMMENT 'The age rating of the game title that triggered the verification, using ESRB or PEGI classification codes (e.g., E, E10+, T, M, AO, RP for ESRB; PEGI 3, 7, 12, 16, 18 for PEGI). Determines age gate thresholds.. Valid values are `E|E10+|T|M|AO|RP|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this age verification record is currently active and valid. True if active, False if superseded or invalidated.',
    `notes` STRING COMMENT 'Free-text field for additional context, comments, or special circumstances related to the age verification event (e.g., manual review notes, customer support escalation details).',
    `parental_consent_token` STRING COMMENT 'A unique token or reference identifier linking to the parental consent record, if parental consent was required and obtained. Nullable if not applicable.',
    `player_declared_age` STRING COMMENT 'The age declared by the player at the time of verification, calculated from the date of birth provided or stated directly. Nullable if age was not explicitly declared.',
    `retry_count` STRING COMMENT 'The number of times the player has attempted age verification for this specific trigger or session. Used to detect fraud or user experience issues.',
    `third_party_provider` STRING COMMENT 'The name of the third-party age verification service provider used, if applicable (e.g., Yoti, Jumio, Veriff). Nullable if verification was performed in-house.',
    `third_party_transaction_reference` STRING COMMENT 'The transaction or session identifier provided by the third-party age verification service for audit and reconciliation purposes. Nullable if not applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this age verification event record was last modified in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and change tracking.',
    `verification_channel` STRING COMMENT 'The channel or interface through which the age verification was performed (e.g., in-game, web portal, mobile app, customer support, email, SMS).. Valid values are `in_game|web_portal|mobile_app|customer_support|email|sms`',
    `verification_expiry_date` DATE COMMENT 'The date on which the age verification expires and must be re-verified, in yyyy-MM-dd format. Nullable if verification does not expire.',
    `verification_ip_address` STRING COMMENT 'The IP address from which the age verification event was initiated. Used for fraud detection and jurisdiction determination. Confidential PII in some jurisdictions.',
    `verification_method` STRING COMMENT 'The method used to verify the players age. Enumeration includes date-of-birth entry, credit card verification, parental consent form submission, third-party age verification service, government ID verification, or biometric verification.. Valid values are `date_of_birth_entry|credit_card_verification|parental_consent_form|third_party_age_verification_service|government_id_verification|biometric_verification`',
    `verification_outcome` STRING COMMENT 'The result of the age verification attempt. Passed indicates the player met age requirements; failed indicates they did not; pending_parental_consent indicates parental approval is required; under_review indicates manual review is in progress; expired indicates a previously valid verification has lapsed.. Valid values are `passed|failed|pending_parental_consent|under_review|expired`',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the age verification event was performed, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). This is the principal business event timestamp.',
    `verification_trigger` STRING COMMENT 'The event or action that triggered the age verification requirement. Examples include account creation, game launch, in-game purchase attempt, loot box access, mature content access, chat feature access, UGC submission, or periodic revalidation. [ENUM-REF-CANDIDATE: account_creation|game_launch|in_game_purchase|loot_box_access|mature_content_access|chat_feature_access|ugc_submission|periodic_revalidation — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_age_verification_event PRIMARY KEY(`age_verification_event_id`)
) COMMENT 'Transactional record of each age verification or parental consent verification event performed for a player account, required for COPPA compliance (under-13 US players), GDPR Article 8 (under-16 EU players), and jurisdiction-specific age gate requirements for M/18+ rated games. Captures player account reference, verification method (date-of-birth entry, credit card verification, parental consent form, third-party age verification service), verification timestamp, verification outcome (passed, failed, pending parental consent), jurisdiction, game title context, and parental consent token reference where applicable.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` (
    `sanctions_screening_result_id` BIGINT COMMENT 'Unique identifier for the sanctions screening result record.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Positive sanctions screening results (matches against restricted party lists) may trigger compliance incidents. Should FK to compliance_incident if an incident was created as a result of the screening',
    `employee_id` BIGINT COMMENT 'Reference to the compliance officer or analyst who reviewed the screening result and made the disposition decision.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Sanctions screening requirements vary by jurisdiction (OFAC in US, EU sanctions lists, etc.). Replacing string-based jurisdiction field with proper FK to jurisdiction master to link to applicable regu',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Screening checks licensees against sanctions lists (export control, OFAC). Real process: KYC and ongoing monitoring of business partners; compliance teams flag high-risk licensees.',
    `payment_instrument_id` BIGINT COMMENT 'Reference to the payment instrument that was screened, if applicable.',
    `player_account_id` BIGINT COMMENT 'Reference to the player account that was screened.',
    `rescreening_sanctions_screening_result_id` BIGINT COMMENT 'Self-referencing FK on sanctions_screening_result (rescreening_sanctions_screening_result_id)',
    `applicable_regulations` STRING COMMENT 'Comma-separated list of regulations and compliance frameworks applicable to this screening (e.g., OFAC, EU Sanctions, UN Sanctions, AML, CFT, EAR, ITAR).',
    `counterparty_reference` BIGINT COMMENT 'Reference to the business counterparty (vendor, partner, licensee) that was screened, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sanctions screening result record was first created in the system.',
    `determination_date` DATE COMMENT 'Date when the final disposition decision was made and documented.',
    `disposition` STRING COMMENT 'Final disposition or action taken based on the screening result.. Valid values are `cleared|blocked|escalated|under_review|pending_documentation`',
    `disposition_reason` STRING COMMENT 'Explanation or justification for the disposition decision, including any mitigating factors or additional evidence reviewed.',
    `documentation_url` STRING COMMENT 'URL or file path to supporting documentation, evidence, or audit trail related to this screening result.',
    `escalation_level` STRING COMMENT 'Level to which the screening result was escalated for review and decision-making.. Valid values are `none|tier_1|tier_2|senior_management|legal_counsel|executive`',
    `export_control_flag` BOOLEAN COMMENT 'Flag indicating whether this screening was performed for export control compliance purposes related to game engine technology or other controlled exports.',
    `export_license_required` BOOLEAN COMMENT 'Flag indicating whether an export license is required for the transaction or relationship based on the screening result.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this screening result record is currently active and relevant for compliance monitoring.',
    `match_details` STRING COMMENT 'Detailed information about the match including matched list name, matched entity name, match criteria, and any aliases or identifiers that triggered the match.',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0-100) indicating the likelihood that the screened entity matches a sanctioned party, as calculated by the screening system.',
    `match_status` STRING COMMENT 'Result of the sanctions screening indicating whether the entity matched any sanctions list entries.. Valid values are `no_match|potential_match|confirmed_match|false_positive`',
    `matched_entity_name` STRING COMMENT 'Name of the sanctioned entity from the list that matched the screened entity.',
    `matched_list_name` STRING COMMENT 'Name of the specific sanctions or restricted party list on which a match was found.',
    `notes` STRING COMMENT 'Additional notes, comments, or context provided by the reviewing officer or compliance team regarding this screening result.',
    `requires_sar_filing` BOOLEAN COMMENT 'Flag indicating whether this screening result requires filing a Suspicious Activity Report with financial authorities.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance officer completed their review of the screening result.',
    `reviewing_officer_name` STRING COMMENT 'Name of the compliance officer who reviewed and adjudicated the screening result.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this screening result based on match quality, entity profile, and jurisdictional factors.. Valid values are `low|medium|high|critical`',
    `sar_filing_date` DATE COMMENT 'Date when the Suspicious Activity Report was filed with the appropriate financial authority, if applicable.',
    `sar_reference_number` STRING COMMENT 'Reference number assigned to the filed Suspicious Activity Report by the financial authority.',
    `screened_entity_country` STRING COMMENT 'Three-letter ISO country code representing the country of residence or registration of the screened entity.. Valid values are `^[A-Z]{3}$`',
    `screened_entity_identifier` STRING COMMENT 'Unique identifier of the screened entity such as national ID, passport number, tax ID, or business registration number.',
    `screened_entity_name` STRING COMMENT 'Name of the entity (individual or organization) that was screened against sanctions lists.',
    `screened_entity_type` STRING COMMENT 'Type of entity that was subjected to sanctions screening.. Valid values are `player_account|payment_instrument|counterparty|business_entity|individual`',
    `screening_lists_checked` STRING COMMENT 'Comma-separated list of sanctions and restricted party lists checked during this screening (e.g., OFAC SDN, EU Consolidated Sanctions List, UN Security Council Sanctions, EAR, ITAR).',
    `screening_method` STRING COMMENT 'Method used to perform the screening check.. Valid values are `automated|manual|hybrid`',
    `screening_provider` STRING COMMENT 'Name of the third-party screening service or internal system that performed the sanctions check.',
    `screening_reference_number` STRING COMMENT 'External reference number or case identifier assigned by the screening system or compliance platform.',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time when the sanctions screening check was performed.',
    `screening_trigger` STRING COMMENT 'Event or action that triggered the sanctions screening check (e.g., new account registration, payment processing, counterparty onboarding, periodic review).',
    `transaction_reference` STRING COMMENT 'Reference to the specific transaction or business event that prompted the screening, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this sanctions screening result record was last modified.',
    CONSTRAINT pk_sanctions_screening_result PRIMARY KEY(`sanctions_screening_result_id`)
) COMMENT 'Transactional record of each sanctions and restricted party screening check performed against player accounts, payment instruments, or business counterparties. Covers OFAC SDN list, EU Consolidated Sanctions List, UN Security Council sanctions, and export control screening (EAR/ITAR for game engine technology exports). Captures screened entity reference, screening date, screening list(s) checked, match status (no match, potential match, confirmed match), match details, disposition (cleared, blocked, escalated), reviewing compliance officer, and final determination date. Required for AML/CFT compliance and export control obligations.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`spend_limit_control` (
    `spend_limit_control_id` BIGINT COMMENT 'Unique identifier for the spend limit control record.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Spend limits can be title-specific (per-game spending caps for minors, title-specific regulatory requirements). Essential for title-level monetization controls, youth protection compliance, and regula',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Spending limit controls are mandated by jurisdiction-specific gambling and consumer protection regulations. Replacing string-based jurisdiction_code with proper FK to jurisdiction master to link to re',
    `player_account_id` BIGINT COMMENT 'Reference to the player account subject to this spending limit control.',
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
    `regulatory_directive_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_directive. Business justification: Internal policies are often created in response to regulatory directives. Should FK to the regulatory_directive that mandates the policy. Currently has regulatory_framework_reference (STRING); should ',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor who completed the training module.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance training costs (GDPR, COPPA, age rating, loot box disclosure training) are allocated to cost centers for budget tracking. Gaming companies track training spend per studio/department for com',
    `training_module_id` BIGINT COMMENT 'Reference to the specific compliance training module completed.',
    `retake_training_completion_id` BIGINT COMMENT 'Self-referencing FK on training_completion (retake_training_completion_id)',
    `applicable_jurisdiction_codes` STRING COMMENT 'Comma-separated list of jurisdiction codes where this training compliance is applicable (e.g., USA, GBR, DEU, FRA).',
    `assessment_max_score` DECIMAL(18,2) COMMENT 'Maximum possible score for the training assessment (typically 100).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved on the training assessment (e.g., 85.50 out of 100).',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this training module (1 for first attempt, 2 for second, etc.).',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this completion record to the audit trail or compliance evidence repository for regulatory inspection.',
    `certificate_issued_date` DATE COMMENT 'Date when the completion certificate was issued to the employee.',
    `certificate_reference` STRING COMMENT 'Unique reference number or identifier for the completion certificate issued to the employee.',
    `certificate_url` STRING COMMENT 'URL or file path to the digital certificate document stored in the document management system.',
    `completion_date` DATE COMMENT 'Date when the employee or contractor successfully completed the training module.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the training module was completed, including time zone information.',
    `compliance_status` STRING COMMENT 'Current compliance status of the employee for this training requirement (compliant, non-compliant, overdue, pending renewal, waived).. Valid values are `compliant|non_compliant|overdue|pending_renewal|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the system.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this training is mandatory (true) or optional (false) for the employee based on their role and jurisdiction.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the employee must complete the next renewal of this training module. Null if no renewal required.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the training completion, special circumstances, or follow-up actions required.',
    `pass_fail_status` STRING COMMENT 'Outcome of the training assessment indicating whether the employee passed, failed, did not complete, or was waived from the requirement.. Valid values are `pass|fail|incomplete|waived`',
    `passing_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment (e.g., 80.00).',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or legislation that this training addresses (e.g., GDPR, COPPA, FCPA, UK Bribery Act, OFAC Sanctions).',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals for this training module (e.g., 12 for annual, 24 for biennial). Null if no renewal required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this training requires periodic renewal (true) or is a one-time completion (false).',
    `role_requirement` STRING COMMENT 'Job role or function for which this training is required (e.g., All Employees, Game Developers, Marketing, Customer Support, Finance).',
    `training_category` STRING COMMENT 'Category of compliance training (data privacy, child protection, anti-bribery, sanctions, responsible gaming, loot box regulation, other). [ENUM-REF-CANDIDATE: data_privacy|child_protection|anti_bribery|sanctions|responsible_gaming|loot_box_regulation|other — 7 candidates stripped; promote to reference product]',
    `training_delivery_method` STRING COMMENT 'Method by which the training was delivered (online, instructor-led, blended, self-paced, webinar, workshop).. Valid values are `online|instructor_led|blended|self_paced|webinar|workshop`',
    `training_duration_minutes` STRING COMMENT 'Total time in minutes spent by the employee completing the training module.',
    `training_module_name` STRING COMMENT 'Name of the compliance training module (e.g., GDPR Awareness, COPPA Handling, Anti-Bribery FCPA/UK Bribery Act, Sanctions Compliance, Responsible Gaming, Loot Box Regulatory Training).',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that provided the training content (internal or external provider).',
    `training_version` STRING COMMENT 'Version identifier of the training module content completed (e.g., v2.1, 2024-Q1).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last modified in the system.',
    `waiver_approval_date` DATE COMMENT 'Date when the training waiver was approved. Null if not waived.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the compliance officer or manager who approved the training waiver. Null if not waived.',
    `waiver_reason` STRING COMMENT 'Explanation for why the training requirement was waived for this employee (e.g., prior certification, role exemption). Null if not waived.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Transactional record of each employee or contractor completion of a mandatory compliance training module — GDPR awareness, COPPA handling, anti-bribery (FCPA/UK Bribery Act), sanctions compliance, responsible gaming, and loot box regulatory training. Captures employee/contractor reference, training module name, training version, completion date, assessment score, pass/fail status, certificate reference, and next renewal due date. Required for demonstrating compliance culture and due diligence to regulators. Distinct from workforce.learning_enrollment (which covers all learning broadly) — this is the compliance domains authoritative record of mandatory regulatory training completion.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance analyst or team member responsible for managing the response to this regulatory change.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory changes (new loot box laws, GDPR updates, age rating changes) have estimated implementation costs and effort hours that must be allocated to cost centers for budgeting. Gaming companies tra',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Regulatory changes may require agreement amendments (new loot box law, updated age rating criteria, GDPR updates). Real process: change impact assessment reviews active contracts; legal teams identify',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Regulatory changes are issued by jurisdiction-specific authorities. Replacing string-based jurisdiction_code with proper FK to jurisdiction master to link to issuing_authority, regulatory framework, a',
    `regulatory_directive_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_directive. Business justification: Regulatory change tracks incoming regulatory changes and new legislation. Should FK to the regulatory_directive that represents the new or updated directive. Currently has regulation_name and issuing_',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Regulatory changes often require policy updates. Should FK to the policy that was updated or created in response to the regulatory change. Nullable until policy update is completed.',
    `superseded_regulatory_change_id` BIGINT COMMENT 'Self-referencing FK on regulatory_change (superseded_regulatory_change_id)',
    `affected_compliance_domain_advertising` BOOLEAN COMMENT 'Flag indicating whether the regulatory change impacts advertising standards, marketing practices, or promotional content requirements.',
    `affected_compliance_domain_age_rating` BOOLEAN COMMENT 'Flag indicating whether the regulatory change impacts age rating certification, content descriptors, or rating authority requirements.',
    `affected_compliance_domain_coppa` BOOLEAN COMMENT 'Flag indicating whether the regulatory change impacts COPPA compliance or childrens privacy protection requirements.',
    `affected_compliance_domain_esports_betting` BOOLEAN COMMENT 'Flag indicating whether the regulatory change impacts esports betting, gambling regulations, or wagering compliance.',
    `affected_compliance_domain_gdpr` BOOLEAN COMMENT 'Flag indicating whether the regulatory change impacts GDPR compliance, data subject rights, or data protection obligations.',
    `affected_compliance_domain_loot_box` BOOLEAN COMMENT 'Flag indicating whether the regulatory change impacts loot box mechanics, probability disclosure, or monetization practices.',
    `affected_compliance_domain_payment` BOOLEAN COMMENT 'Flag indicating whether the regulatory change impacts payment processing, PCI DSS compliance, or financial transaction requirements.',
    `affected_game_titles` STRING COMMENT 'Comma-separated list of specific game titles or franchises impacted by the regulatory change, or all if applicable to entire portfolio.',
    `affected_platforms` STRING COMMENT 'Comma-separated list of gaming platforms affected by the regulatory change (e.g., console, PC, mobile, web).',
    `change_reference_number` STRING COMMENT 'External reference number or identifier assigned by the issuing authority or internal tracking system for this regulatory change.',
    `change_type` STRING COMMENT 'Classification of the regulatory change indicating whether it is a new law, an amendment to existing regulation, updated guidance, enforcement action, repeal, or consultation.. Valid values are `new_law|amendment|guidance_update|enforcement_action|repeal|consultation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory change record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the regulatory change becomes legally binding and enforceable.',
    `escalation_date` DATE COMMENT 'Date when the regulatory change was escalated to senior management or executive leadership.',
    `escalation_required` BOOLEAN COMMENT 'Flag indicating whether the regulatory change requires escalation to executive leadership or board-level review due to materiality or strategic impact.',
    `estimated_implementation_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost in USD to implement the changes required to comply with the new regulation, including development, legal, and operational expenses.',
    `estimated_implementation_effort_hours` DECIMAL(18,2) COMMENT 'Estimated total effort in person-hours required to implement compliance changes across all affected teams and systems.',
    `impact_assessment_summary` STRING COMMENT 'High-level summary of the business impact of the regulatory change, including affected operations, systems, and processes.',
    `implementation_deadline` DATE COMMENT 'Internal or mandated deadline by which Gaming must complete implementation of changes required to comply with the new regulation.',
    `internal_documentation_url` STRING COMMENT 'URL or document repository link to internal impact assessment, response plan, or implementation documentation.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether the regulatory change record is currently active and relevant for ongoing compliance monitoring.',
    `legal_review_completion_date` DATE COMMENT 'Date when legal review of the regulatory change was completed and opinion provided.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which compliance with the regulatory change is monitored and reviewed after implementation.. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of compliance status and effectiveness of implemented changes.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context regarding the regulatory change, its interpretation, or implementation considerations.',
    `player_notification_date` DATE COMMENT 'Date when players were notified of changes resulting from the regulatory change.',
    `publication_date` DATE COMMENT 'Date when the regulatory change was officially published or announced by the issuing authority.',
    `regulatory_document_url` STRING COMMENT 'URL or document repository link to the official regulatory text, guidance document, or announcement.',
    `requires_legal_review` BOOLEAN COMMENT 'Flag indicating whether the regulatory change requires formal legal review and opinion before implementation.',
    `requires_player_notification` BOOLEAN COMMENT 'Flag indicating whether the regulatory change requires direct notification or communication to players (e.g., updated terms of service, privacy policy changes).',
    `requires_policy_update` BOOLEAN COMMENT 'Flag indicating whether the regulatory change requires updates to internal policies, procedures, or governance documentation.',
    `requires_system_changes` BOOLEAN COMMENT 'Flag indicating whether the regulatory change requires modifications to game engines, platforms, or operational systems.',
    `response_plan_status` STRING COMMENT 'Current status of the internal response plan to address the regulatory change.. Valid values are `not_started|in_progress|under_review|approved|implemented|closed`',
    `risk_level` STRING COMMENT 'Assessed risk level of non-compliance with the regulatory change, based on potential financial, reputational, and operational impact.. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory change record was last modified or updated.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Master record tracking incoming regulatory changes, new legislation, and updated guidance that may impact Gamings compliance posture across jurisdictions. Captures regulation name, issuing authority, jurisdiction, change type (new law, amendment, guidance update, enforcement action), publication date, effective date, impact assessment summary, affected compliance domains (loot box, GDPR, age rating, esports betting), assigned compliance analyst, response plan status, and implementation deadline. Enables proactive compliance horizon scanning and regulatory change management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`processor_engagement` (
    `processor_engagement_id` BIGINT COMMENT 'Unique identifier for this processor engagement record',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to the processing activity for which this processor is engaged',
    `third_party_processor_id` BIGINT COMMENT 'Foreign key linking to the third-party processor engaged for this processing activity',
    `contract_end_date` DATE COMMENT 'The date on which this processor engagement for this processing activity is scheduled to end or was terminated. Null indicates ongoing engagement.',
    `contract_start_date` DATE COMMENT 'The date on which this processor engagement for this processing activity became active and the processor began handling personal data under the specified terms.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this processor engagement record was created in the system.',
    `data_categories_shared` STRING COMMENT 'Comma-separated list of specific personal data categories shared with this processor for this processing activity (e.g., player_email, payment_card_data, gameplay_telemetry). This is activity-specific and may be a subset of what the processor handles across all activities.',
    `data_transfer_mechanism` STRING COMMENT 'The legal mechanism used to safeguard international data transfers for this specific processor engagement (e.g., EU Commission Adequacy Decision, Standard Contractual Clauses 2021, Binding Corporate Rules). May differ from processors general transfer mechanism based on activity-specific data flows.',
    `data_volume_estimate` STRING COMMENT 'Estimated volume or scale of personal data shared with this processor for this processing activity (e.g., 1M player records monthly, 500GB telemetry data daily). Used for risk assessment.',
    `dpa_execution_date` DATE COMMENT 'The date on which the Data Processing Agreement or activity-specific addendum for this engagement was executed and became effective.',
    `dpa_reference` STRING COMMENT 'Reference number of the specific Data Processing Agreement or DPA amendment governing this processor engagement for this processing activity. May reference activity-specific addenda to master DPA.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of this specific processor engagement for this processing activity.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this processor engagement record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this processor engagement record.',
    `last_review_date` DATE COMMENT 'The date of the most recent compliance review of this processor engagement for this processing activity, conducted by the Data Protection Officer or compliance team.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next compliance review of this processor engagement for this processing activity.',
    `processing_purpose` STRING COMMENT 'The specific purpose for which this processor is engaged for this processing activity (e.g., payment processing for player registration, analytics for gameplay optimization). Defines the scope of processing instructions.',
    `third_party_processors` STRING COMMENT 'Comma-separated list of named third-party processors engaged for this processing activity (e.g., AWS, Google Cloud Platform, Unity Analytics, AppsFlyer). [Moved from processing_activity: This STRING attribute in processing_activity contains a comma-separated list of processor names, which is a denormalized representation of the M:N relationship. With the processor_engagement association table, this attribute becomes redundant and should be removed to eliminate data duplication and maintain referential integrity through proper foreign keys.]',
    `created_by` STRING COMMENT 'User ID or name of the Data Protection Officer or compliance team member who created this processor engagement record.',
    CONSTRAINT pk_processor_engagement PRIMARY KEY(`processor_engagement_id`)
) COMMENT 'This association product represents the Contract between processing_activity and third_party_processor. It captures the specific engagement of a third-party processor to handle personal data for a particular processing activity under GDPR Article 28 compliance requirements. Each record links one processing_activity to one third_party_processor with activity-specific data sharing scope, legal safeguards, and contractual terms that exist only in the context of this specific engagement.. Existence Justification: In GDPR compliance operations, privacy teams actively manage a matrix of processing activities and the third-party processors engaged to support each activity. A single processing activity (e.g., player registration) typically involves multiple processors (payment gateway, email service, analytics SDK), and each processor is engaged across multiple processing activities. The Data Protection Officer maintains activity-specific DPAs, data sharing scopes, and contractual terms for each engagement, which are reviewed during regulatory inspections.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`policy_applicability` (
    `policy_applicability_id` BIGINT COMMENT 'Unique identifier for this policy-jurisdiction applicability record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to the jurisdiction where this policy applies',
    `policy_id` BIGINT COMMENT 'Foreign key linking to the compliance policy being applied in this jurisdiction',
    `applicable_territories` STRING COMMENT 'Comma-separated list of jurisdiction codes or territory names where this policy is enforceable (e.g., USA, GBR, DEU, JPN, Global). [Moved from compliance_policy: This comma-separated list of jurisdiction codes in compliance_policy is a denormalized representation of the many-to-many relationship. With the policy_applicability association, this becomes redundant and should be derived via join rather than stored as a text list.]',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which compliance with this policy must be audited specifically for this jurisdiction. May differ from global review cycle based on local regulatory requirements.',
    `effective_date` DATE COMMENT 'Date when this policy becomes enforceable in this specific jurisdiction. May differ from the global policy effective date due to local approval timelines or regulatory requirements.',
    `enforcement_status` STRING COMMENT 'Current enforcement status of this policy in this jurisdiction. Values: active (fully enforced), pending (approved but not yet effective), suspended (temporarily not enforced), exempt (jurisdiction exempt from this policy), under_review (applicability being reassessed).',
    `expiration_date` DATE COMMENT 'Date when this policy ceases to apply in this jurisdiction, typically when superseded by a new version or when operations cease in the jurisdiction.',
    `jurisdiction_specific_addendum_url` STRING COMMENT 'URL or document reference to any jurisdiction-specific addendum, local language translation, or regulatory variation of the policy required for this jurisdiction.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit for this policy in this jurisdiction.',
    `local_approval_authority` STRING COMMENT 'Name or role of the local legal or compliance authority who approved this policy for deployment in this jurisdiction (e.g., EU Data Protection Officer, APAC General Counsel).',
    `local_approval_date` DATE COMMENT 'Date when this policy was approved by local legal counsel or regional compliance authority for use in this jurisdiction.',
    `local_regulatory_reference` STRING COMMENT 'Citation of the specific local law, regulation, or regulatory guidance that mandates or influences this policy in this jurisdiction (e.g., California CCPA, German JMStV, Chinese PIPL).',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this policy is legally mandatory in this jurisdiction (true) or represents voluntary best practice (false). Drives audit priority and enforcement rigor.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit of this policy in this jurisdiction.',
    `notes` STRING COMMENT 'Free-text field for jurisdiction-specific implementation notes, exceptions, or special considerations for this policy applicability.',
    CONSTRAINT pk_policy_applicability PRIMARY KEY(`policy_applicability_id`)
) COMMENT 'This association product represents the jurisdictional applicability of compliance policies within Gamings regulatory compliance framework. It captures which compliance policies apply in which jurisdictions, with jurisdiction-specific effective dates, local approval requirements, enforcement status, and any local regulatory addenda. Each record links one compliance_policy to one jurisdiction with attributes that exist only in the context of this jurisdictional deployment.. Existence Justification: Gamings compliance team actively manages a matrix of compliance policies and jurisdictions, tracking which policies apply where with jurisdiction-specific effective dates, local approval processes, and enforcement statuses. A single compliance policy (e.g., Data Protection Policy) applies across multiple jurisdictions (EU, California, Japan), and each jurisdiction is governed by multiple compliance policies (GDPR compliance, loot box disclosure, age rating compliance). This is an operational relationship that compliance officers create, update, and audit as part of regulatory compliance management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`obligation_applicability` (
    `obligation_applicability_id` BIGINT COMMENT 'Unique identifier for this obligation-jurisdiction applicability record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to the jurisdiction where this obligation applies',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Obligation_applicability maps regulatory_obligation to jurisdiction, but should also reference the regulatory_authority that enforces the obligation in that jurisdiction. This enables tracking which a',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation that applies in this jurisdiction',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this obligation-jurisdiction mapping is currently active and being monitored. FALSE if the obligation no longer applies in this jurisdiction or monitoring has been suspended.',
    `applicable_territories` STRING COMMENT 'Comma-separated list of ISO 3-letter country codes or regional identifiers where this obligation applies (e.g., USA, GBR, DEU, FRA, JPN, KOR, EU-MEMBER-STATES). [Moved from regulatory_obligation: This comma-separated list of territories in regulatory_obligation is a denormalized representation of the M:N relationship. The proper model is to have individual obligation_applicability records for each jurisdiction, eliminating the need for this comma-separated field. Each jurisdiction relationship should be a separate record with its own attributes.]',
    `compliance_status` STRING COMMENT 'Current compliance status for this obligation in this jurisdiction. Gaming may be compliant in some jurisdictions but not others for the same obligation. Values: Compliant, Non-Compliant, In Progress, Not Applicable, Under Review.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this obligation-jurisdiction applicability record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this regulatory obligation became enforceable in this specific jurisdiction. May differ from the obligations global effective date due to local implementation timelines.',
    `enforcement_priority` STRING COMMENT 'Priority level for enforcement of this obligation in this jurisdiction, reflecting local regulatory focus and risk assessment. Values: Critical, High, Medium, Low.',
    `expiration_date` DATE COMMENT 'Date when this regulatory obligation ceases to apply in this specific jurisdiction. NULL if the obligation remains active indefinitely in this jurisdiction.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit for this specific obligation in this specific jurisdiction. Tracks jurisdiction-specific audit history.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this obligation-jurisdiction applicability record was last updated.',
    `local_compliance_owner` STRING COMMENT 'Name or identifier of the individual or team responsible for ensuring compliance with this obligation in this specific jurisdiction. May be a regional compliance manager.',
    `local_interpretation_notes` STRING COMMENT 'Free-text notes capturing jurisdiction-specific interpretation, implementation guidance, or local nuances in how this obligation is enforced or applied in this jurisdiction.',
    `local_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty amount in local currency for non-compliance with this obligation in this jurisdiction. May differ from the global maximum penalty due to local enforcement practices.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this obligation in this jurisdiction.',
    CONSTRAINT pk_obligation_applicability PRIMARY KEY(`obligation_applicability_id`)
) COMMENT 'This association product represents the jurisdictional applicability mapping between regulatory obligations and jurisdictions. It captures which regulatory obligations apply in which jurisdictions, with jurisdiction-specific enforcement details, compliance tracking, and local interpretation guidance. Each record links one regulatory obligation to one jurisdiction with attributes that exist only in the context of this specific obligation-jurisdiction pairing.. Existence Justification: This is a genuine operational M:N relationship representing the compliance applicability matrix that gaming companies actively manage. One regulatory obligation (e.g., GDPR Article 17 Right to Erasure) applies in multiple jurisdictions (EU member states, UK, California via CCPA), and one jurisdiction (e.g., Germany) has multiple regulatory obligations applicable to it (GDPR, USK rating requirements, loot box disclosure laws, digital goods VAT). Compliance teams maintain this matrix with jurisdiction-specific effective dates, enforcement priorities, local interpretations, and compliance statuses.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`data_subject_request` (
    `data_subject_request_id` BIGINT COMMENT 'Primary key for data_subject_request',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance team member or data protection officer assigned to process this data subject request.',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who submitted the data subject request.',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Data subject request fulfillment requires identifying which processing activities are affected by the request (e.g., erasure request must identify all processing activities handling the subjects data',
    `original_data_subject_request_id` BIGINT COMMENT 'Self-referencing FK on data_subject_request (original_data_subject_request_id)',
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
    `jurisdiction_code` STRING COMMENT 'ISO 3166 country or region code representing the jurisdiction under which this data subject request is being processed (e.g., DEU for Germany GDPR, USA-CA for California CCPA, GBR for UK GDPR).',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`regulatory_authority` (
    `regulatory_authority_id` BIGINT COMMENT 'Primary key for regulatory_authority',
    `parent_authority_id` BIGINT COMMENT 'Reference to the parent or superior regulatory authority if this authority operates under a hierarchical structure.',
    `parent_regulatory_authority_id` BIGINT COMMENT 'Self-referencing FK on regulatory_authority (parent_regulatory_authority_id)',
    `age_rating_system` STRING COMMENT 'Name of the age rating or content classification system administered by this authority (e.g., ESRB, PEGI, USK, CERO).',
    `audit_frequency` STRING COMMENT 'Standard frequency at which this authority conducts compliance audits of gaming operations.',
    `authority_code` STRING COMMENT 'Unique business identifier or abbreviation code for the regulatory authority used in external communications and filings.',
    `authority_name` STRING COMMENT 'Official legal name of the regulatory authority or governing body.',
    `authority_status` STRING COMMENT 'Current operational status of the regulatory authority in its lifecycle.',
    `authority_type` STRING COMMENT 'Classification of the regulatory authority by jurisdictional scope and governance level.',
    `breach_notification_sla_hours` STRING COMMENT 'Maximum number of hours allowed to notify this authority of a data breach incident.',
    `certification_fee_amount` DECIMAL(18,2) COMMENT 'Standard fee charged by the authority for game certification or age rating review.',
    `certification_fee_currency` STRING COMMENT 'Three-letter ISO currency code for certification fees charged by this authority.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether games must obtain formal certification or approval from this authority before publication in the jurisdiction.',
    `contact_address_line1` STRING COMMENT 'First line of the physical mailing address for the regulatory authority headquarters.',
    `contact_address_line2` STRING COMMENT 'Second line of the physical mailing address for the regulatory authority headquarters.',
    `contact_city` STRING COMMENT 'City where the regulatory authority headquarters is located.',
    `contact_country_code` STRING COMMENT 'Three-letter ISO country code for the regulatory authority headquarters location.',
    `contact_email` STRING COMMENT 'Primary email address for official correspondence and compliance inquiries with the regulatory authority.',
    `contact_phone` STRING COMMENT 'Primary telephone number for contacting the regulatory authority for compliance matters.',
    `contact_postal_code` STRING COMMENT 'Postal or ZIP code for the regulatory authority headquarters address.',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether this authority enforces COPPA requirements for protection of childrens data in gaming.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory authority record was first created in the system.',
    `data_subject_request_sla_days` STRING COMMENT 'Maximum number of days allowed to respond to data subject access requests under this authoritys regulations.',
    `dissolved_date` DATE COMMENT 'Date when the regulatory authority was dissolved, merged, or ceased operations. Null if still active.',
    `esports_oversight` BOOLEAN COMMENT 'Indicates whether this authority has regulatory oversight over esports competitions and leagues.',
    `established_date` DATE COMMENT 'Date when the regulatory authority was officially established or chartered.',
    `filing_deadline_days` STRING COMMENT 'Number of days after period end by which compliance filings must be submitted to this authority.',
    `gambling_regulation_scope` STRING COMMENT 'Extent to which this authority regulates gambling-like mechanics and real-money gaming activities.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this authority enforces GDPR data protection requirements for gaming operations.',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country jurisdiction of the regulatory authority.',
    `jurisdiction_region` STRING COMMENT 'State, province, or regional subdivision within the country where the authority has jurisdiction.',
    `loot_box_disclosure_required` BOOLEAN COMMENT 'Indicates whether this regulatory authority mandates disclosure of loot box probabilities and mechanics.',
    `notes` STRING COMMENT 'Additional notes, special requirements, or contextual information about this regulatory authority and its compliance expectations.',
    `official_website_url` STRING COMMENT 'Primary web address for the regulatory authoritys official website and public information portal.',
    `penalty_enforcement_level` STRING COMMENT 'Relative severity and enforcement rigor of penalties imposed by this authority for non-compliance.',
    `primary_contact_name` STRING COMMENT 'Name of the primary liaison or contact person at the regulatory authority for compliance matters.',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the regulatory authority.',
    `regulatory_domain` STRING COMMENT 'Primary area of regulatory oversight and compliance focus for gaming operations.',
    `reporting_frequency` STRING COMMENT 'Standard frequency at which compliance reports must be submitted to this regulatory authority.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified this regulatory authority record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory authority record was last modified in the system.',
    `created_by` STRING COMMENT 'User identifier of the person who created this regulatory authority record.',
    CONSTRAINT pk_regulatory_authority PRIMARY KEY(`regulatory_authority_id`)
) COMMENT 'Master reference table for regulatory_authority. Referenced by regulatory_authority_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`regulatory_directive` (
    `regulatory_directive_id` BIGINT COMMENT 'Primary key for regulatory_directive',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Regulatory directives are issued by regulatory authorities. Should FK to the regulatory_authority that issued the directive. Currently has issuing_authority (STRING); should normalize to FK.',
    `superseded_by_directive_id` BIGINT COMMENT 'Reference to the regulatory_directive_id of the newer directive that supersedes this one, if applicable. Null if this directive is still current or has been repealed without replacement.',
    `superseded_regulatory_directive_id` BIGINT COMMENT 'Self-referencing FK on regulatory_directive (superseded_regulatory_directive_id)',
    `age_verification_required_flag` BOOLEAN COMMENT 'Indicates whether this directive mandates age verification mechanisms for players (True) or not (False), common for COPPA, age-gated content, and gambling-adjacent mechanics.',
    `applicability_scope` STRING COMMENT 'Defines which gaming products or platforms are subject to this directive (all games, mobile only, console only, PC only, online multiplayer only, specific genres, or games with specific age ratings).',
    `audit_frequency` STRING COMMENT 'Required or recommended frequency for internal compliance audits against this directive (annual, semi-annual, quarterly, monthly, ad-hoc, or continuous monitoring).',
    `compliance_deadline` DATE COMMENT 'Date by which the organization must achieve full compliance with the directive requirements. May differ from effective_date to allow implementation grace period. Format: yyyy-MM-dd.',
    `compliance_owner_email` STRING COMMENT 'Corporate email address of the compliance owner for this directive, used for internal coordination and audit inquiries.',
    `compliance_owner_name` STRING COMMENT 'Full name of the individual designated as the compliance owner or subject matter expert for this directive within the organization.',
    `compliance_priority` STRING COMMENT 'Business priority level assigned to compliance with this directive based on risk exposure, penalty severity, and business impact (critical, high, medium, low).',
    `compliance_status` STRING COMMENT 'Current organizational compliance status with this directive (compliant, non-compliant, partially compliant, under remediation, or not yet assessed).',
    `content_rating_required_flag` BOOLEAN COMMENT 'Indicates whether this directive mandates obtaining an age/content rating from a classification board (e.g., ESRB, PEGI, USK) before distribution (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory directive record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_localization_required_flag` BOOLEAN COMMENT 'Indicates whether this directive mandates that player data must be stored or processed within the jurisdictions borders (True) or not (False).',
    `data_subject_rights_flag` BOOLEAN COMMENT 'Indicates whether this directive grants specific rights to data subjects (e.g., GDPR right to access, right to erasure, COPPA parental consent) that must be operationalized (True) or not (False).',
    `directive_code` STRING COMMENT 'Unique business identifier code for the regulatory directive, used for external reference and reporting (e.g., GDPR-2016-679, COPPA-1998, ESRB-M17).',
    `directive_description` STRING COMMENT 'Detailed description of the regulatory directive, including its purpose, scope, and key requirements for gaming operations.',
    `directive_name` STRING COMMENT 'Full official name of the regulatory directive or legal requirement.',
    `directive_status` STRING COMMENT 'Current lifecycle status of the regulatory directive indicating whether it is enforceable, pending implementation, superseded by newer regulation, repealed, under review, or in draft state.',
    `directive_type` STRING COMMENT 'Classification of the regulatory directive by its primary regulatory domain (privacy regulation, consumer protection, age rating, loot box disclosure, data localization, content restriction).',
    `effective_date` DATE COMMENT 'Date when the regulatory directive becomes legally binding and enforceable. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'Date when the regulatory directive ceases to be enforceable, if applicable. Null for directives with indefinite duration. Format: yyyy-MM-dd.',
    `internal_policy_document_url` STRING COMMENT 'Link to the internal compliance policy, procedure document, or knowledge base article that operationalizes this directive within the organization.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country or territory code indicating the geographic jurisdiction where this directive applies (e.g., USA, GBR, DEU, JPN, AUS).',
    `jurisdiction_level` STRING COMMENT 'Administrative level at which the directive is enforced (international treaty, federal/national law, state/provincial regulation, or municipal ordinance).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory directive record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_review_date` DATE COMMENT 'Date when the organization last conducted a formal review of compliance status against this directive. Format: yyyy-MM-dd.',
    `legal_citation` STRING COMMENT 'Official legal citation or reference number for the directive in the issuing jurisdictions legal system (e.g., Regulation (EU) 2016/679, 15 U.S.C. §§ 6501–6506).',
    `loot_box_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this directive requires disclosure of loot box, gacha, or randomized reward probabilities to players (True) or not (False).',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty amount that can be imposed for non-compliance, in the currency specified by penalty_currency_code. Null if penalty is non-monetary or not specified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal compliance review or audit against this directive. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-text field for additional context, implementation notes, exceptions, or special considerations related to this directive.',
    `official_url` STRING COMMENT 'Web address linking to the official published text of the regulatory directive on the issuing authoritys website.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the maximum penalty amount (e.g., USD, EUR, GBP, JPY).',
    `penalty_severity` STRING COMMENT 'Classification of the enforcement penalty type for non-compliance (criminal prosecution, administrative fine, civil penalty, warning notice, or no specific penalty defined).',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance reports must be submitted to the regulatory authority, if reporting is required (annual, semi-annual, quarterly, monthly, event-driven, or not applicable).',
    `reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this directive mandates periodic regulatory reporting to the issuing authority (True) or not (False).',
    `responsible_department` STRING COMMENT 'Name of the internal business unit or department responsible for ensuring compliance with this directive (e.g., Legal, Compliance, Privacy Office, Product Management).',
    `risk_rating` STRING COMMENT 'Enterprise risk rating assigned to non-compliance with this directive, based on likelihood and impact assessment (critical, high, medium, low, negligible).',
    CONSTRAINT pk_regulatory_directive PRIMARY KEY(`regulatory_directive_id`)
) COMMENT 'Master reference table for regulatory_directive. Referenced by regulatory_directive_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`compliance`.`training_module` (
    `training_module_id` BIGINT COMMENT 'Primary key for training_module',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Training modules are often mandated by internal compliance policies. Should FK to the policy that requires the training. Note: compliance_framework (STRING) is kept as it may describe external framewo',
    `regulatory_directive_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_directive. Business justification: Training modules may be mandated by regulatory directives (e.g., GDPR requires data protection training). Should FK to the regulatory_directive that requires the training.',
    `prerequisite_training_module_id` BIGINT COMMENT 'Self-referencing FK on training_module (prerequisite_training_module_id)',
    `approval_date` DATE COMMENT 'Date when the training module was officially approved for use in compliance training programs.',
    `approver` STRING COMMENT 'Name or identifier of the compliance officer or legal authority who approved this training module for deployment.',
    `assessment_url` STRING COMMENT 'URL or file path to the assessment or quiz component of the training module.',
    `author` STRING COMMENT 'Name or identifier of the individual or team responsible for creating the training module content.',
    `certificate_template_code` STRING COMMENT 'Identifier for the certificate template used to generate completion certificates for this training module.',
    `compliance_framework` STRING COMMENT 'Primary regulatory or industry compliance framework that this training module addresses. [ENUM-REF-CANDIDATE: gdpr|coppa|esrb|pegi|ccpa|ccpa|iso_27001|soc2|ferpa|caru|ftc_guidelines — promote to reference product]',
    `content_format` STRING COMMENT 'Primary delivery format of the training module content.',
    `content_url` STRING COMMENT 'URL or file path to the training module content in the learning management system or content repository.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training module record was first created in the compliance management system.',
    `training_module_description` STRING COMMENT 'Detailed description of the training module content, learning objectives, and compliance topics covered.',
    `duration_minutes` STRING COMMENT 'Expected duration in minutes for an employee to complete the training module.',
    `effective_date` DATE COMMENT 'Date when this training module version becomes effective and available for assignment to employees.',
    `expiration_date` DATE COMMENT 'Date when this training module version expires and is no longer valid for compliance purposes. Null for modules without expiration.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of this training module is mandatory for the target audience to maintain compliance.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code indicating the primary regulatory jurisdiction this training module addresses. Multiple jurisdictions may require separate module instances.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the training module content.',
    `last_review_date` DATE COMMENT 'Date when the training module content was last reviewed for accuracy and regulatory alignment.',
    `learning_objectives` STRING COMMENT 'Structured list of learning objectives and competencies that employees will achieve upon successful completion of the training module.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training module record was last modified or updated.',
    `module_code` STRING COMMENT 'Externally-known unique code for the training module used in compliance tracking systems and regulatory reporting.',
    `module_type` STRING COMMENT 'Categorical classification of the training module based on the compliance domain it addresses. [ENUM-REF-CANDIDATE: regulatory_compliance|data_privacy|age_rating|loot_box_disclosure|esrb_certification|gdpr_training|coppa_training|pegi_certification|audit_preparation|jurisdictional_reporting — promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review to ensure continued regulatory compliance and content accuracy.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to successfully complete the training module and meet compliance requirements.',
    `prerequisites` STRING COMMENT 'Description of any prerequisite training modules or knowledge required before taking this module.',
    `recertification_interval_months` STRING COMMENT 'Number of months between required recertification completions for this training module. Null if recertification is not required.',
    `recertification_required` BOOLEAN COMMENT 'Indicates whether employees must retake this training module periodically to maintain compliance certification.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or governing authority whose requirements this training module addresses (e.g., FTC, ICO, CNIL, ESRB).',
    `training_module_status` STRING COMMENT 'Current lifecycle status of the training module indicating its availability and approval state.',
    `tags` STRING COMMENT 'Comma-separated list of keywords or tags for categorization and searchability of the training module (e.g., privacy, minors, monetization, disclosure).',
    `target_audience` STRING COMMENT 'Intended audience or role group for whom this training module is designed. [ENUM-REF-CANDIDATE: all_employees|developers|publishers|legal_team|customer_support|data_protection_officers|qa_testers|marketing_team — promote to reference product]',
    `title` STRING COMMENT 'Human-readable title of the compliance training module.',
    `version` STRING COMMENT 'Version number of the training module following semantic versioning to track content updates and regulatory changes.',
    CONSTRAINT pk_training_module PRIMARY KEY(`training_module_id`)
) COMMENT 'Master reference table for training_module. Referenced by training_module_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_regulatory_directive_id` FOREIGN KEY (`regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_parent_regulatory_obligation_id` FOREIGN KEY (`parent_regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_superseded_age_rating_cert_id` FOREIGN KEY (`superseded_age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_superseded_loot_box_disclosure_id` FOREIGN KEY (`superseded_loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ADD CONSTRAINT `fk_compliance_dsr_fulfillment_step_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ADD CONSTRAINT `fk_compliance_dsr_fulfillment_step_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ADD CONSTRAINT `fk_compliance_dsr_fulfillment_step_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ADD CONSTRAINT `fk_compliance_dsr_fulfillment_step_prerequisite_dsr_fulfillment_step_id` FOREIGN KEY (`prerequisite_dsr_fulfillment_step_id`) REFERENCES `gaming_ecm`.`compliance`.`dsr_fulfillment_step`(`dsr_fulfillment_step_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_regulatory_directive_id` FOREIGN KEY (`regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_superseded_by_policy_consent_policy_id` FOREIGN KEY (`superseded_by_policy_consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ADD CONSTRAINT `fk_compliance_consent_policy_superseded_consent_policy_id` FOREIGN KEY (`superseded_consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_recurring_audit_schedule_id` FOREIGN KEY (`recurring_audit_schedule_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_schedule`(`audit_schedule_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_audit_schedule_id` FOREIGN KEY (`audit_schedule_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_schedule`(`audit_schedule_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_follow_up_audit_engagement_id` FOREIGN KEY (`follow_up_audit_engagement_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_related_audit_finding_id` FOREIGN KEY (`related_audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_amendment_of_filing_id` FOREIGN KEY (`amendment_of_filing_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_directive_id` FOREIGN KEY (`regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_amended_regulatory_filing_id` FOREIGN KEY (`amended_regulatory_filing_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_root_cause_compliance_incident_id` FOREIGN KEY (`root_cause_compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_regulatory_directive_id` FOREIGN KEY (`regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_escalated_remediation_action_id` FOREIGN KEY (`escalated_remediation_action_id`) REFERENCES `gaming_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_superseded_privacy_impact_assessment_id` FOREIGN KEY (`superseded_privacy_impact_assessment_id`) REFERENCES `gaming_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `gaming_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_parent_processing_activity_id` FOREIGN KEY (`parent_processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ADD CONSTRAINT `fk_compliance_third_party_processor_parent_third_party_processor_id` FOREIGN KEY (`parent_third_party_processor_id`) REFERENCES `gaming_ecm`.`compliance`.`third_party_processor`(`third_party_processor_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_reverification_age_verification_event_id` FOREIGN KEY (`reverification_age_verification_event_id`) REFERENCES `gaming_ecm`.`compliance`.`age_verification_event`(`age_verification_event_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ADD CONSTRAINT `fk_compliance_sanctions_screening_result_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ADD CONSTRAINT `fk_compliance_sanctions_screening_result_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ADD CONSTRAINT `fk_compliance_sanctions_screening_result_rescreening_sanctions_screening_result_id` FOREIGN KEY (`rescreening_sanctions_screening_result_id`) REFERENCES `gaming_ecm`.`compliance`.`sanctions_screening_result`(`sanctions_screening_result_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_superseded_spend_limit_control_id` FOREIGN KEY (`superseded_spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_regulatory_directive_id` FOREIGN KEY (`regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_superseded_policy_id` FOREIGN KEY (`superseded_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_module_id` FOREIGN KEY (`training_module_id`) REFERENCES `gaming_ecm`.`compliance`.`training_module`(`training_module_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_retake_training_completion_id` FOREIGN KEY (`retake_training_completion_id`) REFERENCES `gaming_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_directive_id` FOREIGN KEY (`regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_superseded_regulatory_change_id` FOREIGN KEY (`superseded_regulatory_change_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ADD CONSTRAINT `fk_compliance_processor_engagement_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ADD CONSTRAINT `fk_compliance_processor_engagement_third_party_processor_id` FOREIGN KEY (`third_party_processor_id`) REFERENCES `gaming_ecm`.`compliance`.`third_party_processor`(`third_party_processor_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ADD CONSTRAINT `fk_compliance_policy_applicability_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ADD CONSTRAINT `fk_compliance_policy_applicability_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ADD CONSTRAINT `fk_compliance_obligation_applicability_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ADD CONSTRAINT `fk_compliance_obligation_applicability_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ADD CONSTRAINT `fk_compliance_obligation_applicability_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_original_data_subject_request_id` FOREIGN KEY (`original_data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ADD CONSTRAINT `fk_compliance_regulatory_authority_parent_authority_id` FOREIGN KEY (`parent_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ADD CONSTRAINT `fk_compliance_regulatory_authority_parent_regulatory_authority_id` FOREIGN KEY (`parent_regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ADD CONSTRAINT `fk_compliance_regulatory_directive_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ADD CONSTRAINT `fk_compliance_regulatory_directive_superseded_by_directive_id` FOREIGN KEY (`superseded_by_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ADD CONSTRAINT `fk_compliance_regulatory_directive_superseded_regulatory_directive_id` FOREIGN KEY (`superseded_regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ADD CONSTRAINT `fk_compliance_training_module_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ADD CONSTRAINT `fk_compliance_training_module_regulatory_directive_id` FOREIGN KEY (`regulatory_directive_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_directive`(`regulatory_directive_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ADD CONSTRAINT `fk_compliance_training_module_prerequisite_training_module_id` FOREIGN KEY (`prerequisite_training_module_id`) REFERENCES `gaming_ecm`.`compliance`.`training_module`(`training_module_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `gaming_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `parent_regulatory_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `applicable_game_titles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Game Titles');
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
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction ID');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `parent_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Jurisdiction ID');
ALTER TABLE `gaming_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Certificate ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Authority Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `loot_box_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure ID');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `gacha_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool ID');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ALTER COLUMN `superseded_loot_box_disclosure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `dsr_fulfillment_step_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request (DSR) Fulfillment Step ID');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request (DSR) ID');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `prerequisite_dsr_fulfillment_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `assigned_team_member` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Member');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `assigned_team_member` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `blocker_description` SET TAGS ('dbx_business_glossary_term' = 'Blocker or Exception Description');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `blocker_resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blocker Resolution Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `data_volume_processed` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Processed');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `data_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Unit of Measure');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `data_volume_unit` SET TAGS ('dbx_value_regex' = 'records|files|megabytes|gigabytes');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Step Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `player_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Sent Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `player_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `responsible_system` SET TAGS ('dbx_business_glossary_term' = 'Responsible System or Domain');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `step_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step Completion Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `step_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step Start Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|blocked|skipped');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `step_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Step Type');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `step_type` SET TAGS ('dbx_value_regex' = 'data_extraction|data_deletion|data_portability_package_generation|third_party_notification|player_notification|consent_withdrawal');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `third_party_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Name');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `third_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `third_party_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notification Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `third_party_notified` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notified Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual_review|automated_validation|sampling|third_party_audit');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `gaming_ecm`.`compliance`.`dsr_fulfillment_step` ALTER COLUMN `verified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy ID');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `superseded_by_policy_consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Consent Policy ID');
ALTER TABLE `gaming_ecm`.`compliance`.`consent_policy` ALTER COLUMN `superseded_consent_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mandating Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `recurring_audit_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_lead_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Audit Lead Contact Email');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_lead_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_lead_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_lead_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_lead_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Lead Contact Name');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_lead_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_lead_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Name');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_objectives` SET TAGS ('dbx_business_glossary_term' = 'Audit Objectives');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_compliance|external_regulatory|third_party_ip_licensing|platform_certification|data_protection_authority_inspection|financial');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `auditor_type` SET TAGS ('dbx_business_glossary_term' = 'Auditor Type');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `auditor_type` SET TAGS ('dbx_value_regex' = 'internal|external|third_party');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `estimated_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Days');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `internal_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Internal Coordinator Email');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `internal_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `internal_coordinator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `internal_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `internal_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Coordinator Name');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `last_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Last Occurrence Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `next_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Occurrence Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `preparation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Start Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc|one_time');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `rescheduled_from_date` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `responsible_auditor` SET TAGS ('dbx_business_glossary_term' = 'Responsible Auditor');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `follow_up_audit_engagement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Firm Name');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('dbx_value_regex' = 'gdpr_compliance|coppa_compliance|loot_box_disclosure|age_rating|payment_security|data_retention|[ENUM-REF-CANDIDATE: gdpr_compliance|coppa_compliance|loot_box_disclosure|age_rating|payment_security|data_retention|platform_certification|esrb_rating...');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Status');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `audit_team_size` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Size');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `board_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Board Presentation Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Number');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_value_regex' = '^AE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Type');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|certification|follow_up|special');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `evidence_items_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Evidence Items Reviewed');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `fieldwork_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Duration (Days)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `final_report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Final Report Document Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `follow_up_deadline` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Deadline');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `interviews_conducted` SET TAGS ('dbx_business_glossary_term' = 'Interviews Conducted');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `management_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Management Response Summary');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `opinion_rationale` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion Rationale');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `scope_narrative` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Narrative');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ALTER COLUMN `systems_tested` SET TAGS ('dbx_business_glossary_term' = 'Systems Tested');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `primary_audit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `primary_audit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `primary_audit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `related_audit_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closure_evidence` SET TAGS ('dbx_business_glossary_term' = 'Closure Evidence');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `recommended_remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Remediation Action');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_area` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Area');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|closed|overdue|deferred');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `amendment_of_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment of Filing ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `amended_regulatory_filing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgement_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Receipt Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `age_rating_assigned` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Assigned');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `data_subject_request_count` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Count');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `esports_betting_license_number` SET TAGS ('dbx_business_glossary_term' = 'Esports Betting License Number');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `external_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_document_url` SET TAGS ('dbx_business_glossary_term' = 'Filing Document URL');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'loot_box_disclosure|gdpr_article_30|coppa_parental_consent|age_rating_submission|financial_disclosure|esports_betting_compliance');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `internal_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `loot_box_disclosure_url` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure URL');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `parental_consent_method` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Method');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_imposed_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Imposed Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_response_text` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Text');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident ID');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Player Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Dsr Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ALTER COLUMN `root_cause_compliance_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Player Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `quaternary_remediation_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `quaternary_remediation_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `quaternary_remediation_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `tertiary_remediation_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `tertiary_remediation_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `tertiary_remediation_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ALTER COLUMN `escalated_remediation_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment (PIA) Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mandating Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `superseded_privacy_impact_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('dbx_business_glossary_term' = 'Assessment Team Members');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_title` SET TAGS ('dbx_business_glossary_term' = 'Assessment Title');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'DPIA|PIA|DPIA_Update|PIA_Update');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `children_data_involved` SET TAGS ('dbx_business_glossary_term' = 'Children Data Involved Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `cross_border_transfer` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Categories');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_retention_period` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `data_subject_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Categories');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_reviewer_email` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Reviewer Email');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_reviewer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_reviewer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_reviewer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Reviewer Name');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `dpo_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `identified_privacy_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Privacy Risks');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `initial_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Level');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `initial_risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'Consent|Contract|Legitimate_Interest|Legal_Obligation|Vital_Interest|Public_Task');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `mitigating_controls` SET TAGS ('dbx_business_glossary_term' = 'Mitigating Controls');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `platform_feature` SET TAGS ('dbx_business_glossary_term' = 'Platform Feature');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `processing_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Description');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Biannual|Quarterly|On_Change|One_Time');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `special_category_data_involved` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Involved Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `stakeholder_consultation_notes` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `supervisory_authority_consultation_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `supervisory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Name');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `supervisory_authority_response_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Response Date');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `third_party_integration` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Integration');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Transfer Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_value_regex' = 'Standard_Contractual_Clauses|Adequacy_Decision|Binding_Corporate_Rules|Certification|Derogation|Not_Applicable');
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity ID');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) Reference ID');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `parent_processing_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Code');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^PA-[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Name');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `activity_owner` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Owner');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `automated_decision_logic` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision Logic Description');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `automated_decision_making_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision Making Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
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
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `third_party_processor_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Processor ID');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `parent_third_party_processor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `data_breach_notification_email` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Notification Email Address');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `data_breach_notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `data_breach_notification_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `data_breach_notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `data_categories_shared` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Shared');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `data_processing_location` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Location');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpa_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Execution Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Expiry Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpa_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpo_email` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Email Address');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpo_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpo_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpo_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpo_name` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Name');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dpo_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `dsr_response_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request (DSR) Response Service Level Agreement (SLA) Hours');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `last_due_diligence_date` SET TAGS ('dbx_business_glossary_term' = 'Last Due Diligence Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `next_due_diligence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Diligence Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `processor_code` SET TAGS ('dbx_business_glossary_term' = 'Processor Code');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Processor Legal Name');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `processor_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Processor Risk Rating');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `processor_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `processor_status` SET TAGS ('dbx_business_glossary_term' = 'Processor Status');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `processor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|terminated');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `processor_type` SET TAGS ('dbx_business_glossary_term' = 'Processor Type');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `requires_player_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Player Consent');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `security_certification` SET TAGS ('dbx_business_glossary_term' = 'Security Certification');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `services_provided` SET TAGS ('dbx_business_glossary_term' = 'Services Provided');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `sub_processor_list_url` SET TAGS ('dbx_business_glossary_term' = 'Sub-Processor List URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `supports_data_portability` SET TAGS ('dbx_business_glossary_term' = 'Supports Data Portability');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `supports_dsr` SET TAGS ('dbx_business_glossary_term' = 'Supports Data Subject Request (DSR)');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Data Transfer Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_value_regex' = 'adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|not_applicable');
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `age_verification_event_id` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Event ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `reverification_age_verification_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Age Requirement');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `game_rating` SET TAGS ('dbx_business_glossary_term' = 'Game Rating');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `game_rating` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `parental_consent_token` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Token');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `parental_consent_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `player_declared_age` SET TAGS ('dbx_business_glossary_term' = 'Player Declared Age');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `third_party_provider` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Provider');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `third_party_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Transaction ID');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_channel` SET TAGS ('dbx_business_glossary_term' = 'Verification Channel');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_channel` SET TAGS ('dbx_value_regex' = 'in_game|web_portal|mobile_app|customer_support|email|sms');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Expiry Date');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Verification IP Address');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'date_of_birth_entry|credit_card_verification|parental_consent_form|third_party_age_verification_service|government_id_verification|biometric_verification');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Verification Outcome');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|pending_parental_consent|under_review|expired');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ALTER COLUMN `verification_trigger` SET TAGS ('dbx_business_glossary_term' = 'Verification Trigger');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `sanctions_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result ID');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Officer ID');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `rescreening_sanctions_screening_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `counterparty_reference` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Final Determination Date');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'cleared|blocked|escalated|under_review|pending_documentation');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|tier_1|tier_2|senior_management|legal_counsel|executive');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `match_details` SET TAGS ('dbx_business_glossary_term' = 'Match Details');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `match_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'no_match|potential_match|confirmed_match|false_positive');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `matched_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Entity Name');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `matched_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `matched_list_name` SET TAGS ('dbx_business_glossary_term' = 'Matched List Name');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `requires_sar_filing` SET TAGS ('dbx_business_glossary_term' = 'Requires Suspicious Activity Report (SAR) Filing');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `reviewing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Officer Name');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_country` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Country');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Name');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Type');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_value_regex' = 'player_account|payment_instrument|counterparty|business_entity|individual');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screening_lists_checked` SET TAGS ('dbx_business_glossary_term' = 'Screening Lists Checked');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screening_provider` SET TAGS ('dbx_business_glossary_term' = 'Screening Provider');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `screening_trigger` SET TAGS ('dbx_business_glossary_term' = 'Screening Trigger');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control ID');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account ID');
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
ALTER TABLE `gaming_ecm`.`compliance`.`policy` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Identifier (ID)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_module_id` SET TAGS ('dbx_business_glossary_term' = 'Training Module ID');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `retake_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `applicable_jurisdiction_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdiction Codes');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_max_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Maximum Score');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate URL');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|overdue|pending_renewal|waived');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|waived');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `passing_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Threshold');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Months');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `role_requirement` SET TAGS ('dbx_business_glossary_term' = 'Role Requirement');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'online|instructor_led|blended|self_paced|webinar|workshop');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Minutes');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_module_name` SET TAGS ('dbx_business_glossary_term' = 'Training Module Name');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Compliance Analyst ID');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Updated Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_domain_advertising` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Domain - Advertising');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_domain_age_rating` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Domain - Age Rating');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_domain_coppa` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Domain - Childrens Online Privacy Protection Act (COPPA)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_domain_esports_betting` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Domain - Esports Betting');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_domain_gdpr` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Domain - General Data Protection Regulation (GDPR)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_domain_loot_box` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Domain - Loot Box');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_domain_payment` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Domain - Payment');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_game_titles` SET TAGS ('dbx_business_glossary_term' = 'Affected Game Titles');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_platforms` SET TAGS ('dbx_business_glossary_term' = 'Affected Platforms');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Change Reference Number');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'new_law|amendment|guidance_update|enforcement_action|repeal|consultation');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Cost');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_implementation_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Effort Hours');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Summary');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `internal_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Internal Documentation Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `legal_review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completion Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `player_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_document_url` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Document Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `requires_legal_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Legal Review');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `requires_player_notification` SET TAGS ('dbx_business_glossary_term' = 'Requires Player Notification');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `requires_policy_update` SET TAGS ('dbx_business_glossary_term' = 'Requires Policy Update');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `requires_system_changes` SET TAGS ('dbx_business_glossary_term' = 'Requires System Changes');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `response_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Response Plan Status');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `response_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|under_review|approved|implemented|closed');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` SET TAGS ('dbx_association_edges' = 'compliance.processing_activity,compliance.third_party_processor');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `processor_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Processor Engagement ID');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processor Engagement - Processing Activity Id');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `third_party_processor_id` SET TAGS ('dbx_business_glossary_term' = 'Processor Engagement - Third Party Processor Id');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `data_categories_shared` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Shared');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `data_categories_shared` SET TAGS ('dbx_pii_metadata' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `data_transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Data Transfer Mechanism');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `data_volume_estimate` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Estimate');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `dpa_execution_date` SET TAGS ('dbx_business_glossary_term' = 'DPA Execution Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `dpa_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `third_party_processors` SET TAGS ('dbx_business_glossary_term' = 'Third Party Processors');
ALTER TABLE `gaming_ecm`.`compliance`.`processor_engagement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` SET TAGS ('dbx_association_edges' = 'compliance.compliance_policy,compliance.jurisdiction');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `policy_applicability_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Applicability ID');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Applicability - Jurisdiction Id');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Applicability - Compliance Policy Id');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `applicable_territories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Territories');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `jurisdiction_specific_addendum_url` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction-Specific Addendum URL');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `local_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Local Approval Authority');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `local_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Local Approval Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `local_regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Local Regulatory Reference');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`policy_applicability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` SET TAGS ('dbx_association_edges' = 'compliance.regulatory_obligation,compliance.jurisdiction');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `obligation_applicability_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Applicability Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Applicability - Jurisdiction Id');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Applicability - Regulatory Obligation Id');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Applicability Flag');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `applicable_territories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Territories');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Effective Date');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority Level');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Expiration Date');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `local_compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Local Compliance Owner');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `local_interpretation_notes` SET TAGS ('dbx_business_glossary_term' = 'Local Interpretation Guidance');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `local_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Penalty Amount');
ALTER TABLE `gaming_ecm`.`compliance`.`obligation_applicability` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `original_data_subject_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `data_export_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `legal_hold_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `parent_regulatory_authority_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `superseded_regulatory_directive_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `compliance_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `compliance_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `compliance_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `internal_policy_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_directive` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` SET TAGS ('dbx_subdomain' = 'audit_enforcement');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ALTER COLUMN `training_module_id` SET TAGS ('dbx_business_glossary_term' = 'Training Module Identifier');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ALTER COLUMN `regulatory_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ALTER COLUMN `prerequisite_training_module_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ALTER COLUMN `assessment_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`compliance`.`training_module` ALTER COLUMN `content_url` SET TAGS ('dbx_confidential' = 'true');
