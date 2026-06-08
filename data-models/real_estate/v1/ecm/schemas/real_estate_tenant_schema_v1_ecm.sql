-- Schema for Domain: tenant | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:46:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`tenant` COMMENT 'SSOT for all tenant and prospect identities across commercial and residential portfolios. Manages tenant profiles, contact hierarchies, credit profiles, HOA memberships, occupancy history, lease history, and CRM-linked prospect pipelines. Supports both B2B corporate tenants and B2C residential occupants with comprehensive tenant lifecycle and relationship management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`tenant` (
    `tenant_id` BIGINT COMMENT 'Primary key for tenant',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Portfolio assignment reporting, workload balancing, and manager performance tracking all require linking each tenant profile to their assigned property manager (employee). The existing `assigned_prope',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Tenant billing address geographic hierarchy enables market-level tenant reporting, regulatory jurisdiction assignment for tax and compliance, and portfolio segmentation by submarket. Role-prefixed bi',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: B2B tenant profiles represent corporate tenants whose legal entity details are mastered in corporate_entity. tenant.entity_type distinguishes corporate from individual tenants. Linking tenant.corporat',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Tenant billing currency is required for multi-currency portfolio rent invoicing, financial reporting, and FX exposure management. International real estate portfolios routinely bill tenants in local c',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: Residential tenant profiles belong to household groupings. tenant.hoa_member and household.hoa_member confirm the residential context. Linking tenant.household_id → household.household_id connects ind',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Tenant incorporation country is required for KYC/AML compliance, foreign ownership restriction checks, tax treaty applicability, and FATF risk assessment. incorporation_country is a denormalized cou',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: Tenant industry classification drives credit risk tiering, anchor tenant eligibility assessment, CAM recovery rules, and portfolio diversification reporting. Real estate leasing teams classify every t',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Tenant portfolio segment classification drives investment strategy reporting, NOI attribution by market segment, and asset management decisions. portfolio_segment is a denormalized representation of',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Most recently reported annual gross revenue of the corporate tenant in USD. Used for commercial lease underwriting, rent-to-revenue ratio analysis, and portfolio credit risk assessment. Null for residential individual tenants.',
    `billing_address_city` STRING COMMENT 'City component of the tenants billing address. Used in conjunction with billing_address_line1, billing_address_state, billing_address_postal_code, and billing_address_country for complete invoice addressing.',
    `billing_address_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the tenants billing address. Required for international tenant invoicing, VAT/GST determination, and FATCA/CRS cross-border reporting.. Valid values are `^[A-Z]{3}$`',
    `billing_address_line1` STRING COMMENT 'First line of the tenants billing address used for invoice delivery, rent statements, and CAM reconciliation notices. May differ from the occupied premises address for corporate tenants with centralised accounts payable.',
    `billing_address_postal_code` STRING COMMENT 'Postal or ZIP code of the tenants billing address. Used for geographic segmentation, tax jurisdiction mapping, and mail delivery of rent statements and legal notices.',
    `billing_address_state` STRING COMMENT 'State or province component of the tenants billing address. Used for state tax nexus determination, sales tax applicability on CAM charges, and jurisdictional compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tenant master record was first created in the Silver Layer lakehouse, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Serves as the RECORD_AUDIT_CREATED canonical category field. Used for data lineage, GDPR data subject request processing, and audit trail compliance.',
    `credit_score` STRING COMMENT 'Numeric credit score obtained from a third-party credit bureau (e.g., Experian, Equifax, TransUnion) or commercial credit agency (e.g., Dun & Bradstreet PAYDEX). Used for residential applicant screening and commercial tenant underwriting. Range typically 300–850 for consumer; 0–100 for commercial PAYDEX.',
    `credit_score_date` DATE COMMENT 'Date on which the most recent credit score was obtained. Used to determine whether the credit assessment is current (typically valid for 90 days for residential, 12 months for commercial) and to trigger re-screening workflows.',
    `credit_tier` STRING COMMENT 'Internal credit quality classification assigned to the tenant following underwriting review. Tier A represents investment-grade or highest creditworthiness; Tier D represents sub-investment-grade or high-risk. Drives lease security deposit requirements, guarantor obligations, and portfolio risk reporting.. Valid values are `A|B|C|D|unrated`',
    `crm_account_code` STRING COMMENT 'Salesforce CRM Account record identifier linked to this tenant or prospect. Enables bi-directional synchronization of deal pipeline, contact activity, and tenant relationship data between the CRM and the property management system.',
    `do_not_contact` BOOLEAN COMMENT 'Indicates that the tenant has opted out of non-essential marketing and promotional communications. When True, outbound CRM campaigns and marketing emails must be suppressed. Does not suppress legally required notices (rent demands, eviction notices).',
    `employee_count` STRING COMMENT 'Approximate number of employees of the corporate tenant at the time of lease underwriting. Used to assess space utilisation requirements, parking demand, and building amenity capacity planning. Null for residential tenants.',
    `entity_type` STRING COMMENT 'Legal entity classification of the tenant. Distinguishes between natural persons (individual) and legal entities (corporation, partnership, LLC, trust, government agency). Drives lease structuring, credit assessment methodology, and tax documentation requirements (W-9 vs W-8 series). [ENUM-REF-CANDIDATE: individual|corporation|partnership|llc|trust|government|non_profit|reit — promote to reference product]. Valid values are `individual|corporation|partnership|llc|trust|government`',
    `esg_consent_given` BOOLEAN COMMENT 'Indicates whether the tenant has provided consent to share utility consumption, energy usage, and sustainability data for ESG reporting purposes. Required for LEED, BREEAM, and GRESB portfolio-level sustainability disclosures. Drives data sharing agreements with utility providers.',
    `first_lease_start_date` DATE COMMENT 'Date on which the tenants earliest lease with the enterprise commenced. Used to calculate total tenure, loyalty tier classification, and long-term tenant relationship analytics. Populated from Yardi Voyager lease history.',
    `guarantor_required` BOOLEAN COMMENT 'Indicates whether a personal or corporate guarantor is required as a condition of the lease based on the tenants credit tier or underwriting outcome. When True, a guaranty agreement must be executed prior to lease commencement.',
    `hoa_code` STRING COMMENT 'Membership identifier assigned by the Homeowners Association (HOA) to the residential tenant. Used to reconcile HOA dues payments, violation notices, and community access credentials. Null when hoa_member is False.',
    `hoa_member` BOOLEAN COMMENT 'Indicates whether the residential tenant is subject to a Homeowners Association (HOA) membership obligation as part of their occupancy agreement. When True, HOA dues, rules, and compliance obligations are tracked separately. Applicable to residential portfolio only.',
    `incorporation_state` STRING COMMENT 'U.S. state (or equivalent jurisdiction) in which the corporate tenant is legally incorporated or registered. Used for entity verification, lien searches, and compliance with state-specific landlord-tenant statutes. Null for individual/residential tenants.',
    `kyc_verified` BOOLEAN COMMENT 'Indicates whether the tenant has successfully passed Know Your Customer (KYC) and Anti-Money Laundering (AML) identity verification checks as required for high-value commercial leases and REIT compliance. Mandatory for tenants in regulated sectors.',
    `kyc_verified_date` DATE COMMENT 'Date on which the KYC/AML verification was last completed and approved. Used to determine whether re-verification is required based on the enterprises periodic review schedule (typically every 12–24 months for commercial tenants).',
    `lease_count` STRING COMMENT 'Number of currently active lease agreements associated with this tenant across the portfolio. Supports multi-tenancy analytics, portfolio concentration risk reporting, and WALT/WALE calculations. Derived from the lease domain but stored here as a denormalised operational indicator for CRM and AM dashboards.',
    `legal_name` STRING COMMENT 'Full legal name of the tenant as registered with the relevant authority. For B2B corporate tenants this is the registered company name; for B2C residential occupants this is the individuals full legal name as it appears on government-issued identification. Used for lease execution, invoicing, and regulatory reporting.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the tenant in the enterprise lifecycle pipeline: prospect (CRM lead), applicant (application submitted), active (occupying under a lease), former (lease ended in good standing), evicted (lease terminated for cause). Drives workflow routing, data retention policies, and CRM pipeline reporting.. Valid values are `prospect|applicant|active|former|evicted`',
    `most_recent_lease_expiry` DATE COMMENT 'Expiry date of the tenants most recently executed or currently active lease. Used for Weighted Average Lease Expiry (WALE) reporting, renewal pipeline management, and vacancy forecasting in Argus Enterprise.',
    `mri_tenant_code` STRING COMMENT 'Tenant identifier assigned by MRI Software for residential or investment-managed portfolios. Populated when the tenant record originates from or is co-managed in MRI; null for Yardi-only portfolios.',
    `onboarding_status` STRING COMMENT 'Tracks the completion state of the tenant onboarding workflow including KYC/AML checks, lease execution via DocuSign CLM, Yardi account setup, and portal access provisioning. Distinct from lifecycle_stage which reflects the broader relationship state.. Valid values are `not_started|in_progress|completed|on_hold`',
    `portal_access_enabled` BOOLEAN COMMENT 'Indicates whether the tenant has been provisioned access to the self-service tenant portal (Yardi RentCafe or equivalent). When True, the tenant can view statements, submit maintenance requests via Building Engines, and execute documents via DocuSign CLM.',
    `preferred_contact_method` STRING COMMENT 'Tenants stated preference for receiving communications including rent notices, maintenance updates, and lease renewal offers. Drives communication channel selection in Yardi Voyager, Building Engines, and Salesforce CRM outreach workflows.. Valid values are `email|phone|portal|mail|sms`',
    `primary_contact_email` STRING COMMENT 'Primary email address for tenant communications including rent notices, lease renewal offers, maintenance updates, and regulatory disclosures. Serves as the principal digital contact channel in Yardi Voyager and Salesforce CRM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the tenant contact, stored in E.164 international format. Used for lease administration communications, emergency notifications, and Building Engines tenant service request follow-up.. Valid values are `^+?[1-9]d{1,14}$`',
    `prospect_source` STRING COMMENT 'Lead origination channel through which the prospect was first introduced to the portfolio. Used for brokerage commission attribution, marketing ROI analysis, and CRM pipeline source reporting. Populated from Salesforce CRM deal pipeline. [ENUM-REF-CANDIDATE: referral|broker|website|mls|direct|costar|social_media|event|other — promote to reference product]',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Total security deposit amount held by the landlord in USD as collateral against the tenants lease obligations. Determined by credit tier and lease terms. Subject to state-specific statutory limits and interest accrual requirements. Tracked in Yardi Voyager AR module.',
    `tax_identifier` STRING COMMENT 'Federal tax identification number for the tenant. For corporations and partnerships this is the Employer Identification Number (EIN); for individuals this is the Social Security Number (SSN) or Individual Taxpayer Identification Number (ITIN). Required for IRS 1099 reporting, W-9 compliance, and CAM reconciliation invoicing.',
    `trading_name` STRING COMMENT 'The doing business as (DBA) or trade name used by a corporate tenant for signage, directory listings, and marketing purposes. May differ from the legal entity name. Relevant for retail and commercial tenants in multi-tenant properties.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the tenant master record in the Silver Layer lakehouse, in ISO 8601 format. Used for change data capture (CDC), incremental ETL processing, and audit trail compliance under SOX and GDPR.',
    `yardi_tenant_code` STRING COMMENT 'The native tenant identifier assigned by Yardi Voyager (e.g., T-00012345). Used to reconcile the golden record back to the property management system of record for AR, lease administration, and GL posting.',
    CONSTRAINT pk_tenant PRIMARY KEY(`tenant_id`)
) COMMENT 'SSOT master record for all tenant and prospect identities across commercial and residential portfolios. Captures legal name, entity type (B2B corporate vs B2C residential), tax identification, incorporation details, credit tier, CRM account linkage, property management system tenant code, onboarding status, and lifecycle stage (prospect, applicant, active tenant, former tenant). Serves as the authoritative golden record for every occupant and prospective occupant across the enterprise.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`tenant_contact` (
    `tenant_contact_id` BIGINT COMMENT 'Unique surrogate identifier for each individual contact record associated with a tenant profile. Primary key for the tenant_contact data product in the Silver Layer lakehouse.',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: Tenant contacts for B2B tenants are employees or representatives of corporate entities. Linking tenant_contact.corporate_entity_id → corporate_entity.corporate_entity_id connects the contact to their ',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: Individual tenant contacts (adults, co-signatories) are members of residential households. Linking tenant_contact.household_id → household.household_id connects individual contacts to their household ',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Contact mailing country determines GDPR applicability, AML risk assessment, and regulatory jurisdiction for data privacy compliance. mailing_country is a denormalized country reference; linking to r',
    `tenant_id` BIGINT COMMENT 'Reference to the parent tenant profile to which this contact belongs. Supports both B2B corporate tenant hierarchies and B2C residential occupant households.',
    `access_card_number` STRING COMMENT 'Physical access card or key fob identifier issued to this contact for building entry. Tracked for security audit purposes and deactivated upon lease termination or contact status change.',
    `background_check_date` DATE COMMENT 'Date on which the most recent background screening was completed for this contact. Used to determine whether re-screening is required based on lease renewal cycles or portfolio policy.',
    `background_check_status` STRING COMMENT 'Current status of the background screening process for this contact. Required for residential lease qualification and corporate tenant key-person verification. Governed by FCRA requirements for adverse action notifications.. Valid values are `not_initiated|pending|passed|failed|waived`',
    `contact_role` STRING COMMENT 'Functional role of this contact in relation to the tenant account and lease. Drives routing logic for communications, work orders, and legal notices. [ENUM-REF-CANDIDATE: primary|authorized_signatory|emergency|billing|property_access|legal|guarantor|accounts_payable|facilities_manager — promote to reference product]',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Controls whether the contact is eligible to receive communications, service requests, and legal notices. do_not_contact enforces GDPR and CAN-SPAM opt-out obligations.. Valid values are `active|inactive|do_not_contact|deceased|archived`',
    `contact_type` STRING COMMENT 'Classification of the contact distinguishing between B2C residential household members and B2B corporate representatives, guarantors, and CRM-linked prospects. Drives data handling and communication workflows.. Valid values are `individual|household_member|corporate_representative|guarantor|prospect`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tenant contact record was first created in the Silver Layer lakehouse. Serves as the audit trail anchor for record lineage and GDPR data processing records.',
    `crm_contact_code` STRING COMMENT 'External identifier for this contact in Salesforce CRM, enabling bi-directional synchronization between the lakehouse tenant contact record and the CRM contact object for prospect pipeline and tenant relationship management.',
    `date_of_birth` DATE COMMENT 'Date of birth of the contact individual. Required for identity verification, background screening, credit checks, and age-restricted housing compliance (e.g., 55+ communities under HUD Fair Housing Act).',
    `department` STRING COMMENT 'Organizational department or business unit of the contact within their corporate entity (e.g., Real Estate, Finance, Legal, Operations). Supports routing of communications and service requests to the correct internal team.',
    `email` STRING COMMENT 'Primary business or personal email address for the contact. Used for lease notices, rent statements, work order updates, and CRM communications. Subject to GDPR consent and opt-out management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given (first) name of the individual contact person. Used in formal correspondence, lease documentation, and tenant service communications.',
    `gdpr_consent_date` DATE COMMENT 'Date on which the contact provided GDPR consent for personal data processing. Required for audit trail and regulatory compliance demonstration under GDPR Article 7.',
    `gdpr_consent_given` BOOLEAN COMMENT 'Indicates whether the contact has provided explicit consent for the processing of their personal data under GDPR Article 7. Mandatory for contacts in EU jurisdictions. Drives data processing eligibility and marketing communication permissions.',
    `is_authorized_signatory` BOOLEAN COMMENT 'Indicates whether this contact is authorized to execute lease agreements, amendments, and other binding legal documents on behalf of the tenant entity. Critical for DocuSign CLM workflow routing and SNDA agreement execution.',
    `is_emergency_contact` BOOLEAN COMMENT 'Indicates whether this contact should be notified in emergency situations such as building incidents, fire alarms, or urgent maintenance events. Used by Building Engines for emergency notification workflows.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary contact for the tenant account. Only one contact per tenant should carry this flag as True. Used to determine the default recipient for lease notices, invoices, and property management communications.',
    `job_title` STRING COMMENT 'Professional title or position of the contact within their organization (e.g., CFO, Facilities Manager, Legal Counsel). Critical for B2B corporate tenant hierarchies to identify decision-makers and authorized signatories.',
    `last_name` STRING COMMENT 'Family (last) name of the individual contact person. Combined with first_name to form the full legal name used in lease agreements and legal notices.',
    `mailing_address_line1` STRING COMMENT 'Primary street address line for mailing correspondence to the contact. Used for formal legal notices, lease documents, and certified mail as required under lease terms and applicable landlord-tenant law.',
    `mailing_address_line2` STRING COMMENT 'Secondary address line for suite, unit, floor, or care-of information for the contacts mailing address.',
    `mailing_city` STRING COMMENT 'City component of the contacts mailing address. Used in conjunction with state and postal code for legal notice delivery and geographic segmentation of tenant portfolios.',
    `mailing_postal_code` STRING COMMENT 'Postal or ZIP code for the contacts mailing address. Used for geographic routing of legal notices and demographic analysis of tenant populations.',
    `mailing_state_province` STRING COMMENT 'State or province component of the contacts mailing address using ISO 3166-2 subdivision codes. Determines applicable landlord-tenant law jurisdiction for legal notices.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the contact has opted in to receive marketing communications including property listings, investment opportunities, and promotional content. Distinct from operational communications which are governed by lease terms.',
    `middle_name` STRING COMMENT 'Middle name or initial of the contact person. Required for identity verification, background checks, and legal documentation such as lease execution and SNDA agreements.',
    `national_id_last4` STRING COMMENT 'Last four digits of the contacts government-issued national identifier (e.g., last 4 of SSN). Stored as a masked reference for identity verification workflows without retaining the full identifier in the Silver Layer.. Valid values are `^d{4}$`',
    `national_id_type` STRING COMMENT 'Type of government-issued national identifier provided by the contact for identity verification and background screening purposes (e.g., SSN, passport, drivers license). The actual identifier value is stored separately in a restricted vault.. Valid values are `ssn|passport|drivers_license|national_id|itin`',
    `notes` STRING COMMENT 'Free-text field for property managers and leasing agents to record relevant observations, special instructions, or relationship context about the contact. Synchronized from Salesforce CRM contact notes.',
    `phone_extension` STRING COMMENT 'Internal telephone extension associated with the contacts office phone number. Required for direct routing within large corporate tenant organizations.. Valid values are `^d{1,6}$`',
    `phone_mobile` STRING COMMENT 'Mobile (cell) phone number for the contact in E.164 international format. Primary channel for SMS notifications, two-factor authentication for tenant portal access, and urgent property management communications.. Valid values are `^+?[1-9]d{1,14}$`',
    `phone_office` STRING COMMENT 'Office or direct-dial business phone number for the contact in E.164 format. Used for formal business communications, lease negotiations, and property management inquiries for B2B corporate tenants.. Valid values are `^+?[1-9]d{1,14}$`',
    `portal_access_enabled` BOOLEAN COMMENT 'Indicates whether this contact has been granted access to the tenant self-service portal for submitting maintenance requests, viewing lease documents, and making rent payments. Managed through Yardi Voyager or MRI tenant portal modules.',
    `portal_username` STRING COMMENT 'Username or login identifier used by the contact to access the tenant self-service portal. Stored for account management and support purposes. Passwords are never stored in this product.',
    `preferred_comm_channel` STRING COMMENT 'The contacts preferred channel for receiving communications from property management, including lease notices, maintenance updates, and billing statements. Drives automated notification routing in Yardi Voyager and Building Engines.. Valid values are `email|sms|phone|mail|portal|fax`',
    `preferred_comm_language` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 country subtag) representing the contacts preferred language for all written and verbal communications. Supports multilingual tenant portfolios and GDPR-compliant consent documentation.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `property_access_level` STRING COMMENT 'Level of physical access granted to this contact for the leased property and building facilities. Used by Building Engines for access control management and security compliance. Relevant for contacts designated as property access contacts.. Valid values are `none|common_areas|leased_premises|full_building|restricted_zones`',
    `relationship_end_date` DATE COMMENT 'Date on which this contacts association with the tenant account was terminated or deactivated. Null for currently active contacts. Used for historical reporting and GDPR data retention scheduling.',
    `relationship_start_date` DATE COMMENT 'Date on which this contact was first associated with the tenant account. Supports WALT and WALE calculations for long-standing tenant relationships and tracks the duration of the contacts association with the portfolio.',
    `salutation` STRING COMMENT 'Formal salutation or honorific prefix used in written and verbal communications with the contact (e.g., Mr., Ms., Dr.).. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `secondary_email` STRING COMMENT 'Alternate email address for the contact, used as a fallback channel for critical communications such as lease expiry notices, emergency alerts, and billing statements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this tenant contact record. Used for change data capture (CDC) processing, incremental ETL loads, and audit compliance.',
    `yardi_contact_code` STRING COMMENT 'Source system identifier for this contact record as maintained in Yardi Voyager property management and lease administration modules. Used for reconciliation and lineage tracing.',
    CONSTRAINT pk_tenant_contact PRIMARY KEY(`tenant_contact_id`)
) COMMENT 'Individual contact persons associated with a tenant profile — primary contacts, authorized signatories, emergency contacts, billing contacts, and property access contacts. Supports both B2B corporate tenant hierarchies (multiple contacts per corporate entity) and B2C residential occupants (household members). Stores full name, role, phone, email, preferred communication channel, and CRM contact linkage.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`corporate_entity` (
    `corporate_entity_id` BIGINT COMMENT 'Unique surrogate identifier for the corporate entity record in the tenant domain. Primary key for the master record of a B2B corporate tenant or prospect.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Corporate entities are classified into B2B audience segments for commercial leasing acquisition campaigns. audience_segment has b2b_segment_flag and target_industry_sector. Standard commercial real es',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Corporate entity incorporation country drives KYC/AML compliance, foreign ownership rules, REIT eligibility, and tax treaty applicability for institutional tenants. incorporation_country is a denorm',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: Corporate tenant industry classification is required for credit risk tiering, anchor tenant eligibility, ESG sector reporting, and hazmat risk assessment. industry_sector is a denormalized represent',
    `parent_entity_corporate_entity_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent company in the corporate hierarchy. Enables enterprise-wide exposure tracking across subsidiaries, joint ventures, and affiliated entities leasing multiple premises.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Corporate entity registered address geographic hierarchy enables market-level corporate tenant reporting, regulatory jurisdiction assignment, and tax jurisdiction determination. Role-prefix registere',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Corporate tenant KYC, AML, and ESG compliance are governed by specific regulatory frameworks (e.g., GDPR, Dodd-Frank, local AML laws). Linking corporate_entity to regulatory_framework enables complian',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Corporate entity revenue currency is required for credit assessment, financial analysis, and multi-currency portfolio reporting. revenue_currency is a denormalized currency reference; role-prefix r',
    `annual_revenue_usd` DECIMAL(18,2) COMMENT 'Most recently reported annual gross revenue of the corporate entity in US dollars. Key input for credit underwriting, lease affordability analysis, and enterprise exposure assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corporate entity record was first created in the system. Supports data lineage, audit trail requirements, and SOX financial controls.',
    `credit_rating` STRING COMMENT 'Most recent credit rating assigned to the corporate entity by the designated credit rating agency (e.g., AAA, Baa2, BB+). Critical input for lease underwriting, security deposit determination, and portfolio risk management.',
    `credit_rating_agency` STRING COMMENT 'Name of the credit rating agency that issued the most recent credit rating for the corporate entity (e.g., Moodys, S&P, Fitch). Used alongside the credit rating score for lease underwriting.. Valid values are `Moodys|S&P|Fitch|DBRS|Kroll`',
    `credit_rating_date` DATE COMMENT 'Date on which the current credit rating was issued or last affirmed by the rating agency. Enables staleness detection and triggers re-underwriting workflows when ratings are outdated.',
    `credit_score` STRING COMMENT 'Numeric commercial credit score (e.g., Dun & Bradstreet PAYDEX or equivalent) for the corporate entity. Complements agency ratings for smaller entities not covered by major rating agencies.',
    `crm_account_code` STRING COMMENT 'External account identifier from the Salesforce CRM system linking this corporate entity to its CRM account record. Enables bi-directional synchronization of prospect pipeline, deal activity, and tenant relationship data.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System (DUNS) number uniquely identifying the corporate entity globally. Used for credit risk assessment, enterprise exposure tracking, and corporate hierarchy linkage.. Valid values are `^[0-9]{9}$`',
    `employee_headcount` STRING COMMENT 'Total number of full-time equivalent employees reported by the corporate entity. Used for space planning, lease sizing, and tenant creditworthiness assessment.',
    `entity_status` STRING COMMENT 'Current lifecycle status of the corporate entity within the tenant portfolio. Drives CRM pipeline management, lease eligibility, and reporting segmentation.. Valid values are `prospect|active|inactive|terminated|suspended`',
    `entity_type` STRING COMMENT 'Classification of the corporate entitys legal structure (e.g., corporation, LLC, partnership, REIT). Drives lease execution requirements and credit underwriting. [ENUM-REF-CANDIDATE: corporation|llc|partnership|reit|government|non_profit|sole_proprietorship — promote to reference product]',
    `esg_rating` STRING COMMENT 'Most recent Environmental, Social, and Governance (ESG) rating or score assigned to the corporate entity by a recognized ESG rating provider (e.g., MSCI, Sustainalytics). Supports sustainable leasing strategies and LEED/BREEAM-aligned tenant selection.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this entity within the corporate ownership hierarchy (1 = ultimate parent, 2 = subsidiary, 3 = sub-subsidiary, etc.). Supports roll-up exposure reporting and group-level lease analysis.',
    `hierarchy_type` STRING COMMENT 'Classification of the entitys role within the corporate ownership structure (e.g., ultimate parent, subsidiary, joint venture, affiliate). Used for enterprise exposure aggregation and group lease covenant analysis.. Valid values are `ultimate_parent|parent|subsidiary|joint_venture|affiliate`',
    `incorporation_date` DATE COMMENT 'Date on which the corporate entity was legally incorporated or registered with the relevant authority. Used for credit underwriting and entity age assessment.',
    `incorporation_state` STRING COMMENT 'U.S. state or equivalent sub-national jurisdiction in which the corporate entity was incorporated. Relevant for domestic entities subject to state-level regulatory requirements.',
    `is_publicly_traded` BOOLEAN COMMENT 'Indicates whether the corporate entitys securities are listed and traded on a public stock exchange. Publicly traded entities are subject to additional SEC disclosure and SOX compliance requirements.',
    `is_reit` BOOLEAN COMMENT 'Indicates whether the corporate entity is structured as a Real Estate Investment Trust (REIT). REITs are subject to specific SEC, IRS, and FASB reporting requirements that affect lease structuring and investment analysis.',
    `kyc_status` STRING COMMENT 'Current status of the Know Your Customer (KYC) due diligence process for the corporate entity. Required for anti-money laundering (AML) compliance, particularly for high-value commercial leases and investment transactions.. Valid values are `pending|in_progress|approved|rejected|expired`',
    `kyc_verified_date` DATE COMMENT 'Date on which the KYC due diligence verification was last completed and approved for the corporate entity. Triggers re-verification workflows when the verification period expires.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the corporate entity record was most recently modified. Supports change data capture, audit trail requirements, and data quality monitoring in the Databricks Silver Layer.',
    `legal_entity_name` STRING COMMENT 'Full registered legal name of the corporate entity as recorded with the relevant government or regulatory authority. Used for lease execution, invoicing, and compliance documentation.',
    `naics_code` STRING COMMENT 'Six-digit North American Industry Classification System (NAICS) code representing the corporate entitys primary business activity. Preferred over SIC for modern industry segmentation and analytics.. Valid values are `^[0-9]{6}$`',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact person at the corporate entity. Used for lease correspondence, CRM communications, and tenant service notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the corporate entity (e.g., CFO, Real Estate Director). Used for lease negotiations, CRM pipeline management, and tenant relationship management.',
    `primary_contact_phone` STRING COMMENT 'Direct business phone number of the primary contact person at the corporate entity. Used for lease negotiations, emergency communications, and tenant relationship management.',
    `registered_address_city` STRING COMMENT 'City of the corporate entitys official registered address. Used for jurisdictional compliance, tax nexus determination, and geographic portfolio analytics.',
    `registered_address_country` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the corporate entitys official registered address. Supports international portfolio management and cross-border compliance.. Valid values are `^[A-Z]{3}$`',
    `registered_address_line1` STRING COMMENT 'First line of the corporate entitys official registered address as filed with the relevant government authority. Used for legal notices, lease execution, and regulatory correspondence.',
    `registered_address_postal_code` STRING COMMENT 'Postal or ZIP code of the corporate entitys official registered address. Supports geographic analytics, market area mapping, and GIS-based portfolio reporting.',
    `registered_address_state` STRING COMMENT 'State or province of the corporate entitys official registered address. Used for state tax nexus, regulatory filings, and geographic segmentation.',
    `registration_number` STRING COMMENT 'Official company registration or incorporation number issued by the relevant state, national, or regulatory authority. Used for legal entity verification and compliance due diligence.',
    `revenue_fiscal_year` STRING COMMENT 'The fiscal year (four-digit integer) to which the reported annual revenue figure corresponds. Ensures temporal accuracy when comparing revenue across entities.',
    `sic_code` STRING COMMENT 'Four-digit Standard Industrial Classification (SIC) code identifying the primary industry sector of the corporate entity. Used for tenant mix analysis, portfolio diversification reporting, and market benchmarking.. Valid values are `^[0-9]{4}$`',
    `stock_exchange` STRING COMMENT 'Name of the primary stock exchange on which the corporate entitys securities are listed (e.g., NYSE, NASDAQ, LSE). Relevant for publicly traded tenants subject to SEC or equivalent regulatory oversight.. Valid values are `NYSE|NASDAQ|LSE|TSX|ASX|OTHER`',
    `stock_ticker` STRING COMMENT 'Exchange-listed stock ticker symbol for publicly traded corporate entities. Used for market data integration, credit monitoring, and investor relations tracking.. Valid values are `^[A-Z]{1,5}$`',
    `tax_identification_number` STRING COMMENT 'Government-issued Tax Identification Number (TIN) or Employer Identification Number (EIN) for the corporate entity. Required for lease execution, 1099 reporting, and regulatory compliance.',
    `trading_name` STRING COMMENT 'Operating or doing business as (DBA) name used by the corporate entity in day-to-day commercial activity, which may differ from the registered legal entity name.',
    `yardi_entity_code` STRING COMMENT 'Entity code assigned to the corporate tenant in Yardi Voyager, the primary property management and lease administration system of record. Used for AR, GL, and lease administration reconciliation.',
    CONSTRAINT pk_corporate_entity PRIMARY KEY(`corporate_entity_id`)
) COMMENT 'Master record for B2B corporate tenants capturing legal entity structure — parent company, subsidiaries, joint ventures, and affiliated entities. Stores DUNS number, SIC/NAICS industry code, annual revenue, employee headcount, publicly traded flag, stock ticker, credit rating agency scores, and corporate hierarchy linkage. Enables enterprise-wide exposure tracking across multiple leased premises for institutional and corporate occupiers.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`household` (
    `household_id` BIGINT COMMENT 'Unique system-generated identifier for the residential household grouping entity. Primary key for the household record across the tenant domain. Role: MASTER_PARTY — represents a collective residential party (household unit) that the business interacts with as a counterparty in residential leasing.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Residential households are classified into audience segments (e.g., young families, empty nesters) for targeted residential marketing and renewal campaigns. Standard residential real estate marketing ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Household financial fields (combined_annual_income, security_deposit_amount, hoa_fee_amount, pet_deposit_amount) require currency context for multi-currency residential portfolios and financial report',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Residential household geographic submarket assignment is required for HUD area median income calculations, fair housing compliance reporting, opportunity zone tracking, and residential portfolio marke',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Household fair_housing_protected_class_flag and accessibility_accommodation_required fields are governed by fair housing regulatory frameworks (FHA, ADA, state laws). Linking household to regulatory_f',
    `accessibility_accommodation_required` BOOLEAN COMMENT 'Indicates whether the household has requested a reasonable accommodation or modification under the Fair Housing Act due to a disability. Triggers ADA/FHA accommodation review workflow and unit modification tracking.',
    `adult_count` STRING COMMENT 'Number of adult occupants (age 18 or older) within the household. Used for lease signatory requirements, income qualification, and HUD occupancy compliance reporting.',
    `application_date` DATE COMMENT 'The date on which the household submitted a formal rental application. Marks the beginning of the applicant lifecycle stage and triggers background screening, credit check, and income verification workflows.',
    `approval_date` DATE COMMENT 'The date on which the households rental application was formally approved by the property management team. Used for lease execution timeline tracking and DocuSign CLM workflow initiation.',
    `background_check_status` STRING COMMENT 'Current status of the criminal and eviction background screening conducted for the household during the application process. Drives lease approval routing and adverse action notice generation per FCRA requirements.. Valid values are `pending|clear|adverse_action|waived`',
    `combined_annual_income` DECIMAL(18,2) COMMENT 'Total verified annual gross income across all income-contributing household members, expressed in the local currency. Used for rent-to-income ratio qualification, affordable housing eligibility, and credit underwriting. Typically verified against pay stubs, tax returns, or third-party income verification services.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which the household record was first created in the system. Satisfies MASTER_PARTY RECORD_AUDIT_CREATED category. Used for data lineage, audit trails, and SOX financial controls compliance.',
    `crm_prospect_code` STRING COMMENT 'Identifier linking the household to its originating prospect record in Salesforce CRM. Enables end-to-end prospect-to-tenant conversion tracking, pipeline analytics, and brokerage activity attribution.',
    `dependent_count` STRING COMMENT 'Number of minor dependents (under age 18) residing in the household. Used for HUD familial status fair housing compliance and unit amenity eligibility (e.g., playground access).',
    `eviction_history_flag` BOOLEAN COMMENT 'Indicates whether any member of the household has a prior eviction record identified during background screening. Used for lease approval risk assessment and adverse action documentation per FCRA and HUD guidance.',
    `fair_housing_protected_class_flag` BOOLEAN COMMENT 'Indicates whether the household has self-identified or been identified as belonging to one or more HUD-protected classes (race, color, national origin, religion, sex, familial status, disability). Used exclusively for fair housing compliance auditing and HUD reporting — NOT for leasing decisions.',
    `has_pets` BOOLEAN COMMENT 'Indicates whether the household has registered one or more pets. Triggers pet policy enforcement, pet deposit collection, and unit inspection scheduling. Required for fair housing compliance regarding assistance animals.',
    `hoa_fee_amount` DECIMAL(18,2) COMMENT 'Monthly HOA fee assessed to the household, expressed in the local currency. Applicable only when hoa_member is true. Used for AR billing, budget forecasting, and HOA financial reporting.',
    `hoa_member` BOOLEAN COMMENT 'Indicates whether the household is a member of a Homeowners Association (HOA). Drives HOA fee assessment, amenity access rights, and compliance with HOA covenants, conditions, and restrictions (CC&Rs).',
    `household_name` STRING COMMENT 'Human-readable label for the household, typically the primary leaseholders surname (e.g., Smith Household). Used as the IDENTITY_LABEL for the household party in reporting, correspondence, and CRM displays.',
    `household_type` STRING COMMENT 'Classification of the household composition and tenancy category. Drives fair housing compliance tracking, amenity eligibility, and portfolio segmentation. [ENUM-REF-CANDIDATE: single_family|multi_generational|roommate_group|corporate_relocation|student|senior|subsidized — promote to reference product]',
    `income_verification_status` STRING COMMENT 'Current status of the income verification process for the household. Tracks whether combined household income has been validated against supporting documentation as required for lease approval and affordable housing compliance.. Valid values are `pending|verified|failed|waived`',
    `language_preference` STRING COMMENT 'The households preferred language for communications and documentation, expressed as an ISO 639-1 two-letter language code (e.g., en, es, zh). Used for HUD Limited English Proficiency (LEP) compliance and localized communication delivery.',
    `lead_source` STRING COMMENT 'The originating channel through which the household was first acquired as a prospect. Used for marketing attribution, leasing channel ROI analysis, and brokerage commission tracking. [ENUM-REF-CANDIDATE: mls|referral|walk_in|online_listing|broker|corporate_relocation|social_media|other — promote to reference product]',
    `lifecycle_status` STRING COMMENT 'Current state of the household in the residential tenancy lifecycle, from initial prospect through active occupancy to vacated or archived. Drives workflow routing in Yardi Voyager and MRI Software. [ENUM-REF-CANDIDATE: prospect|applicant|approved|active|notice_given|vacated|evicted|archived — promote to reference product]',
    `move_in_date` DATE COMMENT 'The date on which the household physically took possession of and moved into the residential unit. Distinct from the lease commencement date; used for occupancy tracking, pro-rata rent calculation, and COA (Certificate of Occupancy) compliance.',
    `move_out_date` DATE COMMENT 'The date on which the household vacated the residential unit and returned possession to the property owner. Nullable for currently active households. Used for vacancy tracking, security deposit reconciliation, and WALE calculations.',
    `notice_to_vacate_date` DATE COMMENT 'The date on which the household formally submitted or received a notice to vacate the residential unit. Triggers lease termination workflows, unit turn scheduling, and re-leasing pipeline activation in Yardi Voyager.',
    `parking_spaces_assigned` STRING COMMENT 'Number of parking spaces formally assigned to the household under the lease or HOA agreement. Used for parking inventory management and revenue tracking for paid parking programs.',
    `pet_count` STRING COMMENT 'Total number of pets registered by the household under the lease agreement. Used to enforce pet policy limits, calculate pet deposits, and assess pet-related damage liability at move-out.',
    `pet_deposit_amount` DECIMAL(18,2) COMMENT 'Total pet deposit collected from the household for all registered pets, expressed in the local currency. Separate from the standard security deposit; subject to state statutory limits and refundability rules.',
    `preferred_contact_method` STRING COMMENT 'The households preferred channel for receiving communications from property management, including lease notices, maintenance updates, and billing statements. Used to route outbound communications in Yardi Voyager and Salesforce CRM.. Valid values are `email|phone|sms|portal|mail`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the households principal contact. Used for lease notices, rent statements, maintenance communications, and digital signature workflows via DocuSign CLM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full legal name of the primary leaseholder or head of household who serves as the principal point of contact for lease administration, rent collection, and communications. Satisfies MASTER_PARTY PRIMARY_CONTACT category.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the households principal contact. Used for emergency notifications, maintenance scheduling, and tenant relationship management in Salesforce CRM.. Valid values are `^+?[1-9]d{1,14}$`',
    `renters_insurance_required` BOOLEAN COMMENT 'Indicates whether the household is contractually required to maintain active renters insurance as a lease condition. Used for compliance tracking and lease enforcement workflows.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Total security deposit collected from the household at lease inception, expressed in the local currency. Subject to state statutory limits (typically 1–3 months rent). Tracked for escrow compliance and refund processing upon move-out.',
    `security_deposit_status` STRING COMMENT 'Current disposition status of the households security deposit. Tracks whether the deposit is being held in escrow, has been partially or fully refunded after move-out, or has been forfeited due to lease violations or damages.. Valid values are `held|partially_refunded|fully_refunded|forfeited`',
    `size` STRING COMMENT 'Total number of occupants residing in the household, including adults, dependents, and co-signers. Used for HUD fair housing compliance, occupancy standard enforcement, and unit sizing analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which the household record was most recently modified. Used for change data capture (CDC) in the Databricks lakehouse silver layer pipeline, audit trails, and data freshness monitoring.',
    `vehicle_count` STRING COMMENT 'Total number of vehicles registered by the household for parking assignment and access control. Used for parking space allocation, HOA parking rule enforcement, and towing policy compliance.',
    `yardi_household_code` STRING COMMENT 'External identifier for the household as recorded in Yardi Voyagers residential management module. Used for cross-system reconciliation between the lakehouse silver layer and the system of record.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Residential household grouping entity linking multiple individual occupants (adults, dependents, co-signers) to a single residential tenancy. Captures household composition, combined income, household size, pet ownership, vehicle registrations, and HOA membership status. Supports B2C residential portfolio management and fair housing compliance tracking per HUD requirements.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the tenant credit profile record. Primary key for the credit_profile data product within the tenant domain.',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: Credit profiles are maintained for corporate tenants as well as individuals. corporate_entity.credit_rating, credit_score confirm corporate credit assessment. Linking credit_profile.corporate_entity_i',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor entity (individual or corporate) associated with this credit profile when a guarantor is required. Links to the guarantor record for lease underwriting and documentation.',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Lease underwriting and ASC 842 risk assessment require tracing the credit profile used to approve a specific lease. Asset managers and credit committees need this link for portfolio risk reporting and',
    `security_deposit_id` BIGINT COMMENT 'Foreign key linking to lease.security_deposit. Business justification: Security deposit adequacy reviews and credit risk reporting require tracing the deposit amount back to the credit profile that determined it via security_deposit_multiplier. Auditors and risk managers',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Credit screening is governed by FCRA, fair housing laws, and state-specific screening regulations. Linking credit_profile to regulatory_framework enables adverse action compliance documentation, indiv',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Underwriting decisions on tenant credit profiles are made by a specific employee (credit analyst or underwriting manager). Fair Housing adverse action compliance and internal audit require linking eac',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant whose credit and financial qualification is captured in this profile. Links the credit profile to the authoritative tenant master record.',
    `adverse_action_date` DATE COMMENT 'Date on which the adverse action notice was sent to the tenant. Required for FCRA compliance tracking and regulatory audit purposes.',
    `adverse_action_notice_flag` BOOLEAN COMMENT 'Indicates whether an adverse action notice was issued to the tenant following a declined or conditioned underwriting decision, as required by the Fair Credit Reporting Act. True = adverse action notice sent. Critical for FCRA compliance.',
    `authorization_date` DATE COMMENT 'Date on which the tenant provided written authorization for the credit check. Establishes the legal basis for the credit inquiry under FCRA and GDPR consent requirements.',
    `authorization_document_ref` STRING COMMENT 'Reference identifier for the signed credit check authorization document stored in DocuSign CLM or the document management system. Supports audit trail and FCRA/GDPR compliance documentation.',
    `bankruptcy_chapter` STRING COMMENT 'Type of bankruptcy filing (e.g., Chapter 7 liquidation, Chapter 11 reorganization, Chapter 13 repayment plan). Relevant for commercial tenants where Chapter 11 reorganization may indicate ongoing business viability.. Valid values are `Chapter 7|Chapter 11|Chapter 13|Other`',
    `bankruptcy_discharge_date` DATE COMMENT 'Date on which the tenants bankruptcy was discharged, if applicable. Used to assess the elapsed time since discharge and determine eligibility under leasing underwriting policies that impose waiting periods post-bankruptcy.',
    `bankruptcy_flag` BOOLEAN COMMENT 'Indicates whether the tenant has a bankruptcy filing on record as reported by the credit bureau. True = bankruptcy history present. Used as a disqualifying or conditional factor in leasing underwriting decisions.',
    `bureau_name` STRING COMMENT 'Name of the third-party credit bureau that provided the credit report and score used for leasing underwriting. Supports multi-bureau comparison and audit traceability.. Valid values are `Equifax|Experian|TransUnion|Dun & Bradstreet|Other`',
    `bureau_reference_number` STRING COMMENT 'Externally assigned reference number returned by the credit bureau (e.g., Equifax, Experian, TransUnion) for the credit inquiry. Used to trace the report back to the originating bureau pull for audit and dispute resolution.',
    `collections_amount` DECIMAL(18,2) COMMENT 'Total outstanding balance across all accounts in collections as reported by the credit bureau. Provides a quantitative measure of the tenants delinquent debt exposure for underwriting risk assessment.',
    `collections_flag` BOOLEAN COMMENT 'Indicates whether the tenant has one or more accounts in collections as reported by the credit bureau. True = active or recent collections present. Used as a risk factor in leasing underwriting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit profile record was first created in the system. Establishes the audit trail start point for the credit qualification lifecycle.',
    `credit_authorization_flag` BOOLEAN COMMENT 'Indicates whether the tenant has provided explicit written authorization for the credit bureau check to be performed. True = authorization obtained. Required for FCRA compliance before initiating any credit inquiry.',
    `credit_check_date` DATE COMMENT 'Date on which the tenant authorized and the credit bureau check was performed. Establishes the temporal validity window of the credit report for leasing underwriting purposes.',
    `credit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which income, deposit, and financial qualification amounts on this credit profile are denominated (e.g., USD, GBP, EUR). Supports multi-currency portfolio operations.. Valid values are `^[A-Z]{3}$`',
    `credit_score` STRING COMMENT 'Numeric credit score returned by the credit bureau at the time of the credit check. Typically ranges from 300 to 850 for consumer (FICO/VantageScore) or equivalent commercial scoring range. Used as the primary quantitative input for leasing underwriting decisions.',
    `credit_score_model` STRING COMMENT 'Scoring model used by the credit bureau to generate the credit score (e.g., FICO 8, VantageScore 3.0). Required for accurate interpretation of the score range and underwriting thresholds.. Valid values are `FICO 8|FICO 9|VantageScore 3.0|VantageScore 4.0|Commercial|Other`',
    `credit_tier` STRING COMMENT 'Internal credit tier assigned based on the credit score and underwriting criteria. Tier A represents the highest creditworthiness; Tier F represents the lowest. Used to determine lease approval conditions, security deposit multipliers, and guarantor requirements.. Valid values are `A|B|C|D|F`',
    `dti_ratio` DECIMAL(18,2) COMMENT 'Ratio of the tenants total monthly debt obligations to gross monthly income, expressed as a decimal (e.g., 0.3500 = 35%). A key underwriting metric used to assess the tenants ability to service rent obligations alongside existing debt. Aligns with DTI as defined in common real estate financial qualification standards.',
    `eviction_count` STRING COMMENT 'Total number of prior eviction records identified for the tenant during the screening process. Provides granularity beyond the binary eviction flag for risk tiering and underwriting policy application.',
    `guarantor_required_flag` BOOLEAN COMMENT 'Indicates whether a personal or corporate guarantor is required as a condition of lease approval based on the tenants credit profile assessment. True = guarantor required. Drives lease structuring and documentation requirements.',
    `income_verification_method` STRING COMMENT 'Method used to verify the tenants income during the credit qualification process. Supports audit trail and underwriting documentation requirements.. Valid values are `pay_stub|tax_return|bank_statement|employer_letter|third_party_service|waived`',
    `income_verification_status` STRING COMMENT 'Status of the income verification process for the tenant. verified indicates income has been confirmed via pay stubs, tax returns, or bank statements; unverified indicates income was self-reported without documentation; pending indicates verification is in progress; waived indicates verification was waived per leasing policy.. Valid values are `verified|unverified|pending|waived`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit profile record. Supports change tracking, data lineage, and audit trail requirements in the Databricks Silver Layer.',
    `monthly_gross_income` DECIMAL(18,2) COMMENT 'Tenants verified gross monthly income in the operating currency, as submitted and validated during the credit qualification process. Used as the denominator in DTI calculation and the income-to-rent ratio assessment.',
    `outstanding_judgments_flag` BOOLEAN COMMENT 'Indicates whether the tenant has outstanding civil judgments (e.g., unpaid court-ordered debts) as identified in the credit or public records check. True = outstanding judgments present. A significant risk factor in leasing underwriting.',
    `prior_eviction_flag` BOOLEAN COMMENT 'Indicates whether the tenant has a prior eviction record as identified through the credit check or tenant screening process. True = prior eviction on record. A critical risk indicator in residential and commercial leasing underwriting.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the credit profile record. active indicates the profile is valid for underwriting; expired indicates the review expiry date has passed; pending indicates the credit check is in progress; withdrawn indicates the tenant withdrew consent; under_review indicates a dispute or re-evaluation is in progress.. Valid values are `active|expired|pending|withdrawn|under_review`',
    `recommended_max_rent` DECIMAL(18,2) COMMENT 'Maximum monthly rent amount recommended by the underwriting model based on the tenants verified income and DTI ratio. Typically calculated as a percentage of gross monthly income (e.g., 30% rule). Used by leasing agents to qualify tenants for specific units.',
    `review_expiry_date` DATE COMMENT 'Date on which the current credit profile assessment expires and a new credit check is required before lease execution or renewal. Typically set 30–90 days from the credit check date per leasing policy.',
    `security_deposit_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the monthly rent amount to calculate the required security deposit based on the tenants credit tier and risk profile (e.g., 1.00 = one months rent, 2.00 = two months rent). Drives lease financial structuring and AR setup in Yardi Voyager.',
    `source_system` STRING COMMENT 'Operational system of record from which this credit profile record was sourced or initiated (e.g., Yardi Voyager, MRI Software, Salesforce CRM). Supports data lineage and Silver Layer provenance tracking.. Valid values are `Yardi Voyager|MRI Software|Salesforce CRM|Manual|Other`',
    `tenant_type` STRING COMMENT 'Classification of the tenant as residential (B2C individual occupant) or commercial/industrial/retail (B2B corporate entity). Determines the applicable underwriting criteria, scoring model, and regulatory framework for the credit assessment.. Valid values are `residential|commercial|industrial|retail`',
    `underwriting_decision` STRING COMMENT 'Outcome of the leasing underwriting review based on the credit profile assessment. approved = tenant qualifies unconditionally; approved_with_conditions = tenant qualifies subject to guarantor, higher deposit, or other conditions; declined = tenant does not meet minimum credit criteria; pending = decision not yet rendered.. Valid values are `approved|approved_with_conditions|declined|pending`',
    `underwriting_decision_date` DATE COMMENT 'Date on which the underwriting decision was rendered for this credit profile. Used for audit trail, compliance reporting, and tracking decision turnaround times.',
    `underwriting_notes` STRING COMMENT 'Free-text notes entered by the underwriter or leasing manager documenting the rationale for the underwriting decision, any conditions imposed, or exceptions granted. Supports audit trail and Fair Housing Act compliance documentation.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Tenant credit and financial qualification record capturing credit bureau scores, credit check authorization date, debt-to-income ratio, income verification status, bankruptcy history, prior eviction flag, guarantor requirement flag, security deposit multiplier, and credit review expiry date. Sourced from third-party credit bureaus and stored as the authoritative credit qualification record per tenant for leasing underwriting decisions.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` (
    `tenant_prospect_id` BIGINT COMMENT 'Unique system-generated identifier for the tenant prospect record in the CRM-linked leasing pipeline. Primary key for the tenant_prospect data product.',
    `asset_id` BIGINT COMMENT 'Identifier of the property of interest that the prospect has inquired about or is being matched to within the leasing funnel.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Prospects are assigned to audience segments to drive personalized campaign targeting and nurture sequences. In real estate marketing, prospect segmentation by budget, unit preference, and geography is',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: A tenant prospect represented by a broker is associated with an active brokerage deal. Linking tenant_prospect to deal enables broker commission eligibility tracking, prospect-to-deal conversion repor',
    `brokerage_prospect_id` BIGINT COMMENT 'Foreign key linking to brokerage.prospect. Business justification: When a brokerage prospect converts to a tenant prospect, leasing teams must reference the originating brokerage prospect for commission attribution, deal sourcing, and pipeline conversion reporting. A',
    `buyer_representation_id` BIGINT COMMENT 'Foreign key linking to brokerage.buyer_representation. Business justification: A tenant prospect may be covered by a brokers tenant representation agreement. Linking tenant_prospect to buyer_representation enables commission eligibility verification, dual-agency conflict checks',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: Commercial prospects represent corporate entities in the leasing pipeline. tenant_prospect.company_name is denormalized from corporate_entity.legal_entity_name/trading_name. Linking tenant_prospect.co',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to tenant.credit_profile. Business justification: Prospects undergo preliminary credit checks during the leasing funnel. tenant_prospect.credit_check_status confirms credit evaluation occurs at the prospect stage. Linking tenant_prospect.credit_profi',
    `lead_id` BIGINT COMMENT 'External identifier for this prospect record as maintained in Salesforce CRM (Tenant and Prospect Management module). Used to cross-reference the leasing pipeline record with the originating CRM lead or contact object.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Prospect budget fields (budget_min_monthly, budget_max_monthly, budget_psf, expected_lease_value) require currency context for multi-currency portfolio pipeline reporting and deal sizing. A domain exp',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Pre-leasing is a core development activity. Construction lenders require pre-leasing covenant reporting by project. Leasing teams track prospect pipelines against specific development projects to fore',
    `digital_listing_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_listing. Business justification: Prospects inquire via specific digital marketing listings. Linking prospect to digital_listing enables listing-level lead generation reporting and digital marketing ROI analysis. tenant_prospect has l',
    `employee_id` BIGINT COMMENT 'Identifier of the leasing agent or broker assigned to manage this prospect through the pipeline. Links to the workforce or brokerage agent record.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Prospect geographic preference is a core leasing pipeline attribute enabling submarket demand analysis, market absorption reporting, and leasing strategy by geographic tier. geographic_preference is',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: Residential prospects are often household groups. household.crm_prospect_id (STRING) confirms the household-prospect relationship exists. Linking tenant_prospect.household_id → household.household_id ',
    `lease_agreement_id` BIGINT COMMENT 'Identifier of the lease record created upon successful conversion of this prospect to a tenant. Null while the prospect is still in the pipeline. Enables end-to-end traceability from prospect inquiry to executed lease.',
    `loi_id` BIGINT COMMENT 'Foreign key linking to lease.loi. Business justification: Deal pipeline tracking requires linking a prospect record to the LOI issued to them. Leasing teams report on prospect-to-LOI conversion rates and track LOI status per prospect. loi_issued_date on tena',
    `listing_id` BIGINT COMMENT 'Identifier of the specific property listing (unit or space) that the prospect expressed interest in, linking to the brokerage listing record.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Prospect pipeline segmentation by market segment drives leasing strategy, budget forecasting, and conversion rate reporting by investment strategy type. Leasing teams track which market segment each p',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial leasing pipeline management requires tracking which specific suite/space a prospect is interested in. Leasing agents use this for space availability dashboards, tour scheduling, and pipelin',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Prospects express interest in specific lease structures (gross, NNN, modified gross). Linking to reference.lease_type enables pipeline analysis by lease structure, informs LOI preparation, and support',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Prospect space use type preference determines CAM applicability, TI allowance benchmarks, and lease structure options. unit_type_preference is a denormalized space use type; linking to reference.spa',
    `tenant_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant. Business justification: When a prospect converts to a tenant, the tenant_prospect record should link to the resulting tenant profile. Linking tenant_prospect.profile_id → tenant.profile_id enables conversion tracking from pr',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential leasing pipeline tracks prospect interest at the specific unit level (e.g., Apt 4B). Leasing managers use unit-level prospect tracking for availability management, showing schedules, and c',
    `application_submitted_date` DATE COMMENT 'Date on which the prospect formally submitted a tenancy application. Marks the transition from prospect to applicant in the leasing lifecycle and triggers credit and background screening workflows.',
    `background_check_status` STRING COMMENT 'Status of the background screening process for the prospect. Tracks whether a background check has been initiated, is pending, passed, failed, or waived. Applicable primarily to residential prospects post-application.. Valid values are `not_initiated|pending|passed|failed|waived`',
    `budget_max_monthly` DECIMAL(18,2) COMMENT 'Prospects maximum acceptable monthly rent budget in the portfolios base currency. Defines the upper bound of the prospects affordability range for residential unit matching and pricing negotiations.',
    `budget_min_monthly` DECIMAL(18,2) COMMENT 'Prospects minimum acceptable monthly rent budget in the portfolios base currency. Used for unit matching and pricing strategy. Applicable primarily to residential prospects where monthly rent is the standard pricing unit.',
    `budget_psf` DECIMAL(18,2) COMMENT 'Prospects target rent budget expressed as a Per Square Foot (PSF) rate. Primarily used for commercial leasing where rent is quoted on a PSF basis. Enables direct comparison against asking rents in the CoStar market data.',
    `conversion_probability_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0.00–100.00%) that this prospect will convert to a signed lease. Assigned by the leasing agent or derived from CRM scoring models. Used for pipeline forecasting and leasing velocity reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tenant prospect record was first created in the system. Supports audit trail requirements, pipeline velocity measurement, and SOX financial controls for publicly traded REITs.',
    `credit_check_status` STRING COMMENT 'Status of the credit screening process for the prospect. Tracks whether a credit check has been initiated, is pending results, has passed, failed, or been waived. Relevant after application submission stage.. Valid values are `not_initiated|pending|passed|failed|waived`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary budget fields on this prospect record (e.g., USD, EUR, GBP). Ensures consistent financial reporting across multi-currency portfolios.. Valid values are `^[A-Z]{3}$`',
    `desired_lease_term_months` STRING COMMENT 'Prospects preferred lease duration expressed in months. Used to assess fit with available lease structures and to inform Weighted Average Lease Term (WALT) projections for the portfolio.',
    `desired_move_in_date` DATE COMMENT 'Prospects preferred or requested commencement date for occupancy. Used for unit availability matching, lease scheduling, and Weighted Average Lease Expiry (WALE) planning.',
    `desired_size_max_sqft` DECIMAL(18,2) COMMENT 'Maximum acceptable space size in square feet (SQF) as specified by the prospect. Used alongside desired_size_min_sqft to define the prospects space requirement range for inventory matching.',
    `desired_size_min_sqft` DECIMAL(18,2) COMMENT 'Minimum acceptable space size in square feet (SQF) as specified by the prospect. Used for unit matching against available Gross Leasable Area (GLA) and Net Leasable Area (NLA) inventory.',
    `email` STRING COMMENT 'Primary email address of the prospect or their designated contact person. Used for leasing communications, document delivery via DocuSign CLM, and CRM campaign tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_lease_value` DECIMAL(18,2) COMMENT 'Estimated total lease value for the prospects anticipated tenancy, calculated as the product of expected monthly rent, lease term, and any known escalations. Used for pipeline revenue forecasting and portfolio planning.',
    `follow_up_date` DATE COMMENT 'Next scheduled follow-up date for the assigned leasing agent to contact the prospect. Used for CRM task management and pipeline activity tracking to ensure timely engagement.',
    `inquiry_date` DATE COMMENT 'Date on which the prospect first made contact or submitted an inquiry for a property or unit. Marks the entry point into the leasing funnel and is used to measure pipeline velocity and lead response time.',
    `is_marketing_consent` BOOLEAN COMMENT 'Indicates whether the prospect has provided explicit consent to receive marketing communications from the leasing team. Required for GDPR-compliant outreach and CRM campaign targeting.',
    `lead_source` STRING COMMENT 'Channel or origin through which the prospect was acquired. Tracks marketing attribution across digital (website, social media, email campaign), listing platforms (CoStar, MLS), broker referrals, and direct walk-in inquiries. [ENUM-REF-CANDIDATE: website|referral|costar|mls|broker|walk_in|social_media|email_campaign|direct_mail|event — promote to reference product]',
    `lead_source_detail` STRING COMMENT 'Supplementary detail describing the specific lead source, such as the referring broker name, campaign name, listing platform URL, or event name. Provides granularity beyond the lead_source category for marketing attribution analysis.',
    `lost_reason` STRING COMMENT 'Reason code explaining why the prospect was lost or disqualified from the leasing pipeline. Populated when pipeline_status is lost or disqualified. Used for pipeline loss analysis and leasing strategy improvement. [ENUM-REF-CANDIDATE: price|location|size|competitor|financing|timing|no_response|credit_fail|withdrew|other — promote to reference product]',
    `phone` STRING COMMENT 'Primary contact phone number for the prospect. Used for leasing agent outreach, tour scheduling, and follow-up communications throughout the pipeline.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `pipeline_notes` STRING COMMENT 'Free-text notes entered by the leasing agent capturing key interactions, prospect preferences, negotiation points, or other contextual information relevant to advancing the prospect through the pipeline.',
    `pipeline_stage` STRING COMMENT 'Current stage of the prospect in the leasing funnel pipeline. Tracks progression from initial inquiry through tour, application, Letter of Intent (LOI) issuance, lease negotiation, and final execution or disqualification. [ENUM-REF-CANDIDATE: inquiry|tour_scheduled|application_submitted|loi_issued|lease_negotiation|lease_executed|lost|withdrawn — promote to reference product]',
    `pipeline_status` STRING COMMENT 'Current lifecycle status of the prospect record within the leasing pipeline. Indicates whether the prospect is actively being pursued, placed on hold, converted to a tenant, or lost/disqualified.. Valid values are `active|on_hold|converted|lost|disqualified`',
    `preferred_contact_method` STRING COMMENT 'Prospects preferred channel for receiving communications from the leasing team. Supports GDPR-compliant communication preferences and improves engagement rates in the CRM pipeline.. Valid values are `email|phone|sms|portal|in_person`',
    `prospect_name` STRING COMMENT 'Full legal name of the prospective tenant individual or primary contact person for a corporate tenant prospect. Used for identification and communication throughout the leasing funnel.',
    `prospect_type` STRING COMMENT 'Classification of the prospect by intended use category, distinguishing between residential occupants and commercial, industrial, retail, mixed-use, or government tenants. Drives pipeline workflow and leasing terms applicable.. Valid values are `residential|commercial|industrial|retail|mixed_use|government`',
    `segment` STRING COMMENT 'Business segment classification of the prospect, distinguishing B2B corporate tenants (enterprise or SME) from B2C individual residential occupants, nonprofits, and government entities. Supports targeted leasing strategies and CRM segmentation.. Valid values are `b2b_corporate|b2c_individual|b2b_sme|b2b_enterprise|nonprofit|government`',
    `special_requirements` STRING COMMENT 'Free-text field capturing any specific requirements or preferences stated by the prospect, such as accessibility needs, parking requirements, fit-out specifications, Tenant Improvement (TI) expectations, or amenity preferences.',
    `tour_completed_date` DATE COMMENT 'Date on which the property or unit tour was actually completed by the prospect. Distinct from tour_scheduled_date to capture no-shows and rescheduling. Used to measure conversion from tour to application.',
    `tour_scheduled_date` DATE COMMENT 'Date on which a property or unit tour is scheduled for the prospect. Null if no tour has been arranged. Used to track pipeline progression from inquiry to physical showing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tenant prospect record. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit trail compliance.',
    CONSTRAINT pk_tenant_prospect PRIMARY KEY(`tenant_prospect_id`)
) COMMENT 'CRM-linked prospect pipeline record for prospective tenants in the leasing funnel. Captures lead source, inquiry date, property of interest, unit type preference, desired move-in date, budget range (PSF or monthly), pipeline stage (inquiry, tour scheduled, application submitted, LOI issued, lease negotiation), assigned leasing agent, and conversion probability. Bridges brokerage activity and tenant onboarding.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`application` (
    `application_id` BIGINT COMMENT 'Unique system-generated identifier for the tenancy application record. Primary key for the application data product within the tenant domain.',
    `asset_id` BIGINT COMMENT 'Reference to the property against which this application has been submitted, linking to the property master record.',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: Commercial tenancy applications are submitted by corporate entities. application.company_name and tax_id are denormalized from corporate_entity.legal_entity_name/trading_name and tax_identification_nu',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Lease applications for new development units must be tracked against the specific development project for pre-leasing covenant compliance reporting to construction lenders and for project-level absorp',
    `digital_listing_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_listing. Business justification: Tracking which digital marketing listing generated an application is a standard listing performance and marketing attribution metric in real estate. Enables digital listing conversion rate reporting. ',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: application.guarantor_required: BOOLEAN indicates that a guarantor may be required as part of the application. When a guarantor is identified during the application process, application.guarantor_id →',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: For residential portfolio applications, the applicant represents a household group. household has application_date and approval_date fields confirming it participates in the application process. Linki',
    `lead_id` BIGINT COMMENT 'Foreign key linking to marketing.lead. Business justification: Lead-to-application conversion is the core leasing funnel metric. Marketing teams track which lead converted to a submitted application for campaign ROI and attribution reporting. No existing column o',
    `loi_id` BIGINT COMMENT 'Foreign key linking to lease.loi. Business justification: Deal pipeline tracking requires linking the formal application to the LOI that preceded it. Leasing agents and asset managers use this to trace the full deal lifecycle from LOI through application to ',
    `listing_id` BIGINT COMMENT 'Foreign key linking to brokerage.listing. Business justification: A tenant application is submitted against a specific listed space. Leasing teams track listing-to-application conversion rates, verify application terms match listing terms, and generate listing perfo',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Application market segment classification drives underwriting criteria, approval authority thresholds, and portfolio strategy reporting. portfolio_type on application is a plain attr that partially ',
    `negotiation_instrument_id` BIGINT COMMENT 'Foreign key linking to brokerage.negotiation_instrument. Business justification: A tenant application formally follows a Letter of Intent. Linking application to the LOI record enables deal progression tracking (LOI→application→lease), term consistency verification, and commission',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial lease applications are submitted for a specific leasable suite/space. Lease administration and underwriting require the application to reference the exact space for CAM pro-rata calculation',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease applications specify the requested lease structure which determines CAM responsibility, opex treatment, and ASC 842/IFRS 16 classification. requested_lease_type is a denormalized lease type re',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lease application approval workflows require tracking which employee (leasing agent or manager) reviewed and approved/declined each application for audit trails, Fair Housing compliance, and leasing a',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Applications are for specific space use types (office, retail, industrial, residential) which determine CAM recovery rules, TI allowance benchmarks, and lease structure options. A domain expert expect',
    `tenant_contact_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_contact. Business justification: An application may be submitted by a specific authorized signatory or primary contact associated with the tenant profile. Linking application.tenant_contact_id → tenant_contact.tenant_contact_id ident',
    `tenant_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant. Business justification: An application submitted by a prospect results in a tenant profile upon approval. Linking application.profile_id → tenant.profile_id allows tracking which tenant profile was created from or associated',
    `tenant_prospect_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_prospect. Business justification: An application is submitted by a prospect tracked in the in-domain tenant_prospect pipeline. tenant_prospect.application_submitted_date confirms this relationship. Linking application.tenant_prospect_',
    `unit_id` BIGINT COMMENT 'Reference to the specific unit or premises within the property for which the tenancy application has been submitted.',
    `annual_income` DECIMAL(18,2) COMMENT 'Declared annual gross income of the applicant (individual) or annual gross revenue (corporate). Used to calculate Debt-to-Income Ratio (DTI) and assess rent affordability against standard income-to-rent thresholds (typically 3x monthly rent).',
    `applicant_email` STRING COMMENT 'Primary email address of the applicant used for application correspondence, status notifications, and DocuSign lease execution workflows.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_legal_name` STRING COMMENT 'Full legal name of the primary applicant as it appears on government-issued identification or corporate registration documents. For corporate applicants, this is the registered legal entity name.',
    `applicant_phone` STRING COMMENT 'Primary contact phone number for the applicant, used for screening interviews, verification calls, and application status communication.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `applicant_type` STRING COMMENT 'Classification of the applicant entity type. Individual: natural person (B2C residential occupant); Corporate: legal business entity (B2B commercial tenant); Guarantor: third-party financial guarantor supporting the primary applicant; Co-applicant: joint applicant sharing tenancy obligations.. Valid values are `individual|corporate|guarantor|co_applicant`',
    `application_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to the tenancy application at submission. Used in all correspondence with applicants and approval authorities (e.g., APP-2024-000123).. Valid values are `^APP-[0-9]{4}-[0-9]{6}$`',
    `application_status` STRING COMMENT 'Current lifecycle state of the tenancy application within the qualification workflow. Valid states: submitted (received but not yet reviewed), under_review (active screening in progress), approved (qualified and approved for lease execution), declined (application rejected), withdrawn (applicant voluntarily withdrew).. Valid values are `submitted|under_review|approved|declined|withdrawn`',
    `background_check_status` STRING COMMENT 'Status of the criminal and rental history background check conducted on the applicant. Pending: check initiated but not complete; Passed: no disqualifying findings; Failed: disqualifying findings identified; Waived: check waived per policy (e.g., existing tenant renewal).. Valid values are `pending|passed|failed|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the application record was first created in the data platform. Used for audit trail and data lineage purposes.',
    `credit_score` STRING COMMENT 'The credit score of the individual or corporate applicant obtained from a credit bureau (e.g., Equifax, Experian, TransUnion) during the screening process. Used to assess creditworthiness against minimum thresholds defined in the leasing policy.',
    `crm_opportunity_code` STRING COMMENT 'The Salesforce CRM opportunity or deal record identifier linked to this tenancy application. Enables bi-directional traceability between the formal application workflow and the brokerage deal pipeline.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts on this application (e.g., USD, EUR, GBP, CAD). Supports multi-currency portfolio operations and financial consolidation in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `decision_date` DATE COMMENT 'The date on which a final approval or decline decision was rendered on the application by the designated approval authority. Drives SLA compliance tracking and applicant notification timelines.',
    `decline_reason_code` STRING COMMENT 'Standardized reason code explaining why the application was declined. Required for FCRA adverse action notices and Fair Housing compliance reporting. [ENUM-REF-CANDIDATE: insufficient_income|poor_credit|criminal_history|incomplete_docs|rental_history|guarantor_declined|unit_unavailable|policy_violation — promote to reference product]',
    `dti_ratio` DECIMAL(18,2) COMMENT 'The Debt-to-Income Ratio (DTI) calculated during the screening process, expressed as a decimal (e.g., 0.35 = 35%). Measures the applicants total monthly debt obligations relative to gross monthly income. Key underwriting metric for residential applications.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The non-refundable application processing fee charged to the applicant at submission. Covers credit screening, background check, and administrative processing costs. Tracked in Yardi Voyager Accounts Receivable.',
    `fee_paid` BOOLEAN COMMENT 'Indicates whether the application processing fee has been received and confirmed. Applications with unpaid fees may be placed on hold pending payment confirmation in Yardi Voyager AR.',
    `financial_docs_checklist` STRING COMMENT 'Structured checklist of financial documents submitted by the applicant as part of the qualification package. Tracks submission status of required documents such as bank statements, tax returns, pay stubs, audited financials, and corporate financial statements. Stored as a serialized status string (e.g., bank_statements:Y|tax_returns:Y|pay_stubs:N).',
    `free_rent_months_requested` STRING COMMENT 'Number of rent-free months requested by the applicant as a lease incentive concession. Common in commercial leasing during tenant fit-out periods. Impacts EGI (Effective Gross Income) and NOI calculations in Argus Enterprise.',
    `guarantor_required` BOOLEAN COMMENT 'Indicates whether a personal or corporate guarantor is required as a condition of application approval, typically triggered when the applicants credit score or income does not meet minimum standalone qualification thresholds.',
    `portfolio_type` STRING COMMENT 'Indicates whether the application pertains to a commercial or residential portfolio, driving applicable screening criteria, regulatory requirements, and lease structures.. Valid values are `commercial|residential`',
    `proposed_base_rent_monthly` DECIMAL(18,2) COMMENT 'The monthly base rent amount proposed by the applicant in the application. Represents the gross base rent before CAM charges, operating expense pass-throughs, or percentage rent adjustments. Used in deal pipeline valuation and NOI (Net Operating Income) forecasting.',
    `proposed_lease_end_date` DATE COMMENT 'The applicants requested lease expiry date. Drives WALT (Weighted Average Lease Term) calculations, portfolio planning, and WALE (Weighted Average Lease Expiry) reporting.',
    `proposed_lease_start_date` DATE COMMENT 'The applicants requested lease commencement date. Used in scheduling unit availability, coordinating tenant improvement (TI) work, and planning lease execution timelines.',
    `proposed_lease_term_months` STRING COMMENT 'The total duration of the proposed lease in months as requested by the applicant. Used for WALT analysis, lease expiry scheduling, and investment portfolio modeling in Argus Enterprise.',
    `proposed_rent_psf` DECIMAL(18,2) COMMENT 'The proposed annual rent rate expressed on a Per Square Foot (PSF) basis. Standard commercial real estate pricing metric used for market comparables (CMA), CoStar benchmarking, and deal negotiation.',
    `reference_check_status` STRING COMMENT 'Status of the landlord and personal reference verification process. Completed: all required references contacted and verified; Pending: references not yet contacted; Not Required: waived per leasing policy (e.g., corporate tenant with established credit).. Valid values are `pending|completed|not_required`',
    `requested_gla_sqft` DECIMAL(18,2) COMMENT 'The total Gross Leasable Area (GLA) in square feet (SQF) requested by the applicant. For commercial tenants, this drives PSF (Per Square Foot) rent calculations, CAM (Common Area Maintenance) allocations, and space planning.',
    `requested_nla_sqft` DECIMAL(18,2) COMMENT 'The Net Leasable Area (NLA) in square feet requested by the applicant, excluding common areas and structural elements. Used for net rent calculations and space efficiency analysis.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'The security deposit amount required as a condition of application approval, typically expressed as a multiple of monthly base rent. Tracked in Yardi Voyager for trust accounting and state-mandated security deposit compliance.',
    `source_channel` STRING COMMENT 'The channel through which the tenancy application was originated. Online Portal: self-service web application; Broker Referral: submitted via a licensed broker; Direct Inquiry: direct contact with leasing team; MLS (Multiple Listing Service): originated from MLS listing; Walk-in: in-person inquiry; Corporate Relocation: employer-sponsored relocation program.. Valid values are `online_portal|broker_referral|direct_inquiry|mls|walk_in|corporate_relocation`',
    `submission_date` DATE COMMENT 'The calendar date on which the tenancy application was formally submitted by the applicant. Represents the principal business event date for the application lifecycle.',
    `ti_allowance_requested` DECIMAL(18,2) COMMENT 'The Tenant Improvement (TI) allowance amount requested by the applicant for fit-out or renovation of the premises. A key commercial lease negotiation term tracked in the deal pipeline and CAPEX planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the application record was most recently modified. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `yardi_application_ref` STRING COMMENT 'The native application record identifier from Yardi Voyager Lease Administration module. Enables reconciliation between the lakehouse silver layer and the operational system of record for audit and data lineage purposes.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Formal tenancy application submitted by a prospect or existing tenant for a specific unit or premises. Captures application date, applicant type (individual, corporate, guarantor), requested GLA/NLA, proposed lease term, submitted financial documents checklist, application fee amount, application status (submitted, under review, approved, declined, withdrawn), decline reason code, and approval authority. Tracks the formal qualification workflow prior to lease execution.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` (
    `tenant_occupancy_id` BIGINT COMMENT 'Unique system-generated identifier for each occupancy record. Serves as the primary key for the occupancy data product, uniquely identifying a tenants physical possession of a specific unit or premises for a defined period.',
    `application_id` BIGINT COMMENT 'Foreign key linking to tenant.application. Business justification: An occupancy record is created as the result of an approved application. Linking occupancy.application_id → application.application_id traces the occupancy back to its originating application, enablin',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Occupancy area measurement standard (BOMA, IPMS, GLA, NLA) is required for lease compliance, rent calculation, and valuation reporting. area_measurement_standard is a denormalized UOM reference; lin',
    `asset_id` BIGINT COMMENT 'Reference to the parent property or building in which the occupied unit resides. Enables portfolio-level occupancy reporting and aggregation across all units within a property.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Property management operations assign a specific employee (property manager or inspector) to each occupancy for move-in/move-out inspections, key handovers, and ongoing management. Workload reporting ',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: Occupancy commencement is a standard commission trigger event in brokerage deals. Linking occupancy to the originating deal enables final commission payment processing, deal performance reporting, and',
    `claim_id` BIGINT COMMENT 'Foreign key linking to insurance.claim. Business justification: Move-out inspections frequently identify tenant-caused property damage that triggers an insurance claim against the tenants policy or the landlords property policy. Linking occupancy to the resultin',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tenant occupancy must be backed by a valid Certificate of Occupancy permit. Property managers verify COO validity before tenant move-in. The occupancy record already stores coo_reference and coo_issue',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: Residential occupancy records are associated with household groups. occupancy.num_occupants and portfolio_type confirm residential household occupancy. Linking occupancy.household_id → household.house',
    `owner_ownership_interest_id` BIGINT COMMENT 'Foreign key linking to owner.ownership_interest. Business justification: In co-ownership and JV structures, rental income from each occupancy must be attributed to the correct ownership interest for distribution calculations, K-1 tax reporting, and NOI attribution. Linking',
    `parking_id` BIGINT COMMENT 'Foreign key linking to property.parking. Business justification: Tenant occupancy records allocate parking bays from a specific parking facility. Property managers need this link for parking facility utilization reporting, CAM cost allocation, and move-in/move-out ',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Investment portfolio asset records require direct linkage to occupancy records for WALT/WALE calculation, stabilized NOI verification, and LP investor reporting. Portfolio managers and asset managers ',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial occupancy records must reference the specific leased space for CAM reconciliation, space utilization reporting, and lease administration. occupancy has unit_id (residential) and asset_id bu',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Occupied space use type determines CAM recovery eligibility, operating expense responsibility, and ASC 842/IFRS 16 right-of-use asset classification. A domain expert expects space use type on the occu',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant or occupant holding physical possession of the premises. Links to the tenant master record in the tenant domain, supporting both B2B corporate tenants and B2C residential occupants.',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Occupancy tenure type (leasehold, license, holdover, month-to-month) determines legal rights, valuation methodology, CMBS eligibility, and ASC 842/IFRS 16 lease classification. A domain expert expects',
    `unit_id` BIGINT COMMENT 'Reference to the specific property unit, suite, or premises being physically occupied. Identifies the exact space within the portfolio that is under possession.',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: NNN lease tax recovery billing: property accountants must reconcile which tenant occupancy records correspond to each tax assessment period to allocate recoverable tax charges. The tax_assessment has ',
    `access_card_count` STRING COMMENT 'The number of physical access cards or digital access credentials issued to the tenant for the occupied premises. Used for building security management, key control audits, and move-out reconciliation.',
    `asset_class` STRING COMMENT 'The real estate asset class of the occupied property. Determines applicable lease structures, CAM (Common Area Maintenance) obligations, and industry benchmarking comparables. [ENUM-REF-CANDIDATE: office|retail|industrial|multifamily|mixed_use|hospitality|land|healthcare|self_storage|data_center — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this occupancy record was first created in the system. Supports audit trail requirements, data lineage tracking, and SOX financial controls compliance.',
    `effective_from` TIMESTAMP COMMENT 'The timestamp from which this version of the occupancy record is considered current and valid in the silver layer. Supports slowly changing dimension (SCD) Type 2 history management and point-in-time portfolio reporting.',
    `effective_until` TIMESTAMP COMMENT 'The timestamp until which this version of the occupancy record is considered current and valid. Null indicates the current active version. Supports SCD Type 2 history management and historical portfolio occupancy reporting.',
    `end_date` DATE COMMENT 'The date on which the tenant vacated or is scheduled to vacate the premises. Nullable for active occupancies with no confirmed end date. Used for WALE (Weighted Average Lease Expiry) calculations and re-leasing pipeline planning.',
    `floor_number` STRING COMMENT 'The floor or level within the building on which the occupied premises are located. Supports building operations, emergency evacuation planning, and space utilisation analytics. Stored as STRING to accommodate designations such as G, B1, M, PH.',
    `holdover_start_date` DATE COMMENT 'The date on which the tenant transitioned into holdover status, i.e., the day after the original lease or occupancy end date. Populated only when is_holdover is True. Used to calculate holdover duration and associated penalty rent periods.',
    `is_holdover` BOOLEAN COMMENT 'Flag indicating whether the tenant is currently in holdover status — continuing to occupy the premises after the lease expiry date without a new or renewed lease agreement. Triggers holdover rent calculations and legal notification workflows.',
    `is_sublease` BOOLEAN COMMENT 'Flag indicating whether this occupancy record represents a sublease arrangement where the occupying tenant is not the primary leaseholder. Supports sublease tracking, consent management, and NNN (Triple Net Lease) obligation pass-through analysis.',
    `key_handover_date` DATE COMMENT 'The date on which physical keys, access cards, or digital access credentials were formally handed over to the tenant at commencement, or returned by the tenant at vacation. Critical for establishing the precise moment of physical possession transfer.',
    `move_in_condition_rating` STRING COMMENT 'Standardised rating of the premises condition at the time of tenant move-in, as recorded during the move-in inspection. Establishes the baseline for dilapidations assessment at move-out and supports deposit reconciliation.. Valid values are `excellent|good|fair|poor`',
    `move_in_inspection_date` DATE COMMENT 'The date on which the pre-occupancy condition inspection of the premises was conducted. Establishes the baseline condition of the unit at the time of handover to the tenant, supporting deposit reconciliation and maintenance liability determination.',
    `move_out_condition_rating` STRING COMMENT 'Standardised rating of the premises condition at the time of tenant move-out, as recorded during the move-out inspection. Compared against move_in_condition_rating to determine dilapidations liability and deposit deduction amounts.. Valid values are `excellent|good|fair|poor`',
    `move_out_inspection_date` DATE COMMENT 'The date on which the post-occupancy condition inspection of the premises was conducted upon tenant vacation. Used to assess dilapidations, damage beyond fair wear and tear, and to support deposit deduction decisions.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, or contextual information related to this occupancy record that is not captured by structured fields. Used by property managers for reference checks, tenant lifecycle documentation, and re-leasing intelligence.',
    `num_occupants` STRING COMMENT 'The total number of individuals or employees physically occupying the premises. Used for density analysis, building services planning, HVAC (Heating Ventilation and Air Conditioning) load calculations, and ESG (Environmental Social and Governance) reporting.',
    `occupancy_status` STRING COMMENT 'Current lifecycle state of the occupancy record. active indicates the tenant is in physical possession; vacated indicates the tenant has surrendered possession; pending_handover indicates keys have not yet been formally exchanged; holdover indicates possession continues beyond the agreed end date; terminated indicates the occupancy was ended early; scheduled indicates a future occupancy not yet commenced.. Valid values are `active|vacated|pending_handover|holdover|terminated|scheduled`',
    `occupancy_type` STRING COMMENT 'Classification of the nature of physical possession. primary indicates the main lease-backed occupancy; sublease indicates a sub-tenant arrangement; holdover indicates continued possession after lease expiry without a new agreement; license indicates a short-term or non-exclusive right to occupy; co_occupancy indicates shared possession; temporary indicates a short-term or interim arrangement.. Valid values are `primary|sublease|holdover|license|co_occupancy|temporary`',
    `occupied_area_sqf` DECIMAL(18,2) COMMENT 'The actual net leasable area (NLA) physically occupied by the tenant, measured in square feet (SQF). May differ from the leased area if partial occupation, expansion, or contraction has occurred. Used for PSF (Per Square Foot) analytics and portfolio occupancy rate calculations.',
    `occupied_area_sqm` DECIMAL(18,2) COMMENT 'The actual net leasable area (NLA) physically occupied by the tenant, measured in square metres (SQM). Supports international portfolio reporting and compliance with IFRS 16 disclosures for non-US properties.',
    `parking_bays_allocated` STRING COMMENT 'The number of parking bays or spaces allocated to the tenant as part of the occupancy arrangement. Supports facility operations planning, parking revenue tracking, and tenant service management.',
    `portfolio_type` STRING COMMENT 'Indicates whether this occupancy record relates to a commercial or residential property. Drives applicable regulatory frameworks (e.g., ASC 842 vs residential tenancy law), reporting structures, and tenant lifecycle management processes.. Valid values are `commercial|residential`',
    `premises_identifier` STRING COMMENT 'The human-readable identifier of the specific suite, unit, or premises being occupied (e.g., Suite 1201, Unit 4B, Bay 3). Complements the unit_id system reference with the operational label used in correspondence and building directories.',
    `ref_number` STRING COMMENT 'Externally-known business identifier for this occupancy record, used in correspondence, inspection reports, and operational systems such as Yardi Voyager and Building Engines. Distinct from the system-generated primary key.',
    `scheduled_vacate_date` DATE COMMENT 'The contractually agreed or operationally planned date by which the tenant is expected to vacate the premises. May differ from the actual end_date if the tenant vacates early or holds over. Used for re-leasing planning and portfolio vacancy forecasting.',
    `source_system` STRING COMMENT 'The operational system of record from which this occupancy record was sourced. Supports data lineage, reconciliation, and audit trail requirements across the lakehouse silver layer.. Valid values are `yardi|mri|building_engines|manual|other`',
    `source_system_ref` STRING COMMENT 'The native identifier of this occupancy record in the originating operational system (e.g., Yardi Voyager occupancy ID, MRI occupancy code). Enables traceability and reconciliation between the lakehouse silver layer and the system of record.',
    `start_date` DATE COMMENT 'The date on which the tenant took physical possession of the premises. This is the actual commencement of occupancy, which may differ from the lease commencement date due to fit-out periods, early access, or delayed handover.',
    `ti_completed` BOOLEAN COMMENT 'Flag indicating whether all agreed Tenant Improvement (TI) works were completed prior to or during the occupancy commencement. Supports CAPEX (Capital Expenditure) tracking, lease incentive accounting under ASC 842/IFRS 16, and handover readiness confirmation.',
    `ti_completion_date` DATE COMMENT 'The date on which all Tenant Improvement (TI) works were formally completed and signed off. Used to reconcile TI allowance disbursements, confirm lease commencement triggers, and support CAPEX project close-out in Procore.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this occupancy record was most recently modified. Supports change tracking, audit trail requirements, and incremental data pipeline processing in the Databricks lakehouse silver layer.',
    `vacate_reason_code` STRING COMMENT 'Standardised code indicating the reason the tenant vacated the premises. Supports tenant lifecycle analytics, re-leasing strategy, and churn analysis. [ENUM-REF-CANDIDATE: lease_expiry|early_termination|default|relocation|downsizing|upsizing|business_closure|eviction|mutual_agreement — promote to reference product]',
    `vacate_reason_notes` STRING COMMENT 'Free-text narrative providing additional context for the vacate reason beyond the standardised code. Captures qualitative intelligence for tenant relationship management and re-leasing decisions.',
    CONSTRAINT pk_tenant_occupancy PRIMARY KEY(`tenant_occupancy_id`)
) COMMENT 'Active and historical occupancy record linking a tenant to a specific property unit or premises for a defined period. Captures occupancy start date, end date, occupancy type (primary, sublease, holdover, license), actual occupied area (SQF/SQM), certificate of occupancy reference, move-in and move-out inspection dates, key handover date, occupancy status, and vacate reason code. Serves as the SSOT for physical possession across the entire portfolio — both current and historical — distinct from the legal lease agreement owned by the lease domain. Supports tenant lifecycle analytics, re-leasing decisions, reference checks, and portfolio occupancy reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`guarantor` (
    `guarantor_id` BIGINT COMMENT 'Unique system-generated identifier for the guarantor record. Primary key for the guarantor entity within the tenant domain.',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: Guarantors may be corporate entities (parent companies guaranteeing subsidiary leases, banks issuing letters of credit). guarantor.is_foreign_entity and lc_issuing_bank confirm corporate guarantor sce',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the specific lease instrument that this guarantor is co-signing or guaranteeing. Supports lease underwriting and guarantee enforcement workflows.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Guarantor credit qualification reviews are conducted by a specific employee (credit analyst or leasing manager). Audit trails for guarantor approval decisions and Fair Housing compliance require linki',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant record for whom this guarantor is providing a guarantee. Links the guarantor to the primary lessee in the tenant domain.',
    `address_line1` STRING COMMENT 'First line of the guarantors legal mailing or registered address. Used for legal notices, guarantee enforcement correspondence, and identity verification.',
    `address_line2` STRING COMMENT 'Second line of the guarantors legal mailing or registered address (suite, unit, floor, or additional address detail). Optional field.',
    `annual_income` DECIMAL(18,2) COMMENT 'Declared or verified annual gross income of the guarantor. For individual guarantors, used to assess debt-to-income (DTI) ratio and ability to cover lease obligations. For corporate guarantors, represents annual revenue.',
    `cash_deposit_account` STRING COMMENT 'Reference to the escrow or trust account holding the cash deposit when guarantee_instrument_type is cash_deposit. Used for deposit tracking, interest accrual, and return-of-deposit workflows.',
    `city` STRING COMMENT 'City of the guarantors legal mailing or registered address. Used for legal notices and jurisdictional compliance.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the guarantors legal address or country of incorporation. Identifies foreign guarantors, which may require additional underwriting scrutiny and SNDA considerations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantor record was first created in the system. Supports audit trail, data lineage, and SOX compliance requirements.',
    `credit_bureau` STRING COMMENT 'Name of the credit reporting agency or rating agency from which the guarantors credit score or creditworthiness rating was obtained. [ENUM-REF-CANDIDATE: Equifax|Experian|TransUnion|Dun_and_Bradstreet|Moody|SP_Global|other — promote to reference product]',
    `credit_qualification_status` STRING COMMENT 'Outcome of the credit underwriting review for this guarantor: approved (meets credit standards), conditionally_approved (approved with conditions), declined (does not meet standards), pending_review (under assessment), or expired (prior approval has lapsed and requires renewal).. Valid values are `approved|conditionally_approved|declined|pending_review|expired`',
    `credit_review_date` DATE COMMENT 'Date on which the most recent credit qualification review was completed for this guarantor. Used to determine whether the credit assessment is current and to schedule renewal reviews.',
    `credit_score` STRING COMMENT 'Numeric credit score obtained from a credit bureau for individual guarantors, or an equivalent creditworthiness rating for corporate guarantors. Used in lease underwriting and portfolio credit risk assessment. Typically FICO score range 300–850 for individuals.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the guaranteed amount (e.g., USD, EUR, GBP). Supports multi-currency portfolios and international tenant guarantors.. Valid values are `^[A-Z]{3}$`',
    `document_ref_number` STRING COMMENT 'Reference number of the executed guarantee instrument document as recorded in DocuSign CLM or the contract lifecycle management system. Enables direct retrieval of the signed guarantee agreement.',
    `dti_ratio` DECIMAL(18,2) COMMENT 'Debt-to-Income (DTI) ratio calculated for individual guarantors, expressed as a percentage of monthly debt obligations to gross monthly income. Used in residential lease underwriting to assess guarantors capacity to cover the guaranteed obligation.',
    `effective_date` DATE COMMENT 'Date on which the guarantee instrument becomes legally binding and enforceable. Typically aligned with the lease commencement date or execution date of the guarantee agreement.',
    `execution_date` DATE COMMENT 'Date on which the guarantee instrument was formally signed and executed by the guarantor. Distinct from the effective date; used for document management and legal enforceability tracking in DocuSign CLM.',
    `expiry_date` DATE COMMENT 'Date on which the guarantee instrument expires and the guarantors obligation terminates. Null for open-ended guarantees that run for the full lease term. Critical for guarantee renewal tracking and portfolio credit risk management.',
    `guarantee_instrument_type` STRING COMMENT 'Type of financial instrument used to secure the guarantee obligation: personal guarantee (individual liability), letter of credit (bank-issued), surety bond (insurance-backed), cash deposit (held in escrow), or corporate guarantee (entity-level obligation).. Valid values are `personal_guarantee|letter_of_credit|surety_bond|cash_deposit|corporate_guarantee`',
    `guarantee_notes` STRING COMMENT 'Free-text field for underwriters and property managers to record special conditions, exceptions, or observations related to the guarantee instrument. Supports lease underwriting documentation and guarantee enforcement context.',
    `guarantee_status` STRING COMMENT 'Current lifecycle state of the guarantee instrument: active (in force), expired (past expiry date), released (landlord released guarantor), called (guarantee has been drawn upon), pending (awaiting execution), or cancelled.. Valid values are `active|expired|released|called|pending|cancelled`',
    `guaranteed_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount the guarantor is liable for under the guarantee instrument. Applicable when the guarantee is capped at a specific dollar value rather than a percentage of the total lease obligation. Used in portfolio credit risk assessment.',
    `guaranteed_pct` DECIMAL(18,2) COMMENT 'Percentage of the total lease obligation covered by this guarantors guarantee. Used when the guarantee is expressed as a proportion of total rent rather than a fixed amount. Supports partial guarantee structures common in commercial leases.',
    `guarantor_type` STRING COMMENT 'Classification of the guarantor entity: individual (personal guarantor), corporate (company guarantor), institutional (bank or fund), government, or trust. Drives underwriting and credit qualification workflows.. Valid values are `individual|corporate|institutional|government|trust`',
    `is_foreign_entity` BOOLEAN COMMENT 'Indicates whether the guarantor is a foreign individual or entity (incorporated or domiciled outside the domestic jurisdiction). Foreign guarantors typically require enhanced underwriting, additional security instruments, and SNDA agreements.',
    `lc_expiry_date` DATE COMMENT 'Expiry date of the letter of credit as stated on the LC instrument. May differ from the guarantee expiry date if the LC has a shorter term and requires periodic renewal. Critical for proactive renewal management.',
    `lc_issuing_bank` STRING COMMENT 'Name of the financial institution that issued the letter of credit, when guarantee_instrument_type is letter_of_credit. Required for LC verification, renewal tracking, and draw procedures.',
    `lc_number` STRING COMMENT 'Unique reference number assigned by the issuing bank to the letter of credit instrument. Used for LC draw requests, renewals, and bank correspondence when guarantee_instrument_type is letter_of_credit.',
    `legal_name` STRING COMMENT 'Full legal name of the guarantor as it appears on the guarantee instrument and identity documents. For individuals, this is the full given and family name; for entities, the registered legal entity name.',
    `net_worth` DECIMAL(18,2) COMMENT 'Declared or verified net worth of the guarantor at the time of credit qualification. Represents total assets minus total liabilities. Key underwriting metric for assessing guarantor financial strength relative to the guaranteed lease obligation.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the guarantors legal mailing or registered address.',
    `primary_email` STRING COMMENT 'Primary email address for the guarantor, used for legal notices, guarantee-related correspondence, and CRM communications in Salesforce. Required for digital execution workflows in DocuSign CLM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary contact phone number for the guarantor in E.164 international format. Used for lease underwriting communications and guarantee enforcement contact.. Valid values are `^+?[1-9]d{1,14}$`',
    `ref_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this guarantor record, used in Yardi Voyager and MRI Software for cross-system identification and correspondence.',
    `relationship_to_tenant` STRING COMMENT 'Nature of the relationship between the guarantor and the primary tenant. Used in lease underwriting to assess the strength and reliability of the guarantee. [ENUM-REF-CANDIDATE: parent|spouse|sibling|employer|investor|parent_company|other — promote to reference product]',
    `release_date` DATE COMMENT 'Date on which the landlord formally released the guarantor from their obligation, prior to the natural expiry date. Populated only when guarantee_status is released. Supports legal compliance and audit trail requirements.',
    `state_province` STRING COMMENT 'State or province of the guarantors legal mailing or registered address. Used for jurisdictional determination of guarantee enforceability and applicable law.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the guarantor. For individuals, this is the Social Security Number (SSN) or Individual Taxpayer Identification Number (ITIN); for entities, the Employer Identification Number (EIN) or equivalent. Used for credit checks and IRS reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantor record was most recently modified. Used for change tracking, data synchronization, and audit trail compliance.',
    `yardi_guarantor_code` STRING COMMENT 'Source system identifier for this guarantor record as assigned in Yardi Voyager. Used for data lineage, reconciliation, and cross-system integration between the lakehouse silver layer and the operational property management system.',
    CONSTRAINT pk_guarantor PRIMARY KEY(`guarantor_id`)
) COMMENT 'Guarantor record for tenants requiring a co-signer or financial guarantor on a lease — common in residential tenancies for students/first-time renters and for corporate tenants with insufficient credit history or foreign entities. Captures guarantor type (individual, corporate, institutional), legal name, tax ID, relationship to tenant, guaranteed amount or percentage of lease obligation, guarantee instrument type (personal guarantee, letter of credit, surety bond, cash deposit), guarantee effective and expiry dates, credit qualification status, and guarantor contact details. Supports lease underwriting, guarantee enforcement, and portfolio credit risk assessment.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique system-generated identifier for each tenant or prospect interaction record. Primary key for the interaction data product within the tenant domain.',
    `application_id` BIGINT COMMENT 'Foreign key linking to tenant.application. Business justification: Interactions occur during the application process — status update calls, document request follow-ups, decision communications. Linking interaction.application_id → application.application_id connects ',
    `arrears_event_id` BIGINT COMMENT 'Foreign key linking to tenant.arrears_event. Business justification: Interactions frequently occur in the context of rent arrears — collection calls, payment plan discussions, cure period follow-ups. Linking interaction.arrears_event_id → arrears_event.arrears_event_id',
    `asset_id` BIGINT COMMENT 'Reference to the property that is the subject of this interaction, such as a site tour, lease inquiry, or service escalation tied to a specific building or unit.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: Tenant interactions (negotiations, LOI discussions, site tours) are conducted in the context of specific brokerage deals. Linking interaction to deal enables deal-stage communication tracking, broker ',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or outreach campaign that generated or is associated with this interaction, enabling campaign attribution and ROI analysis for leasing and prospect conversion programs.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to insurance.claim. Business justification: Tenant interactions frequently involve insurance claim communications — damage reports, claim status follow-ups, adjuster visit coordination, and settlement discussions. Linking interaction to claim e',
    `employee_id` BIGINT COMMENT 'Reference to the internal staff member (property manager, asset manager, or leasing agent) assigned to conduct or own this interaction. Supports CRM pipeline visibility and workload tracking.',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: Property managers interact directly with guarantors — guarantee execution discussions, payment demands, guarantee release negotiations. Linking interaction.guarantor_id → guarantor.guarantor_id enable',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: For residential tenants, interactions may be with the household group rather than an individual profile. Linking interaction.household_id → household.household_id enables household-level interaction t',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the active or prospective lease record that this interaction relates to, enabling lease lifecycle tracking and communication audit trail per ASC 842 / IFRS 16.',
    `negotiation_instrument_id` BIGINT COMMENT 'Foreign key linking to brokerage.negotiation_instrument. Business justification: Interactions (meetings, calls, emails) are frequently conducted in the context of a specific LOI negotiation round. Linking interaction to the LOI record enables negotiation activity tracking, deal ti',
    `notice_id` BIGINT COMMENT 'Foreign key linking to tenant.notice. Business justification: Interactions often follow up on formal notices (e.g., a call after a notice to vacate, a meeting to discuss a rent increase notice). Linking interaction.notice_id → notice.notice_id connects the inter',
    `retention_action_id` BIGINT COMMENT 'Foreign key linking to tenant.retention_action. Business justification: Retention campaigns generate interactions (outreach calls, renewal meetings). retention_action.crm_activity_id (STRING) confirms CRM activity linkage. Linking interaction.retention_action_id → retenti',
    `screening_id` BIGINT COMMENT 'Foreign key linking to tenant.screening. Business justification: Interactions occur in the context of screening processes — adverse action discussions, screening result communications, individualized assessment meetings. Linking interaction.screening_id → screening',
    `service_request_id` BIGINT COMMENT 'Reference to a maintenance service request that is the subject of this interaction, linking tenant communications to facility operations work orders for end-to-end resolution tracking.',
    `tenant_contact_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_contact. Business justification: Interactions are with specific tenant contacts. interaction.contact_name, contact_email, contact_phone are denormalized from tenant_contact. Linking interaction.tenant_contact_id → tenant_contact.tena',
    `tenant_id` BIGINT COMMENT 'Reference to the active tenant associated with this interaction. Populated when the interaction is with a current lease-holding occupant rather than a prospect.',
    `tenant_occupancy_id` BIGINT COMMENT 'Foreign key linking to tenant.occupancy. Business justification: Interactions occur in the context of specific occupancy periods — move-in coordination, move-out scheduling, holdover discussions. Linking interaction.occupancy_id → occupancy.occupancy_id connects in',
    `tenant_prospect_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_prospect. Business justification: Interactions (calls, tours, emails) occur with prospects tracked in the in-domain tenant_prospect pipeline. interaction.deal_stage confirms prospect-stage interactions are tracked. Linking interaction',
    `attachment_count` STRING COMMENT 'Number of documents, images, or files attached to this interaction record (e.g., lease proposals, inspection photos, signed LOIs). Supports document completeness checks and audit trail.',
    `channel` STRING COMMENT 'Communication medium through which the interaction was conducted. Supports channel mix analytics and CRM pipeline reporting. [ENUM-REF-CANDIDATE: phone|email|in_person|portal_message|site_tour|video_call|sms|mail — promote to reference product if additional channels are required]. Valid values are `phone|email|in_person|portal_message|site_tour|video_call`',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether the content of this interaction is legally privileged or commercially sensitive (e.g., lease negotiation terms, legal dispute discussions). Restricts access to authorized personnel only.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this interaction record was first created in the system. Serves as the audit creation timestamp for data lineage, SOX controls, and GDPR accountability obligations.',
    `crm_activity_code` STRING COMMENT 'External identifier of the corresponding activity or task record in Salesforce CRM, enabling bi-directional reconciliation between the lakehouse silver layer and the CRM system of record.',
    `deal_stage` STRING COMMENT 'CRM pipeline stage of the associated deal or prospect at the time of this interaction. Enables pipeline velocity analysis and conversion funnel reporting. Aligned with Salesforce CRM deal pipeline stages. [ENUM-REF-CANDIDATE: prospecting|qualification|proposal|negotiation|lease_execution|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `direction` STRING COMMENT 'Indicates whether the interaction was initiated by the tenant or prospect (inbound) or by the relationship manager or property team (outbound). Critical for CRM pipeline and tenant engagement analytics.. Valid values are `inbound|outbound`',
    `duration_minutes` STRING COMMENT 'Length of the interaction in minutes. Applicable to phone calls, video calls, in-person meetings, and site tours. Supports relationship manager productivity analytics and tenant engagement scoring.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this interaction has been escalated to senior management, legal, or a specialized team due to a complaint, dispute, or service failure. Triggers escalation workflow in Building Engines or Salesforce CRM.',
    `escalation_reason` STRING COMMENT 'Narrative explanation of why this interaction was escalated, such as unresolved maintenance complaint, lease dispute, or legal matter. Populated only when escalation_flag is True.',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up action must be completed. Populated when follow_up_required is True. Used for SLA tracking and relationship manager task management.',
    `follow_up_notes` STRING COMMENT 'Specific instructions or context for the required follow-up action, such as items to prepare for a lease renewal meeting or documents to send to a prospect after a site tour.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up action or communication is required after this interaction. Drives task creation in CRM and ensures no tenant or prospect inquiry falls through the cracks.',
    `interaction_date` DATE COMMENT 'Calendar date on which the interaction took place. Used for scheduling, SLA measurement, and communication frequency reporting. Distinct from the record audit timestamp.',
    `interaction_status` STRING COMMENT 'Current lifecycle state of the interaction record. Tracks whether the interaction has been completed, is still in progress, was cancelled, or resulted in a no-show (e.g., missed site tour).. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `interaction_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the interaction occurred, including timezone offset. Used for audit trail, SLA breach detection, and time-of-day analytics.',
    `interaction_type` STRING COMMENT 'Business classification of the interaction purpose. Distinguishes between leasing inquiries, service escalations, renewal discussions, site tours, and general communications. [ENUM-REF-CANDIDATE: inquiry|complaint|service_request|lease_discussion|renewal_discussion|tour|general_communication|payment_dispute|move_out_notice — promote to reference product]',
    `language_code` STRING COMMENT 'ISO 639-1 or BCP 47 language code indicating the language in which the interaction was conducted (e.g., en, es, fr). Supports multilingual tenant portfolio management and compliance with HUD language access requirements.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `location_description` STRING COMMENT 'Free-text description of where the interaction took place, such as a specific building address, leasing office, virtual meeting link reference, or tenant suite number. Relevant for in-person meetings and site tours.',
    `loi_referenced` BOOLEAN COMMENT 'Indicates whether a Letter of Intent (LOI) was discussed, presented, or referenced during this interaction. Supports deal pipeline tracking and lease origination audit trail.',
    `outcome` STRING COMMENT 'Result or disposition of the interaction at its conclusion. Indicates whether the matter was resolved, requires escalation, resulted in a lease conversion, or needs a follow-up action.. Valid values are `resolved|escalated|pending|no_action|follow_up_scheduled|converted`',
    `participant_count` STRING COMMENT 'Total number of participants involved in the interaction, including both internal staff and external parties (tenants, prospects, brokers). Relevant for group meetings, site tours, and multi-party lease discussions.',
    `priority` STRING COMMENT 'Business priority level assigned to the interaction, used to triage tenant complaints, service escalations, and lease renewal discussions. Drives SLA and response time targets.. Valid values are `low|medium|high|urgent`',
    `satisfaction_score` STRING COMMENT 'Numeric satisfaction rating provided by the tenant or prospect following the interaction, typically on a 1–5 or 1–10 scale. Supports tenant experience KPIs and Net Promoter Score (NPS) programs.',
    `sentiment` STRING COMMENT 'Qualitative assessment of the tenant or prospect sentiment observed during the interaction, as recorded by the relationship manager. Supports tenant satisfaction monitoring and early churn risk identification.. Valid values are `positive|neutral|negative`',
    `source_record_code` STRING COMMENT 'Native identifier of this interaction record in the originating source system (e.g., Salesforce Activity ID, Building Engines ticket number). Enables cross-system reconciliation and deduplication.',
    `source_system` STRING COMMENT 'Operational system of record from which this interaction record originated. Supports data lineage, reconciliation, and audit trail requirements across the lakehouse silver layer.. Valid values are `salesforce_crm|yardi_voyager|building_engines|mri_software|manual`',
    `subject` STRING COMMENT 'Brief headline or subject line summarizing the topic of the interaction, analogous to an email subject line. Supports search, filtering, and quick review in CRM dashboards.',
    `summary` STRING COMMENT 'Narrative description of the interaction content, key discussion points, and context. Provides the communication audit trail required for tenant relationship management and regulatory compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this interaction record was last modified. Supports change data capture (CDC) in the Databricks lakehouse silver layer and audit trail requirements.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Record of all tenant and prospect interactions — calls, emails, meetings, portal messages, site tours, and service escalations. Captures interaction date, channel, direction (inbound/outbound), subject, summary, outcome, follow-up required flag, assigned relationship manager, and linked prospect or active tenant. Supports tenant relationship management, CRM pipeline visibility, and communication audit trail.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`notice` (
    `notice_id` BIGINT COMMENT 'Unique system-generated identifier for the formal notice record. Primary key for the tenant.notice data product in the Databricks Silver Layer.',
    `arrears_event_id` BIGINT COMMENT 'Foreign key linking to tenant.arrears_event. Business justification: Notices are frequently triggered by arrears events — notice to pay or quit, demand letters, eviction notices. arrears_event tracks first_notice_date, second_notice_date, demand_letter_date confirming ',
    `asset_id` BIGINT COMMENT 'Reference to the property (commercial or residential) to which this notice applies. Supports portfolio-level notice tracking and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the internal staff member (property manager, asset manager, or leasing agent) who issued or recorded this notice. Supports audit trail and accountability tracking.',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: Notices may be issued to guarantors (demand for payment, guarantee enforcement notices). Linking notice.guarantor_id → guarantor.guarantor_id enables guarantor-specific notice tracking, supporting gua',
    `owner_agreement_id` BIGINT COMMENT 'Foreign key linking to owner.owner_agreement. Business justification: Notices (rent increases, defaults, vacate) must comply with notice periods and escalation requirements defined in the owners management agreement. Property managers verify notice terms against the ow',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Lease notices (vacate, default, rent increase) for commercial tenants must reference the specific leased space for legal validity and lease administration. notice has unit_id (residential) and asset_i',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Notices (eviction, default, rent increase, renewal) are governed by jurisdiction-specific regulatory frameworks (rent control ordinances, eviction moratoriums, notice period laws). Linking notice to r',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: Lease administration requires tracking the formal written notice exercising a specific renewal option. Critical deadline management process: property managers must link the exercise notice to the rene',
    `screening_id` BIGINT COMMENT 'Foreign key linking to tenant.screening. Business justification: Adverse action notices are a required output of the screening process (FCRA compliance). notice.notice_type can be adverse_action. Linking notice.screening_id → screening.screening_id connects the a',
    `tenant_contact_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_contact. Business justification: Formal notices are addressed to specific tenant contacts (authorized signatories, primary contacts). Linking notice.tenant_contact_id → tenant_contact.tenant_contact_id identifies the specific contact',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant or prospect record associated with this notice. Links to the tenant master profile in the tenant domain.',
    `tenant_occupancy_id` BIGINT COMMENT 'Foreign key linking to tenant.occupancy. Business justification: Notices (notice to vacate, move-out notice, holdover notice) are directly related to specific occupancy records. notice.vacate_date confirms occupancy-related notices. Linking notice.occupancy_id → oc',
    `unit_id` BIGINT COMMENT 'Reference to the specific rentable unit (commercial suite or residential unit) to which this notice applies, where the notice is unit-specific rather than property-wide.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this notice record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail, data lineage, and SOX compliance.',
    `cure_deadline_date` DATE COMMENT 'The date by which the tenant must remedy or cure the identified default or violation to avoid further legal action, applicable for cure/default notices. Distinct from the statutory response deadline.',
    `cured_flag` BOOLEAN COMMENT 'Indicates whether the tenant has successfully cured the default or violation identified in a cure/default notice prior to the cure deadline. True = cured; False = not cured or not applicable.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to any monetary amounts on this notice record (e.g., USD, CAD, GBP). Supports multi-currency portfolio management.. Valid values are `^[A-Z]{3}$`',
    `default_description` STRING COMMENT 'Narrative description of the lease default, HOA violation, or breach of covenant that triggered the notice, applicable for cure/default notices, termination notices, and HOA violation notices. Supports litigation readiness.',
    `delivery_confirmation_date` DATE COMMENT 'The date on which delivery of the notice was confirmed, such as the date a certified mail receipt was signed or a portal read receipt was generated. Supports statutory compliance and litigation documentation.',
    `delivery_confirmed` BOOLEAN COMMENT 'Indicates whether delivery of the notice has been confirmed through a receipt, read receipt, certified mail tracking, or in-person acknowledgement. True = delivery confirmed; False = delivery unconfirmed or pending.',
    `delivery_method` STRING COMMENT 'The channel or mechanism used to deliver the notice to the recipient, as required by applicable landlord-tenant statutes. Supports statutory compliance verification and litigation readiness.. Valid values are `certified_mail|email|tenant_portal|in_person|courier|posting`',
    `delivery_tracking_reference` STRING COMMENT 'External tracking identifier for the notice delivery, such as a USPS certified mail tracking number, courier waybill number, or portal message thread ID. Supports proof-of-delivery documentation for litigation readiness.',
    `digital_signature_reference` STRING COMMENT 'Reference identifier for the digital signature envelope or transaction in DocuSign CLM or equivalent contract lifecycle management system, linking the notice to its executed digital signature record.',
    `direction` STRING COMMENT 'Indicates whether the notice was issued by the landlord/property manager to the tenant (outbound) or received from the tenant (inbound). Critical for litigation readiness and statutory compliance tracking.. Valid values are `inbound|outbound`',
    `document_reference` STRING COMMENT 'Reference to the physical or digital document file associated with this notice, such as a document management system path, SharePoint URL, or Yardi document attachment ID.',
    `effective_date` DATE COMMENT 'The date on which the notice takes legal effect, such as the date a rent increase becomes operative or the date a vacate notice requires the tenant to have vacated the premises.',
    `estoppel_due_date` DATE COMMENT 'The date by which the tenant must return the completed and signed estoppel certificate, applicable when notice_type is estoppel_request. Supports transaction closing timelines and CMBS compliance.',
    `estoppel_requested_by` STRING COMMENT 'Name of the party (lender, buyer, or investor) requesting an estoppel certificate from the tenant, applicable when notice_type is estoppel_request. Supports transaction due diligence and CMBS/RMBS compliance.',
    `expiry_date` DATE COMMENT 'The date after which the notice is no longer legally valid or actionable. Relevant for cure/default notices and estoppel certificate requests that have a defined validity window.',
    `hoa_violation_code` STRING COMMENT 'The specific HOA rule or bylaw code that has been violated, applicable when notice_type is hoa_violation. References the HOA governing documents and enables violation trend analysis.',
    `issue_date` DATE COMMENT 'The calendar date on which the notice was formally issued or received. Serves as the anchor date for calculating statutory response deadlines and notice period compliance.',
    `jurisdiction_state` STRING COMMENT 'Two-letter US state code (or equivalent jurisdiction code) governing the statutory notice requirements applicable to this notice. Determines the applicable notice period, delivery method requirements, and cure period rules.. Valid values are `^[A-Z]{2}$`',
    `legal_counsel_engaged` BOOLEAN COMMENT 'Indicates whether legal counsel has been engaged in connection with this notice, relevant for default, termination, and eviction-related notices. True = legal counsel engaged; False = no legal counsel engaged.',
    `litigation_hold` BOOLEAN COMMENT 'Indicates whether this notice record is subject to a litigation hold, preventing deletion or modification of the record for legal discovery purposes. True = litigation hold active; False = no hold.',
    `new_rent_amount` DECIMAL(18,2) COMMENT 'The revised rent amount that will be payable following the rent increase notice, expressed in the lease currency. Supports lease administration, AR forecasting, and NOI reporting.',
    `notes` STRING COMMENT 'Free-text field for additional context, internal commentary, or operational notes related to this notice record, such as verbal communications with the tenant, special circumstances, or follow-up actions required.',
    `notice_number` STRING COMMENT 'Externally-visible, human-readable reference number assigned to this notice for tracking in lease administration systems such as Yardi Voyager and MRI Software. Format: NTC-YYYY-NNNNNN.. Valid values are `^NTC-[0-9]{4}-[0-9]{6}$`',
    `notice_status` STRING COMMENT 'Current lifecycle state of the notice record, tracking progression from draft through issuance, delivery confirmation, tenant response, and final closure or withdrawal. [ENUM-REF-CANDIDATE: draft|issued|delivered|acknowledged|responded|expired|withdrawn|closed — 8 candidates stripped; promote to reference product]',
    `notice_type` STRING COMMENT 'Classification of the formal notice by its legal or administrative purpose. [ENUM-REF-CANDIDATE: vacate|renewal|rent_increase|cure_default|termination|hoa_violation|estoppel_request|lease_extension|entry_notice|other — promote to reference product]',
    `period_days` STRING COMMENT 'The number of calendar days constituting the legally required notice period for this notice type under applicable state or local landlord-tenant statutes (e.g., 3, 30, 60, 90 days). Supports statutory compliance validation.',
    `renewal_offer_rent_amount` DECIMAL(18,2) COMMENT 'The proposed rent amount offered to the tenant in a lease renewal notice, expressed in the lease currency. Supports lease administration, NOI forecasting, and deal pipeline management.',
    `renewal_offer_term_months` STRING COMMENT 'The proposed lease renewal term in months offered to the tenant in a lease renewal notice. Supports WALT and WALE (Weighted Average Lease Term/Expiry) analytics and portfolio lease expiry management.',
    `rent_increase_amount` DECIMAL(18,2) COMMENT 'The dollar amount by which the rent is being increased, applicable when notice_type is rent_increase. Expressed in the lease currency. Supports lease administration and financial reporting.',
    `rent_increase_pct` DECIMAL(18,2) COMMENT 'The percentage by which the rent is being increased, applicable when notice_type is rent_increase. Expressed as a decimal (e.g., 0.0350 = 3.50%). Supports lease administration and CPI-linked rent escalation analysis.',
    `response_date` DATE COMMENT 'The date on which the tenant or landlord formally responded to the notice. Used to assess timeliness of response relative to the statutory response deadline.',
    `response_deadline_date` DATE COMMENT 'The legally mandated deadline by which the recipient must respond to or comply with the notice, calculated per applicable state or local landlord-tenant statutes (e.g., 3-day, 30-day, 60-day notice periods).',
    `response_received` BOOLEAN COMMENT 'Indicates whether a formal response has been received from the notice recipient within the statutory response period. True = response received; False = no response received.',
    `response_summary` STRING COMMENT 'Brief narrative description of the response received from the notice recipient, capturing the nature of the response (e.g., tenant agreed to vacate, tenant disputed the default, tenant requested cure extension).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this notice record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail, change tracking, and SOX compliance.',
    `vacate_date` DATE COMMENT 'The date by which the tenant is required to vacate the premises, applicable for notice-to-vacate and lease termination notices. Supports occupancy planning, unit turnover scheduling, and portfolio management.',
    CONSTRAINT pk_notice PRIMARY KEY(`notice_id`)
) COMMENT 'Formal notice record issued to or received from a tenant covering the full spectrum of landlord-tenant legal communications: notice to vacate, lease renewal notice, rent increase notice, cure/default notice, lease termination notice, HOA violation notice, and estoppel certificate requests. Captures notice type, direction (inbound/outbound), issue date, effective date, statutory response deadline, delivery method (certified mail, email, portal, in-person), delivery confirmation status, response received flag, and digital signature reference. Supports lease administration, statutory compliance with state/local notice period requirements, and litigation readiness.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`document` (
    `document_id` BIGINT COMMENT 'Primary key for document',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: Legal document management requires linking executed amendment documents directly to the amendment record. Lease abstraction, lender due diligence, and version control processes require document→amendm',
    `application_id` BIGINT COMMENT 'Foreign key linking to tenant.application. Business justification: Applications generate and require documents (application forms, financial statements, ID documents). document.document_category can be application. Linking document.application_id → application.appl',
    `arrears_event_id` BIGINT COMMENT 'Foreign key linking to tenant.arrears_event. Business justification: Arrears events generate documents (demand letters, legal filings, payment plans). arrears_event.demand_letter_date, legal_case_reference confirm document generation. Linking document.arrears_event_id ',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: Corporate entities require KYC documents, entity registration certificates, and financial statements. corporate_entity.kyc_status confirms document requirements. Linking document.corporate_entity_id →',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to tenant.credit_profile. Business justification: Credit profiles generate documents (credit authorization forms, adverse action notices, income verification documents). credit_profile.authorization_document_ref confirms document linkage. Linking doc',
    `document_type_id` BIGINT COMMENT 'Foreign key linking to reference.document_type. Business justification: Document type classification drives workflow automation, retention policy enforcement, regulatory filing obligations, SOX control applicability, and legal review routing. document_type is a denormal',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: Guarantor instruments generate documents (guarantee agreements, LC documents, cash deposit confirmations). guarantor.document_ref_number, lc_number confirm document relationships. Linking document.gua',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: Residential households require documents (renters insurance policies, pet agreements, HOA documents). household.renters_insurance_policy_number confirms document relationships. Linking document.househ',
    `notice_id` BIGINT COMMENT 'Foreign key linking to tenant.notice. Business justification: Formal notices are documented — notice letters, delivery confirmations, response documents. notice.document_reference (STRING) confirms document linkage. Linking document.notice_id → notice.notice_id ',
    `owner_agreement_id` BIGINT COMMENT 'Foreign key linking to owner.owner_agreement. Business justification: SNDA agreements, estoppel certificates, and subordination documents are executed under and filed against the owners management or financing agreement. Lenders and owners require these documents to be',
    `previous_version_document_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediately preceding version of this document. Enables full version chain traversal for audit and compliance purposes. Null for first-version documents.',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Document retention periods, filing obligations, and SOX controls are governed by specific regulatory frameworks. Linking document to regulatory_framework enables retention policy enforcement, purge el',
    `retention_action_id` BIGINT COMMENT 'Foreign key linking to tenant.retention_action. Business justification: Retention actions generate documents (LOI, renewal proposals, rent abatement agreements). retention_action.loi_issued confirms document generation. Linking document.retention_action_id → retention_act',
    `screening_id` BIGINT COMMENT 'Foreign key linking to tenant.screening. Business justification: Screening processes generate documents (screening reports, adverse action notices, consent forms). screening.screening_report_url confirms document generation. Linking document.screening_id → screenin',
    `tenant_contact_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_contact. Business justification: Documents are associated with specific tenant contacts — signatories, recipients, authorized representatives. document.signatory_count and digital_signature_status confirm contact-level document relat',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant profile to which this document belongs. Links the document to the tenant master record for lifecycle and compliance tracking.',
    `tenant_occupancy_id` BIGINT COMMENT 'Foreign key linking to tenant.occupancy. Business justification: Occupancy records generate documents (move-in/move-out inspection reports, COO certificates, key handover forms). occupancy.coo_reference confirms document generation. Linking document.occupancy_id → ',
    `tenant_prospect_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_prospect. Business justification: Prospect pipeline activities generate documents (tour confirmations, LOI, NDA, proposal documents). tenant_prospect.loi_issued_date confirms document generation. Linking document.tenant_prospect_id → ',
    `termination_id` BIGINT COMMENT 'Foreign key linking to lease.termination. Business justification: Lease termination legal document management requires linking surrender agreements, termination agreements, and possession return documents directly to the termination record. Legal counsel and complia',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: KYC, identity document verification, and lease execution compliance require an auditable chain of custody linking each verified tenant document to the specific employee who verified it. `verified_by` ',
    `access_restriction_notes` STRING COMMENT 'Free-text notes describing specific access restrictions, need-to-know limitations, or legal holds applied to the document beyond standard confidentiality level controls.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the document based on its sensitivity and access control requirements. Drives role-based access permissions within the document repository and compliance with GDPR and SOX data governance policies.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which the document record was first created in the tenant document repository. Serves as the system-of-record audit creation timestamp for data governance and SOX compliance.',
    `digital_signature_status` STRING COMMENT 'Current status of the digital signature workflow for the document within DocuSign CLM. Tracks whether all required signatories have executed the document electronically.. Valid values are `not_required|pending|partially_signed|completed|declined|voided`',
    `document_category` STRING COMMENT 'High-level grouping of the document for portfolio-wide reporting and access control. Segments documents into legal, financial, identity, compliance, operational, and correspondence buckets.. Valid values are `legal|financial|identity|compliance|operational|correspondence`',
    `document_description` STRING COMMENT 'Free-text narrative describing the content, purpose, and context of the document. Provides additional detail beyond document_name and document_type for search, discovery, and review workflows.',
    `document_name` STRING COMMENT 'Human-readable title or name of the document as displayed in the tenant document repository (e.g., Lease Abstract — Suite 400, Certificate of Incorporation — ABC Corp).',
    `document_number` STRING COMMENT 'Externally-known unique business identifier assigned to the document, used for cross-referencing in DocuSign CLM, Yardi Voyager, and MRI Software. Supports audit trails and regulatory compliance tracking.',
    `document_status` STRING COMMENT 'Current lifecycle state of the document record. active indicates the document is current and valid; expired indicates the document has passed its expiry date; superseded indicates a newer version has replaced it; archived indicates the document is retained for historical purposes; pending_review indicates the document is awaiting approval or verification.. Valid values are `active|expired|superseded|archived|pending_review`',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier assigned by DocuSign CLM for digitally executed documents. Enables direct lookup and audit trail retrieval from the DocuSign platform for lease execution and SNDA agreements.',
    `effective_date` DATE COMMENT 'Date from which the document becomes legally or operationally binding. For lease abstracts and LOIs, this aligns with the lease commencement date. For identification documents, this is the issue date.',
    `execution_date` DATE COMMENT 'Date on which the document was formally signed or executed by all required parties. Applicable to lease abstracts, LOIs, SNDA agreements, and digitally executed documents via DocuSign CLM.',
    `expiry_date` DATE COMMENT 'Date on which the document expires or ceases to be valid. Critical for insurance certificates, identification documents, and regulatory compliance filings. Drives automated expiry alerts and renewal workflows.',
    `file_format` STRING COMMENT 'File format or MIME type of the stored document. Supports rendering, conversion, and archival compatibility checks within the document management system. [ENUM-REF-CANDIDATE: PDF|DOCX|XLSX|JPEG|PNG|TIFF|MSG — 7 candidates stripped; promote to reference product]',
    `file_size_kb` STRING COMMENT 'Size of the document file in kilobytes at the time of upload. Used for storage capacity planning and document repository management.',
    `is_current_version` BOOLEAN COMMENT 'Indicates whether this document record represents the most current active version. True when this is the latest version; False when superseded by a newer version. Supports version chain navigation.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the document has been verified for authenticity and completeness by an authorized reviewer (e.g., property manager, compliance officer, or legal counsel). True when verified; False when pending verification.',
    `issuing_authority` STRING COMMENT 'Name of the government body, regulatory agency, court, or institution that issued or certified the document (e.g., IRS, Secretary of State, ALTA). Applicable to identification documents, incorporation certificates, and regulatory filings.',
    `issuing_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction that issued the document. Required for cross-border tenant compliance and KYC/AML screening.. Valid values are `^[A-Z]{3}$`',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the primary language of the document (e.g., en, fr, es). Supports multilingual tenant portfolios and translation workflow management.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `notes` STRING COMMENT 'Operational notes or comments added by property management or lease administration staff regarding the documents status, exceptions, or follow-up actions required.',
    `page_count` STRING COMMENT 'Total number of pages in the document. Supports document completeness validation and review effort estimation for lease administration and compliance teams.',
    `purge_eligible_date` DATE COMMENT 'Earliest date on which the document may be permanently deleted in compliance with the applicable retention policy. Calculated from upload_date or execution_date plus retention_period_years. Supports GDPR right-to-erasure workflows.',
    `received_date` DATE COMMENT 'Date on which the document was physically or electronically received from the tenant or counterparty. Distinct from upload_date; supports SLA tracking for tenant onboarding and lease administration workflows.',
    `retention_period_years` STRING COMMENT 'Mandatory retention period in years for the document as required by applicable regulatory frameworks (e.g., IRS tax records — 7 years, FASB ASC 842 lease records — lease term plus 5 years). Drives automated archival and purge scheduling.',
    `review_date` DATE COMMENT 'Scheduled or actual date on which the document is due for periodic review or renewal assessment. Used for proactive document management and compliance calendar planning.',
    `signatory_count` STRING COMMENT 'Total number of signatories required to fully execute the document. Used to track completion status of multi-party agreements such as SNDA agreements and lease amendments.',
    `source_system` STRING COMMENT 'Operational system of record from which the document was originated or ingested (e.g., Yardi Voyager, DocuSign CLM, MRI Software, Salesforce CRM). Supports data lineage tracking and reconciliation. [ENUM-REF-CANDIDATE: yardi|mri|docusign|salesforce|procore|manual|other — 7 candidates stripped; promote to reference product]',
    `source_system_ref` STRING COMMENT 'Native identifier of the document record in the originating source system (e.g., Yardi document ID, DocuSign envelope ID, MRI document reference). Enables cross-system reconciliation and data lineage tracing.',
    `storage_reference` STRING COMMENT 'Fully qualified path, URI, or object key pointing to the physical document file in the enterprise content management or cloud storage system (e.g., Azure Blob Storage, SharePoint, Yardi Document Management). Enables direct retrieval of the document binary.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time at which the document record was most recently modified in the tenant document repository. Supports change data capture, audit trails, and Silver Layer incremental processing in the Databricks Lakehouse.',
    `upload_date` DATE COMMENT 'Calendar date on which the document was uploaded or ingested into the tenant document repository. Used for document age tracking and onboarding completeness reporting.',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time at which the document verification was completed by the authorized reviewer. Provides a precise audit timestamp for compliance and regulatory reporting.',
    `version_number` STRING COMMENT 'Version identifier of the document following semantic versioning conventions (e.g., 1.0, 2.1). Enables tracking of document revisions and supersession history within the tenant repository.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Tenant document repository record tracking all documents associated with a tenant profile — identification documents, incorporation certificates, financial statements, tax returns, signed lease abstracts, LOIs, SNDA agreements, and digitally executed documents. Captures document type, document name, version, upload date, expiry date, storage reference, and document status (active, expired, superseded, archived). Supports lease administration, regulatory compliance, and tenant onboarding documentation requirements.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`arrears_event` (
    `arrears_event_id` BIGINT COMMENT 'Unique system-generated identifier for each tenant rent arrears or delinquency event record. Primary key for the arrears_event product in the tenant domain Silver layer.',
    `asset_id` BIGINT COMMENT 'Reference to the property at which the arrears event occurred. Supports portfolio-level delinquency reporting and property manager assignment.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to insurance.claim. Business justification: Rent guarantee insurance and loss-of-rents coverage allow property owners to file an insurance claim when a tenant defaults. Linking arrears_event to the resulting insurance claim supports loss-of-ren',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to tenant.credit_profile. Business justification: Arrears events directly impact tenant credit risk profiles. arrears_event.tenant_retention_risk confirms credit risk assessment occurs at the arrears level. Linking arrears_event.credit_profile_id → c',
    `employee_id` BIGINT COMMENT 'Reference to the Property Manager (PM) responsible for managing this arrears event and coordinating collections actions at the property level. Supports workload assignment and performance reporting.',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: When a tenant defaults on rent, the guarantor may be called upon to fulfill the obligation. Linking arrears_event.guarantor_id → guarantor.guarantor_id connects the arrears event to the guarantor resp',
    `security_deposit_id` BIGINT COMMENT 'Foreign key linking to lease.security_deposit. Business justification: Collections management requires linking arrears events to the security deposit applied during resolution. arrears_event has security_deposit_applied and security_deposit_applied_amount as plain attrib',
    `owner_agreement_id` BIGINT COMMENT 'Foreign key linking to owner.owner_agreement. Business justification: Arrears escalation, legal referral authority, and write-off thresholds are defined in the owners management agreement. Property managers must reference the owner_agreement when escalating arrears to ',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Arrears collection, eviction filing, and legal referral are governed by jurisdiction-specific regulatory frameworks (eviction moratoriums, FDCPA, state debt collection laws). Linking arrears_event to ',
    `relationship_manager_employee_id` BIGINT COMMENT 'Reference to the tenant relationship manager in the CRM responsible for coordinating the tenant retention strategy and collections communication for this arrears event. Distinct from the property manager role.',
    `tenant_contact_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_contact. Business justification: Arrears events involve specific tenant contacts responsible for payment (accounts payable contact, primary contact). Linking arrears_event.tenant_contact_id → tenant_contact.tenant_contact_id identifi',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant party who is in arrears. Links to the tenant master record for identity, contact hierarchy, and credit profile context.',
    `tenant_occupancy_id` BIGINT COMMENT 'Foreign key linking to tenant.occupancy. Business justification: Arrears events are associated with specific occupancy periods — rent is owed for a specific occupancy. arrears_event has unit_id and agreement_id but no direct occupancy link. Linking arrears_event.oc',
    `unit_id` BIGINT COMMENT 'Reference to the specific leasable unit (suite, apartment, or space) associated with the arrears event. Enables unit-level delinquency tracking within a multi-unit property.',
    `arrears_stage` STRING COMMENT 'Current stage in the delinquency lifecycle workflow for this arrears event. Drives escalation actions and communication templates. Stages: first_notice (initial overdue notification), second_notice (follow-up), demand_letter (formal legal demand), legal_referral (referred to legal counsel), eviction_proceedings (formal eviction initiated).. Valid values are `first_notice|second_notice|demand_letter|legal_referral|eviction_proceedings`',
    `charge_type` STRING COMMENT 'Classification of the overdue lease-obligated payment type. Base_rent covers contractual rent; cam covers Common Area Maintenance (CAM) charges; tax covers property tax pass-throughs; insurance covers insurance pass-throughs; utility covers utility recharges; other covers miscellaneous lease charges.. Valid values are `base_rent|cam|tax|insurance|utility|other`',
    `collection_action_notes` STRING COMMENT 'Free-text narrative describing collection actions taken, tenant communications, negotiation outcomes, and any special circumstances relevant to this arrears event. Supports relationship manager context and legal documentation.',
    `collection_agency_name` STRING COMMENT 'Name of the external collection agency to which this arrears event has been referred, if applicable. Null if managed internally. Used for third-party collections tracking and agency performance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this arrears event record was first created in the Silver layer data product. Supports audit trail, data lineage, and SLA compliance monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cure_date` DATE COMMENT 'Date on which the arrears event was fully cured — i.e., all outstanding amounts were paid and the delinquency was resolved. Null if the event is still open. Used to measure time-to-cure and collections effectiveness.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this arrears event record (e.g., USD, GBP, EUR, AUD). Supports multi-currency portfolios and international real estate operations.. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'Number of calendar days elapsed since the payment due date as of the event_date. Drives arrears stage classification, late fee calculation, and credit risk scoring. Captured at the time of event creation and updated on each review cycle.',
    `demand_letter_date` DATE COMMENT 'Date on which a formal legal demand letter was issued to the tenant requiring payment within a specified cure period. Null if the event has not reached demand letter stage. Critical for legal proceedings documentation.',
    `due_date` DATE COMMENT 'The contractual date on which the overdue payment was originally due per the lease agreement. Used to calculate days past due and determine arrears stage escalation thresholds.',
    `event_date` DATE COMMENT 'The business date on which this arrears event was formally identified and recorded. Represents the principal real-world event time — the date the delinquency was recognised in the collections workflow, which may differ from the payment due date.',
    `event_reference_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to this arrears event. Used in correspondence with tenants, legal counsel, and collection agencies. Format: ARR-YYYY-NNNNNN.. Valid values are `^ARR-[0-9]{4}-[0-9]{6}$`',
    `eviction_filing_date` DATE COMMENT 'Date on which formal eviction proceedings were filed with the relevant court or housing authority. Null if eviction has not been initiated. Required for regulatory compliance reporting and legal case management.',
    `first_notice_date` DATE COMMENT 'Date on which the first formal overdue payment notice was issued to the tenant. Marks the start of the formal collections escalation timeline and is required for legal compliance in eviction proceedings.',
    `interest_accrued` DECIMAL(18,2) COMMENT 'Cumulative interest accrued on the overdue principal amount from the due date to the event snapshot date, calculated at the contractual default interest rate specified in the lease.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Contractual late fee or penalty charge assessed on the overdue amount per the lease agreement terms. Separate from the principal overdue amount to support transparent tenant statements.',
    `legal_case_reference` STRING COMMENT 'External court or legal case reference number assigned when eviction or debt recovery proceedings are filed. Null if no legal action has been initiated. Required for legal case management and regulatory compliance.',
    `legal_referral_date` DATE COMMENT 'Date on which the arrears event was formally referred to legal counsel or a collection agency for enforcement action. Null if not yet referred. Triggers legal cost tracking and changes tenant relationship management approach.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Gross amount of the overdue payment in the lease currency at the time this arrears event was created. Represents the principal overdue obligation before late fees or interest are applied.',
    `partial_payment_date` DATE COMMENT 'Date on which the most recent partial payment was received against this arrears event. Null if no partial payment has been made. Used to assess tenant payment behaviour and update collection strategy.',
    `partial_payment_received` DECIMAL(18,2) COMMENT 'Amount of partial payment received against this arrears event since it was opened. Enables tracking of payment progress and remaining balance without requiring a separate payment record lookup.',
    `payment_plan_end_date` DATE COMMENT 'Date by which all instalments under the agreed payment plan must be completed. Null if no payment plan is in place. Supports WALT and delinquency resolution forecasting.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether a formal payment plan has been agreed with the tenant for this arrears event. True when a payment plan is in place; False otherwise. Drives collections workflow routing and tenant communication.',
    `payment_plan_instalment_amount` DECIMAL(18,2) COMMENT 'Agreed periodic instalment amount under the payment plan for this arrears event. Null if no payment plan is in place. Used to generate instalment schedules and monitor compliance.',
    `payment_plan_start_date` DATE COMMENT 'Date on which the agreed payment plan for this arrears event commences. Null if no payment plan is in place. Used to schedule instalment reminders and monitor plan adherence.',
    `portfolio_type` STRING COMMENT 'Indicates whether this arrears event relates to a commercial (B2B corporate tenant) or residential (B2C occupant) portfolio. Drives applicable regulatory framework, escalation procedures, and reporting segmentation.. Valid values are `commercial|residential`',
    `resolution_status` STRING COMMENT 'Current resolution status of the arrears event. Indicates whether the delinquency is still open, under a payment plan, fully cured, written off as bad debt, in legal recovery, or closed. Distinct from arrears_stage which tracks the escalation workflow.. Valid values are `open|payment_plan|cured|written_off|legal_recovery|closed`',
    `second_notice_date` DATE COMMENT 'Date on which the second formal overdue payment notice was issued to the tenant. Null if the event has not progressed to second notice stage. Part of the legally required escalation audit trail.',
    `security_deposit_applied` BOOLEAN COMMENT 'Indicates whether the tenants security deposit has been applied against this arrears event. True if the deposit has been drawn; False otherwise. Affects remaining deposit balance and tenant liability calculations.',
    `security_deposit_applied_amount` DECIMAL(18,2) COMMENT 'Amount of the tenants security deposit applied against this arrears event. Null if security_deposit_applied is False. Used to calculate net remaining arrears after deposit offset.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this arrears event record originated. Supports data lineage, reconciliation, and audit traceability in the Silver layer lakehouse.. Valid values are `yardi_voyager|mri_software|manual`',
    `source_system_event_code` STRING COMMENT 'The native identifier of this arrears event record in the originating operational system (e.g., Yardi Voyager charge batch ID or MRI collections case ID). Enables reconciliation between the lakehouse Silver layer and the source system.',
    `tenant_retention_risk` STRING COMMENT 'Assessed risk level that this arrears event will result in tenant loss or lease termination. Assigned by the relationship manager or CRM workflow to guide collections strategy and retention decisions. Values: low, medium, high, critical.. Valid values are `low|medium|high|critical`',
    `total_outstanding` DECIMAL(18,2) COMMENT 'Total amount outstanding for this arrears event, comprising overdue_amount plus late_fee_amount plus interest_accrued. Represents the full liability the tenant must cure to resolve this event. Stored as a business-captured field from the source AR system snapshot.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this arrears event record was last modified in the Silver layer data product. Required for incremental processing, change data capture, and audit trail completeness. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount of the arrears that has been formally written off as bad debt following approval per the bad debt policy. Null if no write-off has occurred. Required for FASB ASC 310 bad debt provisioning and GL journal entries.',
    `write_off_date` DATE COMMENT 'Date on which the bad debt write-off was approved and posted to the General Ledger (GL). Null if no write-off has occurred. Required for period-end financial close and SOX audit trail.',
    CONSTRAINT pk_arrears_event PRIMARY KEY(`arrears_event_id`)
) COMMENT 'Tenant rent arrears and delinquency event record capturing each instance of overdue rent, CAM charges, or other lease-obligated payments. Records amount overdue, days past due, arrears stage (first notice, second notice, demand letter, legal referral, eviction proceedings), collection actions taken, payment plan terms, cure date, and resolution status. Provides the tenant-facing delinquency lifecycle view for relationship managers, distinct from the finance domains AR aging records, enabling coordinated collections strategy and tenant retention decisions.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`retention_action` (
    `retention_action_id` BIGINT COMMENT 'Unique system-generated identifier for each tenant retention and renewal campaign action record. Primary key for the retention_action product.',
    `asset_id` BIGINT COMMENT 'Reference to the property where the tenant subject to this retention action is located. Enables portfolio-level retention analytics by asset.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: Successful lease renewal retention actions generate brokerage deals for renewal commission tracking. Commercial real estate brokers earn renewal commissions, and linking retention_action to deal enabl',
    `campaign_id` BIGINT COMMENT 'Reference to the broader retention campaign or program under which this individual action was initiated. Enables campaign-level effectiveness reporting across multiple tenant actions.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to tenant.credit_profile. Business justification: Retention decisions consider tenant credit risk. retention_action.tenant_credit_risk_rating confirms credit risk assessment in retention workflows. Linking retention_action.credit_profile_id → credit_',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Retention action financial fields (rent_abatement_amount, ti_allowance_total, proposed_rent_psf, current_rent_psf, market_rent_psf) require currency context for multi-currency portfolio retention anal',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Tenant retention strategies frequently involve offering tenants relocation to a new development project (e.g., upgrading from aging stock to new build). Retention teams must reference the specific dev',
    `negotiation_instrument_id` BIGINT COMMENT 'Foreign key linking to brokerage.negotiation_instrument. Business justification: Retention actions that result in lease renewals generate LOIs as negotiation instruments. Linking retention_action to the LOI record enables full renewal deal progression tracking, renewal commission ',
    `notice_id` BIGINT COMMENT 'Foreign key linking to tenant.notice. Business justification: Retention actions may generate or respond to formal notices (renewal offer notices, lease expiry notices). retention_action.loi_issued and proposed_lease_start_date confirm formal notice generation. L',
    `owner_agreement_id` BIGINT COMMENT 'Foreign key linking to owner.owner_agreement. Business justification: Retention concessions (free rent, TI allowances, rent abatements) require owner approval per the capex/opex approval thresholds in the management agreement. Property managers must reference the owner_',
    `employee_id` BIGINT COMMENT 'Reference to the assigned relationship manager or asset manager (AM) responsible for executing this retention action. Supports workload tracking and accountability.',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Retention offers specify a lease structure (NNN, gross, modified gross) which determines CAM responsibility and financial terms. lease_type_offered is a denormalized lease type reference; linking to',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: Lease expiry management requires linking retention actions to the specific renewal option being negotiated. Asset managers use this to track whether a renewal option is being exercised, restructured, ',
    `tenant_contact_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_contact. Business justification: Retention outreach is directed at specific tenant contacts (decision-makers, authorized signatories). retention_action.outreach_channel and tenant_response confirm contact-level engagement. Linking re',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant profile for whom this retention action is being executed. Links to the tenant master record in the tenant domain.',
    `tenant_occupancy_id` BIGINT COMMENT 'Foreign key linking to tenant.occupancy. Business justification: Retention actions are tied to specific occupancy periods — the tenant being retained is in a specific occupancy. retention_action.lease_expiry_date and months_to_expiry confirm occupancy-level retenti',
    `action_closed_date` DATE COMMENT 'Date on which the retention action was formally closed, either with a retained, lost, or cancelled outcome. Null if the action is still open.',
    `action_date` DATE COMMENT 'The calendar date on which the retention action was initiated or the outreach was first made to the tenant. Principal business event date for this record.',
    `action_due_date` DATE COMMENT 'Target date by which the retention action must be completed or a tenant response must be received. Used for SLA tracking and escalation triggers.',
    `action_notes` STRING COMMENT 'Free-text field capturing qualitative details, negotiation context, tenant concerns, or special conditions discussed during the retention action. Supports relationship management continuity.',
    `action_reference_number` STRING COMMENT 'Externally visible business identifier for this retention action, used in correspondence with tenants and internal reporting. Format: RA-YYYY-NNNNNN.. Valid values are `^RA-[0-9]{4}-[0-9]{6}$`',
    `action_status` STRING COMMENT 'Current lifecycle state of the retention action. Tracks progression from initial outreach through final outcome (retained, lost, or cancelled). Supports WALE management dashboards.. Valid values are `pending|in_progress|awaiting_response|closed_retained|closed_lost|cancelled`',
    `action_type` STRING COMMENT 'Classification of the retention activity being performed. Drives workflow routing and offer eligibility rules. [ENUM-REF-CANDIDATE: lease_renewal_outreach|rent_concession_offer|ti_allowance_proposal|lease_restructuring|escalation_to_senior_am|early_renewal_incentive|termination_prevention — promote to reference product]',
    `cam_rate_psf` DECIMAL(18,2) COMMENT 'Proposed Common Area Maintenance (CAM) charge rate Per Square Foot (PSF) included in the retention offer. Relevant for NNN and modified gross lease structures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention action record was first created in the system. Audit trail field supporting SOX compliance and data lineage tracking.',
    `crm_activity_code` STRING COMMENT 'The corresponding activity or task identifier in Salesforce CRM that tracks this retention action. Enables bi-directional traceability between the lakehouse and the CRM system of record.',
    `current_rent_psf` DECIMAL(18,2) COMMENT 'The tenants current in-place base rent rate expressed in dollars Per Square Foot (PSF) per annum at the time the retention action was initiated. Provides baseline for concession analysis.',
    `escalation_date` DATE COMMENT 'Date on which the retention action was escalated to senior Asset Management (AM). Null if no escalation has occurred. Used to track escalation response time.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this retention action has been escalated to senior Asset Management (AM) due to strategic tenant importance, large concession requirements, or risk of significant vacancy.',
    `escalation_type` STRING COMMENT 'The mechanism by which rent escalates over the proposed renewal term, such as fixed percentage, CPI-indexed, fixed dollar amount, market review, or stepped increases.. Valid values are `fixed_percentage|cpi_indexed|fixed_amount|market_review|stepped`',
    `free_rent_months_offered` DECIMAL(18,2) COMMENT 'Number of months of free rent offered to the tenant as part of the retention incentive package. A key lease concession metric tracked in commercial real estate negotiations.',
    `lease_expiry_date` DATE COMMENT 'The expiration date of the tenants current lease that this retention action is targeting. Critical for Weighted Average Lease Expiry (WALE) and Weighted Average Lease Term (WALT) calculations.',
    `leased_area_sqft` DECIMAL(18,2) COMMENT 'Net Leasable Area (NLA) in Square Feet (SQF) occupied by the tenant under the lease subject to this retention action. Used to calculate total TI allowance and total rent value.',
    `loi_date` DATE COMMENT 'Date on which the Letter of Intent (LOI) was issued to the tenant. Null if no LOI has been issued. Marks a key milestone in the lease renewal negotiation lifecycle.',
    `loi_issued` BOOLEAN COMMENT 'Indicates whether a formal Letter of Intent (LOI) has been issued to the tenant as part of this retention action. True when an LOI has been sent; False when still in informal negotiation.',
    `market_rent_psf` DECIMAL(18,2) COMMENT 'Prevailing market rent rate Per Square Foot (PSF) for comparable space at the time of the retention action, sourced from CoStar or broker opinion. Used to benchmark the offer against market conditions.',
    `months_to_expiry` STRING COMMENT 'Number of months remaining from the action date to the lease expiry date at the time the retention action was created. Used to prioritize outreach urgency and campaign timing.',
    `outcome` STRING COMMENT 'Final disposition of the retention action indicating whether the tenant was retained, lost, or the outcome is still pending. Core KPI for portfolio retention strategy reporting.. Valid values are `retained|lost|pending|renewal_signed|relocated_within_portfolio|vacated`',
    `outreach_channel` STRING COMMENT 'The communication channel used to initiate or conduct the retention action with the tenant. Supports channel effectiveness analytics for retention campaigns.. Valid values are `email|phone|in_person_meeting|formal_letter|video_call|broker_intermediary`',
    `priority_level` STRING COMMENT 'Business priority assigned to this retention action based on tenant strategic importance, lease size, and risk of vacancy. Drives resource allocation and outreach sequencing.. Valid values are `critical|high|medium|low`',
    `proposed_lease_end_date` DATE COMMENT 'Proposed expiration date for the renewed or restructured lease term being offered to the tenant. Used in WALE and WALT portfolio calculations.',
    `proposed_lease_start_date` DATE COMMENT 'Proposed commencement date for the renewed or restructured lease term being offered to the tenant as part of the retention action.',
    `proposed_lease_term_months` STRING COMMENT 'Duration in months of the proposed lease renewal or restructured lease term offered to the tenant. Directly impacts Weighted Average Lease Term (WALT) and Weighted Average Lease Expiry (WALE) metrics.',
    `proposed_rent_psf` DECIMAL(18,2) COMMENT 'The proposed renewal base rent rate expressed in dollars Per Square Foot (PSF) per annum offered to the tenant as part of the retention negotiation.',
    `rent_abatement_amount` DECIMAL(18,2) COMMENT 'Total dollar value of rent abatement offered to the tenant as a retention concession. Represents the gross monetary value of the rent reduction or waiver proposed.',
    `rent_escalation_rate_pct` DECIMAL(18,2) COMMENT 'Annual rent escalation rate (as a decimal percentage) proposed in the renewal offer, e.g., 0.0300 for 3% per annum. Impacts long-term Net Operating Income (NOI) projections.',
    `tenant_credit_risk_rating` STRING COMMENT 'Credit risk rating of the tenant at the time of the retention action, sourced from the tenant credit profile. Informs the level of concession the asset manager is authorized to offer. [ENUM-REF-CANDIDATE: aaa|aa|a|bbb|bb|b|ccc|below_investment_grade — promote to reference product]',
    `tenant_response` STRING COMMENT 'The tenants formal or informal response to the retention action or offer presented. Drives next-step workflow and escalation logic.. Valid values are `interested|not_interested|counter_proposal|no_response|escalated|deferred`',
    `tenant_response_date` DATE COMMENT 'Date on which the tenant formally responded to the retention action or offer. Used to measure response time and campaign velocity.',
    `ti_allowance_psf` DECIMAL(18,2) COMMENT 'Tenant Improvement (TI) allowance offered to the tenant expressed in dollars Per Square Foot (PSF). A primary lease incentive in commercial real estate retention negotiations.',
    `ti_allowance_total` DECIMAL(18,2) COMMENT 'Total dollar value of the Tenant Improvement (TI) allowance offered as part of the retention package, calculated as TI PSF multiplied by the leased area. Represents the full capital commitment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention action record was last modified. Supports change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver Layer.',
    CONSTRAINT pk_retention_action PRIMARY KEY(`retention_action_id`)
) COMMENT 'Tenant retention and renewal campaign action record capturing proactive relationship management activities — lease renewal outreach, rent concession offers, TI allowance proposals, lease restructuring discussions, and escalation to senior asset management. Captures action type, action date, assigned relationship manager, offer details (free rent months, TI PSF, rent abatement), tenant response, and outcome (retained, lost, pending). Supports WALE management and portfolio retention strategy.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`tenant`.`screening` (
    `screening_id` BIGINT COMMENT 'Unique surrogate identifier for the tenant background screening record. Primary key for the tenant.screening data product in the Silver Layer lakehouse.',
    `application_id` BIGINT COMMENT 'Reference to the tenant application that triggered this screening request. Links the screening result back to the originating application record.',
    `brokerage_prospect_id` BIGINT COMMENT 'Reference to the tenant prospect record at the time of screening initiation, prior to lease execution and tenant record creation.',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: For commercial applicants, screening (KYC, entity verification, credit check) is performed on the corporate entity. screening.applicant_type can be corporate. Linking screening.corporate_entity_id →',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: When a guarantor is required (as indicated by credit_profile.guarantor_required_flag), a separate background and credit screening is performed on the guarantor. screening.applicant_type can be guaran',
    `household_id` BIGINT COMMENT 'Foreign key linking to tenant.household. Business justification: For residential applications, screening is performed at the household level (all adult members). Linking screening.household_id → household.household_id connects the screening record to the household ',
    `owner_agreement_id` BIGINT COMMENT 'Foreign key linking to owner.owner_agreement. Business justification: Owner management agreements often specify minimum screening criteria (credit score floors, income-to-rent ratios, background check scope). Linking screening records to the owner_agreement enables comp',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Tenant screening is governed by FCRA, fair housing laws, and state-specific screening regulations. Linking screening to regulatory_framework enables FCRA compliance documentation, adverse action track',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCRA and Fair Housing regulations require an auditable record of which employee reviewed and approved each screening result. The `reviewed_by` plain-text field is a denormalized employee reference tha',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant profile record for the individual or entity being screened. Populated upon conversion from prospect to tenant.',
    `prior_screening_id` BIGINT COMMENT 'Self-referencing FK on screening (prior_screening_id)',
    `adverse_action_notice_date` DATE COMMENT 'Date on which the adverse action notice was issued to the applicant. Must be documented for FCRA compliance. Null if adverse_action_required is false or notice has not yet been sent.',
    `adverse_action_reason_codes` STRING COMMENT 'Pipe-delimited list of standardized reason codes provided on the adverse action notice explaining the basis for denial or conditional approval (e.g., insufficient income, derogatory credit history, prior eviction). Required by FCRA Section 615 for consumer-report-based decisions.',
    `adverse_action_required` BOOLEAN COMMENT 'Indicates whether an adverse action notice is required to be issued to the applicant based on the screening result. Triggered when a consumer report (credit, criminal, eviction) contributed to a denial or conditional approval decision, as mandated by FCRA Section 615.',
    `applicant_consent_obtained` BOOLEAN COMMENT 'Indicates whether written authorization was obtained from the applicant prior to initiating the background screening, as required by FCRA Section 604(b). A prerequisite for any consumer report pull.',
    `applicant_type` STRING COMMENT 'Classification of the subject being screened. Distinguishes between individual residential applicants, corporate entities, guarantors, and co-applicants, each of which may require different check types and criteria.. Valid values are `individual|corporate_entity|guarantor|co_applicant`',
    `completion_date` DATE COMMENT 'Calendar date on which all screening checks were completed and the final composite result was returned by the vendor. Used to measure vendor turnaround time and determine report validity window.',
    `consent_date` DATE COMMENT 'Date on which the applicant provided written authorization for the background screening. Required for FCRA compliance documentation and GDPR lawful basis records.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the screening record was first created in the system. Establishes the audit trail start point and supports data lineage tracking in the Silver Layer lakehouse.',
    `credit_check_result` STRING COMMENT 'Result of the credit bureau check component of the screening. Reflects whether the applicants credit profile meets the propertys minimum credit qualification criteria. Note: detailed credit data is stored in tenant.credit_profile.. Valid values are `pass|fail|conditional_pass|not_conducted`',
    `credit_score_at_screening` STRING COMMENT 'Credit score returned by the screening vendor at the time of this specific screening event. Captured as a point-in-time snapshot for audit and adverse action documentation purposes, independent of the ongoing credit profile record.',
    `criminal_check_result` STRING COMMENT 'Result of the criminal background check component of the screening. A review_required result indicates records were found that require individualized assessment per HUD guidance before an adverse action decision is made.. Valid values are `pass|fail|review_required|not_conducted`',
    `criminal_check_scope` STRING COMMENT 'Geographic scope of the criminal background check performed. Indicates whether the search covered county, state, national, or international criminal records databases, which affects the comprehensiveness of the result.. Valid values are `county|state|national|international`',
    `criteria_version` STRING COMMENT 'Version identifier of the standardized screening criteria policy applied to this screening event. Ensures consistent, documented criteria enforcement across all applications and supports fair housing audit trails.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the screening fee amount (e.g., USD, CAD). Supports multi-currency portfolio operations.. Valid values are `^[A-Z]{3}$`',
    `employment_verification_result` STRING COMMENT 'Result of the employment verification check confirming the applicants current employer, employment status, and income. Supports income-to-rent ratio qualification and FCRA-compliant underwriting.. Valid values are `pass|fail|unable_to_verify|not_conducted`',
    `eviction_check_result` STRING COMMENT 'Result of the eviction history database search. Captures whether prior eviction filings or judgments were found. A fail or review_required result is a key risk indicator in the underwriting decision.. Valid values are `pass|fail|review_required|not_conducted`',
    `fair_housing_review_flag` BOOLEAN COMMENT 'Indicates whether this screening result was flagged for individualized fair housing review, typically triggered when criminal history or other protected-class-adjacent findings require case-by-case assessment per HUD guidance before an adverse action decision.',
    `fcra_compliant` BOOLEAN COMMENT 'Indicates whether all FCRA procedural requirements were met for this screening event, including permissible purpose documentation, applicant disclosure, authorization, and adverse action notice (if applicable). Critical for regulatory audit and litigation defense.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount charged to the applicant or property for the screening services. Tracked for accounts receivable reconciliation and to ensure compliance with state-level limits on application/screening fees.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the applicants identity during the screening process. Captures whether SSN, ITIN, government-issued ID, or passport was used, supporting FCRA compliance documentation.. Valid values are `ssn_validation|itin_validation|government_id|passport|other`',
    `identity_verification_result` STRING COMMENT 'Result of the identity verification check, including SSN/ITIN validation and government-issued ID confirmation. A fail or unable-to-verify result typically blocks lease approval and may trigger adverse action.. Valid values are `pass|fail|unable_to_verify`',
    `income_to_rent_ratio` DECIMAL(18,2) COMMENT 'Ratio of the applicants verified gross monthly income to the proposed monthly rent, calculated at the time of screening. Typically a minimum of 2.5x–3x is required. Used as a primary qualification criterion.',
    `individualized_assessment_conducted` BOOLEAN COMMENT 'Indicates whether an individualized assessment was performed for this applicant prior to an adverse action based on criminal history, as required by HUD guidance to avoid disparate impact under the Fair Housing Act.',
    `landlord_reference_count` STRING COMMENT 'Number of prior landlord references contacted and verified during the screening process. Supports audit documentation of reference check thoroughness.',
    `landlord_reference_result` STRING COMMENT 'Result of the prior landlord reference check, verifying rental payment history, lease compliance, and tenancy conduct with previous landlords. A key qualitative input to the overall screening determination.. Valid values are `pass|fail|unable_to_verify|not_conducted`',
    `notes` STRING COMMENT 'Free-text field for the reviewer to document observations, exceptions, individualized assessment findings, or other context relevant to the screening determination. Supports audit trail and fair housing compliance documentation.',
    `overall_result` STRING COMMENT 'Composite pass/fail determination across all screening check types performed. A conditional pass may indicate approval subject to additional conditions such as a co-signer or increased security deposit. Drives the underwriting decision in the application workflow.. Valid values are `pass|fail|conditional_pass|inconclusive`',
    `portfolio_type` STRING COMMENT 'Indicates whether the screening was conducted for a residential (B2C) or commercial (B2B) tenancy application. Determines applicable screening criteria, fair housing rules, and regulatory requirements.. Valid values are `residential|commercial`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this screening order, typically issued by the screening vendor (e.g., RentPrep, TransUnion SmartMove) upon order submission. Used for vendor reconciliation and audit trail.',
    `report_expiry_date` DATE COMMENT 'Date after which the screening report is considered stale and a new screening must be ordered before a lease can be executed. Typically 30–90 days from completion date per company policy and FCRA guidelines.',
    `report_url` STRING COMMENT 'Secure URL or storage reference to the full screening report document returned by the vendor. Access is restricted to authorized personnel. Supports document retrieval for adverse action, audit, and underwriting review.',
    `request_date` DATE COMMENT 'Calendar date on which the screening order was submitted to the vendor. Establishes the start of the screening timeline and is used to calculate turnaround time and report expiry.',
    `review_date` DATE COMMENT 'Date on which the authorized reviewer completed their assessment of the screening results and recorded the qualification determination. Part of the audit trail for the application decision.',
    `screening_status` STRING COMMENT 'Current lifecycle status of the screening order. Tracks progression from initial request through vendor processing to final determination. Drives workflow routing in the application qualification process.. Valid values are `pending|in_progress|completed|cancelled|expired`',
    `sex_offender_check_result` STRING COMMENT 'Result of the national sex offender registry (NSOPW) check. A fail result requires individualized assessment and documented adverse action notice per FCRA and HUD fair housing guidance before denial.. Valid values are `pass|fail|not_conducted`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the screening record. Tracks changes to screening status, results, or compliance flags throughout the screening lifecycle.',
    `vendor` STRING COMMENT 'Name of the third-party background screening service provider used to conduct the checks (e.g., RentPrep, TransUnion SmartMove, Experian RentBureau, CoreLogic SafeRent). Required for FCRA adverse action notices and vendor audit trails.',
    `vendor_order_code` STRING COMMENT 'Unique order or transaction identifier assigned by the screening vendor system for this specific screening request. Used for vendor portal reconciliation, dispute resolution, and FCRA reinvestigation requests.',
    CONSTRAINT pk_screening PRIMARY KEY(`screening_id`)
) COMMENT 'Tenant background screening and reference verification record capturing the results of employment verification, landlord reference checks, criminal background checks, identity verification (SSN/ITIN validation), and sex offender registry checks performed during the application qualification process. Records screening vendor (e.g., RentPrep, TransUnion SmartMove), screening request date, completion date, pass/fail determination per check type, adverse action notice requirement, and FCRA compliance status. Supports fair housing compliance, consistent screening criteria enforcement, and audit trail for adverse action decisions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ADD CONSTRAINT `fk_tenant_tenant_contact_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ADD CONSTRAINT `fk_tenant_tenant_contact_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ADD CONSTRAINT `fk_tenant_tenant_contact_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_parent_entity_corporate_entity_id` FOREIGN KEY (`parent_entity_corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `real_estate_ecm`.`tenant`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_tenant_prospect_id` FOREIGN KEY (`tenant_prospect_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_prospect`(`tenant_prospect_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_arrears_event_id` FOREIGN KEY (`arrears_event_id`) REFERENCES `real_estate_ecm`.`tenant`.`arrears_event`(`arrears_event_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `real_estate_ecm`.`tenant`.`notice`(`notice_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_retention_action_id` FOREIGN KEY (`retention_action_id`) REFERENCES `real_estate_ecm`.`tenant`.`retention_action`(`retention_action_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_screening_id` FOREIGN KEY (`screening_id`) REFERENCES `real_estate_ecm`.`tenant`.`screening`(`screening_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_tenant_prospect_id` FOREIGN KEY (`tenant_prospect_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_prospect`(`tenant_prospect_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_arrears_event_id` FOREIGN KEY (`arrears_event_id`) REFERENCES `real_estate_ecm`.`tenant`.`arrears_event`(`arrears_event_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_screening_id` FOREIGN KEY (`screening_id`) REFERENCES `real_estate_ecm`.`tenant`.`screening`(`screening_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_arrears_event_id` FOREIGN KEY (`arrears_event_id`) REFERENCES `real_estate_ecm`.`tenant`.`arrears_event`(`arrears_event_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `real_estate_ecm`.`tenant`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `real_estate_ecm`.`tenant`.`notice`(`notice_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_previous_version_document_id` FOREIGN KEY (`previous_version_document_id`) REFERENCES `real_estate_ecm`.`tenant`.`document`(`document_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_retention_action_id` FOREIGN KEY (`retention_action_id`) REFERENCES `real_estate_ecm`.`tenant`.`retention_action`(`retention_action_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_screening_id` FOREIGN KEY (`screening_id`) REFERENCES `real_estate_ecm`.`tenant`.`screening`(`screening_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_tenant_prospect_id` FOREIGN KEY (`tenant_prospect_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_prospect`(`tenant_prospect_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `real_estate_ecm`.`tenant`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `real_estate_ecm`.`tenant`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `real_estate_ecm`.`tenant`.`notice`(`notice_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_prior_screening_id` FOREIGN KEY (`prior_screening_id`) REFERENCES `real_estate_ecm`.`tenant`.`screening`(`screening_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`tenant` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `real_estate_ecm`.`tenant` SET TAGS ('dbx_domain' = 'tenant');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Identifier');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Property Manager Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Tenant Annual Revenue');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_business_glossary_term' = 'Billing Address City');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Country');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Postal Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_state` SET TAGS ('dbx_business_glossary_term' = 'Billing Address State / Province');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `billing_address_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Tenant Credit Score');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `credit_score_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Score Assessment Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `credit_score_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `credit_tier` SET TAGS ('dbx_business_glossary_term' = 'Tenant Credit Tier');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `credit_tier` SET TAGS ('dbx_value_regex' = 'A|B|C|D|unrated');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `credit_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Tenant Employee Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `employee_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Tenant Entity Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'individual|corporation|partnership|llc|trust|government');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `esg_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Data Consent Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `first_lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'First Lease Commencement Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `guarantor_required` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Required Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `hoa_code` SET TAGS ('dbx_business_glossary_term' = 'Homeowners Association (HOA) Membership ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `hoa_member` SET TAGS ('dbx_business_glossary_term' = 'Homeowners Association (HOA) Member Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `kyc_verified` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verified Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `kyc_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `lease_count` SET TAGS ('dbx_business_glossary_term' = 'Active Lease Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Tenant Legal Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Tenant Lifecycle Stage');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'prospect|applicant|active|former|evicted');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `most_recent_lease_expiry` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Lease Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `mri_tenant_code` SET TAGS ('dbx_business_glossary_term' = 'MRI Software Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Tenant Onboarding Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `portal_access_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tenant Portal Access Enabled Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal|mail|sms');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `prospect_source` SET TAGS ('dbx_business_glossary_term' = 'Prospect Source Channel');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Tenant Trading Name (DBA)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `trading_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ALTER COLUMN `yardi_tenant_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Tenant Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `tenant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Contact ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `access_card_number` SET TAGS ('dbx_business_glossary_term' = 'Building Access Card Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `access_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|passed|failed|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|do_not_contact|deceased|archived');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'individual|household_member|corporate_representative|guarantor|prospect');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Contact Date of Birth');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `gdpr_consent_given` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Given Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `is_authorized_signatory` SET TAGS ('dbx_business_glossary_term' = 'Is Authorized Signatory Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `is_emergency_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Contact Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Address Line 1');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Address Line 2');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing City');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Postal Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing State or Province');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_business_glossary_term' = 'National Identifier Last 4 Digits');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_type` SET TAGS ('dbx_business_glossary_term' = 'National Identifier Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_type` SET TAGS ('dbx_value_regex' = 'ssn|passport|drivers_license|national_id|itin');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `national_id_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Extension');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_value_regex' = '^d{1,6}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_office` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_office` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_office` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `phone_office` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `portal_access_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tenant Portal Access Enabled Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `portal_username` SET TAGS ('dbx_business_glossary_term' = 'Tenant Portal Username');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `portal_username` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `preferred_comm_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `preferred_comm_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|portal|fax');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `preferred_comm_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `preferred_comm_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `property_access_level` SET TAGS ('dbx_business_glossary_term' = 'Property Access Level');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `property_access_level` SET TAGS ('dbx_value_regex' = 'none|common_areas|leased_premises|full_building|restricted_zones');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship End Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship Start Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Secondary Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ALTER COLUMN `yardi_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Contact ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `parent_entity_corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Corporate Entity ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Registered Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `annual_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (USD)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `annual_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_value_regex' = 'Moodys|S&P|Fitch|DBRS|Kroll');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `credit_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Credit Score');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `employee_headcount` SET TAGS ('dbx_business_glossary_term' = 'Employee Headcount');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `employee_headcount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'prospect|active|inactive|terminated|suspended');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `esg_rating` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Rating');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy Level');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'ultimate_parent|parent|subsidiary|joint_venture|affiliate');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `is_publicly_traded` SET TAGS ('dbx_business_glossary_term' = 'Publicly Traded Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `is_reit` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Investment Trust (REIT) Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|rejected|expired');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `kyc_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_business_glossary_term' = 'Registered Address City');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Country');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Postal Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_state` SET TAGS ('dbx_business_glossary_term' = 'Registered Address State');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registered_address_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Corporate Registration Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `revenue_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Revenue Fiscal Year');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `stock_exchange` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `stock_exchange` SET TAGS ('dbx_value_regex' = 'NYSE|NASDAQ|LSE|TSX|ASX|OTHER');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `stock_ticker` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `stock_ticker` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,5}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name (DBA)');
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ALTER COLUMN `yardi_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Entity Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `accessibility_accommodation_required` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation Required Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `adult_count` SET TAGS ('dbx_business_glossary_term' = 'Adult Occupant Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Household Application Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Household Application Approval Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'pending|clear|adverse_action|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `combined_annual_income` SET TAGS ('dbx_business_glossary_term' = 'Combined Annual Household Income');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `combined_annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `combined_annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `crm_prospect_code` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Prospect ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Occupant Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `eviction_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Eviction History Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `fair_housing_protected_class_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Protected Class Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `has_pets` SET TAGS ('dbx_business_glossary_term' = 'Pet Ownership Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `hoa_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'HOA (Homeowners Association) Fee Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `hoa_member` SET TAGS ('dbx_business_glossary_term' = 'HOA (Homeowners Association) Membership Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Household Lifecycle Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `move_in_date` SET TAGS ('dbx_business_glossary_term' = 'Move-In Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `move_out_date` SET TAGS ('dbx_business_glossary_term' = 'Move-Out Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `notice_to_vacate_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Vacate Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `parking_spaces_assigned` SET TAGS ('dbx_business_glossary_term' = 'Assigned Parking Spaces Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `pet_count` SET TAGS ('dbx_business_glossary_term' = 'Registered Pet Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `pet_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Pet Deposit Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|portal|mail');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `renters_insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Renters Insurance Requirement Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `security_deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `security_deposit_status` SET TAGS ('dbx_value_regex' = 'held|partially_refunded|fully_refunded|forfeited');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `vehicle_count` SET TAGS ('dbx_business_glossary_term' = 'Registered Vehicle Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ALTER COLUMN `yardi_household_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Household Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Security Deposit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `adverse_action_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `adverse_action_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Authorization Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `authorization_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Authorization Document Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Chapter Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_value_regex' = 'Chapter 7|Chapter 11|Chapter 13|Other');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Discharge Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_discharge_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_discharge_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy History Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bureau_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Bureau Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bureau_name` SET TAGS ('dbx_value_regex' = 'Equifax|Experian|TransUnion|Dun & Bradstreet|Other');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bureau_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Bureau Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bureau_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `bureau_reference_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `collections_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Collections Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `collections_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `collections_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `collections_flag` SET TAGS ('dbx_business_glossary_term' = 'Collections Account Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `collections_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `collections_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Authorization Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_check_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Authorization Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Currency Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_score_model` SET TAGS ('dbx_business_glossary_term' = 'Credit Score Model');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_score_model` SET TAGS ('dbx_value_regex' = 'FICO 8|FICO 9|VantageScore 3.0|VantageScore 4.0|Commercial|Other');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_tier` SET TAGS ('dbx_business_glossary_term' = 'Credit Tier Classification');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `credit_tier` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_business_glossary_term' = 'Debt-to-Income Ratio (DTI)');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `eviction_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Eviction Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `eviction_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `eviction_count` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `guarantor_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Requirement Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `income_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Method');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `income_verification_method` SET TAGS ('dbx_value_regex' = 'pay_stub|tax_return|bank_statement|employer_letter|third_party_service|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `monthly_gross_income` SET TAGS ('dbx_business_glossary_term' = 'Monthly Gross Income');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `monthly_gross_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `monthly_gross_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `outstanding_judgments_flag` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Judgments Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `outstanding_judgments_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `outstanding_judgments_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `prior_eviction_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Eviction Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `prior_eviction_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `prior_eviction_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|withdrawn|under_review');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `recommended_max_rent` SET TAGS ('dbx_business_glossary_term' = 'Recommended Maximum Rent');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `recommended_max_rent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `recommended_max_rent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `review_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `security_deposit_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Multiplier');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Yardi Voyager|MRI Software|Salesforce CRM|Manual|Other');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `tenant_type` SET TAGS ('dbx_business_glossary_term' = 'Tenant Type Classification');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `tenant_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|retail');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|declined|pending');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `underwriting_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `underwriting_notes` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ALTER COLUMN `underwriting_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` SET TAGS ('dbx_subdomain' = 'leasing_operations');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `tenant_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Prospect ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `buyer_representation_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Representation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Lead ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `digital_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Leasing Agent ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Lease ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `loi_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Loi Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `application_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|passed|failed|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_max_monthly` SET TAGS ('dbx_business_glossary_term' = 'Budget Maximum Monthly Rent');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_max_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_max_monthly` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_min_monthly` SET TAGS ('dbx_business_glossary_term' = 'Budget Minimum Monthly Rent');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_min_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_min_monthly` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_psf` SET TAGS ('dbx_business_glossary_term' = 'Budget Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `budget_psf` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `conversion_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Conversion Probability Percentage');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|passed|failed|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `desired_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Desired Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `desired_move_in_date` SET TAGS ('dbx_business_glossary_term' = 'Desired Move-In Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `desired_size_max_sqft` SET TAGS ('dbx_business_glossary_term' = 'Desired Maximum Size (Square Feet)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `desired_size_min_sqft` SET TAGS ('dbx_business_glossary_term' = 'Desired Minimum Size (Square Feet)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Prospect Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `expected_lease_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Lease Value');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `expected_lease_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `expected_lease_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `is_marketing_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `lead_source_detail` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Detail');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `lost_reason` SET TAGS ('dbx_business_glossary_term' = 'Lost Reason');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Prospect Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `pipeline_notes` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `pipeline_status` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `pipeline_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|converted|lost|disqualified');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|portal|in_person');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Full Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|retail|mixed_use|government');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Prospect Segment');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'b2b_corporate|b2c_individual|b2b_sme|b2b_enterprise|nonprofit|government');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `tour_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Tour Completed Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `tour_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Tour Scheduled Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` SET TAGS ('dbx_subdomain' = 'leasing_operations');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `digital_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `loi_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Loi Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `negotiation_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Loi Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `tenant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Contact Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `tenant_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Prospect Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `annual_income` SET TAGS ('dbx_business_glossary_term' = 'Applicant Annual Income');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `annual_income` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Legal Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `applicant_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|guarantor|co_applicant');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|declined|withdrawn');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Applicant Credit Score');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `credit_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'CRM Opportunity ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Application Decision Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Application Decline Reason Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_business_glossary_term' = 'Debt-to-Income Ratio (DTI)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `fee_paid` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Paid Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `financial_docs_checklist` SET TAGS ('dbx_business_glossary_term' = 'Financial Documents Checklist');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `financial_docs_checklist` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `free_rent_months_requested` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Months Requested');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `guarantor_required` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Required Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'commercial|residential');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `proposed_base_rent_monthly` SET TAGS ('dbx_business_glossary_term' = 'Proposed Monthly Base Rent');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `proposed_base_rent_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `proposed_lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `proposed_lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease Commencement Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `proposed_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `proposed_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Proposed Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `proposed_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `requested_gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Requested Gross Leasable Area (GLA) in Square Feet');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `requested_nla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Requested Net Leasable Area (NLA) in Square Feet');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Application Source Channel');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'online_portal|broker_referral|direct_inquiry|mls|walk_in|corporate_relocation');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `ti_allowance_requested` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Requested');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `ti_allowance_requested` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ALTER COLUMN `yardi_application_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Application Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` SET TAGS ('dbx_subdomain' = 'leasing_operations');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `tenant_occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `owner_ownership_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `parking_id` SET TAGS ('dbx_business_glossary_term' = 'Parking Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `access_card_count` SET TAGS ('dbx_business_glossary_term' = 'Access Card Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Record Effective From Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Until Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Occupancy End Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `holdover_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdover Start Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `is_holdover` SET TAGS ('dbx_business_glossary_term' = 'Is Holdover Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `is_sublease` SET TAGS ('dbx_business_glossary_term' = 'Is Sublease Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `key_handover_date` SET TAGS ('dbx_business_glossary_term' = 'Key Handover Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `move_in_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Move-In Condition Rating');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `move_in_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `move_in_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Move-In Inspection Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `move_out_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Move-Out Condition Rating');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `move_out_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `move_out_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Move-Out Inspection Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `num_occupants` SET TAGS ('dbx_business_glossary_term' = 'Number of Occupants');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'active|vacated|pending_handover|holdover|terminated|scheduled');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `occupancy_type` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `occupancy_type` SET TAGS ('dbx_value_regex' = 'primary|sublease|holdover|license|co_occupancy|temporary');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `occupied_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Occupied Area in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `occupied_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Occupied Area in Square Metres (SQM)');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `parking_bays_allocated` SET TAGS ('dbx_business_glossary_term' = 'Parking Bays Allocated');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'commercial|residential');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `premises_identifier` SET TAGS ('dbx_business_glossary_term' = 'Premises Identifier');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `ref_number` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `scheduled_vacate_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Vacate Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi|mri|building_engines|manual|other');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Start Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `ti_completed` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Completed Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `ti_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Completion Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `vacate_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Vacate Reason Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ALTER COLUMN `vacate_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Vacate Reason Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Address Line 1');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Address Line 2');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Annual Income');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `cash_deposit_account` SET TAGS ('dbx_business_glossary_term' = 'Cash Deposit Account Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `cash_deposit_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `cash_deposit_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Guarantor City');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Country Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `credit_bureau` SET TAGS ('dbx_business_glossary_term' = 'Credit Bureau');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `credit_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Qualification Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `credit_qualification_status` SET TAGS ('dbx_value_regex' = 'approved|conditionally_approved|declined|pending_review|expired');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Credit Score');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `document_ref_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Document Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_business_glossary_term' = 'Debt-to-Income Ratio (DTI)');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `dti_ratio` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Effective Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Execution Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantee_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Instrument Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantee_instrument_type` SET TAGS ('dbx_value_regex' = 'personal_guarantee|letter_of_credit|surety_bond|cash_deposit|corporate_guarantee');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantee_notes` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_value_regex' = 'active|expired|released|called|pending|cancelled');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guaranteed_amount` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guaranteed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guaranteed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guaranteed_pct` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Percentage of Lease Obligation');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|institutional|government|trust');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `is_foreign_entity` SET TAGS ('dbx_business_glossary_term' = 'Foreign Entity Indicator');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `lc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `lc_issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Issuing Bank');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `lc_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Legal Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `net_worth` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Net Worth');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `net_worth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `net_worth` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Postal Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Primary Email Address');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Primary Phone Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `ref_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `relationship_to_tenant` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Relationship to Tenant');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Release Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Guarantor State or Province');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ALTER COLUMN `yardi_guarantor_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Guarantor Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `arrears_event_id` SET TAGS ('dbx_business_glossary_term' = 'Arrears Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `negotiation_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Loi Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `notice_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `retention_action_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `screening_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Request ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `tenant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Contact Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `tenant_occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `tenant_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Prospect Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|in_person|portal_message|site_tour|video_call');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Interaction Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Activity ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `deal_stage` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Deal Stage');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Interaction Direction');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Minutes)');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Interaction Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Interaction Language Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Interaction Location Description');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `loi_referenced` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Referenced Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'resolved|escalated|pending|no_action|follow_up_scheduled|converted');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Tenant Satisfaction Score');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `sentiment` SET TAGS ('dbx_business_glossary_term' = 'Interaction Sentiment');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `sentiment` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|yardi_voyager|building_engines|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Interaction Summary');
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `notice_id` SET TAGS ('dbx_business_glossary_term' = 'Notice ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `arrears_event_id` SET TAGS ('dbx_business_glossary_term' = 'Arrears Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By User ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `owner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `screening_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `tenant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Contact Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `tenant_occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `cure_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Deadline Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `cured_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Cured Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `default_description` SET TAGS ('dbx_business_glossary_term' = 'Default or Violation Description');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `delivery_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmed Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Notice Delivery Method');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'certified_mail|email|tenant_portal|in_person|courier|posting');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `delivery_tracking_reference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tracking Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Notice Direction');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Notice Document Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Effective Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `estoppel_due_date` SET TAGS ('dbx_business_glossary_term' = 'Estoppel Certificate Due Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `estoppel_requested_by` SET TAGS ('dbx_business_glossary_term' = 'Estoppel Certificate Requested By');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `hoa_violation_code` SET TAGS ('dbx_business_glossary_term' = 'HOA (Homeowners Association) Violation Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Issue Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `legal_counsel_engaged` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Engaged Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `litigation_hold` SET TAGS ('dbx_business_glossary_term' = 'Litigation Hold Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `new_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'New Rent Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `new_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notice Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_value_regex' = '^NTC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Notice Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `renewal_offer_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Offer Rent Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `renewal_offer_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `renewal_offer_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Offer Term (Months)');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `rent_increase_amount` SET TAGS ('dbx_business_glossary_term' = 'Rent Increase Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `rent_increase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `rent_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Rent Increase Percentage');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `rent_increase_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Response Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Statutory Response Deadline Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `response_received` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `response_summary` SET TAGS ('dbx_business_glossary_term' = 'Notice Response Summary');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ALTER COLUMN `vacate_date` SET TAGS ('dbx_business_glossary_term' = 'Vacate Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `arrears_event_id` SET TAGS ('dbx_business_glossary_term' = 'Arrears Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `notice_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `owner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `previous_version_document_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version Document ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `retention_action_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `screening_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `tenant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Contact Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `tenant_occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `tenant_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Prospect Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Document Access Restriction Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Document Confidentiality Level');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `digital_signature_status` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `digital_signature_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|partially_signed|completed|declined|voided');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'legal|financial|identity|compliance|operational|correspondence');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'active|expired|superseded|archived|pending_review');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Document Effective Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Document Execution Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Document File Size (Kilobytes)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Document Verified Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Document Issuing Authority');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Document Issuing Country');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Document Language Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Document Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `purge_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Document Purge Eligible Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Document Received Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period (Years)');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Document Review Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `signatory_count` SET TAGS ('dbx_business_glossary_term' = 'Required Signatory Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Document Source System');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Reference');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `storage_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `upload_date` SET TAGS ('dbx_business_glossary_term' = 'Document Upload Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Verification Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `arrears_event_id` SET TAGS ('dbx_business_glossary_term' = 'Arrears Event ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Property Manager (PM) ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Security Deposit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `owner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `relationship_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `tenant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Contact Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `tenant_occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `arrears_stage` SET TAGS ('dbx_business_glossary_term' = 'Arrears Stage');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `arrears_stage` SET TAGS ('dbx_value_regex' = 'first_notice|second_notice|demand_letter|legal_referral|eviction_proceedings');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Arrears Charge Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'base_rent|cam|tax|insurance|utility|other');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `collection_action_notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `cure_date` SET TAGS ('dbx_business_glossary_term' = 'Arrears Cure Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `demand_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Letter Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Arrears Event Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Arrears Event Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_value_regex' = '^ARR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `eviction_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Eviction Filing Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `first_notice_date` SET TAGS ('dbx_business_glossary_term' = 'First Notice Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `interest_accrued` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrued on Arrears');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `interest_accrued` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `interest_accrued` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `legal_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `legal_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Referral Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `partial_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `partial_payment_received` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Received');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `partial_payment_received` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `partial_payment_received` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `payment_plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan End Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `payment_plan_instalment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Instalment Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `payment_plan_instalment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `payment_plan_instalment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `payment_plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Start Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'commercial|residential');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Arrears Resolution Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|payment_plan|cured|written_off|legal_recovery|closed');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `second_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Second Notice Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `security_deposit_applied` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Applied Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `security_deposit_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Applied Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `security_deposit_applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `security_deposit_applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `tenant_retention_risk` SET TAGS ('dbx_business_glossary_term' = 'Tenant Retention Risk Level');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `tenant_retention_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `total_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Total Outstanding Arrears Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `total_outstanding` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `total_outstanding` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` SET TAGS ('dbx_subdomain' = 'relationship_services');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `retention_action_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Action ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Campaign ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `negotiation_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Loi Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `notice_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `owner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Contact Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Closed Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Due Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_notes` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|awaiting_response|closed_retained|closed_lost|cancelled');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `cam_rate_psf` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Rate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `cam_rate_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'CRM Activity ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `current_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Current Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `current_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation to Senior Asset Management Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percentage|cpi_indexed|fixed_amount|market_review|stepped');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `free_rent_months_offered` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Months Offered');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `free_rent_months_offered` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `leased_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Leased Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `loi_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `loi_issued` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Issued');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `market_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Market Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `market_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `months_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Months to Lease Expiry');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Retention Outcome');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'retained|lost|pending|renewal_signed|relocated_within_portfolio|vacated');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `outreach_channel` SET TAGS ('dbx_business_glossary_term' = 'Outreach Channel');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `outreach_channel` SET TAGS ('dbx_value_regex' = 'email|phone|in_person_meeting|formal_letter|video_call|broker_intermediary');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Retention Action Priority Level');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `proposed_lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease End Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `proposed_lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease Start Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `proposed_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `proposed_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Proposed Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `proposed_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `rent_abatement_amount` SET TAGS ('dbx_business_glossary_term' = 'Rent Abatement Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `rent_abatement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `rent_escalation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate Percentage');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `rent_escalation_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_credit_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Tenant Credit Risk Rating');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_credit_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_response` SET TAGS ('dbx_business_glossary_term' = 'Tenant Response');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_response` SET TAGS ('dbx_value_regex' = 'interested|not_interested|counter_proposal|no_response|escalated|deferred');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `tenant_response_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Response Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `ti_allowance_total` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Total');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `ti_allowance_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` SET TAGS ('dbx_subdomain' = 'leasing_operations');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `screening_id` SET TAGS ('dbx_business_glossary_term' = 'Screening ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Prospect ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `owner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `prior_screening_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `adverse_action_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `adverse_action_reason_codes` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Reason Codes');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `adverse_action_required` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Required Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `applicant_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Applicant Consent Obtained Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `applicant_type` SET TAGS ('dbx_value_regex' = 'individual|corporate_entity|guarantor|co_applicant');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Completion Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Applicant Consent Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `credit_check_result` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `credit_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_conducted');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `credit_score_at_screening` SET TAGS ('dbx_business_glossary_term' = 'Credit Score at Screening');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `credit_score_at_screening` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `credit_score_at_screening` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `criminal_check_result` SET TAGS ('dbx_business_glossary_term' = 'Criminal Background Check Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `criminal_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|review_required|not_conducted');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `criminal_check_scope` SET TAGS ('dbx_business_glossary_term' = 'Criminal Check Scope');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `criminal_check_scope` SET TAGS ('dbx_value_regex' = 'county|state|national|international');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Screening Criteria Version');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `employment_verification_result` SET TAGS ('dbx_business_glossary_term' = 'Employment Verification Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `employment_verification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|unable_to_verify|not_conducted');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `eviction_check_result` SET TAGS ('dbx_business_glossary_term' = 'Eviction History Check Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `eviction_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|review_required|not_conducted');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `fair_housing_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Review Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `fcra_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Credit Reporting Act (FCRA) Compliance Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Screening Fee Amount');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'ssn_validation|itin_validation|government_id|passport|other');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `identity_verification_result` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `identity_verification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|unable_to_verify');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `income_to_rent_ratio` SET TAGS ('dbx_business_glossary_term' = 'Income-to-Rent Ratio');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `income_to_rent_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `income_to_rent_ratio` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `individualized_assessment_conducted` SET TAGS ('dbx_business_glossary_term' = 'Individualized Assessment Conducted Flag');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `landlord_reference_count` SET TAGS ('dbx_business_glossary_term' = 'Landlord Reference Count');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `landlord_reference_result` SET TAGS ('dbx_business_glossary_term' = 'Landlord Reference Check Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `landlord_reference_result` SET TAGS ('dbx_value_regex' = 'pass|fail|unable_to_verify|not_conducted');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Screening Notes');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Screening Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|inconclusive');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'residential|commercial');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `report_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Report Expiry Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Screening Report URL');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Request Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Review Date');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|expired');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `sex_offender_check_result` SET TAGS ('dbx_business_glossary_term' = 'Sex Offender Registry Check Result');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `sex_offender_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_conducted');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Screening Vendor');
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ALTER COLUMN `vendor_order_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Order ID');
