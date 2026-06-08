-- Schema for Domain: client | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`client` COMMENT 'Single source of truth for all client entities served by the firm including corporate clients, government agencies, individual clients, and prospective clients. Manages client profiles, organizational hierarchies, contact information, client segments, relationship history, KYC documentation, and client classification for conflict checking and engagement purposes. Supports both B2B and B2C client types across all practice areas.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`client`.`organisation` (
    `organisation_id` BIGINT COMMENT 'Unique identifier for the organisation entity. Primary key for the organisation data product.',
    `parent_organisation_id` BIGINT COMMENT 'Reference to the parent organisation if this entity is part of a corporate group or holding structure. Enables hierarchical relationship tracking for conflict checking and consolidated billing.',
    `primary_ultimate_parent_organisation_id` BIGINT COMMENT 'Reference to the ultimate parent or holding company at the top of the corporate hierarchy. Used for group-level conflict checking and relationship management.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.segment. Business justification: The organisation table currently has a denormalized client_segment STRING column. Corporate/institutional clients are subject to the firms client segmentation taxonomy defined in the segment table. T',
    `aml_risk_tier` STRING COMMENT 'The risk tier assigned to the organisation based on AML risk assessment. Determines the level of due diligence and monitoring required under AML regulations.. Valid values are `low|medium|high|prohibited`',
    `annual_revenue_range` STRING COMMENT 'The approximate annual revenue of the organisation. Used for client segmentation, pricing strategy, and relationship management. [ENUM-REF-CANDIDATE: under_1m|1m_10m|10m_50m|50m_100m|100m_500m|500m_1b|1b_plus — 7 candidates stripped; promote to reference product]',
    `billing_address_same_as_registered` BOOLEAN COMMENT 'Indicates whether the billing address is the same as the registered address. If true, billing address fields may be omitted.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this organisation record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'The maximum credit limit approved for the organisation for work in progress (WIP) and outstanding accounts receivable. Used for credit risk management and billing controls.',
    `duns_number` STRING COMMENT 'The 9-digit DUNS number issued by Dun & Bradstreet for business identification and credit reporting purposes.. Valid values are `^[0-9]{9}$`',
    `employee_count_range` STRING COMMENT 'The approximate size of the organisation by employee count. Used for client segmentation and matter scoping. [ENUM-REF-CANDIDATE: 1_10|11_50|51_200|201_500|501_1000|1001_5000|5001_plus — 7 candidates stripped; promote to reference product]',
    `entity_type` STRING COMMENT 'The legal structure or type of the organisation. Indicates whether the entity is a corporation, partnership, LLC, government agency, NGO, or other legal form.. Valid values are `corporation|partnership|limited_liability_company|government_agency|non_governmental_organisation|sole_proprietorship`',
    `industry_sector` STRING COMMENT 'The primary industry sector in which the organisation operates. Used for conflict checking, sector-specific regulatory compliance, and business development segmentation.',
    `is_ultimate_beneficial_owner` BOOLEAN COMMENT 'Indicates whether this organisation is identified as an ultimate beneficial owner in the corporate ownership structure. Critical for AML and KYC compliance.',
    `jurisdiction_of_incorporation` STRING COMMENT 'The legal jurisdiction or country where the organisation is incorporated or registered. Use ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU).',
    `kyc_completion_date` DATE COMMENT 'The date on which the KYC verification process was completed and approved. Used to track KYC refresh requirements and compliance deadlines.',
    `kyc_next_review_date` DATE COMMENT 'The scheduled date for the next periodic KYC review. KYC reviews must be refreshed periodically based on risk tier and regulatory requirements.',
    `kyc_status` STRING COMMENT 'The current status of the KYC verification process for the organisation. Indicates whether the client has passed due diligence checks required for engagement.. Valid values are `pending|in_progress|approved|rejected|expired`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this organisation record was last updated. Used for audit trail and change tracking.',
    `legal_name` STRING COMMENT 'The full legal name of the organisation as registered with the governing jurisdiction. This is the official name used in all legal documents, contracts, and regulatory filings.',
    `lei_code` STRING COMMENT 'The 20-character Legal Entity Identifier issued by the Global Legal Entity Identifier Foundation (GLEIF). Used for regulatory reporting and entity identification in financial transactions.. Valid values are `^[A-Z0-9]{20}$`',
    `naics_code` STRING COMMENT 'The NAICS code that categorizes the organisations primary business activity for North American jurisdictions. Used for regulatory reporting and industry benchmarking.',
    `payment_terms_days` STRING COMMENT 'The standard payment terms for invoices issued to the organisation, expressed in days (e.g., 30, 60, 90). Used for accounts receivable management and cash flow forecasting.',
    `primary_contact_email` STRING COMMENT 'The primary email address for official communications with the organisation. Used for engagement letters, billing notifications, and matter correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'The primary telephone number for contacting the organisation. Used for urgent matter communications and client relationship management.',
    `public_private_status` STRING COMMENT 'Indicates whether the organisation is publicly traded, privately held, a government entity, or a non-profit organisation. Affects disclosure requirements and conflict checking rules.. Valid values are `public|private|government|non_profit`',
    `registered_address_line1` STRING COMMENT 'The first line of the organisations registered or legal address as filed with the incorporation authority. Used for legal correspondence and service of process.',
    `registered_address_line2` STRING COMMENT 'The second line of the organisations registered address, if applicable. Used for suite numbers, building names, or additional address details.',
    `registered_city` STRING COMMENT 'The city or locality of the organisations registered address.',
    `registered_country` STRING COMMENT 'The country of the organisations registered address. Use ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU).',
    `registered_postal_code` STRING COMMENT 'The postal or ZIP code of the organisations registered address.',
    `registered_state_province` STRING COMMENT 'The state, province, or region of the organisations registered address. Use standard postal abbreviations where applicable.',
    `registration_number` STRING COMMENT 'The official registration or incorporation number issued by the jurisdiction of incorporation. Examples include Companies House number (UK), EIN (US), or equivalent.',
    `relationship_inception_date` DATE COMMENT 'The date on which the organisation first became a client of the firm. Used for relationship tenure analysis and client lifetime value calculations.',
    `relationship_status` STRING COMMENT 'The current status of the client relationship. Indicates whether the organisation is an active client, prospective client, or former client.. Valid values are `active|inactive|suspended|prospective|former`',
    `sanctions_screening_date` DATE COMMENT 'The date on which the most recent sanctions screening was performed. Sanctions screening must be performed at onboarding and periodically thereafter.',
    `sanctions_screening_status` STRING COMMENT 'The result of sanctions list screening against OFAC, UN, EU, and other sanctions lists. Indicates whether the organisation is clear to engage or requires further review.. Valid values are `clear|match_found|under_review|blocked`',
    `sic_code` STRING COMMENT 'The Standard Industrial Classification code that categorizes the organisations primary business activity. Used for regulatory reporting and industry analysis.',
    `stock_exchange` STRING COMMENT 'The stock exchange where the organisation is listed, if publicly traded. Examples include NYSE, NASDAQ, LSE, or equivalent. Null for private entities.',
    `tax_identification_number` STRING COMMENT 'The tax identification number assigned by the relevant tax authority. Examples include EIN (US), VAT number (EU), or equivalent. Used for billing and tax compliance.',
    `ticker_symbol` STRING COMMENT 'The ticker or trading symbol for the organisation if publicly listed. Used for market research and conflict checking against securities matters.',
    `trading_name` STRING COMMENT 'The commercial or trading name under which the organisation operates, if different from the legal name. Also known as DBA (Doing Business As) name.',
    `vat_registration_number` STRING COMMENT 'The VAT registration number for organisations operating in VAT jurisdictions. Required for invoicing and tax compliance in EU and other VAT regions.',
    `website_url` STRING COMMENT 'The primary website URL for the organisation. Used for research, business development, and client profile enrichment.',
    CONSTRAINT pk_organisation PRIMARY KEY(`organisation_id`)
) COMMENT 'Master record for all corporate, government, and institutional client entities served by the firm. Captures the legal entity name, registration number, jurisdiction of incorporation, entity type (corporation, partnership, government agency, NGO), industry sector, SIC/NAICS code, parent organisation reference, ultimate beneficial owner flags, public/private status, listed exchange, regulatory identifiers (LEI, DUNS), AML risk tier, KYC status, and relationship inception date. Serves as the B2B anchor entity for all matter, billing, and conflict-check relationships. Sourced primarily from Elite 3E client/matter management and Intapp Conflicts.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`individual` (
    `individual_id` BIGINT COMMENT 'Unique identifier for the individual client record. Primary key for natural-person clients including B2C clients, sole traders, high-net-worth individuals, and personal-capacity contacts.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Individual clients (e.g. HNW individuals, sole traders) have kyc_status, pep_flag, and sanctions_screening fields but no FK to the AML program governing their screening. Legal firms apply AML programs',
    `profile_id` BIGINT COMMENT 'Reference to the parent client entity in the client master. Links this individual to the broader client domain for conflict checking and engagement purposes.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Individual has data_retention_category, lpp_status, and kyc_status but no FK to the regulatory obligation mandating those requirements. Legal firms must trace which regulation (e.g. GDPR, Money Launde',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.segment. Business justification: The individual table currently has a denormalized client_segment STRING column. Individual clients (natural persons) are also subject to the firms client segmentation taxonomy defined in the segment ',
    `client_since_date` DATE COMMENT 'The date when this individual first became a client of the firm. Used for client tenure analysis, relationship lifecycle tracking, and client retention metrics.',
    `client_status` STRING COMMENT 'The current lifecycle status of the individual client. Values: active (current client with open matters), inactive (no current matters but relationship maintained), prospective (potential client), former (relationship ended), suspended (temporarily restricted).. Valid values are `active|inactive|prospective|former|suspended`',
    `communication_preference` STRING COMMENT 'The individuals preferred method of communication for non-urgent matters (email, phone, mail, client portal, SMS). Used to optimize client experience and engagement effectiveness.. Valid values are `email|phone|mail|portal|sms`',
    `conflict_check_status` STRING COMMENT 'The current status of conflict checking for this individual. Values: cleared (no conflicts identified), conflict_identified (potential conflict detected), waived (conflict waived by client), pending (conflict check in progress). Required before engagement acceptance.. Valid values are `cleared|conflict_identified|waived|pending`',
    `country_of_domicile` STRING COMMENT 'The country where the individual is legally domiciled, represented as a 3-letter ISO country code. Determines applicable jurisdiction for tax, estate planning, and regulatory compliance matters.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this individual client record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and data lineage tracking.',
    `credit_status` STRING COMMENT 'The credit standing of the individual client for billing and payment purposes. Values: approved (standard credit terms), restricted (prepayment or retainer required), hold (no new work until payment received), review_required (credit review pending).. Valid values are `approved|restricted|hold|review_required`',
    `data_retention_category` STRING COMMENT 'The data retention classification for this individuals records. Values: standard (default retention period), extended (longer retention for regulatory reasons), litigation_hold (preservation order in effect), permanent (indefinite retention required). Drives records management and information governance policies.. Valid values are `standard|extended|litigation_hold|permanent`',
    `date_of_birth` DATE COMMENT 'The individuals date of birth in yyyy-MM-dd format. Required for identity verification, KYC compliance, and age-restricted legal services (e.g., estate planning, employment law).',
    `kyc_completion_date` DATE COMMENT 'The date when KYC verification was completed for this individual. Used to track KYC refresh cycles and ensure ongoing compliance with client identification requirements.',
    `kyc_status` STRING COMMENT 'The current status of KYC documentation and verification for this individual. Values: complete (all required documents verified), incomplete (missing documents), pending_review (under compliance review), expired (requires refresh), not_started (new client).. Valid values are `complete|incomplete|pending_review|expired|not_started`',
    `legal_first_name` STRING COMMENT 'The individuals legal first name as it appears on official identification documents. Required for KYC (Know Your Client) and AML (Anti-Money Laundering) compliance.',
    `legal_last_name` STRING COMMENT 'The individuals legal last name (surname/family name) as it appears on official identification documents. Required for KYC and AML compliance.',
    `legal_middle_name` STRING COMMENT 'The individuals legal middle name or initial as it appears on official identification documents. May be null if not applicable.',
    `lpp_status` BOOLEAN COMMENT 'Boolean flag indicating whether communications with this individual are protected by Legal Professional Privilege (LPP) or attorney-client privilege. True if privilege applies. Critical for eDiscovery, document review, and information governance.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the individual has consented to receive marketing communications from the firm. True if consent given. Required for GDPR and CCPA compliance in marketing activities.',
    `mobile_phone` STRING COMMENT 'The individuals mobile phone number. Used for SMS notifications, two-factor authentication, and mobile-first client engagement.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this individual client record was last modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for change tracking, audit compliance, and data quality monitoring.',
    `nationality` STRING COMMENT 'The individuals nationality represented as a 3-letter ISO country code (e.g., USA, GBR, CAN). Required for cross-border matters, immigration law, and international arbitration.. Valid values are `^[A-Z]{3}$`',
    `passport_number` STRING COMMENT 'The individuals passport number. Used for identity verification in cross-border transactions, immigration matters, and international dispute resolution.',
    `pep_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the individual is a Politically Exposed Person (PEP) as defined by FATF guidelines. True if the individual holds or has held a prominent public function. Triggers enhanced due diligence requirements for AML compliance.',
    `preferred_language` STRING COMMENT 'The individuals preferred language for communication, represented as a 2-letter ISO language code (e.g., en, fr, es). Ensures culturally appropriate service delivery and compliance with language access requirements.. Valid values are `^[a-z]{2}$`',
    `preferred_name` STRING COMMENT 'The name the individual prefers to be called in day-to-day interactions, which may differ from their legal name. Used for personalized communication and relationship management.',
    `primary_email` STRING COMMENT 'The individuals primary email address for official correspondence and engagement communications. Used for LOE (Letter of Engagement) delivery, billing notifications, and matter updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The individuals primary contact phone number. Used for urgent matter communications, appointment scheduling, and client relationship management.',
    `residential_address_line1` STRING COMMENT 'The first line of the individuals residential address (street number and name). Required for service of process, correspondence, and KYC compliance.',
    `residential_address_line2` STRING COMMENT 'The second line of the individuals residential address (apartment, suite, or unit number). Optional field for additional address details.',
    `residential_city` STRING COMMENT 'The city or municipality of the individuals residential address. Used for jurisdiction determination and venue selection in litigation matters.',
    `residential_country` STRING COMMENT 'The country of the individuals residential address, represented as a 3-letter ISO country code. Used for cross-border matters and international client management.. Valid values are `^[A-Z]{3}$`',
    `residential_postal_code` STRING COMMENT 'The postal or ZIP code of the individuals residential address. Used for mail delivery, geographic segmentation, and jurisdiction mapping.',
    `residential_state_province` STRING COMMENT 'The state, province, or region of the individuals residential address. Critical for determining applicable state bar jurisdiction and regulatory compliance requirements.',
    `salutation` STRING COMMENT 'Formal title or honorific used when addressing the individual client (e.g., Mr, Ms, Dr, Prof, Hon).. Valid values are `Mr|Ms|Mrs|Dr|Prof|Hon`',
    `sanctions_screening_date` DATE COMMENT 'The date when the most recent sanctions screening was performed for this individual. Used to ensure periodic re-screening compliance per AML policies.',
    `sanctions_screening_status` STRING COMMENT 'The current status of sanctions screening for this individual against OFAC, UN, EU, and other sanctions lists. Values: cleared (no match), flagged (potential match requiring review), pending (screening in progress), not_screened (screening not yet performed).. Valid values are `cleared|flagged|pending|not_screened`',
    `source_system` STRING COMMENT 'The operational system of record from which this individual client record originated. Values: elite_3e (Elite 3E practice management), dynamics_365 (Microsoft Dynamics 365 CRM), intapp_conflicts (Intapp Conflicts system), manual_entry (manually created record). Used for data lineage and reconciliation.. Valid values are `elite_3e|dynamics_365|intapp_conflicts|manual_entry`',
    `tax_identification_number` STRING COMMENT 'The individuals tax identification number (e.g., SSN in USA, NI Number in UK). Required for tax advisory, estate planning, and compliance with FATCA and CRS reporting obligations.',
    CONSTRAINT pk_individual PRIMARY KEY(`individual_id`)
) COMMENT 'Master record for natural-person clients including individual (B2C) clients, sole traders, high-net-worth individuals, and personal-capacity contacts who engage the firm directly. Stores salutation, full legal name, preferred name, date of birth, nationality, country of domicile, tax identification number, PII classification flags, LPP status, politically exposed person (PEP) flag, sanctions screening status, preferred language, and communication preferences. Distinct from the organisation entity; supports B2C practice areas such as employment law, estate planning, and personal injury. Sourced from Elite 3E and Microsoft Dynamics 365 CRM.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique identifier for the client profile record. Primary key for the client master data entity.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Profile is the primary client record with aml_risk_rating, kyc_status, and sanctions fields but no FK to the AML program governing those assessments. Legal firms link client profiles to AML programs f',
    `organisation_id` BIGINT COMMENT 'Reference to the organisation entity record for corporate, government, or institutional clients. Null for individual clients.',
    `practice_area_id` BIGINT COMMENT 'Reference to the practice area that represents the majority of work performed for this client (e.g., Corporate, Litigation, Intellectual Property (IP), Employment, Tax).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Profile tracks jurisdiction, kyc_status, and sanctions_screening but has no FK to the regulatory obligation mandating those requirements. Legal firms must trace which regulatory obligation (e.g. Money',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.segment. Business justification: The profile table currently has a denormalized client_segment STRING column. The segment table is the authoritative reference master for client segmentation taxonomy. This FK normalizes the relationsh',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Client profiles carry a tier designation governing service levels and pricing. Linking profile to service.tier replaces the denormalized client_tier text field, enabling tier-based service delivery ',
    `afa_eligible_flag` BOOLEAN COMMENT 'Indicates whether the client is eligible for or prefers Alternative Fee Arrangements (AFA) such as fixed fees, capped fees, contingency, or blended rates instead of traditional hourly billing.',
    `aml_risk_rating` STRING COMMENT 'Risk classification assigned based on Anti-Money Laundering (AML) assessment. High-risk clients require enhanced due diligence; prohibited indicates clients that cannot be accepted due to sanctions or policy restrictions.. Valid values are `low|medium|high|prohibited`',
    `billing_frequency` STRING COMMENT 'Standard billing cycle frequency for this client. Monthly indicates regular monthly invoicing; quarterly indicates quarterly cycles; matter completion indicates billing at matter close; milestone indicates event-driven billing; on demand indicates ad-hoc billing.. Valid values are `monthly|quarterly|matter_completion|milestone|on_demand`',
    `client_name` STRING COMMENT 'Full legal name of the client entity or individual as registered. For corporate clients, this is the registered business name; for individuals, the full legal name.',
    `client_number` STRING COMMENT 'Firm-assigned canonical client identifier used across all systems and matters. This is the business key for client identification in Elite 3E and all downstream systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `client_status` STRING COMMENT 'Current lifecycle status of the client relationship. Active indicates ongoing engagement; inactive indicates no current matters but relationship maintained; prospect indicates potential client; former indicates closed relationship; suspended indicates temporary hold; conflicted indicates ethical conflict identified.. Valid values are `active|inactive|prospect|former|suspended|conflicted`',
    `client_type` STRING COMMENT 'Classification of the client entity type. Corporate includes all business entities; government includes federal, state, and local agencies; individual includes natural persons; prospective includes potential clients undergoing conflict checking.. Valid values are `corporate|government|individual|prospective|partnership|trust`',
    `conflict_check_status` STRING COMMENT 'Current status of ethical conflict checking for this client. Clear indicates no conflicts; conflict identified indicates potential conflict requiring resolution; waived indicates conflict waived by all parties; pending indicates check in progress.. Valid values are `clear|conflict_identified|waived|pending|not_performed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this client profile record was first created in the system. Represents the initial data capture event.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit approved for this client for Work in Progress (WIP) and outstanding accounts receivable. Used for credit risk management and billing holds.',
    `data_protection_classification` STRING COMMENT 'Highest data protection regime applicable to this clients data. General Data Protection Regulation (GDPR) for EU clients; California Consumer Privacy Act (CCPA) for California residents; Health Insurance Portability and Accountability Act (HIPAA) for healthcare; Payment Card Industry Data Security Standard (PCI DSS) for payment data; Sarbanes-Oxley Act (SOX) for public company financial data.. Valid values are `standard|gdpr|ccpa|hipaa|pci_dss|sox`',
    `ebilling_platform` STRING COMMENT 'Name of the third-party electronic billing platform used by the client (e.g., Serengeti Tracker, CounselLink, Collaborati, Legal Tracker, Brightflag). Null if client does not use e-billing.',
    `electronic_billing_required_flag` BOOLEAN COMMENT 'Indicates whether the client requires electronic billing submission in Legal Electronic Data Exchange Standard (LEDES) format or through a third-party e-billing platform (e.g., Serengeti, CounselLink, Collaborati).',
    `first_engagement_date` DATE COMMENT 'Date of the first matter or engagement opened for this client. Represents the start of the client relationship with the firm.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the primary legal jurisdiction where the client is domiciled or incorporated. Used for conflict checking and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `kyc_completion_date` DATE COMMENT 'Date when the most recent KYC verification was completed and approved. Used to track KYC refresh requirements per firm policy.',
    `kyc_next_review_date` DATE COMMENT 'Scheduled date for the next periodic KYC review and refresh. Typically annual or biennial depending on client risk profile and firm policy.',
    `kyc_status` STRING COMMENT 'Current status of Know Your Client (KYC) due diligence and Anti-Money Laundering (AML) verification. Verified indicates completed and current KYC; pending indicates in progress; expired indicates refresh required; rejected indicates failed verification; not required indicates exemption.. Valid values are `pending|verified|expired|rejected|not_required`',
    `last_matter_date` DATE COMMENT 'Date of the most recent matter opened or activity recorded for this client. Used to identify dormant client relationships.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Indicates whether the client has provided consent to receive marketing communications, newsletters, event invitations, and thought leadership materials from the firm. Required for GDPR and CCPA compliance.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this client profile record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this client profile record was last modified. Updated whenever any attribute of the client profile is changed.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, relationship history, or other relevant information about the client that does not fit structured fields. May include relationship sensitivities, preferences, or historical context.',
    `outside_counsel_guidelines_flag` BOOLEAN COMMENT 'Indicates whether the client has published Outside Counsel Guidelines that govern billing practices, rate restrictions, staffing requirements, and matter management protocols.',
    `payment_terms_days` STRING COMMENT 'Standard payment terms for this client expressed in days (e.g., 30, 60, 90). Represents the number of days from invoice date that payment is due.',
    `preferred_billing_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the clients preferred currency for invoicing and billing (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Primary email address for client communications and correspondence. This is the main point of contact for general client matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for client contact. Includes country code and extension where applicable.',
    `retention_policy_years` STRING COMMENT 'Number of years that client records and matter files must be retained per firm policy, client agreement, or regulatory requirement. Typically ranges from 7 to 10 years for legal files.',
    `sanctions_screening_date` DATE COMMENT 'Date when the most recent sanctions screening was performed. Sanctions screening should be performed at client intake and periodically thereafter.',
    `sanctions_screening_status` STRING COMMENT 'Result of screening against sanctions lists (OFAC, UN, EU, etc.). Clear indicates no matches; match indicates potential sanctions hit requiring review; pending indicates screening in progress; not screened indicates screening not yet performed.. Valid values are `clear|match|pending|not_screened`',
    `tax_identifier` STRING COMMENT 'Tax identification number for the client entity. For US clients, this is the Employer Identification Number (EIN) or Social Security Number (SSN); for international clients, the equivalent national tax identifier. Used for tax reporting and compliance.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Unified client identity record serving as the firms Single Source of Truth for client master data across all practice areas and systems. Stores the canonical client_number (firm-assigned), client type (corporate, government, individual, prospective), client status (active, inactive, prospect, former, suspended), references to organisation or individual entity, originating partner, responsible relationship partner, primary practice area, client tier (platinum, gold, silver), AFA eligibility flag, preferred billing currency, billing address reference, client segment assignment, and date of first engagement. Acts as the central hub entity linking to KYC records, engagement scope, relationship teams, corporate hierarchies, and all matter/billing/conflict relationships. Every system interaction with a client resolves through this record. Sourced from Elite 3E client master.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record. Primary key for the contact entity.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Client contacts have is_pep, sanctions_screening_status, and kyc_verification_status fields but no FK to the AML program governing their screening. Legal firms screen key contacts (signatories, benefi',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Contact data processing must be registered under GDPR Article 30. Links contact records to the privacy register entry documenting lawful basis, retention, and data subject rights for client contact in',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Contact persons typically represent and work for organisational clients (corporate, government, institutional). While contact → client_profile exists, adding a direct FK to organisation provides busin',
    `profile_id` BIGINT COMMENT 'Reference to the client organization or individual this contact is associated with. A contact may be linked to multiple clients over time.',
    `address_line_1` STRING COMMENT 'First line of the contacts business address (street number and name).',
    `address_line_2` STRING COMMENT 'Second line of the contacts business address (suite, floor, building name).',
    `city` STRING COMMENT 'City or municipality of the contacts business address.',
    `contact_role` STRING COMMENT 'The functional role this contact serves in the client relationship (e.g., primary contact, billing contact, legal signatory, authorised representative, in-house counsel). A contact may hold multiple roles. [ENUM-REF-CANDIDATE: primary|billing|legal|signatory|authorised_representative|in_house_counsel|compliance_officer|board_member — 8 candidates stripped; promote to reference product]',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record (active, inactive, suspended, deceased, left organization).. Valid values are `active|inactive|suspended|deceased|left_organization`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the contacts business address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contact record was first created in the system.',
    `department` STRING COMMENT 'Business unit or department within the client organization where the contact is employed (e.g., Legal, Compliance, Corporate Affairs).',
    `direct_phone` STRING COMMENT 'Direct dial telephone number for the contact, bypassing switchboard or reception.',
    `email_address` STRING COMMENT 'Primary business email address for the contact. Used for engagement letters, matter communications, and billing correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Facsimile number for the contact, used for formal document transmission where required.',
    `first_name` STRING COMMENT 'Given name of the contact person.',
    `full_name` STRING COMMENT 'Complete legal name of the contact person, typically concatenated from first, middle, and last name components.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the contact is currently active and available for engagement communications.',
    `is_billing_contact` BOOLEAN COMMENT 'Indicates whether this contact is authorized to receive and approve invoices and billing communications.',
    `is_pep` BOOLEAN COMMENT 'Indicates whether the contact is identified as a Politically Exposed Person (PEP) for Anti-Money Laundering (AML) and Know Your Client (KYC) compliance purposes.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for the client organization.',
    `is_signatory` BOOLEAN COMMENT 'Indicates whether this contact has authority to sign engagement letters, Letter of Engagement (LOE), and other binding agreements on behalf of the client.',
    `job_title` STRING COMMENT 'Professional position or role title held by the contact within their organization (e.g., General Counsel (GC), Chief Legal Officer (CLO), Legal Director, In-House Counsel).',
    `kyc_verification_date` DATE COMMENT 'Date when Know Your Client (KYC) verification was completed for this contact.',
    `kyc_verification_status` STRING COMMENT 'Status of Know Your Client (KYC) verification for this contact (verified, pending, failed, not required).. Valid values are `verified|pending|failed|not_required`',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code representing the contacts preferred language for communications (e.g., en, fr, es, de).. Valid values are `^[a-z]{2}$`',
    `last_contact_date` DATE COMMENT 'Date of the most recent communication or interaction with this contact.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the contact record was last updated or modified.',
    `last_name` STRING COMMENT 'Family name or surname of the contact person.',
    `linkedin_profile_url` STRING COMMENT 'URL to the contacts professional LinkedIn profile, used for relationship intelligence and business development.',
    `middle_name` STRING COMMENT 'Middle name or initial of the contact person.',
    `mobile_phone` STRING COMMENT 'Mobile or cellular telephone number for the contact, used for urgent communications.',
    `notes` STRING COMMENT 'Free-text notes and observations about the contact, including communication preferences, relationship history, and special considerations.',
    `office_phone` STRING COMMENT 'Main office telephone number for the contact, may route through switchboard.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the contacts business address.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for matter updates and correspondence.. Valid values are `email|phone|mobile|fax|mail|portal`',
    `professional_profile_url` STRING COMMENT 'URL to the contacts professional profile on other platforms (e.g., company website, professional directory).',
    `salutation` STRING COMMENT 'Formal title or honorific used when addressing the contact. [ENUM-REF-CANDIDATE: Mr|Ms|Mrs|Dr|Prof|Hon|Sir|Dame — 8 candidates stripped; promote to reference product]',
    `sanctions_screening_date` DATE COMMENT 'Date when the most recent sanctions screening was performed for this contact.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions list screening for the contact (clear, match found, pending review, not yet screened). Critical for AML compliance and conflict checking.. Valid values are `clear|match|pending_review|not_screened`',
    `signatory_authority_level` STRING COMMENT 'The level of signing authority the contact holds (unlimited, limited to specific matter types, threshold-based on value, or none).. Valid values are `unlimited|limited|threshold_based|none`',
    `state_province` STRING COMMENT 'State, province, or region of the contacts business address.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts location (e.g., America/New_York, Europe/London), used for scheduling meetings and calls.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual persons who serve as points of contact, authorised representatives, or signatories for organisation and individual client relationships. Captures contact full name, job title, department, direct phone, mobile, email, preferred communication channel, contact role (primary, billing, legal, signatory, authorised representative, in-house counsel), active flag, LinkedIn/professional profile URL, and PEP/sanctions screening status. A single organisation may have multiple contacts across different roles; a contact may be associated with multiple organisations (e.g., in-house counsel moving between clients). Critical for conflict checking (contacts as parties), engagement letter execution (signatories), and day-to-day matter communication. Sourced from Microsoft Dynamics 365 CRM and Elite 3E.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`address` (
    `address_id` BIGINT COMMENT 'Unique identifier for the address record. Primary key.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: The address table is the multi-purpose address registry for all client-domain entities, yet it currently has no FK to client_contact despite client_contact embedding its own address fields (address_li',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Addresses can belong directly to individual clients (residential address, correspondence address). The existing client_id is too generic; we need a specific FK to individual for addresses that belong ',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Addresses can belong directly to organisational clients (registered office, billing address, service of process address). The existing client_id is too generic; we need a specific FK to organisation f',
    `profile_id` BIGINT COMMENT 'Reference to the client entity (organisation or individual) to which this address belongs. Links to the client master record.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active indicates currently in use; inactive indicates no longer used but retained for history; pending indicates awaiting validation or approval; historical indicates archived for compliance retention.. Valid values are `active|inactive|pending|historical`',
    `address_type` STRING COMMENT 'Classification of the address purpose. Registered office is the legal domicile; principal place of business is operational headquarters; billing is for invoicing; correspondence is for general mail; service of process is for legal notice delivery; branch office is for subsidiary locations.. Valid values are `registered_office|principal_place_of_business|billing|correspondence|service_of_process|branch_office`',
    `client_profile_fk` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — Addresses are associated with client profiles for billing, correspondence, and service of process. This is the primary address-to-client association needed for invoice generation and regulatory corres',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the data platform. Supports audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_from_date` DATE COMMENT 'Date from which this address becomes active and valid for use. Supports temporal address tracking required for service of process historical accuracy and regulatory audit trails.',
    `effective_to_date` DATE COMMENT 'Date until which this address remains active. Null indicates current/active address. Supports temporal address tracking for regulatory compliance and historical service of process records.',
    `is_billing_address` BOOLEAN COMMENT 'Boolean flag indicating whether this address is used for billing and invoicing purposes. True indicates billing address; false indicates non-billing. Critical for invoice delivery and accounts receivable (AR) processing.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary address for the client. True indicates primary; false indicates secondary/alternate. Only one address per client per address type should be primary at any given time.',
    `is_service_of_process_address` BOOLEAN COMMENT 'Boolean flag indicating whether this address is designated for legal service of process. True indicates service address; false indicates non-service. Critical for litigation, court filings, and regulatory notice delivery. Must maintain historical accuracy for legal compliance.',
    `jurisdiction_code` STRING COMMENT 'Legal jurisdiction code derived from the address location. Used for regulatory compliance determination, court venue selection, and applicable law identification. May reference state bar jurisdiction, federal district, or international jurisdiction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last updated. Supports change tracking, audit trail, and data quality monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees. Used for geospatial analytics, proximity searches, and location-based reporting. Range: -90.0000000 to +90.0000000.',
    `line_1` STRING COMMENT 'Primary address line containing street number, street name, and building identifier. Required for all address types. Organizational contact data classified as confidential.',
    `line_2` STRING COMMENT 'Secondary address line for suite, floor, apartment, or unit number. Optional field for additional location detail. Organizational contact data classified as confidential.',
    `line_3` STRING COMMENT 'Tertiary address line for additional location details such as building name, complex, or district. Optional field. Organizational contact data classified as confidential.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees. Used for geospatial analytics, proximity searches, and location-based reporting. Range: -180.0000000 to +180.0000000.',
    `notes` STRING COMMENT 'Free-text field for additional address-related information, special delivery instructions, access codes, or contextual details not captured in structured fields. Supports operational use cases and client service requirements.',
    `postal_validation_status` STRING COMMENT 'Indicates whether the address has been validated against postal authority databases. Validated addresses ensure accurate service of process and billing delivery. Pending validation indicates address awaiting verification; invalid indicates failed validation.. Valid values are `validated|unvalidated|invalid|pending_validation`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this address was sourced. Elite 3E for practice management addresses; Microsoft Dynamics 365 for CRM addresses; manual entry for user-created records; data migration for legacy system imports.. Valid values are `elite_3e|microsoft_dynamics_365|manual_entry|data_migration`',
    `source_system_code` STRING COMMENT 'Original identifier of the address record in the source system. Maintains traceability to operational system of record for data lineage and reconciliation purposes.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, Europe/London). Used for scheduling, deadline calculation, and time-sensitive legal filings. Critical for multi-jurisdiction matter management.',
    `to_client_profile` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — Addresses resolve to client profiles for billing, correspondence, and service of process',
    `validation_date` DATE COMMENT 'Date when the address was last validated against postal authority databases. Supports audit trail for service of process accuracy and regulatory compliance.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Multi-purpose address registry for all client-domain entities (organisations, individuals, client profiles). Captures address type (registered office, principal place of business, billing, correspondence, service of process), address lines 1-3, city, state/province, postal code, country ISO code, geocode coordinates, postal validation status, effective date, and expiry date. Supports temporal address tracking for regulatory purposes (service of process requires historical accuracy) and multi-address clients. Critical for billing address resolution, court filing service addresses, and regulatory jurisdiction determination. Sourced from Elite 3E and Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`corporate_hierarchy` (
    `corporate_hierarchy_id` BIGINT COMMENT 'Unique identifier for the corporate hierarchy relationship record. Primary key for the corporate hierarchy entity.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Corporate hierarchy has aml_screening_date, aml_screening_status, and kyc_risk_rating but no FK to the AML program governing group-level screening. Legal firms apply AML programs at the corporate grou',
    `profile_id` BIGINT COMMENT 'Identifier of the child organization in the corporate hierarchy relationship. References the subsidiary, affiliate, or controlled entity in the corporate family tree.',
    `organisation_id` BIGINT COMMENT 'FK to client.organisation.organisation_id — Corporate hierarchy records must reference the child organisation. Both ends of the parent-child relationship must be FK-constrained to organisation.',
    `parent_organisation_id` BIGINT COMMENT 'FK to client.organisation.organisation_id — Corporate hierarchy models parent-child relationships between organisations — both parent and child FK to organisation',
    `primary_corporate_organisation_id` BIGINT COMMENT 'FK to client.organisation.organisation_id — Corporate hierarchy records must reference the parent organisation. This is definitional — the hierarchy IS the parent-child relationship between organisations.',
    `primary_corporate_profile_id` BIGINT COMMENT 'Identifier of the parent organization in the corporate hierarchy relationship. References the controlling or owning entity in the corporate family tree.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Corporate hierarchy has regulatory_filing_reference and kyc_risk_rating but no FK to the regulatory obligation driving group-level disclosure requirements (e.g. PSC register, beneficial ownership dire',
    `aml_screening_date` DATE COMMENT 'Date when the most recent AML (Anti-Money Laundering) screening was performed for the corporate hierarchy relationship. Used to track compliance with periodic screening requirements.',
    `aml_screening_status` STRING COMMENT 'Status of AML (Anti-Money Laundering) screening for the corporate hierarchy relationship. Indicates whether the relationship has been screened against sanctions lists and watchlists and the outcome of that screening.. Valid values are `cleared|flagged|pending|requires_review|escalated`',
    `billing_consolidation_type` STRING COMMENT 'Classification of how billing should be handled for matters involving entities in this corporate hierarchy relationship. Determines whether invoices are consolidated at the parent level or issued separately.. Valid values are `consolidated|separate|hybrid|parent_pays|child_pays`',
    `conflict_check_scope` STRING COMMENT 'Indicator of whether this corporate hierarchy relationship should be automatically included in conflict-of-interest checks. Defines the scope of conflict analysis for engagement acceptance decisions.. Valid values are `include|exclude|conditional|manual_review`',
    `consolidation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the child entity should be consolidated with the parent for billing, reporting, or conflict-checking purposes. True indicates consolidation is required; False indicates separate treatment. Used for group-level billing arrangements and consolidated conflict analysis.',
    `control_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the parent organization exercises operational or strategic control over the child organization, regardless of ownership percentage. True indicates control exists; False indicates no control. Critical for conflict-of-interest determinations under ABA (American Bar Association) rules.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the corporate hierarchy relationship record. Supports audit trail and accountability for data entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corporate hierarchy relationship record was first created in the system. Used for audit trail and data lineage tracking.',
    `cross_border_flag` BOOLEAN COMMENT 'Boolean indicator of whether the corporate hierarchy relationship crosses international borders (parent and child in different countries). True indicates cross-border relationship; False indicates domestic relationship. Important for regulatory compliance and conflict analysis.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 1.00) representing the assessed quality and completeness of the corporate hierarchy relationship data. Higher scores indicate more complete and verified data. Used for data governance and prioritizing data improvement efforts.',
    `effective_date` DATE COMMENT 'Date when the corporate hierarchy relationship became effective or was established. Used for temporal conflict checking and historical relationship tracking.',
    `expiry_date` DATE COMMENT 'Date when the corporate hierarchy relationship ended or is scheduled to end. Null for ongoing relationships. Critical for temporal conflict analysis and engagement scope validation.',
    `hierarchy_level` STRING COMMENT 'Numeric indicator of the depth or level of the child organization within the corporate hierarchy tree, with 1 representing the top level. Used for hierarchy traversal, visualization, and understanding organizational complexity.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the corporate hierarchy relationship record is currently active and should be used in operational processes. True indicates active; False indicates inactive or archived. Used for filtering current relationships in conflict checking and reporting.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or country where the corporate relationship is registered or governed. Uses ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU). Important for regulatory compliance, conflict checking across jurisdictions, and understanding legal frameworks governing the relationship.',
    `kyc_risk_rating` STRING COMMENT 'Risk rating assigned to the corporate hierarchy relationship based on KYC (Know Your Client) and AML (Anti-Money Laundering) assessment. Reflects the compliance risk associated with the relationship structure.. Valid values are `low|medium|high|critical`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the corporate hierarchy relationship record. Supports audit trail and accountability for data changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corporate hierarchy relationship record was last modified or updated. Used for audit trail, change tracking, and data quality monitoring.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the corporate hierarchy relationship. May include special instructions for conflict checking, billing arrangements, or other relevant operational details.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or equity stake that the parent organization holds in the child organization. Expressed as a decimal percentage (0.00 to 100.00). Used for conflict checking, consolidation decisions, and understanding control relationships.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Boolean indicator of whether the corporate hierarchy relationship is publicly disclosed through regulatory filings, annual reports, or other public sources. True indicates public disclosure; False indicates private or undisclosed relationship.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier of the regulatory filing or public document that discloses or evidences the corporate hierarchy relationship. Used for verification and audit purposes.',
    `relationship_description` STRING COMMENT 'Free-text description providing additional context or details about the corporate hierarchy relationship. May include information about the nature of the business relationship, special circumstances, or relevant background for conflict analysis.',
    `relationship_source` STRING COMMENT 'Source or origin of the corporate hierarchy relationship information. Indicates how the relationship was identified and documented. Used for data quality assessment and audit trail purposes.. Valid values are `client_disclosure|public_filing|due_diligence|third_party_database|internal_research|regulatory_filing`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the corporate hierarchy relationship. Indicates whether the relationship is currently in force, pending approval, or has been terminated. Used to filter active relationships for conflict checking.. Valid values are `active|inactive|pending|dissolved|under_review|suspended`',
    `relationship_type` STRING COMMENT 'Classification of the corporate relationship between parent and child entities. Defines the nature of control, ownership, or affiliation. Critical for conflict-of-interest analysis and engagement scope determination.. Valid values are `wholly_owned_subsidiary|majority_owned|minority_stake|affiliate|joint_venture|branch`',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which the corporate hierarchy relationship data originated. Examples include Intapp Conflicts, Elite 3E, Microsoft Dynamics 365, or external data providers. Used for data lineage and integration tracking.',
    `source_system_code` STRING COMMENT 'Unique identifier of the corporate hierarchy relationship record in the source system. Used for data reconciliation, integration, and traceability back to the system of record.',
    `verification_date` DATE COMMENT 'Date when the corporate hierarchy relationship was last verified or validated. Used to track data freshness and trigger periodic re-verification for KYC (Know Your Client) and conflict-checking purposes.',
    `verification_status` STRING COMMENT 'Status of verification for the corporate hierarchy relationship data. Indicates whether the relationship has been confirmed through authoritative sources. Critical for KYC (Know Your Client) and AML (Anti-Money Laundering) compliance.. Valid values are `verified|unverified|pending_verification|disputed|requires_update`',
    `verified_by` STRING COMMENT 'Name or identifier of the person, system, or third-party service that verified the corporate hierarchy relationship. Supports audit trail and data quality accountability.',
    CONSTRAINT pk_corporate_hierarchy PRIMARY KEY(`corporate_hierarchy_id`)
) COMMENT 'Models the parent-subsidiary and affiliated-entity relationships within a corporate client group. Captures parent organisation, child organisation, relationship type (wholly owned subsidiary, majority-owned, minority stake, affiliate, joint venture, branch), ownership percentage, effective date, expiry date, jurisdiction of the relationship, and consolidation flag. Critical for conflict-of-interest checking (Intapp Conflicts), matter origination, and group-level billing arrangements. Enables traversal of the full corporate family tree for AML/KYC and engagement scope purposes.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`kyc_record` (
    `kyc_record_id` BIGINT COMMENT 'Unique identifier for the KYC/AML due diligence dossier. Primary key for the KYC record entity.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: KYC reviews are conducted under the firms AML/KYC program framework. Each KYC record must reference which program version and requirements it satisfies, essential for regulatory audit trails and prog',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: KYC regulatory compliance requires linking KYC records to their supporting legal documents (passports, corporate certificates, source-of-funds evidence). dms_folder_reference is a denormalized text re',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: KYC requirements in legal firms are triggered by specific service types (e.g., M&A, trust formation, AML-sensitive transactions). Linking kyc_record to legal_service enables compliance teams to enforc',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: KYC records are conducted under firm compliance policies (e.g. Client Acceptance Policy, AML Policy). Linking kyc_record to the governing compliance policy supports audit trails showing which policy v',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: KYC risk ratings and review cycles vary by practice area (e.g., enhanced KYC for corporate finance vs. standard for employment). Linking kyc_record to practice_area supports compliance reporting, risk',
    `profile_id` BIGINT COMMENT 'Reference to the client entity for whom this KYC dossier was prepared. Links to the client master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: KYC reviews are performed to satisfy specific regulatory obligations (MLR 2017, SRA Standards). Links each KYC record to the primary regulatory obligation it fulfills, essential for demonstrating comp',
    `adverse_media_screening_date` DATE COMMENT 'Date on which the most recent adverse media screening was performed.',
    `adverse_media_screening_result` STRING COMMENT 'Outcome of screening for negative news or adverse media coverage related to the client, including fraud, corruption, or financial crime allegations.. Valid values are `clear|adverse_found|pending_review`',
    `aml_risk_rating` STRING COMMENT 'Overall AML risk classification assigned to the client based on jurisdiction, business type, source of funds, and PEP status. Prohibited indicates client cannot be onboarded.. Valid values are `low|medium|high|prohibited`',
    `beneficial_ownership_register_reference` STRING COMMENT 'Reference number or document identifier for the beneficial ownership register or declaration submitted by the client.',
    `beneficial_ownership_verified` BOOLEAN COMMENT 'Indicates whether the ultimate beneficial owners (UBOs) of the client entity have been identified and verified, as required for corporate clients.',
    `business_nature_description` STRING COMMENT 'Description of the clients business activities, industry sector, and commercial purpose. Used to assess inherent AML risk.',
    `client_profile_fk` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — Every KYC record is performed FOR a specific client. This is the mandatory association — without it, KYC records cannot be matched to clients for compliance reporting and audit.',
    `compliance_notes` STRING COMMENT 'Free-text notes recorded by the compliance officer during the KYC review, including rationale for risk rating, escalation decisions, or special considerations. Business-confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYC record was first created in the system. Audit trail for record inception.',
    `escalation_reason` STRING COMMENT 'Description of the reason for escalation (e.g., PEP identified, sanctions match, high-risk jurisdiction, adverse media). Business-confidential.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the KYC review identified issues requiring escalation to senior compliance officer, general counsel, or risk committee.',
    `expected_transaction_volume` STRING COMMENT 'Anticipated volume of legal services or financial transactions the client will conduct with the firm. Used for ongoing monitoring and anomaly detection.. Valid values are `low|medium|high|very_high`',
    `high_risk_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether the client is incorporated in or operates from a jurisdiction identified by FATF or other bodies as high-risk for money laundering or terrorist financing.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this is the current active KYC dossier for the client. Only one active dossier per client; historical records retained for audit.',
    `jurisdiction_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where the client entity is incorporated or domiciled. Used for risk assessment.. Valid values are `^[A-Z]{3}$`',
    `kyc_approval_date` DATE COMMENT 'Date on which the KYC dossier was approved by the compliance officer or designated authority, authorizing client onboarding.',
    `kyc_document_count` STRING COMMENT 'Total number of supporting documents attached to this KYC dossier (certificates, passports, utility bills, etc.). Tracked in child document lines.',
    `kyc_expiry_date` DATE COMMENT 'Date on which the KYC dossier expires and must be refreshed. Typically 1-3 years from approval date depending on risk tier.',
    `kyc_reference_number` STRING COMMENT 'Externally-visible business identifier for the KYC dossier, used in compliance reporting and audit trails.. Valid values are `^KYC-[0-9]{8,12}$`',
    `kyc_review_date` DATE COMMENT 'Date on which the KYC review assessment was conducted or last updated. Principal business event timestamp for the dossier.',
    `kyc_status` STRING COMMENT 'Current lifecycle status of the KYC dossier. Approved allows client onboarding; expired requires refresh; rejected blocks engagement.. Valid values are `pending|approved|rejected|expired|under_review`',
    `kyc_tier` STRING COMMENT 'Level of due diligence applied: standard (normal risk), enhanced (high risk or PEP), simplified (low risk). Determines depth of verification required.. Valid values are `standard|enhanced|simplified`',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the KYC record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYC record was last updated. Tracks most recent change for audit and version control.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic KYC review. Triggers compliance workflow to refresh documentation and re-assess risk.',
    `pep_screening_date` DATE COMMENT 'Date on which the most recent PEP screening was performed. Must be refreshed periodically per firm policy.',
    `pep_screening_result` STRING COMMENT 'Outcome of screening to determine if the client or beneficial owners are politically exposed persons (PEPs), requiring enhanced due diligence.. Valid values are `not_pep|pep_identified|pending_review`',
    `reviewer_name` STRING COMMENT 'Full name of the compliance officer or partner who conducted the KYC review, for audit trail and accountability.',
    `sanctions_screening_date` DATE COMMENT 'Date on which the most recent sanctions screening was performed. Must be refreshed periodically per firm policy.',
    `sanctions_screening_result` STRING COMMENT 'Outcome of screening the client and beneficial owners against international sanctions lists (OFAC, UN, EU, etc.). Match found requires escalation.. Valid values are `clear|match_found|pending_review`',
    `source_of_funds_description` STRING COMMENT 'Narrative description of the clients source of funds (e.g., salary, business income, inheritance, investment returns). Business-confidential information.',
    `source_of_funds_verified` BOOLEAN COMMENT 'Indicates whether the origin of the clients funds has been verified and documented in accordance with AML requirements.',
    `to_client_profile` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — Each client profile has one active KYC dossier — this is the primary compliance linkage',
    `version_number` STRING COMMENT 'Version number of the KYC dossier. Incremented with each refresh or material update. Supports regulatory audit trail.',
    CONSTRAINT pk_kyc_record PRIMARY KEY(`kyc_record_id`)
) COMMENT 'Complete KYC/AML due diligence dossier for each client, structured as a header (review assessment) with child document lines. Header captures: KYC review date, reviewer identity, KYC tier (standard, enhanced, simplified), AML risk rating (low, medium, high, prohibited), source of funds verification status, beneficial ownership verification status, sanctions screening result, PEP screening result, next review due date, and KYC expiry date. Child document lines track each supporting document (certificates of incorporation, passports, utility bills, beneficial ownership registers, sanctions clearance certificates) with document type, issuing authority, reference number, issue/expiry dates, verification method (original, certified copy, electronic), verifying officer, DMS storage reference (iManage document_id), and document status (pending, verified, expired, rejected). This product is the SINGLE authoritative owner of all KYC document metadata within the client domain. Each client profile has one active KYC dossier; historical records retained for regulatory audit. Supports FATF, AML, SRA, and GDPR compliance obligations. Sourced from Intapp Conflicts and firm compliance workflows.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the client segment. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Segment defines requires_kyc_enhanced and requires_aml_screening thresholds. The regulatory obligation mandating enhanced due diligence for a client tier (e.g. high-risk jurisdiction rules, PEP regula',
    `applicable_practice_areas` STRING COMMENT 'Comma-separated list of practice area codes where this segment is applicable (e.g., CORP, LIT, IP, TAX, EMPLOY). Used to filter segment options during matter intake based on practice area. Null or ALL indicates segment applies to all practice areas.',
    `approval_date` DATE COMMENT 'Date when the segment definition was approved by partnership or pricing committee. Used for audit trail and effective date validation.',
    `assigned_bd_team` STRING COMMENT 'Name or identifier of the BD team responsible for relationship management, pipeline development, and client acquisition for this segment. Used in Microsoft Dynamics 365 CRM for lead routing and opportunity assignment.',
    `client_count` STRING COMMENT 'Current number of active clients assigned to this segment. Updated periodically during segment review cycles. Used for segment size analysis and resource planning.',
    `conflict_check_intensity` STRING COMMENT 'Level of conflict checking rigor required for clients in this segment. Standard for routine matters, Enhanced for complex corporate transactions, Comprehensive for high-profile litigation or M&A. Drives Intapp Conflicts search scope and review requirements.. Valid values are `standard|enhanced|comprehensive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system. Used for audit trail and data lineage tracking.',
    `cross_sell_priority` STRING COMMENT 'Priority level for cross-selling additional practice area services to clients in this segment. High priority segments receive proactive cross-sell campaigns and dedicated BD resources. Used in Microsoft Dynamics 365 CRM for opportunity targeting.. Valid values are `high|medium|low`',
    `discount_authority_level` STRING COMMENT 'Organizational level required to approve discounts beyond the standard discount percentage for this segment. Ensures pricing governance and margin protection aligned with segment strategy.. Valid values are `partner|practice_group_leader|pricing_committee|managing_partner`',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or superseded. Null for currently active segments. Used to maintain historical segment assignments for billing and reporting purposes.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became effective and available for client assignment. Used for historical segment analysis and rate card versioning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last updated. Used for change tracking and data synchronization across Elite 3E, Microsoft Dynamics 365 CRM, and analytics platforms.',
    `last_review_date` DATE COMMENT 'Date when this segment definition was last formally reviewed by pricing and BD leadership. Used to track governance compliance and trigger upcoming review notifications.',
    `minimum_revenue_threshold` DECIMAL(18,2) COMMENT 'Minimum annual revenue threshold (in firm base currency) required for a client to qualify for this segment. Used during client intake and annual segment review processes. Null for segments without revenue criteria (e.g., pro bono, government).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this segment definition. Calculated based on segment_review_cycle. Used for governance workflow automation and leadership calendar planning.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or historical notes about the segment. Used by pricing and BD teams for segment strategy documentation and institutional knowledge capture.',
    `partner_attention_required` BOOLEAN COMMENT 'Indicates whether clients in this segment require direct partner involvement in all matters. True for strategic segments where partner relationship management is mandatory. Drives matter staffing and partner time allocation.',
    `preferred_afa_types` STRING COMMENT 'Comma-separated list of preferred AFA types for this segment (e.g., Fixed Fee, Capped Fee, Success Fee, Blended Rate, Retainer). Guides pricing discussions during engagement setup. Null indicates standard hourly billing preference.',
    `requires_aml_screening` BOOLEAN COMMENT 'Indicates whether clients in this segment require AML sanctions screening and ongoing monitoring. True for segments with elevated financial crime risk. Integrated with Intapp Conflicts for automated screening workflows.',
    `requires_kyc_enhanced` BOOLEAN COMMENT 'Indicates whether clients in this segment require enhanced KYC due diligence beyond standard intake procedures. True for high-risk segments (e.g., foreign government, high-value transactions). Drives conflict checking and AML screening requirements.',
    `review_cycle` STRING COMMENT 'Frequency at which this segment definition, criteria, and client assignments are formally reviewed by pricing and BD leadership. Annual is most common; strategic segments may be reviewed quarterly.. Valid values are `annual|semi_annual|quarterly|ad_hoc`',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the segment (e.g., GLOBAL500, MIDMKT, GOVPUB, HNWI, STARTUP). Used as business identifier in Elite 3E rate card selection and Microsoft Dynamics 365 CRM pipeline segmentation.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `segment_description` STRING COMMENT 'Detailed narrative describing the segment characteristics, target client profile, strategic importance, and business rationale for segmentation. Used by BD teams and pricing committees for segment strategy alignment.',
    `segment_name` STRING COMMENT 'Full descriptive name of the client segment (e.g., Global 500, Mid-Market Corporate, Government & Public Sector, High Net Worth Individual, Start-up & Emerging Growth). Primary human-readable identifier used across all client-facing and internal reporting.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment. Active segments are used for new client classification and rate card assignment. Inactive segments are retained for historical reporting only. Under review indicates pending partnership approval for changes. Deprecated segments are being phased out.. Valid values are `active|inactive|under_review|deprecated`',
    `segment_tier` STRING COMMENT 'Hierarchical tier classification of the segment indicating strategic priority and resource allocation level. Tier 1 represents highest-value segments with dedicated partner attention; Tier 4 represents standard service segments.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `sla_response_time_hours` STRING COMMENT 'Maximum hours for initial response to client inquiries for this segment. Used to set client expectations and measure service delivery performance. Tier 1 segments typically have shorter response times (e.g., 4 hours) than lower tiers.',
    `standard_discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount percentage off standard rates approved for this segment. Applied automatically in Elite 3E rate card selection unless matter-specific override is authorized. Null indicates no standard discount.',
    `target_client_type` STRING COMMENT 'Primary client entity type this segment is designed to serve. Corporate for business entities, Government for public sector agencies, Individual for HNWIs and personal clients, Non-Profit for charitable organizations, Mixed for segments serving multiple types.. Valid values are `corporate|government|individual|non_profit|mixed`',
    `target_realization_rate` DECIMAL(18,2) COMMENT 'Target realization rate (percentage of standard rates actually billed and collected) for this segment. Used to measure pricing effectiveness and write-off performance. Typically ranges from 85% to 100%.',
    `target_rpe` DECIMAL(18,2) COMMENT 'Target annual revenue per equity partner for clients in this segment. Used for segment performance measurement and partner compensation allocation. Null for segments without RPE targets.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Reference master defining the firms client segmentation taxonomy used for relationship management, pricing strategy, rate card selection, and business development targeting. Each segment record captures segment code, segment name (e.g., Global 500, Mid-Market Corporate, Government & Public Sector, High Net Worth Individual, Start-up & Emerging Growth), segment description, applicable practice areas, minimum revenue threshold, preferred AFA types, assigned BD team, segment review cycle, and segment-level discount authority. Segments drive rate card selection in Elite 3E, pipeline segmentation in Microsoft Dynamics 365 CRM, and partner compensation allocation. Maintained by the firms pricing and BD leadership; changes require partnership approval. Typically 8-15 active segments at any time.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`relationship_team` (
    `relationship_team_id` BIGINT COMMENT 'Unique identifier for the relationship team assignment record.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Relationship team members are assigned to cover specific practice areas for a client. This FK replaces the denormalized practice_area_coverage text field, enabling cross-sell targeting reports, conf',
    `profile_id` BIGINT COMMENT 'Reference to the client entity for whom this relationship team is assigned.',
    `approval_date` DATE COMMENT 'The date on which this relationship team assignment was formally approved by the authorizing partner.',
    `assignment_end_date` DATE COMMENT 'The date on which this timekeepers assignment to this relationship team role ended. Null indicates an active assignment.',
    `assignment_notes` STRING COMMENT 'Additional free-text notes or comments regarding this relationship team assignment. May include special instructions, client preferences, or coordination requirements.',
    `assignment_reason` STRING COMMENT 'Free-text explanation of why this timekeeper was assigned to this relationship team role. May reference practice area expertise, industry knowledge, geographic coverage, client preference, or succession planning.',
    `assignment_start_date` DATE COMMENT 'The date on which this timekeeper was assigned to this relationship team role for the client.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this relationship team assignment. Active assignments are operational; Inactive assignments are historical; Suspended assignments are temporarily paused; Pending Approval assignments await partner approval.. Valid values are `active|inactive|suspended|pending_approval`',
    `billing_authority_level` STRING COMMENT 'Defines the level of billing authority this timekeeper has for matters related to this client. Full Authority can approve invoices independently; Approval Required must escalate; View Only can review but not approve; No Access cannot view billing information.. Valid values are `full_authority|approval_required|view_only|no_access`',
    `client_contact_frequency` STRING COMMENT 'The expected frequency of proactive client contact for this timekeeper in this role. Used in relationship management planning and client engagement tracking.. Valid values are `weekly|bi_weekly|monthly|quarterly|as_needed`',
    `client_profile_fk` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — Relationship teams are assigned TO a client. Without this FK, you cannot determine which partners and BD managers are responsible for which clients — breaking RPE reporting and escalation routing.',
    `client_satisfaction_responsibility` BOOLEAN COMMENT 'Indicates whether this timekeeper is responsible for monitoring and reporting on client satisfaction metrics for this client. Used in client retention and service quality tracking.',
    `conflict_check_authority` BOOLEAN COMMENT 'Indicates whether this timekeeper has authority to approve conflict check clearances for new matters involving this client. Typically granted to Client Relationship Partners and Supervising Partners.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this relationship team assignment record was first created in the system.',
    `cross_sell_target_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper has active cross-sell or upsell targets for this client relationship. Used in Business Development (BD) pipeline management and opportunity tracking in Microsoft Dynamics 365.',
    `effective_date` DATE COMMENT 'The date from which this relationship team assignment becomes operationally effective. May differ from assignment_start_date for planned future assignments.',
    `escalation_priority` STRING COMMENT 'Numeric priority order for escalating client issues to this timekeeper. Lower numbers indicate higher priority. Used in automated escalation routing for client service delivery.',
    `geographic_coverage_region` STRING COMMENT 'The geographic region or jurisdiction this timekeeper is responsible for covering within the client relationship. Supports multi-jurisdictional client service coordination.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this timekeeper is the primary point of contact for the client within their assigned role. Used for escalation routing and client communication prioritization.',
    `last_client_contact_date` DATE COMMENT 'The most recent date this timekeeper had documented contact with the client in this relationship role. Used for relationship health monitoring and engagement gap analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this relationship team assignment record was most recently updated.',
    `next_scheduled_contact_date` DATE COMMENT 'The next planned date for this timekeeper to contact the client in this relationship role. Supports proactive relationship management and follow-up tracking.',
    `notification_preference` STRING COMMENT 'Defines the level of client-related notifications this timekeeper wishes to receive for this assignment. Supports communication workflow automation in Microsoft Dynamics 365.. Valid values are `all_communications|critical_only|escalations_only|none`',
    `origination_credit_percentage` DECIMAL(18,2) COMMENT 'The percentage of origination credit allocated to this timekeeper for this client relationship. Used in Revenue Per Equity Partner (RPE) and Profit Per Partner (PPP) calculations. Sum across all team members for a client should equal 100%.',
    `relationship_role_type` STRING COMMENT 'The specific role this timekeeper plays in the client relationship team. Client Relationship Partner (CRP) is the primary relationship owner; Originating Partner brought the client to the firm; Supervising Partner oversees matter execution; Relationship Manager handles day-to-day coordination; Business Development Manager drives pipeline and cross-sell; Supporting Fee Earner provides specialized expertise.. Valid values are `client_relationship_partner|originating_partner|supervising_partner|relationship_manager|business_development_manager|supporting_fee_earner`',
    `responsibility_percentage` DECIMAL(18,2) COMMENT 'The percentage of relationship responsibility allocated to this timekeeper for ongoing client management and service delivery. Used in partner performance evaluation and compensation allocation.',
    `source_system` STRING COMMENT 'The operational system from which this relationship team assignment record originated. Elite 3E for practice management assignments; Microsoft Dynamics 365 for CRM-driven assignments; Intapp Conflicts for conflict-cleared assignments; Manual Entry for ad-hoc assignments.. Valid values are `elite_3e|microsoft_dynamics_365|intapp_conflicts|manual_entry`',
    `source_system_code` STRING COMMENT 'The unique identifier of this relationship team assignment record in the source operational system. Used for data lineage and reconciliation.',
    `succession_plan_flag` BOOLEAN COMMENT 'Indicates whether this assignment is part of a formal succession plan to transition client relationship ownership. Used in partner retirement planning and relationship continuity management.',
    `to_client_profile` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — Relationship teams are assigned per client — critical for CRP accountability and escalation routing',
    CONSTRAINT pk_relationship_team PRIMARY KEY(`relationship_team_id`)
) COMMENT 'Defines the firm-side relationship team assigned to a client, capturing the client relationship partner (CRP), originating partner, supervising partner, relationship manager, business development manager, and supporting fee earners. Stores role type, assignment start date, assignment end date, primary contact flag, and notification preferences. Supports RPE/PPP reporting, client satisfaction tracking, and BD pipeline management in Microsoft Dynamics 365. Enables accountability and escalation routing for client service delivery.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`engagement_scope` (
    `engagement_scope_id` BIGINT COMMENT 'Unique identifier for the client-level engagement scope record. Primary key.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Client engagement scope has aml_risk_rating and kyc_documentation_status but no FK to the AML program governing matter intake compliance checks. Legal firms apply AML programs at the engagement scope ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Panel appointments and engagement scopes must comply with firm compliance policies (conflicts, AML, data protection). Links engagement terms to governing policies, ensuring client acceptance criteria ',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to service.delivery_model. Business justification: Client engagement scopes specify the agreed delivery approach (onshore, offshore, hybrid). Linking to delivery_model enforces contractual delivery constraints during matter staffing and legal project ',
    `doc_template_id` BIGINT COMMENT 'Reference to the standard engagement letter template or Letter of Engagement (LOE) template used for matters opened under this scope. Links to the firms document management system.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Client engagement scope defines which legal services a client is authorized to receive. This FK enforces service eligibility during matter opening and billing setup — a core legal practice management ',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Panel appointments and retainer arrangements in legal firms are structured as service packages. Linking engagement scope to package supports panel management, scope-of-work enforcement, and renewal tr',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Engagement scopes define the agreed billing arrangement (AFA, hourly, fixed fee). Linking to pricing_model enforces the contractual pricing framework during invoice generation and budget approval — a ',
    `profile_id` BIGINT COMMENT 'Reference to the client entity for whom this engagement scope is defined. Links to the client master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Engagement scope has gdpr_processing_basis, data_protection_classification, and geographic_jurisdictions_covered but no FK to the regulatory obligation driving those requirements. Legal firms must tra',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Engagement scopes govern SLA commitments per client. Linking to sla_template replaces the denormalized service_level_agreement_reference text field, enabling SLA enforcement during matter management',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Engagement scopes are tier-specific, governing service levels and pricing applicable to a client. Linking to tier enables tier-based SLA enforcement, billing validation, and partner approval workflows',
    `afa_framework_type` STRING COMMENT 'Type of Alternative Fee Arrangement (AFA) framework agreed for this engagement scope. Fixed_fee indicates a flat fee per matter; capped_fee indicates a maximum fee limit; contingency indicates success-based fees; blended_rate indicates a single rate for all timekeepers; hourly indicates traditional time-based billing. [ENUM-REF-CANDIDATE: fixed_fee|capped_fee|contingency|blended_rate|success_fee|retainer|hourly — 7 candidates stripped; promote to reference product]',
    `aml_risk_rating` STRING COMMENT 'Anti-Money Laundering (AML) risk rating assigned to this engagement scope based on client profile, jurisdictions, and service types. Used for compliance monitoring and enhanced due diligence requirements.. Valid values are `low|medium|high|very_high`',
    `authorised_practice_areas` STRING COMMENT 'Comma-separated list or structured text describing the practice areas the firm is authorized to provide services in under this scope (e.g., Corporate M&A, Employment Law, Intellectual Property). Defines the substantive legal domains covered.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this engagement scope automatically renews upon expiry unless either party provides termination notice. True indicates auto-renewal; false indicates explicit renewal required.',
    `billing_frequency` STRING COMMENT 'Agreed frequency for invoicing the client under this engagement scope. Monthly indicates invoices are issued monthly; upon_completion indicates invoicing occurs when matters are closed; milestone_based indicates invoicing tied to project milestones.. Valid values are `monthly|quarterly|semi_annually|annually|upon_completion|milestone_based`',
    `conflict_check_required` BOOLEAN COMMENT 'Boolean flag indicating whether a conflict check is required for each new matter opened under this engagement scope. True indicates conflict checks are mandatory; false indicates standing clearance has been granted.',
    `created_by_user_code` STRING COMMENT 'User identifier of the person who created this engagement scope record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement scope record was first created in the system. Used for audit trail and data lineage.',
    `data_protection_classification` STRING COMMENT 'Data protection classification level for client data handled under this engagement scope. Special_category indicates GDPR Article 9 special category data (e.g., health, biometric); highly_confidential indicates enhanced security measures required.. Valid values are `standard|confidential|highly_confidential|special_category`',
    `electronic_billing_required` BOOLEAN COMMENT 'Boolean flag indicating whether the client requires electronic billing submission (e.g., LEDES format) for invoices under this engagement scope. True indicates e-billing is mandatory; false indicates paper or PDF invoices are acceptable.',
    `excluded_services` STRING COMMENT 'Free-text description of services or practice areas explicitly excluded from this engagement scope. Clarifies boundaries and limitations of the firms authority (e.g., Litigation services excluded, No criminal defense work).',
    `gdpr_processing_basis` STRING COMMENT 'Legal basis under GDPR Article 6 for processing personal data under this engagement scope. Contract indicates processing is necessary for contract performance; legal_obligation indicates processing is required by law; legitimate_interest indicates processing is necessary for legitimate business interests.. Valid values are `consent|contract|legal_obligation|legitimate_interest`',
    `geographic_jurisdictions_covered` STRING COMMENT 'Comma-separated list of geographic jurisdictions (countries, states, regions) where the firm is authorized to provide services under this scope. Uses ISO 3166-1 alpha-3 country codes where applicable (e.g., USA, GBR, DEU).',
    `kyc_documentation_status` STRING COMMENT 'Status of Know Your Client (KYC) documentation and due diligence for this engagement scope. Complete indicates all required KYC documents are on file and current; expired indicates KYC refresh is needed.. Valid values are `complete|incomplete|pending|expired|not_required`',
    `ledes_format_version` STRING COMMENT 'Version of the Legal Electronic Data Exchange Standard (LEDES) format required for electronic billing submissions under this engagement scope. LEDES98B is the most common format; LEDES2000 includes additional fields.. Valid values are `LEDES98B|LEDES98BI|LEDES2000`',
    `matter_budget_approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether the client requires formal budget approval before commencing work on individual matters under this engagement scope. True indicates budgets must be submitted and approved; false indicates no formal budget process.',
    `modified_by_user_code` STRING COMMENT 'User identifier of the person who last modified this engagement scope record. Used for audit trail and change accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement scope record was last modified. Updated whenever any field in the record changes. Used for audit trail and change tracking.',
    `originating_office_code` STRING COMMENT 'Code identifying the firm office that originated this engagement scope and is responsible for client relationship management. Used for revenue allocation and reporting.',
    `panel_appointment_reference` STRING COMMENT 'External reference number or identifier for the panel appointment issued by the client, if this scope is a panel arrangement. Null for non-panel scopes.',
    `panel_expiry_date` DATE COMMENT 'Date on which the panel appointment or engagement scope expires. Null for open-ended arrangements. After this date, the firm must seek renewal or new authority.',
    `panel_start_date` DATE COMMENT 'Date on which the panel appointment or engagement scope becomes effective. Marks the beginning of the firms authority to provide services under this scope.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due under this engagement scope. Standard terms are typically 30, 60, or 90 days.',
    `preferred_counsel_designation` BOOLEAN COMMENT 'Boolean flag indicating whether the firm has been designated as preferred counsel for the client under this scope. True indicates preferred status; false indicates standard panel or non-preferred status.',
    `rate_card_reference` STRING COMMENT 'Reference identifier for the rate card or fee schedule applicable to this engagement scope. Links to the billing rate structure agreed with the client.',
    `renewal_notice_days` STRING COMMENT 'Number of days before panel_expiry_date that the firm must provide notice of intent to renew or terminate the engagement scope. Used for proactive relationship management and renewal planning.',
    `retention_period_years` STRING COMMENT 'Number of years that records and documents related to matters under this engagement scope must be retained after matter closure, per client requirements and regulatory obligations. Typical values range from 6 to 10 years.',
    `scope_approval_date` DATE COMMENT 'Date on which the engagement scope was formally approved by the client and the firms conflicts and risk committees. Represents the date of mutual agreement.',
    `scope_description` STRING COMMENT 'Detailed free-text description of the engagement scope, including any special terms, conditions, or operational notes. Provides context and clarification beyond structured fields.',
    `scope_name` STRING COMMENT 'Descriptive name or title for this engagement scope, summarizing the nature of the standing authority (e.g., Corporate Legal Panel 2024, Employment Law Retainer).',
    `scope_reference_number` STRING COMMENT 'Business-facing unique reference number for this engagement scope, used in communications and documentation. Typically alphanumeric code assigned by the firm.. Valid values are `^[A-Z0-9]{6,20}$`',
    `scope_status` STRING COMMENT 'Current lifecycle status of the engagement scope. Active indicates the firm is currently authorized to provide services under this scope; expired indicates the scope has lapsed.. Valid values are `active|inactive|suspended|pending|expired`',
    `scope_type` STRING COMMENT 'Classification of the engagement scope arrangement. Panel indicates the firm is on a legal panel; retainer indicates ongoing retained services; framework indicates a master services agreement; ad_hoc indicates project-based authority; preferred_counsel indicates designated counsel status.. Valid values are `panel|retainer|framework|ad_hoc|preferred_counsel`',
    `utbms_task_codes_required` BOOLEAN COMMENT 'Boolean flag indicating whether the client requires Uniform Task-Based Management System (UTBMS) task and activity codes on time entries and invoices under this engagement scope. True indicates UTBMS coding is mandatory.',
    CONSTRAINT pk_engagement_scope PRIMARY KEY(`engagement_scope_id`)
) COMMENT 'Defines the agreed scope of legal services the firm is authorised to provide to a client, as established at the client level (above individual matters). Captures authorised practice areas, geographic jurisdictions covered, excluded services, panel appointment reference, panel start date, panel expiry date, preferred counsel designation, rate card reference, AFA framework type, and scope approval date. Distinct from matter-level engagement letters (owned by the contract domain); this is the client-level standing authority. Sourced from Elite 3E and contract/CLM systems.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`beneficial_owner` (
    `beneficial_owner_id` BIGINT COMMENT 'Unique identifier for the beneficial owner record. Primary key.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Beneficial ownership identification is a core AML/KYC program requirement under MLR 2017. Each beneficial owner record must reference the program under which verification was conducted for regulatory ',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Beneficial ownership verification requires supporting legal documents (identity documents, corporate ownership certificates). verification_document_reference is a denormalized text field; a proper FK ',
    `kyc_record_id` BIGINT COMMENT 'Reference to the KYC record under which this beneficial owner was identified and verified.',
    `organisation_id` BIGINT COMMENT 'Reference to the corporate client entity for which this beneficial ownership is declared. Links to the organisation master data.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Beneficial owner records are mandated by specific regulatory obligations (e.g. 5th AML Directive, PSC register requirements, FATF Recommendation 24). Linking beneficial_owner to the regulatory obligat',
    `to_kyc_record_id` BIGINT COMMENT 'FK to client.kyc_record.kyc_record_id — Beneficial ownership verification is part of the KYC dossier — linked for audit trail',
    `to_organisation_id` BIGINT COMMENT 'FK to client.organisation.organisation_id — UBOs are recorded against corporate entities for AML compliance',
    `adverse_media_flag` BOOLEAN COMMENT 'Indicates whether adverse media or negative news has been identified for this beneficial owner during screening. True if adverse media is present.',
    `adverse_media_summary` STRING COMMENT 'Summary of adverse media findings, including the nature of the negative news and the source. Populated when adverse_media_flag is true.',
    `beneficial_owner_status` STRING COMMENT 'The current status of the beneficial owner record: active (current UBO), inactive (no longer a UBO), under review (verification in progress), rejected (failed verification), or superseded (replaced by updated record).. Valid values are `active|inactive|under_review|rejected|superseded`',
    `control_description` STRING COMMENT 'Free-text description providing additional detail on how the beneficial owner exercises control, especially when nature_of_control is other or when the control structure is complex.',
    `country_of_residence` STRING COMMENT 'The country where the beneficial owner primarily resides, represented as a 3-letter ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `created_by_user_code` BIGINT COMMENT 'Reference to the user who created this beneficial owner record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this beneficial owner record was first created in the system. Used for audit trail and data lineage.',
    `date_of_birth` DATE COMMENT 'The date of birth of the beneficial owner, used for identity verification and PEP screening.',
    `disclosure_date` DATE COMMENT 'The date on which the beneficial owner information was disclosed to the firm by the client organisation. Marks the start of the KYC record for this UBO.',
    `full_name` STRING COMMENT 'The complete legal name of the ultimate beneficial owner as it appears on official identification documents.',
    `last_modified_by_user_code` BIGINT COMMENT 'Reference to the user who last modified this beneficial owner record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this beneficial owner record was last modified. Used for audit trail and change tracking.',
    `last_review_date` DATE COMMENT 'The date on which the beneficial owner record was last reviewed for accuracy and currency. Used to schedule periodic reviews per the firms AML policy.',
    `nationality` STRING COMMENT 'The nationality of the beneficial owner, represented as a 3-letter ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `nature_of_control` STRING COMMENT 'The mechanism by which the beneficial owner exercises control over the client organisation: direct shareholding, indirect shareholding through intermediaries, voting rights, power to appoint board members, significant influence, or other means.. Valid values are `direct_shareholding|indirect_shareholding|voting_rights|board_appointment|significant_influence|other`',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of the beneficial owner information. Calculated based on risk rating and firm policy.',
    `notes` STRING COMMENT 'Free-text field for internal notes and observations about the beneficial owner, such as unusual circumstances, additional verification steps taken, or risk mitigation measures.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership or control that the beneficial owner holds in the client organisation. Typically 25% or more triggers UBO disclosure requirements under most AML regimes.',
    `pep_role_description` STRING COMMENT 'Description of the political or public role held by the PEP, or the relationship to the PEP if the beneficial owner is a family member or close associate.',
    `pep_status` STRING COMMENT 'Indicates whether the beneficial owner is a Politically Exposed Person (PEP), a family member of a PEP, or a close associate of a PEP. PEP status triggers enhanced due diligence requirements.. Valid values are `not_pep|domestic_pep|foreign_pep|international_organisation_pep|family_member|close_associate`',
    `residential_address` STRING COMMENT 'The full residential address of the beneficial owner, including street, city, postal code, and country. Used for verification and correspondence.',
    `risk_assessment_date` DATE COMMENT 'The date on which the risk rating was last assessed or updated. Used to trigger periodic risk re-assessment.',
    `risk_rating` STRING COMMENT 'The AML/KYC risk rating assigned to this beneficial owner based on PEP status, sanctions screening, adverse media, country risk, and other factors. Determines the level of ongoing monitoring required.. Valid values are `low|medium|high|very_high`',
    `sanctions_list_match` STRING COMMENT 'Details of any sanctions list match, including the list name, match score, and reason for the match. Populated when sanctions_status is match or potential_match.',
    `sanctions_status` STRING COMMENT 'Result of sanctions screening against OFAC, UN, EU, and other sanctions lists. Indicates whether the beneficial owner is sanctioned, potentially sanctioned, or clear.. Valid values are `clear|match|potential_match|under_review`',
    `source_of_funds` STRING COMMENT 'Description of the origin of the funds used in the specific transaction or relationship with the firm. Distinct from source of wealth; focuses on the immediate source of capital.',
    `source_of_wealth` STRING COMMENT 'Description of the origin of the beneficial owners total wealth, such as inheritance, business ownership, employment, investments, or other sources. Required for enhanced due diligence on high-risk clients.',
    `status_change_date` DATE COMMENT 'The date on which the status of the beneficial owner record was last changed. Used for audit trail and lifecycle tracking.',
    `status_change_reason` STRING COMMENT 'Free-text explanation of the reason for the most recent status change, such as ownership transfer, verification failure, or periodic review outcome.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the beneficial owner in their country of residence or nationality. Used for tax reporting and compliance purposes.',
    `tax_residence_country` STRING COMMENT 'The country where the beneficial owner is considered a tax resident, represented as a 3-letter ISO 3166-1 alpha-3 country code. May differ from country of residence.. Valid values are `^[A-Z]{3}$`',
    `verification_date` DATE COMMENT 'The date on which the beneficial owner information was verified by the firm. Used to track the currency of KYC data and trigger periodic re-verification.',
    `verification_method` STRING COMMENT 'The method or document type used to verify the identity and ownership of the beneficial owner: passport, national ID, drivers license, utility bill, bank statement, corporate registry extract, third-party database, or other. [ENUM-REF-CANDIDATE: passport|national_id|drivers_license|utility_bill|bank_statement|corporate_registry|third_party_database|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_beneficial_owner PRIMARY KEY(`beneficial_owner_id`)
) COMMENT 'Records the ultimate beneficial owners (UBOs) of corporate client entities as required by AML/KYC regulations (FATF, EU 4th/5th AML Directives, FinCEN). Captures UBO full name, date of birth, nationality, country of residence, ownership percentage, nature of control (direct shareholding, indirect, voting rights, other significant influence), PEP status, sanctions status, verification date, and verification method. Linked to the organisation master and KYC record. Supports SRA and FATF beneficial ownership disclosure obligations.';

CREATE OR REPLACE TABLE `legal_ecm`.`client`.`outside_counsel_guideline` (
    `outside_counsel_guideline_id` BIGINT COMMENT 'Unique identifier for the outside counsel guideline record. Primary key.',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to service.delivery_model. Business justification: OCGs frequently restrict delivery models (e.g., prohibiting offshore staffing or requiring onshore-only teams). Linking OCG to delivery_model enables automated staffing compliance checks during matter',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Large corporate clients issue Outside Counsel Guidelines at the organisation level that apply enterprise-wide across all subsidiaries and matters. Billing compliance, rate validation, and invoice revi',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Outside counsel guidelines often restrict or prefer certain practice areas (e.g., client prohibits patent prosecution, requires diversity reporting for litigation). Guideline compliance checks and ser',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: OCGs define billing rate caps and AFA preferences that must be validated against the applicable pricing model. Linking OCG to pricing_model enables automated billing compliance checks during invoice r',
    `profile_id` BIGINT COMMENT 'Reference to the client entity to which this guideline applies. Links to the client master data.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to service.rate_card. Business justification: OCGs govern rate caps that must be enforced against the applicable rate card. Linking OCG to rate_card enables billing teams to validate invoiced rates against OCG-mandated caps during invoice review ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: OCGs are often tier-specific, with different rate caps and staffing restrictions per service tier. Linking OCG to tier enables tier-based billing compliance enforcement and supports OCG applicability ',
    `acceptance_date` DATE COMMENT 'Date on which the firm formally accepted or acknowledged the guideline.',
    `acceptance_status` STRING COMMENT 'Firms acceptance status of the client guideline: accepted (firm agrees to comply), rejected (firm declines engagement under these terms), under review, conditionally accepted (with negotiated exceptions), or not applicable.. Valid values are `accepted|rejected|under_review|conditionally_accepted|not_applicable`',
    `afa_permitted` BOOLEAN COMMENT 'Indicates whether the client permits or encourages alternative fee arrangements (fixed fee, capped fee, contingency, blended rate) as opposed to hourly billing.',
    `afa_preference` STRING COMMENT 'Description of the clients preferred alternative fee arrangement structures if AFAs are permitted (e.g., fixed fee for transactional work, success fee for litigation).',
    `billing_rate_cap_associate` DECIMAL(18,2) COMMENT 'Maximum hourly billing rate permitted for associates under this guideline. Null if no cap specified.',
    `billing_rate_cap_paralegal` DECIMAL(18,2) COMMENT 'Maximum hourly billing rate permitted for paralegals under this guideline. Null if no cap specified.',
    `billing_rate_cap_partner` DECIMAL(18,2) COMMENT 'Maximum hourly billing rate permitted for equity partners under this guideline. Null if no cap specified.',
    `block_billing_prohibited` BOOLEAN COMMENT 'Indicates whether the client prohibits block billing (single time entry covering multiple tasks). If true, each task must be separately itemized.',
    `budget_approval_threshold` DECIMAL(18,2) COMMENT 'Monetary threshold above which matter budgets or budget overruns require explicit client approval before proceeding.',
    `budget_threshold_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget approval threshold.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this guideline record was first created in the system. Audit trail field.',
    `data_residency_requirement` STRING COMMENT 'Geographic or jurisdictional data residency requirements imposed by the client (e.g., all matter data must remain within EU, UK-only storage). Null if no restriction.',
    `diversity_reporting_required` BOOLEAN COMMENT 'Indicates whether the client requires periodic diversity and inclusion reporting on matter staffing (e.g., gender, ethnicity, LGBTQ+ representation).',
    `ebilling_platform_mandate` STRING COMMENT 'Name of the e-billing platform the client mandates for invoice submission (e.g., Serengeti Tracker, Legal Tracker, Collaborati, Brightflag). Null if no specific platform required.',
    `effective_date` DATE COMMENT 'Date from which this guideline version becomes binding and must be applied to client matters.',
    `expiry_date` DATE COMMENT 'Date on which this guideline version ceases to be effective. Null for open-ended guidelines.',
    `guideline_name` STRING COMMENT 'Business-friendly name or title of the outside counsel guideline document or preference set.',
    `guideline_type` STRING COMMENT 'Classification of the guideline: formal outside counsel guideline issued by client, operational service preference, or hybrid combining both.. Valid values are `formal_ocg|operational_preference|hybrid`',
    `invoice_delivery_email` STRING COMMENT 'Email address to which invoices should be sent if email delivery method is specified.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `invoice_delivery_method` STRING COMMENT 'Method by which invoices should be delivered to the client: email, e-billing portal upload, postal mail, or secure file transfer (SFTP).. Valid values are `email|ebilling_portal|postal_mail|secure_file_transfer`',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code representing the clients preferred language for all communications and documentation (e.g., en for English, fr for French, de for German).. Valid values are `^[a-z]{2}$`',
    `matter_update_preference` STRING COMMENT 'Clients preference for how matter updates should be communicated: format, level of detail, and escalation triggers.',
    `minimum_time_increment` DECIMAL(18,2) COMMENT 'Minimum time increment for billing entries in hours (e.g., 0.10 for 6-minute increments, 0.25 for 15-minute increments). Null if no specific requirement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this guideline record was last modified. Audit trail field.',
    `notes` STRING COMMENT 'Free-text field for additional notes, exceptions, or special instructions related to this guideline that do not fit structured fields.',
    `ocg_client_profile_fk` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — OCGs govern service delivery per client. Required for billing compliance and staffing decisions.',
    `ocg_to_client_profile` BIGINT COMMENT 'FK to client.client_profile.client_profile_id — OCGs are issued by clients and govern service delivery — must link to the client they apply to',
    `outside_counsel_evaluator_email` STRING COMMENT 'Email address of the client-side outside counsel evaluator for guideline-related inquiries and compliance reporting.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `outside_counsel_evaluator_name` STRING COMMENT 'Name of the client-side individual responsible for evaluating and approving outside counsel guideline compliance (typically General Counsel or Legal Operations Manager).',
    `outside_counsel_guideline_status` STRING COMMENT 'Current lifecycle status of the guideline record: active (currently in force), inactive (temporarily suspended), superseded (replaced by newer version), archived (historical record).. Valid values are `active|inactive|superseded|archived`',
    `preferred_billing_format` STRING COMMENT 'Clients preferred invoice format: LEDES electronic standard, PDF narrative, e-billing portal submission, Excel spreadsheet, or custom format.. Valid values are `ledes|pdf|ebilling_portal|excel|custom`',
    `preferred_communication_channel` STRING COMMENT 'Clients preferred primary communication channel for routine matter correspondence and updates.. Valid values are `email|phone|video_conference|client_portal|in_person`',
    `rate_cap_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for billing rate caps (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `reporting_frequency` STRING COMMENT 'Frequency at which the client expects matter status reports and updates: weekly, biweekly, monthly, quarterly, on-demand, or milestone-based.. Valid values are `weekly|biweekly|monthly|quarterly|on_demand|milestone_based`',
    `staffing_restriction` STRING COMMENT 'Free-text description of any staffing restrictions imposed by the client (e.g., maximum number of timekeepers, seniority mix requirements, named attorney requirements).',
    `sustainability_reporting_required` BOOLEAN COMMENT 'Indicates whether the client requires sustainability or environmental impact reporting (e.g., carbon footprint of legal services, paperless billing compliance).',
    `travel_expense_policy` STRING COMMENT 'Summary of client travel and expense reimbursement policy: permissible travel classes, accommodation standards, meal per diems, and approval requirements.',
    `utbms_task_code_required` BOOLEAN COMMENT 'Indicates whether the client requires UTBMS task codes on all time entries and invoices for standardized billing categorization.',
    `version_number` STRING COMMENT 'Version identifier of the guideline document (e.g., 1.0, 2.3, 2024-Q1). Tracks revisions over time.',
    CONSTRAINT pk_outside_counsel_guideline PRIMARY KEY(`outside_counsel_guideline_id`)
) COMMENT 'Consolidated record of all client service delivery requirements, encompassing both formal outside counsel guidelines (OCGs) and operational service preferences. For OCGs: captures guideline version, effective date, expiry date, billing rate caps, staffing restrictions, budget approval thresholds, e-billing platform mandate, UTBMS task code requirements, diversity reporting obligations, travel and expense policy, and acceptance status. For operational preferences: captures preferred billing format (LEDES, PDF, e-billing portal), invoice delivery method, reporting frequency, matter update preferences, preferred communication channel, language preference, data residency requirements, and sustainability reporting flags. Represents the complete how to serve this client specification that governs matter staffing, billing, and reporting. Sourced from Elite 3E billing preferences, Microsoft Dynamics 365 CRM, and client-issued OCG documents.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`client`.`organisation` ADD CONSTRAINT `fk_client_organisation_parent_organisation_id` FOREIGN KEY (`parent_organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`organisation` ADD CONSTRAINT `fk_client_organisation_primary_ultimate_parent_organisation_id` FOREIGN KEY (`primary_ultimate_parent_organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`organisation` ADD CONSTRAINT `fk_client_organisation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`address` ADD CONSTRAINT `fk_client_address_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`client`.`address` ADD CONSTRAINT `fk_client_address_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`client`.`address` ADD CONSTRAINT `fk_client_address_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`address` ADD CONSTRAINT `fk_client_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ADD CONSTRAINT `fk_client_corporate_hierarchy_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ADD CONSTRAINT `fk_client_corporate_hierarchy_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ADD CONSTRAINT `fk_client_corporate_hierarchy_parent_organisation_id` FOREIGN KEY (`parent_organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ADD CONSTRAINT `fk_client_corporate_hierarchy_primary_corporate_organisation_id` FOREIGN KEY (`primary_corporate_organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ADD CONSTRAINT `fk_client_corporate_hierarchy_primary_corporate_profile_id` FOREIGN KEY (`primary_corporate_profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ADD CONSTRAINT `fk_client_relationship_team_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_to_kyc_record_id` FOREIGN KEY (`to_kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_to_organisation_id` FOREIGN KEY (`to_organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`client` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `legal_ecm`.`client` SET TAGS ('dbx_domain' = 'client');
ALTER TABLE `legal_ecm`.`client`.`organisation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`organisation` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `parent_organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organisation Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_ultimate_parent_organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Organisation Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `aml_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Tier');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `aml_risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Range');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `billing_address_same_as_registered` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Same as Registered Flag');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `billing_address_same_as_registered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `billing_address_same_as_registered` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Range');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'corporation|partnership|limited_liability_company|government_agency|non_governmental_organisation|sole_proprietorship');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Classification');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `is_ultimate_beneficial_owner` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Flag');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Completion Date');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Next Review Date');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|rejected|expired');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `public_private_status` SET TAGS ('dbx_business_glossary_term' = 'Public or Private Status');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `public_private_status` SET TAGS ('dbx_value_regex' = 'public|private|government|non_profit');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `relationship_inception_date` SET TAGS ('dbx_business_glossary_term' = 'Client Relationship Inception Date');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Client Relationship Status');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|prospective|former');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match_found|under_review|blocked');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `stock_exchange` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Listing');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name or Doing Business As (DBA)');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`organisation` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Organisation Website URL');
ALTER TABLE `legal_ecm`.`client`.`individual` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`individual` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Identifier');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `client_since_date` SET TAGS ('dbx_business_glossary_term' = 'Client Since Date');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `client_status` SET TAGS ('dbx_business_glossary_term' = 'Client Status');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `client_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospective|former|suspended');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal|sms');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'cleared|conflict_identified|waived|pending');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `country_of_domicile` SET TAGS ('dbx_business_glossary_term' = 'Country of Domicile');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `country_of_domicile` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|restricted|hold|review_required');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Category');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_value_regex' = 'standard|extended|litigation_hold|permanent');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Completion Date');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|pending_review|expired|not_started');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `lpp_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Status');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Residential Address Line 1');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Residential Address Line 2');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_city` SET TAGS ('dbx_business_glossary_term' = 'Residential City');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_country` SET TAGS ('dbx_business_glossary_term' = 'Residential Country');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Residential Postal Code');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_state_province` SET TAGS ('dbx_business_glossary_term' = 'Residential State or Province');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `residential_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Salutation Title');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr|Ms|Mrs|Dr|Prof|Hon');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|dynamics_365|intapp_conflicts|manual_entry');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`individual` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`profile` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Area Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `afa_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Eligible Flag');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|matter_completion|milestone|on_demand');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_name` SET TAGS ('dbx_business_glossary_term' = 'Client Legal Name');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_number` SET TAGS ('dbx_business_glossary_term' = 'Client Number');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_status` SET TAGS ('dbx_business_glossary_term' = 'Client Status');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|former|suspended|conflicted');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_type` SET TAGS ('dbx_business_glossary_term' = 'Client Type');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `client_type` SET TAGS ('dbx_value_regex' = 'corporate|government|individual|prospective|partnership|trust');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'clear|conflict_identified|waived|pending|not_performed');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `data_protection_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Classification');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `data_protection_classification` SET TAGS ('dbx_value_regex' = 'standard|gdpr|ccpa|hipaa|pci_dss|sox');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `ebilling_platform` SET TAGS ('dbx_business_glossary_term' = 'Electronic Billing (E-Billing) Platform');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `electronic_billing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Billing Required Flag');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `first_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'First Engagement Date');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Completion Date');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Next Review Date');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|verified|expired|rejected|not_required');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `last_matter_date` SET TAGS ('dbx_business_glossary_term' = 'Last Matter Date');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Client Notes');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `outside_counsel_guidelines_flag` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guidelines Flag');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `preferred_billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Billing Currency');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `preferred_billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `retention_policy_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Years');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending|not_screened');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`profile` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`contact` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 1');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 2');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Contact City');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deceased|left_organization');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Country Code');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `direct_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Direct Phone Number');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `direct_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `direct_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `is_billing_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Billing Contact Flag');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `is_pep` SET TAGS ('dbx_business_glossary_term' = 'Is Politically Exposed Person (PEP) Flag');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `is_signatory` SET TAGS ('dbx_business_glossary_term' = 'Is Signatory Flag');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Verification Date');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Verification Status');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Contact Language Preference');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Phone Number');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Postal Code');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|mail|portal');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `professional_profile_url` SET TAGS ('dbx_business_glossary_term' = 'Contact Professional Profile URL');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending_review|not_screened');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `signatory_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Signatory Authority Level');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `signatory_authority_level` SET TAGS ('dbx_value_regex' = 'unlimited|limited|threshold_based|none');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Contact State or Province');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `legal_ecm`.`client`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`address` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|historical');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'registered_office|principal_place_of_business|billing|correspondence|service_of_process|branch_office');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_business_glossary_term' = 'Is Billing Address Flag');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address Flag');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `is_service_of_process_address` SET TAGS ('dbx_business_glossary_term' = 'Is Service of Process Address Flag');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `is_service_of_process_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `is_service_of_process_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `postal_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Postal Validation Status');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `postal_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|pending_validation');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|microsoft_dynamics_365|manual_entry|data_migration');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `legal_ecm`.`client`.`address` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `corporate_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Child Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `primary_corporate_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|requires_review|escalated');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `billing_consolidation_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Consolidation Type');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `billing_consolidation_type` SET TAGS ('dbx_value_regex' = 'consolidated|separate|hybrid|parent_pays|child_pays');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `conflict_check_scope` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Scope');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `conflict_check_scope` SET TAGS ('dbx_value_regex' = 'include|exclude|conditional|manual_review');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Control Indicator');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Relationship Flag');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Date');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Expiry Date');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Jurisdiction');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `kyc_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Risk Rating');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `kyc_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `relationship_source` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `relationship_source` SET TAGS ('dbx_value_regex' = 'client_disclosure|public_filing|due_diligence|third_party_database|internal_research|regulatory_filing');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved|under_review|suspended');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Corporate Relationship Type');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'wholly_owned_subsidiary|majority_owned|minority_stake|affiliate|joint_venture|branch');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|disputed|requires_update');
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` SET TAGS ('dbx_subdomain' = 'compliance_screening');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Record ID');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `adverse_media_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Date');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `adverse_media_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Result');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `adverse_media_screening_result` SET TAGS ('dbx_value_regex' = 'clear|adverse_found|pending_review');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `beneficial_ownership_register_reference` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Ownership Register Reference');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `beneficial_ownership_verified` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Ownership Verified');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `business_nature_description` SET TAGS ('dbx_business_glossary_term' = 'Business Nature Description');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `expected_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Transaction Volume');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `expected_transaction_volume` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `high_risk_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'High Risk Jurisdiction Flag');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Approval Date');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_document_count` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Document Count');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Expiry Date');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Reference Number');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_reference_number` SET TAGS ('dbx_value_regex' = '^KYC-[0-9]{8,12}$');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Review Date');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired|under_review');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_tier` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Tier');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `kyc_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|simplified');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `pep_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Screening Date');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `pep_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Screening Result');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `pep_screening_result` SET TAGS ('dbx_value_regex' = 'not_pep|pep_identified|pending_review');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_value_regex' = 'clear|match_found|pending_review');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `source_of_funds_description` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds Description');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `source_of_funds_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `source_of_funds_verified` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds Verified');
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm`.`client`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`client`.`segment` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Client Segment ID');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `applicable_practice_areas` SET TAGS ('dbx_business_glossary_term' = 'Applicable Practice Areas');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `assigned_bd_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Business Development (BD) Team');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `client_count` SET TAGS ('dbx_business_glossary_term' = 'Client Count');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `conflict_check_intensity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Intensity');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `conflict_check_intensity` SET TAGS ('dbx_value_regex' = 'standard|enhanced|comprehensive');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `cross_sell_priority` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Priority');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `cross_sell_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `discount_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Discount Authority Level');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `discount_authority_level` SET TAGS ('dbx_value_regex' = 'partner|practice_group_leader|pricing_committee|managing_partner');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `minimum_revenue_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Revenue Threshold');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `minimum_revenue_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `partner_attention_required` SET TAGS ('dbx_business_glossary_term' = 'Partner Attention Required');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `preferred_afa_types` SET TAGS ('dbx_business_glossary_term' = 'Preferred Alternative Fee Arrangement (AFA) Types');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `requires_aml_screening` SET TAGS ('dbx_business_glossary_term' = 'Requires Anti-Money Laundering (AML) Screening');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `requires_kyc_enhanced` SET TAGS ('dbx_business_glossary_term' = 'Requires Enhanced Know Your Client (KYC)');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Segment Review Cycle');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|deprecated');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Tier');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `standard_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Standard Discount Percentage');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `standard_discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `target_client_type` SET TAGS ('dbx_business_glossary_term' = 'Target Client Type');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `target_client_type` SET TAGS ('dbx_value_regex' = 'corporate|government|individual|non_profit|mixed');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `target_realization_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Realization Rate');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `target_realization_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `target_rpe` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue Per Equity Partner (RPE)');
ALTER TABLE `legal_ecm`.`client`.`segment` ALTER COLUMN `target_rpe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `relationship_team_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Team ID');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `billing_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Billing Authority Level');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `billing_authority_level` SET TAGS ('dbx_value_regex' = 'full_authority|approval_required|view_only|no_access');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `client_contact_frequency` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Frequency');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `client_contact_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|monthly|quarterly|as_needed');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `client_satisfaction_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Client Satisfaction Responsibility Flag');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `conflict_check_authority` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Authority Flag');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `cross_sell_target_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Target Flag');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `escalation_priority` SET TAGS ('dbx_business_glossary_term' = 'Escalation Priority');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `geographic_coverage_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Region');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `last_client_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Client Contact Date');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `next_scheduled_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Contact Date');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'all_communications|critical_only|escalations_only|none');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `origination_credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Origination Credit Percentage');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `origination_credit_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `relationship_role_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role Type');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `relationship_role_type` SET TAGS ('dbx_value_regex' = 'client_relationship_partner|originating_partner|supervising_partner|relationship_manager|business_development_manager|supporting_fee_earner');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Percentage');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `responsibility_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|microsoft_dynamics_365|intapp_conflicts|manual_entry');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Letter Template Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `afa_framework_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Framework Type');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `authorised_practice_areas` SET TAGS ('dbx_business_glossary_term' = 'Authorised Practice Areas');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|upon_completion|milestone_based');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `conflict_check_required` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Required');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `data_protection_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Classification');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `data_protection_classification` SET TAGS ('dbx_value_regex' = 'standard|confidential|highly_confidential|special_category');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `electronic_billing_required` SET TAGS ('dbx_business_glossary_term' = 'Electronic Billing Required');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `excluded_services` SET TAGS ('dbx_business_glossary_term' = 'Excluded Services');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `gdpr_processing_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Processing Basis');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `gdpr_processing_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|legitimate_interest');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `geographic_jurisdictions_covered` SET TAGS ('dbx_business_glossary_term' = 'Geographic Jurisdictions Covered');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `kyc_documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Documentation Status');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `kyc_documentation_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|pending|expired|not_required');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `ledes_format_version` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Format Version');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `ledes_format_version` SET TAGS ('dbx_value_regex' = 'LEDES98B|LEDES98BI|LEDES2000');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `matter_budget_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Matter Budget Approval Required');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `originating_office_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Office Code');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `panel_appointment_reference` SET TAGS ('dbx_business_glossary_term' = 'Panel Appointment Reference');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `panel_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Expiry Date');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `panel_start_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Start Date');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `preferred_counsel_designation` SET TAGS ('dbx_business_glossary_term' = 'Preferred Counsel Designation');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Reference');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Approval Date');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Description');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_name` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Name');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Reference Number');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Status');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|expired');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Type');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'panel|retainer|framework|ad_hoc|preferred_counsel');
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ALTER COLUMN `utbms_task_codes_required` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Codes Required');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` SET TAGS ('dbx_subdomain' = 'compliance_screening');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `beneficial_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner ID');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Record ID');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation ID');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `adverse_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Flag');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `adverse_media_summary` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Summary');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `beneficial_owner_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Record Status');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `beneficial_owner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|rejected|superseded');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_business_glossary_term' = 'Country of Residence');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Full Name');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `nature_of_control` SET TAGS ('dbx_business_glossary_term' = 'Nature of Control');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `nature_of_control` SET TAGS ('dbx_value_regex' = 'direct_shareholding|indirect_shareholding|voting_rights|board_appointment|significant_influence|other');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `pep_role_description` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Role Description');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `pep_status` SET TAGS ('dbx_value_regex' = 'not_pep|domestic_pep|foreign_pep|international_organisation_pep|family_member|close_associate');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `residential_address` SET TAGS ('dbx_business_glossary_term' = 'Residential Address');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `residential_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `residential_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `sanctions_list_match` SET TAGS ('dbx_business_glossary_term' = 'Sanctions List Match Details');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `sanctions_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `sanctions_status` SET TAGS ('dbx_value_regex' = 'clear|match|potential_match|under_review');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `status_change_date` SET TAGS ('dbx_business_glossary_term' = 'Status Change Date');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `status_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `tax_residence_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Residence Country');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `tax_residence_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline (OCG) ID');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|under_review|conditionally_accepted|not_applicable');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `afa_permitted` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Permitted');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `afa_preference` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Preference');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `billing_rate_cap_associate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Cap - Associate');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `billing_rate_cap_associate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `billing_rate_cap_paralegal` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Cap - Paralegal');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `billing_rate_cap_paralegal` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `billing_rate_cap_partner` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Cap - Partner');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `billing_rate_cap_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `block_billing_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Block Billing Prohibited');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `budget_approval_threshold` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Threshold');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `budget_approval_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `budget_threshold_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Threshold Currency Code');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `budget_threshold_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `data_residency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Requirement');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `diversity_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Diversity Reporting Required');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `ebilling_platform_mandate` SET TAGS ('dbx_business_glossary_term' = 'E-Billing Platform Mandate');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `guideline_name` SET TAGS ('dbx_business_glossary_term' = 'Guideline Name');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `guideline_type` SET TAGS ('dbx_business_glossary_term' = 'Guideline Type');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `guideline_type` SET TAGS ('dbx_value_regex' = 'formal_ocg|operational_preference|hybrid');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `invoice_delivery_email` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Email Address');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `invoice_delivery_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `invoice_delivery_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `invoice_delivery_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|ebilling_portal|postal_mail|secure_file_transfer');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `matter_update_preference` SET TAGS ('dbx_business_glossary_term' = 'Matter Update Preference');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `minimum_time_increment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Time Increment');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_evaluator_email` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Evaluator Email Address');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_evaluator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_evaluator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_evaluator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Evaluator Name');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_evaluator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_evaluator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_guideline_status` SET TAGS ('dbx_business_glossary_term' = 'Guideline Status');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `outside_counsel_guideline_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|archived');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `preferred_billing_format` SET TAGS ('dbx_business_glossary_term' = 'Preferred Billing Format');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `preferred_billing_format` SET TAGS ('dbx_value_regex' = 'ledes|pdf|ebilling_portal|excel|custom');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|video_conference|client_portal|in_person');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `rate_cap_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Currency Code');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `rate_cap_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|on_demand|milestone_based');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `staffing_restriction` SET TAGS ('dbx_business_glossary_term' = 'Staffing Restriction');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `sustainability_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Reporting Required');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `travel_expense_policy` SET TAGS ('dbx_business_glossary_term' = 'Travel and Expense Policy');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `utbms_task_code_required` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code Required');
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
