-- Schema for Domain: customer | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`customer` COMMENT 'Single source of truth for all water and wastewater service accounts including residential, commercial, industrial, and municipal customers. Manages customer profiles, service addresses, account hierarchies, customer segments, contact information, service agreements, and customer lifecycle from application through termination. SSOT for customer identity across all billing, metering, and service delivery systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer_account data product (auto-inserted pre-linking).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Utilities assign customer accounts to cost centers for management accounting, enabling revenue and cost tracking by geographic district, service territory, or operational division. Standard practice f',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Water utilities assign each customer account to a specific fund (water, wastewater, stormwater) for GASB fund accounting and regulatory reporting. Essential for financial statement preparation and rat',
    `organization_id` BIGINT COMMENT 'Foreign key linking to customer.organization. Business justification: Commercial and industrial customer accounts should reference the organization master record. This allows proper tracking of corporate account structures. The account table currently only has person_id',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Multi-facility utilities must track which WTP serves each account for facility-specific CCR distribution, water quality inquiry routing, source water reporting on bills, and facility maintenance notif',
    CONSTRAINT pk_customer_account PRIMARY KEY(`customer_account_id`)
) COMMENT 'Master record for every water and wastewater service account — residential, commercial, industrial, and municipal. Serves as the SSOT for customer identity across Oracle CC&B, SAP, AMI, and all downstream systems. Captures account number, account type (residential/commercial/industrial/municipal), account status (active/inactive/pending/suspended/terminated), service class, credit rating, account open date, account close date, language preference, paperless billing flag, autopay enrollment, lifecycle stage, and water budget allocation (where applicable). This is the primary anchor entity for the customer domain — all billing, metering, service delivery, and regulatory reporting references flow through this entity.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`person` (
    `person_id` BIGINT COMMENT 'Unique identifier for the person record. Primary key for the person entity. Serves as the single source of truth for individual identity within the customer domain.',
    `autopay_enrollment_date` DATE COMMENT 'The date when the person enrolled in or opted out of autopay in yyyy-MM-dd format. Used for payment preference tracking and billing operations.',
    `autopay_enrollment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has enrolled in automatic payment (autopay) for their utility bills. True if enrolled in autopay, False otherwise. Used for payment processing and customer convenience tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this person record was first created in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trails, data lineage, and record lifecycle tracking.',
    `credit_check_consent_date` DATE COMMENT 'The date when the person provided consent for credit check in yyyy-MM-dd format. Used for compliance documentation and audit trails.',
    `credit_check_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has provided consent for the utility to perform a credit check. True if consent given, False otherwise. Required for deposit determination and account establishment.',
    `customer_segment` STRING COMMENT 'The business segment classification of the person based on their primary account relationship. Used for rate classification, service level determination, and customer analytics. Aligns with rate schedule eligibility.. Valid values are `residential|small_commercial|large_commercial|industrial|municipal|agricultural`',
    `data_sharing_consent_date` DATE COMMENT 'The date when the person provided or withdrew data sharing consent in yyyy-MM-dd format. Used for compliance documentation and privacy management.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has consented to sharing their data with third parties (e.g., energy efficiency program partners, government agencies, research organizations). True if consent given, False otherwise.',
    `date_of_birth` DATE COMMENT 'The persons date of birth in yyyy-MM-dd format. Used for identity verification, age-based service eligibility (e.g., senior citizen rates), and compliance with age-restricted service programs.',
    `disability_accommodation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person requires disability accommodations for service delivery, communications, or billing. True if accommodations required, False otherwise. Used to ensure accessible service delivery.',
    `disability_accommodation_notes` STRING COMMENT 'Free-text notes describing specific disability accommodations required by the person (e.g., large print bills, TTY/TDD phone service, accessible meter location). Used to ensure appropriate service delivery and ADA compliance.',
    `email_address` STRING COMMENT 'The primary email address for the person. Used for electronic billing, service notifications, CCR (Consumer Confidence Report) delivery, and digital customer communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `government_id_expiration_date` DATE COMMENT 'The expiration date of the government-issued identification document in yyyy-MM-dd format. Used to ensure identity verification documents remain current and valid.',
    `government_id_issuing_state` STRING COMMENT 'The U.S. state or territory that issued the government identification document. Used for identity verification and fraud prevention. Two-letter state abbreviation (e.g., CA, NY, TX).',
    `government_id_number_masked` STRING COMMENT 'The masked or partially redacted government-issued identification number (e.g., last 4 digits of SSN, masked drivers license number). Full number stored in secure vault; this field contains display-safe version for operational use.',
    `government_id_type` STRING COMMENT 'The type of government-issued identification document provided by the person for identity verification during account application or service connection. Used to comply with customer identification requirements.. Valid values are `drivers_license|state_id|passport|military_id|tribal_id|ssn`',
    `identity_verification_date` DATE COMMENT 'The date when the persons identity was successfully verified in yyyy-MM-dd format. Used for audit trails and compliance reporting on customer identification procedures.',
    `identity_verification_method` STRING COMMENT 'The method used to verify the persons identity (in-person document review, online verification service, mail-in documentation, third-party identity verification service). Used for audit and compliance tracking.. Valid values are `in_person|online|mail|third_party_service`',
    `identity_verification_status` STRING COMMENT 'The current status of the persons identity verification process. Indicates whether government-issued identification has been validated and approved for service connection and account establishment.. Valid values are `verified|pending|failed|expired|not_required`',
    `language_preference` STRING COMMENT 'The persons preferred language for communications and service delivery. Three-letter ISO 639-2 language code. Used to ensure accessible customer service and compliance with language access requirements. [ENUM-REF-CANDIDATE: ENG|SPA|CHI|VIE|KOR|RUS|FRE|ARA|POR|OTH — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this person record was last updated in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trails, change tracking, and data synchronization across systems.',
    `legal_first_name` STRING COMMENT 'The legal first name of the person as it appears on government-issued identification documents. Used for identity verification and legal correspondence.',
    `legal_last_name` STRING COMMENT 'The legal last name (surname) of the person as it appears on government-issued identification documents. Used for identity verification and legal correspondence.',
    `legal_middle_name` STRING COMMENT 'The legal middle name or initial of the person as it appears on government-issued identification documents. May be null if not provided.',
    `life_support_equipment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person or household member relies on life-support medical equipment that requires uninterrupted water service. True if life-support equipment present, False otherwise. Used for service disconnection protection and emergency prioritization.',
    `life_support_verification_date` DATE COMMENT 'The date when the life-support equipment status was verified by medical certification in yyyy-MM-dd format. Used for program compliance and annual recertification tracking.',
    `low_income_assistance_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person is eligible for low-income assistance programs, rate discounts, or payment assistance based on income verification. True if eligible, False otherwise. Used for social equity program administration.',
    `low_income_verification_date` DATE COMMENT 'The date when the persons low-income status was verified for assistance program eligibility in yyyy-MM-dd format. Used for program compliance and recertification tracking.',
    `marketing_consent_date` DATE COMMENT 'The date when the person provided or withdrew marketing consent in yyyy-MM-dd format. Used for compliance documentation and preference management.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has consented to receive marketing communications and promotional materials from the utility. True if consent given, False otherwise. Used to comply with marketing communication regulations.',
    `paperless_billing_enrollment_date` DATE COMMENT 'The date when the person enrolled in or opted out of paperless billing in yyyy-MM-dd format. Used for billing preference tracking and environmental impact reporting.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has enrolled in paperless billing and prefers to receive bills electronically. True if enrolled in paperless billing, False if paper bills preferred.',
    `person_status` STRING COMMENT 'The current lifecycle status of the person record. Active indicates the person is currently associated with one or more accounts. Inactive indicates no current account relationships. Deceased, merged, and duplicate statuses support data quality and master data management.. Valid values are `active|inactive|deceased|merged|duplicate`',
    `person_type` STRING COMMENT 'The role or relationship type of the person within the customer domain. Distinguishes between account holders, co-applicants, authorized contacts, guarantors, and other person roles. One person may have multiple types across different accounts.. Valid values are `account_holder|co_applicant|authorized_contact|guarantor|emergency_contact|property_owner`',
    `preferred_contact_method` STRING COMMENT 'The persons preferred method for receiving utility communications and notifications. Used to honor customer communication preferences and improve engagement rates.. Valid values are `email|phone|sms|mail|portal`',
    `preferred_name` STRING COMMENT 'The name the person prefers to be called in day-to-day interactions, which may differ from their legal name. Used for customer service communications and personalization.',
    `primary_phone` STRING COMMENT 'The primary contact phone number for the person. Used for service notifications, billing inquiries, outage alerts, and emergency communications. Format may include country code, area code, and extension.',
    `primary_phone_type` STRING COMMENT 'The type of primary phone number (mobile, home, work, other). Used to determine appropriate communication channels and times for customer outreach.. Valid values are `mobile|home|work|other`',
    `senior_citizen_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person qualifies as a senior citizen for age-based rate discounts or service programs. True if senior citizen, False otherwise. Age threshold defined by utility policy and regulatory requirements.',
    `suffix` STRING COMMENT 'Generational or professional suffix appended to the persons legal name (e.g., Jr, Sr, II, III). Used to distinguish individuals with identical names.. Valid values are `Jr|Sr|II|III|IV|V`',
    CONSTRAINT pk_person PRIMARY KEY(`person_id`)
) COMMENT 'Master record for individual persons associated with water utility accounts — account holders, co-applicants, authorized contacts, and guarantors. Captures legal name, date of birth, government ID type and masked number, primary phone, secondary phone, email address, preferred contact method, language preference, identity verification status, and privacy consent flags. Distinct from the account entity: one person may hold multiple accounts (e.g., landlord with multiple rental properties). SSOT for individual identity within the customer domain.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`organization` (
    `organization_id` BIGINT COMMENT 'Unique system identifier for the organization entity. Primary key for commercial, industrial, and municipal organizations holding water and wastewater service accounts.',
    `parent_organization_id` BIGINT COMMENT 'Reference to the parent organization in corporate hierarchies. Enables consolidated billing, enterprise account management, and multi-location reporting for corporate customers.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Water utilities frequently have dual-role relationships where commercial/industrial customer organizations are also approved vendors (chemical suppliers, contractors, equipment providers). Tracking th',
    `account_closed_date` DATE COMMENT 'Date when the organizations account was closed or terminated. Null for active accounts.',
    `account_opened_date` DATE COMMENT 'Date when the organizations first service account was established with the utility. Used for customer tenure analysis and loyalty program eligibility.',
    `account_status` STRING COMMENT 'Current lifecycle status of the organization account. Active accounts receive service; Suspended accounts have service restrictions; Closed accounts are terminated.. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `annual_revenue_range` STRING COMMENT 'Estimated annual revenue range of the organization. Used for credit assessment, account prioritization, and business development targeting.. Valid values are `under_1m|1m_to_10m|10m_to_50m|50m_to_100m|over_100m|unknown`',
    `auto_pay_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the organization is enrolled in automatic payment processing. True if enrolled, False otherwise.',
    `billing_address_line1` STRING COMMENT 'First line of the organizations billing address, typically street number and name. Used for invoice delivery and legal correspondence.',
    `billing_address_line2` STRING COMMENT 'Second line of billing address for suite, floor, or department information.',
    `billing_city` STRING COMMENT 'City name for the organizations billing address.',
    `billing_country` STRING COMMENT 'Three-letter ISO country code for the organizations billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the organizations billing address.. Valid values are `^d{5}(-d{4})?$`',
    `billing_state` STRING COMMENT 'Two-letter state code for the organizations billing address.. Valid values are `^[A-Z]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the organization record was first created in the customer information system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the organization before service restrictions are applied. Expressed in USD.',
    `credit_tier` STRING COMMENT 'Internal credit rating tier assigned to the organization based on payment history, financial strength, and risk assessment. Determines deposit requirements and payment terms.. Valid values are `tier_1|tier_2|tier_3|tier_4|unrated`',
    `customer_segment` STRING COMMENT 'Business segment classification for the organization. Used for rate structure assignment, service level agreements, and market analysis.. Valid values are `commercial|industrial|municipal|institutional|agricultural|government`',
    `dba_name` STRING COMMENT 'Trade name or fictitious business name under which the organization operates, if different from legal name. Used for customer-facing communications and service delivery.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit held for the organization. Expressed in USD. Null if no deposit is required.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required for this organization based on credit assessment. True if deposit is required, False otherwise.',
    `employee_count_range` STRING COMMENT 'Estimated number of employees at the organization. Used for water demand forecasting and commercial rate structure assignment. [ENUM-REF-CANDIDATE: 1_to_10|11_to_50|51_to_200|201_to_500|501_to_1000|over_1000|unknown — 7 candidates stripped; promote to reference product]',
    `federal_tax_number` STRING COMMENT 'IRS-issued Employer Identification Number (EIN) for tax reporting and identification purposes. Nine-digit number in format XX-XXXXXXX.. Valid values are `^d{2}-d{7}$`',
    `incorporation_date` DATE COMMENT 'Date the organization was legally incorporated, registered, or chartered. Used for account tenure analysis and credit assessment.',
    `incorporation_state` STRING COMMENT 'Two-letter state code where the organization is legally incorporated or registered. Used for jurisdictional compliance and legal correspondence.. Valid values are `^[A-Z]{2}$`',
    `industrial_user_classification` STRING COMMENT 'EPA classification level for industrial users subject to pretreatment requirements. Categorical Industrial User (CIU) discharges regulated pollutants; Significant Industrial User (SIU) meets discharge thresholds; Non-Significant does not meet thresholds.. Valid values are `categorical|significant|non_significant|not_applicable`',
    `industrial_user_flag` BOOLEAN COMMENT 'Indicates whether the organization is classified as an industrial user subject to pretreatment program requirements under the Clean Water Act. True if industrial user, False otherwise.',
    `iup_expiration_date` DATE COMMENT 'Date when the current IUP permit expires and renewal is required. Used for compliance tracking and permit renewal notifications.',
    `iup_permit_number` STRING COMMENT 'Permit number issued for industrial users authorized to discharge wastewater into the municipal collection system. Required for tracking pretreatment compliance and discharge monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the organization record was last updated. Used for data synchronization and audit trail.',
    `legal_name` STRING COMMENT 'The official registered legal name of the organization as filed with state incorporation documents or municipal charter. Used for contracts, billing, and regulatory reporting.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code identifying the organizations primary industry sector. Used for industrial user classification, rate structure assignment, and regulatory reporting.. Valid values are `^d{6}$`',
    `organization_type` STRING COMMENT 'Legal structure classification of the organization. Determines billing rules, credit policies, and regulatory treatment.. Valid values are `corporation|llc|partnership|municipality|hoa|government_agency`',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the organization has opted for electronic billing only. True if paperless, False if paper invoices are required.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date. Standard terms are typically 30 days; extended terms may be granted based on credit tier.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for electronic billing, service notifications, and account correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary authorized representative or contact person for the organization. Used for account management, billing inquiries, and service notifications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the organization contact. Used for urgent service notifications, outage alerts, and account inquiries.. Valid values are `^+?1?d{10,15}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person within the organization (e.g., Facilities Manager, CFO, City Manager).',
    `sic_code` STRING COMMENT 'Four-digit SIC code for legacy industry classification. Maintained for historical reporting and systems that have not migrated to NAICS.. Valid values are `^d{4}$`',
    `special_billing_instructions` STRING COMMENT 'Free-text field for custom billing requirements, invoice formatting preferences, or special handling instructions for the organization account.',
    `tax_exempt_certificate_number` STRING COMMENT 'State-issued tax exemption certificate number for organizations claiming tax-exempt status. Required for audit compliance.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the organization is exempt from sales tax or utility taxes. True if tax-exempt (typically government entities), False otherwise.',
    `website_url` STRING COMMENT 'Public website URL for the organization. Used for customer research and business development.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master record for commercial, industrial, and municipal organizations that hold water and wastewater service accounts. Captures legal entity name, DBA name, federal tax ID (EIN), NAICS/SIC industry code, organization type (corporation/LLC/municipality/HOA/government), primary contact name, incorporation state, credit tier, industrial user classification (for IUP purposes), and parent organization reference for corporate hierarchies. Supports B2B account management and industrial pretreatment program tracking.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`service_address` (
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address record. Primary key for the service address entity.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Service addresses added or modified through CIP work (subdivision developments, service area extensions, infrastructure upgrades). Essential for geographic expansion tracking, service territory planni',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service addresses fall within District Metered Areas for non-revenue water tracking, leak detection program management, and consumption pattern analysis. Essential for AWWA water audit compliance, tar',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to customer.parcel. Business justification: Service address is physically located on a land parcel; linking provides geographic context and eliminates isolated parcel table.',
    `address_effective_date` DATE COMMENT 'Date when this service address became effective and available for service delivery. Start of the address lifecycle.',
    `address_end_date` DATE COMMENT 'Date when this service address was retired or became unavailable for service. Null if address is still active.',
    `address_line_1` STRING COMMENT 'Primary street address line including house number, street name, and street type. First line of the physical service delivery location.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment number, suite, unit, building, floor, or other location qualifier within the premise.',
    `address_notes` STRING COMMENT 'Free-text notes or comments about the service address including special access instructions, delivery restrictions, or historical context.',
    `address_source_system` STRING COMMENT 'Name of the source system or application that created or last updated this service address record (e.g., CC&B, GIS, CRM).',
    `address_status` STRING COMMENT 'Lifecycle status of the service address record. Values: active (currently serviceable), inactive (temporarily not in use), pending (awaiting activation), retired (permanently closed).. Valid values are `active|inactive|pending|retired`',
    `address_validation_status` STRING COMMENT 'Status indicating whether the address has been validated against USPS or other authoritative address databases. Values: validated, unvalidated, corrected, invalid.. Valid values are `validated|unvalidated|corrected|invalid`',
    `apn` STRING COMMENT 'County assessor parcel number uniquely identifying the land parcel for property tax and ownership purposes. Links service address to GIS parcel data.',
    `building_type` STRING COMMENT 'Type or classification of building structure at the service address (e.g., single-family, multi-family, office, retail, warehouse, school).',
    `city` STRING COMMENT 'City or municipality name where the service address is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the service address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish name where the service address is located. Used for regulatory reporting and jurisdictional compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service address record was first created in the system. Audit trail for data lineage.',
    `customer_class` STRING COMMENT 'Customer classification for rate and billing purposes. Values: residential, commercial, industrial, municipal, agricultural, institutional.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `flood_zone_designation` STRING COMMENT 'FEMA flood zone classification (e.g., A, AE, X, VE) indicating flood risk level. Used for infrastructure planning and emergency response.',
    `gis_feature_code` STRING COMMENT 'Unique identifier linking this service address to the corresponding feature in the Esri ArcGIS spatial database for network modeling and asset management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service address record was last updated or modified. Audit trail for change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees (WGS84 datum). Used for GIS mapping, network modeling, and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees (WGS84 datum). Used for GIS mapping, network modeling, and spatial analysis.',
    `meter_location_description` STRING COMMENT 'Free-text description of where the water meter is physically located at the premise (e.g., front yard, basement, alley, inside garage).',
    `occupancy_status` STRING COMMENT 'Current occupancy status of the premise. Values: occupied, vacant, seasonal, under_construction.. Valid values are `occupied|vacant|seasonal|under_construction`',
    `postal_code` STRING COMMENT 'Five-digit ZIP code or ZIP+4 format postal code for the service address. Used for mail delivery and geographic segmentation.. Valid values are `^d{5}(-d{4})?$`',
    `pressure_zone` STRING COMMENT 'Water distribution pressure zone identifier indicating the hydraulic zone serving this address. Used for hydraulic modeling and pressure management.',
    `service_territory_code` STRING COMMENT 'Code identifying the utility service territory or franchise area where the address is located. Determines regulatory jurisdiction and service provider.',
    `service_type` STRING COMMENT 'Type of utility service(s) available at this address. Values: water_only, wastewater_only, water_and_wastewater, stormwater, reclaimed_water.. Valid values are `water_only|wastewater_only|water_and_wastewater|stormwater|reclaimed_water`',
    `sewer_basin` STRING COMMENT 'Wastewater collection basin or drainage area identifier indicating which sewer system and treatment plant serve this address.',
    `standardized_address` STRING COMMENT 'Fully standardized and concatenated address string following USPS formatting rules. Used for address matching and deduplication.',
    `state_code` STRING COMMENT 'Two-letter state or province abbreviation following USPS standards (e.g., CA, TX, NY).. Valid values are `^[A-Z]{2}$`',
    `within_service_boundary_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the address is within the utilitys authorized service boundary. True if within boundary, False if outside.',
    CONSTRAINT pk_service_address PRIMARY KEY(`service_address_id`)
) COMMENT 'Physical location where water and/or wastewater service is delivered. Captures full street address, city, state, ZIP+4, county, parcel number (APN), GIS coordinates (latitude/longitude), service territory code, pressure zone, DMA (District Metered Area) code, sewer basin, flood zone designation, address validation status, and whether the address is within the utility service boundary. Linked to the distribution network and metering domains via service point. One address may have multiple active accounts over time (tenant turnover).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`premise` (
    `premise_id` BIGINT COMMENT 'Unique identifier for the premise record. Primary key representing the utilitys asset record for a serviceable location.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Premises created or significantly modified by CIP projects (new subdivisions, service area expansions, infrastructure replacements requiring new service lines). Critical for asset-to-project traceabil',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Premises physically connect to specific distribution mains for water service delivery. Essential for hydraulic modeling, service line inventory (LCRR compliance), outage impact analysis, and main brea',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Each premise is served by a specific WTP. This link is essential for Consumer Confidence Report (CCR) distribution, water quality emergency notifications, and service territory management. Domain expe',
    `service_address_id` BIGINT COMMENT 'Reference to the postal and Geographic Information System (GIS) address record for this premise. Links premise to distribution network location.',
    `territory_id` BIGINT COMMENT 'Reference to the geographic service territory in which this premise is located. Determines regulatory jurisdiction and operational district.',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: Every premise is served by a specific water system, determining applicable CCR reporting obligations, LCRR lead service line inventory requirements, quality standards, and targeted public notification',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: Premises are assigned to a specific WWTP service area for capacity planning, wastewater rate zone assignment, and regulatory reporting. Utilities maintain this assignment directly on the premise recor',
    `backflow_prevention_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires backflow prevention devices due to cross-connection hazards. Mandatory for commercial, industrial, and irrigation services per Safe Drinking Water Act (SDWA).',
    `building_square_footage` DECIMAL(18,2) COMMENT 'Total conditioned floor area of structures on the premise in square feet. Used for commercial water demand forecasting and capacity fee assessments.',
    `building_type` STRING COMMENT 'Physical structure classification of the building on the premise. Used for demand forecasting and infrastructure capacity planning. [ENUM-REF-CANDIDATE: detached_house|townhouse|apartment|office|retail|warehouse|manufacturing|school|hospital|government|mixed_use — 11 candidates stripped; promote to reference product]',
    `connection_fee_paid_amount` DECIMAL(18,2) COMMENT 'Total one-time connection or capacity fees paid for this premise to establish utility service. Includes system development charges and impact fees.',
    `connection_fee_paid_date` DATE COMMENT 'Date when connection or capacity fees were paid for this premise. Used for revenue recognition and capital improvement program (CIP) funding tracking.',
    `construction_year` STRING COMMENT 'Year the primary structure on the premise was originally constructed. Used for infrastructure age analysis and lead service line risk assessment per Lead and Copper Rule Revisions (LCRR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was first created in the utility system. Part of audit trail for data lineage and regulatory compliance.',
    `district_metered_area_code` STRING COMMENT 'Code identifying the District Metered Area (DMA) for water loss management and Non-Revenue Water (NRW) tracking. Used for hydraulic zone analysis.. Valid values are `^DMA-[A-Z0-9]{3,10}$`',
    `effective_end_date` DATE COMMENT 'Date when this premise record was retired or became inactive. Null for currently active premises. Supports temporal data management and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this premise record became active and available for service connections. Supports temporal data management and historical analysis.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Ground elevation of the premise in feet above mean sea level. Critical for hydraulic pressure calculations and gravity sewer flow analysis.',
    `estimated_daily_demand_gallons` DECIMAL(18,2) COMMENT 'Projected average daily water consumption in gallons for this premise based on premise type, units, and historical usage patterns. Used for capacity planning and meter sizing.',
    `fats_oils_grease_program_flag` BOOLEAN COMMENT 'Indicates whether the premise is subject to Fats, Oils, and Grease (FOG) control program requirements. Applicable to food service establishments to prevent Sanitary Sewer Overflows (SSO).',
    `fire_protection_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires dedicated fire protection service (fire hydrant or sprinkler connection). Determines fire service charge applicability.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the premise location in decimal degrees (WGS84 datum). Used for spatial analysis, hydraulic modeling, and field service dispatch.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the premise location in decimal degrees (WGS84 datum). Used for spatial analysis, hydraulic modeling, and field service dispatch.',
    `industrial_user_permit_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires an Industrial User Permit (IUP) for wastewater discharge due to industrial processes. Triggers pretreatment program compliance monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was most recently updated. Used for change tracking and data synchronization across systems.',
    `lot_size_square_feet` DECIMAL(18,2) COMMENT 'Total land area of the premise parcel in square feet. Used for irrigation demand estimation and stormwater fee calculations.',
    `low_income_assistance_eligible_flag` BOOLEAN COMMENT 'Indicates whether the premise qualifies for low-income customer assistance programs based on property characteristics or census tract designation. Used for rate discount eligibility.',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Standard meter size in inches required or installed at this premise based on demand characteristics. Common sizes: 0.625, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches.',
    `number_of_units` STRING COMMENT 'Count of individual dwelling or tenant units within the premise. Applicable for multi-family residential and commercial properties. Used for equivalent dwelling unit (EDU) calculations.',
    `parcel_number` STRING COMMENT 'County assessors parcel number (APN) or tax lot identifier for the property. Used for cross-reference with property tax records and GIS systems.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `peak_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak instantaneous water demand in Gallons Per Minute (GPM) for this premise. Used for hydraulic modeling and service line sizing.',
    `premise_number` STRING COMMENT 'Externally-known business identifier for the premise, used in customer communications and field operations. Unique across the utility service territory.. Valid values are `^[A-Z0-9]{6,20}$`',
    `premise_status` STRING COMMENT 'Current lifecycle status of the premise in the utilitys service inventory. Determines whether the premise is available for service connection.. Valid values are `active|inactive|pending_construction|demolished|condemned|seasonal`',
    `premise_type` STRING COMMENT 'Classification of the premise based on its primary use and service characteristics. Determines applicable rate schedules and service requirements.. Valid values are `single_family_residential|multi_family_residential|commercial|industrial|irrigation|fire_protection`',
    `pressure_zone` STRING COMMENT 'Hydraulic pressure zone designation for this premise within the distribution network. Determines operating Pounds per Square Inch (PSI) range and Pressure Reducing Valve (PRV) assignments.. Valid values are `^PZ-[A-Z0-9]{2,8}$`',
    `reclaimed_water_service_available_flag` BOOLEAN COMMENT 'Indicates whether recycled or reclaimed water distribution infrastructure is available for non-potable uses such as irrigation. Part of water conservation programs.',
    `service_line_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the water service line in inches. Determines flow capacity and pressure loss from main to premise.',
    `service_line_material` STRING COMMENT 'Material composition of the water service line connecting the distribution main to the premise. Critical for Lead and Copper Rule Revisions (LCRR) compliance and lead service line inventory. [ENUM-REF-CANDIDATE: copper|galvanized_steel|lead|pvc|pex|hdpe|unknown — 7 candidates stripped; promote to reference product]',
    `sewer_lateral_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the sanitary sewer lateral in inches. Determines wastewater conveyance capacity from premise to collection system.',
    `sewer_lateral_material` STRING COMMENT 'Material composition of the sanitary sewer lateral connecting the premise to the collection main. Used for Inflow and Infiltration (I&I) risk assessment.. Valid values are `vitrified_clay|cast_iron|pvc|concrete|orangeburg|unknown`',
    `special_notes` STRING COMMENT 'Free-text field for operational notes, access instructions, or unique characteristics of the premise relevant to field service personnel and customer service representatives.',
    `stormwater_service_available_flag` BOOLEAN COMMENT 'Indicates whether stormwater drainage infrastructure serves this premise. Determines applicability of stormwater utility fees.',
    `wastewater_service_available_flag` BOOLEAN COMMENT 'Indicates whether sanitary sewer collection infrastructure is available to serve this premise. True if sewer mains are accessible within standard connection distance.',
    `water_service_available_flag` BOOLEAN COMMENT 'Indicates whether potable water distribution infrastructure is available to serve this premise. True if water mains are accessible within standard connection distance.',
    `zoning_classification` STRING COMMENT 'Municipal zoning code designation for the premise parcel. Determines permitted land uses and development density. Format varies by jurisdiction.. Valid values are `^[A-Z]{1,3}-[0-9]{1,2}$`',
    CONSTRAINT pk_premise PRIMARY KEY(`premise_id`)
) COMMENT 'The physical property or facility at which utility service is provided, representing the utilitys view of a serviceable location independent of the customer occupying it. Captures premise type (single-family residential, multi-family, commercial, industrial, irrigation, fire protection), lot size, building type, number of units (for multi-family), number of fixture units (for capacity planning), zoning classification, construction year, lead service line status (known lead, galvanized requiring replacement, non-lead, unknown — per LCRR inventory), and whether the premise is subject to low-income assistance programs. Bridges the customer domain to the distribution network and metering domains. Distinct from service_address: a premise is the utilitys asset record for the location; service_address is the postal/GIS record.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`service_agreement` (
    `service_agreement_id` BIGINT COMMENT 'Unique identifier for the customer_service_agreement data product (auto-inserted pre-linking).',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: The customer-side service_agreement record must reference the operational service.agreement for SLA enforcement, billing rate application, and regulatory compliance reporting. Water utility domain exp',
    `billing_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.billing_rate_schedule. Business justification: A service agreement in water utilities is governed by a specific approved rate schedule (tariff). Knowing which rate schedule applies to a service agreement is essential for bill calculation, rate cas',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: New service agreements for subdivisions or major developments are enabled by a specific CIP main extension or capacity project. Water utilities must track which CIP project authorized and funded the i',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service agreements are assigned to cost centers to allocate O&M costs by service type for rate case cost-of-service studies and departmental budget tracking. Water utilities require this link to produ',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: A service agreement is the contractual relationship between a customer account and the utility for a specific service type. Without a FK to customer_account, the service_agreement has no direct link t',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Each service agreement tied to specific fund type (water/wastewater/stormwater/reclaimed) for proper revenue recognition and GASB compliance. Critical for multi-service utilities with separate fund ac',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Water utilities map each service agreement to a GL revenue account for GASB-compliant revenue recognition by service type (water, wastewater, reclaimed). Rate case cost-of-service studies and revenue ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service agreements are created for a specific service offering (potable water, recycled water, wastewater). This link drives billing rate determination, service type classification, and capacity plann',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: A service agreement is fulfilled through a specific service point (meter connection). This link is essential for meter reading assignment, consumption billing, field service dispatch, and AMI data ass',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service agreements are established for specific premises (physical properties). This FK links the contractual relationship to the physical location where service is provided. Currently service_agreeme',
    `pretreatment_iup_id` BIGINT COMMENT 'Foreign key linking to compliance.pretreatment_iup. Business justification: An industrial users service agreement is governed by their Individual User Permit (IUP). This link enables billing reconciliation against IUP discharge limits, compliance status checks on active serv',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Service agreements contain denormalized address fields that should reference the service_address master. This eliminates redundancy and ensures address consistency. The service_address table is the au',
    `service_application_id` BIGINT COMMENT 'Foreign key linking to customer.service_application. Business justification: A service agreement is the outcome of an approved service application. The agreement should reference the originating application to maintain the full lifecycle traceability from application submissio',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Service agreements are classified by service class (residential, commercial, industrial) which directly drives rate schedule application, AWWA classification reporting, and regulatory tier assignment.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: A service agreement is the contractual basis for water delivery through a specific service line. Direct contract-to-asset linkage enables LCRR compliance traceability, billing accuracy validation, and',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Service agreements are governed by specific SLA definitions (response times, restoration times, pressure guarantees). Required for SLA compliance monitoring, penalty calculation, and regulatory perfor',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Each service agreement is governed by a PUC-approved tariff that determines all applicable rates, fees, and service rules. Required for billing accuracy, regulatory compliance, and rate case reporting',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Service agreements are scoped to a service territory determining applicable franchise agreement, regulatory jurisdiction, rate zone, and primacy agency. Required for franchise compliance reporting, te',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'The contractual relationship between a customer account and the utility for a specific service type (potable water, wastewater, recycled water, fire protection, irrigation) at a premise. Captures service agreement number, service type, rate schedule code, start date, end date, deposit amount, deposit waiver reason, service class, budget billing enrollment, and agreement status. This is the SSOT for what service a customer is contracted to receive and at what rate. Distinct from billing invoices (which are transactional) and from the rate schedule (which is a reference entity in the service domain).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`account_person_rel` (
    `account_person_rel_id` BIGINT COMMENT 'Unique identifier for the account-person relationship record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the water utility account in this relationship. Links to the service account that the person is associated with.',
    `person_id` BIGINT COMMENT 'Reference to the person entity in this relationship. Links to the individual who has a role on the account.',
    `accessibility_requirements` STRING COMMENT 'Special accessibility or accommodation needs for this person when communicating about the account. May include requirements for large print, braille, TTY, or other assistive technologies.',
    `authorization_date` DATE COMMENT 'The date when this relationship was formally authorized or approved. Used for audit trail and compliance verification.',
    `authorization_document_reference` STRING COMMENT 'Reference number or identifier for the legal document or form that authorizes this relationship. May reference a power of attorney, lease agreement, or authorization form.',
    `billing_authority_flag` BOOLEAN COMMENT 'Indicates whether this person has authority to make billing decisions, dispute charges, or modify payment arrangements for the account. True if authorized, false otherwise.',
    `ccr_delivery_required_flag` BOOLEAN COMMENT 'Indicates whether this person must receive the annual Consumer Confidence Report for water quality as required by the Safe Drinking Water Act. True if delivery is required, false otherwise.',
    `created_by_user` STRING COMMENT 'The system user ID or username of the person who created this relationship record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'The date when this person-account relationship ended or will end. Null for open-ended relationships. Used for temporal tracking and historical analysis.',
    `effective_start_date` DATE COMMENT 'The date when this person-account relationship became active and legally binding. Used for temporal tracking and compliance reporting.',
    `emergency_contact_priority` STRING COMMENT 'The order in which this person should be contacted in case of emergency at the service address. Lower numbers indicate higher priority. Null if not an emergency contact.',
    `financial_responsibility_percentage` DECIMAL(18,2) COMMENT 'The percentage of account charges for which this person is financially responsible. Used in split-billing scenarios or shared responsibility arrangements. Value between 0.00 and 100.00.',
    `landlord_tenant_indicator` STRING COMMENT 'Specifies whether this person is the property owner (landlord), renter (tenant), owner-occupant, or property manager. Used for billing responsibility determination and compliance reporting.. Valid values are `landlord|tenant|owner_occupant|property_manager|not_applicable`',
    `language_preference` STRING COMMENT 'The preferred language for communications with this person regarding the account. Three-letter ISO 639-2 language code. Used for compliance with language access requirements. [ENUM-REF-CANDIDATE: ENG|SPA|CHI|FRE|VIE|KOR|RUS|ARA|POR|OTH — 10 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'The system user ID or username of the person who last modified this relationship record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was most recently updated. Used for audit trail and change tracking.',
    `lcrr_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this person must receive mandatory notifications under the EPA Lead and Copper Rule Revisions regarding lead service lines at the service address. True if notification is required, false otherwise.',
    `notification_preference` STRING COMMENT 'The preferred communication channel for sending notifications to this person regarding the account. Used for outage alerts, billing reminders, and compliance notifications.. Valid values are `email|sms|phone|mail|portal|none`',
    `relationship_notes` STRING COMMENT 'Free-form text field for additional information about this account-person relationship. May include special instructions, restrictions, or context relevant to customer service representatives.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the account-person relationship. Indicates whether the relationship is currently in effect or has been terminated.. Valid values are `active|inactive|pending|suspended|terminated`',
    `relationship_type` STRING COMMENT 'The role or capacity in which the person is associated with the account. Defines the nature of the relationship between the person and the service account.. Valid values are `primary_account_holder|co_applicant|authorized_representative|emergency_contact|third_party_notification|property_manager`',
    `service_authorization_flag` BOOLEAN COMMENT 'Indicates whether this person has authority to request service orders, schedule appointments, or authorize field work for the account. True if authorized, false otherwise.',
    `termination_date` DATE COMMENT 'The date when this relationship was formally terminated in the system. May differ from effective_end_date if termination was processed retroactively. Null for active relationships.',
    `termination_reason` STRING COMMENT 'The reason why this account-person relationship was terminated. Null for active relationships. Used for analytics and compliance reporting. [ENUM-REF-CANDIDATE: account_closed|person_removed|authorization_revoked|lease_ended|property_sold|death|customer_request|administrative — 8 candidates stripped; promote to reference product]',
    `third_party_payer_flag` BOOLEAN COMMENT 'Indicates whether this person is responsible for paying the bill on behalf of the primary account holder. True for third-party payers such as social service agencies or property managers, false otherwise.',
    `verification_date` DATE COMMENT 'The date when the persons identity and relationship authorization were last verified. Used for periodic re-verification requirements and audit compliance.',
    `verification_method` STRING COMMENT 'The method used to verify the persons identity and authorization for this relationship. Used for audit trail and fraud prevention analysis.. Valid values are `in_person|document_upload|phone_verification|email_verification|third_party_service|notarized_form`',
    `verification_status` STRING COMMENT 'Indicates whether the persons identity and authorization for this relationship have been verified. Used for fraud prevention and compliance with customer identification requirements.. Valid values are `verified|pending_verification|unverified|verification_failed|expired`',
    CONSTRAINT pk_account_person_rel PRIMARY KEY(`account_person_rel_id`)
) COMMENT 'Association entity capturing the relationship between a person and a water utility account, including the role the person plays (primary account holder, co-applicant, authorized representative, emergency contact, third-party notification recipient). Carries its own business data: relationship type, effective start date, effective end date, notification preferences for this role, and whether the person has billing authority. Supports scenarios such as landlord-tenant relationships, property managers, and third-party bill payers. Required for LCRR lead service line notification compliance.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`service_application` (
    `service_application_id` BIGINT COMMENT 'Unique identifier for the service application record. Primary key.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Service applications capture applicant details that should reference the person master record. This eliminates data duplication and ensures applicant identity is properly managed. The person table con',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Service applications for new connections often trigger or relate to CIP projects (developer-funded infrastructure, capacity expansions). Critical for capacity planning, developer coordination, and con',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: New service application connection fees and system development charges must be allocated to specific capital funds (e.g., infrastructure expansion fund, SDC fund). Water utilities track which fund rec',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Service applications specify a requested meter size that must be validated against available meter_size_type records for capacity planning, connection fee calculation, and inventory allocation. The pl',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Applications request specific service offerings (potable water, wastewater, reclaimed). Application review validates requested service against available offerings, calculates connection fees per offer',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service applications are for establishing service at specific premises. While service_address_id exists, the premise_id link is needed to reference the physical property record which contains addition',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: New service applications require engineering review to verify adequate pressure and capacity in the target pressure zone before approval. Critical for ensuring system can support additional demand wit',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer (applicant) who submitted this service application. Links to the customer master record.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address (premise) where water or wastewater service is being requested. Links to the service address master record.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: A new service application results in the creation or modification of a service line asset. Linking the application to the resulting service line enables end-to-end traceability from customer request t',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Applications must validate service address falls within utilitys franchise territory before approval. Required for capacity planning, infrastructure availability checks, regulatory jurisdiction deter',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned when the customer submits a service application. Used for customer communication and tracking.. Valid values are `^APP-[0-9]{8,12}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the service application: submitted (initial state), under review (being processed by utility staff), approved (ready for service establishment), rejected (application denied), withdrawn (applicant cancelled), or pending payment (awaiting deposit or connection fee).. Valid values are `submitted|under_review|approved|rejected|withdrawn|pending_payment`',
    `application_type` STRING COMMENT 'Type of service application: new service establishment, transfer of service to new occupant, service upgrade (larger meter or additional service), service downgrade, service termination, or reconnection after disconnection.. Valid values are `new_service|transfer|upgrade|downgrade|termination|reconnection`',
    `approval_date` DATE COMMENT 'Date when the service application was approved by the utility, authorizing service establishment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service application was approved.',
    `connection_fee_amount` DECIMAL(18,2) COMMENT 'One-time connection or service establishment fee charged to the applicant for initiating water or wastewater service at the premise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service application record was first created in the system.',
    `credit_check_result` STRING COMMENT 'Outcome of the credit check: pass (credit meets utility standards), fail (credit does not meet standards, deposit required), insufficient history (no credit history available), or not applicable (credit check not performed).. Valid values are `pass|fail|insufficient_history|not_applicable`',
    `credit_check_status` STRING COMMENT 'Status of credit check for the applicant: not required (based on service class or policy), pending (credit check requested), completed (credit check results received), or waived (credit check requirement waived by management).. Valid values are `not_required|pending|completed|waived`',
    `credit_score` STRING COMMENT 'Numeric credit score obtained from credit bureau for the applicant, used to determine deposit requirements and service approval.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit required from the applicant before service establishment. Null if no deposit is required.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required from the applicant before service can be established, based on credit check results, service history, or utility policy.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the applicants identity: drivers license, passport, utility bill from previous address, government-issued ID, credit report, or in-person verification at utility office.. Valid values are `drivers_license|passport|utility_bill|government_id|credit_report|in_person`',
    `identity_verification_status` STRING COMMENT 'Status of applicant identity verification process: not started, pending (documents submitted, under review), verified (identity confirmed), or failed (unable to verify identity).. Valid values are `not_started|pending|verified|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this service application record was last updated or modified.',
    `priority_level` STRING COMMENT 'Priority level assigned to the application for processing: low (standard processing), normal (default priority), high (expedited processing requested), or urgent (emergency service needed).. Valid values are `low|normal|high|urgent`',
    `processing_notes` STRING COMMENT 'Free-text notes entered by utility staff during application review and processing, documenting special circumstances, follow-up actions, or additional context.',
    `rejection_date` DATE COMMENT 'Date when the service application was rejected by the utility. Null if application was not rejected.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the service application was rejected (e.g., failed credit check, incomplete documentation, service not available at address, outstanding balance from previous account).',
    `rejection_reason_code` STRING COMMENT 'Standardized code categorizing the reason for application rejection: credit failure, incomplete documentation, service unavailable at location, outstanding balance from prior account, duplicate application, or invalid service address.. Valid values are `credit_fail|incomplete_docs|service_unavailable|outstanding_balance|duplicate_application|invalid_address`',
    `requested_service_start_date` DATE COMMENT 'Date when the applicant requests water or wastewater service to begin at the service address.',
    `review_completed_date` DATE COMMENT 'Date when the application review process was completed and a decision (approved or rejected) was made.',
    `review_start_date` DATE COMMENT 'Date when utility staff began reviewing and processing the service application.',
    `service_class_requested` STRING COMMENT 'Customer segment or service class requested: residential (single-family or multi-family), commercial (retail, office), industrial (manufacturing, processing), municipal (government facilities), agricultural (irrigation, livestock), or institutional (schools, hospitals).. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `service_type_requested` STRING COMMENT 'Type of utility service requested by the applicant: water only, wastewater (sewer) only, or combined water and wastewater service.. Valid values are `water_only|wastewater_only|water_and_wastewater`',
    `sla_due_date` DATE COMMENT 'Target date by which the application should be reviewed and processed according to utility service level agreement standards.',
    `submission_channel` STRING COMMENT 'Channel through which the customer submitted the service application: online customer portal, phone call to customer service, walk-in at utility office, postal mail, mobile app, or email.. Valid values are `online_portal|phone|walk_in|mail|mobile_app|email`',
    `submission_date` DATE COMMENT 'Date when the customer submitted the service application.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service application was submitted by the customer or entered into the system.',
    `withdrawn_date` DATE COMMENT 'Date when the applicant withdrew or cancelled the service application. Null if application was not withdrawn.',
    `withdrawn_reason` STRING COMMENT 'Reason provided by the applicant for withdrawing the service application (e.g., changed mind, moved to different location, service no longer needed).',
    CONSTRAINT pk_service_application PRIMARY KEY(`service_application_id`)
) COMMENT 'Record of a customers application to establish, transfer, or modify water and/or wastewater service. Captures application number, application type (new service, transfer, upgrade, downgrade, termination), applicant identity, requested service address, requested service start date, application submission channel (online, phone, walk-in), application status (submitted, under review, approved, rejected, withdrawn), identity verification outcome, credit check result, deposit requirement, and processing timestamps. Represents the start of the customer lifecycle. Sourced from Oracle CC&B and Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account or person this contact is associated with. Links contact to the customer master record in Oracle Utilities CC&B.',
    `contact_customer_customer_account_id` BIGINT COMMENT 'Reference to the customer account or person this contact is associated with. Links contact to the customer master record in Oracle Utilities CC&B.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Contact points (phone, email) may be associated with specific persons in addition to accounts. This allows tracking which person at an account uses which contact method. Nullable FK as some contacts a',
    `channel` STRING COMMENT 'The communication channel or medium through which this contact point operates. Supports multi-channel customer engagement including Consumer Confidence Report (CCR) delivery, boil-water notices, and outage notifications.. Valid values are `phone|email|sms|postal|portal|fax`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Active contacts are used for communications; inactive contacts are retained for history; invalid contacts have been identified as unreachable; pending_verification contacts await confirmation.. Valid values are `active|inactive|suspended|invalid|pending_verification`',
    `contact_type` STRING COMMENT 'Classification of the contact purpose. Indicates whether this contact is used for billing correspondence, service notifications, emergency alerts, legal notices, technical communications, or general customer service inquiries.. Valid values are `billing|service|emergency|legal_notice|technical|customer_service`',
    `contact_value` DECIMAL(18,2) COMMENT 'The actual contact information value - phone number, email address, mailing address, SMS number, portal username, or fax number. Format varies by contact_channel. This is the primary contact data point.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was first created in the data platform. Supports audit trail and data lineage tracking.',
    `delivery_failure_count` STRING COMMENT 'Count of failed communication delivery attempts to this contact. Used to identify problematic contacts and trigger validation workflows.',
    `delivery_success_count` STRING COMMENT 'Count of successful communication deliveries to this contact. Used to calculate contact reliability and quality scores.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Boolean flag indicating customer has requested no contact through this channel except for legally required communications. Overrides opt-in preferences except for emergency and regulatory notifications.',
    `effective_end_date` DATE COMMENT 'Date after which this contact information is no longer active. Null for currently active contacts. Enables contact history tracking and audit trails.',
    `effective_start_date` DATE COMMENT 'Date from which this contact information becomes active and valid for use. Supports temporal contact management and future-dated contact changes.',
    `invalid_date` DATE COMMENT 'Date when this contact was marked as invalid. Used for data quality reporting and contact refresh prioritization.',
    `invalid_reason` STRING COMMENT 'Reason why this contact was marked as invalid. Populated when contact_status is set to invalid. Supports data quality improvement and contact cleansing workflows.. Valid values are `bounced_email|disconnected_phone|returned_mail|customer_reported|system_validation_failed`',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary contact point for the associated customer and contact type. Used to determine default communication channel for critical notifications.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether this contact information has been verified as accurate and reachable. Verification may occur through confirmation emails, SMS codes, or postal mail validation.',
    `label` STRING COMMENT 'Human-readable label or nickname for this contact (e.g., Home Phone, Work Email, Billing Address). Helps users distinguish between multiple contacts of the same type.',
    `language_preference` STRING COMMENT 'Preferred language for communications sent to this contact. Three-letter ISO 639-2 language code. Supports multilingual customer communications and regulatory compliance for non-English speaking customers. [ENUM-REF-CANDIDATE: ENG|SPA|FRE|CHI|VIE|KOR|RUS|ARA|POR|GER — 10 candidates stripped; promote to reference product]',
    `last_contact_date` DATE COMMENT 'Date when this contact point was last used for outbound communication. Used to track contact engagement and identify stale contact records.',
    `last_contact_type` STRING COMMENT 'Type of the last communication sent to this contact (e.g., bill, service alert, CCR, boil-water notice). Supports communication history analysis.',
    `notes` STRING COMMENT 'Free-text notes or comments about this contact record. May include special handling instructions, customer preferences, or historical context.',
    `opt_in_billing` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive billing-related communications through this contact channel. Supports compliance with communication preference regulations.',
    `opt_in_emergency` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive emergency alerts (e.g., boil-water notices, water quality advisories, Sanitary Sewer Overflow (SSO) notifications) through this contact channel. Typically defaults to true for critical public health communications.',
    `opt_in_marketing` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive marketing and promotional communications (e.g., conservation programs, new service offerings) through this contact channel.',
    `opt_in_service` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive service-related communications (e.g., planned outages, maintenance notifications) through this contact channel.',
    `opt_out_date` DATE COMMENT 'Date when the customer opted out of communications through this contact channel. Null if customer has not opted out. Used for compliance reporting and communication suppression.',
    `opt_out_reason` STRING COMMENT 'Free-text reason provided by customer for opting out of communications. Supports customer experience analysis and communication strategy improvement.',
    `quality_score` DECIMAL(18,2) COMMENT 'Data quality score for this contact record (0.00 to 100.00). Calculated based on verification status, recency, completeness, and delivery success rate. Used to prioritize contact data cleansing efforts.',
    `source_system` STRING COMMENT 'Name of the system that originally created or provided this contact record (e.g., Oracle CC&B, Microsoft Dynamics 365 CRM, Customer Portal, Manual Entry). Supports data lineage and integration troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier for this contact in the source system. Enables traceability back to the system of record and supports data reconciliation.',
    `time_zone` STRING COMMENT 'Time zone associated with this contact location (e.g., America/New_York, America/Los_Angeles). Used to schedule communications at appropriate local times and comply with TCPA calling hour restrictions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was last modified. Supports change tracking and data quality monitoring.',
    `verification_date` DATE COMMENT 'Date when this contact information was last verified. Used to track data quality and trigger re-verification workflows for stale contact data.',
    `verification_method` STRING COMMENT 'Method used to verify this contact information. Tracks how the contact was validated to support audit and data quality reporting.. Valid values are `email_link|sms_code|postal_mail|phone_call|in_person|system_import`',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Master record of all contact points, communication preferences, and third-party notification arrangements associated with a customer account or person. Captures contact type (billing, service, emergency, legal notice, third-party notification), contact value, contact channel (phone/email/SMS/postal/portal), is_primary flag, is_verified flag, verification date, opt-in/opt-out status per communication channel, preferred language, notification trigger type (for third-party arrangements: pre-disconnect, outage, boil-water notice), ADA accommodation flags (large print, braille, TTY), relationship to account holder (for third-party contacts), effective date range, and consent documentation reference. Supports multi-channel customer communications including CCR delivery, boil-water notices, outage notifications, TCPA/CAN-SPAM compliance, EPA CCR electronic delivery rules, and state PUC consumer protection rules for third-party notification before disconnection.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` (
    `assistance_enrollment_id` BIGINT COMMENT 'Unique identifier for the customer_assistance_enrollment data product (auto-inserted pre-linking).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Low-income assistance and lead service line replacement programs in water utilities are administered by approved third-party vendors (plumbers, contractors). Tracking which vendor administers each enr',
    `affordability_plan_id` BIGINT COMMENT 'Foreign key linking to service.affordability_plan. Business justification: Enrollments must reference which affordability plan (discount percentage, eligibility thresholds, benefit duration) applies. Required for billing discount calculation, recertification tracking, regula',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Assistance program enrollments (LIHWAP, rate assistance, bill credits) are applied to a specific billing account where the discount or credit is posted. Linking enrollment to billing account is essent',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assistance programs are administered by specific departments tracked as cost centers. Water utilities allocate assistance program costs to cost centers for budget variance reporting, grant compliance ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Assistance program costs allocated to specific funds (often separate assistance fund or general fund subsidy). Essential for rate case cost-of-service studies and regulatory reporting of assistance pr',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Low-income assistance enrollments funded by specific federal/state grants (LIHWAP, LIHEAP, utility assistance programs). Required for grant expenditure tracking, compliance reporting, and reimbursemen',
    `primary_assistance_program_affordability_plan_id` BIGINT COMMENT 'Foreign key linking to customer.assistance_program. Business justification: Enrollment records must reference the assistance program they enroll in; adds inbound to assistance_program and outbound from enrollment.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Assistance program enrollments may apply to specific service agreements rather than entire accounts. This allows agreement-level benefit tracking for accounts with multiple services. Nullable as some ',
    CONSTRAINT pk_assistance_enrollment PRIMARY KEY(`assistance_enrollment_id`)
) COMMENT 'Transactional record of a customer accounts enrollment in a utility assistance or affordability program. Captures enrollment date, expiration date, recertification due date, enrollment status (active, expired, suspended, pending recertification), benefit amount applied, income verification method, household size at enrollment, and the certifying agent. Tracks the full lifecycle of assistance program participation per account. Required for state public utilities commission reporting on affordability program reach and expenditure.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for each customer interaction record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Customer interactions (calls about billing, service changes, rate inquiries) are conducted in the context of a specific service agreement. Required for interaction context, agent efficiency, SLA track',
    `case_id` BIGINT COMMENT 'Foreign key linking to customer.case. Business justification: The interaction table currently stores case_number as a STRING denormalized attribute. The case product exists in the customer domain with case_id as its PK. Replacing case_number (STRING) with case_i',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Customer inquiries about planned/ongoing CIP work in their area (timeline questions, service interruption notices, construction updates). Essential for public outreach tracking, stakeholder communicat',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Customer interactions may report violations or document utility response to violation-related inquiries—customer service and regulatory documentation requirement for tracking public complaints and res',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: An interaction occurs through a specific contact channel/record (e.g., a specific phone number, email address, or portal account). The contact product in the customer domain represents these contact p',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Customer interactions capture contact details that should reference the person master when the contact is a known person. This eliminates duplication of person contact information. Nullable as some in',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this interaction. Links to the customer account master record.',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Customer reports about hydrant problems (leaking, damaged, blocked access, vandalism) reference specific hydrant assets. Enables tracking of public-reported hydrant defects, prioritizing inspection/re',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customer service interactions frequently reference a specific invoice (billing inquiry, high-bill call, dispute initiation). Linking interaction to invoice supports call center first-contact resolutio',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Customer service agents handling outage calls must reference the causative main break event. Interaction already links to hydrant and network_valve; main_break_id enables agents to see real-time break',
    `network_valve_id` BIGINT COMMENT 'Foreign key linking to distribution.network_valve. Business justification: Customer reports about valve issues (leaking valve box, exposed valve, damaged cover) reference specific valve assets. Enables public-sourced defect identification, prioritizes valve maintenance, and ',
    `order_id` BIGINT COMMENT 'Reference to a service request created as a result of this interaction. Null if no service request was generated.',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: Interactions capture customer reports of overflow events or utility communication about events affecting customers—event documentation and public notification tracking required for regulatory complian',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Customer service interactions about payment arrangement enrollment, modification, or compliance reference a specific payment plan. Call center agents need this link for hardship assistance tracking, l',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: Interactions about meter reads, service point access, AMI device issues, or connection problems reference a specific service point. Required for field service dispatch, meter investigation tracking, a',
    `premise_id` BIGINT COMMENT 'Reference to the premise associated with this interaction. Null if interaction is not premise-specific.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address associated with this interaction. Null if interaction is not address-specific.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Customer interactions may pertain to specific service agreements (e.g., questions about a particular service). This enables agreement-level interaction tracking. Nullable as some interactions are acco',
    `work_order_id` BIGINT COMMENT 'Reference to a work order created as a result of this interaction. Null if no work order was generated.',
    `accessibility_accommodation` STRING COMMENT 'Description of any accessibility accommodations provided during the interaction (e.g., TTY, large print, sign language). Null if no accommodation was required.',
    `agent_name` STRING COMMENT 'Full name of the customer service agent who handled the interaction. Null for self-service interactions.',
    `callback_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the requested callback was completed. Null if callback was not requested or not yet completed.',
    `callback_requested_flag` BOOLEAN COMMENT 'Indicates whether the customer requested a callback from the utility.',
    `channel` STRING COMMENT 'Channel through which the interaction occurred: inbound call, outbound call, web portal, mobile app, email, chat, walk-in visit, IVR self-service, or SMS. [ENUM-REF-CANDIDATE: inbound_call|outbound_call|web_portal|mobile_app|email|chat|walk_in|ivr|sms — 9 candidates stripped; promote to reference product]',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was formally closed. Null if interaction is not yet closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction record was first created in the system.',
    `customer_satisfaction_score` STRING COMMENT 'Customer satisfaction rating provided by the customer after the interaction, typically on a scale of 1 to 5. Null if not captured.',
    `duration_seconds` STRING COMMENT 'Total duration of the interaction in seconds, applicable primarily to call and chat channels. Null for asynchronous channels like email.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the interaction was escalated to a supervisor, specialist, or higher tier of support.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the interaction, such as complex technical issue, customer dissatisfaction, or policy exception required. Null if not escalated.',
    `first_contact_resolution_flag` BOOLEAN COMMENT 'Indicates whether the interaction was resolved during the first contact without requiring follow-up. Key customer service performance indicator.',
    `interaction_category` STRING COMMENT 'High-level category grouping for the interaction type, used for reporting and analytics (e.g., billing, service delivery, water quality, account management).',
    `interaction_description` STRING COMMENT 'Detailed narrative description of the interaction, including customer inquiry, issue reported, and any relevant context provided by the customer or agent.',
    `interaction_number` STRING COMMENT 'Business-facing unique identifier for the interaction, used for tracking and reference in customer communications.. Valid values are `^INT-[0-9]{10}$`',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the interaction: open, in progress, pending customer response, pending internal action, resolved, closed, or cancelled. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_internal|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `interaction_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was initiated or received by the utility. Primary business event timestamp for the interaction.',
    `interaction_type` STRING COMMENT 'Classification of the interaction purpose: billing inquiry, service request, complaint, outage report, payment arrangement, or general inquiry.. Valid values are `billing_inquiry|service_request|complaint|outage_report|payment_arrangement|general_inquiry`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required or used during the interaction.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language used during the interaction. [ENUM-REF-CANDIDATE: ENG|SPA|FRE|CHI|VIE|KOR|RUS|ARA|POR|GER — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction record was last updated or modified.',
    `net_promoter_score` STRING COMMENT 'Net Promoter Score provided by the customer, typically on a scale of 0 to 10, measuring likelihood to recommend the utility. Null if not captured.',
    `priority` STRING COMMENT 'Priority level assigned to the interaction based on urgency and impact: low, medium, high, urgent, or critical.. Valid values are `low|medium|high|urgent|critical`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution provided, actions taken, and any follow-up required. Populated when interaction is resolved or closed.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was marked as resolved. Null if interaction is still open or in progress.',
    `source_system` STRING COMMENT 'System of record where the interaction was originally captured: Dynamics 365 CRM, Oracle CC&B, IVR, web portal, mobile app, or email system.. Valid values are `dynamics_365|oracle_ccb|ivr|web_portal|mobile_app|email_system`',
    `source_system_code` STRING COMMENT 'Unique identifier of the interaction record in the source system, used for traceability and reconciliation.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the interaction category, providing granular classification for analytics (e.g., high bill inquiry, leak report, water pressure issue).',
    `subject` STRING COMMENT 'Brief subject or title summarizing the purpose or topic of the interaction.',
    `survey_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer completed a post-interaction satisfaction survey.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Unified record of every customer-initiated or utility-initiated interaction, contact, and account note across all channels — inbound calls, outbound calls, web portal sessions, chat, email, walk-in visits, IVR self-service, and system-generated notes. Captures interaction date and time, channel, interaction type (billing inquiry, service request, complaint, outage report, payment arrangement, general inquiry, staff note, system alert), record subtype (structured interaction vs free-text note), duration, agent ID, note text (for unstructured entries), note visibility level (internal/external), resolution status, case or work order reference, workflow trigger flag, and customer satisfaction score if captured. Sourced from Microsoft Dynamics 365 CRM and Oracle CC&B. SSOT for all customer contact history and account annotations. Supports customer service continuity, dispute resolution, and field crew awareness (e.g., dangerous dog, locked gate, medical equipment dependency).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Unique identifier for the customer complaint record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Complaints (billing disputes, service quality, SLA breaches) are filed against a specific service agreement. Required for regulatory complaint tracking, SLA breach analysis, and billing dispute resolu',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: LCRR and water quality regulations require complaints about lead service lines, meter accuracy, and infrastructure to reference the specific asset registry record. This enables regulatory complaint-to',
    `case_id` BIGINT COMMENT 'Foreign key linking to customer.case. Business justification: Customer complaints in water utilities frequently generate or are linked to formal cases for tracking and resolution. The case product in the customer domain is the appropriate parent for escalated co',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Complaints during construction (noise, access disruption, water discoloration during commissioning) must be tracked against the causing project for resolution, public relations, and project closeout d',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this complaint.',
    `complaint_customer_customer_account_id` BIGINT COMMENT 'Reference to the customer who filed the complaint.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Water quality complaints are categorized by suspected contaminant (lead, chlorine, turbidity, coliform) for LCRR compliance, CCR reporting, and public notification triggers. Linking complaint to conta',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Aggregating complaints by DMA reveals water loss patterns, quality issues, and pressure problems at the zone level. Supports NRW reduction programs, leak detection prioritization, and proactive main r',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customer complaints about billing errors, high bills, or estimated reads reference a specific invoice. Complaint investigation, billing adjustment processing, and regulatory reporting (PUC complaint t',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Complaints about outages, discolored water, and low pressure are frequently caused by main breaks. Linking complaints to main breaks enables root cause analysis, regulatory reporting (CCR), and custom',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to customer.interaction. Business justification: A customer complaint is typically filed during or as a result of a customer interaction (e.g., a phone call, web submission, or in-person visit). The complaint should reference the originating interac',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: Customer complaints reporting sewage backups, odors, or surface discharge are primary detection mechanism for SSO/CSO events—operational reality requiring documented linkage for regulatory reporting.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Water quality complaints (taste, odor, discoloration, pressure) routinely reference the specific distribution main where the issue originates. Operations teams use this for targeted flushing, leak det',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: Complaints about meter accuracy, AMI device errors, service point access, or connection quality require direct reference to the service point for investigation, regulatory reporting, and corrective ac',
    `premise_id` BIGINT COMMENT 'Reference to the premise associated with the complaint.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Pressure-related complaints must reference the pressure zone for operational dispatch and system performance analysis. Enables zone-level complaint trending, identifies chronic low-pressure areas, and',
    `order_id` BIGINT COMMENT 'Reference to the service order created to address customer-facing service actions related to the complaint, such as meter test, service reconnection, or billing adjustment.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to address the physical or operational issue underlying the complaint, such as a repair, inspection, or maintenance activity in IBM Maximo Asset Management (CMMS).',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Complaints capture reporter details that should reference the person master when the reporter is a known person. This eliminates duplication and enables proper reporter tracking. Nullable as some comp',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Water utility complaint investigations (water quality, service disruption, infrastructure damage) must identify the responsible vendor (chemical supplier, contractor, equipment vendor) for root cause ',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the complaint issue is occurring.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Complaints may relate to specific service agreements (e.g., billing disputes for a particular service type). This provides more granular complaint tracking for accounts with multiple agreements. Nulla',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: LCRR regulations require utilities to track complaints related to specific lead service lines. Complaints about low pressure, discolored water, or service line leaks must be linked to the physical ser',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: Sewer backup, odor, and overflow complaints are routed to specific sewer network segments for investigation and maintenance prioritization. This mirrors the existing pipe_main_id pattern for water com',
    `treatment_violation_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_violation. Business justification: Water quality complaints (taste, odor, discoloration) are directly linked to treatment violations for CCR public notification compliance, regulatory response tracking, and root-cause documentation. A ',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Water quality complaints triggering investigative sampling (water_quality_test_required_flag=true) must be traceable to the resulting water_sample for regulatory response documentation and complaint r',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: Water quality complaint management requires correlating complaint clusters (taste, odor, discoloration, health) to the serving water system for root cause analysis, CCR reporting, and regulatory escal',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Water quality complaints require facility-specific investigation and operator response. Linking complaints to serving facility enables proper routing to facility operators, coordinated sampling, and f',
    `actual_resolution_date` DATE COMMENT 'Actual date when the complaint was resolved and closed.',
    `assigned_date` DATE COMMENT 'Date when the complaint was assigned to a resolution owner.',
    `assigned_to_department` STRING COMMENT 'Department or functional area responsible for resolving the complaint, such as Customer Service, Water Quality, Distribution Operations and Maintenance (O&M), Billing, or Laboratory.',
    `billing_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of billing adjustment or credit issued to the customer as a result of the complaint resolution, if applicable.',
    `compensation_provided_flag` BOOLEAN COMMENT 'Indicates whether any form of compensation, credit, or goodwill gesture was provided to the customer as part of the complaint resolution.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type. Water quality includes turbidity, discoloration, and contaminant concerns. Billing disputes cover charges, meter reads, and rate application. Service interruption includes planned and unplanned outages. Pressure issues cover low or high Pounds per Square Inch (PSI). Regulatory complaints are those escalated to state primacy agencies or Public Utilities Commission (PUC). [ENUM-REF-CANDIDATE: water_quality|billing_dispute|service_interruption|pressure_issue|odor_taste|leak|meter_accuracy|customer_service|regulatory|other — 10 candidates stripped; promote to reference product]',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the customer, including symptoms, duration, and customer concerns.',
    `complaint_number` STRING COMMENT 'Externally visible unique complaint tracking number assigned by the Customer Information System (CIS) or Customer Care and Billing (CC&B) system.',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint in the resolution workflow. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_investigation|resolved|closed|escalated|withdrawn — 8 candidates stripped; promote to reference product]',
    `contact_method` STRING COMMENT 'Channel through which the complaint was received by the utility. [ENUM-REF-CANDIDATE: phone|email|web_portal|mobile_app|in_person|mail|social_media — 7 candidates stripped; promote to reference product]',
    `corrective_action` STRING COMMENT 'Specific corrective action taken to address the root cause and prevent recurrence, such as infrastructure repair, meter replacement, billing adjustment, or process improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was first created in the database.',
    `customer_satisfaction_comments` STRING COMMENT 'Free-text feedback provided by the customer regarding their satisfaction with the complaint resolution process and outcome.',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction score provided by the customer after complaint resolution, typically on a scale of 1 to 5 or 1 to 10.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up action or customer contact to verify sustained resolution.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action or monitoring is required after initial complaint resolution.',
    `internal_notes` STRING COMMENT 'Internal notes and comments for staff use, not visible to the customer, documenting investigation steps, coordination with other departments, and operational context.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was last updated.',
    `priority_level` STRING COMMENT 'Urgency classification of the complaint based on health and safety risk, regulatory exposure, and customer impact. Critical includes Maximum Contaminant Level (MCL) exceedances and Sanitary Sewer Overflow (SSO) events.. Valid values are `critical|high|medium|low`',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency involved if the complaint was escalated, such as state Department of Environmental Quality, Public Utilities Commission (PUC), or U.S. Environmental Protection Agency (EPA).',
    `regulatory_case_number` STRING COMMENT 'Case or reference number assigned by the regulatory agency for tracking the escalated complaint.',
    `regulatory_escalation_flag` BOOLEAN COMMENT 'Indicates whether the complaint was escalated to or originated from a regulatory agency such as state primacy agency, Public Utilities Commission (PUC), or U.S. Environmental Protection Agency (EPA).',
    `regulatory_response_due_date` DATE COMMENT 'Date by which the utility must provide a formal response to the regulatory agency regarding the escalated complaint.',
    `reported_date` DATE COMMENT 'Date when the complaint was first reported to the utility by the customer.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise date and time when the complaint was logged into the system, including time zone offset.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the actions taken to resolve the complaint, including investigation findings, corrective actions, and customer communication.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the complaint was marked as resolved, including time zone offset.',
    `root_cause` STRING COMMENT 'Identified root cause of the complaint issue, such as main break, meter malfunction, billing system error, water treatment process deviation, or customer misunderstanding.',
    `subcategory` STRING COMMENT 'Detailed subcategory providing additional classification granularity within the primary complaint category. Examples: discoloration, chlorine_odor, high_bill, estimated_read, low_pressure, no_water, meter_leak, service_attitude.',
    `target_resolution_date` DATE COMMENT 'Target date by which the complaint should be resolved, based on Service Level Agreement (SLA) commitments and regulatory requirements.',
    `water_quality_test_required_flag` BOOLEAN COMMENT 'Indicates whether a water quality test was required or performed as part of the complaint investigation, particularly for complaints involving taste, odor, discoloration, or suspected contamination.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Formal record of a customer complaint or grievance filed with the utility, including water quality complaints, billing disputes, service interruption complaints, pressure complaints, odor/taste complaints, and regulatory complaints escalated to the state primacy agency or PUC. Captures complaint number, complaint category, complaint description, reported date, assigned resolution owner, target resolution date, actual resolution date, resolution description, regulatory escalation flag, and customer satisfaction outcome. Distinct from customer_interaction (which captures all contacts) — a complaint has its own formal resolution workflow and regulatory reporting obligations.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`parcel` (
    `parcel_id` BIGINT COMMENT 'Primary key for parcel',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Parcels are acquired, encumbered with easements, or impacted by CIP projects for pipeline installation, pump station construction, or right-of-way. Water utilities track which CIP project requires or ',
    `parent_parcel_id` BIGINT COMMENT 'Self-referencing FK on parcel (parent_parcel_id)',
    `acquisition_date` DATE COMMENT 'Date the parcel was acquired by the current owner.',
    `address_line1` STRING COMMENT 'Primary street address of the parcel.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite, unit).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total land area of the parcel in square feet.',
    `cadastral_reference` STRING COMMENT 'Official cadastral registry identifier for the parcel.',
    `city` STRING COMMENT 'Municipality where the parcel is located.',
    `county` STRING COMMENT 'County jurisdiction of the parcel.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the parcel record was first created in the system.',
    `disposition_date` DATE COMMENT 'Date the parcel was transferred or disposed.',
    `geometry_wkt` STRING COMMENT 'Well-Known Text representation of the parcels spatial geometry.',
    `is_historical` BOOLEAN COMMENT 'Indicates whether the record represents a historical (true) or current (false) parcel.',
    `land_use_description` STRING COMMENT 'Narrative description of the parcels land use.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the parcel record.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the parcel centroid.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the parcel centroid.',
    `owner_contact_phone` STRING COMMENT 'Primary phone number for the parcel owner.',
    `owner_email` STRING COMMENT 'Primary email address for the parcel owner.',
    `owner_name` STRING COMMENT 'Name of the individual or entity that owns the parcel.',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the parcel.',
    `parcel_number` STRING COMMENT 'Human-readable parcel number used in field operations.',
    `parcel_status` STRING COMMENT 'Current lifecycle status of the parcel.',
    `parcel_type` STRING COMMENT 'Category of the parcel based on land use and zoning.',
    `source_system` STRING COMMENT 'Originating source system that supplied the parcel data.',
    `state` STRING COMMENT 'State or province code where the parcel is located.',
    `tax_assessed_value` DECIMAL(18,2) COMMENT 'Assessed value of the parcel for property tax purposes.',
    `tax_assessment_year` STRING COMMENT 'Fiscal year of the tax assessment.',
    `valuation_usd` DECIMAL(18,2) COMMENT 'Assessed monetary value of the parcel in US dollars.',
    `zip_code` STRING COMMENT 'Postal code for the parcel location.',
    `zoning_code` STRING COMMENT 'Regulatory zoning classification code for the parcel.',
    CONSTRAINT pk_parcel PRIMARY KEY(`parcel_id`)
) COMMENT 'Master reference table for parcel. Referenced by parcel_id.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`customer`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for case',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Cases (billing disputes, service quality complaints, SLA breach claims) are raised against a specific service agreement. Required for billing dispute resolution, SLA breach analysis, and regulatory co',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Water utilities link customer cases (service disruptions, infrastructure complaints, construction impacts) to the CIP project causing or resolving the issue. This supports project impact reporting, cu',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who raised the case.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customer cases (billing disputes, service issues) frequently reference a specific invoice as the subject of the case. Case management in water utilities requires invoice linkage for resolution trackin',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Customer service disruption cases are opened in response to main breaks. Utilities link cases to causative main break events for SLA tracking, root cause reporting, and regulatory customer notificatio',
    `order_id` BIGINT COMMENT 'Foreign key linking to service.order. Business justification: Customer cases (service disruptions, quality complaints) generate service orders for field resolution. Linking case to the fulfilling service order enables case closure tracking, SLA compliance measur',
    `parent_case_id` BIGINT COMMENT 'Self-referencing FK on case (parent_case_id)',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: A case is typically initiated by or associated with a specific person (the account holder, co-applicant, or authorized representative who filed or is the subject of the case). Adding person_id to case',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Cases in water utilities are often location-specific — water quality complaints, service outages, and infrastructure issues are tied to a physical premise. Adding premise_id to case enables spatial an',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Cases may be associated with a specific service address (the physical delivery point) independent of the premise. This supports address-level case analysis and geographic reporting. No existing FK fro',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Cases in water utilities are frequently tied to a specific service agreement — billing disputes, service quality issues, and account adjustments all occur in the context of a service agreement. Adding',
    `treatment_violation_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_violation. Business justification: Formal customer cases for public notification, regulatory escalation, or CCR inquiries must reference the underlying treatment violation. Water utility domain experts expect this link for public notif',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Customer service cases (low pressure, water quality, meter disputes) are resolved by specific work orders. Water utility customer service operations require direct case-to-work-order traceability for ',
    `assigned_department` STRING COMMENT 'Internal department responsible for handling the case.',
    `case_number` STRING COMMENT 'Human‑readable case number used in customer communications and internal tracking.',
    `case_status` STRING COMMENT 'Current lifecycle state of the case.',
    `case_type` STRING COMMENT 'Category of the case indicating the nature of the request or issue.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Base monetary amount associated with the case before taxes, fees, or discounts.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date‑time when the case was marked as closed or resolved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case record was first persisted in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date‑time when the case was initially created by the customer or system.',
    `priority` STRING COMMENT 'Urgency level assigned to the case for handling and SLA purposes.',
    `resolution_description` STRING COMMENT 'Narrative description of how the case was resolved.',
    `sla_met` BOOLEAN COMMENT 'True if the case was resolved within the SLA target timeframe.',
    `sla_target_hours` STRING COMMENT 'Maximum number of hours allowed to resolve the case per service level agreement.',
    `source_channel` STRING COMMENT 'Channel through which the case was submitted.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the charge amount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes, fees, and discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the case record.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Master reference table for case. Referenced by case_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `water_utilities_ecm`.`customer`.`organization`(`organization_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `water_utilities_ecm`.`customer`.`organization`(`organization_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `water_utilities_ecm`.`customer`.`parcel`(`parcel_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_application_id` FOREIGN KEY (`service_application_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_application`(`service_application_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ADD CONSTRAINT `fk_customer_account_person_rel_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ADD CONSTRAINT `fk_customer_account_person_rel_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_contact_customer_customer_account_id` FOREIGN KEY (`contact_customer_customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_case_id` FOREIGN KEY (`case_id`) REFERENCES `water_utilities_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `water_utilities_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_case_id` FOREIGN KEY (`case_id`) REFERENCES `water_utilities_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_complaint_customer_customer_account_id` FOREIGN KEY (`complaint_customer_customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `water_utilities_ecm`.`customer`.`interaction`(`interaction_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ADD CONSTRAINT `fk_customer_parcel_parent_parcel_id` FOREIGN KEY (`parent_parcel_id`) REFERENCES `water_utilities_ecm`.`customer`.`parcel`(`parcel_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_parent_case_id` FOREIGN KEY (`parent_case_id`) REFERENCES `water_utilities_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `water_utilities_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_account');
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person Identifier');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `autopay_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrollment Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `autopay_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrollment Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `credit_check_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Consent Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `credit_check_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Consent Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|small_commercial|large_commercial|industrial|municipal|agricultural');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `data_sharing_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `disability_accommodation_notes` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `disability_accommodation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `government_id_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Expiration Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `government_id_issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Issuing State');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Number (Masked)');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_value_regex' = 'drivers_license|state_id|passport|military_id|tribal_id|ssn');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `identity_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'in_person|online|mail|third_party_service');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_required');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `life_support_equipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Support Equipment Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `life_support_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Life Support Verification Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `low_income_assistance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Eligible Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `low_income_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Low Income Verification Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `marketing_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `paperless_billing_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Enrollment Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `person_status` SET TAGS ('dbx_business_glossary_term' = 'Person Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `person_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|merged|duplicate');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `person_type` SET TAGS ('dbx_business_glossary_term' = 'Person Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `person_type` SET TAGS ('dbx_value_regex' = 'account_holder|co_applicant|authorized_contact|guarantor|emergency_contact|property_owner');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|portal');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_value_regex' = 'mobile|home|work|other');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `senior_citizen_flag` SET TAGS ('dbx_business_glossary_term' = 'Senior Citizen Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Range');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_value_regex' = 'under_1m|1m_to_10m|10m_to_50m|50m_to_100m|over_100m|unknown');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `auto_pay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enrolled Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `credit_tier` SET TAGS ('dbx_business_glossary_term' = 'Credit Tier Classification');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `credit_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|unrated');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `credit_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'commercial|industrial|municipal|institutional|agricultural|government');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Range');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Employer Identification Number (EIN)');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `industrial_user_classification` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Classification');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `industrial_user_classification` SET TAGS ('dbx_value_regex' = 'categorical|significant|non_significant|not_applicable');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `industrial_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `iup_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Expiration Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `iup_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Organization Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'corporation|llc|partnership|municipality|hoa|government_agency');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?1?d{10,15}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `special_billing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Billing Instructions');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Organization Website URL');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_business_glossary_term' = 'Address End Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_business_glossary_term' = 'Address Source System');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|corrected|invalid');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Assessor Parcel Number (APN)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `flood_zone_designation` SET TAGS ('dbx_business_glossary_term' = 'Flood Zone Designation');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `meter_location_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Location Description');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'occupied|vacant|seasonal|under_construction');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP+4)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'water_only|wastewater_only|water_and_wastewater|stormwater|reclaimed_water');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `sewer_basin` SET TAGS ('dbx_business_glossary_term' = 'Sewer Basin');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_business_glossary_term' = 'Standardized Address');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ALTER COLUMN `within_service_boundary_flag` SET TAGS ('dbx_business_glossary_term' = 'Within Service Boundary Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `backflow_prevention_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `building_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Building Square Footage');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `connection_fee_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Paid Amount');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `connection_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Paid Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `district_metered_area_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `district_metered_area_code` SET TAGS ('dbx_value_regex' = '^DMA-[A-Z0-9]{3,10}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `estimated_daily_demand_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Daily Demand (Gallons)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `fats_oils_grease_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Fats Oils and Grease (FOG) Program Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `fire_protection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `industrial_user_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `lot_size_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Square Feet)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `low_income_assistance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Eligible Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size (Inches)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `parcel_number` SET TAGS ('dbx_business_glossary_term' = 'Parcel Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `parcel_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `peak_demand_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (Gallons Per Minute - GPM)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `premise_number` SET TAGS ('dbx_business_glossary_term' = 'Premise Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `premise_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_business_glossary_term' = 'Premise Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_construction|demolished|condemned|seasonal');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `premise_type` SET TAGS ('dbx_value_regex' = 'single_family_residential|multi_family_residential|commercial|industrial|irrigation|fire_protection');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_value_regex' = '^PZ-[A-Z0-9]{2,8}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `reclaimed_water_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Reclaimed Water Service Available Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `service_line_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Service Line Diameter (Inches)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `service_line_material` SET TAGS ('dbx_business_glossary_term' = 'Service Line Material');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `sewer_lateral_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Sewer Lateral Diameter (Inches)');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `sewer_lateral_material` SET TAGS ('dbx_business_glossary_term' = 'Sewer Lateral Material');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `sewer_lateral_material` SET TAGS ('dbx_value_regex' = 'vitrified_clay|cast_iron|pvc|concrete|orangeburg|unknown');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `special_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `stormwater_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Service Available Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `wastewater_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Service Available Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `water_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Service Available Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification');
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}-[0-9]{1,2}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_service_agreement');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `pretreatment_iup_id` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Iup Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_application_id` SET TAGS ('dbx_business_glossary_term' = 'Service Application Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `account_person_rel_id` SET TAGS ('dbx_business_glossary_term' = 'Account Person Relationship ID');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person ID');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirements');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `authorization_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Document Reference');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `billing_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Authority Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `ccr_delivery_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Delivery Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `emergency_contact_priority` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Priority');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `financial_responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Financial Responsibility Percentage');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `landlord_tenant_indicator` SET TAGS ('dbx_business_glossary_term' = 'Landlord Tenant Indicator');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `landlord_tenant_indicator` SET TAGS ('dbx_value_regex' = 'landlord|tenant|owner_occupant|property_manager|not_applicable');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `lcrr_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Notification Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|portal|none');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `relationship_notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'primary_account_holder|co_applicant|authorized_representative|emergency_contact|third_party_notification|property_manager');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `service_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Authorization Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `third_party_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Payer Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'in_person|document_upload|phone_verification|email_verification|third_party_service|notarized_form');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`account_person_rel` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|unverified|verification_failed|expired');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_application_id` SET TAGS ('dbx_business_glossary_term' = 'Service Application ID');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Person Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{8,12}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|rejected|withdrawn|pending_payment');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new_service|transfer|upgrade|downgrade|termination|reconnection');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Application Approval Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Approval Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `connection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Amount');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `credit_check_result` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Result');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `credit_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|insufficient_history|not_applicable');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|waived');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'drivers_license|passport|utility_bill|government_id|credit_report|in_person');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Application Priority Level');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `processing_notes` SET TAGS ('dbx_business_glossary_term' = 'Application Processing Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Application Rejection Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Rejection Reason');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Application Rejection Reason Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'credit_fail|incomplete_docs|service_unavailable|outstanding_balance|duplicate_application|invalid_address');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `requested_service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Start Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Application Review Completed Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Application Review Start Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_class_requested` SET TAGS ('dbx_business_glossary_term' = 'Service Class Requested');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_class_requested` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Service Type Requested');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `service_type_requested` SET TAGS ('dbx_value_regex' = 'water_only|wastewater_only|water_and_wastewater');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Channel');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'online_portal|phone|walk_in|mail|mobile_app|email');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `withdrawn_date` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawn Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ALTER COLUMN `withdrawn_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawn Reason');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Contact Channel');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|sms|postal|portal|fax');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|invalid|pending_verification');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'billing|service|emergency|legal_notice|technical|customer_service');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_business_glossary_term' = 'Contact Value');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `delivery_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Count');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `delivery_success_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Success Count');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `invalid_date` SET TAGS ('dbx_business_glossary_term' = 'Invalid Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `invalid_reason` SET TAGS ('dbx_business_glossary_term' = 'Invalid Reason');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `invalid_reason` SET TAGS ('dbx_value_regex' = 'bounced_email|disconnected_phone|returned_mail|customer_reported|system_validation_failed');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Contact Label');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `last_contact_type` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_billing` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Billing Communications Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_emergency` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Emergency Communications Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_marketing` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Marketing Communications Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_service` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Service Communications Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `opt_out_reason` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Reason');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Contact Quality Score');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email_link|sms_code|postal_mail|phone_call|in_person|system_import');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `assistance_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_assistance_enrollment');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `affordability_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Affordability Plan Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `primary_assistance_program_affordability_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `callback_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Callback Completed Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `callback_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Callback Requested Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Seconds');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `first_contact_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'First Contact Resolution (FCR) Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_category` SET TAGS ('dbx_business_glossary_term' = 'Interaction Category');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_description` SET TAGS ('dbx_business_glossary_term' = 'Interaction Description');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_value_regex' = '^INT-[0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'billing_inquiry|service_request|complaint|outage_report|payment_arrangement|general_inquiry');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `net_promoter_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent|critical');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'dynamics_365|oracle_ccb|ivr|web_portal|mobile_app|email_system');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subcategory');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ALTER COLUMN `survey_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Survey Completed Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Person Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `assigned_to_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Department');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `billing_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Amount');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Provided Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `customer_satisfaction_comments` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Comments');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Escalation Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `regulatory_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Due Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ALTER COLUMN `water_quality_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Test Required Flag');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `parent_parcel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `county` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `parent_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
