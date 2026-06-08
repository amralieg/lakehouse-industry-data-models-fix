-- Schema for Domain: customer | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`customer` COMMENT 'Single source of truth for all customer identities — research institutions, clinical laboratories, biopharma partners, agricultural genomics clients, OEM accounts, and individual researchers. Owns customer profiles, account hierarchies, contacts, segmentation (RUO vs. IVD/clinical), consent records, technical requirements, service agreements, and relationship history. Master data managed via Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the customer account. Primary key for the account entity.',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: Accounts must comply with master data management policies governing retention, access control, PHI handling, and cross-border transfer rules. Essential for regulatory compliance (GDPR, HIPAA) and oper',
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
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Contact has embedded mailing address fields (mailing_street, mailing_city, mailing_state_province, mailing_postal_code, mailing_country_code) which should be normalized to mailing_address_id FK to the',
    `contact_role` STRING COMMENT 'Primary functional role of the contact within the customer relationship (technical, commercial, billing, regulatory, procurement, clinical, research). [ENUM-REF-CANDIDATE: technical|commercial|billing|regulatory|procurement|clinical|research — 7 candidates stripped; promote to reference product]',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record (active, inactive, suspended, pending_verification).. Valid values are `active|inactive|suspended|pending_verification`',
    `contact_type` STRING COMMENT 'Specific classification of the contact based on their professional function (principal investigator, lab director, procurement officer, field application scientist, clinical specialist, purchasing contact).. Valid values are `principal_investigator|lab_director|procurement_officer|field_application_scientist|clinical_specialist|purchasing_contact`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the system.',
    `customer_segment` STRING COMMENT 'Market segment classification for the contacts organization (Research Use Only, In Vitro Diagnostic, clinical, biopharma, agricultural, academic, government, Original Equipment Manufacturer). [ENUM-REF-CANDIDATE: ruo|ivd|clinical|biopharma|agricultural|academic|government|oem — 8 candidates stripped; promote to reference product]',
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
    `product_interest` STRING COMMENT 'Primary product category or solution the contact has expressed interest in (e.g., WGS, WES, Targeted Panels, Microarrays, Library Prep Kits, Bioinformatics Software).',
    `research_focus` STRING COMMENT 'Primary research focus or application area for the contact (e.g., Cancer Genomics, Agricultural Genomics, Rare Disease, Pharmacogenomics, Population Health).',
    `salutation` STRING COMMENT 'Professional or personal title prefix for the contact (Dr, Prof, Mr, Ms, Mrs, Mx).. Valid values are `Dr|Prof|Mr|Ms|Mrs|Mx`',
    `secondary_email_address` STRING COMMENT 'Alternate email address for the contact, used for backup communication or specific purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `suffix` STRING COMMENT 'Professional or generational suffix for the contact (Jr, Sr, II, III, PhD, MD, DVM, ScD). [ENUM-REF-CANDIDATE: Jr|Sr|II|III|IV|PhD|MD|DVM|ScD — 9 candidates stripped; promote to reference product]',
    `technical_expertise_area` STRING COMMENT 'Primary area of technical or scientific expertise for the contact (e.g., Next-Generation Sequencing, Bioinformatics, Clinical Genomics, CRISPR Gene Editing, Array-Based Genotyping).',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual person associated with a customer account — principal investigators, lab directors, procurement officers, clinical genomics specialists, field application scientists, and purchasing contacts. Sourced from Salesforce CRM Contact object. Captures full name, job title, department, email, phone, preferred communication channel, contact role (technical, commercial, billing, regulatory), opt-in/opt-out marketing flags, GDPR consent status, PHI handling authorization, and active/inactive status.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'Unique identifier for the account hierarchy relationship record.',
    `account_id` BIGINT COMMENT 'Identifier of the child account in the hierarchy. References the downstream account such as subsidiary labs, satellite clinical genomics sites, or member institutions.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this account hierarchy relationship. References the user management system for accountability and audit trail purposes.',
    `parent_account_id` BIGINT COMMENT 'Identifier of the parent account in the hierarchy. References the upstream account in enterprise structures such as biopharma groups, hospital networks, or academic consortia.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this account hierarchy relationship was formally approved by sales operations or finance for activation in consolidated reporting and pricing programs. Null for relationships pending approval.',
    `billing_rollup_flag` BOOLEAN COMMENT 'Indicates whether invoices for the child account should be consolidated and rolled up to the parent account for centralized billing. True for enterprise agreements with consolidated invoicing; false for independent billing.',
    `business_segment` STRING COMMENT 'Business segment classification for this hierarchical relationship, indicating the primary market focus. Enables segment-specific reporting and strategic analysis across RUO (Research Use Only), IVD (In Vitro Diagnostic), and other genomics applications.. Valid values are `research|clinical|agricultural|pharmaceutical|diagnostic|industrial`',
    `consolidation_eligible_flag` BOOLEAN COMMENT 'Indicates whether this hierarchical relationship qualifies for consolidated commercial reporting and volume-based pricing aggregation. True for relationships that should roll up revenue, orders, and usage; false for informational-only links.',
    `contract_reference_number` STRING COMMENT 'Reference number of the master service agreement, enterprise contract, or consortium agreement that governs this hierarchical relationship. Links to contract management systems for terms and conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account hierarchy relationship record was first created in the system. Supports audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date when the hierarchical relationship becomes active and begins participating in consolidated commercial reporting and pricing aggregation. Supports temporal queries and historical analysis.',
    `expiry_date` DATE COMMENT 'Date when the hierarchical relationship ends or is scheduled to terminate. Null for open-ended relationships. Enables time-bound hierarchy analysis and future-state planning.',
    `geographic_region` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary geographic region where this hierarchical relationship operates. Used for regional sales reporting and compliance segmentation. [ENUM-REF-CANDIDATE: USA|CAN|GBR|DEU|FRA|CHN|JPN|AUS|IND|BRA|MEX|ITA|ESP|NLD|CHE|SWE|SGP|KOR|ISR|BEL — 20 candidates stripped; promote to reference product]',
    `hierarchy_level` STRING COMMENT 'Numeric level in the account hierarchy tree structure. Level 1 represents the top-level parent, with increasing numbers for deeper nested relationships. Enables depth-based queries and rollup aggregations.',
    `hierarchy_path` STRING COMMENT 'Materialized path representation of the full account hierarchy from root to current node, typically formatted as slash-delimited account identifiers (e.g., /1001/2045/3078/). Enables efficient ancestor and descendant queries without recursive joins.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity or company code under which this hierarchical relationship is registered for financial and regulatory reporting purposes. Aligns with ERP (Enterprise Resource Planning) company code structures.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this account hierarchy relationship record was last modified. Tracks the most recent update for change management and audit purposes.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this account hierarchy relationship, capturing special instructions, historical context, or operational considerations for sales and finance teams.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or control the parent account holds over the child account. Used for financial consolidation, revenue attribution, and equity-based reporting. Null for non-ownership relationships such as consortium members or OEM (Original Equipment Manufacturer) resellers.',
    `pricing_tier_inheritance_flag` BOOLEAN COMMENT 'Indicates whether the child account inherits volume-based pricing tiers and discounts from the parent account. True for subsidiaries and affiliates participating in enterprise pricing programs; false for independent pricing.',
    `primary_hierarchy_flag` BOOLEAN COMMENT 'Indicates whether this is the primary hierarchical relationship for the child account. True when this parent-child link is the authoritative path for reporting and aggregation; false for secondary or alternate hierarchies.',
    `relationship_description` STRING COMMENT 'Free-text description providing additional context about the hierarchical relationship, such as the business rationale, legal structure details, or special commercial arrangements between parent and child accounts.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the hierarchical relationship. Active relationships participate in volume-based pricing and consolidated reporting; inactive or terminated relationships are excluded.. Valid values are `active|inactive|pending|suspended|terminated`',
    `relationship_type` STRING COMMENT 'Classification of the hierarchical relationship between parent and child accounts. Defines the legal, operational, or commercial nature of the connection for consolidated reporting and pricing aggregation. [ENUM-REF-CANDIDATE: subsidiary|affiliate|consortium_member|oem_reseller|branch|division|franchise — 7 candidates stripped; promote to reference product]',
    `salesforce_account_hierarchy_code` STRING COMMENT 'External identifier from Salesforce CRM (Customer Relationship Management) system representing this account hierarchy relationship. Enables traceability to the source system of record for customer master data.',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Defines parent-child relationships within customer account structures — enterprise biopharma groups with subsidiary labs, hospital networks with satellite clinical genomics sites, academic consortia with member institutions, and OEM partner trees. Captures parent account, child account, hierarchy level, relationship type (subsidiary, affiliate, consortium member, OEM reseller), effective date, and expiry date. Enables consolidated commercial reporting and volume-based pricing aggregation across account families.';

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

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` (
    `customer_consent_record_id` BIGINT COMMENT 'Unique identifier for the customer consent record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account or organization that provided this consent. Links to the customer master record managed in Salesforce CRM.',
    `contact_id` BIGINT COMMENT 'Reference to the specific individual contact person who provided or signed this consent. Links to the contact master record.',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to data.dpia. Business justification: Processing genomic data with PHI requires Data Protection Impact Assessment under GDPR Article 35. Consent records must reference the DPIA that authorized the processing activity. Mandatory for lawful',
    `parent_consent_record_customer_consent_record_id` BIGINT COMMENT 'Reference to a parent or predecessor consent record that this record supersedes or amends. Used to track consent version history and re-consent workflows. Nullable if this is an original consent.',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to data.retention_policy. Business justification: Consent records have legal retention requirements under GDPR, HIPAA, and IRB protocols. Retention policies define minimum/maximum retention periods and disposal methods for consent documentation. Dire',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the detailed audit trail or log entry that captures the full consent workflow, including all system interactions, user actions, and timestamps. Links to audit logging system.',
    `collection_channel` STRING COMMENT 'The channel or method through which this consent was collected from the customer. Indicates whether consent was obtained via web portal, mobile application, paper form, email, CRM system entry, phone conversation, in-person interaction, or API integration. [ENUM-REF-CANDIDATE: web_portal|mobile_app|paper_form|email|crm_system|phone|in_person|api — 8 candidates stripped; promote to reference product]',
    `consent_date` DATE COMMENT 'The date on which the customer or contact provided this consent. Represents the business event date when consent was granted, distinct from system audit timestamps.',
    `consent_effective_date` DATE COMMENT 'The date from which this consent becomes legally effective and enforceable. May differ from consent_date if there is a future start date specified in the agreement.',
    `consent_expiry_date` DATE COMMENT 'The date on which this consent expires and is no longer valid. Nullable for consents that do not have a predetermined expiration. Used to trigger re-consent workflows and ensure compliance with time-limited authorizations.',
    `consent_language` STRING COMMENT 'The language in which the consent form was presented to and understood by the data subject. ISO 639-1 two-letter language code (e.g., EN for English, ES for Spanish, FR for French).',
    `consent_method` STRING COMMENT 'The method by which consent was formally captured and recorded. Includes electronic signature, wet (physical) signature, verbal consent (documented), checkbox selection, click-through acceptance, or implied consent.. Valid values are `electronic_signature|wet_signature|verbal|checkbox|click_through|implied`',
    `consent_purpose` STRING COMMENT 'The specific business or legal purpose for which this consent was obtained. Examples include research data sharing, marketing communications, clinical trial participation, genomic data analysis, or third-party data transfer.',
    `consent_scope` STRING COMMENT 'Detailed description of the scope and boundaries of what this consent covers. Specifies the data types, processing activities, third parties, geographic regions, or specific use cases that are authorized under this consent.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record. Indicates whether consent is actively granted, has been withdrawn by the customer, has expired based on time limits, is pending approval or signature, has been revoked by the organization, or has been superseded by a newer consent version.. Valid values are `granted|withdrawn|expired|pending|revoked|superseded`',
    `consent_text_reference` STRING COMMENT 'Reference identifier or document control number pointing to the full legal text of the consent agreement. Links to the controlled document repository (e.g., Veeva Vault) where the complete consent language is stored.',
    `consent_type` STRING COMMENT 'The category or type of consent being recorded. Includes GDPR (General Data Protection Regulation) data processing consent, HIPAA (Health Insurance Portability and Accountability Act) Business Associate Agreement acknowledgment, PHI (Protected Health Information) handling authorization, marketing opt-in/opt-out, genomic data sharing consent per NIH (National Institutes of Health) Genomic Data Sharing Policy, and IRB (Institutional Review Board) related data use agreements.. Valid values are `gdpr_data_processing|hipaa_baa_acknowledgment|phi_handling_authorization|marketing_opt_in|marketing_opt_out|genomic_data_sharing`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form or agreement template used when this consent was obtained. Tracks which version of the legal text or policy the customer agreed to, enabling audit trails when consent language changes.',
    `consenting_party_role` STRING COMMENT 'The role or capacity in which the individual provided consent. Indicates whether they are the primary contact, an authorized representative, legal guardian, principal investigator, IRB (Institutional Review Board) coordinator, or data protection officer.. Valid values are `primary_contact|authorized_representative|legal_guardian|principal_investigator|irb_coordinator|data_protection_officer`',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user or process that created this consent record. Part of the audit trail for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this consent record was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `data_subject_email` STRING COMMENT 'The email address of the individual who provided consent. Used for consent verification, withdrawal notifications, and audit trail purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_subject_name` STRING COMMENT 'The full name of the individual data subject (person) who provided this consent. May differ from the customer account name if the consent is provided by an authorized representative or specific contact within an organization.',
    `geolocation` STRING COMMENT 'Geographic location information (e.g., country, region, or coordinates) from which the consent was provided. Used to determine applicable data protection regulations and jurisdictional compliance requirements.',
    `ip_address` STRING COMMENT 'The IP address from which the consent was submitted, if collected via electronic channel. Used for audit trail and fraud prevention purposes. May be considered PII under GDPR in certain jurisdictions.',
    `irb_protocol_number` STRING COMMENT 'The IRB (Institutional Review Board) protocol number associated with this consent, if applicable. Links consent to a specific approved research study or clinical trial.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or geographic region whose data protection laws govern this consent. Examples include EU, USA, California, Brazil, Canada. Determines applicable compliance requirements and data subject rights.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user or process that last modified this consent record. Part of the audit trail for accountability and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this consent record was last updated or modified. Part of the audit trail for record lifecycle tracking.',
    `marketing_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive marketing communications. True if opted in, False if opted out.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to this consent record. Used to capture special circumstances, clarifications, or operational details not covered by structured fields.',
    `regulatory_framework` STRING COMMENT 'The primary regulatory or legal framework under which this consent was obtained. Includes GDPR (General Data Protection Regulation), HIPAA (Health Insurance Portability and Accountability Act), CCPA (California Consumer Privacy Act), LGPD (Brazilian General Data Protection Law), PIPEDA (Canadian Personal Information Protection and Electronic Documents Act), or NIH (National Institutes of Health) Genomic Data Sharing Policy.. Valid values are `gdpr|hipaa|ccpa|lgpd|pipeda|nih_gds_policy`',
    `renewal_frequency_months` STRING COMMENT 'The frequency in months at which this consent must be renewed. Nullable if renewal is not required or if renewal is event-driven rather than time-based.',
    `renewal_required` BOOLEAN COMMENT 'Boolean flag indicating whether this consent requires periodic renewal or re-confirmation. True if renewal is required, False if consent is perpetual or does not require renewal.',
    `research_participation_consent` BOOLEAN COMMENT 'Boolean flag indicating whether the customer or data subject has consented to participation in research studies or use of their data for research purposes. True if consent is granted, False otherwise.',
    `signature_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consent was signed or formally accepted by the data subject. Provides audit trail for electronic consent workflows.',
    `third_party_list` STRING COMMENT 'Comma-separated or structured list of specific third parties (organizations or categories) with whom data sharing is authorized under this consent. Nullable if no third-party sharing is allowed or if sharing is unrestricted.',
    `third_party_sharing_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether the data subject has consented to sharing their data with third parties. True if third-party sharing is authorized, False otherwise.',
    `withdrawal_date` DATE COMMENT 'The date on which the customer or data subject withdrew this consent. Nullable if consent has not been withdrawn. Triggers data processing cessation and right-to-be-forgotten workflows.',
    `withdrawal_reason` STRING COMMENT 'Free-text or coded reason provided by the data subject for withdrawing consent. Used for compliance documentation and to improve consent processes.',
    CONSTRAINT pk_customer_consent_record PRIMARY KEY(`customer_consent_record_id`)
) COMMENT 'Tracks explicit consent and data privacy agreements obtained from customer contacts and accounts — GDPR data processing consent, HIPAA Business Associate Agreement acknowledgment, PHI handling authorization, marketing opt-in/opt-out, genomic data sharing consent (NIH Genomic Data Sharing Policy), and IRB-related data use agreements. Captures consent type, consent version, consent status (granted, withdrawn, expired), consent date, expiry date, collection channel (web, paper, CRM), consent text version reference, and the identity of the consenting individual.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` (
    `technical_requirement_id` BIGINT COMMENT 'Unique identifier for the technical requirement record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom this technical requirement was captured.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Technical requirements specify which genomic products (sequencers, library prep kits, reagents) are needed for customer applications. Critical for technical sales consultations, quote generation, inst',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Requirements specify annotation source (GENCODE v42, RefSeq) for variant calling and interpretation pipelines. Direct operational dependency for bioinformatics service delivery. Replaces text-based an',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Technical requirements specify reference genome (GRCh38, T2T-CHM13) for sequencing alignment and variant calling. Essential for service specification, pipeline configuration, and result reproducibilit',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Customer technical requirements specify exact reagent materials needed by catalog number (e.g., specific library prep kit, flow cell type, index adapters). Essential for quote generation, order fulfil',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Technical requirements captured during pre-sales discovery directly inform opportunity configuration, product fit validation, and solution architecture. Sales teams reference these to build accurate q',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Customer technical requirements (coverage depth, turnaround time, annotation preferences, regulatory classification) drive selection of appropriate validated pipeline versions. Critical for matching c',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Customer technical requirements specify preferred reagent products (library prep methods, sequencing kits) for their applications. Tracks customer preferences for quote generation, opportunity qualifi',
    `employee_id` BIGINT COMMENT 'Identifier of the field application scientist, sales engineer, or support specialist who captured this technical requirement.',
    `quotation_id` BIGINT COMMENT 'Foreign key linking to order.quotation. Business justification: Technical requirements captured during pre-sales (read length, coverage depth, instrument platform, regulatory classification) drive quotation configuration. Sales engineers reference the technical re',
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
    `instrument_platform_preference` STRING COMMENT 'Customers preferred or required sequencing instrument platform (e.g., NovaSeq 6000, NextSeq 2000, MiSeq, iSeq 100). Free-text field to accommodate evolving product portfolio.',
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
    `opportunity_id` BIGINT COMMENT 'Salesforce opportunity ID of the commercial sale resulting from a successful evaluation or beta program conversion.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Service agreements cover specific products/instruments. Required for contract entitlement validation, warranty claim processing, service level compliance tracking, and determining which products are e',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Service agreements include reagent supply commitments, covered products, or reagent rental terms. Tracks which reagents are included in service contracts for entitlement verification, usage tracking, ',
    `employee_id` BIGINT COMMENT 'User ID or name of the person who approved this service agreement.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Service level agreements specify approved reference genome builds for contracted sequencing/analysis services. Regulatory compliance requirement (CAP/CLIA) and contractual obligation. Ensures consiste',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Service agreements in genomics often mandate specific qualified positions (CLIA director, GxP-qualified scientist) for regulatory compliance. Enables contract compliance verification and personnel ass',
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
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated or is associated with this interaction, such as a webinar series, trade show, or product launch event. Nullable for organic interactions.',
    `contact_id` BIGINT COMMENT 'Reference to the specific contact person at the customer account who participated in this interaction. Links to customer contact master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this interaction record. Used for audit trail and data quality accountability.',
    `interaction_employee_id` BIGINT COMMENT 'Reference to the internal Genomics Biotech employee who conducted or led the interaction. Typically a sales representative, Field Application Scientist (FAS), technical support engineer, or account manager.',
    `interaction_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who most recently modified this interaction record. Used for audit trail and change management.',
    `opportunity_id` BIGINT COMMENT 'Reference to the associated sales opportunity in Salesforce CRM if this interaction is part of an active sales cycle. Nullable for non-sales interactions.',
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
    `product_interest` STRING COMMENT 'Description of the specific Genomics Biotech product, instrument, reagent, or service that was the focus of the interaction. May include NGS platforms, array products, LIMS solutions, or bioinformatics pipelines.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the internal user (compliance officer, sales operations) who last verified the accreditation status.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Laboratory accreditations (CAP, CLIA, ISO15189) validate specific genome builds for clinical testing. Regulatory traceability requirement. Accreditation scope explicitly lists validated reference geno',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: accreditation has laboratory_director_name (STRING) which should be normalized to laboratory_director_contact_id FK to the contact table. Laboratory directors are key contacts responsible for accredit',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: accreditation has embedded laboratory site address fields (laboratory_site_address_line_1, laboratory_site_address_line_2, laboratory_site_city, laboratory_site_state_province, laboratory_site_postal_',
    `quality_rule_id` BIGINT COMMENT 'Foreign key linking to data.quality_rule. Business justification: Accredited laboratories (CLIA, CAP, ISO15189) must meet specific data quality standards for diagnostic genomic testing. Quality rules enforce accreditation requirements (e.g., minimum coverage depth, ',
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
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Company-owned instruments placed at customer sites for evaluation or under service agreements are depreciable assets requiring fixed asset tracking for financial statements, tax depreciation, and asse',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Sequencing instruments have validated/default reference genomes for onboard secondary analysis (BaseSpace, DRAGEN). Configuration management requirement for instrument qualification, software validati',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Installation technician name exists as denormalized string. Linking to employee enables service history tracking, GxP training verification, and audit trail integrity for instrument qualification docu',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Installed instruments must reference the catalog item representing that instrument model for asset tracking, service contract eligibility validation, consumables compatibility checks, and warranty man',
    `model_id` BIGINT COMMENT 'FK to instrument.instrument_model',
    `quality_rule_id` BIGINT COMMENT 'Foreign key linking to data.quality_rule. Business justification: Sequencing instruments generate data subject to instrument-specific quality control rules (cluster density, Q30 scores, error rates). Quality rules are applied per instrument model/serial number for r',
    `asset_id` BIGINT COMMENT 'Unique identifier for this installed instrument record in Salesforce CRM Asset object. Used for cross-system reconciliation and master data synchronization between Salesforce and enterprise data warehouse.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: installed_instrument has service_contract_number (STRING) which should be normalized to service_agreement_id FK. Instruments are often covered by service contracts that define maintenance, support, an',
    `address_id` BIGINT COMMENT 'Reference to the physical address where the instrument is installed. Links to customer address master for field service dispatch and logistics planning.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Instruments are sourced from specific OEM suppliers. Tracking original supplier enables warranty claim routing, parts procurement, service contract management, and supplier performance tracking for ca',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Instruments have validated reagent compatibility lists (e.g., sequencers qualified for specific library prep kits). Tracks which reagent products are approved for each installed instrument, supporting',
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
    `service_contract_end_date` DATE COMMENT 'Date when the current service contract coverage ends. Used for renewal opportunity identification and customer retention campaigns.',
    `service_contract_start_date` DATE COMMENT 'Date when the current service contract coverage begins. May follow warranty expiry or overlap with warranty for enhanced coverage.',
    `service_tier` STRING COMMENT 'Level of service coverage for this instrument. Basic provides business-hours support. Standard adds extended hours. Premium includes 24/7 support and priority dispatch. Enterprise adds dedicated field service engineer and proactive monitoring.. Valid values are `Basic|Standard|Premium|Enterprise`',
    `servicenow_configuration_item_code` STRING COMMENT 'Unique identifier for this instrument in ServiceNow Configuration Management Database (CMDB). Links installed base registry to IT service management and field service dispatch systems.. Valid values are `^CI[0-9]{10,15}$`',
    `software_version` STRING COMMENT 'Current control software version running on the instrument. Used for compatibility verification, troubleshooting, and upgrade eligibility assessment. Format: major.minor.patch.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
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
    `employee_id` BIGINT COMMENT 'Identifier of the support engineer or field application scientist currently assigned to the case.',
    `field_safety_action_id` BIGINT COMMENT 'Foreign key linking to regulatory.field_safety_action. Business justification: Quality issues escalate from support cases to field safety corrective actions (recalls, FSNs). Critical for complaint-to-FSCA traceability and regulatory reporting in genomics device post-market surve',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Support cases track reference genome version for troubleshooting alignment issues, variant calling discrepancies, and result reproducibility. Technical support requirement. Reference genome mismatch i',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Support cases frequently originate from order fulfillment issues (damaged shipment, incorrect product, quality complaint). Linking case to originating order enables RMA processing, credit memo generat',
    `installed_instrument_id` BIGINT COMMENT 'Foreign key linking to customer.installed_instrument. Business justification: support_case has instrument_serial_number (STRING) which should be normalized to installed_instrument_id FK. The installed_instrument table has instrument_serial_number as an attribute, so the FK allo',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Support cases frequently involve specific reagent materials causing quality issues (failed runs, low Q-scores). Linking material_id enables batch-level quality investigations, trend analysis across ma',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Support cases often originate from pre-sales technical questions during active opportunities. Field application scientists and sales engineers track which technical issues influenced deal progression,',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Support cases frequently originate from data quality failures (low Q-scores, failed runs, contamination). Linking cases to quality issues enables root cause analysis, trend detection, and resolution t',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Technical support cases reference specific reagent lot numbers for troubleshooting quality issues, performance deviations, or contamination investigations. Lot-level traceability enables root cause an',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Certain support cases (GxP-critical, CLIA-regulated assays) require assignment to specific qualified positions for regulatory compliance. Enables intelligent case routing and ensures qualified personn',
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
    `software_version` STRING COMMENT 'Version of the software, firmware, or bioinformatics pipeline involved in the case.',
    `subject` STRING COMMENT 'Brief summary or title of the support case describing the issue.',
    `support_case_description` STRING COMMENT 'Detailed description of the issue as reported by the customer, including symptoms, error messages, and context.',
    `tat_hours` DECIMAL(18,2) COMMENT 'Total turnaround time in hours from case creation to resolution, calculated as the difference between reported_timestamp and resolution_timestamp.',
    CONSTRAINT pk_support_case PRIMARY KEY(`support_case_id`)
) COMMENT 'Records customer-reported technical support cases, instrument issues, reagent complaints, bioinformatics pipeline questions, and field application requests. Sourced from ServiceNow and Salesforce CRM Case objects. Captures case number, case type (instrument fault, reagent QC complaint, software/pipeline issue, application support, billing inquiry), priority, severity, status (open, in-progress, resolved, closed), reported date, resolution date, TAT, root cause category, resolution summary, and escalation flag. Distinct from internal CAPA records owned by the quality domain.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique identifier for the training enrollment record. Primary key for the training enrollment entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this training enrollment. Links to the customer entity for account-level training tracking and reporting.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Training programs are product-specific (e.g., NovaSeq operation, Nextera library prep). Required for customer enablement tracking, certification management, product adoption analytics, and ensuring us',
    `contact_id` BIGINT COMMENT 'Reference to the customer contact who enrolled in the training program. Links to the contact entity in the customer domain.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Instructor name exists as denormalized string. Linking to employee enables GxP training record integrity, instructor qualification verification for regulatory audits, and tracking of customer-facing t',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: Training programs (CLIA compliance, instrument operation, application training) generate revenue recognized upon delivery/completion. Links enrollment to revenue accounting for financial reporting and',
    `actual_start_date` DATE COMMENT 'Actual date when the contact began the training program. May differ from scheduled start date due to late enrollment or rescheduling.',
    `application_focus` STRING COMMENT 'Primary genomic application or use case covered in the training (e.g., Whole Genome Sequencing (WGS), Whole Exome Sequencing (WES), Single Nucleotide Polymorphism (SNP) genotyping, Copy Number Variation (CNV) analysis, RNA-Seq, CRISPR screening). Aligns with customer research focus and technical requirements.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved on the training assessment or examination, typically expressed as a percentage (0.00 to 100.00). Null if no formal assessment was conducted.',
    `attendance_hours` DECIMAL(18,2) COMMENT 'Actual number of hours the contact attended or participated in the training program. Used to track engagement and compliance with minimum attendance requirements.',
    `certification_expiry_date` DATE COMMENT 'Date when the certification expires and requires renewal or recertification. Null for certifications with no expiration or if no certification was issued. Critical for tracking compliance with Clinical Laboratory Improvement Amendments (CLIA) and College of American Pathologists (CAP) requirements for clinical assay training.',
    `certification_issue_date` DATE COMMENT 'Date when the certification was officially issued to the contact. Typically aligns with or follows the completion date. Null if no certification was issued.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certification or credential was issued upon successful completion of the training program. True if certification was issued, False otherwise.',
    `certification_number` STRING COMMENT 'Unique certification identifier issued to the contact upon successful completion. Used for verification and audit purposes. Null if no certification was issued.. Valid values are `^CERT-[A-Z0-9]{8,16}$`',
    `clia_compliant_flag` BOOLEAN COMMENT 'Indicates whether this training meets Clinical Laboratory Improvement Amendments (CLIA) requirements for clinical laboratory personnel competency assessment. True if CLIA-compliant, False otherwise. Critical for Laboratory Developed Test (LDT) and In Vitro Diagnostic (IVD) applications.',
    `completion_date` DATE COMMENT 'Date when the contact successfully completed all requirements of the training program. Null if training is in progress or incomplete.',
    `completion_status` STRING COMMENT 'Final outcome of the training program: pass (met all completion criteria), fail (did not meet criteria), incomplete (partially completed), or not applicable (for informational sessions without pass/fail criteria).. Valid values are `pass|fail|incomplete|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_satisfaction_score` STRING COMMENT 'Post-training satisfaction rating provided by the contact, typically on a scale of 1 to 5 or 1 to 10. Used for training quality assessment and continuous improvement. Null if feedback was not collected.',
    `delivery_format` STRING COMMENT 'Format in which the training was delivered: in-person classroom or lab session, virtual live instructor-led, on-demand recorded content, hybrid combination, or self-paced online module.. Valid values are `in_person|virtual_live|on_demand|hybrid|self_paced`',
    `enrollment_date` DATE COMMENT 'Date when the contact enrolled in the training program. Represents the business event timestamp for enrollment initiation.',
    `enrollment_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for enrollment in the training program, expressed in the billing currency. May be zero for complimentary training provided as part of instrument purchase or service agreement. Used for revenue recognition and training program profitability analysis.',
    `enrollment_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the enrollment fee (e.g., USD, EUR, GBP, JPY). Used for multi-currency financial reporting and analysis.. Valid values are `^[A-Z]{3}$`',
    `enrollment_notes` STRING COMMENT 'Additional free-text notes or comments related to the enrollment, such as special accommodations, prerequisites completed, or follow-up actions required. Used for operational tracking and customer success management.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the training enrollment: registered (enrolled but not started), in progress (actively participating), completed (successfully finished), failed (did not meet completion criteria), withdrawn (contact withdrew), cancelled (program cancelled), or expired (enrollment period lapsed). [ENUM-REF-CANDIDATE: registered|in_progress|completed|failed|withdrawn|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `feedback_comments` STRING COMMENT 'Free-text feedback comments provided by the contact regarding the training experience, content quality, instructor effectiveness, or suggestions for improvement. Used for qualitative analysis and training program enhancement.',
    `hands_on_lab_included_flag` BOOLEAN COMMENT 'Indicates whether the training program included hands-on laboratory exercises or practical instrument operation. True if hands-on component was included, False for lecture-only or theoretical training.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training enrollment record was last updated. Used for change tracking and data synchronization between systems.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training program, expressed as a percentage (0.00 to 100.00). Used to determine pass/fail status.',
    `payment_status` STRING COMMENT 'Status of payment for the training enrollment fee: paid (payment received), pending (payment outstanding), waived (fee waived per agreement), refunded (payment returned), or not applicable (complimentary training).. Valid values are `paid|pending|waived|refunded|not_applicable`',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether periodic recertification is required to maintain the credential. True if recertification is mandatory, False if certification is permanent or not applicable.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this training satisfies regulatory compliance requirements for clinical laboratory personnel under Clinical Laboratory Improvement Amendments (CLIA), College of American Pathologists (CAP), or In Vitro Diagnostic Regulation (IVDR) standards. True if training meets regulatory requirements, False otherwise.',
    `salesforce_enrollment_code` STRING COMMENT 'Unique identifier for this training enrollment record in the Salesforce CRM system. Used for system integration and data lineage tracking between the lakehouse and the source system of record.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `scheduled_end_date` DATE COMMENT 'Planned end date for the training session or program. For multi-day or extended programs, represents the final scheduled session date.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the training session or program. For on-demand or self-paced training, this may represent the date access was granted.',
    `training_category` STRING COMMENT 'High-level category of the training program to support segmentation and reporting (instrument operation, library preparation, bioinformatics pipeline, gene editing techniques, clinical assay validation, quality and compliance, or safety training). [ENUM-REF-CANDIDATE: instrument_operation|library_preparation|bioinformatics|gene_editing|clinical_assay|quality_compliance|safety — 7 candidates stripped; promote to reference product]',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training program expressed in hours. Includes all instructional time, lab sessions, and required activities. Used for scheduling and resource planning.',
    `training_location` STRING COMMENT 'Physical location or facility where in-person training was conducted (e.g., customer site, Genomics Biotech training center, conference venue). For virtual training, may indicate the platform used (e.g., Zoom, Microsoft Teams). Null for on-demand training.',
    `training_materials_provided_flag` BOOLEAN COMMENT 'Indicates whether training materials (manuals, protocols, Standard Operating Procedures (SOPs), reference guides) were provided to the contact. True if materials were provided, False otherwise.',
    `training_program_code` STRING COMMENT 'Unique code identifying the specific training program (e.g., NGS-INST-101 for NGS instrument operation, LIBPREP-ADV for advanced library preparation, CRISPR-APP for CRISPR application training).. Valid values are `^[A-Z0-9]{4,12}$`',
    `training_program_name` STRING COMMENT 'Full descriptive name of the training program (e.g., Next-Generation Sequencing (NGS) Instrument Operation Certification, Advanced Library Preparation Workshop, CRISPR Gene Editing Application Training).',
    `training_region` STRING COMMENT 'Geographic region where the training was delivered (e.g., North America, Europe, Asia Pacific, Latin America). Used for regional training analytics and field application scientist territory management.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Tracks customer contact enrollment and completion of Genomics Biotech training programs — instrument operation training, library preparation workshops, bioinformatics pipeline onboarding, CRISPR application training, and clinical assay validation courses. Captures training program name, delivery format (in-person, virtual, on-demand), enrollment date, completion date, pass/fail status, certification issued, expiry date of certification, and the contact and account associated with the enrollment. Supports field application scientist scheduling and customer success tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`nda_record` (
    `nda_record_id` BIGINT COMMENT 'Unique identifier for the NDA or MTA record. Primary key for the nda_record product.',
    `account_id` BIGINT COMMENT 'Reference to the customer account with whom this NDA or MTA is executed. Links to the customer master data managed in Salesforce CRM.',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: NDAs establish legal framework for genomic data access (confidentiality, permitted use, IP terms). Access control policies enforce NDA terms technically. NDA is prerequisite for granting dataset acces',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Legal reviewer name exists as denormalized string. Linking to employee enables audit trails for contract approval authority, SOX compliance verification, and tracking of legal review workload and turn',
    `contact_id` BIGINT COMMENT 'Reference to the customer contact who signed the NDA or MTA on behalf of the customer organization. Links to the contact master data in Salesforce CRM.',
    `document_id` BIGINT COMMENT 'Reference to the executed NDA or MTA document stored in Veeva Vault regulatory document management system. Enables retrieval of the full legal document for audit and compliance purposes.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the NDA or MTA document. Used for reference in legal correspondence and contract management systems.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the NDA or MTA. Active agreements are enforceable; expired or terminated agreements no longer provide IP protection. Superseded indicates replacement by a newer agreement.. Valid values are `draft|pending_signature|active|expired|terminated|superseded`',
    `agreement_type` STRING COMMENT 'Classification of the confidentiality agreement. NDA = Non-Disclosure Agreement, MTA = Material Transfer Agreement, CDA = Confidential Disclosure Agreement, MNDA = Mutual Non-Disclosure Agreement. Determines the scope and nature of IP protection.. Valid values are `NDA|MTA|CDA|MNDA|Bilateral NDA|Unilateral NDA`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews unless one party provides notice of non-renewal. True = auto-renews, False = requires explicit renewal action.',
    `breach_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the receiving party is contractually obligated to notify Genomics Biotech of any unauthorized disclosure or breach of confidentiality. True = notification required, False = no explicit requirement.',
    `business_owner_name` STRING COMMENT 'Name of the Genomics Biotech business development, sales, or R&D representative who owns the customer relationship and is responsible for managing this NDA or MTA.',
    `countersignatory_name` STRING COMMENT 'Full name of the Genomics Biotech representative who countersigned the NDA or MTA. Typically a legal counsel, business development executive, or authorized officer.',
    `countersignatory_title` STRING COMMENT 'Job title or role of the Genomics Biotech countersignatory at the time of execution. Documents internal signatory authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NDA record was first created in the system. Supports audit trail and data lineage tracking.',
    `disclosure_purpose` STRING COMMENT 'Business rationale for sharing proprietary information under this agreement. Examples include product evaluation, collaborative research, OEM partnership discussions, or pre-commercial beta testing. Governs permissible use of disclosed information.',
    `document_version` STRING COMMENT 'Version identifier of the NDA or MTA document template used. Tracks evolution of standard agreement terms and supports version control for legal compliance.',
    `effective_start_date` DATE COMMENT 'Date from which the confidentiality obligations and IP protection provisions become binding. May differ from execution date if agreement specifies a future start.',
    `exclusions_from_confidentiality` STRING COMMENT 'Description of information explicitly excluded from confidentiality obligations. Typically includes publicly available information, independently developed information, information received from third parties without restriction, or information disclosed under legal compulsion.',
    `execution_date` DATE COMMENT 'Date on which the NDA or MTA was fully executed by all parties. Marks the effective start of the confidentiality obligations and IP protection period.',
    `expiry_date` DATE COMMENT 'Date on which the NDA or MTA expires and confidentiality obligations cease, unless extended or renewed. Null for perpetual agreements. Critical for determining what proprietary information can be shared.',
    `export_control_applicable_flag` BOOLEAN COMMENT 'Indicates whether the disclosed information or materials are subject to export control regulations (ITAR, EAR, or equivalent). True = export controls apply, False = no export restrictions.',
    `governing_law` STRING COMMENT 'Jurisdiction and legal framework under which the NDA or MTA is governed. Examples include Delaware law, California law, or English law. Critical for dispute resolution and enforceability.',
    `ip_classification` STRING COMMENT 'Internal classification of the IP sensitivity level covered by this agreement. Examples include trade secret, patent-pending, proprietary process, or competitive advantage. Governs internal disclosure controls and access restrictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this NDA record. Tracks data currency and supports change audit requirements.',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Indicates whether the agreement has been reviewed and approved by Genomics Biotech legal counsel prior to execution. True = legal review completed, False = pending or not required.',
    `legal_review_date` DATE COMMENT 'Date on which legal review was completed and the agreement was approved for execution. Null if no legal review was performed.',
    `material_transfer_included_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes provisions for physical transfer of proprietary materials (reagents, samples, prototypes). True = MTA provisions included, False = information disclosure only.',
    `mutual_agreement_flag` BOOLEAN COMMENT 'Indicates whether the NDA is mutual (both parties disclose and receive confidential information) or unilateral (only one party discloses). True = mutual, False = unilateral.',
    `notes` STRING COMMENT 'Free-text field for additional context, special provisions, amendment history, or internal comments related to the NDA or MTA. Not part of the legal document but supports operational management.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required for termination or non-renewal of the agreement. Null if no notice period is specified.',
    `permitted_use_scope` STRING COMMENT 'Defines the permissible use of disclosed confidential information. Evaluation_only restricts use to assessment purposes; research_collaboration allows joint R&D; commercial_negotiation supports business discussions; product_development permits integration into customer products; regulatory_submission allows use in regulatory filings.. Valid values are `evaluation_only|research_collaboration|commercial_negotiation|product_development|regulatory_submission|unrestricted`',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes provisions for renewal or extension beyond the initial term. True = renewal option exists, False = no renewal provision.',
    `residual_knowledge_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a residual knowledge clause allowing the receiving party to retain and use general knowledge, skills, or experience gained during the relationship. True = clause present, False = no residual rights.',
    `return_destruction_obligation_flag` BOOLEAN COMMENT 'Indicates whether the receiving party is obligated to return or destroy confidential materials and information upon agreement expiry or termination. True = return/destruction required, False = no such obligation.',
    `signatory_name` STRING COMMENT 'Full name of the individual who signed the agreement on behalf of the customer. Captured for audit trail and legal enforceability even if contact record is updated or deactivated.',
    `signatory_title` STRING COMMENT 'Job title or role of the customer signatory at the time of execution. Validates signatory authority and supports legal enforceability verification.',
    `subject_matter` STRING COMMENT 'Description of the proprietary information, technology, or materials covered by the NDA or MTA. Examples include sequencing chemistry formulations, CRISPR intellectual property, custom array designs, pre-commercial product specifications, or reagent compositions. Defines the scope of IP protection.',
    `survival_period_years` DECIMAL(18,2) COMMENT 'Number of years that confidentiality obligations survive after agreement expiry or termination. Common values are 2, 3, 5, or perpetual (represented as 99.99). Critical for determining ongoing IP protection obligations.',
    `technology_area` STRING COMMENT 'Primary genomics technology domain covered by the agreement. Enables segmentation of IP protection by product line and facilitates compliance tracking for technology-specific disclosures. [ENUM-REF-CANDIDATE: NGS|Array|CRISPR|PCR|qPCR|Library Prep|Reagent|Instrument|Bioinformatics|Clinical Assay|Other — 11 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'Date on which the agreement was terminated prior to its natural expiry. Populated only when agreement is ended early by mutual consent or breach. Null for agreements that expire naturally or remain active.',
    CONSTRAINT pk_nda_record PRIMARY KEY(`nda_record_id`)
) COMMENT 'Tracks Non-Disclosure Agreements and Material Transfer Agreements (MTAs) executed with customer accounts — covering proprietary sequencing chemistry, CRISPR IP, custom array designs, and pre-commercial product evaluations. Captures agreement type (NDA, MTA, CDA), execution date, expiry date, covered subject matter, signatory contact, countersignatory, agreement status (active, expired, terminated), and Veeva Vault document reference. Ensures IP protection compliance and governs what proprietary information can be shared with each account.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` (
    `evaluation_program_id` BIGINT COMMENT 'Unique identifier for the evaluation program record. Primary key.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account participating in this evaluation program. Links to the strategic account receiving beta placement, early access, or clinical evaluation opportunity.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Evaluation programs test specific reagent products in customer workflows. Essential for tracking product performance, conversion outcomes, and customer feedback. Supports new product introduction (NPI',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Evaluation programs test specific products before purchase. Essential for pre-sales evaluation tracking, conversion pipeline management, NPI feedback collection, and measuring product-market fit for n',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Field application scientist name exists as denormalized string. Linking to employee enables time tracking, performance metrics, territory management, and accountability for evaluation program outcomes',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Product evaluation programs test new assays/instruments against specific reference genome builds. Product validation and NPI requirement. Evaluation results are genome-build-specific; build changes re',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Evaluation programs provide controlled access to pre-release genomic methods, reference datasets, and proprietary algorithms. Access control policies define data use limitations, publication moratoria',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Evaluation programs convert to commercial orders upon successful completion. Tracking which order resulted from the evaluation enables revenue attribution, program ROI analysis, sales cycle metrics, a',
    `installed_instrument_id` BIGINT COMMENT 'Foreign key linking to customer.installed_instrument. Business justification: evaluation_program has instrument_serial_number (STRING) which should be normalized to installed_instrument_id FK. Evaluation programs often involve testing specific instruments at customer sites. Thi',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Evaluation programs incur costs (reagents, consumables, instrument depreciation, field application scientist time) tracked via internal orders for program profitability analysis, cost recovery decisio',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Evaluation programs test specific materials/reagents (new library prep kits, flow cell versions, chemistry upgrades). Linking material_id tracks which materials are under customer evaluation, enables ',
    `nda_record_id` BIGINT COMMENT 'Foreign key linking to customer.nda_record. Business justification: evaluation_program has agreement_reference_number (STRING) and confidentiality_agreement_signed (BOOLEAN) flag, indicating that evaluation programs are often governed by confidentiality agreements (ND',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Evaluations use specific reagent lots. Lot-level traceability is critical when evaluation results drive product improvements, quality investigations, or manufacturing process changes. Supports linking',
    `opportunity_id` BIGINT COMMENT 'Salesforce CRM opportunity identifier linking this evaluation program to the associated sales opportunity record for pipeline tracking and forecasting.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Evaluation programs generate clinical evidence (sensitivity, specificity data) that feeds directly into 510k, CE marking, or PMA submissions. Essential traceability for regulatory dossier compilation ',
    `account_manager_name` STRING COMMENT 'Name of the sales account manager responsible for the customer relationship and commercial aspects of the evaluation program.',
    `actual_end_date` DATE COMMENT 'Actual date when the evaluation program concluded, which may differ from the planned end date due to extensions or early termination.',
    `actual_sample_count` STRING COMMENT 'Actual number of samples, runs, or assays completed by the customer during the evaluation program.',
    `business_unit` STRING COMMENT 'Internal business unit or division sponsoring the evaluation program: sequencing (NGS platforms), array (microarray solutions), gene_editing (CRISPR tools), clinical_genomics (IVD products), agricultural_genomics (ag-bio applications), research_solutions (RUO products).. Valid values are `sequencing|array|gene_editing|clinical_genomics|agricultural_genomics|research_solutions`',
    `confidentiality_agreement_signed` BOOLEAN COMMENT 'Indicates whether the customer has signed a Non-Disclosure Agreement (NDA) or Confidentiality Agreement covering the evaluation program and pre-commercial product information.',
    `conversion_date` DATE COMMENT 'Date when the evaluation program resulted in a commercial purchase order or formal decision to convert.',
    `conversion_outcome` STRING COMMENT 'Final commercial outcome of the evaluation program: converted_to_purchase (customer placed commercial order), no_conversion (customer declined to purchase), pending_decision (evaluation complete, decision pending), extended_evaluation (program extended for additional testing), competitive_loss (customer selected competitor product).. Valid values are `converted_to_purchase|no_conversion|pending_decision|extended_evaluation|competitive_loss`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this evaluation program record was first created in the system.',
    `critical_issues_count` STRING COMMENT 'Number of critical or high-severity technical issues that significantly impacted the evaluation or required escalation.',
    `customer_application_area` STRING COMMENT 'Primary research or clinical application area for which the customer is evaluating the product (e.g., Oncology Research, Rare Disease Diagnostics, Population Genomics, Agricultural Breeding).',
    `customer_feedback_summary` STRING COMMENT 'Consolidated summary of customer feedback collected during the evaluation program, including performance observations, usability comments, technical issues, and feature requests.',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the customer has consented to share evaluation data, performance metrics, and results with the company for product development and marketing purposes.',
    `duration_days` STRING COMMENT 'Total number of calendar days allocated for the evaluation program from start to planned end date.',
    `geographic_region` STRING COMMENT 'Geographic sales region where the evaluation program is being conducted: north_america (US, Canada), emea (Europe, Middle East, Africa), asia_pacific (APAC excluding China/Japan), latin_america (LATAM), china (Greater China), japan (Japan).. Valid values are `north_america|emea|asia_pacific|latin_america|china|japan`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this evaluation program record was most recently updated.',
    `npi_phase` STRING COMMENT 'Stage of the New Product Introduction lifecycle at which this evaluation is occurring: alpha (internal testing), beta (external pre-release), limited_release (controlled commercial launch), general_availability (full commercial release), post_launch (post-market evaluation).. Valid values are `alpha|beta|limited_release|general_availability|post_launch`',
    `performance_rating` STRING COMMENT 'Overall customer assessment of product performance during the evaluation: excellent (exceeded expectations), good (met expectations), satisfactory (acceptable with minor issues), needs_improvement (significant gaps identified), poor (failed to meet requirements), not_rated (evaluation incomplete or rating not provided).. Valid values are `excellent|good|satisfactory|needs_improvement|poor|not_rated`',
    `planned_end_date` DATE COMMENT 'Originally scheduled date for the evaluation program to conclude, as agreed upon at program initiation.',
    `program_code` STRING COMMENT 'Unique alphanumeric code assigned to the evaluation program for tracking and reporting purposes (e.g., BETA-NSX-2024-001).. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_name` STRING COMMENT 'Business name or title assigned to this evaluation program (e.g., NovaSeq X Beta Program Q1 2024, CRISPR Cas9 Early Access - Oncology Panel).',
    `program_notes` STRING COMMENT 'Free-text field for capturing additional context, special conditions, lessons learned, or important observations about the evaluation program.',
    `program_owner_email` STRING COMMENT 'Email address of the internal program owner for communication and coordination purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `program_owner_name` STRING COMMENT 'Name of the internal employee responsible for managing and coordinating this evaluation program (typically from Product Management, R&D, or Commercial team).',
    `program_status` STRING COMMENT 'Current lifecycle status of the evaluation program: draft (planning phase), approved (authorized to proceed), active (currently running), on_hold (temporarily suspended), completed (finished per plan), cancelled (terminated early), converted (successfully transitioned to commercial purchase). [ENUM-REF-CANDIDATE: draft|approved|active|on_hold|completed|cancelled|converted — 7 candidates stripped; promote to reference product]',
    `program_type` STRING COMMENT 'Classification of the evaluation program indicating the nature of the engagement: beta (pre-release product testing), early_access (limited commercial release), clinical_evaluation (clinical assay validation), demo_placement (demonstration unit placement), validation_pilot (performance validation study), field_trial (real-world application testing).. Valid values are `beta|early_access|clinical_evaluation|demo_placement|validation_pilot|field_trial`',
    `publication_rights` STRING COMMENT 'Agreement on publication and presentation rights for evaluation results: company_only (company may publish), joint_publication (co-authored publication), customer_only (customer may publish independently), no_publication (results confidential), pending_approval (rights under negotiation).. Valid values are `company_only|joint_publication|customer_only|no_publication|pending_approval`',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the product under evaluation: RUO (Research Use Only), IVD (In Vitro Diagnostic - FDA cleared/approved), LDT (Laboratory Developed Test), CE_IVD (CE marked for European IVD use), investigational (under clinical investigation), pre_commercial (not yet released).. Valid values are `RUO|IVD|LDT|CE_IVD|investigational|pre_commercial`',
    `start_date` DATE COMMENT 'Date when the evaluation program officially begins, typically when the product is delivered or access is granted to the customer.',
    `success_criteria` STRING COMMENT 'Defined objectives and measurable criteria that determine successful completion of the evaluation program (e.g., Achieve 95% concordance with reference method, Complete 100 WGS runs with <1% error rate, Validate LOD at 5% VAF).',
    `target_sample_count` STRING COMMENT 'Planned number of samples, runs, or assays to be processed during the evaluation program to meet validation objectives.',
    `technical_issues_reported` STRING COMMENT 'Number of technical issues, defects, or support cases logged by the customer during the evaluation program.',
    `training_date` DATE COMMENT 'Date when product training was delivered to the customer for the evaluation program.',
    `training_provided_flag` BOOLEAN COMMENT 'Indicates whether formal product training was provided to the customer as part of the evaluation program setup.',
    CONSTRAINT pk_evaluation_program PRIMARY KEY(`evaluation_program_id`)
) COMMENT 'Manages formal product evaluation and beta-testing programs offered to strategic customer accounts — instrument beta placements, reagent kit early-access evaluations, pre-commercial CRISPR tool assessments, and clinical assay validation pilots. Captures program name, program type (beta, early access, clinical evaluation, demo placement), start date, end date, evaluation status, products under evaluation, success criteria, customer feedback summary, and commercial conversion outcome. Bridges R&D and commercial teams for new product introduction (NPI) feedback loops.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique identifier for the customer credit profile record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account to which this credit profile applies. Links to the master customer record in Salesforce CRM.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Credit approval authority exists as denormalized string. Linking to employee enables SOX compliance audit trails, approval authority verification, segregation of duties controls, and tracking of credi',
    `superseded_credit_profile_id` BIGINT COMMENT 'Self-referencing FK on credit_profile (superseded_credit_profile_id)',
    `approved_currencies` STRING COMMENT 'Comma-separated list of ISO 4217 three-letter currency codes in which the customer is authorized to transact (e.g., USD, EUR, GBP, JPY).',
    `available_credit_amount` DECIMAL(18,2) COMMENT 'Remaining credit capacity calculated as credit limit minus outstanding AR balance and open order commitments.',
    `bank_guarantee_amount` DECIMAL(18,2) COMMENT 'Total amount covered by the bank guarantee or letter of credit, typically matching or exceeding the approved credit limit.',
    `bank_guarantee_expiry_date` DATE COMMENT 'Expiration date of the bank guarantee or letter of credit, after which the guarantee is no longer valid.',
    `bank_guarantee_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the customer has provided a bank guarantee or letter of credit to secure credit terms.',
    `bank_guarantee_reference_number` STRING COMMENT 'Reference number or identifier for the bank guarantee or letter of credit provided by the customer to secure credit terms.',
    `collection_status` STRING COMMENT 'Current collection status of outstanding receivables, indicating whether invoices are current, past due, in collections, or subject to legal action. [ENUM-REF-CANDIDATE: current|past_due_1_30|past_due_31_60|past_due_61_90|past_due_over_90|in_collections|legal_action — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_approval_date` DATE COMMENT 'Date when the current credit limit and terms were approved by the designated credit approval authority.',
    `credit_hold_date` DATE COMMENT 'Date when the credit hold was placed on the customer account.',
    `credit_hold_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the customer account is currently on credit hold, blocking new order releases until credit issues are resolved.',
    `credit_hold_reason` STRING COMMENT 'Detailed explanation for why the customer account is on credit hold, such as exceeded credit limit, overdue invoices, or failed credit review.',
    `credit_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum amount covered by the trade credit insurance policy for this customer account.',
    `credit_insurance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the customer account is covered by trade credit insurance to mitigate default risk.',
    `credit_insurance_policy_number` STRING COMMENT 'Policy number for the trade credit insurance covering this customer account, if applicable.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum approved credit exposure for this customer across all open orders and outstanding receivables. Critical for high-value sequencing platform purchases ranging from $500K to $5M.',
    `credit_limit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit limit amount.. Valid values are `^[A-Z]{3}$`',
    `credit_notes` STRING COMMENT 'Free-text field for internal notes and comments related to the customer credit profile, credit decisions, and payment behavior.',
    `credit_profile_number` STRING COMMENT 'Business-facing unique identifier for the credit profile, typically sourced from SAP SD credit management module.',
    `credit_rating` STRING COMMENT 'Alphanumeric credit rating classification (e.g., AAA, AA, A, BBB, BB, B, CCC, D) derived from internal credit assessment or external credit bureau such as Dun & Bradstreet. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `credit_rating_source` STRING COMMENT 'Source of the credit rating or credit score, indicating whether it is an internal assessment or provided by an external credit bureau or rating agency. [ENUM-REF-CANDIDATE: internal|dun_bradstreet|experian|equifax|moody|sp|fitch|other — 8 candidates stripped; promote to reference product]',
    `credit_review_date` DATE COMMENT 'Date of the most recent credit review or assessment conducted for this customer.',
    `credit_review_frequency_months` STRING COMMENT 'Frequency in months at which the customer credit profile is reviewed and reassessed (e.g., 6, 12, 24 months).',
    `credit_score` STRING COMMENT 'Numerical credit score assigned to the customer based on internal credit assessment or external credit bureau data (e.g., Dun & Bradstreet). Higher scores indicate lower credit risk.',
    `credit_status` STRING COMMENT 'Current lifecycle status of the customer credit profile governing order release and commercial transaction approvals.. Valid values are `approved|pending|on_hold|suspended|rejected|under_review`',
    `days_sales_outstanding` DECIMAL(18,2) COMMENT 'Average number of days it takes the customer to pay invoices, calculated as (Accounts Receivable / Total Credit Sales) * Number of Days. Key metric for assessing payment behavior and credit risk.',
    `dunning_level` STRING COMMENT 'Current dunning level or escalation stage for overdue invoice collection activities (e.g., 0=none, 1=reminder, 2=warning, 3=final notice, 4=legal action).',
    `effective_end_date` DATE COMMENT 'Date when this credit profile record ceased to be effective, typically when superseded by a new credit profile version or when the customer account was closed.',
    `effective_start_date` DATE COMMENT 'Date when this credit profile record became effective and active for the customer account.',
    `last_credit_assessment_outcome` STRING COMMENT 'Outcome of the most recent credit assessment, indicating whether credit was approved, declined, increased, decreased, or remained unchanged.. Valid values are `approved|approved_with_conditions|declined|limit_increased|limit_decreased|no_change`',
    `last_dunning_date` DATE COMMENT 'Date when the most recent dunning notice or collection communication was sent to the customer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was most recently updated or modified, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_credit_review_date` DATE COMMENT 'Scheduled date for the next periodic credit review or reassessment of the customer credit profile.',
    `outstanding_ar_balance` DECIMAL(18,2) COMMENT 'Total unpaid invoices and receivables currently outstanding for this customer, sourced from SAP FI accounts receivable module.',
    `payment_terms_code` STRING COMMENT 'Approved payment terms governing invoice due dates for instrument capital sales, reagent supply agreements, and service contracts. Common terms include net-30, net-60, and net-90 days. [ENUM-REF-CANDIDATE: net_30|net_60|net_90|net_120|prepayment|cod|custom — 7 candidates stripped; promote to reference product]',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date until payment is due, corresponding to the payment terms code.',
    `risk_category` STRING COMMENT 'Internal risk classification assigned to the customer based on credit score, payment history, financial stability, and other risk factors.. Valid values are `low|medium|high|critical`',
    `salesforce_credit_profile_code` STRING COMMENT 'External identifier for this credit profile record in Salesforce CRM, used for cross-system reconciliation and data lineage tracking.',
    `sap_credit_account_number` STRING COMMENT 'Credit account number or credit control area identifier in SAP SD credit management module, used for cross-system reconciliation.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Customer-level credit and financial profile governing commercial terms for instrument capital sales, reagent supply agreements, and service contracts. Captures credit limit, approved payment terms (net-30, net-60, net-90), credit score/rating (D&B, internal), credit hold status, credit review date, last credit assessment outcome, outstanding AR balance, days sales outstanding (DSO), collection status, approved currencies, bank guarantee or letter of credit references, and credit approval authority. Critical for order release decisions on high-value sequencing platform purchases ($500K-$5M) and for managing payment risk across multi-year reagent supply commitments. Sourced from SAP SD credit management and Salesforce CRM financial fields.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` (
    `research_collaboration_id` BIGINT COMMENT 'Unique identifier for the research collaboration record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account participating in this research collaboration. Links to the customer master data managed in Salesforce CRM.',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to data.dpia. Business justification: Collaborative genomic research involving PHI or cross-border data transfer requires DPIA under GDPR. DPIA assesses risks, necessity, proportionality before data sharing. Mandatory for lawful internati',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Research collaborations define data access rights, permitted uses, publication terms, and data sharing boundaries for genomic datasets. Access control policies operationalize collaboration agreements.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Funded research collaborations require internal order tracking for cost allocation, budget management, grant accounting, and indirect cost recovery. Standard practice for R&D finance in genomics biote',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee record for the scientific lead managing this collaboration from the Genomics Biotech side.',
    `nda_record_id` BIGINT COMMENT 'Foreign key linking to customer.nda_record. Business justification: research_collaboration has nda_reference_number (STRING) which should be normalized to nda_record_id FK. Research collaborations are typically governed by NDAs that define confidentiality terms, IP ow',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Research collaborations frequently convert to commercial opportunities when funded projects transition to production-scale purchasing. Sales teams track conversion pipeline from collaboration to comme',
    `contact_id` BIGINT COMMENT 'Reference to the customer contact serving as the principal investigator or lead scientist on the customer side for this collaboration.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: research_collaboration has contract_reference_number (STRING) which should be normalized to service_agreement_id FK. Research collaborations are formalized through service agreements that define deliv',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Research collaborations produce publications and clinical data that become part of regulatory submission packages. Critical for evidence traceability in genomics product regulatory filings (510k, CE m',
    `predecessor_research_collaboration_id` BIGINT COMMENT 'Self-referencing FK on research_collaboration (predecessor_research_collaboration_id)',
    `actual_end_date` DATE COMMENT 'Actual date when the collaboration concluded, whether by completion, termination, or expiration. Null if collaboration is still active.',
    `actual_sample_count` STRING COMMENT 'Actual number of samples, sequencing runs, or assays completed to date. Used to track progress against target_sample_count.',
    `business_unit` STRING COMMENT 'Genomics Biotech business unit or division sponsoring or managing the collaboration (e.g., Research Solutions, Clinical Genomics, Agricultural Genomics, Oncology).',
    `collaboration_name` STRING COMMENT 'Descriptive name of the research collaboration, typically reflecting the scientific focus or project title.',
    `collaboration_number` STRING COMMENT 'Externally-known unique business identifier for the research collaboration, used in contracts, publications, and communications.',
    `collaboration_owner_name` STRING COMMENT 'Name of the Genomics Biotech business owner or account manager responsible for overall relationship management and commercial aspects of the collaboration.',
    `collaboration_status` STRING COMMENT 'Current lifecycle state of the collaboration: proposed (under negotiation), active (ongoing work), completed (successfully concluded), terminated (ended early), on hold (temporarily paused), or suspended (inactive pending resolution).. Valid values are `proposed|active|completed|terminated|on hold|suspended`',
    `collaboration_type` STRING COMMENT 'Classification of the collaboration structure: co-development (joint product development), publication partnership (joint research publication), grant-funded (NIH/EU/foundation-funded project), consortium (multi-party academic/industry alliance), technology access (early access to pre-release platforms), or early access (beta testing program).. Valid values are `co-development|publication partnership|grant-funded|consortium|technology access|early access`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collaboration record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the funded amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_sharing_terms` STRING COMMENT 'Terms governing the sharing, use, and publication of genomic data generated during the collaboration, including compliance with NIH Genomic Data Sharing Policy, GDPR, and institutional data use agreements.',
    `deliverables_description` STRING COMMENT 'Detailed description of the expected outputs, milestones, and deliverables from the collaboration (e.g., joint publications, validated assays, sequencing datasets, software tools, clinical trial data).',
    `funded_amount` DECIMAL(18,2) COMMENT 'Total monetary value of funding committed to this collaboration, including grants, co-funding, or in-kind contributions. Expressed in the currency specified in currency_code.',
    `funding_source` STRING COMMENT 'Name of the organization or program providing funding for the collaboration (e.g., NIH, European Commission Horizon 2020, Bill & Melinda Gates Foundation, internal R&D budget).',
    `geographic_region` STRING COMMENT 'Primary geographic region of the customer organization participating in the collaboration (e.g., North America, EMEA, APAC, Latin America).',
    `grant_number` STRING COMMENT 'Official grant or award number assigned by the funding agency, if applicable. Used for tracking and compliance reporting.',
    `ip_ownership_terms` STRING COMMENT 'Summary of intellectual property ownership, licensing, and commercialization rights resulting from the collaboration, including background IP, foreground IP, and joint inventions.',
    `irb_protocol_number` STRING COMMENT 'IRB or ethics committee protocol number if the collaboration involves human subjects research, clinical specimens, or protected health information.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collaboration record was most recently updated. Used for audit trail and change tracking.',
    `mta_reference_number` STRING COMMENT 'Reference number of the associated material transfer agreement governing the exchange of biological materials, reagents, or samples, if applicable.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, operational notes, or historical information about the collaboration not captured in structured fields.',
    `phi_handling_required_flag` BOOLEAN COMMENT 'Indicates whether the collaboration involves handling of protected health information (PHI) requiring HIPAA Business Associate Agreement and data security controls. True if PHI is involved.',
    `planned_end_date` DATE COMMENT 'Originally scheduled or contracted end date for the collaboration. May differ from actual end date if extended or terminated early.',
    `publication_rights` STRING COMMENT 'Terms governing publication of research results, including co-authorship requirements, review periods, embargo periods, and acknowledgment obligations.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the collaboration is subject to regulatory compliance requirements such as GxP, CLIA, HIPAA, or GDPR. True if compliance oversight is required.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the collaboration agreement includes an option for renewal or extension beyond the initial term. True if renewal option exists.',
    `research_focus_area` STRING COMMENT 'Primary scientific or application domain of the collaboration (e.g., cancer genomics, agricultural genomics, rare disease research, population health, CRISPR gene editing).',
    `salesforce_collaboration_code` STRING COMMENT 'Unique identifier for this collaboration record in the Salesforce CRM system, used for cross-system reconciliation and data lineage.',
    `start_date` DATE COMMENT 'Date when the research collaboration officially commenced, as defined in the collaboration agreement or contract.',
    `strategic_priority_tier` STRING COMMENT 'Internal classification of the collaborations strategic importance: tier 1 (highest strategic value, executive sponsorship), tier 2 (significant strategic value), tier 3 (moderate strategic value), or standard (routine collaboration).. Valid values are `tier 1|tier 2|tier 3|standard`',
    `target_sample_count` STRING COMMENT 'Planned or contracted number of biological samples, sequencing runs, or assays to be processed as part of the collaboration deliverables.',
    `technology_platform` STRING COMMENT 'Genomics Biotech technology platform or product family central to the collaboration (e.g., NovaSeq, MiSeq, Infinium Array, TruSight Oncology, BaseSpace).',
    `termination_reason` STRING COMMENT 'Explanation for early termination or suspension of the collaboration, if applicable (e.g., funding withdrawn, objectives achieved early, partner withdrew, compliance issue, strategic realignment).',
    CONSTRAINT pk_research_collaboration PRIMARY KEY(`research_collaboration_id`)
) COMMENT 'Tracks structured multi-year scientific collaborations, co-development agreements, and strategic research partnerships between Genomics Biotech and customer accounts — including joint publication agreements, co-funded sequencing projects, early-access technology partnerships, academic consortium memberships, and NIH/EU-funded collaborative grants. Captures collaboration type (co-development, publication partnership, grant-funded, consortium, technology access), start date, end date, principal investigator (customer contact), internal scientific lead, collaboration status (proposed, active, completed, terminated), funded amount, funding source, deliverables, publication rights, IP ownership terms, and associated NDA/MTA references. Distinct from service_agreement (which covers commercial contracts) and interaction (which covers individual touchpoints). Enables strategic account management and R&D pipeline alignment.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` (
    `contracted_material_id` BIGINT COMMENT 'Unique identifier for this contracted material pricing record. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key linking to the material covered under this service agreement',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to the service agreement that contains this contracted material pricing',
    `committed_annual_volume` DECIMAL(18,2) COMMENT 'Total volume of this material the customer commits to purchase annually under this service agreement. Used for volume-based pricing tiers.',
    `contracted_unit_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for this material under this specific service agreement. Price per base unit of measure.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this contracted material pricing record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted unit price (e.g., USD, EUR, GBP).',
    `discount_tier` STRING COMMENT 'Discount tier applied to this material under this agreement: standard (list price), volume (volume discount), enterprise (enterprise pricing), strategic (strategic account pricing), custom (custom negotiated tier).',
    `effective_date` DATE COMMENT 'Date when this contracted material pricing becomes effective. May differ from service agreement start date if materials are added mid-term.',
    `expiry_date` DATE COMMENT 'Date when this contracted material pricing expires. May differ from service agreement end date if materials are removed or repriced mid-term.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this contracted material pricing record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this contracted material pricing record was last modified.',
    `line_status` STRING COMMENT 'Current status of this contracted material line: active (currently valid), suspended (temporarily inactive), expired (past expiry date), superseded (replaced by newer pricing).',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per transaction for this material under this agreement. Nullable if no cap exists.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per transaction for this material under this agreement.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this contracted material pricing record.',
    CONSTRAINT pk_contracted_material PRIMARY KEY(`contracted_material_id`)
) COMMENT 'This association product represents the Contract between service_agreement and material. It captures the specific pricing, volume commitments, and commercial terms negotiated for each material included in a customer service agreement. Each record links one service_agreement to one material with contracted pricing, volume commitments, discount tiers, and validity periods that exist only in the context of this contractual relationship.. Existence Justification: In genomics biotech operations, service agreements (reagent rental programs, consumables supply contracts, instrument service contracts with bundled reagents) routinely cover multiple materials with individually negotiated pricing, volume commitments, and discount tiers. Each material (reagents, flow cells, array substrates, consumables) can be included in multiple customer service agreements with different contracted terms. The business actively manages contracted material pricing as line items within service agreements, tracking pricing validity periods, volume commitments, and discount tiers per agreement-material combination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ADD CONSTRAINT `fk_customer_customer_consent_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ADD CONSTRAINT `fk_customer_customer_consent_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ADD CONSTRAINT `fk_customer_customer_consent_record_parent_consent_record_customer_consent_record_id` FOREIGN KEY (`parent_consent_record_customer_consent_record_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`customer_consent_record`(`customer_consent_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ADD CONSTRAINT `fk_customer_training_enrollment_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ADD CONSTRAINT `fk_customer_training_enrollment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ADD CONSTRAINT `fk_customer_nda_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ADD CONSTRAINT `fk_customer_nda_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_nda_record_id` FOREIGN KEY (`nda_record_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`nda_record`(`nda_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_superseded_credit_profile_id` FOREIGN KEY (`superseded_credit_profile_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_nda_record_id` FOREIGN KEY (`nda_record_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`nda_record`(`nda_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_predecessor_research_collaboration_id` FOREIGN KEY (`predecessor_research_collaboration_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`research_collaboration`(`research_collaboration_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ADD CONSTRAINT `fk_customer_contracted_material_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `genomics_biotech_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'customer_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'customer_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'principal_investigator|lab_director|procurement_officer|field_application_scientist|clinical_specialist|purchasing_contact');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Classification');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `product_interest` SET TAGS ('dbx_business_glossary_term' = 'Product Interest Category');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `research_focus` SET TAGS ('dbx_business_glossary_term' = 'Research Focus Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Dr|Prof|Mr|Ms|Mrs|Mx');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Secondary Email Address');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Contact Name Suffix');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ALTER COLUMN `technical_expertise_area` SET TAGS ('dbx_business_glossary_term' = 'Technical Expertise Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'customer_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `billing_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Rollup Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'research|clinical|agricultural|pharmaceutical|diagnostic|industrial');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `consolidation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `pricing_tier_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Inheritance Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `primary_hierarchy_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Hierarchy Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `salesforce_account_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Hierarchy Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'customer_management');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'customer_management');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` SET TAGS ('dbx_subdomain' = 'customer_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `customer_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Consent Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `parent_consent_record_customer_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consent Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Collection Channel');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|wet_signature|verbal|checkbox|click_through|implied');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending|revoked|superseded');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_text_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Reference');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'gdpr_data_processing|hipaa_baa_acknowledgment|phi_handling_authorization|marketing_opt_in|marketing_opt_out|genomic_data_sharing');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consenting_party_role` SET TAGS ('dbx_business_glossary_term' = 'Consenting Party Role');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `consenting_party_role` SET TAGS ('dbx_value_regex' = 'primary_contact|authorized_representative|legal_guardian|principal_investigator|irb_coordinator|data_protection_officer');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `data_subject_email` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Email Address');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `data_subject_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `data_subject_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `data_subject_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `data_subject_name` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `data_subject_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `data_subject_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `geolocation` SET TAGS ('dbx_business_glossary_term' = 'Geolocation');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `geolocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'gdpr|hipaa|ccpa|lgpd|pipeda|nih_gds_policy');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `research_participation_consent` SET TAGS ('dbx_business_glossary_term' = 'Research Participation Consent Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `third_party_list` SET TAGS ('dbx_business_glossary_term' = 'Third Party List');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `third_party_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Third Party Sharing Allowed Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `technical_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirement ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Captured By User ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ALTER COLUMN `instrument_platform_preference` SET TAGS ('dbx_business_glossary_term' = 'Instrument Platform Preference');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Opportunity Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Covered Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Covered Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Required Personnel Position Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Opportunity ID');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `product_interest` SET TAGS ('dbx_business_glossary_term' = 'Product Interest');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'ruo|ivd|ldt|clinical');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `salesforce_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Activity ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Sentiment Score');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|very_positive|very_negative');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ALTER COLUMN `technical_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Director Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Site Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Udi Assignment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `model_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Asset Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `asset_id` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Site Address Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Validated Reagent Catalog Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'Basic|Standard|Premium|Enterprise');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `servicenow_configuration_item_code` SET TAGS ('dbx_business_glossary_term' = 'ServiceNow Configuration Item Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `servicenow_configuration_item_code` SET TAGS ('dbx_value_regex' = '^CI[0-9]{10,15}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ALTER COLUMN `software_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Support Case ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `adverse_event_report_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Report Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Required Qualification Position Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `support_case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ALTER COLUMN `tat_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Hours');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Training Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `application_focus` SET TAGS ('dbx_business_glossary_term' = 'Application Focus');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `attendance_hours` SET TAGS ('dbx_business_glossary_term' = 'Attendance Hours');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `certification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `certification_number` SET TAGS ('dbx_value_regex' = '^CERT-[A-Z0-9]{8,16}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `clia_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Format');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'in_person|virtual_live|on_demand|hybrid|self_paced');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `enrollment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee Amount');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `enrollment_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `enrollment_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee Currency');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `enrollment_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Training Feedback Comments');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `hands_on_lab_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Hands-On Laboratory Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|waived|refunded|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Training Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `salesforce_enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Customer Relationship Management (CRM) Enrollment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `salesforce_enrollment_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Training End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Training Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_materials_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Provided Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_program_code` SET TAGS ('dbx_business_glossary_term' = 'Training Program Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_program_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ALTER COLUMN `training_region` SET TAGS ('dbx_business_glossary_term' = 'Training Region');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `nda_record_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_signature|active|expired|terminated|superseded');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'NDA|MTA|CDA|MNDA|Bilateral NDA|Unilateral NDA');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `breach_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `business_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `countersignatory_name` SET TAGS ('dbx_business_glossary_term' = 'Countersignatory Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `countersignatory_title` SET TAGS ('dbx_business_glossary_term' = 'Countersignatory Title');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `exclusions_from_confidentiality` SET TAGS ('dbx_business_glossary_term' = 'Exclusions from Confidentiality');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `export_control_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `ip_classification` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `ip_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `material_transfer_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Transfer Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `mutual_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutual Agreement Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `permitted_use_scope` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use Scope');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `permitted_use_scope` SET TAGS ('dbx_value_regex' = 'evaluation_only|research_collaboration|commercial_negotiation|product_development|regulatory_submission|unrestricted');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `residual_knowledge_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Knowledge Clause Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `return_destruction_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Return or Destruction Obligation Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `subject_matter` SET TAGS ('dbx_business_glossary_term' = 'Subject Matter');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `subject_matter` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `survival_period_years` SET TAGS ('dbx_business_glossary_term' = 'Survival Period Years');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` SET TAGS ('dbx_subdomain' = 'research_collaboration');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `evaluation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Program ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Field Application Scientist Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `nda_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Record Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `account_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Program End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `actual_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Sample Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = 'sequencing|array|gene_editing|clinical_genomics|agricultural_genomics|research_solutions');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `confidentiality_agreement_signed` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Signed Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_business_glossary_term' = 'Commercial Conversion Outcome');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_value_regex' = 'converted_to_purchase|no_conversion|pending_decision|extended_evaluation|competitive_loss');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `critical_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Issues Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `customer_application_area` SET TAGS ('dbx_business_glossary_term' = 'Customer Application Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `customer_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Summary');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Program Duration in Days');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|emea|asia_pacific|latin_america|china|japan');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `npi_phase` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Phase');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `npi_phase` SET TAGS ('dbx_value_regex' = 'alpha|beta|limited_release|general_availability|post_launch');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor|not_rated');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Program End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Program Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Program Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Email Address');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Program Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Program Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'beta|early_access|clinical_evaluation|demo_placement|validation_pilot|field_trial');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `publication_rights` SET TAGS ('dbx_business_glossary_term' = 'Publication Rights');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `publication_rights` SET TAGS ('dbx_value_regex' = 'company_only|joint_publication|customer_only|no_publication|pending_approval');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|CE_IVD|investigational|pre_commercial');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Success Criteria');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `target_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Target Sample Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `technical_issues_reported` SET TAGS ('dbx_business_glossary_term' = 'Technical Issues Reported Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Training Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ALTER COLUMN `training_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Provided Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'customer_management');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Authority Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `superseded_credit_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `approved_currencies` SET TAGS ('dbx_business_glossary_term' = 'Approved Currencies');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Amount');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `bank_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Amount');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `bank_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `bank_guarantee_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `bank_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `bank_guarantee_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `bank_guarantee_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Coverage Amount');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Policy Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_rating_source` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Source');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Frequency Months');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|pending|on_hold|suspended|rejected|under_review');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `last_credit_assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Assessment Outcome');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `last_credit_assessment_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|declined|limit_increased|limit_decreased|no_change');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `next_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `outstanding_ar_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Accounts Receivable (AR) Balance');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `outstanding_ar_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `salesforce_credit_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Credit Profile Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `sap_credit_account_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Credit Account Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `sap_credit_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ALTER COLUMN `sap_credit_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` SET TAGS ('dbx_subdomain' = 'research_collaboration');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `research_collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'Research Collaboration Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Scientific Lead Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `nda_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Record Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `predecessor_research_collaboration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `actual_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Sample Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `collaboration_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `collaboration_number` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `collaboration_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_value_regex' = 'proposed|active|completed|terminated|on hold|suspended');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'co-development|publication partnership|grant-funded|consortium|technology access|early access');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `data_sharing_terms` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Terms');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `deliverables_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Description');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Funded Amount');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Terms');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `mta_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Material Transfer Agreement (MTA) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `phi_handling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Handling Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `publication_rights` SET TAGS ('dbx_business_glossary_term' = 'Publication Rights');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `research_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Research Focus Area');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `salesforce_collaboration_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Collaboration Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Start Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_value_regex' = 'tier 1|tier 2|tier 3|standard');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `target_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Target Sample Count');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` SET TAGS ('dbx_association_edges' = 'customer.service_agreement,supply.material');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `contracted_material_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Material ID');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Material - Material Id');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Material - Service Agreement Id');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `committed_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Annual Volume');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `contracted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `contracted_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Discount Tier');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `discount_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
