-- Schema for Domain: customer | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`customer` COMMENT 'Single source of truth for all client and counterparty identities across retail, corporate, institutional, and government segments. Owns KYC/CDD onboarding, customer lifecycle management, beneficial ownership, relationship hierarchies, customer segmentation, NPS tracking, and CLTV scoring. Supports CRM integration and serves as the FK reference for all other domains requiring party identification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party` (
    `party_id` BIGINT COMMENT 'Unique identifier for the party. Primary key for the party entity. Serves as the authoritative foreign key anchor for all other domains requiring party identification.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Payment routing - SWIFT BIC codes must be validated for correspondent banking relationships, payment instructions, and SWIFT message routing. Core payment operations dependency.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: KYC/AML regulatory requirement - party domicile country drives FATCA/CRS classification, sanctions screening jurisdiction, and country risk rating. Core compliance process requiring validated country ',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Legal entity validation - LEI codes must be validated against GLEIF registry for corporate customers, drives counterparty identification in derivatives, securities trading, and MiFID II/EMIR regulator',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Operational necessity - preferred currency drives statement generation, pricing display, FX conversion rules for multi-currency customers, and fee calculations. Real daily banking operations dependenc',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Every banking customer relationship exists with a specific legal entity of the bank for regulatory capital allocation, financial statement consolidation, and legal entity P&L attribution. Required for',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Core entity classification - party types (Individual, Corporate, Trust, Partnership) drive regulatory treatment, product eligibility, KYC requirements, and reporting obligations. Must use standardized',
    `cif_number` STRING COMMENT 'Core banking system Customer Information File number. Internal unique identifier from the source system (Temenos T24 / FIS Profile).',
    `citizenship_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the partys citizenship. For individuals only. May be multi-valued in source systems but stored as primary citizenship here.. Valid values are `^[A-Z]{3}$`',
    `cltv_score` DECIMAL(18,2) COMMENT 'Calculated customer lifetime value score representing the predicted net profit attributed to the entire future relationship with the party. Used for relationship prioritization and resource allocation.',
    `customer_segment` STRING COMMENT 'Business segmentation classification of the party. Used for relationship management, pricing strategies, and service level differentiation.. Valid values are `retail|corporate|institutional|government|private_wealth`',
    `date_of_birth` DATE COMMENT 'Date of birth for individual parties. Used for age verification, regulatory compliance, and customer segmentation. Null for non-individual party types.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet DUNS number for corporate parties. 9-digit unique identifier for business entities.. Valid values are `^[0-9]{9}$`',
    `incorporation_date` DATE COMMENT 'Date of incorporation or registration for legal entity parties. Null for individual party types.',
    `is_pep` BOOLEAN COMMENT 'Flag indicating whether the party is classified as a Politically Exposed Person. PEPs require enhanced due diligence under AML regulations.',
    `is_sanctioned` BOOLEAN COMMENT 'Flag indicating whether the party appears on any sanctions lists (OFAC, UN, EU, etc.). Sanctioned parties are prohibited from transacting.',
    `kyc_completion_date` DATE COMMENT 'Date when the most recent KYC verification was completed. Used to track periodic review requirements.',
    `kyc_next_review_date` DATE COMMENT 'Scheduled date for the next periodic KYC review. Review frequency is typically risk-based.',
    `kyc_status` STRING COMMENT 'Current status of the KYC (Know Your Customer) verification process. Indicates whether customer due diligence has been completed and is current.. Valid values are `pending|verified|expired|rejected`',
    `legal_name` STRING COMMENT 'Full legal name of the party as registered with governing authorities. For individuals, this is the full name as it appears on official documents. For legal entities, this is the registered business name.',
    `lifecycle_status` STRING COMMENT 'Current state of the party in the customer lifecycle. Tracks the operational status from initial prospect through relationship termination or merger.. Valid values are `prospect|active|dormant|deceased|closed|merged`',
    `national_id_number` STRING COMMENT 'Government-issued national identification number for individuals. Format varies by country (e.g., Social Security Number in USA, National Insurance Number in UK).',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score for the party, ranging from -100 to +100. Measures customer loyalty and satisfaction.',
    `passport_expiry_date` DATE COMMENT 'Expiration date of the passport. Used to ensure identity documents remain current for compliance purposes.',
    `passport_issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the authority that issued the passport.. Valid values are `^[A-Z]{3}$`',
    `passport_number` STRING COMMENT 'Passport number for individual parties. Used for identity verification and cross-border compliance.',
    `preferred_language_code` STRING COMMENT 'ISO 639-1 two-letter language code representing the partys preferred language for communication and documentation.. Valid values are `^[a-z]{2}$`',
    `primary_address_city` STRING COMMENT 'City or municipality of the partys primary physical address.',
    `primary_address_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the partys primary physical address.. Valid values are `^[A-Z]{3}$`',
    `primary_address_line_1` STRING COMMENT 'First line of the partys primary physical address. Typically contains street number and street name.',
    `primary_address_line_2` STRING COMMENT 'Second line of the partys primary physical address. Typically contains apartment, suite, or unit number.',
    `primary_address_postal_code` STRING COMMENT 'Postal code or ZIP code of the partys primary physical address.',
    `primary_address_state_province` STRING COMMENT 'State, province, or region of the partys primary physical address.',
    `primary_email_address` STRING COMMENT 'Primary email address for party communication. Used for statements, notifications, and digital correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone_number` STRING COMMENT 'Primary contact phone number for the party. Used for customer service, fraud alerts, and operational communication.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this party record was first created in the system. Audit field for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this party record was last modified. Audit field for data lineage and compliance.',
    `relationship_end_date` DATE COMMENT 'Date when the partys relationship with the bank was terminated. Null for active relationships.',
    `relationship_start_date` DATE COMMENT 'Date when the party first established a relationship with the bank. Represents the initial onboarding or account opening date.',
    `residency_status` STRING COMMENT 'Tax residency classification of the party. Critical for regulatory reporting under FATCA and CRS.. Valid values are `resident|non_resident|dual_resident`',
    `risk_rating` STRING COMMENT 'Overall risk classification of the party based on AML (Anti-Money Laundering), sanctions screening, credit risk, and operational risk assessments.. Valid values are `low|medium|high|prohibited`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this party record originated (e.g., T24 for Temenos T24, FIS_PROFILE for FIS Profile).. Valid values are `T24|FIS_PROFILE|LEGACY`',
    `tax_identification_number` STRING COMMENT 'Primary tax identification number issued by the domicile country tax authority. For US individuals this is SSN (Social Security Number), for US entities this is EIN (Employer Identification Number).',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Golden master record for every legal entity or natural person the bank interacts with — retail clients, corporate borrowers, institutional counterparties, government entities, and internal legal entities. Stores canonical identity attributes: full legal name, date of birth / incorporation date, entity type (individual, corporation, partnership, trust, government), domicile country, residency status, citizenship, and lifecycle status (prospect, active, dormant, deceased, closed). Also captures: universal operational preferences (preferred language, preferred branch, statement delivery method, currency preference, time zone, accessibility requirements); external and internal identifiers (TIN, EIN, SSN, LEI, SWIFT BIC, DUNS, CIF number, passport number, national ID, Bloomberg BUID, Reuters PERM ID, legacy system IDs) with identifier type, issuing authority, effective/expiry dates, and is_primary flag per type; and lifecycle event audit log (prior status, new status, event type such as onboarded/activated/dormancy-flagged/reactivated/relationship-exited/deceased/merged/deduped, event timestamp, triggering system, initiating employee_id, approval employee_id, event notes). SINGLE SOURCE OF TRUTH for party identity, party identifiers, and party lifecycle events — no separate identifier or lifecycle event tables exist. Serves as the authoritative FK anchor for all other domains requiring party identification. Sourced from Core Banking System (Temenos T24 / FIS Profile — Customer Master).';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`individual_profile` (
    `individual_profile_id` BIGINT COMMENT 'Unique identifier for the individual profile record. Primary key for natural-person parties in retail and private banking segments.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Demographic standardization - gender codes must be standardized for fair lending analysis (HMDA reporting), regulatory compliance, and demographic segmentation. Regulatory reporting requirement.',
    `party_id` BIGINT COMMENT 'Foreign key reference to the parent party entity where entity_type equals individual. Establishes one-to-one relationship with core party master.',
    `annual_income_amount` DECIMAL(18,2) COMMENT 'Total gross annual income declared by the individual in the banks reporting currency. Core input for credit decisioning, loan-to-income ratio calculations, and wealth management suitability assessments.',
    `annual_income_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared annual income. Required for multi-currency operations and foreign exchange risk assessment.',
    `biometric_authentication_enabled_flag` BOOLEAN COMMENT 'Indicates whether the individual has enabled biometric authentication (fingerprint, face recognition) for digital banking access. Used for security posture assessment and fraud risk scoring.',
    `cltv_calculation_date` DATE COMMENT 'Date when the CLTV score was last calculated or refreshed. Used for model recency validation and refresh scheduling.',
    `cltv_score` DECIMAL(18,2) COMMENT 'Predicted total net revenue the bank expects to earn from this individual over the entire customer relationship lifecycle. Used for prioritization, retention investment, and portfolio optimization.',
    `credit_bureau_reporting_consent_flag` BOOLEAN COMMENT 'Indicates whether the individual has consented to the bank reporting their credit activity to credit bureaus. Required in jurisdictions with opt-in credit reporting regimes.',
    `customer_segment` STRING COMMENT 'Strategic segmentation classification assigned to the individual based on net worth, income, product holdings, and relationship depth. Drives service model, pricing, and relationship manager assignment.. Valid values are `mass_market|affluent|high_net_worth|ultra_high_net_worth|private_banking|premier`',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the individual has consented to sharing their data with third parties (affiliates, partners, credit bureaus). Required for GDPR and CCPA compliance.',
    `digital_banking_enrollment_date` DATE COMMENT 'Date when the individual first enrolled in digital banking services. Used for cohort analysis, digital maturity scoring, and customer lifecycle stage determination.',
    `digital_banking_enrollment_flag` BOOLEAN COMMENT 'Indicates whether the individual has completed enrollment in the banks digital banking platform (online and mobile banking). Used for channel analytics, digital adoption tracking, and omnichannel strategy.',
    `education_level` STRING COMMENT 'Highest level of formal education attained by the individual. Used for customer segmentation, product targeting, and financial literacy program design. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional|other — 7 candidates stripped; promote to reference product]',
    `employer_name` STRING COMMENT 'Legal name of the individuals current employer or business entity if self-employed. Used for income verification, employment stability assessment, and corporate banking cross-sell opportunities.',
    `employment_status` STRING COMMENT 'Current employment classification of the individual. Critical input for credit risk assessment, loan origination decisioning, and income verification workflows.. Valid values are `employed_full_time|employed_part_time|self_employed|unemployed|retired|student`',
    `kyc_refresh_due_date` DATE COMMENT 'Next scheduled date for periodic KYC refresh and customer due diligence update. Frequency is risk-based per AML regulations (typically annual for high-risk, biennial for medium-risk, triennial for low-risk).',
    `marital_status` STRING COMMENT 'Current marital or civil partnership status of the individual. Impacts credit assessment, joint account eligibility, and wealth planning strategies.. Valid values are `single|married|divorced|widowed|separated|domestic_partnership`',
    `marketing_consent_date` DATE COMMENT 'Date when the individual provided or last updated their marketing consent. Used for consent lifecycle management and regulatory audit trails.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Indicates whether the individual has provided explicit consent to receive marketing communications. Required for GDPR, CCPA, and CAN-SPAM compliance.',
    `mobile_app_user_flag` BOOLEAN COMMENT 'Indicates whether the individual has downloaded and activated the banks mobile banking application. Used for mobile engagement metrics and push notification eligibility.',
    `net_worth_band` STRING COMMENT 'Categorized range of the individuals total net worth (assets minus liabilities). Used for private banking eligibility, wealth management segmentation, and high-net-worth individual (HNWI) identification.. Valid values are `under_100k|100k_to_500k|500k_to_1m|1m_to_5m|5m_to_10m|over_10m`',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score provided by the individual, ranging from 0 to 10. Measures customer loyalty and likelihood to recommend the bank to others.',
    `nps_survey_date` DATE COMMENT 'Date when the most recent NPS score was collected. Used for trend analysis and survey recency validation.',
    `number_of_dependents` STRING COMMENT 'Count of financial dependents claimed by the individual. Used in credit underwriting, affordability assessments, and wealth management planning.',
    `occupation_code` STRING COMMENT 'Standardized occupation classification code (NAICS or SIC) representing the individuals primary profession. Enables industry-based risk segmentation and targeted product offerings.',
    `occupation_description` STRING COMMENT 'Free-text description of the individuals job title or professional role. Complements occupation_code with human-readable context for relationship managers and underwriters.',
    `pep_classification` STRING COMMENT 'Specific category of PEP status if pep_flag is true. Determines the level of enhanced due diligence and monitoring intensity required under AML frameworks.. Valid values are `domestic_pep|foreign_pep|international_organization|family_member|close_associate|not_applicable`',
    `pep_flag` BOOLEAN COMMENT 'Indicates whether the individual is classified as a Politically Exposed Person under AML regulations. Triggers enhanced due diligence, ongoing monitoring, and senior management approval for account opening.',
    `preferred_contact_method` STRING COMMENT 'Individuals stated preference for primary communication channel. Used by CRM systems to optimize customer engagement, regulatory notifications, and marketing campaign delivery.. Valid values are `email|phone|sms|mail|mobile_app|secure_message`',
    `preferred_language` STRING COMMENT 'ISO 639-1 two-letter language code representing the individuals preferred language for communications and service delivery. Ensures compliance with language access requirements and enhances customer experience.',
    `profile_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the individual profile record was first created in the system. Used for audit trails, data lineage, and customer tenure calculations.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the individual profile. Controls access to banking services, reporting inclusion, and regulatory treatment.. Valid values are `active|inactive|suspended|closed|deceased`',
    `profile_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the individual profile record was last modified. Used for change tracking, data freshness assessment, and audit compliance.',
    `risk_rating` STRING COMMENT 'Composite AML and financial crime risk rating assigned to the individual based on PEP status, geographic risk, transaction patterns, and adverse media screening. Determines monitoring intensity and review frequency.. Valid values are `low|medium|high|prohibited`',
    `risk_rating_date` DATE COMMENT 'Date when the AML risk rating was last assessed or updated. Used for periodic review scheduling and regulatory examination evidence.',
    `tax_identification_number` STRING COMMENT 'Primary tax identification number issued by the individuals country of tax residency. Required for FATCA, CRS, and domestic tax reporting. May be SSN, EIN, or foreign equivalent.',
    `tax_residency_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing all jurisdictions where the individual is a tax resident. Required for CRS (Common Reporting Standard) compliance and automatic exchange of information.',
    `us_person_flag` BOOLEAN COMMENT 'Indicates whether the individual is classified as a US person under FATCA regulations (US citizen, green card holder, or US tax resident). Triggers IRS Form W-9 collection and FATCA reporting obligations.',
    CONSTRAINT pk_individual_profile PRIMARY KEY(`individual_profile_id`)
) COMMENT 'Extended personal profile for natural-person parties (retail and private banking clients). Captures demographic and lifestyle attributes beyond core identity: gender, marital status, number of dependents, education level, employment status, employer name, annual income, net worth band, primary occupation (NAICS/SIC code), politically exposed person (PEP) flag, US person flag (FATCA), tax residency countries (CRS), preferred contact method, and digital banking enrollment status. One-to-one with party where entity_type = individual.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`corporate_profile` (
    `corporate_profile_id` BIGINT COMMENT 'Unique identifier for the corporate profile record. Primary key.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Corporate banking relationships are booked to specific bank legal entities for credit risk concentration limits, regulatory capital calculations, and legal entity financial reporting. Essential for Ba',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Credit risk and concentration management - industry classification (NAICS/SIC/GICS) drives risk rating, concentration limits, sector exposure reporting, and regulatory capital calculations. Core credi',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Corporate clients frequently issue debt or equity securities. Investment banking tracks issuer status for underwriting, advisory mandates, DCM/ECM pipeline management, and relationship profitability. ',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Legal entity validation - incorporation jurisdiction determines regulatory treatment, tax obligations, legal enforceability of contracts, and credit risk assessment. Critical for corporate banking and',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Legal entity type validation - legal form (LLC, Corporation, Partnership, Trust) affects regulatory treatment, tax reporting, liability assessment, and credit risk evaluation. Must use standardized co',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Corporate LEI validation - LEI codes must be validated against GLEIF registry for corporate customers, mandatory for derivatives trading, securities transactions, and MiFID II/EMIR reporting.',
    `party_id` BIGINT COMMENT 'Foreign key reference to the party_id of the immediate parent company in the corporate hierarchy. Null if the entity is the ultimate parent or has no parent relationship. Used for consolidated reporting and group exposure management.',
    `primary_corporate_party_id` BIGINT COMMENT 'Foreign key reference to the party master table. Links this corporate profile to the corresponding party entity where entity_type is non-individual (corporation, partnership, trust, government agency, etc.).',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee_id of the primary relationship manager or account officer responsible for managing the banking relationship with this corporate entity. Used for client coverage, revenue attribution, and service delivery.',
    `annual_revenue_band` STRING COMMENT 'The revenue size band representing the entitys approximate annual revenue or turnover. Used for credit assessment, relationship pricing, and regulatory segmentation. [ENUM-REF-CANDIDATE: 0-1M|1M-10M|10M-50M|50M-100M|100M-500M|500M-1B|1B+ — promote to reference product]',
    `credit_rating_fitch` STRING COMMENT 'The long-term issuer credit rating assigned by Fitch Ratings (e.g., AAA, AA+, BBB-, CCC). Used for credit risk assessment, capital allocation, and pricing decisions.',
    `credit_rating_moodys` STRING COMMENT 'The long-term issuer credit rating assigned by Moodys Investors Service (e.g., Aaa, Aa1, Baa3, Caa1). Used for credit risk assessment, capital allocation, and pricing decisions.',
    `credit_rating_sp` STRING COMMENT 'The long-term issuer credit rating assigned by Standard & Poors (e.g., AAA, AA+, BBB-, CCC). Used for credit risk assessment, capital allocation, and pricing decisions.',
    `crs_jurisdiction_of_tax_residence` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the jurisdiction where the entity is tax resident for CRS purposes. May differ from jurisdiction of incorporation.. Valid values are `^[A-Z]{3}$`',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the entity is subject to CRS reporting requirements (True) or exempt (False). Used for automatic exchange of financial account information between tax authorities.',
    `employee_count_band` STRING COMMENT 'The size band representing the approximate number of employees working for the entity. Used for segmentation, credit risk assessment, and regulatory reporting (e.g., SME classification).. Valid values are `1-10|11-50|51-200|201-500|501-1000|1001-5000|5001+`',
    `fatca_classification` STRING COMMENT 'The entity classification under FATCA regulations: Active NFFE (Non-Financial Foreign Entity), Passive NFFE, FFI (Foreign Financial Institution), Exempt Beneficial Owner, or Non-Participating FFI. Determines FATCA reporting obligations.. Valid values are `active_nffe|passive_nffe|ffi|exempt_beneficial_owner|non_participating_ffi`',
    `incorporation_date` DATE COMMENT 'The date on which the entity was legally incorporated or registered in its jurisdiction. Used for entity age calculations and regulatory compliance.',
    `industry_classification_system` STRING COMMENT 'The classification system used for the industry_classification_code field (SIC, NAICS, or ISIC).. Valid values are `SIC|NAICS|ISIC`',
    `internal_credit_rating` STRING COMMENT 'The banks internal credit rating assigned to the entity based on proprietary credit risk models and assessment frameworks. Used for IRB (Internal Ratings-Based) approach under Basel III and internal risk management.',
    `kyc_completion_date` DATE COMMENT 'The date when the most recent KYC/CDD (Customer Due Diligence) review was completed for this corporate entity. Used to track KYC refresh cycles and regulatory compliance.',
    `kyc_next_review_date` DATE COMMENT 'The scheduled date for the next periodic KYC/CDD review. Review frequency is typically risk-based (e.g., annually for high-risk, every 3 years for low-risk).',
    `legal_name` STRING COMMENT 'The full legal name of the corporate entity as registered with the jurisdiction of incorporation. This is the official name used in all legal documents, contracts, and regulatory filings.',
    `operating_address_line_1` STRING COMMENT 'The first line of the entitys primary operating or business address. This may differ from the registered address and represents where the entity conducts its day-to-day business operations.',
    `operating_address_line_2` STRING COMMENT 'The second line of the entitys primary operating address (suite, floor, building name, etc.).',
    `operating_city` STRING COMMENT 'The city or municipality of the entitys primary operating address.',
    `operating_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the entitys primary operating address (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `operating_postal_code` STRING COMMENT 'The postal or ZIP code of the entitys primary operating address.',
    `operating_state_province` STRING COMMENT 'The state, province, or administrative region of the entitys primary operating address.',
    `publicly_listed_flag` BOOLEAN COMMENT 'Indicates whether the entity is publicly traded on a stock exchange (True) or privately held (False). Affects regulatory requirements, disclosure obligations, and credit risk assessment.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this corporate profile record was first created in the system. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this corporate profile record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `registered_address_line_1` STRING COMMENT 'The first line of the entitys registered legal address as filed with the corporate registry. This is the official address for legal correspondence and service of process.',
    `registered_address_line_2` STRING COMMENT 'The second line of the entitys registered legal address (suite, floor, building name, etc.).',
    `registered_city` STRING COMMENT 'The city or municipality of the entitys registered legal address.',
    `registered_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the entitys registered legal address (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'The postal or ZIP code of the entitys registered legal address.',
    `registered_state_province` STRING COMMENT 'The state, province, or administrative region of the entitys registered legal address.',
    `registration_number` STRING COMMENT 'The official registration or incorporation number assigned by the jurisdictions corporate registry (e.g., Companies House number in UK, EIN in USA). Used for legal identification and verification.',
    `stock_exchange_code` STRING COMMENT 'The Market Identifier Code (MIC) of the primary stock exchange where the entitys shares are listed (e.g., XNYS for NYSE, XLON for London Stock Exchange). Null if not publicly listed.',
    `stock_ticker_symbol` STRING COMMENT 'The ticker symbol or trading symbol used to identify the entitys publicly traded shares on the stock exchange. Null if not publicly listed.',
    `tax_identification_number` STRING COMMENT 'The primary tax identification number assigned by the tax authority in the entitys jurisdiction (e.g., EIN in USA, UTR in UK, ABN in Australia). Used for tax reporting and compliance.',
    `ubo_flag` BOOLEAN COMMENT 'Indicates whether this entity is itself an ultimate beneficial owner (True) or is owned by another entity (False). Used for AML/KYC compliance and ownership transparency.',
    CONSTRAINT pk_corporate_profile PRIMARY KEY(`corporate_profile_id`)
) COMMENT 'Extended organizational profile for non-natural-person parties (corporations, partnerships, trusts, SPVs, government agencies). Captures: legal form, jurisdiction of incorporation, registered address, operating address, SIC/NAICS industry code, number of employees band, annual revenue band, publicly listed flag, stock exchange and ticker, parent company party_id, ultimate beneficial owner (UBO) flag, FATCA entity classification (NFFE/FFI), CRS reporting status, credit rating (S&P / Moodys / Fitch), and relationship manager employee_id. One-to-one with party where entity_type != individual.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`kyc_record` (
    `kyc_record_id` BIGINT COMMENT 'Unique identifier for the KYC/CDD record. Primary key.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: KYC framework standardization - KYC tiers (Simplified, Standard, Enhanced Due Diligence) must be standardized per regulatory framework (risk-based approach) for consistent compliance application.',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: KYC/AML control failures resulting in operational losses (regulatory fines, sanctions violations) must link to specific KYC records for regulatory reporting, root cause analysis, and remediation track',
    `party_id` BIGINT COMMENT 'Reference to the customer or counterparty entity this KYC record belongs to. Links to the customer master.',
    `employee_id` BIGINT COMMENT 'Reference to the compliance analyst employee who performed the KYC review.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the compliance analyst employee who conducted the most recent review event.',
    `adverse_media_screening_date` DATE COMMENT 'The date when the most recent adverse media screening was performed.',
    `adverse_media_screening_result` STRING COMMENT 'Result of screening against adverse media sources for negative news related to financial crime, fraud, or reputational risk.. Valid values are `not_screened|clear|negative_news_identified|under_investigation`',
    `aml_risk_rating` STRING COMMENT 'Consolidated AML and financial crime risk rating for the party. Single source of truth for AML risk classification.. Valid values are `low|medium|high|very_high`',
    `beneficial_ownership_verification_date` DATE COMMENT 'The date when beneficial ownership information was last verified.',
    `beneficial_ownership_verified` BOOLEAN COMMENT 'Indicates whether beneficial ownership information has been collected and verified for corporate or trust entities, as required by FinCEN CDD Rule.',
    `cdd_completion_status` STRING COMMENT 'Status of the standard Customer Due Diligence process completion.. Valid values are `not_started|in_progress|completed|incomplete`',
    `customer_risk_profile` STRING COMMENT 'Comprehensive narrative risk profile summarizing all risk factors, business activities, geographic exposure, and other considerations relevant to AML risk assessment.',
    `edd_completion_date` DATE COMMENT 'The date when Enhanced Due Diligence procedures were completed, if applicable.',
    `edd_completion_status` STRING COMMENT 'Status of the Enhanced Due Diligence process if required.. Valid values are `not_applicable|not_started|in_progress|completed|incomplete`',
    `edd_required_flag` BOOLEAN COMMENT 'Indicates whether Enhanced Due Diligence is required for this party based on risk assessment.',
    `jurisdiction_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0-100) based on the customers operating jurisdictions and geographic risk factors, with higher scores indicating higher risk.',
    `kyc_documentation_complete` BOOLEAN COMMENT 'Indicates whether all required KYC documentation (identity documents, proof of address, business registration, etc.) has been collected and verified.',
    `kyc_status` STRING COMMENT 'Overall status of the KYC record lifecycle: pending initial review, approved and current, expired requiring refresh, rejected, under periodic review, or suspended.. Valid values are `pending|approved|expired|rejected|under_review|suspended`',
    `last_review_date` DATE COMMENT 'The date of the most recent KYC review or refresh event.',
    `last_sar_filing_date` DATE COMMENT 'The date when the most recent Suspicious Activity Report was filed for this customer, if applicable. Highly confidential.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic KYC review based on risk rating and regulatory requirements.',
    `onboarding_date` DATE COMMENT 'The date when the customer relationship was initially established and KYC onboarding was completed.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite numeric risk score (0-100) aggregating all risk dimensions (jurisdiction, product, transaction, relationship) to produce the overall AML risk rating.',
    `pep_screening_date` DATE COMMENT 'The date when the most recent PEP screening was performed.',
    `pep_screening_result` STRING COMMENT 'Result of screening against Politically Exposed Person lists. Match identified requires enhanced scrutiny.. Valid values are `not_screened|clear|match_identified|under_investigation`',
    `prior_risk_rating` STRING COMMENT 'The AML risk rating assigned before the most recent review, used to track rating changes over time.. Valid values are `low|medium|high|very_high`',
    `product_service_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0-100) based on the types of banking products and services the customer uses, with higher scores for higher-risk products.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this KYC record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this KYC record was last modified or updated.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this KYC record or customer relationship has triggered any regulatory reporting requirements (SAR, CTR, etc.).',
    `relationship_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0-100) based on the customers business relationships, ownership structure, and counterparty network, with higher scores indicating higher risk.',
    `review_outcome` STRING COMMENT 'The outcome of the most recent KYC review: no change to risk rating, risk upgraded, risk downgraded, escalated to Enhanced Due Diligence, or relationship terminated/exited.. Valid values are `no_change|upgraded|downgraded|escalated_to_edd|relationship_exited`',
    `review_trigger_type` STRING COMMENT 'The event or condition that triggered the most recent KYC review: periodic scheduled review, risk-based trigger, regulatory requirement, client-initiated update, transaction pattern alert, or system-generated alert.. Valid values are `periodic|risk_triggered|regulatory|client_initiated|transaction_triggered|system_alert`',
    `risk_rating_rationale` STRING COMMENT 'Detailed explanation and justification for the assigned AML risk rating, including contributing factors and risk indicators.',
    `sanctions_screening_date` DATE COMMENT 'The date when the most recent sanctions screening was performed.',
    `sanctions_screening_result` STRING COMMENT 'Result of screening against international sanctions lists (OFAC, UN, EU, etc.). Match identified triggers immediate escalation.. Valid values are `not_screened|clear|match_identified|under_investigation`',
    `source_of_funds_verified` BOOLEAN COMMENT 'Indicates whether the source of funds for the customer has been verified and documented.',
    `source_of_wealth_verified` BOOLEAN COMMENT 'Indicates whether the source of wealth for the customer has been verified and documented, typically required for high-risk or high-net-worth clients.',
    `transaction_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0-100) based on the customers transaction patterns, volumes, and behaviors, with higher scores indicating higher risk.',
    CONSTRAINT pk_kyc_record PRIMARY KEY(`kyc_record_id`)
) COMMENT 'KYC/CDD (Know Your Customer / Customer Due Diligence) master record encompassing current KYC state, review event history, and consolidated AML/financial-crime risk rating for each party. Current KYC state: KYC tier (simplified, standard, enhanced EDD), onboarding date, last review date, next scheduled review date, AML risk rating (low/medium/high/very-high), risk rating rationale, CDD/EDD completion status, source of funds/wealth verification, PEP screening result, sanctions screening result, adverse media screening result, KYC analyst and approver employee_ids, and overall KYC status (pending, approved, expired, rejected). Review event history (time-series): review trigger type (periodic, risk-triggered, regulatory, client-initiated), review date, prior and new risk ratings, review outcome (no change, upgraded, downgraded, escalated to EDD, relationship exited), EDD required flag, EDD completion date, reviewer and approver employee_ids, and next review due date. SINGLE SOURCE OF TRUTH for AML/financial-crime risk rating and KYC review events — no separate review event or AML risk rating tables exist. Credit risk and operational risk ratings are owned by the risk domain. Provides the complete audit trail required for regulatory examination. Sourced from AML/Financial Crime System (NICE Actimize / Oracle Financial Crime).';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` (
    `customer_beneficial_owner_id` BIGINT COMMENT 'Unique identifier for the beneficial ownership record. Primary key for the customer beneficial owner registry.',
    `beneficial_owner_id` BIGINT COMMENT 'Unique identifier for the beneficial ownership record. Primary key for this entity.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: UBO control classification - control types (Ownership, Voting Rights, Senior Management, Other Means) must be standardized for FinCEN CTA reporting and 4AMLD/5AMLD compliance.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: CTA compliance - beneficial owner country must be validated for FinCEN Corporate Transparency Act reporting, sanctions screening, and UBO risk assessment.',
    `party_id` BIGINT COMMENT 'Reference to the individual party who is the beneficial owner. Links to the party master for the individual who owns or controls the legal entity.',
    `primary_customer_country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: UBO verification - beneficial owner country of residence drives AML risk rating, CRS/FATCA reporting obligations, and sanctions screening. Core UBO compliance requirement.',
    `primary_customer_legal_entity_party_id` BIGINT COMMENT 'Reference to the legal entity customer for which this beneficial ownership record applies. Links to the party master for the corporate or legal entity customer.',
    `quaternary_customer_party_id` BIGINT COMMENT 'Reference to the intermediate legal entity in the ownership chain for indirect ownership structures. Null for direct ownership. Links to customer master for the intermediary entity.',
    `tertiary_customer_owned_party_id` BIGINT COMMENT 'Reference to the legal entity (corporation, trust, partnership) that is owned or controlled. Links to the customer master for the legal entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who performed the beneficial owner verification. Links to the employee master.',
    `adverse_media_flag` BOOLEAN COMMENT 'Boolean indicator of whether adverse media or negative news has been identified for this beneficial owner. True = adverse media found requiring enhanced due diligence. False = no adverse media.',
    `adverse_media_screening_date` DATE COMMENT 'Date on which the most recent adverse media screening was performed for the beneficial owner.',
    `certification_date` DATE COMMENT 'Date on which the beneficial ownership certification was obtained from the legal entity customer, confirming the accuracy of beneficial owner information.',
    `certification_form_reference` STRING COMMENT 'Reference number or identifier for the beneficial ownership certification form completed by the legal entity customer.',
    `control_description` STRING COMMENT 'Detailed description of the nature and extent of control exercised by the beneficial owner, including specific roles, titles, or mechanisms of control.',
    `control_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this person exercises significant control over the entity regardless of ownership percentage. True for senior managing officials and others with control authority per FinCEN rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this beneficial ownership record was first created in the system. Supports audit trail and regulatory examination requirements.',
    `cta_report_date` DATE COMMENT 'Date on which the beneficial ownership information was reported to FinCEN under the Corporate Transparency Act.',
    `cta_report_reference_number` STRING COMMENT 'Unique reference number assigned by FinCEN for the beneficial ownership report filed under the Corporate Transparency Act.',
    `cta_reporting_status` STRING COMMENT 'Status of beneficial ownership reporting to FinCEN under the Corporate Transparency Act. Reported indicates information has been filed with FinCEN, pending indicates filing is in progress, exempt indicates the entity is exempt from CTA reporting, not_required indicates reporting is not required for this ownership record.. Valid values are `reported|pending|exempt|not_required`',
    `data_source` STRING COMMENT 'Identifier of the system or process that created or last updated this beneficial ownership record (e.g., KYC onboarding system, periodic review process, regulatory filing). Supports data lineage and audit trail.',
    `effective_date` DATE COMMENT 'Date from which the beneficial ownership relationship became effective. Represents when the individual began exercising ownership or control over the legal entity.',
    `effective_from_date` DATE COMMENT 'Date when this beneficial ownership relationship became effective. Supports historical tracking of ownership changes over time.',
    `effective_to_date` DATE COMMENT 'Date when this beneficial ownership relationship ended or was superseded. Null for current active relationships. Enables point-in-time ownership reconstruction for regulatory reporting and investigations.',
    `expiry_date` DATE COMMENT 'Date on which the beneficial ownership relationship ended or is scheduled to end. Null if the relationship is ongoing.',
    `identification_document_number` STRING COMMENT 'Unique number or identifier on the government-issued identification document used for beneficial owner verification.',
    `identification_document_type` STRING COMMENT 'Type of government-issued identification document used to verify the identity of the beneficial owner.. Valid values are `passport|drivers_license|national_id|state_id|other`',
    `identification_expiry_date` DATE COMMENT 'Date on which the identification document expires. Null if the document does not expire.',
    `identification_issue_date` DATE COMMENT 'Date on which the identification document was issued by the issuing authority.',
    `identification_issuing_country` STRING COMMENT 'Three-letter ISO country code for the country that issued the identification document.. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Boolean indicator of whether this beneficial ownership relationship is currently active. True = active, False = historical or terminated. Used to filter current UBO relationships for AML screening and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this beneficial ownership record was last updated. Tracks changes to ownership information for compliance monitoring and audit purposes.',
    `last_reported_date` DATE COMMENT 'Date when this beneficial ownership information was last reported to regulatory authorities. Used to track reporting compliance and identify records requiring updated filings.',
    `nationality` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the beneficial owners nationality or citizenship. May differ from residence. Used for sanctions screening and tax reporting.. Valid values are `^[A-Z]{3}$`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of beneficial ownership information. Review frequency is risk-based: low risk annually, medium risk semi-annually, high risk quarterly.',
    `notes` STRING COMMENT 'Free-text field for additional context, exceptions, or special circumstances related to the beneficial ownership relationship. Used by compliance officers to document complex ownership structures or unusual situations.',
    `owner_city` STRING COMMENT 'City of residence for the beneficial owner.',
    `owner_date_of_birth` DATE COMMENT 'Date of birth of the beneficial owner individual, required for identity verification and regulatory reporting.',
    `owner_full_name` STRING COMMENT 'Full legal name of the individual beneficial owner as it appears on official identification documents.',
    `owner_postal_code` STRING COMMENT 'Postal or ZIP code of the beneficial owners residential address.',
    `owner_residential_address` STRING COMMENT 'Complete residential street address of the beneficial owner, including street number, street name, apartment or suite number.',
    `owner_state_province` STRING COMMENT 'State or province of residence for the beneficial owner.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest held by the beneficial owner in the legal entity. Expressed as a decimal (e.g., 25.00 for 25%). Used to determine if the 25% threshold for UBO identification is met per FinCEN rules.',
    `ownership_status` STRING COMMENT 'Current lifecycle status of the beneficial ownership record. Verified: ownership confirmed and documented. Pending verification: awaiting documentation. Under review: being investigated or updated. Disputed: conflicting information. Expired: verification period lapsed. Terminated: ownership ended.. Valid values are `verified|pending_verification|under_review|disputed|expired|terminated`',
    `ownership_tier_level` STRING COMMENT 'Numeric indicator of the ownership chain depth. 1 = direct ownership, 2 = one intermediary, 3 = two intermediaries, etc. Supports recursive traversal of multi-tier ownership structures for UBO graph construction.',
    `pep_screening_date` DATE COMMENT 'Date on which the most recent PEP screening was performed for the beneficial owner.',
    `pep_status` STRING COMMENT 'Classification of whether the beneficial owner is a Politically Exposed Person or related party. Not PEP: no political exposure. Domestic PEP: prominent domestic political figure. Foreign PEP: foreign government official. International organization PEP: senior official in international body. PEP family member: immediate family of PEP. PEP close associate: known business associate of PEP. Used for enhanced due diligence and AML risk scoring.. Valid values are `not_pep|domestic_pep|foreign_pep|international_organization_pep|pep_family_member|pep_close_associate`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator of whether this beneficial ownership record must be included in regulatory reports to FinCEN, EU beneficial ownership registers, or other authorities. True = reportable, False = not reportable.',
    `risk_rating` STRING COMMENT 'Overall AML and financial crime risk rating assigned to this beneficial ownership relationship. Low: standard monitoring. Medium: enhanced monitoring. High: intensive monitoring and senior management approval. Prohibited: relationship not permitted. Drives CDD intensity and monitoring frequency.. Valid values are `low|medium|high|prohibited`',
    `risk_rating_date` DATE COMMENT 'Date when the risk rating was assigned or last reviewed. Used to track risk assessment refresh cycles per risk-based approach requirements.',
    `sanctions_screening_date` DATE COMMENT 'Date when the beneficial owner was last screened against sanctions lists (OFAC, UN, EU, etc.). Used to ensure ongoing compliance with sanctions screening requirements.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions list screening for the beneficial owner. Cleared: no matches found. Match found: potential match requires review. Pending review: screening in progress. False positive: match determined to be different person. True positive: confirmed sanctions match requiring escalation.. Valid values are `cleared|match_found|pending_review|false_positive|true_positive`',
    `source_of_funds` STRING COMMENT 'Description of the origin of funds used in the business relationship (e.g., salary, sale of assets, loan proceeds). Required for enhanced due diligence and large transaction monitoring.',
    `source_of_wealth` STRING COMMENT 'Description of how the beneficial owner accumulated their wealth (e.g., inheritance, business ownership, employment, investments). Required for enhanced due diligence on high-risk customers and PEPs.',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this beneficial ownership record originated.',
    `tax_identification_number` STRING COMMENT 'Tax identification number for the beneficial owner in their country of tax residence. Required for FATCA and CRS reporting of beneficial ownership information to tax authorities.',
    `tax_residence_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the beneficial owners country of tax residence. Used for FATCA, CRS, and cross-border tax reporting obligations.. Valid values are `^[A-Z]{3}$`',
    `ubo_threshold_met` BOOLEAN COMMENT 'Boolean indicator of whether this ownership meets the regulatory threshold for UBO reporting (typically 25% ownership or control). True = meets threshold and must be reported. False = below threshold.',
    `verification_date` DATE COMMENT 'Date when the beneficial ownership information was verified. Used to track CDD refresh cycles and ensure compliance with periodic review requirements.',
    `verification_document_reference` STRING COMMENT 'Reference identifier or file path to the supporting documentation used to verify beneficial ownership. Links to document management system for audit trail and regulatory examination.',
    `verification_method` STRING COMMENT 'Method used to verify the identity of the beneficial owner. Documentary indicates verification through government-issued documents, non-documentary indicates verification through independent sources, electronic indicates automated electronic verification, in-person indicates face-to-face verification, third-party indicates verification through a trusted third-party service.. Valid values are `documentary|non_documentary|electronic|in_person|third_party`',
    `verification_status` STRING COMMENT 'Current status of the beneficial owner identity verification process. Verified indicates successful completion of KYC verification, pending indicates verification in progress, failed indicates verification could not be completed, expired indicates verification has lapsed and requires renewal.. Valid values are `verified|pending|failed|expired|not_verified`',
    `voting_rights_percentage` DECIMAL(18,2) COMMENT 'Percentage of voting rights held by the beneficial owner, which may differ from ownership percentage in cases of non-voting shares or special voting arrangements. Used to assess control for UBO determination.',
    CONSTRAINT pk_customer_beneficial_owner PRIMARY KEY(`customer_beneficial_owner_id`)
) COMMENT 'Registry of ultimate beneficial owners (UBOs) for corporate and trust parties, satisfying FinCEN Beneficial Ownership Rule (31 CFR 1010.230) and FATF Recommendations 24/25. Captures: owning party_id (the natural person UBO), owned party_id (the legal entity), ownership percentage, control type (direct ownership, indirect ownership, senior managing official, trustee, settlor, beneficiary), verification method, verification date, document reference, and is_active flag. Supports complex multi-tier ownership chains via recursive traversal and enables automated UBO graph construction for AML screening, CDD, and regulatory reporting (FinCEN BOI, EU AMLD beneficial ownership registers).';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_address` (
    `party_address_id` BIGINT COMMENT 'Unique identifier for the party address record. Primary key.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Address management - address types (Residential, Business, Mailing, Legal) must be standardized for correspondence routing, regulatory notifications, and KYC address verification.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Address validation - address country must be validated for correspondence routing, regulatory notifications, geographic risk rating, and postal format validation.',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, counterparty, or entity) to whom this address or contact detail belongs.',
    `address_line_1` STRING COMMENT 'First line of the physical address (street number, street name, building name). Applicable only when contact_type is physical_address.',
    `address_line_2` STRING COMMENT 'Second line of the physical address (apartment, suite, floor, unit). Applicable only when contact_type is physical_address.',
    `address_line_3` STRING COMMENT 'Third line of the physical address (additional location details). Applicable only when contact_type is physical_address.',
    `city` STRING COMMENT 'City or municipality of the physical address. Applicable only when contact_type is physical_address.',
    `contact_type` STRING COMMENT 'Type of contact information: physical_address (registered, mailing, residential, business, branch, billing), mobile, home_phone, work_phone, fax, primary_email, secondary_email, or digital identifier. [ENUM-REF-CANDIDATE: physical_address|mobile|home_phone|work_phone|fax|primary_email|secondary_email — 7 candidates stripped; promote to reference product]',
    `contact_value` DECIMAL(18,2) COMMENT 'The actual contact detail value: phone number (with country code), email address, fax number, or digital identifier. Applicable for electronic contact types (mobile, home_phone, work_phone, fax, primary_email, secondary_email).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact detail or address record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `do_not_call` BOOLEAN COMMENT 'Flag indicating whether the party has requested not to be contacted via phone at this number. True if do-not-call requested, False otherwise. Applicable for phone contact types.',
    `do_not_mail` BOOLEAN COMMENT 'Flag indicating whether the party has requested not to receive physical mail at this address. True if do-not-mail requested, False otherwise. Applicable for physical address contact types.',
    `effective_date` DATE COMMENT 'Date from which this contact detail or address becomes active and valid for use. Format: yyyy-MM-dd.',
    `expiry_date` DATE COMMENT 'Date when this contact detail or address ceases to be valid. Null indicates no expiration. Format: yyyy-MM-dd.',
    `geographic_risk_score` DECIMAL(18,2) COMMENT 'AML (Anti-Money Laundering) risk score assigned to the geographic location of this address, based on jurisdiction risk ratings. Higher scores indicate higher risk. Applicable for physical address contact types.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this is the primary contact point or address for the party. True if primary, False otherwise.',
    `is_verified` BOOLEAN COMMENT 'Flag indicating whether this contact detail or address has been verified through a validation process. True if verified, False otherwise.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact detail or address record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the physical address for geocoding and mapping. Applicable only when contact_type is physical_address.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the physical address for geocoding and mapping. Applicable only when contact_type is physical_address.',
    `opt_in_estatements` BOOLEAN COMMENT 'Flag indicating whether the party has consented to receive electronic statements at this contact point. True if opted in, False otherwise. Applicable for email contact types.',
    `opt_in_marketing` BOOLEAN COMMENT 'Flag indicating whether the party has consented to receive marketing communications at this contact point. True if opted in, False otherwise. Applicable for electronic contact types.',
    `party_address_status` STRING COMMENT 'Current lifecycle status of the contact detail or address: active (in use), inactive (not in use but valid), pending (awaiting verification), invalid (failed verification), expired (past expiry_date), or suspended (temporarily disabled).. Valid values are `active|inactive|pending|invalid|expired|suspended`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the physical address. Applicable only when contact_type is physical_address.',
    `regulatory_notification_flag` BOOLEAN COMMENT 'Flag indicating whether this contact point is designated for receiving regulatory and compliance notifications. True if designated, False otherwise.',
    `source_system` STRING COMMENT 'Name of the operational system from which this contact detail or address was originally captured (e.g., Core Banking System, CRM, Loan Origination System).',
    `state_province` STRING COMMENT 'State, province, or region of the physical address. Applicable only when contact_type is physical_address.',
    `tax_domicile_flag` BOOLEAN COMMENT 'Flag indicating whether this address is used to determine the partys tax domicile for FATCA (Foreign Account Tax Compliance Act) and CRS (Common Reporting Standard) reporting. True if tax domicile, False otherwise. Applicable for physical address contact types.',
    `usage_context` STRING COMMENT 'Business context in which this contact detail or address is used: correspondence (general communication), service (account servicing), billing (invoices and statements), legal (regulatory notices), kyc (identity verification), or emergency (urgent contact).. Valid values are `correspondence|service|billing|legal|kyc|emergency`',
    `verification_date` DATE COMMENT 'Date when the contact detail or address was last verified. Format: yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'Method used to verify the contact detail or address: document (utility bill, bank statement), third_party (credit bureau, data vendor), customer_declaration, site_visit, or electronic (email link, SMS OTP).. Valid values are `document|third_party|customer_declaration|site_visit|electronic`',
    CONSTRAINT pk_party_address PRIMARY KEY(`party_address_id`)
) COMMENT 'Unified contact point registry for all physical addresses and electronic contact details associated with a party. For physical addresses: address type (registered, mailing, residential, business, branch, billing), address lines, city, state/province, postal code, country (ISO 3166-1), geocode, effective/expiry dates, is_primary flag, verification status. For electronic contacts: contact type (mobile, home phone, work phone, fax, primary email, secondary email, digital identifier), contact value, country code, is_verified flag, verification date, opt-in status for marketing/e-statements, do-not-call flag. All entries carry effective/expiry dates and primary/verified flags. Supports regulatory domicile determination (FATCA/CRS situs rules), AML geographic risk scoring, omnichannel CRM integration, and regulatory notification obligations. SINGLE SOURCE OF TRUTH for all party contact information — both physical addresses and electronic contact details. No separate contact table exists.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_contact` (
    `party_contact_id` BIGINT COMMENT 'Unique identifier for the party contact record. Primary key for the party_contact data product.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Contact management - contact types (Mobile, Email, Landline, Fax) must be standardized for omnichannel communication, regulatory notifications, and contact preference management.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Contact validation - phone country codes and address validation require validated country reference for contact center routing, regulatory notifications, and international dialing rules.',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, counterparty, or entity) to whom this contact information belongs. Links to the party master data product.',
    `area_code` STRING COMMENT 'Geographic area code or regional prefix for phone numbers. Applicable to phone contact types only.',
    `bounce_count` STRING COMMENT 'The number of times an email sent to this contact has bounced (failed delivery). Used to identify invalid or inactive email addresses. Applicable to email contact types only.',
    `contact_preference_rank` STRING COMMENT 'Numeric ranking indicating the partys preference order for this contact method. Lower numbers indicate higher preference (1 = most preferred). Used for omnichannel communication routing.',
    `contact_purpose` STRING COMMENT 'The intended purpose or use case for this contact information. Personal for personal communications, business for business-related communications, emergency for urgent notifications, billing for payment-related communications, correspondence for general account communications.. Valid values are `personal|business|emergency|billing|correspondence`',
    `contact_status` STRING COMMENT 'Current operational status of the contact information. Active indicates the contact is valid and in use. Inactive indicates the contact is no longer in use. Bounced indicates email delivery failures. Invalid indicates the contact failed validation. Suspended indicates temporary restriction.. Valid values are `active|inactive|bounced|invalid|suspended`',
    `contact_value` DECIMAL(18,2) COMMENT 'The actual contact information value (phone number, email address, or digital identifier). Format varies by contact type. Classified as restricted PII (Personally Identifiable Information) for phone and email.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this contact record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Immutable audit field.',
    `do_not_call` BOOLEAN COMMENT 'Boolean flag indicating whether the party has requested not to be contacted via phone for marketing or solicitation purposes. True if do-not-call is active, False otherwise. Required for TCPA compliance.',
    `do_not_email` BOOLEAN COMMENT 'Boolean flag indicating whether the party has requested not to be contacted via email for marketing purposes. True if do-not-email is active, False otherwise. Required for CAN-SPAM compliance.',
    `do_not_mail` BOOLEAN COMMENT 'Boolean flag indicating whether the party has requested not to receive physical mail for marketing purposes. True if do-not-mail is active, False otherwise.',
    `effective_from_date` DATE COMMENT 'The date from which this contact information is valid and active. Format: yyyy-MM-dd. Supports temporal tracking of contact information changes.',
    `effective_to_date` DATE COMMENT 'The date until which this contact information is valid. Null indicates the contact is currently active with no planned end date. Format: yyyy-MM-dd. Supports temporal tracking of contact information changes.',
    `extension` STRING COMMENT 'Internal phone extension number for work or business phone contacts. Applicable to work phone contact types only.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary or preferred contact method for the party. True if primary, False otherwise.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the contact information has been verified through a validation process (e.g., email verification link, SMS OTP). True if verified, False otherwise.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the preferred language for communications via this contact method (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `last_bounce_date` DATE COMMENT 'The date of the most recent email bounce. Null if no bounces have occurred. Format: yyyy-MM-dd. Applicable to email contact types only.',
    `last_contact_date` DATE COMMENT 'The date when this contact method was last used to communicate with the party. Null if never contacted. Format: yyyy-MM-dd.',
    `opt_in_estatements` BOOLEAN COMMENT 'Boolean flag indicating whether the party has consented to receive account statements and regulatory notifications electronically via this contact method. True if opted in, False otherwise.',
    `opt_in_estatements_date` DATE COMMENT 'The date when the party provided consent for electronic statements. Null if not opted in. Format: yyyy-MM-dd.',
    `opt_in_marketing` BOOLEAN COMMENT 'Boolean flag indicating whether the party has consented to receive marketing communications via this contact method. True if opted in, False otherwise. Required for GDPR and CAN-SPAM compliance.',
    `opt_in_marketing_date` DATE COMMENT 'The date when the party provided consent for marketing communications. Null if not opted in. Format: yyyy-MM-dd.',
    `source_system` STRING COMMENT 'The operational system or channel from which this contact information was originally captured (e.g., Core Banking System, CRM, Mobile App, Branch, Call Center, Online Banking).',
    `time_zone` STRING COMMENT 'The time zone associated with this contact information, using IANA time zone database format (e.g., America/New_York, Europe/London). Used to schedule communications at appropriate local times and comply with TCPA calling hour restrictions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this contact record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Updated on every change to support change data capture and audit trails.',
    `verification_date` DATE COMMENT 'The date when the contact information was last verified. Null if never verified. Format: yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'The method used to verify the contact information. Options include email verification link, SMS one-time password, voice call verification, manual verification by staff, or third-party verification service.. Valid values are `email_link|sms_otp|voice_call|manual|third_party`',
    CONSTRAINT pk_party_contact PRIMARY KEY(`party_contact_id`)
) COMMENT 'Contact details for a party across all communication channels: phone (mobile, home, work, fax), email (primary, secondary, business), and digital identifiers. Captures: contact type, contact value, country code, is_primary flag, is_verified flag, verification date, opt-in status for marketing, opt-in status for e-statements, do-not-call flag, and effective/expiry dates. Supports omnichannel CRM integration and regulatory notification obligations.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_document` (
    `party_document_id` BIGINT COMMENT 'Unique identifier for the party document record. Primary key.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Document type validation - KYC document types (Passport, Drivers License, Utility Bill, Bank Statement) must be standardized for regulatory reporting consistency and document verification workflows.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: KYC/AML compliance - passport/ID issuing country must be validated for document verification, sanctions screening, and regulatory reporting. Core identity verification process.',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, counterparty, or entity) to whom this document belongs. Links to the party master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or compliance officer who performed or approved the document verification. Links to the employee master record for audit trail purposes.',
    `collection_channel` STRING COMMENT 'Channel or method through which the document was collected from the party. Examples include branch submission, online portal upload, mobile app, email attachment, postal mail, or third-party agent.. Valid values are `branch|online_portal|mobile_app|email|postal_mail|third_party_agent`',
    `collection_date` DATE COMMENT 'Date on which the document was collected or received from the party during the KYC onboarding or periodic review process. Format: yyyy-MM-dd.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the document. Aligns with the banks data classification policy.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this party document record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `destruction_eligible_date` DATE COMMENT 'Date on which the document becomes eligible for secure destruction or deletion based on retention policy and regulatory requirements. Nullable if document must be retained indefinitely. Format: yyyy-MM-dd.',
    `document_format` STRING COMMENT 'File format or MIME type of the stored document (e.g., PDF, JPEG, PNG, TIFF, DOCX, XML). Indicates the digital format in which the document is archived.. Valid values are `pdf|jpeg|png|tiff|docx|xml`',
    `document_language` STRING COMMENT 'ISO 639-2 three-letter language code indicating the primary language in which the document is written (e.g., ENG for English, SPA for Spanish, FRA for French, DEU for German, CHI for Chinese).. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'The unique identification number or reference code printed on the document (e.g., passport number, national ID number, drivers license number, corporate registration number).',
    `document_size_kb` DECIMAL(18,2) COMMENT 'Size of the stored document file in kilobytes. Used for storage management and audit purposes.',
    `document_storage_uri` STRING COMMENT 'Secure storage location reference (URI, file path, or vault key) pointing to the digitized copy of the document in the banks document management system or secure vault. Used to retrieve the document image or PDF for audit and review.',
    `expiry_date` DATE COMMENT 'Date on which the document expires and is no longer valid for identification or verification purposes. Nullable for documents without expiration (e.g., some corporate certificates). Format: yyyy-MM-dd.',
    `is_primary_identity_document` BOOLEAN COMMENT 'Boolean flag indicating whether this document is the primary identity document used for KYC verification (e.g., the main passport or national ID). True if primary, False otherwise.',
    `issue_date` DATE COMMENT 'Date on which the document was originally issued by the authority. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'Name of the government agency, regulatory body, or institution that issued the document (e.g., U.S. Department of State, UK Home Office, Companies House, Ministry of Finance).',
    `last_review_date` DATE COMMENT 'Date on which the document was last reviewed or re-verified by compliance or operations. Used to track periodic KYC refresh cycles. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or observations related to the document collection, verification, or review process. Used by compliance officers and relationship managers for context and audit trail.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this document is required for regulatory reporting purposes (e.g., FATCA, CRS, SAR filing). True if required for reporting, False otherwise.',
    `rejection_reason` STRING COMMENT 'Free-text explanation or code describing why the document was rejected during verification (e.g., expired, illegible, fraudulent, does not match party details, insufficient information). Nullable if document is not rejected.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained in the banks records to comply with regulatory requirements (e.g., 5 years for AML, 7 years for tax records). Drives document lifecycle and archival policies.',
    `review_due_date` DATE COMMENT 'Date by which the document must be reviewed or re-verified as part of periodic KYC refresh or regulatory compliance requirements. Nullable if no periodic review is required. Format: yyyy-MM-dd.',
    `translation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the document requires translation into the banks primary operating language for compliance or operational purposes. True if translation is required, False otherwise.',
    `translation_status` STRING COMMENT 'Status of the document translation process. Indicates whether translation is not required, pending, completed, or certified by a professional translator.. Valid values are `not_required|pending|completed|certified`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this party document record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verification_date` DATE COMMENT 'Date on which the document verification was completed and the verification status was last updated. Format: yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'Method or channel used to verify the authenticity of the document. Examples include manual review by compliance officer, biometric matching, third-party verification bureau (e.g., Experian, LexisNexis), automated OCR and data extraction, video KYC, or in-person verification.. Valid values are `manual_review|biometric_match|third_party_bureau|automated_ocr|video_verification|in_person`',
    `verification_status` STRING COMMENT 'Current verification status of the document in the KYC (Know Your Customer) and CDD (Customer Due Diligence) process. Indicates whether the document has been authenticated and accepted.. Valid values are `unverified|verified|expired|rejected|pending_review|under_investigation`',
    CONSTRAINT pk_party_document PRIMARY KEY(`party_document_id`)
) COMMENT 'Identity and supporting documents collected during KYC onboarding and periodic reviews. Captures: document type (passport, national ID, drivers license, articles of incorporation, certificate of good standing, audited financials, utility bill), issuing country, document number, issue date, expiry date, verification status (unverified, verified, expired), verification method (manual, biometric, third-party bureau), document storage reference (vault URI), and collecting employee_id. Supports CDD evidence chain and regulatory audit trail.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`relationship_hierarchy` (
    `relationship_hierarchy_id` BIGINT COMMENT 'Unique identifier for the party-to-party relationship record. Primary key for the relationship hierarchy entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or relationship manager responsible for managing this party-to-party relationship. Used for accountability, CRM workflows, and performance tracking.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this relationship record. Used for audit trails, accountability, and compliance with SOX and data governance requirements.',
    `party_id` BIGINT COMMENT 'Identifier of the first party in the relationship. For hierarchical relationships, this is typically the parent, controlling entity, or primary party. For bilateral relationships, this is one side of the association.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Relationship management - relationship types (Parent-Subsidiary, Guarantor-Borrower, Ultimate Parent, Affiliate) must be standardized for credit risk aggregation, related-party reporting, and exposure',
    `consolidated_exposure_flag` BOOLEAN COMMENT 'Indicates whether this relationship should be included in consolidated exposure calculations for regulatory capital and large exposure reporting (Basel III). True for relationships that create economic dependency or control (e.g., parent-subsidiary, guarantor-borrower).',
    `control_indicator` BOOLEAN COMMENT 'Indicates whether Party A exercises control over Party B, as defined by accounting standards (IFRS 10) or regulatory frameworks (Basel III). Control may exist even without majority ownership (e.g., through voting rights, board representation, or contractual arrangements). Used for consolidated financial reporting and group-level risk aggregation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was first created in the system. Used for audit trails, data lineage, and regulatory compliance.',
    `cross_sell_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this relationship enables cross-sell opportunities (e.g., household members, corporate group entities). Used for CRM analytics, marketing campaigns, and customer lifetime value (CLTV) scoring.',
    `effective_date` DATE COMMENT 'The date on which this relationship became active or legally binding. Used for temporal analysis, historical relationship tracking, and regulatory reporting (e.g., KYC refresh, group structure changes).',
    `expiry_date` DATE COMMENT 'The date on which this relationship ends or is scheduled to terminate. Null for open-ended or ongoing relationships. Used for relationship lifecycle management and automated alerts for relationship renewals or reviews.',
    `hierarchy_level` STRING COMMENT 'The depth or tier of this relationship within a hierarchical tree structure. Level 1 represents the top-most parent or ultimate controlling entity. Used for corporate group structure traversal and consolidated exposure calculation. Null for non-hierarchical (bilateral or reciprocal) relationships.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this relationship is currently active and in effect. False indicates the relationship has been terminated, suspended, or superseded. Used for filtering current relationships in exposure calculations, CRM views, and regulatory reporting.',
    `kyc_last_review_date` DATE COMMENT 'The date on which this relationship was last reviewed or refreshed as part of KYC/CDD procedures. Used for tracking KYC refresh cycles and ensuring compliance with periodic review requirements.',
    `kyc_next_review_date` DATE COMMENT 'The scheduled date for the next KYC/CDD review or refresh of this relationship. Used for proactive compliance management and automated workflow triggers.',
    `kyc_verification_status` STRING COMMENT 'Indicates the KYC verification status of this relationship. Verified indicates the relationship has been validated through KYC/CDD procedures. Pending indicates verification is in progress. Expired indicates the relationship requires re-verification. Used for AML compliance and regulatory reporting.. Valid values are `verified|pending|failed|expired|not_required`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was last updated or modified. Used for audit trails, change tracking, and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional context, comments, or special instructions related to this relationship. Used for capturing qualitative information that does not fit structured fields (e.g., special approval conditions, relationship history).',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership, control, or beneficial interest that Party A holds in Party B. Applicable for ownership, parent-subsidiary, and beneficial ownership relationships. Used for consolidated exposure calculations and regulatory reporting (e.g., Basel III, IFRS 10). Null for non-ownership relationships.',
    `pep_indicator` BOOLEAN COMMENT 'Indicates whether either party in this relationship is classified as a Politically Exposed Person (PEP) or is associated with a PEP. Used for enhanced due diligence requirements and AML compliance.',
    `related_party_transaction_flag` BOOLEAN COMMENT 'Indicates whether transactions between these parties are classified as related party transactions under accounting standards (IAS 24) or regulatory frameworks. Used for disclosure requirements, conflict of interest management, and regulatory reporting.',
    `relationship_direction` STRING COMMENT 'Indicates whether the relationship is directional (hierarchical, with a clear parent-child or controlling-controlled structure), bilateral (symmetric association where both parties have equal standing), or reciprocal (mutual obligations or roles).. Valid values are `hierarchical|bilateral|reciprocal`',
    `relationship_source_code` STRING COMMENT 'The unique identifier of this relationship in the source system. Used for traceability, reconciliation, and bi-directional synchronization with operational systems.',
    `relationship_source_system` STRING COMMENT 'The operational system of record from which this relationship was sourced (e.g., Core Banking System, CRM, Loan Origination System). Used for data lineage, reconciliation, and troubleshooting.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the relationship. Active indicates the relationship is in effect. Pending indicates the relationship is awaiting approval or documentation. Under review indicates the relationship is being validated or updated (e.g., during KYC refresh). Terminated indicates the relationship has ended.. Valid values are `active|inactive|pending|suspended|terminated|under_review`',
    `risk_rating` STRING COMMENT 'The risk classification assigned to this relationship based on AML, credit, or operational risk assessment. Used for risk-based KYC/CDD procedures, enhanced due diligence triggers, and regulatory reporting (e.g., SAR filing thresholds).. Valid values are `low|medium|high|very_high`',
    `role_a` STRING COMMENT 'The role or function that Party A plays in this relationship (e.g., parent, guarantor, account holder, introducer, controlling shareholder, trustee). Provides semantic context for Party As position.',
    `role_b` STRING COMMENT 'The role or function that Party B plays in this relationship (e.g., subsidiary, borrower, co-applicant, authorized signatory, beneficial owner, beneficiary). Provides semantic context for Party Bs position.',
    `sanctions_last_screened_date` DATE COMMENT 'The date on which this relationship was last screened against sanctions lists (e.g., OFAC, UN, EU). Used for tracking screening frequency and ensuring compliance with continuous monitoring requirements.',
    `sanctions_screening_status` STRING COMMENT 'Indicates the result of sanctions screening for this relationship. Clear indicates no sanctions matches. Match indicates a potential or confirmed sanctions hit. Pending indicates screening is in progress. Used for AML compliance and regulatory reporting.. Valid values are `clear|match|pending|not_screened`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to the legal or supporting documentation that evidences this relationship (e.g., shareholder agreement, power of attorney document, joint account application, beneficial ownership declaration). Used for audit trails and regulatory compliance (KYC/AML).',
    CONSTRAINT pk_relationship_hierarchy PRIMARY KEY(`relationship_hierarchy_id`)
) COMMENT 'Unified registry of all inter-party relationships including hierarchical structures (parent-subsidiary, branch, household, ownership chains) and bilateral/reciprocal associations (guarantor-borrower, co-applicant, authorized signatory, power of attorney, referral source, introducer, joint account holder). Captures: party_a_id, party_b_id, relationship type, relationship direction (hierarchical, bilateral, reciprocal), role_a, role_b, hierarchy level (for tree structures), effective date, expiry date, is_active flag, and supporting document reference. Enables corporate group structure traversal, consolidated exposure calculation (Basel III large exposure framework), group-level KYC, household-level cross-sell analytics, relationship-aware credit aggregation, and CRM relationship mapping. SINGLE SOURCE OF TRUTH for all party-to-party relationships — both hierarchical and bilateral. No separate bilateral relationship table exists. Sourced from Core Banking System and CRM.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Foreign key reference to the segment definition. Links to the segment master table that defines segment criteria and characteristics.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who manually assigned or approved this segment assignment. Populated for MANUAL_OVERRIDE assignments or when manual approval is required.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Line of business standardization - LOB codes (Retail Banking, Commercial Banking, Investment Banking, Wealth Management) must be consistent for P&L reporting, regulatory submissions, and segment perfo',
    `party_id` BIGINT COMMENT 'Foreign key reference to the customer or counterparty being assigned to this segment. Links to the customer master data.',
    `assignment_method` STRING COMMENT 'The methodology used to assign the party to this segment. RULE_BASED: automated rule engine based on predefined criteria; MANUAL_OVERRIDE: manual assignment by relationship manager or operations; MODEL_DRIVEN: machine learning or statistical model output.. Valid values are `RULE_BASED|MANUAL_OVERRIDE|MODEL_DRIVEN`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment assignment record was created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and temporal analysis.',
    `aum_threshold_max` DECIMAL(18,2) COMMENT 'Maximum Assets Under Management threshold for this segment assignment. Defines the upper bound of the segment tier. Expressed in base currency.',
    `aum_threshold_min` DECIMAL(18,2) COMMENT 'Minimum Assets Under Management threshold required for this segment assignment. Used for wealth management and private banking segmentation. Expressed in base currency.',
    `campaign_eligibility_flag` BOOLEAN COMMENT 'Boolean flag indicating whether customers in this segment are eligible for targeted marketing campaigns. False may indicate regulatory restrictions or opt-out status.',
    `cltv_cohort` STRING COMMENT 'CLTV-based cohort classification for segment analysis and targeted campaigns. Values: HIGH (top tier value), MEDIUM (mid tier value), LOW (entry tier value).. Valid values are `HIGH|MEDIUM|LOW`',
    `cltv_score` DECIMAL(18,2) COMMENT 'Calculated Customer Lifetime Value score at the time of segment assignment. Used for cohort analysis and segment migration tracking. Higher scores indicate greater long-term value.',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special instructions related to this segment assignment. Supports operational communication and exception handling.',
    `criteria` STRING COMMENT 'Description of the business rules or criteria that qualified the party for this segment (e.g., AUM threshold, revenue tier, relationship tenure, product holdings). Supports transparency and audit.',
    `effective_date` DATE COMMENT 'The date from which this segment assignment becomes active and applicable for pricing, service levels, and targeting. Format: yyyy-MM-dd.',
    `expiry_date` DATE COMMENT 'The date on which this segment assignment expires or is superseded by a new assignment. Null indicates an open-ended assignment. Format: yyyy-MM-dd.',
    `ftp_pricing_tier` STRING COMMENT 'Funds Transfer Pricing tier associated with this segment. Determines internal cost of funds allocation and profitability measurement. Aligns with segment-based pricing strategy.',
    `is_current` BOOLEAN COMMENT 'Boolean flag indicating whether this is the currently active segment assignment for the party. True for the active record, False for historical records.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this segment assignment. Supports compliance with segment review policies and ensures assignment accuracy. Format: yyyy-MM-dd.',
    `model_run_reference` STRING COMMENT 'Identifier of the segmentation model execution run that produced this assignment. Enables traceability and model performance analysis. Populated only when assignment_method is MODEL_DRIVEN.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this segment assignment. Ensures timely reassessment of segment appropriateness. Format: yyyy-MM-dd.',
    `nps_score` STRING COMMENT 'Net Promoter Score at the time of segment assignment, reflecting customer satisfaction and loyalty. Range: -100 to +100. Used for service quality tracking by segment.',
    `override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment was manually overridden from the system-recommended segment. True indicates a manual override occurred.',
    `override_rationale` STRING COMMENT 'Business justification for manual override of the system-recommended segment assignment. Required when override_flag is True. Supports audit and compliance review.',
    `previous_segment_code` STRING COMMENT 'The segment code that was active immediately prior to this assignment. Enables segment migration analysis and transition tracking. Null for initial segment assignments.',
    `record_status` STRING COMMENT 'Current status of this segment assignment record in the data warehouse. ACTIVE: currently in effect; INACTIVE: expired or terminated; SUPERSEDED: replaced by a newer assignment; PENDING: awaiting approval or activation.. Valid values are `ACTIVE|INACTIVE|SUPERSEDED|PENDING`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the segment for capital adequacy and reporting purposes under Basel III and other frameworks. Determines Risk-Weighted Asset (RWA) treatment.. Valid values are `RETAIL|CORPORATE|SOVEREIGN|FINANCIAL_INSTITUTION`',
    `revenue_threshold_max` DECIMAL(18,2) COMMENT 'Maximum annual revenue threshold for corporate and commercial customer segmentation. Defines the upper bound of the segment tier. Expressed in base currency.',
    `revenue_threshold_min` DECIMAL(18,2) COMMENT 'Minimum annual revenue threshold for corporate and commercial customer segmentation. Used to classify SME, mid-market, and large corporate segments. Expressed in base currency.',
    `risk_rating` STRING COMMENT 'Risk classification of the segment for credit risk, operational risk, and compliance purposes. Influences credit limits, monitoring intensity, and approval authorities.. Valid values are `LOW|MEDIUM|HIGH|VERY_HIGH`',
    `segment_code` STRING COMMENT 'Business code representing the customer segment classification. Values include: MASS_MARKET (mass market retail), MASS_AFFLUENT (mass affluent retail), HNW (High Net Worth), UHNW (Ultra High Net Worth), SME (Small and Medium Enterprise), MID_MARKET (mid-market corporate). [ENUM-REF-CANDIDATE: MASS_MARKET|MASS_AFFLUENT|HNW|UHNW|SME|MID_MARKET|LARGE_CORPORATE|INSTITUTIONAL|GOVERNMENT — promote to reference product]. Valid values are `MASS_MARKET|MASS_AFFLUENT|HNW|UHNW|SME|MID_MARKET`',
    `segment_name` STRING COMMENT 'Human-readable name of the customer segment for reporting and display purposes.',
    `service_level` STRING COMMENT 'Service level entitlement associated with this segment. Determines access to relationship managers, priority servicing, and product offerings. Values: PREMIUM (dedicated RM, priority service), STANDARD (shared RM, standard service), BASIC (self-service, limited support).. Valid values are `PREMIUM|STANDARD|BASIC`',
    `source_system` STRING COMMENT 'Name of the source system that originated this segment assignment record (e.g., CRM, Segmentation Engine, Core Banking System). Supports data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'Unique identifier of this segment assignment record in the source system. Enables traceability back to the originating system for reconciliation and troubleshooting.',
    `sub_segment` STRING COMMENT 'Granular sub-classification within the primary segment, enabling more precise targeting and analysis (e.g., within HNW: emerging wealth, established wealth, legacy wealth).',
    `transition_date` DATE COMMENT 'The date on which the customer transitioned from the previous segment to the current segment. Used for segment migration reporting and trend analysis. Format: yyyy-MM-dd.',
    `transition_reason` STRING COMMENT 'Business reason for the segment transition (e.g., AUM growth, revenue decline, relationship upgrade, regulatory reclassification). Supports root cause analysis of segment movements.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Segment definition and time-series party assignment record supporting product targeting, pricing tiers, and service-level determination. Segment definitions: segment code (mass market, mass affluent, HNW, UHNW, SME, mid-market, large corporate, institutional, government), sub-segment, LOB, and segment criteria. Party-level assignments: party_id, segment_id, effective date, expiry date, assignment method (rule-based, manual override, model-driven), model run_id, assigned_by employee_id, is_current flag, override flag with rationale. Supports CLTV cohort analysis, segment migration reporting, segment transition analysis, FTP pricing tier determination, and targeted campaign eligibility. SINGLE SOURCE OF TRUTH for both segment definitions and party-to-segment assignments — no separate assignment table exists. Sourced from CRM and segmentation engine.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_segment_assignment` (
    `party_segment_assignment_id` BIGINT COMMENT 'Unique identifier for each party segment assignment record. Primary key for the party segment assignment entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Customer segments are mapped to profit centers for revenue attribution, segment P&L reporting, RAROC calculation, and management reporting. Essential for line-of-business profitability analysis and st',
    `branch_id` BIGINT COMMENT 'Reference to the branch or service center associated with this segment assignment, supporting geographic and organizational segmentation.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager or account officer assigned to parties in this segment, supporting personalized service delivery.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: LOB standardization for segment assignment - line of business codes must be consistent for segment performance reporting, cross-LOB analytics, and customer profitability analysis.',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, counterparty, or entity) being assigned to a segment. Links to the party master entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who created or approved the segment assignment, supporting accountability and audit trail requirements.',
    `segment_id` BIGINT COMMENT 'Reference to the customer segment classification being assigned. Links to the customer segment reference entity.',
    `approval_date` DATE COMMENT 'Date when the segment assignment was formally approved, supporting audit trail and governance requirements.',
    `assignment_date` DATE COMMENT 'Date when the segment assignment was created or recorded in the system, distinct from the effective date.',
    `assignment_method` STRING COMMENT 'Methodology used to assign the party to the segment, indicating whether it was automated through business rules, manually overridden by staff, or driven by analytical models.. Valid values are `rule_based|manual_override|model_driven|system_generated|migration|bulk_import`',
    `assignment_reason` STRING COMMENT 'Business justification or rationale for the segment assignment, capturing why the party was placed in this particular segment.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the segment assignment indicating whether it is currently in effect, pending approval, or has been terminated.. Valid values are `active|inactive|pending|expired|superseded|cancelled`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the segment assignment was created or recorded, supporting detailed audit trail and sequencing requirements.',
    `aum_band` STRING COMMENT 'Assets Under Management band or range associated with the segment assignment, particularly relevant for wealth management and private banking segments.',
    `campaign_eligibility_flag` BOOLEAN COMMENT 'Boolean flag indicating whether parties in this segment assignment are eligible for targeted marketing campaigns and promotional activities.',
    `cltv_cohort` STRING COMMENT 'Customer Lifetime Value cohort classification associated with this segment assignment, enabling CLTV-based analysis and targeted strategies.',
    `comments` STRING COMMENT 'Free-text comments or notes providing additional context, justification, or special considerations related to the segment assignment.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level (expressed as percentage) associated with the segment assignment, indicating the reliability of the classification.',
    `effective_date` DATE COMMENT 'Date when the segment assignment becomes active and valid for business operations, reporting, and analytics.',
    `expiry_date` DATE COMMENT 'Date when the segment assignment ceases to be valid. Null indicates an open-ended assignment with no predetermined end date.',
    `geographic_region` STRING COMMENT 'Geographic region or market associated with the segment assignment, supporting regional segmentation and market analysis.',
    `is_current` BOOLEAN COMMENT 'Boolean flag indicating whether this is the currently active segment assignment for the party. True indicates the current assignment; False indicates a historical or superseded assignment.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary segment assignment when a party may belong to multiple segments simultaneously.',
    `model_name` STRING COMMENT 'Name of the analytical or segmentation model used to determine the segment assignment (e.g., Customer Lifetime Value (CLTV) Model, Risk-Based Segmentation Model).',
    `model_run_reference` STRING COMMENT 'Reference identifier for the analytical model execution that generated this segment assignment, enabling traceability to specific model runs for audit and validation purposes.',
    `model_score` DECIMAL(18,2) COMMENT 'Numerical score produced by the segmentation model indicating the strength or confidence of the segment assignment.',
    `model_version` STRING COMMENT 'Version identifier of the segmentation model used, supporting model governance and change tracking over time.',
    `priority_rank` STRING COMMENT 'Numerical ranking indicating the priority or precedence of this segment assignment when multiple concurrent assignments exist for the same party.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment assignment record was first created in the data platform, supporting audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment assignment record was last modified in the data platform, supporting change tracking and audit requirements.',
    `revenue_band` STRING COMMENT 'Revenue band or range associated with the segment assignment, supporting revenue-based segmentation strategies.',
    `review_date` DATE COMMENT 'Date when the segment assignment is scheduled for review or reassessment, supporting periodic validation and refresh cycles.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which the segment assignment should be reviewed and potentially updated, supporting ongoing segmentation accuracy.',
    `risk_rating` STRING COMMENT 'Risk classification associated with the segment assignment, supporting risk-based customer management and Anti-Money Laundering (AML) compliance requirements.. Valid values are `low|medium|high|very_high|critical`',
    `segment_tier` STRING COMMENT 'Hierarchical tier classification within the segment, supporting multi-level segmentation strategies (e.g., Tier 1 for highest value customers).. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5`',
    `service_level` STRING COMMENT 'Service level or tier associated with the segment assignment, determining the level of service, support, and benefits provided to the party.. Valid values are `basic|standard|premium|platinum|private`',
    `source_system` STRING COMMENT 'Name or identifier of the source system that originated or provided the segment assignment data, supporting data lineage and reconciliation.',
    `transition_date` DATE COMMENT 'Date when the party transitioned from the previous segment to the current segment, supporting segment migration analysis.',
    `transition_reason` STRING COMMENT 'Business reason or trigger for the segment transition, capturing why the party moved from one segment to another.',
    CONSTRAINT pk_party_segment_assignment PRIMARY KEY(`party_segment_assignment_id`)
) COMMENT 'Time-series assignment of segment classifications to parties, enabling segment history tracking and transition analysis. Captures: party_id, customer_segment_id, effective date, expiry date, assignment method (rule-based, manual override, model-driven), model run_id, assigned_by employee_id, and is_current flag. Supports CLTV cohort analysis, segment migration reporting, and targeted campaign eligibility.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`onboarding_case` (
    `onboarding_case_id` BIGINT COMMENT 'Unique identifier for the onboarding case record. Primary key for the onboarding case entity.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the manager or authorized approver who provided final approval for the onboarding case, required for compliance and audit trail.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Branch-originated onboarding cases require branch FK for origination tracking, branch performance metrics, regulatory reporting, and SLA compliance monitoring. Removes denormalized branch_code in favo',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Tracks application-to-activation workflow for wealth onboarding. Enables time-to-book KPIs, regulatory onboarding reporting (MiFID II suitability timeline), and links initial product application to re',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: New customer origination is attributed to profit centers for customer acquisition revenue recognition, origination team performance measurement, and new business P&L tracking. Essential for growth str',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, corporate entity, or counterparty) being onboarded. Links to the party master record in the customer domain.',
    `primary_onboarding_assigned_analyst_employee_id` BIGINT COMMENT 'Employee identifier of the analyst or case manager currently assigned to process and manage this onboarding case through its workflow stages.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Onboarding workflow - regulatory jurisdiction determines which licensing, disclosure, suitability, and KYC rules apply. Drives onboarding checklist, required documents, and approval workflows.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Onboarding analytics - rejection reasons must be standardized for root cause analysis, fair lending reporting (adverse action notices), and process improvement initiatives.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Onboarding activities incur operational costs that must be allocated to cost centers for customer acquisition cost analysis, profitability measurement, and management accounting. Required for activity',
    `tertiary_onboarding_last_modified_by_employee_id` BIGINT COMMENT 'Employee identifier of the user who last modified this onboarding case record, supporting audit trail and accountability requirements.',
    `aml_screening_date` DATE COMMENT 'Date when AML screening was completed for this onboarding case.',
    `aml_screening_status` STRING COMMENT 'Status of AML screening against sanctions lists, PEP (Politically Exposed Persons) databases, and adverse media: not started, in progress, clear, potential match, confirmed match, escalated, or approved with conditions. [ENUM-REF-CANDIDATE: not_started|in_progress|clear|potential_match|confirmed_match|escalated|approved_with_conditions — 7 candidates stripped; promote to reference product]',
    `application_date` DATE COMMENT 'Date when the onboarding application was initially submitted by the party or on behalf of the party.',
    `application_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the onboarding application was submitted, capturing the exact moment of case initiation for audit and SLA tracking purposes.',
    `beneficial_owner_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether beneficial ownership has been verified and documented for this onboarding case, required for corporate and institutional entities. True indicates verified, False indicates pending or not applicable.',
    `case_number` STRING COMMENT 'Externally visible business identifier for the onboarding case, used for tracking and reference in customer communications and operational workflows.. Valid values are `^[A-Z0-9]{8,20}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the onboarding case workflow: initiated, document collection, KYC (Know Your Customer) review, AML (Anti-Money Laundering) screening, credit check, compliance approval, final approval, account opening, completed, rejected, withdrawn, or expired. [ENUM-REF-CANDIDATE: initiated|document_collection|kyc_review|aml_screening|credit_check|compliance_approval|final_approval|account_opening|completed|rejected|withdrawn|expired — 12 candidates stripped; promote to reference product]',
    `completion_date` DATE COMMENT 'Date when the onboarding case was successfully completed and the account or relationship was activated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding case record was first created in the system, used for audit trail and data lineage tracking.',
    `credit_check_status` STRING COMMENT 'Status of credit assessment for this onboarding case: not required (for non-credit products), pending, completed, approved, declined, or requiring manual review.. Valid values are `not_required|pending|completed|approved|declined|manual_review`',
    `credit_score` STRING COMMENT 'Credit score obtained during the onboarding credit assessment, typically from credit bureaus. Used for risk rating and product eligibility determination.',
    `crs_status` STRING COMMENT 'CRS compliance status for this onboarding case, applicable for international tax reporting: not applicable, pending review, compliant, non-compliant, or exempt.. Valid values are `not_applicable|pending|compliant|non_compliant|exempt`',
    `customer_segment` STRING COMMENT 'Target customer segment for this onboarding case: retail, mass affluent, private banking, small business, commercial, corporate, institutional, or government. [ENUM-REF-CANDIDATE: retail|mass_affluent|private_banking|small_business|commercial|corporate|institutional|government — 8 candidates stripped; promote to reference product]',
    `document_checklist_complete_flag` BOOLEAN COMMENT 'Boolean indicator of whether all required documentation has been collected and verified for this onboarding case. True indicates complete, False indicates pending documents.',
    `expected_account_balance` DECIMAL(18,2) COMMENT 'Expected initial account balance or Assets Under Management (AUM) indicated by the applicant during onboarding, used for relationship planning and resource allocation.',
    `expected_monthly_transaction_volume` STRING COMMENT 'Expected number of transactions per month indicated by the applicant, used for account type recommendation and fee structure determination.',
    `fatca_status` STRING COMMENT 'FATCA compliance status for this onboarding case: not applicable, pending review, compliant, non-compliant, or exempt.. Valid values are `not_applicable|pending|compliant|non_compliant|exempt`',
    `kyc_completion_date` DATE COMMENT 'Date when the KYC verification process was completed and approved for this onboarding case.',
    `kyc_status` STRING COMMENT 'Status of the KYC verification process for this onboarding case: not started, in progress, documents pending, under review, approved, rejected, or escalated to compliance. [ENUM-REF-CANDIDATE: not_started|in_progress|documents_pending|under_review|approved|rejected|escalated — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding case record was last updated, capturing the most recent modification for audit and change tracking purposes.',
    `onboarding_channel` STRING COMMENT 'Channel through which the onboarding case was initiated: branch, digital web, digital mobile app, relationship manager assisted, call center, or API partner integration.. Valid values are `branch|digital_web|digital_mobile|relationship_manager|call_center|api_partner`',
    `onboarding_type` STRING COMMENT 'Classification of the onboarding scenario: new-to-bank (first relationship), new-to-product (existing customer adding product), existing-party-new-segment (moving from retail to corporate), cross-sell, relationship upgrade, or entity conversion.. Valid values are `new_to_bank|new_to_product|existing_party_new_segment|cross_sell|relationship_upgrade|entity_conversion`',
    `priority_level` STRING COMMENT 'Priority classification for processing this onboarding case: standard, high, urgent, or VIP (for high-value or strategic relationships).. Valid values are `standard|high|urgent|vip`',
    `product_applied_for` STRING COMMENT 'Name or code of the primary banking product the party is applying for during this onboarding case (e.g., checking account, savings account, credit card, loan, investment account, corporate banking package).',
    `rejection_date` DATE COMMENT 'Date when the onboarding case was formally rejected and the applicant was notified.',
    `rejection_reason_description` STRING COMMENT 'Detailed textual description of the reason for onboarding case rejection, providing context beyond the standardized rejection code.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the party during onboarding based on KYC, AML screening, credit assessment, and business risk factors: low, medium, high, very high, or prohibited.. Valid values are `low|medium|high|very_high|prohibited`',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the onboarding case has breached its SLA target completion timeline. True indicates breach, False indicates within SLA.',
    `sla_target_completion_date` DATE COMMENT 'Target date by which the onboarding case should be completed according to the applicable SLA for the customer segment and product type.',
    `source_system_code` STRING COMMENT 'Code identifying the source system or module from which the onboarding case originated (e.g., core banking onboarding module, digital banking platform, loan origination system).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `stage_entry_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding case entered the current workflow stage. Used for stage duration calculation and SLA (Service Level Agreement) monitoring.',
    `withdrawal_date` DATE COMMENT 'Date when the onboarding case was withdrawn by the applicant before completion.',
    `workflow_stage` STRING COMMENT 'Detailed workflow stage within the onboarding process: application, document submission, identity verification, KYC/CDD (Customer Due Diligence), AML check, credit assessment, risk rating, compliance review, management approval, account setup, funding, or activation. [ENUM-REF-CANDIDATE: application|document_submission|identity_verification|kyc_cdd|aml_check|credit_assessment|risk_rating|compliance_review|management_approval|account_setup|funding|activation — 12 candidates stripped; promote to reference product]',
    CONSTRAINT pk_onboarding_case PRIMARY KEY(`onboarding_case_id`)
) COMMENT 'End-to-end onboarding workflow record for new party acquisition, tracking the full lifecycle from prospect to active client. Captures: onboarding channel (branch, digital, RM-assisted, API), product applied for, onboarding type (new-to-bank, new-to-product, existing-party-new-segment), current workflow stage (application, document collection, KYC review, credit check, approval, account opening), stage entry timestamps, SLA breach flag, assigned analyst employee_id, approver employee_id, rejection reason code, and completion date. Sourced from Core Banking System onboarding module.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`kyc_review_event` (
    `kyc_review_event_id` BIGINT COMMENT 'Unique identifier for the KYC review event record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved the KYC review outcome and risk rating decision.',
    `party_id` BIGINT COMMENT 'Reference to the customer subject to this KYC review.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: KYC review activities incur compliance costs allocated to cost centers for regulatory cost tracking, AML program cost measurement, and operational expense budgeting. Required for compliance function c',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: KYC review classification - review types (Periodic, Event-Driven, Regulatory, Risk-Based) must be standardized for compliance reporting, audit trails, and KYC program effectiveness measurement.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the employee who conducted the KYC review.',
    `adverse_media_findings_flag` BOOLEAN COMMENT 'Indicates whether adverse media findings were identified during this review (True if adverse media found, False otherwise).',
    `beneficial_ownership_verified_flag` BOOLEAN COMMENT 'Indicates whether beneficial ownership information was verified during this review (True if verified, False otherwise). Applicable for legal entity customers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC review event record was first created in the system.',
    `documents_reviewed_count` STRING COMMENT 'The number of customer documents reviewed and validated during this KYC review event.',
    `documents_updated_count` STRING COMMENT 'The number of customer documents that were updated or refreshed as a result of this KYC review.',
    `edd_completion_date` DATE COMMENT 'The date on which Enhanced Due Diligence was completed, if required. Null if EDD not required or not yet completed.',
    `edd_required_flag` BOOLEAN COMMENT 'Indicates whether Enhanced Due Diligence is required as a result of this review (True if EDD required, False otherwise).',
    `escalation_reason` STRING COMMENT 'Detailed reason for escalating this review to Enhanced Due Diligence or senior management, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC review event record was last modified or updated.',
    `new_risk_rating` STRING COMMENT 'The customer risk rating assigned as a result of this review event.. Valid values are `low|medium|high|very_high|prohibited`',
    `next_review_due_date` DATE COMMENT 'The scheduled date for the next periodic KYC review, calculated based on the new risk rating and regulatory requirements.',
    `pep_status` STRING COMMENT 'Politically Exposed Person status determined or confirmed during this review.. Valid values are `not_pep|domestic_pep|foreign_pep|international_organization_pep|pep_associate`',
    `prior_risk_rating` STRING COMMENT 'The customer risk rating assigned before this review event, used to track risk rating changes over time.. Valid values are `low|medium|high|very_high|prohibited`',
    `regulatory_mandate_reference` STRING COMMENT 'Reference number or citation of the regulatory mandate or examination request that triggered this review, if applicable.',
    `relationship_exit_date` DATE COMMENT 'The date on which the customer relationship was exited or terminated as a result of this review, if applicable. Null if relationship continues.',
    `relationship_exit_reason` STRING COMMENT 'Detailed reason for exiting the customer relationship, if applicable.',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYC review process was completed.',
    `review_date` DATE COMMENT 'The date on which the KYC review was conducted or completed.',
    `review_frequency_months` STRING COMMENT 'The number of months until the next scheduled review, determined by the customer risk rating (e.g., 12 months for low risk, 6 months for high risk).',
    `review_notes` STRING COMMENT 'Free-text notes and observations recorded by the reviewer during the KYC review process.',
    `review_outcome` STRING COMMENT 'The business outcome or decision resulting from this KYC review event.. Valid values are `no_change|upgraded|downgraded|escalated_to_edd|relationship_exited|suspended`',
    `review_reference_number` STRING COMMENT 'Business-assigned unique reference number for this KYC review event, used for audit trail and regulatory reporting.',
    `review_scope` STRING COMMENT 'The scope or depth of the KYC review conducted (full comprehensive review, limited refresh, targeted investigation, or expedited review).. Valid values are `full|limited|targeted|expedited`',
    `review_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYC review process was initiated.',
    `review_status` STRING COMMENT 'Current lifecycle status of the KYC review event.. Valid values are `initiated|in_progress|pending_approval|completed|escalated|cancelled`',
    `risk_rating_change_flag` BOOLEAN COMMENT 'Indicates whether the risk rating changed as a result of this review (True if changed, False if no change).',
    `sanctions_screening_result` STRING COMMENT 'Result of sanctions list screening performed during this KYC review event.. Valid values are `clear|potential_match|confirmed_match|not_performed`',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed as a result of findings during this KYC review (True if SAR filed, False otherwise).',
    `sar_reference_number` STRING COMMENT 'Reference number of the Suspicious Activity Report filed, if applicable. Null if no SAR was filed.',
    `source_of_funds_verified_flag` BOOLEAN COMMENT 'Indicates whether the source of funds was verified during this review (True if verified, False otherwise).',
    `source_of_wealth_verified_flag` BOOLEAN COMMENT 'Indicates whether the source of wealth was verified during this review (True if verified, False otherwise). Typically required for high-risk customers.',
    `system_source` STRING COMMENT 'The source system or platform from which this KYC review event record originated (e.g., NICE Actimize, Oracle Financial Crime, manual review system).',
    `trigger_reason` STRING COMMENT 'Detailed explanation of the specific reason or event that triggered this KYC review (e.g., scheduled refresh, suspicious transaction alert, adverse media hit, regulatory request).',
    CONSTRAINT pk_kyc_review_event PRIMARY KEY(`kyc_review_event_id`)
) COMMENT 'Periodic and event-driven KYC/CDD review events triggered by scheduled refresh cycles, risk-rating changes, transaction alerts, or regulatory mandates. Captures: review trigger type (periodic, risk-triggered, regulatory, client-initiated), review date, prior risk rating, new risk rating, review outcome (no change, upgraded, downgraded, escalated to EDD, relationship exited), EDD required flag, EDD completion date, reviewer employee_id, approver employee_id, and next review due date. Provides full audit trail for regulatory examination.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Consent captured via specific channels requires channel attribution for regulatory audit trails (GDPR, CCPA), consent lifecycle management, and channel-specific consent analytics. Removes denormalized',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: GDPR/privacy compliance - consent types (Marketing, Data Sharing, Profiling, Third-Party Transfer) must be standardized for regulatory audit trails, consent withdrawal processing, and privacy impact a',
    `data_subject_request_id` BIGINT COMMENT 'Reference to a formal data subject access request (DSAR), right to be forgotten request, or other privacy rights request that triggered the creation or update of this consent record. Null if not associated with a formal request.',
    `employee_id` BIGINT COMMENT 'The identifier of the bank employee who facilitated or witnessed the consent capture, if applicable. Null for self-service digital channels.',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Data privacy breaches and consent violations (GDPR fines, unauthorized data use) are operational risk events requiring linkage to specific consent records for regulatory reporting, loss attribution, a',
    `parent_consent_record_id` BIGINT COMMENT 'Reference to a prior consent record that this record supersedes or amends. Null for original consent grants. Supports consent version history and audit trail.',
    `party_id` BIGINT COMMENT 'Reference to the customer, counterparty, or legal entity who granted or withdrew the consent. Links to the party master in the Customer domain.',
    `branch_code` STRING COMMENT 'The branch or office code where the consent was captured, if obtained through a physical location. Null for digital channels.',
    `consent_audit_trail` STRING COMMENT 'Structured or semi-structured log of all state changes, amendments, and actions taken on this consent record. Supports regulatory audit and internal compliance review.',
    `consent_evidence_reference` STRING COMMENT 'Reference identifier or URI to the stored evidence of consent, such as a scanned document, recorded call, or digital audit log. Supports regulatory audit and dispute resolution.',
    `consent_expiry_date` DATE COMMENT 'The date on which the consent automatically expires and is no longer valid. Null for consents with indefinite validity subject to withdrawal.',
    `consent_granted_timestamp` TIMESTAMP COMMENT 'The date and time when the consent was originally granted by the party. Represents the principal business event timestamp for this record.',
    `consent_jurisdiction` STRING COMMENT 'The ISO 3166-1 alpha-3 country code representing the legal jurisdiction under which the consent was granted. Determines applicable privacy and data protection regulations.. Valid values are `^[A-Z]{3}$`',
    `consent_language` STRING COMMENT 'The ISO 639-2 three-letter language code in which the consent was presented and granted. Ensures compliance with multilingual disclosure requirements.. Valid values are `^[A-Z]{3}$`',
    `consent_method` STRING COMMENT 'The mechanism by which consent was obtained. Distinguishes between explicit opt-in, implicit consent, verbal agreement, or signature-based consent.. Valid values are `explicit_opt_in|implicit_opt_in|pre_checked_box|verbal|written_signature|electronic_signature`',
    `consent_notes` STRING COMMENT 'Free-text field for additional context, special instructions, or clarifications related to the consent. Used for edge cases or manual overrides documented by compliance officers.',
    `consent_purpose` STRING COMMENT 'The stated business purpose for which the consent was requested and granted. Aligns with lawful basis for processing under GDPR and business purpose disclosure under CCPA.',
    `consent_renewal_frequency_months` STRING COMMENT 'The number of months after which the consent must be renewed, if renewal is required. Null if no periodic renewal is mandated.',
    `consent_renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this consent requires periodic renewal or re-confirmation. True if the consent must be refreshed at intervals; false if it remains valid until withdrawn or expired.',
    `consent_scope` STRING COMMENT 'Free-text description of the specific scope or limitations of the consent. May include details such as specific products, data categories, or third parties covered by the consent.',
    `consent_source_system` STRING COMMENT 'The name or identifier of the operational system or application that originally captured this consent. Supports data lineage and system-of-record tracking.',
    `consent_status` STRING COMMENT 'Current lifecycle state of the consent. Indicates whether the consent is active, has been withdrawn by the party, has expired, or has been superseded by a newer version.. Valid values are `granted|withdrawn|expired|pending|revoked|superseded`',
    `consent_version` STRING COMMENT 'The version identifier of the consent policy or terms and conditions document that the party agreed to. Links to the policy version in effect at the time of consent.',
    `consent_withdrawn_timestamp` TIMESTAMP COMMENT 'The date and time when the consent was withdrawn or revoked by the party. Null if consent has not been withdrawn.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the system. Audit field for data lineage and compliance tracking.',
    `ip_address` STRING COMMENT 'The IP address from which the consent was submitted, if captured via a digital channel. Used for audit trail and fraud detection purposes.',
    `minor_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent was granted on behalf of a minor by a parent or legal guardian. True if the party is a minor; false otherwise.',
    `opt_out_processed_timestamp` TIMESTAMP COMMENT 'The date and time when the opt-out or withdrawal request was fully processed and the consent status was updated. Tracks compliance with regulatory timelines for honoring opt-out requests.',
    `opt_out_request_timestamp` TIMESTAMP COMMENT 'The date and time when the party submitted a request to opt out or withdraw consent. May differ from consent_withdrawn_timestamp if there is a processing delay.',
    `regulatory_framework` STRING COMMENT 'The primary regulatory framework or data protection law under which this consent was captured and is governed. [ENUM-REF-CANDIDATE: gdpr|ccpa|cfpb_reg_p|fatca|crs|bsa|glba|pipeda|lgpd|pdpa|appi — promote to reference product]',
    `third_party_recipient` STRING COMMENT 'The name or identifier of the third-party organization or affiliate with whom data may be shared under this consent. Null if consent does not involve third-party data sharing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was last modified. Audit field for change tracking and compliance monitoring.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Captures explicit and implicit consents granted or withdrawn by a party for data usage, marketing communications, product solicitation, and regulatory data sharing. Stores: consent type (marketing email, SMS, data sharing with affiliates, credit bureau pull, FATCA self-certification, CRS self-certification, e-statement enrollment), consent status (granted, withdrawn, expired), consent channel (web, branch, IVR, paper), consent timestamp, expiry date, consent version (linked to policy version), and IP address or branch code at time of consent. Supports GDPR, CCPA, and CFPB compliance.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_relationship` (
    `party_relationship_id` BIGINT COMMENT 'Unique identifier for the bilateral party relationship record. Primary key.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Foreign key reference to the employee or relationship manager responsible for overseeing this party relationship.',
    `party_id` BIGINT COMMENT 'Foreign key reference to the first party in the bilateral relationship. This party holds the role defined in relationship_role_a.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Relationship standardization - relationship types (Authorized Signer, Power of Attorney, Guardian, Trustee, Beneficiary) must be standardized for access control, regulatory reporting, and relationship',
    `aml_risk_rating` STRING COMMENT 'Risk rating assigned to this relationship for anti-money laundering purposes (e.g., low, medium, high, very high).. Valid values are `low|medium|high|very_high`',
    `approval_date` DATE COMMENT 'Date on which this relationship was formally approved.',
    `approval_status` STRING COMMENT 'Status of internal approval workflow for this relationship (e.g., approved, pending, rejected, under review).. Valid values are `approved|pending|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved this relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this party relationship record was first created in the system.',
    `document_type` STRING COMMENT 'Type of supporting document that establishes the relationship (e.g., guarantee agreement, power of attorney, authorization letter, trust deed, agency agreement, referral agreement).. Valid values are `guarantee_agreement|power_of_attorney|authorization_letter|trust_deed|agency_agreement|referral_agreement`',
    `effective_date` DATE COMMENT 'The date from which this party relationship becomes legally binding and operationally active.',
    `expiry_date` DATE COMMENT 'The date on which this party relationship ceases to be active. Nullable for open-ended relationships.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the relationship is currently active and operationally effective (True/False).',
    `kyc_next_review_date` DATE COMMENT 'Scheduled date for the next periodic KYC review of this relationship, as required by regulatory compliance frameworks.',
    `kyc_verification_date` DATE COMMENT 'Date on which KYC verification for this relationship was last completed or updated.',
    `kyc_verification_status` STRING COMMENT 'Status of KYC verification for this relationship, indicating whether due diligence has been completed (e.g., verified, pending, failed, expired, not required).. Valid values are `verified|pending|failed|expired|not_required`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this party relationship record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this party relationship.',
    `pep_flag` BOOLEAN COMMENT 'Boolean flag indicating whether either party in this relationship is classified as a Politically Exposed Person (PEP) requiring enhanced due diligence (True/False).',
    `relationship_limit_amount` DECIMAL(18,2) COMMENT 'Monetary limit or cap associated with this relationship (e.g., maximum guarantee amount, authorization limit, credit exposure limit).',
    `relationship_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the relationship limit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `relationship_percentage` DECIMAL(18,2) COMMENT 'Percentage value representing the extent or share of the relationship (e.g., guarantee coverage percentage, ownership percentage, authorization limit percentage). Range 0.00 to 100.00.',
    `relationship_role_a` STRING COMMENT 'The role that Party A plays in this bilateral relationship (e.g., guarantor, borrower, co-applicant, authorized signatory, power of attorney, referral source, introducer). [ENUM-REF-CANDIDATE: guarantor|borrower|co_applicant|authorized_signatory|power_of_attorney|referral_source|introducer|beneficial_owner|trustee|custodian|nominee|agent|principal|counterparty|correspondent_bank — promote to reference product]. Valid values are `guarantor|borrower|co_applicant|authorized_signatory|power_of_attorney|referral_source`',
    `relationship_role_b` STRING COMMENT 'The role that Party B plays in this bilateral relationship (e.g., guarantor, borrower, co-applicant, authorized signatory, power of attorney, referral source, introducer). [ENUM-REF-CANDIDATE: guarantor|borrower|co_applicant|authorized_signatory|power_of_attorney|referral_source|introducer|beneficial_owner|trustee|custodian|nominee|agent|principal|counterparty|correspondent_bank — promote to reference product]. Valid values are `guarantor|borrower|co_applicant|authorized_signatory|power_of_attorney|referral_source`',
    `relationship_source` STRING COMMENT 'Source or channel through which this relationship was established (e.g., direct, referral, branch, online, third party, data migration).. Valid values are `direct|referral|branch|online|third_party|migration`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the party relationship (e.g., active, inactive, suspended, pending approval, terminated, expired).. Valid values are `active|inactive|suspended|pending_approval|terminated|expired`',
    `relationship_strength` STRING COMMENT 'Indicator of the relationship importance or priority level (e.g., primary, secondary, tertiary) for credit exposure aggregation and risk assessment.. Valid values are `primary|secondary|tertiary`',
    `sanctions_screening_date` DATE COMMENT 'Date on which sanctions screening was last performed for this relationship.',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions screening for this relationship (e.g., clear, match found, pending review, not screened).. Valid values are `clear|match|pending|not_screened`',
    `source_system` STRING COMMENT 'Name or identifier of the operational system from which this relationship record originated (e.g., Core Banking System, CRM, Loan Origination System).',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to the legal or supporting documentation that establishes this relationship (e.g., guarantee agreement, power of attorney document, authorization letter).',
    `termination_date` DATE COMMENT 'The actual date on which the relationship was terminated, if applicable. May differ from expiry_date if terminated early.',
    `termination_reason` STRING COMMENT 'The reason for relationship termination (e.g., mutual agreement, breach of terms, regulatory requirement, death of party, bankruptcy, other).. Valid values are `mutual_agreement|breach|regulatory|death|bankruptcy|other`',
    CONSTRAINT pk_party_relationship PRIMARY KEY(`party_relationship_id`)
) COMMENT 'Bilateral relationship registry between two parties capturing non-hierarchical associations such as guarantor-borrower, co-applicant, authorized signatory, power of attorney, referral source, and introducer relationships. Distinct from relationship_hierarchy (which models ownership/control trees). Captures: party_a_id, party_b_id, relationship role_a, relationship role_b, effective date, expiry date, is_active flag, and supporting document reference. Enables relationship-aware credit exposure aggregation and CRM relationship mapping.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_risk_rating` (
    `party_risk_rating_id` BIGINT COMMENT 'Unique identifier for the party risk rating record.',
    `employee_id` BIGINT COMMENT 'Reference to the senior employee or credit officer who reviewed and approved the risk rating assignment.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Credit risk teams maintain internal ratings on issuer entities (sovereign, corporate, financial institutions) for portfolio credit limits, concentration risk management, regulatory capital (Basel), an',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, counterparty, or entity) being rated.',
    `primary_party_rating_analyst_employee_id` BIGINT COMMENT 'Reference to the employee who performed the risk rating analysis and assigned the rating grade.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Risk methodology governance - rating methodologies must be catalogued for model risk management, regulatory validation (SR 11-7), and methodology version control across rating systems.',
    `approval_date` DATE COMMENT 'The date on which the risk rating was formally approved by the designated authority.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this risk rating record was first created in the system.',
    `data_source` STRING COMMENT 'Identifier of the primary data source or system from which the rating inputs were obtained (e.g., Core Banking System, Risk Management Platform, External Data Provider).',
    `effective_date` DATE COMMENT 'The date from which the risk rating becomes effective and is used for risk reporting, capital calculations, and credit decisioning.',
    `expiry_date` DATE COMMENT 'The date on which the risk rating expires and must be reviewed or renewed. Nullable for ratings that remain valid until explicitly superseded.',
    `external_rating_agency` STRING COMMENT 'Name of the external credit rating agency (e.g., S&P, Moodys, Fitch) whose rating was referenced or used as input to the internal rating process. Nullable if no external rating was considered.',
    `external_rating_date` DATE COMMENT 'The date on which the external rating agency published or updated the external rating grade.',
    `external_rating_grade` STRING COMMENT 'The credit rating assigned by the external rating agency (e.g., AAA, Baa2, BB+). Used for benchmarking and validation of internal ratings.',
    `geographic_region` STRING COMMENT 'The primary geographic region or country where the party is domiciled or conducts the majority of its business. Used for country risk and geographic concentration analysis.',
    `industry_sector` STRING COMMENT 'The primary industry or economic sector in which the party operates (e.g., Financial Services, Manufacturing, Real Estate, Healthcare). Used for sector concentration risk analysis and portfolio segmentation.',
    `internal_rating_grade` STRING COMMENT 'The banks internal risk rating grade assigned to the party, expressed in the institutions proprietary rating scale (e.g., AAA, AA+, A, BBB, BB, B, CCC, D or 1-10 numeric scale). This is the primary output of the rating process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this risk rating record was most recently updated or modified.',
    `lgd_estimate` DECIMAL(18,2) COMMENT 'Estimated percentage of exposure that will be lost if the party defaults, expressed as a decimal (e.g., 0.45 = 45% loss severity). Used in conjunction with PD and EAD for ECL and capital adequacy calculations.',
    `model_score` DECIMAL(18,2) COMMENT 'Raw quantitative score output by the rating model or scorecard before mapping to the internal rating grade. Provides granular risk differentiation within rating grades.',
    `model_version` STRING COMMENT 'Version identifier of the quantitative model or scorecard used to generate the rating, enabling traceability and model governance.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of the partys risk rating, ensuring ratings remain current and reflect the partys evolving risk profile.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or qualitative factors considered in the rating process that are not captured in structured fields.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether the assigned rating was manually overridden from the system-generated or model-recommended rating. True if overridden, False otherwise.',
    `override_rationale` STRING COMMENT 'Detailed explanation and business justification for any manual override of the system-generated or model-recommended rating. Required when override_flag is True.',
    `pd_estimate` DECIMAL(18,2) COMMENT 'Quantitative estimate of the probability that the party will default within a one-year horizon, expressed as a decimal (e.g., 0.025 = 2.5%). Core input for Expected Credit Loss (ECL) and Risk-Weighted Assets (RWA) calculations.',
    `previous_rating_grade` STRING COMMENT 'The internal rating grade that was in effect immediately prior to the current rating, enabling trend analysis and rating migration tracking.',
    `rating_change_date` DATE COMMENT 'The date on which the rating was changed from the previous rating grade to the current rating grade. Nullable for initial ratings.',
    `rating_confidence_level` STRING COMMENT 'Qualitative assessment of the confidence or reliability of the assigned rating, based on data quality, model performance, and analyst judgment. High indicates strong supporting evidence, low indicates limited data or high uncertainty.. Valid values are `high|medium|low`',
    `rating_date` DATE COMMENT 'The date on which the risk rating was assigned or calculated by the rating analyst or system.',
    `rating_migration_direction` STRING COMMENT 'Indicates the direction of rating change compared to the previous rating: upgrade (improved credit quality), downgrade (deteriorated credit quality), stable (no change), or new (first-time rating).. Valid values are `upgrade|downgrade|stable|new`',
    `rating_scale` STRING COMMENT 'Identifier of the rating scale or methodology framework used (e.g., S&P_Equivalent, Moody_Equivalent, Internal_10_Point, IRB_Master_Scale). Provides context for interpreting the internal_rating_grade.',
    `rating_status` STRING COMMENT 'Current lifecycle status of the risk rating record: draft (under development), pending_approval (awaiting review), approved (validated but not yet effective), active (currently in use), expired (past expiry date), superseded (replaced by newer rating), or suspended (temporarily inactive). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|expired|superseded|suspended — 7 candidates stripped; promote to reference product]',
    `rating_type` STRING COMMENT 'The dimension of risk being assessed: credit risk (probability of default), Anti-Money Laundering (AML) risk (financial crime exposure), operational risk (process/system failure), market risk (price volatility exposure), country risk (sovereign/geopolitical), or concentration risk (portfolio exposure).. Valid values are `credit_risk|aml_risk|operational_risk|market_risk|country_risk|concentration_risk`',
    `regulatory_capital_treatment` STRING COMMENT 'The regulatory capital approach applied to exposures to this party for Risk-Weighted Assets (RWA) calculation: standardized approach, IRB foundation, IRB advanced, or exempt (e.g., sovereign exposures with zero risk weight).. Valid values are `standard|irb_foundation|irb_advanced|exempt`',
    `risk_weight_percentage` DECIMAL(18,2) COMMENT 'The risk weight percentage applied to exposures to this party for calculating Risk-Weighted Assets (RWA) under the applicable regulatory capital framework (e.g., 20%, 50%, 100%, 150%).',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this risk rating record originated (e.g., SAS Risk Management, Moodys RiskAuthority, Core Banking System).',
    `stress_test_scenario` STRING COMMENT 'Identifier of the stress testing scenario (e.g., CCAR Severely Adverse, DFAST Baseline, Internal Recession Scenario) under which this rating was assessed or projected. Nullable for baseline ratings.',
    `stressed_pd_estimate` DECIMAL(18,2) COMMENT 'Probability of Default (PD) estimate under the specified stress test scenario, reflecting the partys credit risk under adverse economic conditions. Used for stress testing and capital planning.',
    `watch_list_flag` BOOLEAN COMMENT 'Indicates whether the party is on a credit watch list or special monitoring list due to deteriorating credit quality, heightened risk, or regulatory concern. True if on watch list, False otherwise.',
    `watch_list_reason` STRING COMMENT 'Explanation of why the party was placed on the watch list, including specific risk indicators or events that triggered heightened monitoring.',
    CONSTRAINT pk_party_risk_rating PRIMARY KEY(`party_risk_rating_id`)
) COMMENT 'Point-in-time credit and AML risk rating assigned to a party, capturing the banks internal assessment of counterparty risk. Stores: party_id, rating type (AML risk, credit risk, operational risk), internal rating grade, rating scale (e.g., 1-10 or AAA-D), PD (Probability of Default) estimate, rating methodology (IRB, SA, judgmental), rating date, effective date, expiry date, rating analyst employee_id, approver employee_id, and override flag with override rationale. Distinct from kyc_record risk rating (AML-specific) — this covers all risk dimensions.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`customer_relationship_manager` (
    `customer_relationship_manager_id` BIGINT COMMENT 'Unique identifier for the customer relationship manager assignment record.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: RM role standardization - coverage roles (Primary RM, Secondary RM, Product Specialist, Credit Officer) must be standardized for revenue attribution, client coverage reporting, and compensation calcul',
    `party_id` BIGINT COMMENT 'Identifier of the client party (customer, corporate, institutional, or government entity) to whom the relationship manager is assigned.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee serving as the relationship manager or coverage banker for this client party.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Relationship managers are assigned to profit centers for revenue attribution, performance measurement, and incentive compensation calculation. Required for sales force effectiveness analysis and manag',
    `tertiary_customer_handover_to_rm_employee_id` BIGINT COMMENT 'Identifier of the new relationship manager to whom this client coverage is being handed over when the current assignment is terminated. Null if no handover is planned.',
    `approval_date` DATE COMMENT 'The date on which this relationship manager assignment was formally approved by the authorized approver.',
    `assignment_notes` STRING COMMENT 'Free-text notes providing additional context about this relationship manager assignment. May include special instructions, client preferences, or coverage considerations.',
    `assignment_priority` STRING COMMENT 'Numeric priority ranking of this assignment relative to other assignments for the same RM. Lower numbers indicate higher priority. Used for workload management and client prioritization.',
    `assignment_reason` STRING COMMENT 'The business reason for this relationship manager assignment. Captures whether this is a new client onboarding, RM transfer, segment migration, coverage model change, geographic realignment, or product specialization.. Valid values are `new_client|rm_transfer|segment_migration|coverage_model_change|geographic_realignment|product_specialization`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the relationship manager assignment. Indicates whether the assignment is active, pending approval, suspended, terminated, or expired.. Valid values are `active|pending|suspended|terminated|expired`',
    `client_aum` DECIMAL(18,2) COMMENT 'The total assets under management for this client at the time of assignment or most recent valuation. Used for RM portfolio sizing and performance benchmarking. Expressed in the banks reporting currency.',
    `client_revenue_target` DECIMAL(18,2) COMMENT 'The annual revenue target assigned to this relationship manager for this client. Used for goal setting and performance evaluation. Expressed in the banks reporting currency.',
    `client_segment` STRING COMMENT 'The client segmentation category at the time of this assignment. Used to align RM expertise with client needs and for segment-based performance reporting. [ENUM-REF-CANDIDATE: retail|mass_affluent|high_net_worth|ultra_high_net_worth|small_business|middle_market|corporate|institutional|government — 9 candidates stripped; promote to reference product]',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of client coverage responsibility allocated to this relationship manager. Used in split-coverage models where multiple RMs share client responsibility. Sum of coverage percentages across all RMs for a client should equal 100.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this relationship manager assignment record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crm_routing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether client communications and CRM workflows should be routed to this relationship manager. True for active routing, false otherwise.',
    `effective_date` DATE COMMENT 'The date from which this relationship manager assignment becomes active and the RM assumes coverage responsibility for the client.',
    `expiry_date` DATE COMMENT 'The date on which this relationship manager assignment ends. Null for open-ended assignments.',
    `geographic_coverage_region` STRING COMMENT 'The geographic region or territory for which this relationship manager has coverage responsibility. May be country, state, city, or custom-defined territory code.',
    `handover_completion_date` DATE COMMENT 'The date on which the client handover process from the current RM to the new RM was completed. Used to track transition effectiveness.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this relationship manager is the primary RM for the client. True for primary RM, false for secondary or supporting roles.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this relationship manager assignment record was most recently updated. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lob` STRING COMMENT 'The line of business under which this relationship manager assignment falls. Aligns with the banks organizational structure and product segmentation.. Valid values are `retail_banking|commercial_banking|investment_banking|wealth_management|asset_management|treasury_services`',
    `performance_attribution_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment should be included in RM performance attribution and compensation calculations. True for inclusion, false for exclusion.',
    `product_coverage_scope` STRING COMMENT 'The product or service categories that this relationship manager is authorized to cover for the client. Examples include lending, deposits, treasury, trade finance, capital markets, wealth advisory.',
    `revenue_attribution_percentage` DECIMAL(18,2) COMMENT 'The percentage of client-generated revenue attributed to this relationship manager for performance measurement and compensation purposes. May differ from coverage percentage based on contribution model.',
    `source_system` STRING COMMENT 'The name or code of the operational system from which this relationship manager assignment record originated. Examples include CRM system, core banking system, or HR system.',
    `termination_date` DATE COMMENT 'The actual date on which this relationship manager assignment was terminated. Populated when assignment status changes to terminated.',
    `termination_reason` STRING COMMENT 'Free-text explanation of why this relationship manager assignment was terminated. Examples include RM departure, client closure, segment migration, coverage model restructuring.',
    CONSTRAINT pk_customer_relationship_manager PRIMARY KEY(`customer_relationship_manager_id`)
) COMMENT 'Assignment of relationship managers (RMs) and coverage bankers to client parties, tracking the primary and secondary coverage model. Captures: party_id, rm_employee_id, coverage role (primary RM, secondary RM, product specialist, credit officer, private banker), LOB, effective date, expiry date, is_primary flag, and assignment reason (new client, RM transfer, segment migration, coverage model change). Enables CRM routing, RM performance attribution, and client coverage reporting. Distinct from hr domain employee master — this is the business coverage assignment record.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_lifecycle_event` (
    `party_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for each party lifecycle event record. Primary key for the party lifecycle event audit log.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the employee serving as the relationship manager or account officer for this party at the time of the lifecycle event. Used for accountability and follow-up tracking.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Event type standardization - lifecycle event types (Account Opening, Status Change, Closure, Merger, Deduplication) must be catalogued for audit trails, regulatory reporting, and lifecycle analytics.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Lifecycle events (death, bankruptcy, legal incapacity, account closure) trigger portfolio-specific actions: freeze trading, liquidate positions, transfer to estate. Direct linkage enables automated wo',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, counterparty, or entity) whose lifecycle state changed. Links to the party master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who initiated or requested the lifecycle status change. May be null for system-triggered events such as automated dormancy detection.',
    `reversed_event_party_lifecycle_event_id` BIGINT COMMENT 'For reversal events, this field references the party_lifecycle_event_id of the original event being reversed. Null for non-reversal events.',
    `aml_review_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event triggers a mandatory AML review or enhanced due diligence. True for high-risk transitions such as reactivation after dormancy, relationship exit, or merger events.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the lifecycle status change was formally approved. Null if no approval was required. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `branch_code` STRING COMMENT 'The branch or office code where the party relationship is managed or where the lifecycle event was processed. Null for centrally managed or digital-only relationships.',
    `business_unit` STRING COMMENT 'The business unit, division, or line of business (LOB) responsible for the party relationship at the time of the lifecycle event. Examples: Retail Banking, Corporate Banking, Wealth Management, Investment Banking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lifecycle event record was first created in the data platform. This is the technical record creation time, distinct from event_timestamp which captures the business event time. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated data quality score (0.00 to 100.00) assigned to this lifecycle event record based on completeness, consistency, and validation rule compliance. Used for data governance and audit trail quality assessment.',
    `dedup_confidence_score` DECIMAL(18,2) COMMENT 'For deduplication events, this field captures the algorithmic confidence score (0.00 to 100.00) that the two party records represent the same real-world entity. Higher scores indicate stronger match confidence. Null for non-dedup events.',
    `document_type` STRING COMMENT 'Classification of the supporting document referenced. Examples: death_certificate, closure_request, regulatory_notice, dedup_report, customer_letter, court_order.',
    `effective_date` DATE COMMENT 'The business-effective date when the new status became valid. May differ from event_timestamp if the status change was backdated or scheduled for future activation. Format: yyyy-MM-dd.',
    `event_notes` STRING COMMENT 'Free-form notes or comments recorded by the initiating or approving employee at the time of the event. Captures operational context, special instructions, or regulatory observations relevant to the lifecycle transition.',
    `event_reason_code` STRING COMMENT 'Standardized code representing the business reason for the lifecycle transition. Examples: CUST_REQUEST (customer-initiated closure), INACTIVITY (dormancy due to no transactions), REGULATORY (compliance-driven suspension), DEATH_CERT (deceased status based on death certificate), DUPLICATE (deduplication event). Links to internal reason code reference table.',
    `event_reason_description` STRING COMMENT 'Free-text explanation or additional context describing why the lifecycle status change occurred. Supplements the event_reason_code with narrative detail.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the lifecycle state transition occurred in the business system. This is the business event time, not the record creation time. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `jurisdiction_code` STRING COMMENT 'The regulatory jurisdiction or country code governing the party relationship at the time of the lifecycle event. Uses ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU).',
    `kyc_refresh_triggered_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event automatically triggered a KYC refresh or re-verification process. True for events such as reactivation, status upgrade, or significant relationship changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this lifecycle event record was most recently updated in the data platform. Used for change tracking and audit trail purposes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `new_status` STRING COMMENT 'The party lifecycle status after this event was applied. Captures the to-state in the state transition for audit trail purposes. [ENUM-REF-CANDIDATE: prospect|pending|active|dormant|suspended|inactive|closed|deceased|merged — 9 candidates stripped; promote to reference product]',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the party or stakeholders of the lifecycle event. Values: email, sms, postal_mail, in_app (mobile/web app notification), phone_call, none (no notification sent).. Valid values are `email|sms|postal_mail|in_app|phone_call|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated notification (email, SMS, letter) was sent to the party or relationship manager informing them of the lifecycle status change.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the notification was sent to the party or stakeholders. Null if no notification was sent. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `prior_status` STRING COMMENT 'The party lifecycle status immediately before this event occurred. Captures the from-state in the state transition for audit trail purposes. [ENUM-REF-CANDIDATE: prospect|pending|active|dormant|suspended|inactive|closed|deceased|merged — 9 candidates stripped; promote to reference product]',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event must be included in regulatory reporting submissions. True for events that trigger reporting obligations under Bank Secrecy Act (BSA), Anti-Money Laundering (AML), Know Your Customer (KYC), or other compliance frameworks.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event record represents a reversal or correction of a prior event. True if the event was reversed due to error or operational correction.',
    `source_system` STRING COMMENT 'The name or identifier of the operational system of record that originally captured this lifecycle event. Examples: Temenos T24, FIS Profile, Salesforce CRM, Custom Onboarding Portal.',
    `source_system_event_reference` STRING COMMENT 'The unique identifier or transaction ID assigned to this lifecycle event in the source system. Used for traceability and reconciliation back to the operational system.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation for the lifecycle event. Examples: death certificate ID, customer closure request ticket number, regulatory notice reference, deduplication analysis report ID.',
    `triggering_system` STRING COMMENT 'The source system or application that initiated or recorded the lifecycle event. Examples: Core Banking System, CRM, KYC Platform, Batch Job, Manual Entry.',
    CONSTRAINT pk_party_lifecycle_event PRIMARY KEY(`party_lifecycle_event_id`)
) COMMENT 'Audit log of significant lifecycle state transitions for a party record, capturing every status change from prospect through closure. Records: party_id, prior status, new status, event type (onboarded, activated, dormancy flagged, reactivated, relationship exited, deceased, merged, deduped), event timestamp, triggering system, initiating employee_id, approval employee_id, and event notes. Provides the full lifecycle audit trail required for regulatory examination and data governance. Distinct from kyc_review_event (KYC-specific) — this covers all party lifecycle transitions.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`fatca_crs_classification` (
    `fatca_crs_classification_id` BIGINT COMMENT 'Unique identifier for the FATCA and CRS tax classification record.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who approved this FATCA/CRS classification after review.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: FATCA compliance - classification codes (US Person, Passive NFFE, Active NFFE, FFI) must use IRS-standard codes for Form 1099/8966 reporting and withholding calculations.',
    `party_id` BIGINT COMMENT 'Foreign key reference to the party (customer, counterparty, or entity) for whom this FATCA/CRS classification applies.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: FATCA and CRS reporting obligations are legal-entity-specific; each classification must identify which bank legal entity has the reporting obligation to IRS or foreign tax authorities. Required for re',
    `reviewer_employee_id` BIGINT COMMENT 'Foreign key reference to the employee who last reviewed and validated this FATCA/CRS classification.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: FATCA/CRS compliance - tax residence country must be validated for automatic exchange of information (AEOI) reporting, withholding calculations, and treaty benefit determination.',
    `chapter_4_status` STRING COMMENT 'The detailed Chapter 4 (FATCA) status code assigned to the party by the financial institution. This is a more granular classification than the basic FATCA classification code and aligns with IRS reporting requirements. Examples include specific FFI types, exempt beneficial owner categories, and NFFE subcategories.',
    `classification_status` STRING COMMENT 'Current status of this FATCA/CRS classification record. Active indicates the classification is current and valid; Pending Review indicates documentation is under review; Expired indicates the certification has expired; Superseded indicates a newer classification exists; Invalid indicates the classification was determined to be incorrect.. Valid values are `ACTIVE|PENDING_REVIEW|EXPIRED|SUPERSEDED|INVALID`',
    `controlling_person_flag` BOOLEAN COMMENT 'Indicates whether this classification record pertains to a controlling person of a passive NFE (Non-Financial Entity) under CRS. Controlling persons of passive NFEs must be identified and reported.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this FATCA/CRS classification record was first created in the system.',
    `crs_reportable_jurisdiction_list` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing jurisdictions to which this partys financial account information must be reported under CRS. Empty if not reportable.',
    `cure_period_end_date` DATE COMMENT 'The date on which the cure period expires. Typically 90 days from the cure period start date.',
    `cure_period_start_date` DATE COMMENT 'The date on which the cure period began for resolving US indicia or documentation deficiencies. Typically triggered when indicia are detected.',
    `cure_period_status` STRING COMMENT 'Status of the cure period for resolving US indicia or documentation deficiencies. Cure Pending indicates the party is within the 90-day cure period; Cure Completed indicates documentation was provided; Cure Expired indicates the cure period lapsed without resolution.. Valid values are `NOT_APPLICABLE|CURE_PENDING|CURE_COMPLETED|CURE_EXPIRED`',
    `documentation_complete_flag` BOOLEAN COMMENT 'Indicates whether all required FATCA/CRS documentation has been collected and validated for this party. True if documentation is complete and valid.',
    `documentation_reference` STRING COMMENT 'Reference identifier or file path to the stored self-certification forms and supporting documentation for this FATCA/CRS classification.',
    `entity_type` STRING COMMENT 'The legal entity type of the party for FATCA/CRS classification purposes. Determines applicable reporting rules and documentation requirements. [ENUM-REF-CANDIDATE: INDIVIDUAL|CORPORATION|PARTNERSHIP|TRUST|ESTATE|GOVERNMENT|INTERNATIONAL_ORG|OTHER — 8 candidates stripped; promote to reference product]',
    `fatca_giin` STRING COMMENT 'The Global Intermediary Identification Number assigned to the party if it is a Foreign Financial Institution (FFI) registered with the IRS for FATCA compliance. Format: 6 alphanumeric characters, dot, 5 alphanumeric characters, dot, 2-letter entity type, dot, 3-digit branch code.. Valid values are `^[A-Z0-9]{6}.[A-Z0-9]{5}.(LE|SL|ME|BR).[0-9]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this FATCA/CRS classification record was last modified or updated.',
    `last_review_date` DATE COMMENT 'The date on which this FATCA/CRS classification was last reviewed by compliance personnel.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this FATCA/CRS classification. Typically aligned with KYC refresh cycles or certification expiry dates.',
    `reason_no_tin` STRING COMMENT 'The reason why a Tax Identification Number (TIN) was not provided by the party. Not Required indicates the jurisdiction does not issue TINs; Not Issued indicates the party has not been issued a TIN; Applied For indicates the party has applied but not yet received a TIN; Other requires explanation.. Valid values are `NOT_REQUIRED|NOT_ISSUED|APPLIED_FOR|OTHER`',
    `recalcitrant_account_holder_flag` BOOLEAN COMMENT 'Indicates whether the party is classified as a recalcitrant account holder under FATCA due to failure to provide required documentation or information. Recalcitrant account holders are subject to 30% withholding.',
    `reporting_obligation_flag` BOOLEAN COMMENT 'Indicates whether the financial institution has a reporting obligation for this party under FATCA or CRS. True if the party is reportable to IRS or foreign tax authorities.',
    `secondary_tax_residence_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing a secondary country of tax residence for the party, if applicable. Some individuals or entities may have dual tax residency.. Valid values are `^[A-Z]{3}$`',
    `self_certification_date` DATE COMMENT 'The date on which the party completed and submitted the self-certification form.',
    `self_certification_expiry_date` DATE COMMENT 'The date on which the current self-certification expires and requires renewal. Typically 3 years from certification date or upon change in circumstances.',
    `self_certification_form_type` STRING COMMENT 'The type of tax self-certification form provided by the party. W-9 for US persons; W-8 series for non-US persons claiming treaty benefits or exemptions; CRS Self-Certification for CRS reportable persons; Entity Self-Certification for entities. [ENUM-REF-CANDIDATE: W-9|W-8BEN|W-8BEN-E|W-8ECI|W-8EXP|W-8IMY|CRS_SELF_CERT|ENTITY_SELF_CERT|NOT_PROVIDED — 9 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this FATCA/CRS classification record originated. Typically the Regulatory Reporting Platform (e.g., AxiomSL, Wolters Kluwer OneSumX).',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the party in their country of tax residence. For US persons, this is typically a Social Security Number (SSN) or Employer Identification Number (EIN). For non-US persons, this is the foreign TIN.',
    `us_indicia_address_flag` BOOLEAN COMMENT 'Indicates whether the party has a US address on file, which is an indicium of US person status under FATCA.',
    `us_indicia_birthplace_flag` BOOLEAN COMMENT 'Indicates whether the party has a US place of birth recorded, which is an indicium of US person status under FATCA.',
    `us_indicia_in_care_of_flag` BOOLEAN COMMENT 'Indicates whether the party has an in-care-of address or hold mail instruction that is the sole address on file, which is an indicium requiring further documentation under FATCA.',
    `us_indicia_phone_flag` BOOLEAN COMMENT 'Indicates whether the party has a US telephone number on file, which is an indicium of US person status under FATCA.',
    `us_indicia_power_of_attorney_flag` BOOLEAN COMMENT 'Indicates whether the party has granted power of attorney or signatory authority to a person with a US address, which is an indicium of US person status under FATCA.',
    `us_indicia_standing_instruction_flag` BOOLEAN COMMENT 'Indicates whether the party has standing instructions to transfer funds to a US address, which is an indicium of US person status under FATCA.',
    `withholding_rate_percent` DECIMAL(18,2) COMMENT 'The applicable FATCA withholding tax rate (as a percentage) for this party. Typically 30% for recalcitrant account holders or non-participating FFIs, 0% for compliant parties.',
    CONSTRAINT pk_fatca_crs_classification PRIMARY KEY(`fatca_crs_classification_id`)
) COMMENT 'FATCA and CRS tax classification record for each party, supporting automatic exchange of financial account information with tax authorities. Captures: party_id, FATCA entity classification (US Person, Specified US Person, NFFE, FFI, Exempt Beneficial Owner), CRS reportable jurisdiction list, self-certification form type (W-9, W-8BEN, W-8BEN-E, CRS Self-Cert), self-certification date, self-certification expiry, indicia detected flags (US address, US phone, US birthplace, US standing instruction), cure period status, and reporting obligation flag. Sourced from Regulatory Reporting Platform (AxiomSL / Wolters Kluwer OneSumX).';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`party_identifier` (
    `party_identifier_id` BIGINT COMMENT 'Unique identifier for the party identifier record. Primary key for this entity.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Identifier type standardization - identifier types (CIF, Account Number, Tax ID, SSN, Passport) must be consistent across systems for deduplication, regulatory reporting, and customer matching.',
    `party_id` BIGINT COMMENT 'Reference to the party (customer, counterparty, or entity) to whom this identifier belongs. Links to the party master record.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this identifier. Aligns with enterprise data classification policy and determines who can view or use the identifier.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this identifier record was first created in the system. Supports audit trail requirements and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deduplication_key` STRING COMMENT 'Normalized or hashed representation of the identifier value used for deduplication and matching across systems. Supports golden record management and cross-system reconciliation by providing a standardized matching key that accounts for formatting variations.',
    `effective_date` DATE COMMENT 'The date from which the identifier becomes valid and can be used for business operations, regulatory reporting, and cross-system reconciliation. Supports temporal validity tracking for audit and compliance purposes.',
    `expiry_date` DATE COMMENT 'The date on which the identifier ceases to be valid. Nullable for identifiers that do not have a predetermined expiration (e.g., permanent tax IDs). Critical for Know Your Customer (KYC) and Anti-Money Laundering (AML) compliance to ensure identifiers are current.',
    `identifier_status` STRING COMMENT 'Current lifecycle status of the identifier. Indicates whether the identifier is currently valid and usable for business operations, regulatory reporting, and cross-system reconciliation.. Valid values are `active|inactive|expired|suspended|pending|revoked`',
    `identifier_value` DECIMAL(18,2) COMMENT 'The actual identifier value or number assigned to the party. This is the unique alphanumeric string that represents the party in the external or internal system (e.g., the 20-character LEI code, the 8 or 11-character SWIFT BIC, the 9-digit DUNS number, the CIF account number, the tax identification number, passport number, or national ID number).',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is the primary or preferred identifier of its type for the party. Used in golden record management and master data management (MDM) processes to determine the authoritative identifier for cross-domain foreign key resolution.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the identifier has been verified against the issuing authority or an authoritative source. Critical for KYC/AML compliance and data quality assurance.',
    `issuing_authority` STRING COMMENT 'The organization, government agency, or regulatory body that issued or assigned the identifier. Examples include Global Legal Entity Identifier Foundation (GLEIF) for LEI, SWIFT for BIC, Dun & Bradstreet for DUNS, Internal Revenue Service (IRS) for Tax ID, passport issuing country government, or internal bank system name for legacy identifiers.',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country or jurisdiction where the identifier was issued. Used for regulatory reporting and jurisdiction-based risk assessment.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this identifier record was last updated or modified. Supports audit trail requirements, change tracking, and data quality monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_updated_by` STRING COMMENT 'The user ID, employee ID, or system process name that last modified this identifier record. Supports audit trail requirements and accountability for data changes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or special instructions related to the identifier. May include information about data quality issues, verification challenges, or special handling requirements.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority or preference order of this identifier among multiple identifiers of the same type for the party. Lower numbers indicate higher priority. Used in golden record management and cross-system reconciliation when multiple identifiers of the same type exist.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is required for regulatory reporting purposes. Examples include LEI for derivatives reporting under Dodd-Frank Act and European Market Infrastructure Regulation (EMIR), Tax ID for FATCA/CRS reporting, or SWIFT BIC for cross-border payment reporting.',
    `source_system` STRING COMMENT 'The name or code of the operational system from which this identifier record originated. Examples include Core Banking System (e.g., Temenos T24, FIS Profile), Customer Relationship Management (CRM) system, Loan Origination System (LOS), Trading System (e.g., Murex, Calypso), or external data provider. Supports data lineage tracking and cross-system reconciliation.',
    `source_system_identifier` STRING COMMENT 'The unique identifier or primary key of this record in the source operational system. Used for traceability, reconciliation, and troubleshooting data quality issues back to the originating system.',
    `usage_context` STRING COMMENT 'Description of the business context or purpose for which this identifier is used. Examples include regulatory reporting (e.g., Common Reporting Standard (CRS), Foreign Account Tax Compliance Act (FATCA)), cross-border payments (SWIFT messaging), credit reporting (DUNS), internal customer relationship management (CRM) system integration, or trade finance documentation.',
    `verification_date` DATE COMMENT 'The date on which the identifier was last verified against the issuing authority or authoritative source. Used to track the recency of verification for KYC/AML compliance and data quality monitoring.',
    `verification_method` STRING COMMENT 'The method or process used to verify the identifier. Examples include manual review by operations staff, automated validation via application programming interface (API) lookup against issuing authority database, third-party verification service, self-attestation by customer, or document review (e.g., scanning passport or tax document).. Valid values are `manual|automated|third_party|self_attested|document_review|api_lookup`',
    `verification_source` STRING COMMENT 'The name of the system, service, or authority used to verify the identifier. Examples include GLEIF API for LEI verification, SWIFT directory for BIC verification, Dun & Bradstreet API for DUNS verification, government registry for national ID or passport verification, or internal compliance system name.',
    CONSTRAINT pk_party_identifier PRIMARY KEY(`party_identifier_id`)
) COMMENT 'Registry of all external and internal identifiers associated with a party, enabling cross-system reconciliation and deduplication. Captures: party_id, identifier type (LEI, SWIFT BIC, DUNS, CIF number, tax ID, passport number, national ID, ISIN issuer code, Bloomberg BUID, Reuters PERM ID, internal legacy system ID), identifier value, issuing authority, effective date, expiry date, and is_primary flag per type. Supports golden record management, cross-domain FK resolution, and regulatory reporting identifier requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`risk_rating` (
    `risk_rating_id` BIGINT COMMENT 'Unique identifier for the customer risk rating record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the senior compliance officer or Money Laundering Reporting Officer (MLRO) who approved the risk rating.',
    `party_id` BIGINT COMMENT 'Reference to the customer, counterparty, or beneficial owner being risk-rated. Links to the party master record.',
    `primary_risk_override_approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the senior compliance officer or Money Laundering Reporting Officer (MLRO) who approved the manual override.',
    `risk_analyst_employee_id` BIGINT COMMENT 'Employee identifier of the compliance analyst who performed the risk rating assessment and analysis.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Risk tier standardization - risk tiers (Low, Medium, High, Prohibited) must use enterprise-standard codes for portfolio reporting, transaction monitoring intensity, and regulatory submissions.',
    `adverse_information_risk_score` DECIMAL(18,2) COMMENT 'Risk score component based on adverse media findings, sanctions screening hits, Politically Exposed Person (PEP) status, and negative news. Scale 0-100.',
    `adverse_media_flag` BOOLEAN COMMENT 'Flag indicating whether adverse media findings (negative news related to financial crime, corruption, fraud, or reputational risk) were identified for this customer.',
    `adverse_media_summary` STRING COMMENT 'Summary of adverse media findings identified during screening, including source, date, and nature of the negative news.',
    `approval_date` DATE COMMENT 'Date on which the risk rating was formally approved by the authorized compliance officer.',
    `cdd_tier_required` STRING COMMENT 'Level of Customer Due Diligence (CDD) required based on the assigned risk tier: simplified for low-risk, standard for medium-risk, enhanced for high-risk and very-high-risk customers.. Valid values are `simplified|standard|enhanced`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk rating record was first created in the system. Immutable audit field.',
    `customer_type_risk_score` DECIMAL(18,2) COMMENT 'Risk score component based on customer type classification (individual, corporate, Politically Exposed Person (PEP), non-profit, money services business). Scale 0-100.',
    `edd_required_flag` BOOLEAN COMMENT 'Flag indicating whether Enhanced Due Diligence (EDD) procedures are required for this customer based on their risk tier and profile.',
    `effective_date` DATE COMMENT 'Date from which this risk rating becomes effective and drives transaction monitoring rule intensity and Know Your Customer (KYC) review frequency.',
    `expiry_date` DATE COMMENT 'Date on which this risk rating expires and must be refreshed. Null for ratings with indefinite validity subject to trigger-based review.',
    `geographic_risk_score` DECIMAL(18,2) COMMENT 'Risk score component based on customer domicile, transaction jurisdictions, and exposure to high-risk or sanctioned countries per Financial Action Task Force (FATF) and Office of Foreign Assets Control (OFAC) lists. Scale 0-100.',
    `kyc_review_frequency_months` STRING COMMENT 'Frequency in months for mandatory Know Your Customer (KYC) refresh reviews. Typically 12 months for low-risk, 6 months for medium-risk, 3 months for high-risk customers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk rating record was last modified or updated. Updated on every change for audit trail purposes.',
    `model_version` STRING COMMENT 'Version identifier of the risk rating model or rule set used to calculate this rating. Critical for model governance and audit trail.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory risk rating review. Frequency is determined by risk tier: low-risk annually, high-risk quarterly or more frequently.',
    `notes` STRING COMMENT 'Additional free-text notes and observations recorded by the compliance analyst during the risk rating assessment process.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated from weighted combination of all contributing risk factor scores. This score drives the risk tier assignment. Scale 0-100.',
    `override_approval_date` DATE COMMENT 'Date on which the manual override was formally approved by the authorized compliance officer.',
    `override_indicator` BOOLEAN COMMENT 'Flag indicating whether the risk tier was manually overridden by a compliance officer, deviating from the model-recommended rating.',
    `override_justification` STRING COMMENT 'Detailed justification narrative for any manual override of the model-recommended risk tier. Required when override_indicator is true.',
    `pep_status` STRING COMMENT 'Politically Exposed Person (PEP) classification status of the customer. PEP status is a key driver of elevated risk ratings and Enhanced Due Diligence (EDD) requirements.. Valid values are `not_pep|domestic_pep|foreign_pep|international_organization_pep|pep_family_member|pep_close_associate`',
    `prior_risk_tier` STRING COMMENT 'Previous risk tier assigned to this customer before the current rating. Used to track risk rating migration and escalation trends.. Valid values are `low|medium|high|very_high|prohibited`',
    `product_service_risk_score` DECIMAL(18,2) COMMENT 'Risk score component based on the products and services used by the customer (e.g., private banking, correspondent banking, wire transfers, trade finance). Scale 0-100.',
    `rating_date` DATE COMMENT 'Date on which the risk rating assessment was performed and the rating was assigned.',
    `rating_methodology` STRING COMMENT 'Methodology used to derive the risk rating: rule-based scoring, quantitative model, hybrid approach, or manual override by compliance officer.. Valid values are `rule_based|model_based|hybrid|manual_override`',
    `rating_rationale` STRING COMMENT 'Detailed narrative explanation of the rationale for the assigned risk tier, including key risk factors, mitigating controls, and compliance officer judgment.',
    `rating_reference_number` STRING COMMENT 'Business-facing unique reference number for this risk rating assessment, used for audit trails and regulatory reporting.',
    `rating_status` STRING COMMENT 'Current lifecycle status of the risk rating record. Active ratings drive operational controls; expired ratings trigger mandatory refresh.. Valid values are `active|pending_review|expired|superseded|rejected`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Flag indicating whether this risk rating triggers mandatory regulatory reporting obligations, such as Suspicious Activity Report (SAR) filing or Currency Transaction Report (CTR) filing.',
    `relationship_exit_consideration_flag` BOOLEAN COMMENT 'Flag indicating whether the risk profile is severe enough to warrant consideration of customer relationship termination or exit.',
    `risk_tier_change_date` DATE COMMENT 'Date on which the risk tier changed from the prior tier to the current tier. Null if this is the initial rating.',
    `risk_tier_change_reason` STRING COMMENT 'Explanation of the reason for the risk tier change, such as change in transaction behavior, new adverse information, or geographic risk escalation.',
    `sanctions_last_screened_date` DATE COMMENT 'Date of the most recent sanctions screening performed for this customer. Sanctions screening must be performed at onboarding and periodically thereafter.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions screening against Office of Foreign Assets Control (OFAC), United Nations (UN), European Union (EU), and other sanctions lists. Confirmed matches result in prohibited risk tier.. Valid values are `clear|potential_match|confirmed_match|false_positive|pending_review`',
    `sar_filing_consideration_flag` BOOLEAN COMMENT 'Flag indicating whether the risk rating assessment identified activity warranting consideration for Suspicious Activity Report (SAR) filing.',
    `source_system` STRING COMMENT 'Code identifying the source system or Anti-Money Laundering (AML) platform that generated or recorded this risk rating record.',
    `transaction_behavior_risk_score` DECIMAL(18,2) COMMENT 'Risk score component based on transaction volume, velocity, complexity, and deviation from expected activity profile. Scale 0-100.',
    `transaction_monitoring_rule_intensity` STRING COMMENT 'Intensity level for transaction monitoring rules and thresholds applied to this customer. Higher risk tiers trigger more sensitive detection rules and lower alert thresholds.. Valid values are `low|medium|high|very_high`',
    CONSTRAINT pk_risk_rating PRIMARY KEY(`risk_rating_id`)
) COMMENT 'AML/BSA customer risk rating assigned to a customer, counterparty, or beneficial owner based on their composite risk profile encompassing customer type, product/service usage, geographic risk (country, jurisdiction), transaction behavior, and adverse information. Captures risk tier (low/medium/high/very-high/prohibited), rating methodology (rule-based, model-based, hybrid), effective date, next scheduled review date, rating rationale narrative, contributing risk factor scores, override indicator, override justification, and approving officer. Drives CDD/EDD requirements, transaction monitoring rule intensity, and KYC review frequency. Distinct from credit risk ratings (risk domain) and fraud risk scores (fraud domain).';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`beneficial_owner` (
    `beneficial_owner_id` BIGINT COMMENT 'Primary key for beneficial_owner',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: beneficial_owner is currently a SILOED table with no FK relationships. Every beneficial owner is a person or legal entity that should exist in the party golden master. Adding party_id FK links benefic',
    CONSTRAINT pk_beneficial_owner PRIMARY KEY(`beneficial_owner_id`)
) COMMENT 'Beneficial ownership record for legal entity customers, capturing individuals who own or control 25% or more of the entity or exercise significant management control, as required by FinCENs Customer Due Diligence (CDD) Rule and the Corporate Transparency Act (CTA). Captures owner name, ownership percentage, control type (ownership, management, other significant control), identification document details, certification date, verification status, and CTA reporting status. Supports FinCEN CDD Rule compliance, Corporate Transparency Act beneficial ownership reporting, and sanctions screening of beneficial owners.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Unique identifier for the customer complaint record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the supervisor or manager who approved the complaint resolution and closure.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Complaint management - complaint categories must be standardized for regulatory reporting (CFPB, FCA, ASIC), root cause analysis, and product/service quality improvement initiatives.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Foreign key linking to channel.relationship_manager. Business justification: RM-managed client complaints require RM assignment for accountability tracking, resolution ownership, and relationship management performance metrics. Critical for private banking and wealth managemen',
    `complaint_assigned_handler_employee_id` BIGINT COMMENT 'Employee identifier of the staff member assigned to investigate and resolve the complaint.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the specific account associated with the complaint, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Complaint handling costs are tracked by cost center for operational risk measurement, service quality cost analysis, and non-interest expense allocation. Required for operational efficiency metrics an',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Portfolio-specific complaints (performance disputes, unauthorized trades, fee billing errors) require direct portfolio linkage for root cause analysis, MiFID II complaint reporting, remediation tracki',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Customer complaints triggering operational risk events (service failures, regulatory breaches, litigation) require linkage for Basel operational risk reporting, root cause analysis, and loss attributi',
    `party_id` BIGINT COMMENT 'Reference to the customer or counterparty who filed the complaint.',
    `account_transaction_id` BIGINT COMMENT 'Reference to the specific transaction that is the subject of the complaint, if applicable.',
    `related_complaint_id` BIGINT COMMENT 'Self-referencing FK on complaint (related_complaint_id)',
    `approval_date` DATE COMMENT 'Date when the complaint resolution was formally approved by the designated authority.',
    `branch_code` STRING COMMENT 'Code identifying the branch location where the complaint was received or the product/service is held.',
    `channel` STRING COMMENT 'Channel through which the complaint was received (branch, digital, phone, written correspondence). [ENUM-REF-CANDIDATE: branch|phone|email|web|mobile_app|written_letter|social_media|atm|relationship_manager — 9 candidates stripped; promote to reference product]',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation or reimbursement amount provided to the customer as part of the complaint resolution.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount.. Valid values are `^[A-Z]{3}$`',
    `complaint_date` DATE COMMENT 'Date when the complaint was formally received and logged by the institution.',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint in the resolution workflow. [ENUM-REF-CANDIDATE: open|investigating|pending_customer_response|resolved|closed|escalated_to_regulator|withdrawn — 7 candidates stripped; promote to reference product]',
    `complaint_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the complaint was received and entered into the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was first created in the system.',
    `customer_feedback` STRING COMMENT 'Free-text feedback provided by the customer regarding the complaint handling and resolution experience.',
    `customer_satisfaction_rating` STRING COMMENT 'Post-resolution customer satisfaction score provided by the complainant, typically on a scale of 1 to 5 or 1 to 10.',
    `escalation_level` STRING COMMENT 'Current escalation tier within the complaint resolution hierarchy.. Valid values are `level_1|level_2|level_3|executive|regulatory`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was last updated or modified.',
    `lob` STRING COMMENT 'Line of Business (LOB) responsible for the product or service that is the subject of the complaint.. Valid values are `retail_banking|commercial_banking|investment_banking|wealth_management|treasury|capital_markets`',
    `notes` STRING COMMENT 'Internal notes and comments recorded by complaint handlers during investigation and resolution process.',
    `product_service_complained` STRING COMMENT 'The specific banking product or service that is the subject of the complaint (e.g., checking account, credit card, mortgage, wire transfer).',
    `reference_number` STRING COMMENT 'Externally visible unique reference number assigned to the complaint for tracking and customer communication purposes.',
    `regulatory_body` STRING COMMENT 'The specific regulatory authority to which the complaint has been or must be reported. [ENUM-REF-CANDIDATE: CFPB|FCA|ASIC|OCC|FDIC|SEC|FINRA|EBA|PRA — 9 candidates stripped; promote to reference product]',
    `regulatory_reference_number` STRING COMMENT 'Reference number assigned by the regulatory authority for tracking the reported complaint.',
    `regulatory_report_date` DATE COMMENT 'Date when the complaint was formally reported to the regulatory authority.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicator whether this complaint must be reported to regulatory authorities such as Consumer Financial Protection Bureau (CFPB), Financial Conduct Authority (FCA), or Australian Securities and Investments Commission (ASIC).',
    `resolution_date` DATE COMMENT 'Date when the complaint was formally resolved and closed.',
    `resolution_description` STRING COMMENT 'Detailed narrative describing the actions taken to resolve the complaint and the outcome provided to the customer.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the complaint resolution was completed and recorded.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the underlying root cause of the complaint for trend analysis and process improvement.',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause identified during complaint investigation.',
    `severity_level` STRING COMMENT 'Assessed severity or priority level of the complaint based on impact, regulatory risk, and customer harm.. Valid values are `low|medium|high|critical`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator whether the complaint resolution exceeded the Service Level Agreement (SLA) target timeframe.',
    `sla_target_resolution_date` DATE COMMENT 'Target date by which the complaint must be resolved according to internal Service Level Agreement (SLA) commitments or regulatory requirements.',
    `source_system` STRING COMMENT 'Identifier of the operational system from which the complaint record originated (e.g., Customer Relationship Management (CRM), Core Banking System, Contact Center Platform).',
    `subcategory` STRING COMMENT 'Detailed subcategory providing granular classification of the complaint issue.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Customer complaint and grievance record tracking formal and informal complaints received across all channels (branch, digital, phone, written). Captures: party_id, complaint date, channel, product/service complained about, complaint category (service quality, fee dispute, unauthorized transaction, privacy breach, discrimination), severity, assigned handler employee_id, escalation level, resolution status (open, investigating, resolved, escalated to regulator), resolution date, resolution description, compensation amount, root cause code, and regulatory reporting flag (CFPB, FCA, ASIC). Supports regulatory complaint reporting obligations, SLA monitoring, and root cause analysis for service improvement.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the prospect record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the relationship manager or sales representative assigned to cultivate and convert this prospect.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Lead qualification - prospect country drives regulatory feasibility assessment, sanctions screening, market entry evaluation, and sales territory assignment. Core sales and compliance process.',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the specific marketing campaign or initiative that generated this prospect lead for attribution and ROI (Return on Investment) tracking.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Marketing attribution - lead sources (Referral, Campaign, Walk-in, Digital, Partner) must be standardized for marketing ROI analysis, channel effectiveness measurement, and customer acquisition cost t',
    `party_id` BIGINT COMMENT 'Party identifier assigned to the prospect upon successful conversion to customer status linking the prospect record to the customer master record.',
    `prospect_referral_source_party_id` BIGINT COMMENT 'Party identifier of the existing customer or partner who referred this prospect for relationship attribution and incentive tracking.',
    `source_prospect_id` BIGINT COMMENT 'Self-referencing FK on prospect (source_prospect_id)',
    `branch_code` STRING COMMENT 'Code of the branch or office location responsible for this prospect relationship.',
    `conversion_date` DATE COMMENT 'Date when the prospect was successfully converted to an active customer and onboarding was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect record was first created in the system.',
    `data_privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the prospect has provided consent for data collection and processing in accordance with privacy regulations.',
    `disqualification_date` DATE COMMENT 'Date when the prospect was formally disqualified and removed from active pursuit.',
    `disqualification_reason` STRING COMMENT 'Reason code or description explaining why the prospect was disqualified such as insufficient assets, regulatory restrictions, or lack of interest.',
    `engagement_score` STRING COMMENT 'Numerical score representing the level of prospect engagement based on interaction frequency, response rates, and expressed interest for prioritization.',
    `estimated_annual_revenue_potential` DECIMAL(18,2) COMMENT 'Projected annual revenue the bank could generate from this prospect based on expected product usage and fee income.',
    `estimated_aum` DECIMAL(18,2) COMMENT 'Estimated total assets under management that the prospect could bring to the bank if converted, used for prioritization and resource allocation.',
    `first_contact_date` DATE COMMENT 'Date of the first documented contact or interaction with the prospect.',
    `geographic_region` STRING COMMENT 'Geographic region or market where the prospect is located for territory management and regulatory compliance purposes.',
    `industry_sector` STRING COMMENT 'Industry classification of the prospect entity for corporate and institutional prospects using standard industry codes such as NAICS (North American Industry Classification System) or SIC (Standard Industrial Classification).',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact or interaction with the prospect for tracking engagement recency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the prospect record for audit trail and data freshness tracking.',
    `legal_name` STRING COMMENT 'Full legal name of the prospective individual or entity as it would appear on official documents.',
    `lifecycle_status` STRING COMMENT 'Current stage of the prospect in the sales pipeline lifecycle from initial lead capture through conversion or disqualification. [ENUM-REF-CANDIDATE: new|qualified|contacted|engaged|converted|disqualified|inactive — 7 candidates stripped; promote to reference product]',
    `lob` STRING COMMENT 'Primary line of business responsible for pursuing this prospect such as Retail Banking, Wealth Management, Investment Banking, or Commercial Lending.',
    `marketing_consent_date` DATE COMMENT 'Date when marketing consent was granted or withdrawn by the prospect.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Indicates whether the prospect has provided consent to receive marketing communications and promotional materials.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next planned follow-up activity or touchpoint with the prospect.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, observations, or special instructions related to the prospect relationship.',
    `nps_score` STRING COMMENT 'Net Promoter Score captured during prospect interactions indicating likelihood to recommend the bank to others on a scale of 0 to 10.',
    `pep_indicator_preliminary` BOOLEAN COMMENT 'Flag indicating whether initial screening suggests the prospect may be a Politically Exposed Person requiring enhanced due diligence.',
    `primary_email_address` STRING COMMENT 'Primary email address for prospect communication and digital outreach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone_number` STRING COMMENT 'Primary contact telephone number for the prospect including country and area codes.',
    `products_of_interest` STRING COMMENT 'Comma-separated list of banking products or services the prospect has expressed interest in such as checking accounts, loans, investment advisory, or trade finance.',
    `prospect_type` STRING COMMENT 'Classification of the prospect entity type indicating whether the prospect is an individual, corporation, institutional investor, government entity, partnership, or trust.. Valid values are `individual|corporate|institutional|government|partnership|trust`',
    `qualification_date` DATE COMMENT 'Date when the prospect was formally qualified or disqualified based on established criteria.',
    `qualification_status` STRING COMMENT 'Assessment of whether the prospect meets the banks criteria for target customer profile based on initial screening and discovery.. Valid values are `unqualified|qualified|highly_qualified|not_qualified`',
    `reference_number` STRING COMMENT 'Business-facing unique reference number assigned to the prospect for tracking and communication purposes.',
    `revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated revenue and AUM (Assets Under Management) amounts.. Valid values are `^[A-Z]{3}$`',
    `risk_rating_preliminary` STRING COMMENT 'Initial risk assessment of the prospect based on available information prior to full KYC (Know Your Customer) and due diligence for AML (Anti-Money Laundering) and compliance screening.. Valid values are `low|medium|high|very_high`',
    `sanctions_screening_preliminary` STRING COMMENT 'Result of initial sanctions list screening against OFAC (Office of Foreign Assets Control), UN, EU, and other watchlists prior to onboarding.. Valid values are `not_screened|clear|potential_match|confirmed_match`',
    `source_system` STRING COMMENT 'Name or code of the originating system that created or manages this prospect record such as CRM (Customer Relationship Management) platform or marketing automation system.',
    `target_customer_segment` STRING COMMENT 'Anticipated customer segment classification if the prospect is successfully onboarded such as retail mass market, affluent, high net worth, corporate SME (Small and Medium Enterprise), or institutional.',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Prospective customer record for individuals and entities in the sales pipeline who have not yet been onboarded. Captures lead source, qualification status, estimated revenue potential, and conversion tracking.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`tax_profile` (
    `tax_profile_id` BIGINT COMMENT 'Unique identifier for the customer tax profile record. Primary key.',
    `party_id` BIGINT COMMENT 'Reference to the customer or counterparty to whom this tax profile belongs. Links to the party master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who last reviewed and validated the tax profile.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Tax reporting compliance - W-8/W-9 forms require validated country of tax residence for withholding calculations, treaty benefit determination, and IRS/tax authority reporting.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Tax form standardization - W-8 form types (W-8BEN, W-8BEN-E, W-8ECI, W-8EXP, W-8IMY) must be standardized for withholding calculations, IRS reporting, and tax documentation management.',
    `previous_tax_profile_id` BIGINT COMMENT 'Self-referencing FK on tax_profile (previous_tax_profile_id)',
    `backup_withholding_flag` BOOLEAN COMMENT 'Indicates whether the customer is subject to backup withholding due to missing or incorrect TIN, underreporting of interest/dividends, or IRS notification.',
    `backup_withholding_rate_percent` DECIMAL(18,2) COMMENT 'Backup withholding tax rate percentage applicable to the customer if backup withholding is required. Typically 24% in the US.',
    `chapter_3_status_code` STRING COMMENT 'IRC Chapter 3 withholding status code indicating the customers classification for withholding purposes on US-source income (e.g., foreign individual, foreign corporation, foreign partnership). [ENUM-REF-CANDIDATE: promote to reference product if more than 6 distinct codes are used]',
    `chapter_4_status_code` STRING COMMENT 'IRC Chapter 4 (FATCA) withholding status code indicating the customers classification for FATCA purposes (e.g., Participating FFI, Certified Deemed-Compliant FFI, Passive NFFE, Active NFFE). [ENUM-REF-CANDIDATE: promote to reference product if more than 6 distinct codes are used]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax profile record was first created in the system.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the customer account is reportable under the OECD Common Reporting Standard for automatic exchange of financial account information.',
    `crs_reportable_jurisdiction_list` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing jurisdictions to which this customer account must be reported under CRS.',
    `documentation_complete_flag` BOOLEAN COMMENT 'Indicates whether all required tax documentation has been received and validated for the customer.',
    `documentation_status` STRING COMMENT 'Current status of the tax documentation on file for the customer (complete, incomplete, pending receipt, expired, or not required).. Valid values are `COMPLETE|INCOMPLETE|PENDING|EXPIRED|NOT_REQUIRED`',
    `effective_date` DATE COMMENT 'Date from which this tax profile record becomes effective and applicable for withholding and reporting purposes.',
    `expiry_date` DATE COMMENT 'Date on which this tax profile record expires or is superseded by a new version. Null if currently active.',
    `fatca_classification_code` STRING COMMENT 'FATCA classification code indicating the customer entity type and reporting obligations (e.g., Chapter 3 status codes, Chapter 4 status codes such as Owner-Documented FFI, Passive NFFE, Active NFFE). [ENUM-REF-CANDIDATE: promote to reference product if more than 6 distinct codes are used]',
    `fatca_giin` STRING COMMENT 'Global Intermediary Identification Number assigned to Foreign Financial Institutions (FFIs) that have registered with the IRS under FATCA. Format: XXXXXX.XXXXX.XX.XXX.. Valid values are `^[A-Z0-9]{6}.[A-Z0-9]{5}.[A-Z]{2}.[0-9]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax profile record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date on which the tax profile was last reviewed and validated by compliance or tax operations staff.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the tax profile to ensure continued accuracy and compliance.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the tax profile record (active, inactive, pending validation, expired, or suspended).. Valid values are `ACTIVE|INACTIVE|PENDING|EXPIRED|SUSPENDED`',
    `secondary_tax_residency_country_code` STRING COMMENT 'Secondary country of tax residency if the customer has dual tax residency status, represented as ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `secondary_tin` STRING COMMENT 'Secondary Tax Identification Number if the customer has tax obligations in multiple jurisdictions.',
    `secondary_tin_issuing_country_code` STRING COMMENT 'Country that issued the secondary Tax Identification Number, represented as ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `self_certification_date` DATE COMMENT 'Date on which the customer completed and submitted the tax residency self-certification form.',
    `self_certification_expiry_date` DATE COMMENT 'Date on which the self-certification expires and requires renewal or revalidation.',
    `self_certification_form_type` STRING COMMENT 'Type of self-certification form submitted by the customer for CRS or other tax residency purposes (e.g., entity self-certification, individual self-certification, controlling person self-certification).',
    `source_system` STRING COMMENT 'Name or code of the source system from which this tax profile record originated (e.g., Core Banking System, Regulatory Reporting Platform, Tax Compliance System).',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the customer is exempt from withholding tax (e.g., foreign governments, international organizations, qualified pension funds).',
    `tax_exemption_reason_code` STRING COMMENT 'Code indicating the reason for tax exemption (e.g., foreign government, international organization, pension fund, charitable organization). [ENUM-REF-CANDIDATE: promote to reference product if more than 6 distinct codes are used]',
    `tin` STRING COMMENT 'Tax Identification Number issued by the primary tax jurisdiction. Format varies by country (e.g., SSN in USA, NI in UK).',
    `tin_issuing_country_code` STRING COMMENT 'Country that issued the Tax Identification Number, represented as ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `tin_type` STRING COMMENT 'Type of Tax Identification Number provided (e.g., SSN for Social Security Number, EIN for Employer Identification Number, ITIN for Individual Taxpayer Identification Number, NI for National Insurance, VAT for Value Added Tax number).. Valid values are `SSN|EIN|ITIN|NI|VAT|OTHER`',
    `treaty_article_reference` STRING COMMENT 'Specific article or section of the tax treaty under which the customer claims treaty benefits (e.g., Article 10 for dividends, Article 11 for interest).',
    `treaty_benefit_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the customer is eligible for reduced withholding tax rates under an applicable tax treaty between the US and the customers country of residence.',
    `treaty_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country with which a tax treaty applies, enabling reduced withholding rates.. Valid values are `^[A-Z]{3}$`',
    `us_person_flag` BOOLEAN COMMENT 'Indicates whether the customer is classified as a US person for FATCA purposes (US citizen, resident alien, domestic partnership, domestic corporation, or US estate/trust).',
    `w8_form_expiry_date` DATE COMMENT 'Date on which the IRS Form W-8 expires and requires renewal. Typically three years from the date of signature unless a change in circumstances occurs.',
    `w8_form_received_date` DATE COMMENT 'Date on which the IRS Form W-8 was received from the customer.',
    `w9_form_received_date` DATE COMMENT 'Date on which the IRS Form W-9 (Request for Taxpayer Identification Number and Certification) was received from the US person customer.',
    `withholding_rate_percent` DECIMAL(18,2) COMMENT 'Applicable withholding tax rate percentage for payments to this customer, based on tax residency, treaty benefits, and FATCA/CRS classification. Expressed as a percentage (e.g., 30.00 for 30%).',
    CONSTRAINT pk_tax_profile PRIMARY KEY(`tax_profile_id`)
) COMMENT 'Customer tax profile record capturing tax residency, TIN (Tax Identification Number), W-8/W-9 form status, withholding rate, and treaty benefit eligibility. Supports FATCA/CRS reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`customer_investor_order` (
    `customer_investor_order_id` BIGINT COMMENT 'Primary key for customer_investor_order',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the capital markets offering for which the order was placed. References the master ECM/DCM transaction record.',
    `investment_investor_order_id` BIGINT COMMENT 'Unique surrogate identifier for the investor order record. Primary key for the investor_order association.',
    `party_id` BIGINT COMMENT 'Foreign key linking to the investor party placing the order. References the golden master record for the institutional investor, retail client, or other legal entity participating in the capital markets offering.',
    `allocation_decision_timestamp` TIMESTAMP COMMENT 'Timestamp when the syndicate desk finalized the allocation decision for this investor order. Typically occurs after pricing_date and before settlement_date.',
    `allocation_price` DECIMAL(18,2) COMMENT 'Final price per share or unit at which securities were allocated to this investor. Typically matches the offerings offer_price, but may differ for certain investor tiers or in Dutch auction scenarios.',
    `allocation_size` DECIMAL(18,2) COMMENT 'Actual monetary value or number of shares/units allocated to the investor by the syndicate desk, expressed in the offering currency. May be less than, equal to, or (rarely) greater than order_size depending on demand and investor tier.',
    `demand_multiple` DECIMAL(18,2) COMMENT 'Ratio of order_size to allocation_size for this investor, indicating the degree of oversubscription at the individual investor level. A value of 2.5 means the investor ordered 2.5x what they were allocated. Used to assess investor demand quality.',
    `investor_tier` STRING COMMENT 'Classification of the investor based on relationship strength, order size, and strategic importance to the offering. Influences allocation priority and size. Tier 1 anchor investors typically receive preferential allocation.',
    `is_anchor_investor` BOOLEAN COMMENT 'Flag indicating whether this investor was designated as an anchor investor for the offering. Anchor investors commit early, receive guaranteed allocation, and provide market confidence. Typically large institutional investors with strategic importance.',
    `lock_up_period_days` STRING COMMENT 'Number of calendar days following settlement during which this specific investor is contractually restricted from selling their allocated securities. May vary by investor tier and negotiation. Null if no investor-specific lock-up applies (offering-level lock-up may still apply).',
    `order_size` DECIMAL(18,2) COMMENT 'Total monetary value or number of shares/units requested by the investor in their order, expressed in the offering currency. Represents investor demand before allocation decisions are made.',
    `order_status` STRING COMMENT 'Current lifecycle state of the investor order. Tracks progression from initial submission through allocation decision to final settlement. Updated by investment banking operations and syndicate desk.',
    `order_submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the investor order was first received by the syndicate desk during the book-building period. Used to track order flow timing and priority.',
    `order_type` STRING COMMENT 'Classification of the order based on pricing and commitment terms. Indicates whether the investor submitted a limit order (price-sensitive), market order (price-insensitive), indication of interest (non-binding), or firm commitment (binding). Captured during book-building process.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Timestamp when securities were delivered to the investor and payment was received. Aligns with the offerings settlement_date but may vary slightly by investor due to operational timing.',
    CONSTRAINT pk_customer_investor_order PRIMARY KEY(`customer_investor_order_id`)
) COMMENT 'This association product represents the order placement and allocation relationship between institutional and retail investors (party) and capital markets offerings (offering). It captures the book-building process where investors submit orders during the roadshow period, and the investment bank allocates securities based on demand, investor tier, and strategic considerations. Each record links one investor party to one offering with order-specific attributes including order size, allocation amount, pricing, investor classification, anchor status, and lock-up terms that exist only in the context of this specific investment order.. Existence Justification: In capital markets offerings, institutional and retail investors place orders during the roadshow/book-building period, and a single investor participates in multiple offerings over time. Conversely, each offering receives orders from hundreds or thousands of investor parties. The investment banks syndicate desk actively manages this many-to-many relationship through the book-building process, tracking order submission, allocation decisions, pricing, investor tier classification, and settlement for each investor-offering combination.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`account_holder` (
    `account_holder_id` BIGINT COMMENT 'Unique identifier for this account holder relationship record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key to the employee who approved this account holder relationship. Required for audit trail and accountability in account administration.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to the deposit account being held or controlled by the party',
    `party_id` BIGINT COMMENT 'Foreign key linking to the party who holds ownership or signing authority on the deposit account',
    `approval_date` DATE COMMENT 'Date this account holder relationship was approved by authorized bank personnel. Required for compliance with account opening and modification procedures.',
    `beneficiary_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of account proceeds allocated to this beneficiary upon account holder death. Must sum to 100% across all beneficiaries of the same type (primary or contingent) for the same account. Null for non-beneficiary roles.',
    `beneficiary_type` STRING COMMENT 'Classification of beneficiary designation if this party is named as a beneficiary on the account. PRIMARY = first in line; CONTINGENT = receives if primary predeceases; PER_STIRPES = inheritance passes to descendants. NONE for non-beneficiary roles.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this account holder relationship record was created. Used for audit and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date this party-account relationship became effective and operational. Used for audit, compliance reporting, and determining when authority was granted.',
    `expiry_date` DATE COMMENT 'Date this party-account relationship expires or was terminated. Null for active relationships. Used to track historical ownership and authority changes, required for regulatory audit trails.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this account holder relationship record was last modified. Used for audit and change tracking.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest this party holds in the account. Relevant for joint accounts and partnership accounts. Must sum to 100% across all owners of the same account. Null for non-owner roles like authorized signers.',
    `ownership_role` STRING COMMENT 'The legal and operational role this party holds with respect to the deposit account. Defines the nature of the relationship and associated rights and responsibilities.',
    `relationship_status` STRING COMMENT 'Current operational status of this account holder relationship. ACTIVE = relationship is in force; SUSPENDED = temporarily inactive due to fraud hold or legal order; TERMINATED = relationship ended; PENDING_APPROVAL = awaiting compliance or management approval.',
    `signing_authority_level` STRING COMMENT 'Level of transactional authority this party has on the account. FULL = can perform all transactions including closure; LIMITED = can transact up to specified limit; VIEW_ONLY = can view but not transact; NONE = ownership without operational authority.',
    `signing_authority_limit_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount this party can authorize on the account when signing_authority_level is LIMITED. Null for FULL authority or VIEW_ONLY/NONE roles. Enforced by transaction processing systems.',
    CONSTRAINT pk_account_holder PRIMARY KEY(`account_holder_id`)
) COMMENT 'This association product represents the ownership and signing authority relationship between parties and deposit accounts. It captures the legal and operational relationship that defines who owns, controls, and has authority over deposit accounts. Each record links one party to one deposit account with attributes that define the nature of ownership (primary owner, joint owner, authorized signer), ownership percentage for joint accounts, signing authority levels and limits, beneficiary designations, and the temporal validity of the relationship. This is the canonical banking M:N pattern that enables joint accounts, corporate accounts with multiple signatories, and accounts with authorized representatives.. Existence Justification: In banking operations, parties and deposit accounts have a true many-to-many relationship. One party (customer) can own or have authority over multiple deposit accounts (checking, savings, money market, CDs), and one deposit account can have multiple parties associated with it (joint account owners, authorized signers, corporate signatories, beneficiaries, trustees). This relationship is actively managed by banking operations teams who add/remove account holders, modify signing authority, update beneficiary designations, and track ownership percentages.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`limit_allocation` (
    `limit_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each party-limit allocation record. Primary key for the limit allocation association.',
    `employee_id` BIGINT COMMENT 'Surrogate identifier of the risk officer or credit committee member who approved this specific allocation. Supports accountability and audit requirements.',
    `party_id` BIGINT COMMENT 'Foreign key linking to the counterparty party for whom this risk limit is allocated',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to the specific risk limit being allocated to this party',
    `allocated_limit_amount` DECIMAL(18,2) COMMENT 'The specific limit amount allocated to this party for this limit type. May differ from the master limit amount in risk_limit when the limit is subdivided across multiple counterparties.',
    `allocation_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which this allocation amount is denominated. May differ from master limit currency for multi-currency counterparty management.',
    `allocation_notes` STRING COMMENT 'Free-text field capturing business rationale, special conditions, or risk committee commentary specific to this party-limit allocation. Documents exception justifications.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of this party-limit allocation. Tracks whether the allocation is actively monitored, temporarily suspended, or has been revoked.',
    `approval_date` DATE COMMENT 'Date on which this specific party-limit allocation was formally approved by the designated risk authority. Critical for audit trail and governance compliance.',
    `breach_count` STRING COMMENT 'Cumulative number of breach events recorded against this specific party-limit allocation since its effective date. Tracks counterparty-specific limit violations.',
    `effective_date` DATE COMMENT 'Date on which this specific limit allocation to this party becomes active and binding. Enables temporal tracking of when counterparty limits were established.',
    `expiry_date` DATE COMMENT 'Date on which this limit allocation to this party ceases to be binding. Null for open-ended allocations. Supports time-bound counterparty exposure management.',
    `last_breach_date` DATE COMMENT 'Date of the most recent breach event for this party-limit allocation. Null if no breaches have occurred. Supports breach pattern analysis.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this party-limit allocation. Used to ensure allocations are reaffirmed according to risk policy review cycles.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this allocation. Drives workflow for periodic reaffirmation of counterparty exposure limits.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this allocation was approved as an exception or override to standard limit policies. True when allocation exceeds normal concentration thresholds or policy guidelines.',
    `utilization_amount` DECIMAL(18,2) COMMENT 'Current utilization of this specific party-limit allocation, expressed in the limit currency. Tracks actual exposure against the allocated amount for this counterparty.',
    CONSTRAINT pk_limit_allocation PRIMARY KEY(`limit_allocation_id`)
) COMMENT 'This association product represents the operational allocation of risk limits to specific counterparties (parties). It captures the approved exposure limits assigned to each party-limit combination, tracking utilization, breaches, and approval governance. Each record links one party to one risk_limit with attributes that exist only in the context of this specific allocation relationship, enabling concentration risk management, counterparty exposure monitoring, and regulatory compliance under Basel III.. Existence Justification: In banking operations, risk limits are allocated to multiple counterparties simultaneously (e.g., a single-name credit limit type is allocated to hundreds of corporate borrowers, a trading limit is allocated to multiple institutional counterparties), and each counterparty (party) is subject to multiple limit types (credit limit, settlement limit, concentration limit, market risk limit). Risk teams actively manage these allocations as operational records, tracking party-specific utilization, approval dates, breach events, and override flags for each party-limit combination.';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`customer_unit_register` (
    `customer_unit_register_id` BIGINT COMMENT 'Primary key for customer_unit_register',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to the fund share class in which units are held',
    `party_id` BIGINT COMMENT 'Foreign key linking to the investor party who holds units in the fund class',
    `asset_unit_register_id` BIGINT COMMENT 'Unique identifier for this investor position record. Primary key for the unit register.',
    `account_number` STRING COMMENT 'Transfer agent or custodian account number under which this position is registered. Links to external systems for transaction processing and reconciliation.',
    `average_cost_per_unit` DECIMAL(18,2) COMMENT 'Weighted average cost basis per unit, calculated across all subscription transactions. Used for capital gains/loss calculation upon redemption. Recalculated with each new subscription using weighted average method.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this unit register record was created (first subscription processed).',
    `distribution_option` STRING COMMENT 'Investors election for how income distributions should be handled for this specific fund class holding. REINVEST: automatically purchase additional units; CASH: pay to registered bank account; TRANSFER: pay to another fund class. Investor can have different elections for different fund class holdings.',
    `first_investment_date` DATE COMMENT 'Date of the investors initial subscription into this fund class. Used as the anchor for holding_period_days calculation, eligibility for founder class benefits, and regulatory reporting (e.g., AIFMD investor reporting requires investment date).',
    `holding_period_days` STRING COMMENT 'Number of calendar days since the first investment in this fund class. Used to determine eligibility for reduced exit loads (many funds waive exit fees after a holding period threshold), long-term vs short-term capital gains classification, and loyalty program benefits.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent subscription or redemption transaction affecting this position. Used for dormancy detection and investor engagement analytics.',
    `position_status` STRING COMMENT 'Current operational status of this investor position. ACTIVE: normal operations; FULLY_REDEEMED: units_held = 0, historical record; SUSPENDED: temporarily blocked from transactions due to KYC review or regulatory hold; BLOCKED: permanently restricted due to sanctions or legal order.',
    `registration_type` STRING COMMENT 'Legal registration structure of this specific holding. Same investor (party) can hold the same fund class under different registration types (e.g., individual account and IRA account). Determines tax treatment, distribution rules, and beneficiary designation requirements.',
    `total_cost_basis` DECIMAL(18,2) COMMENT 'Total acquisition cost of all units held (units_held × average_cost_per_unit). Used for tax reporting and performance attribution. Critical for Form 1099-B reporting in US and equivalent tax forms in other jurisdictions.',
    `units_held` DECIMAL(18,2) COMMENT 'Current number of units or shares held by the investor in this fund class. Updated with each subscription and redemption transaction. Used for NAV-based valuation and distribution calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this record (subscription, redemption, or attribute change).',
    CONSTRAINT pk_customer_unit_register PRIMARY KEY(`customer_unit_register_id`)
) COMMENT 'This association product represents the investor position record between party and fund_class. It captures the ownership stake of an investor (party) in a specific fund share class, tracking units held, cost basis, distribution preferences, and holding period. Each record links one party to one fund_class with attributes that exist only in the context of this investment position. This is the operational record used for NAV calculations, distribution processing, tax reporting (Form 1099, K-1), and redemption processing.. Existence Justification: In asset management operations, investors (parties) hold positions in multiple fund share classes simultaneously (e.g., institutional class of Fund A, retail class of Fund B, hedged class of Fund C), and each fund class has multiple investors. The unit register is the operational system of record that tracks each investors position in each fund class, capturing units held, cost basis, distribution elections, and holding period. This is not an analytical correlation—it is the core operational data structure used daily for subscription processing, redemption processing, NAV calculations, distribution payments, and tax reporting (1099/K-1 generation).';

CREATE OR REPLACE TABLE `banking_ecm`.`customer`.`marketing_campaign` (
    `marketing_campaign_id` BIGINT COMMENT 'Primary key for marketing_campaign',
    `parent_campaign_id` BIGINT COMMENT 'Reference to a parent or umbrella campaign if this is a sub-campaign or variant. Nullable for standalone campaigns.',
    `parent_marketing_campaign_id` BIGINT COMMENT 'Self-referencing FK on marketing_campaign (parent_marketing_campaign_id)',
    `actual_reach` BIGINT COMMENT 'Number of unique customers or prospects actually reached by the campaign.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total amount actually spent on the campaign to date in the base currency.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved for execution. Nullable if not yet approved.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the campaign in the base currency.',
    `business_unit` STRING COMMENT 'Banking business unit or division sponsoring the campaign.',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign, used in tracking URLs, promotional materials, and cross-system references.',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign for internal reference and reporting.',
    `campaign_objective` STRING COMMENT 'Primary business goal the campaign is designed to achieve.',
    `campaign_owner` STRING COMMENT 'Name or identifier of the marketing manager or team responsible for the campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the marketing campaign.',
    `campaign_type` STRING COMMENT 'Classification of the campaign by primary marketing channel or method used.',
    `channel_primary` STRING COMMENT 'Primary communication channel used to deliver the campaign.',
    `channel_secondary` STRING COMMENT 'Secondary or supporting communication channel used in the campaign. Nullable if single-channel.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was marked as completed. Nullable for ongoing or cancelled campaigns.',
    `conversion_count` BIGINT COMMENT 'Number of customers who completed the desired action (e.g., opened account, applied for product).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `creative_version` STRING COMMENT 'Version identifier for the creative assets (copy, images, design) used in the campaign.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget and spend amounts.',
    `end_date` DATE COMMENT 'Date when the campaign is scheduled to conclude. Nullable for ongoing campaigns.',
    `geographic_scope` STRING COMMENT 'Geographic market or region targeted by the campaign (e.g., national, regional, branch-specific).',
    `landing_page_url` STRING COMMENT 'URL of the dedicated landing page for the campaign.',
    `launched_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was actually launched and became active. Nullable if not yet launched.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was last updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about the campaign for internal reference.',
    `offer_code` STRING COMMENT 'Unique promotional code customers can use to redeem the campaign offer.',
    `offer_description` STRING COMMENT 'Detailed description of the promotional offer or value proposition presented in the campaign.',
    `opt_in_required` BOOLEAN COMMENT 'Indicates whether customer opt-in consent is required for this campaign per privacy regulations.',
    `product_category` STRING COMMENT 'Banking product category being promoted (e.g., credit cards, mortgages, investment products, business loans).',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory or compliance approval was granted. Nullable if not required.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the campaign required regulatory or compliance review before launch.',
    `response_count` BIGINT COMMENT 'Number of customers who responded to the campaign (clicked, replied, or engaged).',
    `start_date` DATE COMMENT 'Date when the campaign becomes active and begins execution.',
    `target_audience_size` BIGINT COMMENT 'Number of customers or prospects targeted by this campaign.',
    `target_segment` STRING COMMENT 'Description of the customer segment or persona this campaign is targeting (e.g., high-net-worth individuals, small business owners, millennials).',
    `test_control_flag` BOOLEAN COMMENT 'Indicates whether this campaign includes a test/control group for A/B testing or effectiveness measurement.',
    `tracking_url` STRING COMMENT 'URL with tracking parameters used to measure campaign click-through and conversions.',
    CONSTRAINT pk_marketing_campaign PRIMARY KEY(`marketing_campaign_id`)
) COMMENT 'Master reference table for marketing_campaign. Referenced by lead_source_campaign_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ADD CONSTRAINT `fk_customer_individual_profile_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_primary_corporate_party_id` FOREIGN KEY (`primary_corporate_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_beneficial_owner_id` FOREIGN KEY (`beneficial_owner_id`) REFERENCES `banking_ecm`.`customer`.`beneficial_owner`(`beneficial_owner_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_primary_customer_legal_entity_party_id` FOREIGN KEY (`primary_customer_legal_entity_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_quaternary_customer_party_id` FOREIGN KEY (`quaternary_customer_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_tertiary_customer_owned_party_id` FOREIGN KEY (`tertiary_customer_owned_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_address` ADD CONSTRAINT `fk_customer_party_address_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ADD CONSTRAINT `fk_customer_party_contact_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_document` ADD CONSTRAINT `fk_customer_party_document_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ADD CONSTRAINT `fk_customer_relationship_hierarchy_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `banking_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ADD CONSTRAINT `fk_customer_kyc_review_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_parent_consent_record_id` FOREIGN KEY (`parent_consent_record_id`) REFERENCES `banking_ecm`.`customer`.`consent_record`(`consent_record_id`);
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ADD CONSTRAINT `fk_customer_party_relationship_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ADD CONSTRAINT `fk_customer_party_risk_rating_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ADD CONSTRAINT `fk_customer_customer_relationship_manager_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ADD CONSTRAINT `fk_customer_party_lifecycle_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ADD CONSTRAINT `fk_customer_party_lifecycle_event_reversed_event_party_lifecycle_event_id` FOREIGN KEY (`reversed_event_party_lifecycle_event_id`) REFERENCES `banking_ecm`.`customer`.`party_lifecycle_event`(`party_lifecycle_event_id`);
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ADD CONSTRAINT `fk_customer_fatca_crs_classification_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ADD CONSTRAINT `fk_customer_party_identifier_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`beneficial_owner` ADD CONSTRAINT `fk_customer_beneficial_owner_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_related_complaint_id` FOREIGN KEY (`related_complaint_id`) REFERENCES `banking_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `banking_ecm`.`customer`.`prospect` ADD CONSTRAINT `fk_customer_prospect_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `banking_ecm`.`customer`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `banking_ecm`.`customer`.`prospect` ADD CONSTRAINT `fk_customer_prospect_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`prospect` ADD CONSTRAINT `fk_customer_prospect_prospect_referral_source_party_id` FOREIGN KEY (`prospect_referral_source_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`prospect` ADD CONSTRAINT `fk_customer_prospect_source_prospect_id` FOREIGN KEY (`source_prospect_id`) REFERENCES `banking_ecm`.`customer`.`prospect`(`prospect_id`);
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ADD CONSTRAINT `fk_customer_tax_profile_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ADD CONSTRAINT `fk_customer_tax_profile_previous_tax_profile_id` FOREIGN KEY (`previous_tax_profile_id`) REFERENCES `banking_ecm`.`customer`.`tax_profile`(`tax_profile_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ADD CONSTRAINT `fk_customer_customer_investor_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ADD CONSTRAINT `fk_customer_account_holder_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ADD CONSTRAINT `fk_customer_limit_allocation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ADD CONSTRAINT `fk_customer_customer_unit_register_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` ADD CONSTRAINT `fk_customer_marketing_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `banking_ecm`.`customer`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` ADD CONSTRAINT `fk_customer_marketing_campaign_parent_marketing_campaign_id` FOREIGN KEY (`parent_marketing_campaign_id`) REFERENCES `banking_ecm`.`customer`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `banking_ecm`.`customer`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`party` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Party Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `cif_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Information File (CIF) Number');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `cif_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `cif_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Country Code');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Score');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'retail|corporate|institutional|government|private_wealth');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `is_pep` SET TAGS ('dbx_business_glossary_term' = 'Is Politically Exposed Person (PEP)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `is_sanctioned` SET TAGS ('dbx_business_glossary_term' = 'Is Sanctioned');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Review Date');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|verified|expired|rejected');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'prospect|active|dormant|deceased|closed|merged');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Passport Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Passport Issuing Country Code');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_city` SET TAGS ('dbx_business_glossary_term' = 'Primary Address City');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Country Code');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 1');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 2');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Postal Code');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_state_province` SET TAGS ('dbx_business_glossary_term' = 'Primary Address State or Province');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_address_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Residency Status');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'resident|non_resident|dual_resident');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'T24|FIS_PROFILE|LEGACY');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `individual_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Profile Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Gender Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `code_list_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `code_list_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `annual_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Income Amount');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `annual_income_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `annual_income_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `annual_income_currency` SET TAGS ('dbx_business_glossary_term' = 'Annual Income Currency');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `biometric_authentication_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Authentication Enabled Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `biometric_authentication_enabled_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `biometric_authentication_enabled_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `cltv_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Calculation Date');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Score');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `credit_bureau_reporting_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Bureau Reporting Consent Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'mass_market|affluent|high_net_worth|ultra_high_net_worth|private_banking|premier');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `digital_banking_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Digital Banking Enrollment Date');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `digital_banking_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Banking Enrollment Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Name');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `employer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'employed_full_time|employed_part_time|self_employed|unemployed|retired|student');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `kyc_refresh_due_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Refresh Due Date');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|domestic_partnership');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `marketing_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Date');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `mobile_app_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Application (App) User Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `mobile_app_user_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `mobile_app_user_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `net_worth_band` SET TAGS ('dbx_business_glossary_term' = 'Net Worth Band');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `net_worth_band` SET TAGS ('dbx_value_regex' = 'under_100k|100k_to_500k|500k_to_1m|1m_to_5m|5m_to_10m|over_10m');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `net_worth_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `net_worth_band` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `number_of_dependents` SET TAGS ('dbx_business_glossary_term' = 'Number of Dependents');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `occupation_code` SET TAGS ('dbx_business_glossary_term' = 'Occupation Code');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `occupation_description` SET TAGS ('dbx_business_glossary_term' = 'Occupation Description');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `pep_classification` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Classification');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `pep_classification` SET TAGS ('dbx_value_regex' = 'domestic_pep|foreign_pep|international_organization|family_member|close_associate|not_applicable');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `pep_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `pep_classification` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `pep_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `pep_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|mobile_app|secure_message');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|deceased');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `risk_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating Date');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `tax_residency_countries` SET TAGS ('dbx_business_glossary_term' = 'Tax Residency Countries');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `tax_residency_countries` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `tax_residency_countries` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `us_person_flag` SET TAGS ('dbx_business_glossary_term' = 'United States (US) Person Flag');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `us_person_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ALTER COLUMN `us_person_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `corporate_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Profile ID');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Banking Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Form Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Party ID');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `primary_corporate_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Band');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `credit_rating_fitch` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating - Fitch');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `credit_rating_fitch` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `credit_rating_moodys` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating - Moodys');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `credit_rating_moodys` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `credit_rating_sp` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating - Standard & Poors (S&P)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `credit_rating_sp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `crs_jurisdiction_of_tax_residence` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Jurisdiction of Tax Residence');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `crs_jurisdiction_of_tax_residence` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `employee_count_band` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Band');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `employee_count_band` SET TAGS ('dbx_value_regex' = '1-10|11-50|51-200|201-500|501-1000|1001-5000|5001+');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `fatca_classification` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Classification');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `fatca_classification` SET TAGS ('dbx_value_regex' = 'active_nffe|passive_nffe|ffi|exempt_beneficial_owner|non_participating_ffi');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `industry_classification_system` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification System');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `industry_classification_system` SET TAGS ('dbx_value_regex' = 'SIC|NAICS|ISIC');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Review Date');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Operating Address Line 1');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Operating Address Line 2');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_city` SET TAGS ('dbx_business_glossary_term' = 'Operating City');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_country_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Country Code');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Postal Code');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_state_province` SET TAGS ('dbx_business_glossary_term' = 'Operating State or Province');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `operating_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `publicly_listed_flag` SET TAGS ('dbx_business_glossary_term' = 'Publicly Listed Flag');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `stock_exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Code');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ALTER COLUMN `ubo_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Record ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Tier Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Analyst Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `adverse_media_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `adverse_media_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Result');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `adverse_media_screening_result` SET TAGS ('dbx_value_regex' = 'not_screened|clear|negative_news_identified|under_investigation');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `adverse_media_screening_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `beneficial_ownership_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Ownership Verification Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `beneficial_ownership_verified` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Ownership Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `cdd_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Due Diligence (CDD) Completion Status');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `cdd_completion_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|incomplete');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `customer_risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Customer Risk Profile');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `customer_risk_profile` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `edd_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `edd_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Completion Status');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `edd_completion_status` SET TAGS ('dbx_value_regex' = 'not_applicable|not_started|in_progress|completed|incomplete');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `edd_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Required Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `jurisdiction_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `kyc_documentation_complete` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Documentation Complete Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|approved|expired|rejected|under_review|suspended');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Know Your Customer (KYC) Review Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `last_sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `last_sar_filing_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Know Your Customer (KYC) Review Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Onboarding Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `pep_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `pep_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Screening Result');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `pep_screening_result` SET TAGS ('dbx_value_regex' = 'not_screened|clear|match_identified|under_investigation');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `pep_screening_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `prior_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Prior Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `prior_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `product_service_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Product and Service Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `relationship_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'no_change|upgraded|downgraded|escalated_to_edd|relationship_exited');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `review_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Review Trigger Type');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `review_trigger_type` SET TAGS ('dbx_value_regex' = 'periodic|risk_triggered|regulatory|client_initiated|transaction_triggered|system_alert');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `risk_rating_rationale` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Rationale');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `risk_rating_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_value_regex' = 'not_screened|clear|match_identified|under_investigation');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `source_of_funds_verified` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `source_of_wealth_verified` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ALTER COLUMN `transaction_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Transaction Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `customer_beneficial_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Beneficial Owner ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `beneficial_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Control Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Party ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `primary_customer_country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Of Residence Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `primary_customer_legal_entity_party_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Party ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `quaternary_customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Entity ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `tertiary_customer_owned_party_id` SET TAGS ('dbx_business_glossary_term' = 'Owned Party ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `adverse_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Flag');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `adverse_media_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `certification_form_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Form Reference');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Control Indicator');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `cta_report_date` SET TAGS ('dbx_business_glossary_term' = 'Corporate Transparency Act (CTA) Report Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `cta_report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corporate Transparency Act (CTA) Report Reference Number');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `cta_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Corporate Transparency Act (CTA) Reporting Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `cta_reporting_status` SET TAGS ('dbx_value_regex' = 'reported|pending|exempt|not_required');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Identification Document Number');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_document_type` SET TAGS ('dbx_business_glossary_term' = 'Identification Document Type');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_document_type` SET TAGS ('dbx_value_regex' = 'passport|drivers_license|national_id|state_id|other');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Issue Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Identification Issuing Country');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `identification_issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `last_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_city` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner City');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Date of Birth');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_full_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Full Name');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Postal Code');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_residential_address` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Residential Address');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_residential_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_residential_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_state_province` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner State or Province');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `owner_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|under_review|disputed|expired|terminated');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `ownership_tier_level` SET TAGS ('dbx_business_glossary_term' = 'Ownership Tier Level');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `pep_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `pep_status` SET TAGS ('dbx_value_regex' = 'not_pep|domestic_pep|foreign_pep|international_organization_pep|pep_family_member|pep_close_associate');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `risk_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|match_found|pending_review|false_positive|true_positive');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `tax_residence_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Residence Country');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `tax_residence_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `ubo_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Threshold Met');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `verification_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Reference');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'documentary|non_documentary|electronic|in_person|third_party');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_verified');
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ALTER COLUMN `voting_rights_percentage` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Percentage');
ALTER TABLE `banking_ecm`.`customer`.`party_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`party_address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_address_id` SET TAGS ('dbx_business_glossary_term' = 'Party Address ID');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Address Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `contact_value` SET TAGS ('dbx_business_glossary_term' = 'Contact Value');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `contact_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `contact_value` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `do_not_mail` SET TAGS ('dbx_business_glossary_term' = 'Do Not Mail');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `geographic_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Geographic Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `opt_in_estatements` SET TAGS ('dbx_business_glossary_term' = 'Opt-In E-Statements');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `opt_in_marketing` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Marketing');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_address_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|invalid|expired|suspended');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `party_address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `regulatory_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `tax_domicile_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Domicile Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `usage_context` SET TAGS ('dbx_value_regex' = 'correspondence|service|billing|legal|kyc|emergency');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `banking_ecm`.`customer`.`party_address` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document|third_party|customer_declaration|site_visit|electronic');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `party_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Party Contact Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_preference_rank` SET TAGS ('dbx_business_glossary_term' = 'Contact Preference Rank');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_purpose` SET TAGS ('dbx_business_glossary_term' = 'Contact Purpose');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_purpose` SET TAGS ('dbx_value_regex' = 'personal|business|emergency|billing|correspondence');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|bounced|invalid|suspended');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_business_glossary_term' = 'Contact Value');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `do_not_email` SET TAGS ('dbx_business_glossary_term' = 'Do Not Email Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `do_not_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `do_not_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `do_not_mail` SET TAGS ('dbx_business_glossary_term' = 'Do Not Mail Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `extension` SET TAGS ('dbx_business_glossary_term' = 'Phone Extension');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `last_bounce_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bounce Date');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `opt_in_estatements` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Electronic Statements (E-Statements) Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `opt_in_estatements_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Electronic Statements (E-Statements) Date');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `opt_in_marketing` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Marketing Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `opt_in_marketing_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Marketing Date');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email_link|sms_otp|voice_call|manual|third_party');
ALTER TABLE `banking_ecm`.`customer`.`party_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`party_document` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `party_document_id` SET TAGS ('dbx_business_glossary_term' = 'Party Document Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Document Collection Channel');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `collection_channel` SET TAGS ('dbx_value_regex' = 'branch|online_portal|mobile_app|email|postal_mail|third_party_agent');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Document Collection Date');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Document Confidentiality Level');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `destruction_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Document Destruction Eligible Date');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|jpeg|png|tiff|docx|xml');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language Code');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Document Size in Kilobytes (KB)');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Uniform Resource Identifier (URI)');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `document_storage_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `is_primary_identity_document` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identity Document Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Document Review Date');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Document Notes');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Document Rejection Reason');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period in Years');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Document Review Due Date');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `translation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Required Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `translation_status` SET TAGS ('dbx_business_glossary_term' = 'Translation Status');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `translation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|certified');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual_review|biometric_match|third_party_bureau|automated_ocr|video_verification|in_person');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `banking_ecm`.`customer`.`party_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|expired|rejected|pending_review|under_investigation');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `relationship_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Hierarchy Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party A Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `consolidated_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Exposure Flag');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Control Indicator');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `cross_sell_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Eligibility Flag');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `kyc_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Last Review Date');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Review Date');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_required');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `pep_indicator` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Indicator');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `related_party_transaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Related Party Transaction Flag');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_value_regex' = 'hierarchical|bilateral|reciprocal');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `relationship_source_code` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `relationship_source_system` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source System');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated|under_review');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `role_a` SET TAGS ('dbx_business_glossary_term' = 'Role of Party A');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `role_b` SET TAGS ('dbx_business_glossary_term' = 'Role of Party B');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `sanctions_last_screened_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Last Screened Date');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending|not_screened');
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `banking_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'marketing_operations');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Identifier');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Identifier');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Lob Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'RULE_BASED|MANUAL_OVERRIDE|MODEL_DRIVEN');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `aum_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Maximum Threshold');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `aum_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Minimum Threshold');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `campaign_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Eligibility Flag');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `cltv_cohort` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Cohort');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `cltv_cohort` SET TAGS ('dbx_value_regex' = 'HIGH|MEDIUM|LOW');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Score');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `criteria` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Criteria');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `ftp_pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Tier');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Segment Assignment Flag');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Segment Review Date');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `model_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Model Run Identifier');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Segment Review Date');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `override_rationale` SET TAGS ('dbx_business_glossary_term' = 'Override Rationale');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `previous_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Segment Code');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|SUPERSEDED|PENDING');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RETAIL|CORPORATE|SOVEREIGN|FINANCIAL_INSTITUTION');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `revenue_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Revenue Maximum Threshold');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `revenue_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Revenue Minimum Threshold');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|VERY_HIGH');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = 'MASS_MARKET|MASS_AFFLUENT|HNW|UHNW|SME|MID_MARKET');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'PREMIUM|STANDARD|BASIC');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `sub_segment` SET TAGS ('dbx_business_glossary_term' = 'Sub-Segment Classification');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `transition_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Transition Date');
ALTER TABLE `banking_ecm`.`customer`.`segment` ALTER COLUMN `transition_reason` SET TAGS ('dbx_business_glossary_term' = 'Segment Transition Reason');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` SET TAGS ('dbx_subdomain' = 'marketing_operations');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `party_segment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Party Segment Assignment Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Line Of Business Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|manual_override|model_driven|system_generated|migration|bulk_import');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded|cancelled');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `aum_band` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Band');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `campaign_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Eligibility Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `cltv_cohort` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Cohort');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `model_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Model Run Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `model_score` SET TAGS ('dbx_business_glossary_term' = 'Model Score');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `revenue_band` SET TAGS ('dbx_business_glossary_term' = 'Revenue Band');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|critical');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Tier');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|platinum|private');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `transition_date` SET TAGS ('dbx_business_glossary_term' = 'Transition Date');
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ALTER COLUMN `transition_reason` SET TAGS ('dbx_business_glossary_term' = 'Transition Reason');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `primary_onboarding_assigned_analyst_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `primary_onboarding_assigned_analyst_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `primary_onboarding_assigned_analyst_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Servicing Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `tertiary_onboarding_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `tertiary_onboarding_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `tertiary_onboarding_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `beneficial_owner_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Number');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Status');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|approved|declined|manual_review');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `crs_status` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Status');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `crs_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|compliant|non_compliant|exempt');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `document_checklist_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Checklist Complete Flag');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `expected_account_balance` SET TAGS ('dbx_business_glossary_term' = 'Expected Account Balance');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `expected_account_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `expected_monthly_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Monthly Transaction Volume');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|compliant|non_compliant|exempt');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `onboarding_channel` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Channel');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `onboarding_channel` SET TAGS ('dbx_value_regex' = 'branch|digital_web|digital_mobile|relationship_manager|call_center|api_partner');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Type');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_value_regex' = 'new_to_bank|new_to_product|existing_party_new_segment|cross_sell|relationship_upgrade|entity_conversion');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|vip');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `product_applied_for` SET TAGS ('dbx_business_glossary_term' = 'Product Applied For');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|prohibited');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `sla_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `stage_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Stage Entry Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Workflow Stage');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `kyc_review_event_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Review Event ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Review Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `adverse_media_findings_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Findings Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `beneficial_ownership_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Ownership Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `documents_reviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Documents Reviewed Count');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `documents_updated_count` SET TAGS ('dbx_business_glossary_term' = 'Documents Updated Count');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `edd_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `edd_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Required Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `new_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'New Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `new_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|prohibited');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `pep_status` SET TAGS ('dbx_value_regex' = 'not_pep|domestic_pep|foreign_pep|international_organization_pep|pep_associate');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `prior_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Prior Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `prior_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|prohibited');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `regulatory_mandate_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Reference');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `relationship_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Exit Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `relationship_exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Relationship Exit Reason');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'no_change|upgraded|downgraded|escalated_to_edd|relationship_exited|suspended');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Review Reference Number');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_scope` SET TAGS ('dbx_business_glossary_term' = 'Review Scope');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_scope` SET TAGS ('dbx_value_regex' = 'full|limited|targeted|expedited');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|pending_approval|completed|escalated|cancelled');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `risk_rating_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Change Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match|not_performed');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `source_of_funds_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `source_of_wealth_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Trigger Reason');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `parent_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consent Record Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Consent Audit Trail');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Evidence Reference');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Consent Jurisdiction Code');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit_opt_in|implicit_opt_in|pre_checked_box|verbal|written_signature|electronic_signature');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose Description');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Consent Renewal Frequency in Months');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Renewal Required Flag');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope Description');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_source_system` SET TAGS ('dbx_business_glossary_term' = 'Consent Source System');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending|revoked|superseded');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_withdrawn_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawn Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `minor_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Consent Flag');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `opt_out_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Processed Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `opt_out_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Request Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `third_party_recipient` SET TAGS ('dbx_business_glossary_term' = 'Third Party Recipient');
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `party_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Party Relationship Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party A Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'guarantee_agreement|power_of_attorney|authorization_letter|trust_deed|agency_agreement|referral_agreement');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Review Date');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_required');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Relationship Limit Amount');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Relationship Limit Currency');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_percentage` SET TAGS ('dbx_business_glossary_term' = 'Relationship Percentage');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_role_a` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role A');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_role_a` SET TAGS ('dbx_value_regex' = 'guarantor|borrower|co_applicant|authorized_signatory|power_of_attorney|referral_source');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_role_b` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role B');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_role_b` SET TAGS ('dbx_value_regex' = 'guarantor|borrower|co_applicant|authorized_signatory|power_of_attorney|referral_source');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_value_regex' = 'direct|referral|branch|online|third_party|migration');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|expired');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending|not_screened');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'mutual_agreement|breach|regulatory|death|bankruptcy|other');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `party_risk_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Party Risk Rating Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Approver Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `primary_party_rating_analyst_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Analyst Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `primary_party_rating_analyst_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `primary_party_rating_analyst_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Rating Data Source');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'External Rating Agency');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `external_rating_date` SET TAGS ('dbx_business_glossary_term' = 'External Rating Date');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `external_rating_grade` SET TAGS ('dbx_business_glossary_term' = 'External Rating Grade');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `internal_rating_grade` SET TAGS ('dbx_business_glossary_term' = 'Internal Rating Grade');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `lgd_estimate` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Estimate');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `model_score` SET TAGS ('dbx_business_glossary_term' = 'Model Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Model Version');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rating Notes');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Rating Override Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `override_rationale` SET TAGS ('dbx_business_glossary_term' = 'Rating Override Rationale');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `pd_estimate` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Estimate');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `previous_rating_grade` SET TAGS ('dbx_business_glossary_term' = 'Previous Rating Grade');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_change_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Change Date');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Rating Confidence Level');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Assignment Date');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_migration_direction` SET TAGS ('dbx_business_glossary_term' = 'Rating Migration Direction');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_migration_direction` SET TAGS ('dbx_value_regex' = 'upgrade|downgrade|stable|new');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Identifier');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Type');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_value_regex' = 'credit_risk|aml_risk|operational_risk|market_risk|country_risk|concentration_risk');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Treatment');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_value_regex' = 'standard|irb_foundation|irb_advanced|exempt');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `risk_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `stress_test_scenario` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Scenario Identifier');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `stressed_pd_estimate` SET TAGS ('dbx_business_glossary_term' = 'Stressed Probability of Default (PD) Estimate');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `watch_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Watch List Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ALTER COLUMN `watch_list_reason` SET TAGS ('dbx_business_glossary_term' = 'Watch List Reason');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `customer_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Manager ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Role Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager (RM) Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Rm Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `tertiary_customer_handover_to_rm_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handover To Relationship Manager (RM) Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `tertiary_customer_handover_to_rm_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `tertiary_customer_handover_to_rm_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_value_regex' = 'new_client|rm_transfer|segment_migration|coverage_model_change|geographic_realignment|product_specialization');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|expired');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `client_aum` SET TAGS ('dbx_business_glossary_term' = 'Client Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `client_aum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `client_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Client Revenue Target');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `client_revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `client_segment` SET TAGS ('dbx_business_glossary_term' = 'Client Segment');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `crm_routing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Routing Flag');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `geographic_coverage_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Region');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `handover_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Completion Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Flag');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'retail_banking|commercial_banking|investment_banking|wealth_management|asset_management|treasury_services');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `performance_attribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Attribution Flag');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `product_coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Coverage Scope');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `revenue_attribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attribution Percentage');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `party_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Party Lifecycle Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Event Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `reversed_event_party_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `aml_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Required Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `dedup_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Confidence Score');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `event_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `event_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Description');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `kyc_refresh_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Refresh Triggered Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Party Status');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|postal_mail|in_app|phone_call|none');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Party Status');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `source_system_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ALTER COLUMN `triggering_system` SET TAGS ('dbx_business_glossary_term' = 'Triggering System');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `fatca_crs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'FATCA (Foreign Account Tax Compliance Act) and CRS (Common Reporting Standard) Classification ID');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Fatca Classification Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Residence Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `chapter_4_status` SET TAGS ('dbx_business_glossary_term' = 'Chapter 4 Status');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|PENDING_REVIEW|EXPIRED|SUPERSEDED|INVALID');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `controlling_person_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlling Person Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `crs_reportable_jurisdiction_list` SET TAGS ('dbx_business_glossary_term' = 'CRS (Common Reporting Standard) Reportable Jurisdiction List');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `cure_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Period End Date');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `cure_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Start Date');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `cure_period_status` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Status');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `cure_period_status` SET TAGS ('dbx_value_regex' = 'NOT_APPLICABLE|CURE_PENDING|CURE_COMPLETED|CURE_EXPIRED');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `documentation_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Complete Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `fatca_giin` SET TAGS ('dbx_business_glossary_term' = 'FATCA GIIN (Global Intermediary Identification Number)');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `fatca_giin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}.[A-Z0-9]{5}.(LE|SL|ME|BR).[0-9]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reason_no_tin` SET TAGS ('dbx_business_glossary_term' = 'Reason No TIN (Tax Identification Number)');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reason_no_tin` SET TAGS ('dbx_value_regex' = 'NOT_REQUIRED|NOT_ISSUED|APPLIED_FOR|OTHER');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reason_no_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reason_no_tin` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `recalcitrant_account_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Recalcitrant Account Holder Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `reporting_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `secondary_tax_residence_country_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Tax Residence Country Code');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `secondary_tax_residence_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `self_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Certification Date');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `self_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Certification Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `self_certification_form_type` SET TAGS ('dbx_business_glossary_term' = 'Self-Certification Form Type');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_address_flag` SET TAGS ('dbx_business_glossary_term' = 'US Indicia Address Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_birthplace_flag` SET TAGS ('dbx_business_glossary_term' = 'US Indicia Birthplace Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_in_care_of_flag` SET TAGS ('dbx_business_glossary_term' = 'US Indicia In-Care-Of Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_phone_flag` SET TAGS ('dbx_business_glossary_term' = 'US Indicia Phone Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_phone_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_phone_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_power_of_attorney_flag` SET TAGS ('dbx_business_glossary_term' = 'US Indicia Power of Attorney Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `us_indicia_standing_instruction_flag` SET TAGS ('dbx_business_glossary_term' = 'US Indicia Standing Instruction Flag');
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ALTER COLUMN `withholding_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Withholding Rate Percent');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `party_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier ID');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `deduplication_key` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Key');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `identifier_status` SET TAGS ('dbx_business_glossary_term' = 'Identifier Status');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `identifier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending|revoked');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Identifier Value');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `identifier_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `identifier_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identifier Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual|automated|third_party|self_attested|document_review|api_lookup');
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `risk_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Risk Rating Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Approver Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `primary_risk_override_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Override Approving Officer Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `primary_risk_override_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `primary_risk_override_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `risk_analyst_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Analyst Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `risk_analyst_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `risk_analyst_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `adverse_information_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Adverse Information Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `adverse_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Finding Flag');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `adverse_media_summary` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Finding Summary');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `cdd_tier_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Due Diligence (CDD) Tier Required');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `cdd_tier_required` SET TAGS ('dbx_value_regex' = 'simplified|standard|enhanced');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `customer_type_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Type Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `edd_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Required Flag');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `geographic_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Geographic Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `kyc_review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Review Frequency in Months');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Model Version');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Notes');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Composite Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `override_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `override_indicator` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator Flag');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Justification');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `pep_status` SET TAGS ('dbx_value_regex' = 'not_pep|domestic_pep|foreign_pep|international_organization_pep|pep_family_member|pep_close_associate');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `prior_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Prior Anti-Money Laundering (AML) Risk Tier');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `prior_risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|prohibited');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `product_service_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Product and Service Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Assessment Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Methodology');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_value_regex' = 'rule_based|model_based|hybrid|manual_override');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `rating_rationale` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Rationale Narrative');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `rating_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Reference Number');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Status');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'active|pending_review|expired|superseded|rejected');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `relationship_exit_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Exit Consideration Flag');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `risk_tier_change_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Change Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `risk_tier_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Change Reason');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `sanctions_last_screened_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Last Screened Date');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match|false_positive|pending_review');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `sar_filing_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Consideration Flag');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `transaction_behavior_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Transaction Behavior Risk Score');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `transaction_monitoring_rule_intensity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Monitoring Rule Intensity Level');
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ALTER COLUMN `transaction_monitoring_rule_intensity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`customer`.`beneficial_owner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`beneficial_owner` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`beneficial_owner` ALTER COLUMN `beneficial_owner_id` SET TAGS ('dbx_business_glossary_term' = 'beneficial_owner Identifier');
ALTER TABLE `banking_ecm`.`customer`.`beneficial_owner` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`complaint` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_assigned_handler_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Handler Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_assigned_handler_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_assigned_handler_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `related_complaint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Complaint Channel');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Date');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|executive|regulatory');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'retail_banking|commercial_banking|investment_banking|wealth_management|treasury|capital_markets');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Complaint Notes');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `product_service_complained` SET TAGS ('dbx_business_glossary_term' = 'Product or Service Complained About');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Reference Number');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `sla_target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Date');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`complaint` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `banking_ecm`.`customer`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`prospect` SET TAGS ('dbx_subdomain' = 'marketing_operations');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Relationship Manager (RM) Employee Identifier');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Campaign Identifier');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Party Identifier');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `prospect_referral_source_party_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Party Identifier');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `source_prospect_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `data_privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Consent Flag');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `disqualification_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Date');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `estimated_annual_revenue_potential` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Revenue Potential');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `estimated_annual_revenue_potential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `estimated_aum` SET TAGS ('dbx_business_glossary_term' = 'Estimated Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `estimated_aum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `first_contact_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Date');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `marketing_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Date');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `pep_indicator_preliminary` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Politically Exposed Person (PEP) Indicator');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `products_of_interest` SET TAGS ('dbx_business_glossary_term' = 'Products of Interest');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Type');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|institutional|government|partnership|trust');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|highly_qualified|not_qualified');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Prospect Reference Number');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `risk_rating_preliminary` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Risk Rating');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `risk_rating_preliminary` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `sanctions_screening_preliminary` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Sanctions Screening Result');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `sanctions_screening_preliminary` SET TAGS ('dbx_value_regex' = 'not_screened|clear|potential_match|confirmed_match');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`prospect` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tax_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Profile ID');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Residency Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'W8 Form Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `previous_tax_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `backup_withholding_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Withholding Flag');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `backup_withholding_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Backup Withholding Rate Percent');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `chapter_3_status_code` SET TAGS ('dbx_business_glossary_term' = 'Chapter 3 Status Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `chapter_4_status_code` SET TAGS ('dbx_business_glossary_term' = 'Chapter 4 Status Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `crs_reportable_jurisdiction_list` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Jurisdiction List');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `documentation_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Complete Flag');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'COMPLETE|INCOMPLETE|PENDING|EXPIRED|NOT_REQUIRED');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `fatca_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Classification Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `fatca_giin` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Global Intermediary Identification Number (GIIN)');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `fatca_giin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}.[A-Z0-9]{5}.[A-Z]{2}.[0-9]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|PENDING|EXPIRED|SUSPENDED');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tax_residency_country_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Tax Residency Country Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tax_residency_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tin` SET TAGS ('dbx_business_glossary_term' = 'Secondary Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tin_issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Tax Identification Number (TIN) Issuing Country Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tin_issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tin_issuing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `secondary_tin_issuing_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `self_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Certification Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `self_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Certification Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `self_certification_form_type` SET TAGS ('dbx_business_glossary_term' = 'Self-Certification Form Type');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tax_exemption_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Reason Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN) Issuing Country Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_issuing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_issuing_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN) Type');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_type` SET TAGS ('dbx_value_regex' = 'SSN|EIN|ITIN|NI|VAT|OTHER');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `tin_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `treaty_article_reference` SET TAGS ('dbx_business_glossary_term' = 'Treaty Article Reference');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `treaty_benefit_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Treaty Benefit Eligibility Flag');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `treaty_country_code` SET TAGS ('dbx_business_glossary_term' = 'Treaty Country Code');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `treaty_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `us_person_flag` SET TAGS ('dbx_business_glossary_term' = 'United States (US) Person Flag');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `w8_form_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'IRS Form W-8 Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `w8_form_received_date` SET TAGS ('dbx_business_glossary_term' = 'IRS Form W-8 Received Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `w9_form_received_date` SET TAGS ('dbx_business_glossary_term' = 'IRS Form W-9 Received Date');
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ALTER COLUMN `withholding_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Withholding Rate Percent');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` SET TAGS ('dbx_association_edges' = 'customer.party,investment.offering');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `customer_investor_order_id` SET TAGS ('dbx_business_glossary_term' = 'customer_investor_order Identifier');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Order - Capital Markets Offering Id');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `investment_investor_order_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Order ID');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Order - Party Id');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `allocation_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Decision Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `allocation_price` SET TAGS ('dbx_business_glossary_term' = 'Allocation Price');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `allocation_size` SET TAGS ('dbx_business_glossary_term' = 'Allocation Size');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `demand_multiple` SET TAGS ('dbx_business_glossary_term' = 'Demand Multiple');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `investor_tier` SET TAGS ('dbx_business_glossary_term' = 'Investor Tier');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `is_anchor_investor` SET TAGS ('dbx_business_glossary_term' = 'Is Anchor Investor');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `lock_up_period_days` SET TAGS ('dbx_business_glossary_term' = 'Lock-Up Period Days');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `order_size` SET TAGS ('dbx_business_glossary_term' = 'Order Size');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `order_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Submission Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` SET TAGS ('dbx_association_edges' = 'customer.party,account.deposit_account');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Identifier');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Employee Identifier');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder - Deposit Account Id');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder - Party Id');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `beneficiary_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Allocation Percentage');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `ownership_role` SET TAGS ('dbx_business_glossary_term' = 'Ownership Role');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `signing_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority Level');
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ALTER COLUMN `signing_authority_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority Limit Amount');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` SET TAGS ('dbx_association_edges' = 'customer.party,risk.risk_limit');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `limit_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Allocation Identifier');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Employee');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Allocation - Party Id');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Allocation - Risk Limit Id');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `allocated_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Limit Amount');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `allocation_currency` SET TAGS ('dbx_business_glossary_term' = 'Allocation Currency');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Approval Date');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Allocation Breach Count');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `last_breach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Allocation Breach Date');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Allocation Review Date');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Allocation Review Date');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocation Override Flag');
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ALTER COLUMN `utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Utilization Amount');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` SET TAGS ('dbx_association_edges' = 'customer.party,asset.fund_class');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `customer_unit_register_id` SET TAGS ('dbx_business_glossary_term' = 'customer_unit_register Identifier');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Register - Fund Class Id');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Register - Party Id');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `asset_unit_register_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Register Identifier');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `average_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Unit');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Created Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `distribution_option` SET TAGS ('dbx_business_glossary_term' = 'Distribution Option');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `first_investment_date` SET TAGS ('dbx_business_glossary_term' = 'First Investment Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Days');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `total_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Basis');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `units_held` SET TAGS ('dbx_business_glossary_term' = 'Units Held');
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Updated Timestamp');
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` SET TAGS ('dbx_subdomain' = 'marketing_operations');
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Identifier');
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` ALTER COLUMN `parent_marketing_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`customer`.`marketing_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
