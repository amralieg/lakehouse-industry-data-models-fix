-- Schema for Domain: customer | Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`customer` COMMENT 'Single source of truth for all customer identities — research institutions, clinical laboratories, biopharma partners, agricultural genomics clients, OEM accounts, and individual researchers. Owns customer profiles, account hierarchies, contacts, segmentation (RUO vs. IVD/clinical), consent records, technical requirements, service agreements, and relationship history. Master data managed via Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the customer account. Primary key for the account entity.',
    `parent_account_id` BIGINT COMMENT 'Reference to the parent account in a corporate hierarchy. Used for multi-site organizations, hospital systems, university networks, and corporate subsidiaries. Enables roll-up reporting and consolidated billing.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Account has market_segment (STRING) which should be normalized to customer_segment_id FK. The customer_segment table exists as a reference table with segment_code, segment_name, regulatory_use_classif',
    `account_status` STRING COMMENT 'Current lifecycle status of the customer account. Active (operational), Inactive (dormant but not closed), Suspended (temporarily blocked), Pending Approval (new account under review), Closed (permanently terminated).. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `account_type` STRING COMMENT 'Primary classification of the customer account based on business relationship and product usage. RUO (Research Use Only), IVD/Clinical (In Vitro Diagnostic), OEM (Original Equipment Manufacturer), Agricultural Genomics, Biopharma Partner, or Academic/Government Institution.. Valid values are `ruo|ivd_clinical|oem|agricultural|biopharma|academic_government`',
    `assigned_territory` STRING COMMENT 'Sales territory or region to which this account is assigned. Used for sales quota allocation, territory management, and field application scientist assignment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account record was first created in the system. Used for audit trails and data lineage.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit approved for the account in the account currency. Used for order approval workflows and credit risk management.',
    `crm_account_code` STRING COMMENT 'External identifier from Salesforce CRM Account object. Used for cross-system reconciliation and integration.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the accounts default transaction currency. Used for pricing, invoicing, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `dba_name` STRING COMMENT 'Trade name or operating name used by the customer if different from legal entity name. Common for research institutions and clinical laboratories.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet identifier for the business entity. Used for credit assessment, supplier verification, and regulatory reporting.. Valid values are `^[0-9]{9}$`',
    `erp_customer_number` STRING COMMENT 'Customer master number from SAP S/4HANA SD (Sales and Distribution) module. Used for order processing, billing, and financial transactions.',
    `established_date` DATE COMMENT 'Date when the customer account was first established in the system. Represents the start of the business relationship.',
    `gdpr_consent_date` DATE COMMENT 'Date when GDPR consent was obtained from the account. Used for consent lifecycle management and audit trails.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the account has provided consent for data processing under GDPR requirements. True if consent obtained, False otherwise. Required for EU-based accounts.',
    `hipaa_baa_effective_date` DATE COMMENT 'Effective date of the executed HIPAA Business Associate Agreement. Used for compliance tracking and audit readiness.',
    `hipaa_baa_flag` BOOLEAN COMMENT 'Indicates whether a HIPAA Business Associate Agreement is in place for this account. True if BAA executed, False otherwise. Required for clinical and IVD accounts handling Protected Health Information (PHI).',
    `industry_vertical` STRING COMMENT 'Industry sector or vertical market segment of the customer. Examples: clinical diagnostics, pharmaceutical research, agricultural biotechnology, academic research, contract research organization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this account record was last updated. Used for change tracking, synchronization, and audit trails.',
    `last_order_date` DATE COMMENT 'Date of the most recent order placed by this account. Used for customer activity tracking, churn risk analysis, and reactivation campaigns.',
    `legal_entity_name` STRING COMMENT 'Official registered legal name of the customer organization or individual. Used for contracts, invoicing, and regulatory compliance.',
    `owner_name` STRING COMMENT 'Name of the sales representative or account manager assigned as the primary owner of this account. Used for relationship management and accountability.',
    `preferred_language_code` STRING COMMENT 'Two-letter ISO language code for the accounts preferred communication language. Used for documentation, support, and correspondence.. Valid values are `^[a-z]{2}$`',
    `pricing_tier` STRING COMMENT 'Pricing tier assigned to the account based on volume commitments, strategic relationship, and negotiated terms. Determines discount levels and special pricing agreements.. Valid values are `enterprise|volume|standard|promotional`',
    `primary_address_line1` STRING COMMENT 'First line of the primary business address for the account. Typically contains street number and street name.',
    `primary_address_line2` STRING COMMENT 'Second line of the primary business address. Used for suite numbers, building names, department identifiers, or additional location details.',
    `primary_city` STRING COMMENT 'City or municipality of the primary business address.',
    `primary_country_code` STRING COMMENT 'Three-letter ISO country code for the primary business address. Used for regulatory compliance, export controls, and regional reporting.. Valid values are `^[A-Z]{3}$`',
    `primary_email` STRING COMMENT 'Primary business email address for account-level communication, notifications, and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Main business telephone number for the account. Used for customer service, technical support, and business communication.',
    `primary_postal_code` STRING COMMENT 'Postal code or ZIP code of the primary business address. Format varies by country.',
    `primary_state_province` STRING COMMENT 'State, province, or administrative region of the primary business address. Format varies by country (two-letter state code in USA, province name in other jurisdictions).',
    `segment_change_reason` STRING COMMENT 'Business reason for the most recent market segment classification change. Examples: product portfolio shift, regulatory status change, acquisition, business model pivot.',
    `segment_effective_date` DATE COMMENT 'Date when the current market segment classification became effective. Used for tracking segment transitions and historical analysis.',
    `sla_tier` STRING COMMENT 'Service level tier defining response times, technical support priority, and service commitments. Platinum (24/7 premium support), Gold (priority business hours), Silver (enhanced standard), Standard (basic support).. Valid values are `platinum|gold|silver|standard`',
    `strategic_tier` STRING COMMENT 'Strategic importance tier assigned to the account. Key Account (top-tier strategic partners), Growth (high-potential emerging accounts), or Standard (regular commercial accounts). Drives resource allocation and service levels.. Valid values are `key_account|growth|standard`',
    `tax_identifier` STRING COMMENT 'Tax identification number for the customer entity. Format varies by jurisdiction (EIN in USA, VAT number in EU, GST number in other regions). Used for tax reporting and invoice compliance.',
    `vat_registration_number` STRING COMMENT 'VAT registration number for customers in VAT jurisdictions. Required for cross-border EU transactions and tax compliance.',
    `website_url` STRING COMMENT 'Official website URL of the customer organization. Used for research, validation, and business intelligence.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for every customer account served by Genomics Biotech — research institutions, clinical laboratories, biopharma partners, agricultural genomics clients, OEM accounts, and individual researchers. Sourced from Salesforce CRM Account object. Stores legal entity name, account type (RUO, IVD/clinical, OEM, agricultural, biopharma), industry vertical, tier classification, account status, primary address, tax/VAT identifiers, DUNS number, parent account reference for hierarchy, assigned territory, CRM account ID, ERP customer number (SAP SD), credit limit, currency, preferred language, data privacy consent flags (GDPR, HIPAA), market segment classification (RUO, IVD/clinical, biopharma, agricultural, OEM, academic/government), strategic tier (key account, growth, standard), pricing tier, SLA tier, segment effective date, and segment change reason. Segment classification is the authoritative source — no separate segment entity exists.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the parent customer account this contact is associated with. Links contact to organizational account hierarchy.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: In genomics biotech, contacts are segmented by specific product interest (e.g., sequencing vs. array vs. gene-editing) for targeted marketing campaigns and sales outreach. Replaces denormalized produc',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Contact has embedded mailing address fields (mailing_street, mailing_city, mailing_state_province, mailing_postal_code, mailing_country_code) which should be normalized to mailing_address_id FK to the',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: contact currently has a customer_segment STRING field which is a denormalized copy of segment classification data. The segment table is the authoritative source for market segmentation (RUO vs. IVD/cl',
    `contact_role` STRING COMMENT 'Primary functional role of the contact within the customer relationship (technical, commercial, billing, regulatory, procurement, clinical, research). [ENUM-REF-CANDIDATE: technical|commercial|billing|regulatory|procurement|clinical|research — 7 candidates stripped; promote to reference product]',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record (active, inactive, suspended, pending_verification).. Valid values are `active|inactive|suspended|pending_verification`',
    `contact_type` STRING COMMENT 'Specific classification of the contact based on their professional function (principal investigator, lab director, procurement officer, field application scientist, clinical specialist, purchasing contact).. Valid values are `principal_investigator|lab_director|procurement_officer|field_application_scientist|clinical_specialist|purchasing_contact`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the system.',
    `department` STRING COMMENT 'Organizational department or division where the contact works (e.g., Genomics Research, Clinical Laboratory, Procurement, Bioinformatics).',
    `email_address` STRING COMMENT 'Primary email address for professional communication with the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the contact, used for document transmission in regulated environments.',
    `first_name` STRING COMMENT 'Given name of the contact person.',
    `full_name` STRING COMMENT 'Complete concatenated name of the contact including salutation, first, middle, last, and suffix.',
    `gdpr_consent_date` DATE COMMENT 'Date when GDPR consent was obtained or last updated.',
    `gdpr_consent_status` STRING COMMENT 'Current GDPR consent status for processing the contacts personal data (consented, not_consented, withdrawn, pending).. Valid values are `consented|not_consented|withdrawn|pending`',
    `job_title` STRING COMMENT 'Professional job title or role of the contact within their organization (e.g., Principal Investigator, Lab Director, Procurement Officer, Clinical Genomics Specialist).',
    `language_preference` STRING COMMENT 'Two-letter ISO language code representing the contacts preferred language for communication (e.g., en, de, fr, es, ja, zh).. Valid values are `^[a-z]{2}$`',
    `last_activity_date` DATE COMMENT 'Date of the most recent activity or interaction with this contact (email, call, meeting, support case).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was last modified or updated.',
    `last_name` STRING COMMENT 'Family name or surname of the contact person.',
    `lead_source` STRING COMMENT 'Original source through which this contact was acquired (web, referral, conference, trade_show, partner, direct_sales, advertisement, other). [ENUM-REF-CANDIDATE: web|referral|conference|trade_show|partner|direct_sales|advertisement|other — 8 candidates stripped; promote to reference product]',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the contact has opted in to receive marketing communications (True/False).',
    `marketing_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the contact has opted out of marketing communications (True/False).',
    `middle_name` STRING COMMENT 'Middle name or initial of the contact person.',
    `mobile_phone_number` STRING COMMENT 'Mobile or cellular phone number for the contact.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the contact relationship and interactions.',
    `owner_name` STRING COMMENT 'Name of the Salesforce CRM user or field application scientist who owns and manages this contact relationship.',
    `phi_authorization_date` DATE COMMENT 'Date when PHI handling authorization was granted or last verified.',
    `phi_handling_authorization_flag` BOOLEAN COMMENT 'Indicates whether the contact is authorized to handle Protected Health Information under HIPAA regulations (True/False).',
    `phone_number` STRING COMMENT 'Primary business phone number for the contact.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication (email, phone, mobile, fax, portal, in-person).. Valid values are `email|phone|mobile|fax|portal|in_person`',
    `research_focus` STRING COMMENT 'Primary research focus or application area for the contact (e.g., Cancer Genomics, Agricultural Genomics, Rare Disease, Pharmacogenomics, Population Health).',
    `salutation` STRING COMMENT 'Professional or personal title prefix for the contact (Dr, Prof, Mr, Ms, Mrs, Mx).. Valid values are `Dr|Prof|Mr|Ms|Mrs|Mx`',
    `suffix` STRING COMMENT 'Professional or generational suffix for the contact (Jr, Sr, II, III, PhD, MD, DVM, ScD). [ENUM-REF-CANDIDATE: Jr|Sr|II|III|IV|PhD|MD|DVM|ScD — 9 candidates stripped; promote to reference product]',
    `technical_expertise_area` STRING COMMENT 'Primary area of technical or scientific expertise for the contact (e.g., Next-Generation Sequencing, Bioinformatics, Clinical Genomics, CRISPR Gene Editing, Array-Based Genotyping).',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual person associated with a customer account — principal investigators, lab directors, procurement officers, clinical genomics specialists, field application scientists, and purchasing contacts. Sourced from Salesforce CRM Contact object. Captures full name, job title, department, email, phone, preferred communication channel, contact role (technical, commercial, billing, regulatory), opt-in/opt-out marketing flags, GDPR consent status, PHI handling authorization, and active/inactive status.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the customer segment classification record. Primary key.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this segment is currently active and in use for customer classification (True) or has been retired/deprecated (False).',
    `consent_requirement_flag` BOOLEAN COMMENT 'Indicates whether accounts in this segment require explicit consent management for data processing and marketing communications (True) or operate under standard terms (False). Relevant for GDPR and HIPAA compliance.',
    `contract_term_months` STRING COMMENT 'Standard contract duration in months for accounts in this segment (e.g., 12 for annual contracts, 36 for multi-year agreements). Null if no standard term applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'Standard credit limit assigned to accounts in this segment for credit risk management. Expressed in USD. Null if no standard limit applies.',
    `effective_end_date` DATE COMMENT 'Date when this segment classification was retired or superseded. Null if currently active. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when this segment classification became effective and available for customer assignment. Format: yyyy-MM-dd.',
    `geographic_scope` STRING COMMENT 'Primary geographic scope or region where this segment operates (e.g., GLOBAL for worldwide segments, USA for US-only, EMEA for Europe/Middle East/Africa). [ENUM-REF-CANDIDATE: GLOBAL|NORTH_AMERICA|EMEA|APAC|LATAM|USA|MULTI_REGION — 7 candidates stripped; promote to reference product]',
    `gxp_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether accounts in this segment operate under GxP regulations (GMP, GLP, GCP) and require validated systems, audit trails, and regulatory documentation (True) or not (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `market_sub_vertical` STRING COMMENT 'More granular sub-classification within the market vertical (e.g., Oncology Research, Rare Disease Diagnostics, Crop Genomics, Companion Diagnostics).',
    `market_vertical` STRING COMMENT 'Primary market vertical or industry sector this segment serves (e.g., ACADEMIC for research institutions, CLINICAL_LAB for diagnostic laboratories, BIOPHARMA for pharmaceutical companies, AGRICULTURAL for agri-genomics clients). [ENUM-REF-CANDIDATE: ACADEMIC|CLINICAL_LAB|BIOPHARMA|AGRICULTURAL|OEM|GOVERNMENT|HOSPITAL|DIAGNOSTIC_CENTER — 8 candidates stripped; promote to reference product]',
    `owner_email` STRING COMMENT 'Email address of the segment owner for business inquiries and segment strategy coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the business leader or product manager responsible for this segment strategy and performance (e.g., VP of Clinical Markets, Director of Academic Sales).',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for accounts in this segment (e.g., 30 for Net 30, 60 for Net 60). Drives accounts receivable and credit management.',
    `phi_handling_required_flag` BOOLEAN COMMENT 'Indicates whether accounts in this segment handle Protected Health Information (PHI) and require HIPAA-compliant data handling, Business Associate Agreements (BAA), and enhanced security controls (True) or not (False).',
    `preferred_sales_channel` STRING COMMENT 'Primary sales channel used to serve accounts in this segment (e.g., DIRECT for direct sales force, DISTRIBUTOR for channel partners, ONLINE for e-commerce).. Valid values are `DIRECT|DISTRIBUTOR|OEM|ONLINE|FIELD_SALES|INSIDE_SALES`',
    `pricing_tier` STRING COMMENT 'Pricing tier assigned to this segment, determining discount levels, volume pricing eligibility, and contract terms. Drives product pricing and promotional eligibility.. Valid values are `TIER_1|TIER_2|TIER_3|TIER_4|CUSTOM|VOLUME_DISCOUNT`',
    `product_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this segment has access to the full product catalog (True) or restricted product eligibility based on regulatory or commercial constraints (False).',
    `promotional_eligibility_flag` BOOLEAN COMMENT 'Indicates whether accounts in this segment are eligible for promotional campaigns, special offers, and marketing programs (True) or excluded from promotions (False).',
    `regulatory_use_classification` STRING COMMENT 'Primary regulatory classification of the segment: RUO (Research Use Only), IVD (In Vitro Diagnostic), LDT (Laboratory Developed Test), CLINICAL (clinical use), RESEARCH (research only), or MIXED (multiple use cases).. Valid values are `RUO|IVD|LDT|CLINICAL|RESEARCH|MIXED`',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the segment (e.g., RUO_ACADEMIC, IVD_CLINICAL, BIOPHARMA_DRUG_DEV). Used as business key for segment classification.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `segment_description` STRING COMMENT 'Detailed description of the segment characteristics, target customer profile, and business rationale for this segmentation.',
    `segment_name` STRING COMMENT 'Full descriptive name of the customer segment (e.g., Research Use Only - Academic Institutions, In Vitro Diagnostic - Clinical Laboratories).',
    `sla_tier` STRING COMMENT 'Service level agreement tier defining support response times, technical assistance levels, and service prioritization (e.g., PREMIUM for 24/7 support, STANDARD for business hours).. Valid values are `PREMIUM|STANDARD|BASIC|CUSTOM`',
    `source_system` STRING COMMENT 'System of record where this segment definition originated (e.g., SALESFORCE_CRM for CRM-managed segments, SAP_SD for ERP-managed segments, MANUAL for manually defined segments).. Valid values are `SALESFORCE_CRM|SAP_SD|MANUAL|DATA_MIGRATION`',
    `source_system_code` STRING COMMENT 'Unique identifier of this segment record in the source system (e.g., Salesforce Record ID, SAP segment code). Used for data lineage and reconciliation.',
    `strategic_tier` STRING COMMENT 'Strategic importance classification of accounts in this segment: KEY_ACCOUNT (top-tier strategic partners), STRATEGIC (high-value established), GROWTH (high-potential expansion), STANDARD (regular commercial), EMERGING (new/developing).. Valid values are `KEY_ACCOUNT|STRATEGIC|GROWTH|STANDARD|EMERGING`',
    `support_priority_level` STRING COMMENT 'Numeric priority level for technical support and field application scientist assistance (1=highest priority, 5=standard priority). Drives support queue prioritization.',
    `target_annual_revenue_usd` DECIMAL(18,2) COMMENT 'Target annual revenue contribution from all accounts in this segment. Used for segment performance tracking and strategic planning. Expressed in USD.',
    `target_asp_usd` DECIMAL(18,2) COMMENT 'Target average selling price per transaction for accounts in this segment, used for pricing strategy and revenue forecasting. Expressed in USD.',
    `technical_support_model` STRING COMMENT 'Technical support delivery model for this segment: DEDICATED_FAE (dedicated Field Application Engineer), SHARED_FAE (shared FAE resources), SELF_SERVICE (online resources only), PARTNER_SUPPORT (through distributors), PREMIUM_SUPPORT (24/7 premium service).. Valid values are `DEDICATED_FAE|SHARED_FAE|SELF_SERVICE|PARTNER_SUPPORT|PREMIUM_SUPPORT`',
    `typical_order_size_category` STRING COMMENT 'Typical order size category for accounts in this segment (e.g., SMALL for individual reagent orders, LARGE for instrument purchases, ENTERPRISE for multi-year contracts).. Valid values are `SMALL|MEDIUM|LARGE|ENTERPRISE|CUSTOM`',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Market segmentation classification applied to customer accounts for commercial targeting, pricing strategy, and service tiering. Segments include RUO (Research Use Only), IVD/clinical, biopharma drug development, agricultural genomics, OEM/reseller, and academic/government. Stores segment code, segment name, regulatory use classification (RUO vs. IVD), market vertical, sub-vertical, strategic tier (key account, growth, standard), assigned pricing tier, SLA tier, and segment owner. Drives downstream product eligibility, promotional eligibility, and support prioritization.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'Unique identifier for the address record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account or contact associated with this address.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the address is currently active and available for use in transactions. True if active, False if inactive or deprecated.',
    `address_type` STRING COMMENT 'Classification of the address purpose: shipping destination for instruments and reagent kits, billing address for invoicing, legal registered address, laboratory site address, general mailing address, or headquarters location.. Valid values are `shipping|billing|legal|lab_site|mailing|headquarters`',
    `biosafety_level` STRING COMMENT 'Biosafety containment level of the receiving laboratory site (BSL-1 through BSL-4) as defined by CDC/NIH guidelines. Determines permissible shipment of biological materials, reagents, and samples. BSL-1: minimal hazard; BSL-2: moderate hazard; BSL-3: serious/potentially lethal; BSL-4: dangerous/exotic. Not applicable for non-laboratory addresses.. Valid values are `BSL-1|BSL-2|BSL-3|BSL-4|not_applicable`',
    `city` STRING COMMENT 'City or municipality name where the address is located.',
    `cold_chain_eligible_flag` BOOLEAN COMMENT 'Indicates whether the address is equipped and authorized to receive temperature-sensitive shipments requiring cold-chain logistics (e.g., reagents, enzymes, library prep kits stored at -20°C or -80°C). True if eligible, False if not.',
    `cold_chain_temperature_range` STRING COMMENT 'Acceptable temperature range for cold-chain shipments to this address (e.g., 2-8°C, -20°C, -80°C, ambient). Null if cold_chain_eligible_flag is False.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the country of the address (e.g., USA, CAN, GBR, DEU, CHN, JPN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the address record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delivery_instructions` STRING COMMENT 'Special instructions for delivery to this address, including access codes, gate instructions, receiving hours, contact person for delivery, loading dock location, or other site-specific logistics guidance.',
    `effective_end_date` DATE COMMENT 'Date when the address ceased to be valid or was deprecated. Null if the address is still active. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when the address became valid and available for use. Format: yyyy-MM-dd.',
    `hazmat_receiving_authorized_flag` BOOLEAN COMMENT 'Indicates whether the address is authorized and equipped to receive hazardous materials shipments (e.g., flammable reagents, corrosive chemicals, biological agents) in compliance with DOT, IATA, and IMDG regulations. True if authorized, False if not.',
    `hazmat_un_classes_accepted` STRING COMMENT 'Comma-separated list of UN hazard classes that the receiving site is authorized to accept (e.g., Class 3: Flammable Liquids, Class 6.2: Infectious Substances, Class 8: Corrosives, Class 9: Miscellaneous). Null if hazmat_receiving_authorized_flag is False.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the address record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for precise geolocation of the address. Range: -90.0000000 to +90.0000000. Used for logistics routing and cold-chain planning.',
    `line_1` STRING COMMENT 'Primary street address line including street number, street name, and building identifier. First line of the physical or mailing address.',
    `line_2` STRING COMMENT 'Secondary address line for suite, floor, apartment, unit, building name, or other location details within the primary address.',
    `line_3` STRING COMMENT 'Tertiary address line for additional location details, department name, or care-of information.',
    `loading_dock_available_flag` BOOLEAN COMMENT 'Indicates whether the address has a loading dock or freight receiving area for large shipments (e.g., sequencing instruments, bulk reagent orders). True if available, False if not.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for precise geolocation of the address. Range: -180.0000000 to +180.0000000. Used for logistics routing and cold-chain planning.',
    `notes` STRING COMMENT 'Free-text notes or comments about the address, including historical context, special handling requirements, known delivery issues, or other relevant information for operations and customer service teams.',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for mail delivery routing. Format varies by country (e.g., 12345, 12345-6789, A1A 1A1, SW1A 1AA).',
    `primary_address_flag` BOOLEAN COMMENT 'Indicates whether this is the primary or default address for the associated customer account. True if primary, False if secondary or alternate address.',
    `receiving_hours` STRING COMMENT 'Standard receiving hours for deliveries at this address (e.g., Monday-Friday 8:00 AM - 5:00 PM, 24/7, By Appointment Only). Used for logistics planning and carrier scheduling.',
    `state_province` STRING COMMENT 'State, province, region, or administrative division within the country. Uses standard postal abbreviations where applicable (e.g., CA for California, ON for Ontario).',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for scheduling deliveries, service appointments, and coordinating with customer sites.',
    `validated_flag` BOOLEAN COMMENT 'Indicates whether the address has been validated against an authoritative postal or geocoding service. True if validated, False if not validated or validation failed.',
    `validation_source` STRING COMMENT 'Name of the address validation service or system used to verify the address (e.g., USPS CASS, Google Maps Geocoding API, Loqate, Melissa Data, Canada Post SERP). Null if address has not been validated.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if address has never been validated.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing addresses associated with customer accounts and contacts — shipping destinations for instruments and reagent kits, billing addresses, laboratory site addresses, and registered legal addresses. Captures address type (shipping, billing, legal, lab site), street lines, city, state/province, postal code, country (ISO 3166), geocoordinates, validated flag, validation source, biosafety level of the receiving lab (BSL-1 through BSL-4), cold-chain eligibility flag, and hazmat receiving authorization.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` (
    `technical_requirement_id` BIGINT COMMENT 'Unique identifier for the technical requirement record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom this technical requirement was captured.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: A customers technical requirement for a regulated assay or instrument must reference the specific regulatory approval (510(k) clearance, CE marking) that authorizes the requested product configuratio',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Technical requirements specify which genomic products (sequencers, library prep kits, reagents) are needed for customer applications. Critical for technical sales consultations, quote generation, inst',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Technical requirements in genomics biotech are captured from specific individuals — principal investigators, lab directors, or bioinformatics leads — who define the sequencing parameters, coverage dep',
    `ivd_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.ivd_registration. Business justification: A technical requirement specifying IVD use in a particular jurisdiction must reference the IVD registration for that market. Genomics diagnostics sales teams use this link to confirm product eligibili',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Customer technical requirements specify exact reagent materials needed by catalog number (e.g., specific library prep kit, flow cell type, index adapters). Essential for quote generation, order fulfil',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: Technical requirements capture which instrument model a customer needs for their genomics application (sequencing platform, throughput, read length). instrument_platform_preference is a plain-text den',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Customer technical requirements (coverage depth, turnaround time, annotation preferences, regulatory classification) drive selection of appropriate validated pipeline versions. Critical for matching c',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Customer technical requirements specify preferred reagent products (library prep methods, sequencing kits) for their applications. Tracks customer preferences for quote generation, opportunity qualifi',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Regulated genomics customers (clinical labs, pharma) maintain approved vendor lists and specify preferred suppliers for materials in their technical requirements during pre-sales/quoting. Role-prefix ',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Customer technical requirements in genomics biotech are scoped to specific R&D projects (e.g., a pharma sponsors oncology sequencing project). Project managers need to pull all customer technical spe',
    `quotation_id` BIGINT COMMENT 'Foreign key linking to order.quotation. Business justification: Technical requirements captured during pre-sales (read length, coverage depth, instrument platform, regulatory classification) drive quotation configuration. Sales engineers reference the technical re',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Technical requirements are frequently captured in the context of a specific service agreement — particularly for evaluation/beta-testing engagements, custom service contracts, or IVD validation progra',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Technical requirements in genomics biotech are scoped to a specific service offering (e.g., whole genome sequencing service, library prep service). This FK enables service feasibility assessment, capa',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Technical requirements capture customer-specific genomics parameters (read length, coverage depth, Q30 thresholds). Linking to product specification enables gap analysis between customer requirements ',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: When a customer requests a specific IVD or regulated genomics assay configuration, the technical requirement must be validated against the regulatory submissions intended use and cleared specificatio',
    `application_type` STRING COMMENT 'Primary sequencing application type required by the customer. WGS (Whole Genome Sequencing), WES (Whole Exome Sequencing), targeted panel, single-cell sequencing, RNA-seq, ChIP-seq, ATAC-seq, metagenomics, amplicon sequencing, or methylation profiling. [ENUM-REF-CANDIDATE: WGS|WES|targeted_panel|single_cell|RNA_seq|ChIP_seq|ATAC_seq|metagenomics|amplicon_sequencing|methylation_profiling — 10 candidates stripped; promote to reference product]',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this technical requirement was formally approved for implementation or quotation.',
    `budget_constraint_usd` DECIMAL(18,2) COMMENT 'Customers budget constraint or target cost per sample in USD, used for configuring cost-effective sequencing and analysis solutions.',
    `capture_timestamp` TIMESTAMP COMMENT 'Date and time when this technical requirement was initially captured during pre-sales, onboarding, or support engagement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this technical requirement record was first created in the system.',
    `data_delivery_format` STRING COMMENT 'Required bioinformatics output format(s) for data delivery. FASTQ (raw sequence reads), BAM (aligned reads), VCF (variant calls), or combinations thereof.. Valid values are `FASTQ|BAM|VCF|FASTQ_BAM|FASTQ_VCF|FASTQ_BAM_VCF`',
    `data_retention_period_days` STRING COMMENT 'Required data retention period in days, driven by customer policy, regulatory requirements (e.g., CLIA, CAP, GDPR), or contractual obligations.',
    `data_storage_location_preference` STRING COMMENT 'Customers preferred data storage and delivery location: on-premise, cloud (AWS, Azure, GCP), Illumina BaseSpace Sequence Hub, or hybrid model.. Valid values are `on_premise|cloud_aws|cloud_azure|cloud_gcp|baseSpace|hybrid`',
    `engagement_type` STRING COMMENT 'Type of customer engagement during which this technical requirement was captured.. Valid values are `pre_sales|onboarding|support|annual_review|project_consultation|custom_development`',
    `flow_cell_type` STRING COMMENT 'Preferred or required flow cell type (e.g., S4, S2, SP, Standard, Micro) corresponding to the instrument platform and throughput requirements.',
    `gxp_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether GxP (GMP, GLP, GCP) compliance is required for this application, typically for clinical or diagnostic use cases.',
    `index_strategy` STRING COMMENT 'Indexing strategy for sample multiplexing: single index (i7 only), dual index (i7 + i5), unique dual index (UDI), or combinatorial dual index.. Valid values are `single_index|dual_index|unique_dual_index|combinatorial_dual_index`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this technical requirement record was last updated.',
    `library_prep_method` STRING COMMENT 'Preferred or required library preparation method or kit (e.g., TruSeq DNA PCR-Free, Nextera DNA Flex, Stranded mRNA, KAPA HyperPrep). Free-text field capturing customer-specific protocol preferences.',
    `minimum_coverage_depth` DECIMAL(18,2) COMMENT 'Minimum acceptable sequencing coverage depth threshold below which data quality is considered insufficient for the intended application.',
    `multiplexing_required_flag` BOOLEAN COMMENT 'Indicates whether multiplexing (pooling multiple samples with unique index barcodes in a single sequencing run) is required or preferred.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, clarifications, or customer-specific nuances not covered by structured fields.',
    `phi_handling_required_flag` BOOLEAN COMMENT 'Indicates whether the sequencing data will contain Protected Health Information (PHI) requiring HIPAA-compliant handling and storage.',
    `phred_score_threshold` STRING COMMENT 'Minimum acceptable Phred quality score threshold for base calling (commonly Q20 or Q30, representing 99% or 99.9% base call accuracy).',
    `qc_metric_requirements` STRING COMMENT 'Specific quality control (QC) metrics and thresholds required by the customer (e.g., Q30 score >80%, cluster density, duplication rate <20%). Free-text field capturing detailed QC specifications.',
    `read_configuration` STRING COMMENT 'Sequencing read configuration: single-end (one read per fragment) or paired-end (two reads per fragment).. Valid values are `single_end|paired_end`',
    `read_length_bp` STRING COMMENT 'Required sequencing read length in base pairs (bp). Common values include 50, 75, 100, 150, 250, 300 bp depending on application.',
    `regulatory_use_classification` STRING COMMENT 'Regulatory classification of the intended use: RUO (Research Use Only), IVD (In Vitro Diagnostic), LDT (Laboratory Developed Test), clinical research, or diagnostic. Determines compliance and validation requirements.. Valid values are `RUO|IVD|LDT|clinical_research|diagnostic`',
    `requirement_code` STRING COMMENT 'Externally-known unique business identifier for this technical requirement record, formatted as TR-NNNNNNNN.. Valid values are `^TR-[0-9]{8}$`',
    `requirement_status` STRING COMMENT 'Current lifecycle status of the technical requirement record in the customer engagement workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|superseded|archived — 7 candidates stripped; promote to reference product]',
    `sample_type` STRING COMMENT 'Type of biological sample to be sequenced (e.g., whole blood, saliva, FFPE tissue, fresh frozen tissue, cell line, plasma, DNA, RNA). Free-text to accommodate diverse sample matrices.',
    `samples_per_run` STRING COMMENT 'Expected or maximum number of samples to be multiplexed per sequencing run, if multiplexing is required.',
    `special_handling_instructions` STRING COMMENT 'Any special sample handling, processing, or data analysis instructions provided by the customer (e.g., low-input protocols, degraded sample protocols, custom bioinformatics workflows).',
    `species` STRING COMMENT 'Biological species of the sample (e.g., Homo sapiens, Mus musculus, Arabidopsis thaliana, microbial species). Free-text to accommodate diverse research organisms.',
    `target_coverage_depth` DECIMAL(18,2) COMMENT 'Required average sequencing coverage depth (e.g., 30x for WGS, 100x for WES, 500x for targeted panels). Represents the average number of reads covering each base position.',
    `throughput_requirement_gb` DECIMAL(18,2) COMMENT 'Required sequencing throughput in gigabases (Gb) per run or per sample, depending on application and multiplexing strategy.',
    `turnaround_time_days` STRING COMMENT 'Expected turnaround time (TAT) in calendar days from sample receipt to data delivery, as required by the customers operational or clinical workflow.',
    `variant_calling_required_flag` BOOLEAN COMMENT 'Indicates whether variant calling (SNP, indel, CNV detection) is required as part of the bioinformatics pipeline deliverable.',
    CONSTRAINT pk_technical_requirement PRIMARY KEY(`technical_requirement_id`)
) COMMENT 'Documents customer-specific technical and application requirements captured during pre-sales, onboarding, or support engagements. Covers sequencing application type (WGS, WES, targeted panel, single-cell), required read length, coverage depth targets, preferred library preparation method, multiplexing requirements, bioinformatics pipeline preferences (FASTQ delivery, BAM/VCF output), instrument platform preference, throughput requirements, turnaround time (TAT) expectations, and regulatory use classification (RUO vs. IVD/LDT). Enables field application scientists and commercial teams to configure appropriate product and service offerings.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` (
    `service_agreement_id` BIGINT COMMENT 'Unique identifier for the service agreement record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that holds this service agreement.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Service agreements for IVD products reference the regulatory approval governing covered products/services. Required for compliance verification and contract scope validation in regulated genomics mark',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Service agreements cover specific products/instruments. Required for contract entitlement validation, warranty claim processing, service level compliance tracking, and determining which products are e',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Service agreements include reagent supply commitments, covered products, or reagent rental terms. Tracks which reagents are included in service contracts for entitlement verification, usage tracking, ',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Service agreements in genomics biotech (preventive maintenance, field service contracts) are scoped to specific service offerings. Role-prefixed covered_ disambiguates from existing covered_catalog_',
    `post_market_surveillance_id` BIGINT COMMENT 'Foreign key linking to regulatory.post_market_surveillance. Business justification: Service agreements covering post-market support (performance monitoring, complaint handling, field safety response) are directly tied to PMS plans under EU MDR Article 83. Regulatory affairs teams lin',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Service agreements require a designated primary contact at the customer organization — typically the lab director, procurement officer, or scientific lead who is the signatory and primary point of con',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Service agreements in genomics biotech (sequencing-as-a-service, sponsored research contracts) are frequently tied to a named R&D project for spend tracking, milestone billing, and project-level contr',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: Service agreements for instrument maintenance or reagent supply programs reference master supplier contracts for pricing terms, SLA alignment, and commercial conditions. Critical for contract complian',
    `agreement_name` STRING COMMENT 'Descriptive name of the service agreement for easy identification (e.g., NovaSeq 6000 Premium Support - Broad Institute).',
    `agreement_number` STRING COMMENT 'Externally visible unique business identifier for the service agreement, used in customer communications and invoicing.. Valid values are `^SA-[A-Z0-9]{8,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the service agreement: draft (being prepared), pending approval (awaiting internal or customer sign-off), active (in force), suspended (temporarily paused), expired (end date reached), terminated (cancelled before expiry), or renewed (replaced by successor agreement). [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the service agreement: instrument warranty (standard coverage), preventive maintenance (scheduled service), reagent supply SLA (consumable delivery commitment), FAS support (Field Application Scientist engagement), beta evaluation (pre-release product testing), early access (limited release program), clinical evaluation (IVD/LDT validation pilot), demo placement (trial instrument), bioinformatics support (pipeline and analysis assistance), or custom service (bespoke engagement). [ENUM-REF-CANDIDATE: instrument_warranty|preventive_maintenance|reagent_supply_sla|fas_support|beta_evaluation|early_access|clinical_evaluation|demo_placement|bioinformatics_support|custom_service — 10 candidates stripped; promote to reference product]',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'Total annualized revenue value of this service agreement in USD, used for sales forecasting and account planning.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the service agreement was formally approved by internal stakeholders or the customer.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the service agreement automatically renews at the end of the term unless explicitly cancelled by either party.',
    `billing_frequency` STRING COMMENT 'Frequency at which the customer is invoiced for this service agreement: one-time (upfront payment), monthly, quarterly, annually, or milestone-based (tied to deliverables).. Valid values are `one_time|monthly|quarterly|annually|milestone_based`',
    `commercial_conversion_outcome` STRING COMMENT 'Outcome of evaluation engagement: not applicable (standard service agreement), converted (customer purchased product), not converted (customer declined), or pending decision (evaluation complete, decision awaited).. Valid values are `not_applicable|converted|not_converted|pending_decision`',
    `confidentiality_agreement_flag` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) or confidentiality clause is in place for this service agreement, typically required for beta and early-access programs.',
    `contract_owner` STRING COMMENT 'Name or user ID of the Salesforce account owner or contract manager responsible for this service agreement.',
    `covered_instruments` STRING COMMENT 'Comma-separated list or description of instrument serial numbers or models covered under this service agreement (e.g., NovaSeq 6000 SN12345, MiSeq SN67890).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual contract value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_feedback_summary` STRING COMMENT 'Summary of customer feedback, performance observations, and satisfaction notes collected during or after the evaluation period.',
    `end_date` DATE COMMENT 'Date when the service agreement expires or is scheduled to terminate. Nullable for open-ended agreements.',
    `escalation_contact` STRING COMMENT 'Name, email, or phone number of the designated escalation contact for service issues or disputes under this agreement.',
    `evaluation_end_date` DATE COMMENT 'Date when the evaluation or beta testing period concluded or is scheduled to conclude. Applicable only for evaluation-type agreements.',
    `evaluation_start_date` DATE COMMENT 'Date when the evaluation or beta testing period began. Applicable only for evaluation-type agreements.',
    `evaluation_status` STRING COMMENT 'Status of evaluation or beta engagement: not applicable (standard service agreement), planned (evaluation scheduled), in progress (active testing), completed (evaluation finished), converted to commercial (customer purchased), or discontinued (evaluation terminated without conversion).. Valid values are `not_applicable|planned|in_progress|completed|converted_to_commercial|discontinued`',
    `internal_scientific_lead` STRING COMMENT 'Name or employee ID of the internal Field Application Scientist (FAS), R&D scientist, or technical lead responsible for managing this service agreement or evaluation engagement.',
    `ip_ownership_terms` STRING COMMENT 'Description of intellectual property ownership and usage rights for data, methods, or innovations generated during the service engagement or evaluation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was last updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, or internal comments related to this service agreement.',
    `payment_terms` STRING COMMENT 'Payment terms and conditions (e.g., Net 30, Net 60, Due on Receipt, 50% upfront, 50% on completion).',
    `products_under_evaluation` STRING COMMENT 'Comma-separated list of product names or SKUs being evaluated under this agreement (e.g., NextSeq 2000 Prototype, TruSight Oncology 500 v2 Beta Kit).',
    `program_name` STRING COMMENT 'Name of the evaluation or beta program if this agreement is part of a structured early-access or pilot initiative (e.g., CRISPR Cas9 Beta Program Q1 2024, WGS Clinical Validation Pilot).',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on regulatory compliance requirements applicable to this agreement, such as FDA, CLIA, CAP, IVDR, GDPR, or HIPAA obligations for clinical or IVD service agreements.',
    `renewal_terms` STRING COMMENT 'Description of renewal conditions, auto-renewal clauses, notice periods, and pricing adjustments for contract extension.',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Maximum number of hours within which the service provider commits to respond to a service request or incident under this agreement.',
    `service_level_penalties` STRING COMMENT 'Description of financial penalties, service credits, or remediation actions if SLA commitments (response time, uptime) are not met.',
    `sla_tier` STRING COMMENT 'Service level tier defining response time, uptime guarantees, and support scope: standard (basic coverage), premium (enhanced response), enterprise (dedicated support), or custom (bespoke terms).. Valid values are `standard|premium|enterprise|custom`',
    `start_date` DATE COMMENT 'Date when the service agreement becomes effective and coverage begins.',
    `success_criteria` STRING COMMENT 'Defined success metrics and acceptance criteria for evaluation agreements (e.g., Achieve 95% concordance with reference standard, Complete 100 WGS runs with <1% error rate).',
    `termination_clause` STRING COMMENT 'Description of conditions under which either party may terminate the agreement, including notice periods, penalties, and exit terms.',
    `uptime_guarantee_percentage` DECIMAL(18,2) COMMENT 'Guaranteed instrument or service availability percentage (e.g., 99.5% uptime for sequencing instruments under premium maintenance contracts).',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'Records service-level agreements, support contracts, and product evaluation/beta-testing engagements established with customer accounts — instrument service contracts, reagent supply agreements, bioinformatics support SLAs, field application scientist engagement terms, instrument beta placements, early-access reagent kit evaluations, clinical assay validation pilots, CRISPR tool assessments, and demo placements. Captures agreement type (instrument warranty, preventive maintenance, reagent supply SLA, FAS support, beta evaluation, early access, clinical evaluation, demo placement), program name, start date, end date, SLA tier (standard, premium, enterprise), response time commitments, uptime guarantees, covered instruments/products, annual contract value (ACV), renewal terms, agreement status, evaluation status, products under evaluation, success criteria, customer feedback summary, commercial conversion outcome, and internal scientific lead. Serves as the unified contractual and evaluation engagement record — no separate evaluation program entity exists.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for the customer interaction record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account involved in this interaction. Links to the customer master data managed in Salesforce CRM.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: CRM interaction tracking in genomics biotech requires linking each sales/support interaction to the specific catalog item discussed (demo, quote follow-up, technical Q&A) for pipeline reporting and pr',
    `contact_id` BIGINT COMMENT 'Reference to the specific contact person at the customer account who participated in this interaction. Links to customer contact master data.',
    `installed_instrument_id` BIGINT COMMENT 'Foreign key linking to customer.installed_instrument. Business justification: In genomics biotech, many customer interactions are instrument-specific — field service visits, remote troubleshooting calls, instrument demo sessions, firmware upgrade discussions, and utilization re',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Customer interactions (scientific advisory meetings, technical reviews, collaborative planning sessions) in genomics biotech are frequently tied to specific R&D projects. Project managers need a compl',
    `support_case_id` BIGINT COMMENT 'Reference to the associated technical support case or service request if this interaction is related to customer support activities. Nullable for non-support interactions.',
    `application_area` STRING COMMENT 'The scientific or clinical application domain discussed during the interaction. Aligns with customer research focus and product use cases. [ENUM-REF-CANDIDATE: wgs|wes|targeted_sequencing|rna_seq|single_cell|metagenomics|clinical_diagnostics|agricultural_genomics|oncology|rare_disease|pharmacogenomics|microbiome|epigenetics|liquid_biopsy — promote to reference product]',
    `attendee_count` STRING COMMENT 'Number of participants from the customer organization who attended the interaction. Used for engagement reach and influence analysis.',
    `channel` STRING COMMENT 'The communication medium or platform through which the interaction took place. Distinct from interaction_type which describes the purpose.. Valid values are `in_person|phone|email|video_conference|customer_portal|webinar`',
    `competitive_mention_flag` BOOLEAN COMMENT 'Indicates whether competing vendors, products, or technologies were discussed during the interaction. Used for competitive intelligence and market positioning analysis.',
    `competitor_name` STRING COMMENT 'Name of the competing organization mentioned during the interaction. Business-confidential competitive intelligence. Nullable if no competitor was discussed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was first created in the system. Audit trail for data governance and compliance.',
    `customer_segment` STRING COMMENT 'The business segment classification of the customer account involved in this interaction. Used for engagement strategy and reporting segmentation.. Valid values are `research_institution|clinical_laboratory|biopharma_partner|agricultural_genomics_client|oem_account|individual_researcher`',
    `duration_minutes` STRING COMMENT 'Length of the interaction in minutes. Used for resource planning, engagement scoring, and Field Application Scientist (FAS) time allocation analysis.',
    `employee_role` STRING COMMENT 'The functional role of the employee who conducted the interaction. Provides context for the type of expertise and support provided.. Valid values are `sales_representative|field_application_scientist|technical_support_engineer|account_manager|product_specialist|service_engineer`',
    `engagement_score` DECIMAL(18,2) COMMENT 'Quantitative score (0.00 to 100.00) representing the quality and depth of customer engagement during this interaction. Calculated based on duration, outcome, sentiment, and follow-up actions. Used for customer health scoring.',
    `gdpr_consent_verified_flag` BOOLEAN COMMENT 'Indicates whether customer consent for data processing and communication was verified at the time of interaction, as required by GDPR for EU contacts. True if consent was confirmed.',
    `interaction_date` DATE COMMENT 'The calendar date on which the customer interaction occurred. Principal business event timestamp for this transaction.',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the interaction record. Indicates whether the interaction occurred as planned or required rescheduling.. Valid values are `completed|scheduled|cancelled|no_show|rescheduled`',
    `interaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the interaction started, including time zone information. Provides granular timing for scheduling and duration analysis.',
    `interaction_type` STRING COMMENT 'Classification of the interaction activity. [ENUM-REF-CANDIDATE: sales_call|fas_site_visit|technical_support_call|webinar_attendance|trade_show_meeting|product_demonstration|training_session|scientific_advisory_board_meeting|customer_visit|email_correspondence|portal_inquiry|conference_call|onsite_consultation|remote_troubleshooting|application_review — promote to reference product]. Valid values are `sales_call|fas_site_visit|technical_support_call|webinar_attendance|trade_show_meeting|product_demonstration`',
    `language` STRING COMMENT 'Primary language used during the interaction. Supports multilingual customer engagement and regional reporting. Uses ISO 639-1 two-letter language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was most recently updated. Audit trail for data governance and change tracking.',
    `location` STRING COMMENT 'Physical location or venue where the interaction took place for in-person meetings. May include customer site address, trade show venue, or Genomics Biotech office location. Nullable for remote interactions.',
    `next_action` STRING COMMENT 'Description of the follow-up activity or commitment resulting from this interaction. May include scheduled tasks, deliverables, or customer requests.',
    `next_action_due_date` DATE COMMENT 'Target date by which the next action or follow-up commitment should be completed. Used for task management and SLA tracking.',
    `notes` STRING COMMENT 'Detailed narrative notes capturing the discussion content, customer feedback, technical questions raised, and any commitments made during the interaction. Business-confidential customer relationship information.',
    `outcome` STRING COMMENT 'The result or disposition of the interaction from a business perspective. Indicates whether objectives were met and what next steps are needed.. Valid values are `successful|follow_up_required|issue_resolved|no_action|opportunity_identified|escalated`',
    `regulatory_classification` STRING COMMENT 'Indicates whether the interaction pertains to Research Use Only (RUO), In Vitro Diagnostic (IVD), Laboratory Developed Test (LDT), or clinical applications. Critical for compliance and product positioning.. Valid values are `ruo|ivd|ldt|clinical`',
    `salesforce_activity_code` STRING COMMENT 'The unique identifier of this interaction record in the source Salesforce CRM system. Used for data lineage, reconciliation, and bidirectional synchronization.',
    `sentiment_score` STRING COMMENT 'Qualitative assessment of the customer mood, satisfaction, or receptiveness during the interaction. Used for relationship health monitoring and early warning indicators.. Valid values are `positive|neutral|negative|very_positive|very_negative`',
    `subject` STRING COMMENT 'Brief summary or title describing the primary topic or purpose of the interaction. Used for quick identification and search.',
    `technical_issue_flag` BOOLEAN COMMENT 'Indicates whether the interaction involved discussion or resolution of a technical problem, instrument malfunction, or assay performance issue. True if technical support was required.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Captures all recorded touchpoints and engagement activities between Genomics Biotech personnel and customer accounts or contacts — sales calls, field application scientist (FAS) site visits, technical support calls, webinar attendance, trade show meetings, product demonstrations, training sessions, and scientific advisory board meetings. Stores interaction type, interaction date, channel (in-person, phone, email, video, portal), subject, outcome/notes, next action, associated opportunity or case reference, duration, and the internal employee who conducted the interaction. Provides the relationship history timeline for each account and supports customer engagement scoring.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`accreditation` (
    `accreditation_id` BIGINT COMMENT 'Unique identifier for the laboratory accreditation record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account holding this accreditation. Links to the clinical laboratory or diagnostic customer entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Customer lab accreditations (CLIA, CAP) often require use of FDA-cleared/CE-marked products. Links accreditation scope to specific product regulatory approvals for compliance verification in clinical ',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Lab accreditations may be product-specific (e.g., CLIA-certified for specific IVD assays, CAP-accredited for certain tests). Required for regulatory compliance verification, product eligibility valida',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: CLIA/CAP accreditation for a specific IVD instrument or assay kit references the UDI/device identifier of the authorized device. UDI-based accreditation verification is a real FDA and EU MDR complianc',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: CLIA/CAP/ISO 15189 lab accreditations are scoped to specific instrument models — a lab is accredited to run a specific sequencer platform. This FK enables accreditation scope validation, instrument el',
    `ivd_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.ivd_registration. Business justification: A customer labs accreditation to perform IVD testing in a specific jurisdiction must be validated against the IVD registration for that jurisdiction. Genomics diagnostics compliance teams verify this',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: accreditation has laboratory_director_name (STRING) which should be normalized to laboratory_director_contact_id FK to the contact table. Laboratory directors are key contacts responsible for accredit',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: accreditation has embedded laboratory site address fields (laboratory_site_address_line_1, laboratory_site_address_line_2, laboratory_site_city, laboratory_site_state_province, laboratory_site_postal_',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: CAP/CLIA/ISO 15189 lab accreditations in genomics biotech authorize use of products meeting specific technical specifications (Q30 thresholds, coverage depth, LOD). Linking accreditation to specificat',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: A customer labs CLIA/CAP/ISO 15189 accreditation for an NGS assay references the 510(k)/PMA/CE submission that cleared the assay. Regulatory compliance audits and accreditation renewal processes requ',
    `accreditation_scope` STRING COMMENT 'Description of the scope of testing, procedures, or activities covered by the accreditation. May include specific test categories, methodologies (NGS, qPCR, array-based), or clinical specialties (oncology, reproductive health, infectious disease).',
    `accreditation_status` STRING COMMENT 'Current lifecycle status of the accreditation. Active = currently valid and in good standing, Expired = past expiry date and not renewed, Suspended = temporarily inactive due to compliance issue, Pending_Renewal = renewal application submitted awaiting approval, Revoked = permanently withdrawn by issuing body, Under_Review = subject to audit or investigation.. Valid values are `active|expired|suspended|pending_renewal|revoked|under_review`',
    `accreditation_type` STRING COMMENT 'Type of laboratory accreditation or certification held by the customer. CLIA = Clinical Laboratory Improvement Amendments certification, CAP = College of American Pathologists accreditation, ISO_15189 = Medical Laboratories Quality and Competence certification, CE_IVD = Conformité Européenne In Vitro Diagnostic authorization, GxP = Good Practice Regulations compliance status, IRB = Institutional Review Board registration.. Valid values are `CLIA|CAP|ISO_15189|CE_IVD|GxP|IRB`',
    `audit_frequency_months` STRING COMMENT 'Standard interval in months between routine audits or inspections required by the accreditation body. Common values: 12, 24, 36.',
    `certificate_number` STRING COMMENT 'Unique certificate or registration number assigned by the issuing body. Business-confidential identifier used for verification and regulatory compliance tracking.',
    `complexity_level` STRING COMMENT 'CLIA complexity level of testing authorized under this accreditation. Waived = simple tests with low error risk, Moderate = moderately complex tests, High = highly complex tests requiring specialized expertise.. Valid values are `waived|moderate|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation record was first created in the system.',
    `document_url` STRING COMMENT 'URL or file path to the stored accreditation certificate or official documentation in the document management system (e.g., Veeva Vault).',
    `effective_date` DATE COMMENT 'Date from which the accreditation becomes valid and the laboratory is authorized to operate under the certification.',
    `expiry_date` DATE COMMENT 'Date on which the accreditation expires and must be renewed. Nullable for indefinite or rolling certifications.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the laboratory site is compliant with GDPR requirements for handling personal data of EU residents. True = GDPR compliant, False = not compliant or not applicable.',
    `gxp_compliance_status` STRING COMMENT 'Compliance status with Good Practice regulations (GMP, GLP, GCP) relevant to the laboratory operations. Compliant = meets all GxP requirements, Non_Compliant = deficiencies identified, Not_Applicable = GxP not required for this lab type, Under_Review = compliance assessment in progress.. Valid values are `compliant|non_compliant|not_applicable|under_review`',
    `issue_date` DATE COMMENT 'Date the accreditation or certification was originally issued by the regulatory body.',
    `issuing_body` STRING COMMENT 'Name of the regulatory or accreditation body that issued the certification. Examples: Centers for Medicare & Medicaid Services (CMS) for CLIA, College of American Pathologists for CAP, national accreditation bodies for ISO 15189, notified bodies for CE-IVD.',
    `ivd_authorized_flag` BOOLEAN COMMENT 'Indicates whether the laboratory is authorized to perform clinical diagnostic testing with IVD-labeled products. True = IVD authorized, False = RUO only.',
    `laboratory_director_license_number` STRING COMMENT 'Professional license number of the laboratory director (e.g., medical license, clinical laboratory scientist license). Required for regulatory compliance verification.',
    `laboratory_site_name` STRING COMMENT 'Name of the specific laboratory facility or site covered by this accreditation. A customer may have multiple sites with separate accreditations.',
    `last_audit_date` DATE COMMENT 'Date of the most recent on-site or remote audit conducted by the accreditation body to verify compliance with standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation record was last updated or modified.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next routine or surveillance audit by the accreditation body.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, audit findings, or compliance observations related to the accreditation.',
    `phi_handling_authorized_flag` BOOLEAN COMMENT 'Indicates whether the laboratory is authorized and compliant to handle Protected Health Information under HIPAA regulations. True = PHI handling authorized, False = not authorized.',
    `product_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this accreditation qualifies the customer to purchase and use In Vitro Diagnostic (IVD) products. True = eligible for IVD products, False = restricted to Research Use Only (RUO) products.',
    `renewal_due_date` DATE COMMENT 'Target date by which the renewal application or re-certification process must be completed to avoid lapse in accreditation status.',
    `salesforce_accreditation_code` STRING COMMENT 'External identifier from the source Salesforce CRM system. Used for data lineage and reconciliation with the operational system of record.',
    `verification_date` DATE COMMENT 'Date when the accreditation status was last verified by internal compliance or sales operations team against the issuing bodys registry.',
    CONSTRAINT pk_accreditation PRIMARY KEY(`accreditation_id`)
) COMMENT 'Tracks laboratory accreditations, certifications, and regulatory authorizations held by clinical laboratory and diagnostic customer accounts — CLIA certification, CAP accreditation, ISO 15189 certification, CE-IVD authorization, GxP compliance status, and IRB registration. Captures accreditation type, issuing body, certificate number, accreditation scope, issue date, expiry date, renewal status, and associated laboratory site address. Critical for determining product eligibility (IVD vs. RUO) and regulatory compliance of customer-facing activities.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` (
    `installed_instrument_id` BIGINT COMMENT 'Unique identifier for the installed instrument record. Primary key for the installed instrument registry.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that owns or operates this installed instrument. Links to the customer master data managed in Salesforce CRM.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Installed instruments operate under specific regulatory approvals (510k, CE mark). Essential for compliance audits, service contract eligibility, and post-market surveillance in genomics operations.',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Sequencing instruments require specific approved reagent materials (flow cells, library prep kits, buffers). Tracking approved material compatibility per instrument enables automated ordering validati',
    `contact_id` BIGINT COMMENT 'Reference to the primary contact person responsible for this instrument at the customer site. Typically the laboratory manager, principal investigator, or facility operations lead.',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: Each installed instrument has a UDI (Unique Device Identifier) required for FDA/EU MDR traceability. Essential for post-market surveillance, recall management, and regulatory compliance in genomics in',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Installed instruments must reference the catalog item representing that instrument model for asset tracking, service contract eligibility validation, consumables compatibility checks, and warranty man',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to instrument.service_contract. Business justification: Installed instruments are governed by a specific service contract determining SLA, PM visits, and parts coverage. service_contract_start_date and service_contract_end_date are denormalizations of inst',
    `ivd_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.ivd_registration. Business justification: An instrument installed at a customer site in a given country must be covered by the IVD registration for that jurisdiction. Regulatory affairs teams use this link for jurisdiction-specific field safe',
    `model_id` BIGINT COMMENT 'FK to instrument.instrument_model',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: GxP-regulated genomics labs must document which supply batch was used during instrument installation qualification (IQ/OQ/PQ). Regulators (FDA 21 CFR Part 11, ISO 13485) require traceability of valida',
    `asset_id` BIGINT COMMENT 'Unique identifier for this installed instrument record in Salesforce CRM Asset object. Used for cross-system reconciliation and master data synchronization between Salesforce and enterprise data warehouse.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: installed_instrument has service_contract_number (STRING) which should be normalized to service_agreement_id FK. Instruments are often covered by service contracts that define maintenance, support, an',
    `address_id` BIGINT COMMENT 'Reference to the physical address where the instrument is installed. Links to customer address master for field service dispatch and logistics planning.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Installed instruments are purchased as specific SKUs (configuration, regional variant, pack). In genomics biotech, the exact SKU is required for spare parts ordering, warranty entitlement validation, ',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Tracking the exact software release on each installed instrument is critical for FDA 21 CFR Part 11 compliance, field service dispatch, and upgrade eligibility management in genomics biotech. Replaces',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Each installed instrument at a customer site is authorized under a specific regulatory submission (510(k), CE technical file). Field safety and post-market surveillance reporting requires direct trace',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Instruments are sourced from specific OEM suppliers. Tracking original supplier enables warranty claim routing, parts procurement, service contract management, and supplier performance tracking for ca',
    `biosafety_level` STRING COMMENT 'Biosafety containment level of the facility where the instrument is installed. BSL-1: minimal hazard. BSL-2: moderate hazard (most clinical labs). BSL-3: serious or potentially lethal agents. BSL-4: dangerous and exotic agents. Used for service technician safety protocols and hazmat handling requirements.. Valid values are `BSL-1|BSL-2|BSL-3|BSL-4|Not Applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this installed instrument record was first created in the system. Used for data lineage, audit trail, and record lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_segment` STRING COMMENT 'Market segment classification of the customer account operating this instrument. RUO indicates research-only applications. IVD indicates clinical diagnostic use. Used for regulatory compliance tracking, product lifecycle management, and targeted marketing.. Valid values are `Research Use Only (RUO)|In Vitro Diagnostic (IVD)|Clinical Laboratory|Biopharma|Agricultural Genomics|OEM Partner`',
    `data_sharing_consent_status` STRING COMMENT 'Customer consent status for sharing instrument usage data, performance metrics, and anonymized run data with the manufacturer for product improvement and research. Consented allows full data sharing. Partial Consent limits data types. Withdrawn revokes previous consent.. Valid values are `Consented|Not Consented|Partial Consent|Withdrawn`',
    `decommission_date` DATE COMMENT 'Date when the instrument was permanently removed from service at the customer site. Marks the end of the instrument lifecycle for installed base reporting. Null for active instruments.',
    `decommission_reason` STRING COMMENT 'Reason for instrument decommissioning. Used for churn analysis, product lifecycle insights, and customer retention strategy development. [ENUM-REF-CANDIDATE: Upgrade to Newer Model|End of Life|Customer Closure|Relocation|Equipment Failure|Regulatory Non-Compliance|Other — 7 candidates stripped; promote to reference product]',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the instrument. Critical for compatibility tracking, upgrade planning, and technical support. Format: major.minor.patch (e.g., 2.5.1).. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `installation_date` DATE COMMENT 'Date when the instrument was installed and commissioned at the customer site. Marks the start of the instrument lifecycle for warranty, service contract, and utilization tracking.',
    `instrument_location_description` STRING COMMENT 'Detailed description of the instruments physical location within the customer facility. Examples: Building 3, Room 205, Core Genomics Lab; Main Hospital, Molecular Diagnostics Suite, Bay 4. Used for field service dispatch and on-site navigation.',
    `instrument_serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the physical instrument unit. Used for warranty tracking, service history, and asset identification. This is the customer-facing installed base view; engineering asset master is owned by the instrument domain.. Valid values are `^[A-Z0-9]{8,20}$`',
    `instrument_status` STRING COMMENT 'Current operational status of the installed instrument. Active indicates the instrument is operational and in use. Under Repair indicates temporary service outage. Decommissioned indicates the instrument has been permanently removed from service.. Valid values are `Active|Inactive|Under Repair|Decommissioned|Pending Installation|Pending Decommission`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this installed instrument record was last updated. Used for change tracking, data freshness assessment, and synchronization control. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_service_date` DATE COMMENT 'Date of the most recent preventive maintenance or repair service performed on this instrument. Used for service interval tracking and next maintenance scheduling.',
    `network_connectivity_type` STRING COMMENT 'Type of network connection used by the instrument for data transfer, remote monitoring, and software updates. Offline indicates no network connection. Hybrid indicates multiple connection methods available.. Valid values are `Ethernet|Wi-Fi|Cellular|Offline|Hybrid`',
    `next_scheduled_service_date` DATE COMMENT 'Date when the next preventive maintenance service is scheduled. Enables proactive service planning, technician dispatch, and customer communication.',
    `notes` STRING COMMENT 'Free-text field for additional information about the installed instrument. May include special handling instructions, customer-specific configurations, site access requirements, or historical context not captured in structured fields.',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the instrument for its intended use. RUO: Research Use Only, not for diagnostic procedures. IVD: In Vitro Diagnostic device. LDT: Laboratory Developed Test. CE-IVD: European conformity for in vitro diagnostics. FDA Cleared: US FDA cleared for clinical use. CLIA Compliant: meets Clinical Laboratory Improvement Amendments standards.. Valid values are `RUO|IVD|LDT|CE-IVD|FDA Cleared|CLIA Compliant`',
    `remote_monitoring_enabled_flag` BOOLEAN COMMENT 'Indicates whether the instrument is enrolled in remote monitoring and diagnostics services. True enables proactive issue detection, predictive maintenance, and automated performance reporting. False indicates customer opted out or network restrictions prevent remote access.',
    `replacement_instrument_serial_number` STRING COMMENT 'Serial number of the instrument that replaced this unit, if applicable. Used for upgrade tracking and customer migration analysis. Null if not replaced or customer discontinued service.. Valid values are `^[A-Z0-9]{8,20}$`',
    `service_tier` STRING COMMENT 'Level of service coverage for this instrument. Basic provides business-hours support. Standard adds extended hours. Premium includes 24/7 support and priority dispatch. Enterprise adds dedicated field service engineer and proactive monitoring.. Valid values are `Basic|Standard|Premium|Enterprise`',
    `servicenow_configuration_item_code` STRING COMMENT 'Unique identifier for this instrument in ServiceNow Configuration Management Database (CMDB). Links installed base registry to IT service management and field service dispatch systems.. Valid values are `^CI[0-9]{10,15}$`',
    `total_operational_hours` DECIMAL(18,2) COMMENT 'Cumulative hours the instrument has been in active operation since installation. Used for wear-and-tear assessment, maintenance interval calculation, and residual value estimation.',
    `total_run_count` STRING COMMENT 'Cumulative number of sequencing runs, array scans, or PCR cycles performed by this instrument since installation. Key metric for utilization analysis, lifecycle forecasting, and consumable demand prediction.',
    `upgrade_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this instrument is eligible for hardware or software upgrades based on model generation, current configuration, and customer service tier. True enables upgrade opportunity targeting. False indicates end-of-life model or configuration constraints.',
    `utilization_tier` STRING COMMENT 'Classification of instrument usage intensity based on run frequency, sample throughput, or operational hours. Used for proactive maintenance scheduling, consumable forecasting, and upgrade targeting. Low: occasional use. Medium: regular use. High: daily intensive use. Very High: continuous 24/7 operation.. Valid values are `Low|Medium|High|Very High`',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturer warranty coverage ends. Critical for service contract renewal targeting and customer communication planning.',
    `warranty_start_date` DATE COMMENT 'Date when the manufacturer warranty coverage begins. Typically aligned with installation date but may differ for pre-purchased or delayed-installation units.',
    `warranty_status` STRING COMMENT 'Current status of the warranty coverage. Active indicates warranty is in effect. Expired indicates warranty period has ended. Extended indicates customer purchased warranty extension. Voided indicates warranty was invalidated due to unauthorized modifications or misuse.. Valid values are `Active|Expired|Extended|Voided`',
    CONSTRAINT pk_installed_instrument PRIMARY KEY(`installed_instrument_id`)
) COMMENT 'Customer-facing registry of sequencing instruments, array scanners, PCR/qPCR platforms, and gene-editing equipment installed at customer sites. Captures instrument model, serial number, installation date, site address, warranty expiry, current firmware version, service contract reference, instrument status (active, decommissioned, under repair), utilization tier, and the customer account and contact responsible for the instrument. Enables field service dispatch, proactive maintenance scheduling, reagent/consumable consumption forecasting, and upgrade targeting. Note: this is the customer-relationship view of installed base; the instrument domain owns the engineering asset master.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`support_case` (
    `support_case_id` BIGINT COMMENT 'Unique identifier for the customer support case. Primary key.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who reported the support case.',
    `adverse_event_report_id` BIGINT COMMENT 'Foreign key linking to regulatory.adverse_event_report. Business justification: Support cases involving patient impact or device malfunction trigger MDR/MAUDE adverse event reporting obligations. Essential traceability for post-market surveillance and regulatory compliance in IVD',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Cases reference specific reagent batch/lot numbers for quality investigations and recall management. Replacing denormalized reagent_lot_number with structured batch_id FK enables automated batch trace',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Cases logged against specific reagent products enable product quality trend analysis, failure mode tracking, and product improvement prioritization. Critical for post-market surveillance and quality m',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Support cases must link to specific products (reagent kits, instruments, software) for quality management, complaint handling, CAPA investigations, and product performance analytics. Critical for regu',
    `contact_id` BIGINT COMMENT 'Identifier of the specific contact person who submitted the case.',
    `field_safety_action_id` BIGINT COMMENT 'Foreign key linking to regulatory.field_safety_action. Business justification: Quality issues escalate from support cases to field safety corrective actions (recalls, FSNs). Critical for complaint-to-FSCA traceability and regulatory reporting in genomics device post-market surve',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Support cases frequently originate from order fulfillment issues (damaged shipment, incorrect product, quality complaint). Linking case to originating order enables RMA processing, credit memo generat',
    `installed_instrument_id` BIGINT COMMENT 'Foreign key linking to customer.installed_instrument. Business justification: support_case has instrument_serial_number (STRING) which should be normalized to installed_instrument_id FK. The installed_instrument table has instrument_serial_number as an attribute, so the FK allo',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Support cases frequently involve specific reagent materials causing quality issues (failed runs, low Q-scores). Linking material_id enables batch-level quality investigations, trend analysis across ma',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Support cases in genomics biotech are frequently raised against a specific pipeline version (e.g., incorrect variant calls from v2.3.1). Support triage, root cause analysis, and CAPA processes require',
    `post_market_surveillance_id` BIGINT COMMENT 'Foreign key linking to regulatory.post_market_surveillance. Business justification: Support cases (complaints) are a primary data source for post-market surveillance under EU MDR Article 83 and FDA 21 CFR Part 803. Linking each complaint directly to the PMS record it feeds enables au',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Technical support cases reference specific reagent lot numbers for troubleshooting quality issues, performance deviations, or contamination investigations. Lot-level traceability enables root cause an',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: A support case is frequently governed by a specific service agreement that defines the SLA tier, response time commitments, and coverage scope. Linking support_case directly to service_agreement enabl',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Support cases in genomics biotech are frequently software defect reports or validation failures tied to a specific release. Linking to software_release enables defect tracking by release, regression a',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Support cases in genomics biotech are frequently raised against a specific product specification (e.g., reagent kit failing Q30 or coverage depth spec). Linking to specification enables CAPA root-caus',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Complaint handling in genomics biotech (21 CFR 820.198, EU MDR Article 92) requires linking each support case/complaint to the regulatory submission governing the affected product. This enables MDR/vi',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Genomics biotech quality processes require linking customer complaints about defective reagents/materials directly to the responsible supplier to initiate Supplier Corrective Action Requests (SCARs) a',
    `assigned_to_team` STRING COMMENT 'Name of the support team or queue assigned to the case (e.g., Instrument Support, Reagent QC, Bioinformatics, Field Applications).',
    `case_number` STRING COMMENT 'Externally visible unique case number assigned by ServiceNow or Salesforce CRM for customer reference and tracking.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the support case: open (newly created), in-progress (actively being worked), pending-customer (awaiting customer response), pending-internal (awaiting internal escalation or parts), resolved (solution provided), closed (customer confirmed resolution), or cancelled. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_internal|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the support case by primary issue category: instrument fault (sequencer or array scanner malfunction), reagent QC complaint (lot quality or performance issue), software/pipeline issue (bioinformatics or BaseSpace problem), application support (protocol or experimental design question), billing inquiry, or general inquiry.. Valid values are `instrument_fault|reagent_qc_complaint|software_pipeline_issue|application_support|billing_inquiry|general_inquiry`',
    `channel` STRING COMMENT 'Channel through which the customer reported the case: phone, email, web portal, chat, or on-site visit.. Valid values are `phone|email|web_portal|chat|on_site`',
    `closed_date` DATE COMMENT 'Date the case was closed after customer confirmation or automatic closure.',
    `closed_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the case was closed.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the customer location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the support case record was first created in the system.',
    `customer_feedback` STRING COMMENT 'Free-text feedback provided by the customer regarding their support experience.',
    `customer_satisfaction_score` STRING COMMENT 'Customer satisfaction rating provided by the customer after case closure, typically on a scale of 1 to 5.',
    `customer_segment` STRING COMMENT 'Customer segment classification (e.g., Research Use Only (RUO), In Vitro Diagnostic (IVD), Clinical, Biopharma, Agricultural Genomics, OEM (Original Equipment Manufacturer)).',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the case has been escalated to senior technical staff or management due to complexity or customer impact.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was escalated, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the support case record was last updated.',
    `on_site_visit_required_flag` BOOLEAN COMMENT 'Indicates whether an on-site field service engineer visit was required to resolve the case.',
    `parts_shipped_flag` BOOLEAN COMMENT 'Indicates whether replacement parts or consumables were shipped to the customer as part of case resolution.',
    `priority` STRING COMMENT 'Business priority assigned to the case based on customer impact and urgency. Critical: production sequencing halted; High: significant workflow disruption; Medium: workaround available; Low: informational or minor issue.. Valid values are `critical|high|medium|low`',
    `region` STRING COMMENT 'Geographic region of the customer reporting the case (e.g., North America, EMEA, APAC, LATAM).',
    `reported_date` DATE COMMENT 'Date the customer initially reported the issue.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the case was created in the support system.',
    `resolution_date` DATE COMMENT 'Date the case was marked as resolved.',
    `resolution_summary` STRING COMMENT 'Summary of the actions taken to resolve the case, including troubleshooting steps, parts replaced, software patches applied, or guidance provided.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the case was marked as resolved.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause determined during case resolution (e.g., hardware failure, reagent defect, user error, software bug, environmental factor, design limitation).',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause identified by the support team.',
    `severity` STRING COMMENT 'Technical severity level of the issue. Sev1: complete system failure; Sev2: major functionality impaired; Sev3: minor functionality impaired; Sev4: cosmetic or documentation issue.. Valid values are `sev1|sev2|sev3|sev4`',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the case was resolved within the SLA target time.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target turnaround time in hours as defined by the customers service level agreement for this case priority and type.',
    `subject` STRING COMMENT 'Brief summary or title of the support case describing the issue.',
    `support_case_description` STRING COMMENT 'Detailed description of the issue as reported by the customer, including symptoms, error messages, and context.',
    `tat_hours` DECIMAL(18,2) COMMENT 'Total turnaround time in hours from case creation to resolution, calculated as the difference between reported_timestamp and resolution_timestamp.',
    CONSTRAINT pk_support_case PRIMARY KEY(`support_case_id`)
) COMMENT 'Records customer-reported technical support cases, instrument issues, reagent complaints, bioinformatics pipeline questions, and field application requests. Sourced from ServiceNow and Salesforce CRM Case objects. Captures case number, case type (instrument fault, reagent QC complaint, software/pipeline issue, application support, billing inquiry), priority, severity, status (open, in-progress, resolved, closed), reported date, resolution date, TAT, root cause category, resolution summary, and escalation flag. Distinct from internal CAPA records owned by the quality domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`support_case`(`support_case_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `genomics_biotech_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'ruo|ivd_clinical|oem|agricultural|biopharma|academic_government');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `assigned_territory` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Territory');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `erp_customer_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Customer Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Account Established Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `hipaa_baa_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Business Associate Agreement (BAA) Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `hipaa_baa_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Business Associate Agreement (BAA) Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Account Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'enterprise|volume|standard|promotional');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_city` SET TAGS ('dbx_business_glossary_term' = 'Primary City');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_business_glossary_term' = 'Primary State or Province');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `segment_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Change Reason');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `segment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|standard');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Tier Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_value_regex' = 'key_account|growth|standard');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'principal_investigator|lab_director|procurement_officer|field_application_scientist|clinical_specialist|purchasing_contact');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'consented|not_consented|withdrawn|pending');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `marketing_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `phi_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Authorization Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `phi_handling_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Handling Authorization Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal|in_person');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `research_focus` SET TAGS ('dbx_business_glossary_term' = 'Research Focus Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Dr|Prof|Mr|Ms|Mrs|Mx');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Contact Name Suffix');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `technical_expertise_area` SET TAGS ('dbx_business_glossary_term' = 'Technical Expertise Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Segment Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `consent_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Requirement Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Standard Contract Term in Months');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Credit Limit in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `gxp_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Compliance Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `market_sub_vertical` SET TAGS ('dbx_business_glossary_term' = 'Market Sub-Vertical');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `market_vertical` SET TAGS ('dbx_business_glossary_term' = 'Market Vertical');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Email Address');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Payment Terms in Days');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `phi_handling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Handling Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `preferred_sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sales Channel');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `preferred_sales_channel` SET TAGS ('dbx_value_regex' = 'DIRECT|DISTRIBUTOR|OEM|ONLINE|FIELD_SALES|INSIDE_SALES');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'TIER_1|TIER_2|TIER_3|TIER_4|CUSTOM|VOLUME_DISCOUNT');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `product_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Eligibility Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `promotional_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Eligibility Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `regulatory_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `regulatory_use_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|CLINICAL|RESEARCH|MIXED');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'PREMIUM|STANDARD|BASIC|CUSTOM');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SALESFORCE_CRM|SAP_SD|MANUAL|DATA_MIGRATION');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_value_regex' = 'KEY_ACCOUNT|STRATEGIC|GROWTH|STANDARD|EMERGING');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `support_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Support Priority Level');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `target_annual_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Target Annual Revenue in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `target_annual_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `target_asp_usd` SET TAGS ('dbx_business_glossary_term' = 'Target Average Selling Price (ASP) in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `target_asp_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `technical_support_model` SET TAGS ('dbx_business_glossary_term' = 'Technical Support Model');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `technical_support_model` SET TAGS ('dbx_value_regex' = 'DEDICATED_FAE|SHARED_FAE|SELF_SERVICE|PARTNER_SUPPORT|PREMIUM_SUPPORT');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `typical_order_size_category` SET TAGS ('dbx_business_glossary_term' = 'Typical Order Size Category');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` ALTER COLUMN `typical_order_size_category` SET TAGS ('dbx_value_regex' = 'SMALL|MEDIUM|LARGE|ENTERPRISE|CUSTOM');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'shipping|billing|legal|lab_site|mailing|headquarters');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_business_glossary_term' = 'Biosafety Level (BSL)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_value_regex' = 'BSL-1|BSL-2|BSL-3|BSL-4|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `cold_chain_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `cold_chain_temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Temperature Range');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `hazmat_receiving_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Receiving Authorized Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `hazmat_un_classes_accepted` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials United Nations (UN) Classes Accepted');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `loading_dock_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock Available Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `receiving_hours` SET TAGS ('dbx_business_glossary_term' = 'Receiving Hours');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Address Validated Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Source');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` SET TAGS ('dbx_subdomain' = 'engagement_support');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `technical_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirement ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `ivd_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Application Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `budget_constraint_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Constraint (United States Dollar)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `budget_constraint_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requirement Capture Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `data_delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Data Delivery Format');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `data_delivery_format` SET TAGS ('dbx_value_regex' = 'FASTQ|BAM|VCF|FASTQ_BAM|FASTQ_VCF|FASTQ_BAM_VCF');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `data_storage_location_preference` SET TAGS ('dbx_business_glossary_term' = 'Data Storage Location Preference');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `data_storage_location_preference` SET TAGS ('dbx_value_regex' = 'on_premise|cloud_aws|cloud_azure|cloud_gcp|baseSpace|hybrid');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'pre_sales|onboarding|support|annual_review|project_consultation|custom_development');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `flow_cell_type` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `gxp_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Compliance Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `index_strategy` SET TAGS ('dbx_business_glossary_term' = 'Index Strategy');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `index_strategy` SET TAGS ('dbx_value_regex' = 'single_index|dual_index|unique_dual_index|combinatorial_dual_index');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `library_prep_method` SET TAGS ('dbx_business_glossary_term' = 'Library Preparation Method');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `minimum_coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Minimum Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `multiplexing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Multiplexing Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirement Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `phi_handling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Handling Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `phred_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Phred Quality Score Threshold');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `qc_metric_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Metric Requirements');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `read_configuration` SET TAGS ('dbx_business_glossary_term' = 'Read Configuration');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `read_configuration` SET TAGS ('dbx_value_regex' = 'single_end|paired_end');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `read_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Read Length (Base Pairs)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `regulatory_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `regulatory_use_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|clinical_research|diagnostic');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirement Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^TR-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirement Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `samples_per_run` SET TAGS ('dbx_business_glossary_term' = 'Samples Per Run');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `species` SET TAGS ('dbx_business_glossary_term' = 'Species');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `target_coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Target Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `throughput_requirement_gb` SET TAGS ('dbx_business_glossary_term' = 'Throughput Requirement (Gigabases)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) in Days');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `variant_calling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Variant Calling Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` SET TAGS ('dbx_subdomain' = 'engagement_support');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Covered Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Covered Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Covered Service Offering Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `post_market_surveillance_id` SET TAGS ('dbx_business_glossary_term' = 'Post Market Surveillance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SA-[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value (ACV)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agreement Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|annually|milestone_based');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `commercial_conversion_outcome` SET TAGS ('dbx_business_glossary_term' = 'Commercial Conversion Outcome');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `commercial_conversion_outcome` SET TAGS ('dbx_value_regex' = 'not_applicable|converted|not_converted|pending_decision');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `confidentiality_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `covered_instruments` SET TAGS ('dbx_business_glossary_term' = 'Covered Instruments');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `customer_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Summary');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `evaluation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `evaluation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'not_applicable|planned|in_progress|completed|converted_to_commercial|discontinued');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `internal_scientific_lead` SET TAGS ('dbx_business_glossary_term' = 'Internal Scientific Lead');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Terms');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `products_under_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Products Under Evaluation');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Commitment (Hours)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_level_penalties` SET TAGS ('dbx_business_glossary_term' = 'Service Level Penalties');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_level_penalties` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|custom');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `uptime_guarantee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Guarantee Percentage');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_support');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Support Case ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `application_area` SET TAGS ('dbx_business_glossary_term' = 'Genomic Application Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|video_conference|customer_portal|webinar');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `competitive_mention_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Mention Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'research_institution|clinical_laboratory|biopharma_partner|agricultural_genomics_client|oem_account|individual_researcher');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Minutes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `employee_role` SET TAGS ('dbx_business_glossary_term' = 'Employee Role');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `employee_role` SET TAGS ('dbx_value_regex' = 'sales_representative|field_application_scientist|technical_support_engineer|account_manager|product_specialist|service_engineer');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `gdpr_consent_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Verified Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Interaction Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'completed|scheduled|cancelled|no_show|rescheduled');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'sales_call|fas_site_visit|technical_support_call|webinar_attendance|trade_show_meeting|product_demonstration');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Interaction Language');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Interaction Location');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|follow_up_required|issue_resolved|no_action|opportunity_identified|escalated');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'ruo|ivd|ldt|clinical');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `salesforce_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Activity ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Sentiment Score');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|very_positive|very_negative');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `technical_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `ivd_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Director Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Site Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|revoked|under_review');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_value_regex' = 'CLIA|CAP|ISO_15189|CE_IVD|GxP|IRB');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Complexity Level');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `complexity_level` SET TAGS ('dbx_value_regex' = 'waived|moderate|high');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Document Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `gxp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `gxp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable|under_review');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `ivd_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'In Vitro Diagnostic (IVD) Authorized Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Director License Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `laboratory_site_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Site Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `phi_handling_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Handling Authorized Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `product_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Eligibility Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `salesforce_accreditation_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Accreditation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` SET TAGS ('dbx_subdomain' = 'engagement_support');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Udi Assignment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Service Contract Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `ivd_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `model_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Asset Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Site Address Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_business_glossary_term' = 'Biosafety Level (BSL)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_value_regex' = 'BSL-1|BSL-2|BSL-3|BSL-4|Not Applicable');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'Research Use Only (RUO)|In Vitro Diagnostic (IVD)|Clinical Laboratory|Biopharma|Agricultural Genomics|OEM Partner');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `data_sharing_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `data_sharing_consent_status` SET TAGS ('dbx_value_regex' = 'Consented|Not Consented|Partial Consent|Withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `firmware_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `instrument_location_description` SET TAGS ('dbx_business_glossary_term' = 'Instrument Location Description');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Instrument Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Under Repair|Decommissioned|Pending Installation|Pending Decommission');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Network Connectivity Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_value_regex' = 'Ethernet|Wi-Fi|Cellular|Offline|Hybrid');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `next_scheduled_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Service Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Instrument Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|CE-IVD|FDA Cleared|CLIA Compliant');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `remote_monitoring_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Monitoring Enabled Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `replacement_instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Instrument Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `replacement_instrument_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'Basic|Standard|Premium|Enterprise');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `servicenow_configuration_item_code` SET TAGS ('dbx_business_glossary_term' = 'ServiceNow Configuration Item Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `servicenow_configuration_item_code` SET TAGS ('dbx_value_regex' = '^CI[0-9]{10,15}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `total_operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Operational Hours');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `total_run_count` SET TAGS ('dbx_business_glossary_term' = 'Total Run Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `upgrade_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligibility Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `utilization_tier` SET TAGS ('dbx_business_glossary_term' = 'Utilization Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `utilization_tier` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Very High');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'Active|Expired|Extended|Voided');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` SET TAGS ('dbx_subdomain' = 'engagement_support');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Support Case ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `adverse_event_report_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Report Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `post_market_surveillance_id` SET TAGS ('dbx_business_glossary_term' = 'Post Market Surveillance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `assigned_to_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'instrument_fault|reagent_qc_complaint|software_pipeline_issue|application_support|billing_inquiry|general_inquiry');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Support Channel');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|web_portal|chat|on_site');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `on_site_visit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Site Visit Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `parts_shipped_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Shipped Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'sev1|sev2|sev3|sev4');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `support_case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `tat_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Hours');
