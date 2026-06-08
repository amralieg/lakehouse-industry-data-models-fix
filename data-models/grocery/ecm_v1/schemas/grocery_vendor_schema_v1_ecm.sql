-- Schema for Domain: vendor | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:35:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`vendor` COMMENT 'Supplier and vendor master data including CPG manufacturers, produce growers, DSD distributors, private-label co-manufacturers, and category captain designations. Manages vendor profiles, contracts, EDI partner profiles, slotting agreements, performance scorecards (fill rate, on-time delivery), and compliance tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier entity. Primary key for the supplier master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns supplier‑related expenses to a designated cost center for budgeting and variance analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP system defaults payable postings to a supplier‑specific GL account for expense classification and audit trail.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: PROCUREMENT: Assign internal buyer to each supplier for PO approval workflow; essential for supplier performance tracking and contract compliance.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Required for Supplier Compliance Program Enrollment report; suppliers are enrolled in multiple compliance programs (food safety, organic).',
    `business_type` STRING COMMENT 'Primary business classification of the supplier indicating their role in the supply chain. CPG Manufacturer produces consumer packaged goods, Produce Grower supplies fresh produce, DSD Distributor delivers directly to stores, Private Label Co-Manufacturer produces store-brand products, Specialty Supplier provides niche products, Service Provider offers non-product services.. Valid values are `cpg_manufacturer|produce_grower|dsd_distributor|private_label_comanufacturer|specialty_supplier|service_provider`',
    `category_captain_flag` BOOLEAN COMMENT 'Indicates whether the supplier is designated as a category captain, providing category management insights, planogram recommendations, and market intelligence for their product category.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was first created in the system. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for transactions with this supplier (e.g., USD, CAD, MXN). Used for invoice processing and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `dba_name` STRING COMMENT 'Trade name or DBA name under which the supplier operates if different from legal name. Used for marketing and operational purposes.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether the supplier delivers products directly to retail stores bypassing the distribution center. Common for bread, beverages, and snacks.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for credit assessment and supplier verification.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the supplier has EDI capability for electronic exchange of purchase orders, invoices, and advance ship notices. Critical for automated supply chain operations.',
    `edi_partner_profile_id` STRING COMMENT 'Unique identifier for the supplier in the EDI network. Used for routing EDI transactions through value-added networks (VANs).',
    `gap_certified_flag` BOOLEAN COMMENT 'Indicates whether the produce supplier holds USDA GAP certification for food safety practices. Required for fresh produce suppliers.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the suppliers legal entity and physical locations. Used for EDI transactions and supply chain traceability.. Valid values are `^[0-9]{13}$`',
    `growing_region` STRING COMMENT 'Primary geographic region where produce is grown (e.g., California Central Valley, Florida, Mexico). Applicable to produce growers for sourcing and traceability.',
    `gtin_prefix` STRING COMMENT 'GS1 company prefix assigned to the supplier for generating GTINs/UPCs for their products. Used for product identification and barcode generation.. Valid values are `^[0-9]{6,12}$`',
    `haccp_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier has HACCP certification for food safety management. Required for suppliers of perishable and high-risk food products.',
    `headquarters_address_line1` STRING COMMENT 'First line of the suppliers headquarters street address. Used for correspondence, legal notices, and supplier verification.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the suppliers headquarters street address (suite, floor, building). Optional field for additional address details.',
    `headquarters_city` STRING COMMENT 'City where the suppliers headquarters is located. Used for geographic analysis and supplier diversity reporting.',
    `headquarters_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the suppliers headquarters location (e.g., USA, CAN, MEX). Used for international trade compliance and reporting.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'ZIP or postal code for the suppliers headquarters address. Format: XXXXX or XXXXX-XXXX for US addresses.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `headquarters_state` STRING COMMENT 'Two-letter state or province code where the suppliers headquarters is located. Used for tax jurisdiction and compliance reporting.. Valid values are `^[A-Z]{2}$`',
    `last_review_date` DATE COMMENT 'Date of the most recent supplier performance review or business review. Used to track review cadence and ensure regular supplier evaluation.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order submission to delivery at distribution center. Used for replenishment planning and inventory management.',
    `legal_name` STRING COMMENT 'The full legal name of the supplier entity as registered with government authorities. Used for contracts, tax reporting, and legal documentation.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for purchase orders. May be expressed in units, cases, or pallets depending on supplier terms.',
    `minority_owned_flag` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a minority-owned business enterprise (MBE). Used for diversity sourcing initiatives and compliance reporting.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next supplier performance review or business review. Used for proactive relationship management and compliance with review policies.',
    `onboarding_date` DATE COMMENT 'Date when the supplier was first onboarded and approved for purchasing. Used for supplier tenure analysis and relationship lifecycle tracking.',
    `organic_acreage` DECIMAL(18,2) COMMENT 'Total acreage of certified organic farmland operated by the produce supplier. Used for capacity planning and organic sourcing strategy.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds USDA organic certification for produce or products. Required for suppliers of organic products.',
    `ownership_structure` STRING COMMENT 'Legal ownership structure of the supplier entity. Impacts contract terms, liability, and financial stability assessment. [ENUM-REF-CANDIDATE: public_corporation|private_corporation|partnership|sole_proprietorship|cooperative|llc|nonprofit — 7 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Defines when payment is due and any early payment discounts available.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the supplier. Used for purchase orders, invoices, and operational communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier organization. Used for operational communication and relationship management.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the supplier. Used for urgent communication and issue resolution.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether the supplier manufactures private-label (store-brand) products for the retailer. Used for private label sourcing and brand management.',
    `seasonal_availability` STRING COMMENT 'Description of seasonal availability windows for produce suppliers (e.g., May-September for berries, Year-round for greenhouse tomatoes). Used for seasonal assortment planning.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates whether the supplier qualifies as a small business under SBA size standards. Used for procurement preferences and compliance reporting.',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier relationship. Active suppliers are approved for purchasing. Inactive suppliers are not currently used but remain in system. Suspended suppliers have temporary holds due to performance or compliance issues. Pending Approval suppliers are undergoing onboarding. Terminated suppliers have ended relationships. Blocked suppliers are prohibited from use due to serious violations.. Valid values are `active|inactive|suspended|pending_approval|terminated|blocked`',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID used for tax reporting and compliance. Format: XX-XXXXXXX.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `termination_date` DATE COMMENT 'Date when the supplier relationship was terminated or contract ended. Null for active suppliers. Used for historical analysis and supplier lifecycle tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was last modified. Used for change tracking and data quality monitoring.',
    `vendor_tier` STRING COMMENT 'Internal classification of supplier based on strategic importance, volume, performance, and relationship strength. Tier 1 Strategic suppliers are critical partners with highest volume and performance. Tier 2 Preferred suppliers meet performance standards. Tier 3 Approved suppliers are qualified but lower volume. Tier 4 Conditional suppliers are on probation or limited use.. Valid values are `tier_1_strategic|tier_2_preferred|tier_3_approved|tier_4_conditional`',
    `veteran_owned_flag` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a veteran-owned business. Used for diversity sourcing initiatives and compliance reporting.',
    `woman_owned_flag` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a woman-owned business enterprise (WBE). Used for diversity sourcing initiatives and compliance reporting.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all vendor and supplier entities including CPG manufacturers, produce growers, DSD distributors, private-label co-manufacturers, and specialty suppliers. Captures legal entity name, DUNS number, tax ID, headquarters address, business type, ownership structure, minority/diversity certification status, EDI capability flag, GTIN prefix, GS1 GLN, payment terms, currency, lead time, vendor tier classification, and active status. This is the Single Source of Truth (SSOT) for vendor identity across the retail-grocery enterprise. Supports produce-specific attributes (growing region, GAP certification, organic acreage, seasonal availability) for agricultural suppliers.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`supplier_contact` (
    `supplier_contact_id` BIGINT COMMENT 'Unique identifier for the supplier contact record. Primary key.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier organization this contact belongs to. Links to the supplier master data.',
    `active_status` STRING COMMENT 'Current lifecycle status of the supplier contact record. Active contacts are included in automated routing and communications.. Valid values are `active|inactive|suspended|terminated`',
    `compliance_notification_flag` BOOLEAN COMMENT 'Indicates whether this contact should receive compliance-related notices including regulatory updates, audit requests, and certification renewals.',
    `contact_first_name` STRING COMMENT 'First name of the supplier contact person.',
    `contact_full_name` STRING COMMENT 'Full legal name of the supplier contact person, combining first and last name.',
    `contact_last_name` STRING COMMENT 'Last name of the supplier contact person.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier contact record was first created in the system.',
    `department` STRING COMMENT 'Department or division within the supplier organization where the contact works.',
    `edi_qualified_flag` BOOLEAN COMMENT 'Indicates whether this contact is qualified and authorized to handle EDI transactions and technical integrations.',
    `effective_end_date` DATE COMMENT 'Date when this contacts authorization ended or will end. Null for currently active contacts.',
    `effective_start_date` DATE COMMENT 'Date when this contact became active and authorized to represent the supplier in business transactions.',
    `email_address` STRING COMMENT 'Primary email address for the supplier contact. Used for automated routing of purchase orders, compliance notices, and quality incident notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_priority` STRING COMMENT 'Priority level for escalating issues to this contact. Primary contacts are reached first, followed by secondary and tertiary contacts.. Valid values are `primary|secondary|tertiary|emergency`',
    `fax_number` STRING COMMENT 'Fax number for the supplier contact, used for formal document transmission when required.',
    `functional_role_type` STRING COMMENT 'Categorization of the contacts functional role within the supplier relationship. Determines routing of communications such as POs, compliance notices, and quality incident notifications. [ENUM-REF-CANDIDATE: account_manager|edi_coordinator|compliance_officer|quality_assurance_lead|category_management_representative|logistics_coordinator|sales_representative|technical_support|billing_specialist|customer_service|operations_manager — promote to reference product]. Valid values are `account_manager|edi_coordinator|compliance_officer|quality_assurance_lead|category_management_representative|logistics_coordinator`',
    `job_title` STRING COMMENT 'Official job title or position of the contact within the supplier organization.',
    `language_preference` STRING COMMENT 'Preferred language for business communications with this contact.',
    `last_contact_date` DATE COMMENT 'Date of the most recent business communication or interaction with this contact.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier contact record was last updated or modified.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the supplier contact, used for urgent communications and escalations.',
    `notes` STRING COMMENT 'Free-form notes and comments about the contact, including special handling instructions, communication preferences, or relationship history.',
    `office_location` STRING COMMENT 'Physical office location or site where the contact is based.',
    `phone_number` STRING COMMENT 'Primary business phone number for the supplier contact.',
    `po_approval_authority_flag` BOOLEAN COMMENT 'Indicates whether this contact has authority to approve and acknowledge purchase orders on behalf of the supplier.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for routine business interactions.. Valid values are `email|phone|mobile|fax|edi|portal`',
    `quality_incident_notification_flag` BOOLEAN COMMENT 'Indicates whether this contact should receive automated notifications for quality incidents and product recalls.',
    `termination_reason` STRING COMMENT 'Reason for terminating or inactivating the contact relationship, such as employee departure, role change, or supplier relationship termination.',
    `time_zone` STRING COMMENT 'Time zone of the contacts primary work location, used for scheduling communications and meetings.',
    CONSTRAINT pk_supplier_contact PRIMARY KEY(`supplier_contact_id`)
) COMMENT 'Individual contacts associated with a supplier organization, including account managers, EDI coordinators, compliance officers, quality assurance leads, and category management representatives. Captures contact name, title, functional role type, phone, email, preferred communication channel, escalation priority, and active status. Supports multi-contact relationships per supplier across different functional roles, enabling automated routing of POs, compliance notices, and quality incident notifications to the correct counterpart.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`supplier_site` (
    `supplier_site_id` BIGINT COMMENT 'Unique identifier for the supplier site. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Site‑level cost allocation enables accurate overhead distribution per distribution center.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: SITE MANAGEMENT: Links site manager employee to supplier site for logistics coordination and SLA monitoring.',
    `supplier_id` BIGINT COMMENT 'Reference to the parent supplier organization that owns or operates this site.',
    `address_line_1` STRING COMMENT 'Primary street address of the supplier site including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number.',
    `capacity_units_per_day` DECIMAL(18,2) COMMENT 'Maximum production or throughput capacity of the supplier site measured in units per day.',
    `city` STRING COMMENT 'City or municipality where the supplier site is located.',
    `cold_chain_capable_flag` BOOLEAN COMMENT 'Indicates whether the supplier site has temperature-controlled storage and handling capabilities for perishable and frozen products.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the supplier site is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier site record was first created in the system.',
    `cross_dock_capable_flag` BOOLEAN COMMENT 'Indicates whether the supplier site supports cross-docking operations for transfer without storage.',
    `dsd_capable_flag` BOOLEAN COMMENT 'Indicates whether the supplier site supports DSD operations for direct delivery to retail stores bypassing distribution centers.',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether the supplier site is configured for EDI transaction processing for purchase orders, advance ship notices, and invoices.',
    `effective_end_date` DATE COMMENT 'Date when the supplier site ceased operations or was decommissioned. Null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when the supplier site became active and operational for sourcing and logistics.',
    `email_address` STRING COMMENT 'Primary email address for operational communication with the supplier site.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the supplier site if applicable for document transmission.',
    `fda_registration_date` DATE COMMENT 'Date when the supplier site was registered with the FDA.',
    `fda_registration_number` STRING COMMENT 'FDA-assigned registration number for food facilities required under the Bioterrorism Act.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical location for EDI transactions and supply chain traceability.. Valid values are `^[0-9]{13}$`',
    `haccp_certification_date` DATE COMMENT 'Date when the supplier site received HACCP certification.',
    `haccp_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier site holds HACCP certification for food safety management.',
    `haccp_expiration_date` DATE COMMENT 'Date when the HACCP certification expires and requires renewal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier site record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supplier site for logistics routing and distance calculations.',
    `lead_time_days` STRING COMMENT 'Standard number of days required from order placement to shipment departure from this supplier site.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supplier site for logistics routing and distance calculations.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the supplier site including days and times when the facility is operational for receiving orders and shipments.',
    `operational_status` STRING COMMENT 'Current operational state of the supplier site indicating whether it is actively fulfilling orders and shipments.. Valid values are `active|inactive|suspended|pending_approval|decommissioned`',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier site is certified to handle or produce organic products under USDA National Organic Program standards.',
    `organic_certifier_name` STRING COMMENT 'Name of the USDA-accredited certifying agent that issued the organic certification.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the supplier site.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supplier site address.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary operational contact person at the supplier site.',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the supplier site.',
    `site_code` STRING COMMENT 'Unique alphanumeric code assigned to the supplier site for identification in procurement and logistics systems.',
    `site_name` STRING COMMENT 'Business name or designation of the supplier site facility.',
    `site_type` STRING COMMENT 'Classification of the supplier site based on its operational function: manufacturing plant, distribution warehouse, DSD (Direct Store Delivery) depot, co-manufacturing facility, processing plant, or cold storage facility.. Valid values are `manufacturing_plant|distribution_warehouse|dsd_depot|co_manufacturing_facility|processing_plant|cold_storage`',
    `state_province` STRING COMMENT 'State, province, or region where the supplier site is located.',
    `temperature_range_max_f` DECIMAL(18,2) COMMENT 'Maximum temperature in Fahrenheit that the site can maintain for cold chain storage.',
    `temperature_range_min_f` DECIMAL(18,2) COMMENT 'Minimum temperature in Fahrenheit that the site can maintain for cold chain storage.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the supplier site location used for scheduling deliveries and coordinating operations.',
    `usda_establishment_number` STRING COMMENT 'USDA-assigned establishment number for facilities that process meat or poultry products.',
    `usda_inspection_status` STRING COMMENT 'Current USDA inspection status for facilities handling meat, poultry, or egg products.. Valid values are `inspected|exempt|pending|suspended|revoked`',
    CONSTRAINT pk_supplier_site PRIMARY KEY(`supplier_site_id`)
) COMMENT 'Physical locations associated with a supplier including manufacturing plants, distribution warehouses, DSD depots, and co-manufacturing facilities. Captures site name, address, site type (plant, warehouse, DSD depot, co-man facility), cold chain capability flag, HACCP certification status, FDA facility registration number, USDA inspection status, and operating hours. Enables sourcing and logistics routing decisions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`trade_agreement` (
    `trade_agreement_id` BIGINT COMMENT 'Unique identifier for the trade agreement. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: AGREEMENT OWNERSHIP: Associates responsible for each trade agreement are needed for renewal alerts and performance tracking.',
    `edi_partner_profile_id` BIGINT COMMENT 'The EDI partner identifier or ISA ID used for electronic transaction exchange with the supplier.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Trade agreement financial impact (rebates, fees) is recorded against a specific GL account for proper accounting.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor party that is the counterparty to this trade agreement.',
    `agreement_type` STRING COMMENT 'Classification of the trade agreement type. [ENUM-REF-CANDIDATE: master_supply_agreement|private_label_co_manufacturing|dsd_distribution_agreement|category_captain_agreement|promotional_agreement|rebate_agreement|slotting_agreement|exclusivity_agreement — promote to reference product]. Valid values are `master_supply_agreement|private_label_co_manufacturing|dsd_distribution_agreement|category_captain_agreement|promotional_agreement|rebate_agreement`',
    `amendment_date` DATE COMMENT 'The date of the most recent amendment to this trade agreement, if applicable.',
    `amendment_description` STRING COMMENT 'Summary description of the most recent amendment or modification made to the trade agreement terms.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiration without requiring explicit renegotiation.',
    `category_captain_flag` BOOLEAN COMMENT 'Indicates whether the supplier is designated as a category captain with strategic planning and assortment advisory responsibilities.',
    `contract_name` STRING COMMENT 'Human-readable name or title of the trade agreement for easy identification and reporting.',
    `contract_number` STRING COMMENT 'The externally-known unique contract number or agreement identifier used for business reference and communication with the supplier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary transactions under this agreement.. Valid values are `^[A-Z]{3}$`',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes Direct Store Delivery terms where the supplier delivers directly to retail locations bypassing the Distribution Center (DC).',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether Electronic Data Interchange is enabled for automated purchase orders, invoices, and shipment notifications under this agreement.',
    `effective_end_date` DATE COMMENT 'The date when the trade agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'The date when the trade agreement becomes legally binding and operational.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants exclusive rights to the supplier for specific categories, products, or geographic regions.',
    `exclusivity_scope` STRING COMMENT 'Description of the scope of exclusivity, including product categories, geographic regions, or channels covered by the exclusivity clause.',
    `execution_date` DATE COMMENT 'The date on which the trade agreement was formally signed and executed by both parties.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade agreement record was most recently updated or modified.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity required per order or per period as stipulated in the agreement.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'The minimum monetary value required per order or per period to maintain agreement terms.',
    `notes` STRING COMMENT 'Free-form notes or comments regarding special terms, conditions, or context relevant to this trade agreement.',
    `payment_method` STRING COMMENT 'The primary payment instrument or method used to settle invoices under this agreement.. Valid values are `ach|wire_transfer|check|edi_payment|credit_card`',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this trade agreement, such as Net 30, Net 60, 2/10 Net 30, or other negotiated terms.',
    `performance_scorecard_required_flag` BOOLEAN COMMENT 'Indicates whether the supplier is subject to regular performance scorecard evaluation including fill rate, on-time delivery, and quality metrics.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this agreement covers private-label or store-brand products manufactured or supplied exclusively for Grocery.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'The percentage rebate rate applicable to purchases under this agreement, if rebate structure is percentage-based.',
    `rebate_structure_type` STRING COMMENT 'Classification of the rebate or incentive structure negotiated in this agreement.. Valid values are `volume_based|growth_based|fixed_amount|tiered|promotional|none`',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that either party must provide notice to prevent auto-renewal or initiate renewal discussions.',
    `signatory_name` STRING COMMENT 'Full name of the authorized signatory from Grocery who executed this trade agreement.',
    `signatory_title` STRING COMMENT 'Job title or role of the authorized signatory from Grocery who executed this trade agreement.',
    `slotting_fee_amount` DECIMAL(18,2) COMMENT 'The one-time or recurring slotting fee paid by the supplier for shelf space allocation and new product introductions.',
    `srp_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether the supplier requires adherence to suggested retail pricing guidelines as part of the agreement terms.',
    `supplier_signatory_name` STRING COMMENT 'Full name of the authorized signatory from the supplier organization who executed this trade agreement.',
    `supplier_signatory_title` STRING COMMENT 'Job title or role of the authorized signatory from the supplier organization who executed this trade agreement.',
    `termination_date` DATE COMMENT 'The actual date on which the trade agreement was terminated prior to its natural expiration, if applicable.',
    `termination_reason` STRING COMMENT 'Business reason or cause for early termination of the trade agreement, such as breach of contract, mutual agreement, or business restructuring.',
    `trade_agreement_status` STRING COMMENT 'Current lifecycle status of the trade agreement indicating its operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Sequential version number of this trade agreement to track amendments and revisions over the contract lifecycle.',
    CONSTRAINT pk_trade_agreement PRIMARY KEY(`trade_agreement_id`)
) COMMENT 'Formal trade agreements between Grocery and its suppliers including master supply agreements, private-label co-manufacturing contracts, DSD distribution agreements, and category captain agreements. Captures contract number, contract type, effective date, expiration date, auto-renewal flag, payment terms, rebate structure, exclusivity clauses, minimum order quantities, SRP compliance requirements, signatory details, and amendment history. Tracks full contract lifecycle from negotiation through amendments, renewals, and expiration with version control for audit compliance.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` (
    `edi_partner_profile_id` BIGINT COMMENT 'Unique identifier for the EDI partner profile record. Primary key.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor master record for which this EDI profile is configured. Links EDI configuration to the vendor entity.',
    `active_status` BOOLEAN COMMENT 'Indicates whether this EDI partner profile is currently active and enabled for message transmission. False if partnership is suspended or terminated.',
    `authentication_method` STRING COMMENT 'Method used to authenticate and authorize EDI message transmission. Certificate-based authentication is common for AS2; SSH keys for SFTP.. Valid values are `Certificate|Username/Password|API Key|OAuth|SSH Key|VAN Credentials`',
    `certificate_expiration_date` DATE COMMENT 'Expiration date of the trading partners digital certificate. Critical for proactive renewal to avoid EDI transmission failures.',
    `certificate_serial_number` STRING COMMENT 'Serial number of the digital certificate used for AS2 encryption and signing. Used to validate partner identity and message integrity.',
    `communication_protocol` STRING COMMENT 'Transport protocol used for EDI message exchange. AS2 provides secure, encrypted transmission over the internet; SFTP/FTPS are file-based; VAN is a third-party value-added network. [ENUM-REF-CANDIDATE: AS2|SFTP|FTPS|VAN|HTTP|HTTPS|API — 7 candidates stripped; promote to reference product]',
    `compliance_validation_level` STRING COMMENT 'Level of EDI message validation applied before transmission. Basic checks syntax only; Standard validates against X12 rules; Strict enforces trading partner-specific business rules.. Valid values are `Basic|Standard|Strict|Custom`',
    `connection_endpoint` STRING COMMENT 'URL, IP address, or hostname used to connect to the trading partners EDI system. May be an AS2 URL, SFTP server address, or VAN mailbox identifier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EDI partner profile record was first created in the system. Audit trail for record creation.',
    `edi_coordinator_email` STRING COMMENT 'Email address of the EDI coordinator for technical communication regarding EDI transmission issues, testing, and configuration changes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `edi_coordinator_name` STRING COMMENT 'Full name of the primary EDI technical contact at the supplier organization responsible for EDI setup, troubleshooting, and maintenance.',
    `edi_coordinator_phone` STRING COMMENT 'Phone number of the EDI coordinator for urgent technical support and escalation of EDI transmission failures.',
    `edi_partner_name` STRING COMMENT 'Business name of the EDI trading partner as registered in the EDI network or VAN directory.',
    `edi_standard` STRING COMMENT 'The EDI messaging standard used for electronic transactions with this partner. ANSI X12 is predominant in North America; EDIFACT is common in Europe and international trade.. Valid values are `ANSI X12|EDIFACT|XML|JSON|CSV|TRADACOMS`',
    `edi_version` STRING COMMENT 'Version of the EDI standard in use (e.g., 4010, 5010 for ANSI X12; D96A, D01B for EDIFACT). Critical for message parsing and compliance.',
    `effective_end_date` DATE COMMENT 'Date when this EDI partner profile configuration was deactivated or superseded. Null for currently active profiles.',
    `effective_start_date` DATE COMMENT 'Date when this EDI partner profile configuration became effective and available for use in production EDI processing.',
    `functional_ack_required_flag` BOOLEAN COMMENT 'Indicates whether this trading partner requires 997 Functional Acknowledgment for every EDI transaction received. True if acknowledgment is mandatory per trading partner agreement.',
    `go_live_date` DATE COMMENT 'Date when the EDI partnership transitioned from test to production status and began processing live business transactions.',
    `gs_receiver_code` STRING COMMENT 'GS03 Application Receiver Code used in ANSI X12 functional group header. Identifies the receiving application or division within Grocery.',
    `gs_sender_code` STRING COMMENT 'GS02 Application Sender Code used in ANSI X12 functional group header. Identifies the sending application or division within the trading partner organization.',
    `inbound_832_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supplier sends 832 Price/Sales Catalog transactions to Grocery. True if supplier provides electronic price updates for item master synchronization.',
    `inbound_850_enabled_flag` BOOLEAN COMMENT 'Indicates whether Grocery sends 850 Purchase Order transactions to this supplier via EDI. True if automated PO transmission is active.',
    `isa_receiver_qualifier` STRING COMMENT 'ISA07 Interchange Receiver ID Qualifier. Defines the type of receiver identifier used by Grocery in the EDI interchange. [ENUM-REF-CANDIDATE: 01|02|08|09|12|14|16|20|27|28|29|30|33|ZZ — 14 candidates stripped; promote to reference product]',
    `isa_sender_qualifier` STRING COMMENT 'ISA05 Interchange Sender ID Qualifier. Defines the type of sender identifier (e.g., 01=DUNS, 12=Phone, 14=UPC, ZZ=Mutually Defined). [ENUM-REF-CANDIDATE: 01|02|08|09|12|14|16|20|27|28|29|30|33|ZZ — 14 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this EDI partner profile record was last updated. Audit trail for tracking configuration changes and troubleshooting.',
    `last_successful_transmission_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful EDI message transmission to or from this partner. Used for monitoring partnership health and detecting transmission failures.',
    `message_retry_count` STRING COMMENT 'Number of automatic retry attempts for failed EDI transmissions before manual intervention is required. Typically 3-5 retries.',
    `notes` STRING COMMENT 'Free-text field for additional EDI configuration notes, special handling instructions, known issues, or trading partner-specific requirements not captured in structured fields.',
    `outbound_810_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supplier sends 810 Invoice transactions to Grocery via EDI. True if electronic invoicing is active for automated accounts payable processing.',
    `outbound_855_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supplier sends 855 PO Acknowledgment transactions back to Grocery. True if supplier confirms orders electronically.',
    `outbound_856_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supplier sends 856 Advance Ship Notice transactions to Grocery. True if supplier provides electronic shipment notifications for warehouse receiving automation.',
    `retry_interval_minutes` STRING COMMENT 'Time interval in minutes between automatic retry attempts for failed EDI transmissions. Common values are 15, 30, or 60 minutes.',
    `supported_transaction_sets` STRING COMMENT 'Comma-separated list of EDI transaction set codes supported by this partner (e.g., 850=Purchase Order, 855=PO Acknowledgment, 856=Advance Ship Notice, 810=Invoice, 832=Price/Sales Catalog, 846=Inventory Inquiry, 997=Functional Acknowledgment). Defines the scope of automated document exchange.',
    `termination_reason` STRING COMMENT 'Business reason for deactivating this EDI partnership (e.g., Supplier Contract Ended, Migrated to API, Technical Issues, Supplier Out of Business). Null for active profiles.',
    `test_production_status` STRING COMMENT 'Current operational status of the EDI partnership. Test indicates initial setup and validation phase; Production indicates live transaction processing; Certification indicates formal compliance testing.. Valid values are `Test|Production|Certification|Inactive`',
    `time_zone` STRING COMMENT 'Time zone used by the trading partner for EDI transmission scheduling and timestamp interpretation (e.g., America/New_York, Europe/London). Critical for coordinating batch windows.',
    `transmission_frequency` STRING COMMENT 'Expected frequency of EDI message transmission for this partner. Real-time for immediate PO transmission; Daily for batch invoice processing; On-demand for ad-hoc transactions.. Valid values are `Real-time|Hourly|Daily|Weekly|On-demand|Batch`',
    `transmission_time_window` STRING COMMENT 'Scheduled time window for batch EDI transmissions (e.g., 02:00-04:00 UTC). Null for real-time or on-demand transmission patterns.',
    `van_mailbox_code` STRING COMMENT 'Unique mailbox identifier assigned by the VAN provider for this trading partner. Used for message routing within the VAN network.',
    `van_provider` STRING COMMENT 'Name of the third-party VAN service provider used for EDI message routing and translation (e.g., SPS Commerce, TrueCommerce, Cleo). Null if direct AS2/SFTP connection is used.',
    CONSTRAINT pk_edi_partner_profile PRIMARY KEY(`edi_partner_profile_id`)
) COMMENT 'EDI (Electronic Data Interchange) configuration and partnership profile for each supplier enabled for electronic transactions. Captures EDI standard (ANSI X12, EDIFACT), ISA/GS identifiers, supported transaction sets (850 PO, 855 PO Acknowledgment, 856 ASN, 810 Invoice, 832 Price Catalog), communication protocol (AS2, SFTP, VAN), test vs. production status, and EDI coordinator contact. Critical for automated PO-to-invoice workflows with CPG and DSD suppliers.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` (
    `vendor_category_captain_id` BIGINT COMMENT 'Unique identifier for the vendor category captain designation record.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: CATEGORY CAPTAIN: Links internal category captain employee to each captain record for pricing, assortment, and planogram decisions.',
    `supplier_id` BIGINT COMMENT 'Reference to the Consumer Packaged Goods (CPG) vendor or manufacturer designated as category captain for this arrangement.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual fee paid to the vendor for category captain services if the compensation model includes a fixed fee component. Expressed in United States Dollars (USD).',
    `antitrust_compliance_acknowledgment` BOOLEAN COMMENT 'Indicates whether the vendor has formally acknowledged and agreed to comply with Federal Trade Commission (FTC) antitrust requirements governing category captain arrangements.',
    `approval_authority` STRING COMMENT 'Name or title of the Grocery executive or role who approved this category captain designation, typically a Vice President of Merchandising or Category Management Director.',
    `approval_date` DATE COMMENT 'Date when the category captain designation was formally approved by Grocery management.',
    `assortment_recommendation_authority` BOOLEAN COMMENT 'Indicates whether the category captain has authority to recommend product assortment changes including Stock Keeping Unit (SKU) additions or deletions.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the category captain designation automatically renews at term end unless either party provides notice of termination.',
    `category_code` STRING COMMENT 'The product category or subcategory code for which this vendor serves as category captain within Grocerys category management program.',
    `compensation_model` STRING COMMENT 'Type of compensation arrangement for category captain services, which may include fixed fees, performance incentives, or no direct compensation with indirect benefits.. Valid values are `fee_based|performance_based|no_compensation|hybrid`',
    `competitive_insights_access` BOOLEAN COMMENT 'Indicates whether the category captain receives access to aggregated competitive sales data and market insights for the category, subject to Federal Trade Commission (FTC) antitrust compliance requirements.',
    `competitor_data_access_level` STRING COMMENT 'Level of detail the category captain may access regarding competitor product performance data, constrained by Federal Trade Commission (FTC) antitrust requirements.. Valid values are `none|aggregated_only|brand_level|sku_level`',
    `conflict_of_interest_disclosure` STRING COMMENT 'Documented disclosure of potential conflicts of interest arising from the vendors dual role as category captain and competing supplier, required for Federal Trade Commission (FTC) compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this category captain designation record was first created in the system.',
    `data_sharing_agreement_reference` STRING COMMENT 'Reference number or identifier for the formal data sharing agreement governing what sales data, Point of Sale (POS) data, and competitive information the category captain may access.',
    `designation_number` STRING COMMENT 'Business identifier for this category captain arrangement, used for contract reference and audit trail purposes.',
    `designation_status` STRING COMMENT 'Current lifecycle status of the category captain designation indicating whether the arrangement is currently in force.. Valid values are `active|inactive|suspended|under_review|terminated`',
    `effective_end_date` DATE COMMENT 'Date when the category captain designation expires or is scheduled for review. Null indicates an open-ended arrangement subject to periodic review.',
    `effective_start_date` DATE COMMENT 'Date when the category captain designation becomes effective and the vendor assumes category captain responsibilities.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the exclusive category captain for this category or if multiple vendors share category captain responsibilities.',
    `ftc_disclosure_document_reference` STRING COMMENT 'Reference identifier for the Federal Trade Commission (FTC) antitrust disclosure documentation required for category captain arrangements involving competitor data access.',
    `geographic_scope` STRING COMMENT 'Geographic scope of the category captain designation indicating whether it applies nationally across all Grocery locations or is limited to specific regions or store clusters.. Valid values are `national|regional|division|district|store_cluster`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this category captain designation record was most recently updated, supporting audit trail and change tracking requirements.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review of the category captains effectiveness and compliance with arrangement terms.',
    `last_performance_review_score` DECIMAL(18,2) COMMENT 'Numeric score from the most recent performance review, typically on a scale of 1-5 or 1-100, measuring category captain effectiveness.',
    `modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified this category captain designation record, supporting audit and compliance requirements.',
    `new_item_evaluation_authority` BOOLEAN COMMENT 'Indicates whether the category captain participates in evaluation and approval of new item introductions to the category from competing vendors.',
    `next_scheduled_review_date` DATE COMMENT 'Date scheduled for the next formal performance review of the category captain arrangement, typically quarterly or semi-annually.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special conditions, or historical information about this category captain arrangement.',
    `performance_bonus_structure` STRING COMMENT 'Description of performance-based bonus or incentive structure tied to category performance metrics such as sales growth or margin improvement.',
    `performance_evaluation_criteria` STRING COMMENT 'Documented criteria and key performance indicators used to evaluate the category captains performance including category sales growth, Gross Margin Return on Investment (GMROI), and Out of Stock (OOS) reduction.',
    `planogram_design_authority` BOOLEAN COMMENT 'Indicates whether the category captain has authority to design or recommend planograms (visual merchandise display plans) for the category.',
    `pricing_recommendation_authority` BOOLEAN COMMENT 'Indicates whether the category captain has authority to recommend pricing strategies or Suggested Retail Price (SRP) changes for category products.',
    `promotional_calendar_authority` BOOLEAN COMMENT 'Indicates whether the category captain has authority to plan or recommend promotional calendar activities including Temporary Price Reduction (TPR) and Buy One Get One (BOGO) events.',
    `renewal_review_date` DATE COMMENT 'Scheduled date for formal review of the category captain arrangement to determine renewal, modification, or termination.',
    `scope_description` STRING COMMENT 'Detailed narrative description of the category captains specific responsibilities, deliverables, and scope of authority for this arrangement.',
    `store_format_scope` STRING COMMENT 'Store format types covered by this category captain designation such as supermarkets, pharmacies, or fuel centers, allowing different captains for different formats.',
    `term_duration_months` STRING COMMENT 'Length of the category captain appointment term expressed in months, typically 12, 24, or 36 months for grocery retail arrangements.',
    `termination_notice_date` DATE COMMENT 'Date when formal notice of termination or non-renewal was provided by either party, typically required 60-90 days before term end.',
    `termination_reason` STRING COMMENT 'Documented reason for termination or non-renewal of the category captain designation if the arrangement has ended, including performance issues or strategic changes.',
    CONSTRAINT pk_vendor_category_captain PRIMARY KEY(`vendor_category_captain_id`)
) COMMENT 'Designation records identifying which CPG vendor serves as category captain for a given product category or subcategory within Grocerys category management program. Captures category code, designated vendor, appointment effective date, term end/review date, scope of responsibilities (planogram design, assortment recommendations, promotional calendar planning, competitive insights), performance evaluation criteria, data sharing agreements, conflict-of-interest disclosures, and current active/inactive status. This is a regulated vendor role in grocery retail requiring FTC compliance documentation — distinct from general vendor contracts because it involves access to competitor sales data and carries specific antitrust disclosure obligations. Supports category management governance and enables audit trail for FTC compliance on category captain arrangements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`vendor_item` (
    `vendor_item_id` BIGINT COMMENT 'Unique identifier for the vendor item cross-reference record. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: BUYER ASSIGNMENT: Tracks which associate is responsible for purchasing each vendor item, used in order allocation and cost analysis reports.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Links each vendor‑supplied item to the GL account used for inventory valuation and COGS posting.',
    `sku_id` BIGINT COMMENT 'Reference to Grocerys internal SKU master. This is the authoritative product identifier used across stores, DCs, and systems.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor providing this item. Links to the supplier master data.',
    `case_cube_cubic_feet` DECIMAL(18,2) COMMENT 'Volume of one case in cubic feet. Used for warehouse space allocation and transportation optimization.',
    `case_pack_quantity` STRING COMMENT 'Number of consumer units (eaches) contained in one vendor case. Used for ordering and receiving calculations.',
    `case_weight_pounds` DECIMAL(18,2) COMMENT 'Weight of one case in pounds. Used for freight cost calculation and warehouse capacity planning.',
    `cases_per_pallet` STRING COMMENT 'Total number of cases on a full pallet (TI × HI). Used for full-pallet ordering and DC receiving.',
    `catch_weight_flag` BOOLEAN COMMENT 'Indicates whether this item is sold by variable weight (e.g., fresh meat, produce) requiring scale-based pricing at receiving.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for vendor cost amount. Used for international supplier cost management.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the product is manufactured or grown. Required for customs, labeling, and consumer transparency.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor item record was first created in the system.',
    `discontinuation_reason` STRING COMMENT 'Business reason for discontinuing this vendor item relationship (e.g., vendor exit, product reformulation, cost issues).',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this item is delivered directly to stores by the vendor, bypassing the DC. Used for receiving and inventory planning.',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether electronic ordering and invoicing via EDI is enabled for this vendor item. Used for automated procurement.',
    `effective_end_date` DATE COMMENT 'Date when this vendor item relationship ended or will end. Null for active relationships.',
    `effective_start_date` DATE COMMENT 'Date when this vendor item relationship became active and available for ordering.',
    `gtin` STRING COMMENT 'GS1 global trade item number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) assigned by the manufacturer. Used for global product identification.. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the item is classified as hazardous material requiring special handling, storage, and transportation.',
    `inner_pack_quantity` STRING COMMENT 'Number of consumer units contained in one inner pack within a case. Used for shelf-ready packaging and merchandising.',
    `last_cost_update_date` DATE COMMENT 'Date when the vendor cost was last updated. Used for cost change tracking and margin analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor item record was last updated. Used for change tracking and data quality audits.',
    `last_order_date` DATE COMMENT 'Date when this vendor item was last ordered via purchase order. Used for vendor performance analysis and item rationalization.',
    `lead_time_days` STRING COMMENT 'Number of days from purchase order submission to expected delivery at DC or store. Used for replenishment planning and safety stock calculations.',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity that must be ordered from the vendor, expressed in the unit of measure. Used in replenishment planning.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record. Used for audit trail and data governance.',
    `order_multiple_quantity` STRING COMMENT 'Quantity increment required for orders above the minimum (e.g., must order in multiples of 10 cases). Used in CAO systems.',
    `organic_certification_number` STRING COMMENT 'USDA organic certification number or equivalent certifying body identifier. Required for organic product verification.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified organic by USDA or equivalent certifying body. Used for merchandising and labeling compliance.',
    `pallet_hi` STRING COMMENT 'Number of layers stacked on a pallet (HI dimension). Used for warehouse space planning and transportation optimization.',
    `pallet_ti` STRING COMMENT 'Number of cases per layer on a pallet (TI dimension). Used for warehouse space planning and transportation optimization.',
    `primary_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the primary source for this SKU. Used in automated replenishment and PO generation.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this item is a Grocery private-label brand product manufactured by a co-manufacturer.',
    `shelf_life_days` STRING COMMENT 'Number of days from manufacture or receipt date until the product expires or is no longer saleable. Used for FIFO inventory management and markdown planning.',
    `temperature_zone` STRING COMMENT 'Required storage and transportation temperature zone for this item. Critical for cold chain management and HACCP compliance.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for ordering and inventory tracking (each, case, pallet, weight, volume). [ENUM-REF-CANDIDATE: each|case|pallet|pound|kilogram|liter|gallon|ounce — 8 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT '12-digit UPC barcode identifier for the item. Used at point of sale and for inventory tracking.. Valid values are `^d{12}$`',
    `vendor_cost_amount` DECIMAL(18,2) COMMENT 'Current cost per unit of measure charged by the vendor. Used for cost management, margin analysis, and PO pricing.',
    `vendor_item_description` STRING COMMENT 'Vendors description of the item as it appears on their catalog or invoice. Used for receiving verification and reconciliation.',
    `vendor_item_number` STRING COMMENT 'Suppliers unique part number or item code for this product. Used in purchase orders and EDI transactions.',
    `vendor_item_status` STRING COMMENT 'Current lifecycle status of the vendor item relationship. Controls whether the item can be ordered from this supplier.. Valid values are `active|inactive|discontinued|pending|seasonal`',
    CONSTRAINT pk_vendor_item PRIMARY KEY(`vendor_item_id`)
) COMMENT 'Supplier-specific item catalog linking vendor part numbers, UPCs, GTINs, and case configurations to Grocerys internal SKU master. Captures vendor item number, GTIN/UPC, case pack quantity, inner pack quantity, unit of measure, pallet configuration (TI-HI), minimum order quantity, lead time days, country of origin, organic certification flag, and item status. This is the authoritative cross-reference between supplier item identifiers and Grocerys product domain, enabling PO generation, cost management, and receiving operations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`cost_schedule` (
    `cost_schedule_id` BIGINT COMMENT 'Unique identifier for the vendor cost schedule record. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: COST SCHEDULE MAINTENANCE: Captures which associate created/updated a cost schedule, required for change‑control audit.',
    `tpr_event_id` BIGINT COMMENT 'Reference to the promotional event or TPR (Temporary Price Reduction) campaign associated with this cost schedule, if applicable.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor providing the item at this cost.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Cost schedule rows belong to a specific vendor item; linking via vendor_item_id eliminates redundant item identifiers.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'The monetary value of the vendor allowance or discount per unit or case, depending on allowance type.',
    `allowance_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the base cost, if the allowance is expressed as a percentage rather than a fixed amount.',
    `allowance_type` STRING COMMENT 'The mechanism by which vendor allowances or discounts are applied: off-invoice (deducted at purchase), bill-back (claimed after sale), scan-based (paid on scan), accrual (accumulated over time), lump-sum (one-time payment), or none.. Valid values are `off_invoice|bill_back|scan_based|accrual|lump_sum|none`',
    `approval_status` STRING COMMENT 'The approval workflow status for this cost schedule: approved (ready for use), pending approval, rejected, or under review by category management or finance.. Valid values are `approved|pending_approval|rejected|under_review`',
    `approved_by` STRING COMMENT 'The user ID or name of the category manager, buyer, or finance approver who authorized this cost schedule.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this cost schedule was approved for use in COGS (Cost of Goods Sold) calculation.',
    `bracket_max_quantity` STRING COMMENT 'The maximum quantity threshold for this bracket pricing tier. Null indicates no upper limit for the tier.',
    `bracket_min_quantity` STRING COMMENT 'The minimum quantity threshold for this bracket pricing tier. Quantities at or above this level qualify for the tier cost.',
    `bracket_tier` STRING COMMENT 'The volume tier or bracket level for bracket pricing schedules (e.g., Tier 1, Tier 2, Tier 3). Used when cost varies by purchase volume.',
    `case_cost` DECIMAL(18,2) COMMENT 'The wholesale cost per case or pack. Typically used for DSD (Direct Store Delivery) and DC (Distribution Center) ordering.',
    `contract_reference_number` STRING COMMENT 'The vendor contract or agreement number under which this cost schedule is defined. Links to master vendor contract.',
    `cost_basis` STRING COMMENT 'The unit of measure on which the cost is based: per unit (each), per case, per pallet, per weight (lb/kg), or per volume (gallon/liter).. Valid values are `per_unit|per_case|per_pallet|per_weight|per_volume`',
    `cost_change_reason` STRING COMMENT 'The business reason or justification for the most recent cost change (e.g., vendor price increase, commodity cost fluctuation, contract renegotiation, promotional pricing).',
    `cost_source` STRING COMMENT 'The origin or method by which this cost schedule was captured: EDI (Electronic Data Interchange) invoice, manual entry, contract upload, vendor portal, or price file import.. Valid values are `edi_invoice|manual_entry|contract_upload|vendor_portal|price_file_import`',
    `cost_status` STRING COMMENT 'The current lifecycle status of the cost schedule: active (in use), pending (future effective), expired (past end date), superseded (replaced by newer schedule), or cancelled.. Valid values are `active|pending|expired|superseded|cancelled`',
    `cost_type` STRING COMMENT 'Classification of the cost schedule entry: base cost (standard wholesale), promotional cost (temporary reduction), bracket pricing (volume tier), contract cost (negotiated rate), spot cost (one-time purchase), or rebate-adjusted cost.. Valid values are `base_cost|promotional_cost|bracket_pricing|contract_cost|spot_cost|rebate_adjusted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost amounts (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this item is delivered via DSD (Direct Store Delivery) rather than through the DC (Distribution Center). True if DSD, False if warehouse-supplied.',
    `effective_end_date` DATE COMMENT 'The date on which this cost schedule expires. Null indicates an open-ended schedule.',
    `effective_start_date` DATE COMMENT 'The date from which this cost schedule becomes active and applicable for COGS (Cost of Goods Sold) calculation.',
    `freight_cost_per_unit` DECIMAL(18,2) COMMENT 'The allocated freight or transportation cost per unit, if freight is included in the landed cost calculation.',
    `last_cost_change_date` DATE COMMENT 'The date of the most recent change to the cost values in this schedule. Used for cost variance tracking and audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost schedule record was last updated or modified.',
    `minimum_order_quantity` STRING COMMENT 'The minimum quantity (in units or cases) that must be ordered to qualify for this cost schedule.',
    `net_cost` DECIMAL(18,2) COMMENT 'The final net cost per unit after all allowances, discounts, and adjustments are applied. This is the true COGS (Cost of Goods Sold) for margin calculation.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this cost schedule, including special terms, conditions, or exceptions negotiated with the vendor.',
    `payment_terms` STRING COMMENT 'The payment terms negotiated with the vendor for this cost schedule (e.g., Net 30, 2/10 Net 30, COD). Impacts cash flow and working capital.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this cost schedule applies to a private-label (store-owned brand) item. True if private label, False if national brand or CPG (Consumer Packaged Goods).',
    `unit_cost` DECIMAL(18,2) COMMENT 'The wholesale cost per single unit (each) of the item. Used for COGS (Cost of Goods Sold) and GMROI (Gross Margin Return on Investment) calculation.',
    `units_per_case` STRING COMMENT 'The number of individual units (eaches) contained in one case or pack. Used to reconcile unit cost and case cost.',
    CONSTRAINT pk_cost_schedule PRIMARY KEY(`cost_schedule_id`)
) COMMENT 'Vendor cost and pricing schedule defining the wholesale cost (COGS) for each vendor item over a defined effective period. Captures vendor item, cost type (base cost, promotional cost, bracket pricing tier), effective start and end dates, unit cost, case cost, allowance type, bill-back vs. off-invoice designation, and currency. Supports COGS calculation, GMROI analysis, and margin management across the merchandise planning process.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`trade_allowance` (
    `trade_allowance_id` BIGINT COMMENT 'Unique identifier for the trade allowance record. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Allowance transactions must post to a designated GL account to track promotional spend.',
    `associate_id` BIGINT COMMENT 'Identifier of the user who created this trade allowance record in the system.',
    `supplier_id` BIGINT COMMENT 'Reference to the CPG supplier or vendor providing the trade allowance.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Trade allowance is granted under a specific trade agreement; linking via trade_agreement_id removes the need for a free‑text contract reference.',
    `accrual_method` STRING COMMENT 'Defines when the allowance is accrued: at time of purchase from supplier, at time of sale to customer, based on POS scan data, or based on performance metrics achievement.. Valid values are `purchase_based|sales_based|scan_based|performance_based`',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of allowance accrued to date under this agreement, based on qualifying purchases or sales.',
    `allowance_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allowance amount (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `allowance_number` STRING COMMENT 'Business identifier for the trade allowance agreement, typically provided by the supplier or generated internally for tracking.',
    `allowance_rate_type` STRING COMMENT 'Defines how the allowance value is calculated: percentage of purchase price, fixed dollar amount per unit sold, fixed amount per case, or lump sum payment.. Valid values are `percentage|fixed_amount_per_unit|fixed_amount_per_case|lump_sum`',
    `allowance_rate_value` DECIMAL(18,2) COMMENT 'The numeric value of the allowance rate. Interpretation depends on allowance_rate_type (e.g., 5.00 for 5% or $5.00 per unit).',
    `allowance_scope` STRING COMMENT 'Defines the breadth of products covered by the allowance: specific SKUs, entire category, brand family, or all products from the supplier.. Valid values are `sku_specific|category|brand|supplier_wide`',
    `allowance_status` STRING COMMENT 'Current lifecycle status of the trade allowance agreement. [ENUM-REF-CANDIDATE: draft|active|pending_approval|approved|in_settlement|settled|expired|cancelled — 8 candidates stripped; promote to reference product]',
    `allowance_type` STRING COMMENT 'Classification of the trade allowance mechanism: off-invoice (deducted at purchase), bill-back (claimed after purchase), scan-based (triggered by POS scan data), performance rebate (based on sales targets), volume rebate (based on purchase volume), or slotting allowance (for shelf space).. Valid values are `off_invoice|bill_back|scan_based|performance_rebate|volume_rebate|slotting_allowance`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this trade allowance agreement was approved.',
    `category_captain_flag` BOOLEAN COMMENT 'Indicates whether this allowance is part of a category captain arrangement where the supplier has strategic partnership status.',
    `claim_submission_deadline_date` DATE COMMENT 'The final date by which bill-back or rebate claims must be submitted to the supplier for this allowance.',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total dollar amount claimed from the supplier for this allowance through bill-back or rebate submissions.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for managing and tracking this trade allowance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this trade allowance record was first created in the system.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Dollar amount of allowance claims that are currently in dispute with the supplier.',
    `edi_transaction_set` STRING COMMENT 'EDI transaction set identifier used for electronic exchange of allowance data with the supplier (e.g., 867 for Product Transfer and Resale Report, 880 for Grocery Products Invoice).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this trade allowance record was last updated.',
    `maximum_allowance_amount` DECIMAL(18,2) COMMENT 'Cap on the total allowance amount that can be earned or claimed under this agreement. Nullable if no cap applies.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum dollar value of qualifying products that must be purchased to trigger the allowance. Nullable if no minimum applies.',
    `minimum_purchase_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity of qualifying products that must be purchased to trigger the allowance. Nullable if no minimum applies.',
    `notes` STRING COMMENT 'Free-form notes capturing additional details, special terms, or exceptions related to this trade allowance agreement.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total dollar amount actually paid or credited by the supplier for this allowance.',
    `payment_method` STRING COMMENT 'Method by which the supplier pays or credits the allowance: deduction from invoice, check payment, electronic funds transfer, credit memo, or offset against payables.. Valid values are `invoice_deduction|check|eft|credit_memo|offset`',
    `payment_trigger` STRING COMMENT 'Event that triggers payment or settlement of the allowance: automatic deduction from invoice, retailer claim submission, supplier verification of performance, or end of promotion period.. Valid values are `automatic_deduction|claim_submission|performance_verification|period_end`',
    `performance_actual_value` DECIMAL(18,2) COMMENT 'Actual achieved value for the performance metric, used to calculate earned allowance amount.',
    `performance_metric_type` STRING COMMENT 'Type of performance metric used to determine eligibility for performance-based rebates. Applicable when allowance_type is performance_rebate.. Valid values are `sales_volume|revenue_target|market_share|display_compliance|distribution_points`',
    `performance_target_value` DECIMAL(18,2) COMMENT 'Target value for the performance metric that must be achieved to earn the full allowance. Applicable for performance-based allowances.',
    `promotion_period_end_date` DATE COMMENT 'The date when the trade allowance promotion period ends. Nullable for open-ended agreements.',
    `promotion_period_start_date` DATE COMMENT 'The date when the trade allowance promotion period begins and qualifying purchases or sales become eligible.',
    `promotional_event_name` STRING COMMENT 'Name or description of the promotional event or campaign associated with this trade allowance (e.g., Back to School, Holiday Promotion).',
    `qualifying_brand_name` STRING COMMENT 'Brand name that qualifies for this allowance. Populated when allowance_scope is brand.',
    `qualifying_category_code` STRING COMMENT 'Product category code that qualifies for this allowance. Populated when allowance_scope is category.',
    `qualifying_sku_list` STRING COMMENT 'Comma-separated list of SKU identifiers or UPC codes that qualify for this trade allowance. Populated when allowance_scope is sku_specific.',
    `settlement_status` STRING COMMENT 'Current status of the allowance settlement process with the supplier. [ENUM-REF-CANDIDATE: not_started|accruing|claim_submitted|under_review|approved|paid|disputed|rejected — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_trade_allowance PRIMARY KEY(`trade_allowance_id`)
) COMMENT 'Vendor trade promotion allowances, rebates, and bill-back programs negotiated with CPG suppliers. Captures allowance type (off-invoice, bill-back, scan allowance, performance rebate), promotion period, qualifying SKUs or categories, allowance rate or amount, accrual method, payment trigger (scan, purchase, performance), and settlement status. Supports accounts payable deduction management and promotional funding reconciliation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`performance_scorecard` (
    `performance_scorecard_id` BIGINT COMMENT 'Primary key for performance_scorecard',
    `associate_id` BIGINT COMMENT 'Reference to the user (category manager or procurement analyst) who finalized and approved this scorecard.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scorecard metrics are evaluated against the cost center responsible for supplier performance.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor being evaluated in this scorecard period.',
    `action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor is required to submit a corrective action plan based on this scorecard performance. True if action plan required, False otherwise.',
    `asn_accuracy_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ASN transmissions that accurately matched the physical delivery contents during the measurement period.',
    `case_fill_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ordered cases that were successfully delivered by the vendor during the measurement period. Measures fulfillment at case level rather than unit level.',
    `composite_score` DECIMAL(18,2) COMMENT 'Overall weighted performance score combining all KPI metrics into a single vendor performance rating for the measurement period. Drives vendor tier classification and contract decisions.',
    `contract_compliance_flag` BOOLEAN COMMENT 'Indicates whether the vendor met all contractual performance obligations during the measurement period. True if compliant, False if any contract terms were violated.',
    `contract_renegotiation_flag` BOOLEAN COMMENT 'Indicates whether this scorecard performance triggers contract renegotiation or review. True if renegotiation recommended, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was first created in the system.',
    `edi_compliance_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of transactions successfully transmitted via EDI without errors or manual intervention during the measurement period. Measures vendor technical integration quality.',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ordered units that were successfully delivered by the vendor during the measurement period. Key supply chain KPI measuring vendor ability to fulfill complete orders.',
    `finalized_date` DATE COMMENT 'Date when this scorecard was finalized and approved for official use in vendor management decisions.',
    `invoice_accuracy_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of invoices submitted without pricing errors, quantity discrepancies, or other billing issues during the measurement period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was last updated or modified.',
    `lead_time_adherence_percentage` DECIMAL(18,2) COMMENT 'Percentage of orders delivered within the agreed lead time window during the measurement period.',
    `measurement_period_type` STRING COMMENT 'The frequency or type of measurement period for this scorecard (weekly, monthly, quarterly, annual).. Valid values are `weekly|monthly|quarterly|annual`',
    `on_time_delivery_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of deliveries that arrived on or before the scheduled delivery date during the measurement period.',
    `oos_incident_count` STRING COMMENT 'Number of out-of-stock incidents at store or DC level attributed to this vendor during the measurement period. Tracks vendor-caused stockouts.',
    `order_accuracy_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of orders delivered with correct SKUs, quantities, and specifications without errors during the measurement period.',
    `otif_score_percentage` DECIMAL(18,2) COMMENT 'Composite percentage measuring orders delivered both on-time AND in-full during the measurement period. Industry-standard vendor performance metric combining timeliness and completeness.',
    `performance_improvement_flag` BOOLEAN COMMENT 'Indicates whether the vendor composite score improved compared to the previous measurement period. True if improved, False otherwise.',
    `quality_defect_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of delivered units or cases that failed quality inspection or were rejected during the measurement period.',
    `recall_incident_count` STRING COMMENT 'Number of product recall incidents initiated by or involving this vendor during the measurement period. Critical quality and compliance metric.',
    `reviewer_notes` STRING COMMENT 'Free-text notes and comments from the category manager or procurement analyst reviewing this scorecard. Captures qualitative context and action items.',
    `scorecard_period_end_date` DATE COMMENT 'The last date of the measurement period for this performance scorecard.',
    `scorecard_period_start_date` DATE COMMENT 'The first date of the measurement period for this performance scorecard.',
    `scorecard_status` STRING COMMENT 'Current workflow status of this performance scorecard record. Tracks approval and dispute resolution lifecycle.. Valid values are `draft|finalized|under_review|approved|disputed`',
    `shrink_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar value of inventory shrink (loss from theft, spoilage, or damage) attributed to this vendor during the measurement period. Tracks vendor-caused inventory loss.',
    `total_cases_delivered` BIGINT COMMENT 'Total number of cases successfully delivered by this vendor during the measurement period. Numerator for case fill rate calculations.',
    `total_cases_ordered` BIGINT COMMENT 'Total number of cases ordered from this vendor during the measurement period. Denominator for case fill rate calculations.',
    `total_order_count` STRING COMMENT 'Total number of purchase orders placed with this vendor during the measurement period. Provides context for rate-based metrics.',
    `total_order_value_amount` DECIMAL(18,2) COMMENT 'Total dollar value of all purchase orders placed with this vendor during the measurement period. Provides spend context for performance evaluation.',
    `total_units_delivered` BIGINT COMMENT 'Total number of units successfully delivered by this vendor during the measurement period. Numerator for fill rate calculations.',
    `total_units_ordered` BIGINT COMMENT 'Total number of units ordered from this vendor during the measurement period. Denominator for fill rate calculations.',
    `vendor_tier_classification` STRING COMMENT 'Vendor performance tier assigned based on composite score and KPI thresholds. Determines contract terms, payment terms, and strategic partnership status.. Valid values are `platinum|gold|silver|bronze|probation`',
    CONSTRAINT pk_performance_scorecard PRIMARY KEY(`performance_scorecard_id`)
) COMMENT 'Periodic vendor performance scorecard capturing key supply chain KPIs for each supplier across a measurement period. Captures fill rate percentage, on-time delivery rate, order accuracy rate, invoice accuracy rate, case fill rate, OOS incidents attributed to vendor, OTIF (On-Time In-Full) score, shrink contribution, recall incidents, and overall composite score. Drives vendor tier classification and contract renegotiation decisions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`compliance_requirement` (
    `compliance_requirement_id` BIGINT COMMENT 'Unique identifier for the compliance requirement record. Primary key.',
    `superseded_requirement_compliance_requirement_id` BIGINT COMMENT 'Reference to the prior version of this compliance requirement that this version replaces. Null for initial versions. Enables traceability of regulatory change history and vendor certification lineage.',
    `applicable_vendor_category` STRING COMMENT 'Vendor categories or supplier types to which this compliance requirement applies (e.g., CPG Manufacturers, Produce Growers, DSD Distributors, Private-Label Co-Manufacturers, Pharmacy Vendors, Meat and Poultry Suppliers). Pipe-separated list for multiple categories. [ENUM-REF-CANDIDATE: cpg_manufacturer|produce_grower|dsd_distributor|private_label_comanufacturer|pharmacy_vendor|meat_poultry_supplier|dairy_supplier|bakery_supplier|seafood_supplier — promote to reference product]',
    `audit_frequency_months` STRING COMMENT 'Number of months between required audits or inspections for this compliance requirement. For example, 12 for annual audits, 24 for biennial. Null if no periodic audit is required.',
    `category_captain_exemption_flag` BOOLEAN COMMENT 'Indicates whether vendors designated as Category Captains are exempt from this compliance requirement (True) or must comply like all other vendors (False). Used for strategic vendor relationship management.',
    `certification_body` STRING COMMENT 'Name of the third-party certification or accreditation body authorized to issue certificates for this compliance requirement (e.g., USDA Accredited Certifying Agent, GFSI Recognized Certification Body, State Board of Pharmacy). Null if certification is issued directly by the regulatory authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance requirement record was first created in the system. Used for audit trail and compliance history tracking.',
    `documentation_submission_required_flag` BOOLEAN COMMENT 'Indicates whether vendors must submit supporting documentation (certificates, inspection reports, insurance policies, COA) to demonstrate compliance with this requirement (True) or if self-attestation is sufficient (False).',
    `documentation_type` STRING COMMENT 'Type of documentation that vendors must submit to satisfy this compliance requirement (e.g., Certificate of Analysis, HACCP Plan, Organic Certificate, DEA Registration Certificate, Insurance Certificate of Liability, Third-Party Audit Report, FDA Facility Registration Number). Null if no documentation is required.',
    `edi_integration_required_flag` BOOLEAN COMMENT 'Indicates whether vendors must have EDI capability to exchange compliance documentation and certification status electronically (True) or if manual submission is acceptable (False).',
    `effective_date` DATE COMMENT 'Date on which this compliance requirement version becomes enforceable for vendor certification and onboarding. Vendors must meet this requirement for contracts starting on or after this date.',
    `expiration_date` DATE COMMENT 'Date on which this compliance requirement version is no longer valid or enforceable. Null for requirements with indefinite validity. Typically populated when a requirement is superseded or retired.',
    `grace_period_days` STRING COMMENT 'Number of days after the regulatory change effective date during which vendors are allowed to transition to the new requirement without penalty. Null if no grace period is granted.',
    `insurance_coverage_minimum_amount` DECIMAL(18,2) COMMENT 'Minimum insurance coverage amount (in USD) required for insurance certificate compliance requirements (e.g., General Liability, Product Liability, Workers Compensation). Null if this requirement is not insurance-related.',
    `insurance_coverage_type` STRING COMMENT 'Type of insurance coverage required for insurance certificate compliance requirements. Null if this requirement is not insurance-related.. Valid values are `general_liability|product_liability|workers_compensation|commercial_auto|umbrella|professional_liability`',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, certification organization, or internal department that mandates this compliance requirement (e.g., FDA, USDA, DEA, State Board of Pharmacy, GFSI, Internal Quality Assurance).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance requirement record was last updated. Used for audit trail and change tracking.',
    `last_reviewed_date` DATE COMMENT 'Date when this compliance requirement was last reviewed by the owner department to confirm continued relevance and accuracy. Used to ensure requirements remain current with regulatory changes.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this compliance requirement is mandatory (True) or optional/recommended (False) for the applicable vendor categories. Mandatory requirements block vendor onboarding if not met.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this compliance requirement. Used to trigger proactive review workflows and ensure requirements are kept up-to-date.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or clarifications regarding this compliance requirement. May include transition guidance, vendor communication templates, or links to training materials.',
    `notification_lead_time_days` STRING COMMENT 'Number of days in advance that vendors must be notified before a new or updated compliance requirement becomes effective. Used to ensure vendors have adequate time to achieve compliance.',
    `owner_department` STRING COMMENT 'Internal department or business unit responsible for managing and enforcing this compliance requirement (e.g., Quality Assurance, Regulatory Affairs, Pharmacy Compliance, Vendor Management, Legal).',
    `penalty_for_noncompliance` STRING COMMENT 'Description of the consequences for vendors who fail to meet this compliance requirement (e.g., Vendor Onboarding Blocked, Contract Suspension, Immediate Termination, Financial Penalty, Corrective Action Plan Required, Regulatory Reporting to FDA/USDA).',
    `regulatory_change_effective_date` DATE COMMENT 'Date on which the underlying regulatory change (e.g., FDA rule update, USDA policy revision) officially took effect. May differ from internal effective_date if a grace period is granted. Null if this is not a regulatory-driven change.',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory framework or legal statute under which this requirement is mandated (e.g., FDA Food Safety Modernization Act, USDA Organic Regulations 7 CFR Part 205, DEA Controlled Substances Act 21 CFR Part 1300, HIPAA Privacy Rule 45 CFR Part 160).',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals or recertifications for this compliance requirement. For example, 12 for annual renewal, 36 for triennial. Null if no periodic renewal is required.',
    `requirement_code` STRING COMMENT 'Business identifier code for the compliance requirement (e.g., FDA_HACCP_2023, USDA_ORGANIC_CERT, DEA_SCHED_II). Used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `requirement_name` STRING COMMENT 'Full descriptive name of the compliance requirement (e.g., Hazard Analysis Critical Control Points Certification, Organic Producer Certification, DEA Schedule II Controlled Substance Registration).',
    `requirement_status` STRING COMMENT 'Current lifecycle status of the compliance requirement. Active requirements are enforced; superseded requirements have been replaced by newer versions; pending requirements are scheduled for future activation; retired requirements are no longer applicable; suspended requirements are temporarily not enforced.. Valid values are `active|superseded|pending|retired|suspended`',
    `requirement_type` STRING COMMENT 'Category of compliance requirement that classifies the regulatory or business obligation. Determines applicable vendor categories and enforcement procedures. [ENUM-REF-CANDIDATE: food_safety|haccp|organic_certification|usda_inspection|fda_registration|dea_schedule|gfsi_certification|insurance_certificate|coa_requirement|environmental_compliance|labor_compliance|quality_standard — 12 candidates stripped; promote to reference product]',
    `risk_level` STRING COMMENT 'Business risk classification for noncompliance with this requirement. Critical: poses immediate health/safety/legal risk (e.g., DEA Schedule II noncompliance, HACCP failure). High: significant operational or reputational risk. Medium: moderate risk. Low: minimal risk.. Valid values are `critical|high|medium|low`',
    `standard_reference_document` STRING COMMENT 'Citation or URL to the official regulatory standard, guidance document, or internal policy that defines this compliance requirement (e.g., FDA 21 CFR Part 117, USDA 7 CFR Part 205.400, DEA Practitioner Manual, Internal SOP-COMP-001).',
    `vendor_self_certification_allowed_flag` BOOLEAN COMMENT 'Indicates whether vendors are allowed to self-certify compliance with this requirement (True) or if third-party verification is mandatory (False).',
    `version_number` STRING COMMENT 'Version identifier for the compliance requirement (e.g., 1.0, 2.1, 3.0.1). Incremented when regulatory changes or business policy updates necessitate a new version. Supports audit trail of requirement evolution.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    CONSTRAINT pk_compliance_requirement PRIMARY KEY(`compliance_requirement_id`)
) COMMENT 'Vendor compliance requirements and certification obligations that suppliers must meet to do business with Grocery. Captures requirement type (food safety, HACCP, organic certification, USDA inspection, FDA registration, DEA Schedule II-V for pharmacy vendors, GFSI certification, insurance certificate, COA requirements), applicable vendor categories, effective date, renewal frequency, version number, supersession reference (links to prior version when regulatory changes occur), regulatory change effective date, grace period for transition, and documentation submission requirements. Supports version-controlled regulatory change management — when FDA or USDA updates requirements, a new version is created with the prior version marked superseded, enabling audit trail of which requirement version each vendor was certified against.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`compliance_record` (
    `compliance_record_id` BIGINT COMMENT 'Unique identifier for the vendor compliance certification record. Primary key.',
    `compliance_requirement_id` BIGINT COMMENT 'Foreign key linking to vendor.compliance_requirement. Business justification: Compliance records are issued against a defined compliance requirement; linking provides direct access to requirement details.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: COMPLIANCE REVIEW: Links internal compliance reviewer to each record for audit trails and performance scorecards.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor entity that this compliance record pertains to. Links to the vendor master data.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the compliance certification is set up for automatic renewal by the vendor or certification body. True if auto-renewal is enabled; false if manual renewal is required.',
    `business_impact` STRING COMMENT 'The operational impact on the vendor relationship if this compliance requirement is not met. No impact indicates the requirement is informational only; restricted ordering indicates purchase orders may be limited to compliant product categories; suspended ordering indicates all new orders are blocked until compliance is restored; terminated relationship indicates the vendor will be deactivated.. Valid values are `no_impact|restricted_ordering|suspended_ordering|terminated_relationship`',
    `certificate_number` STRING COMMENT 'The unique alphanumeric identifier assigned by the certification body to this specific compliance certificate or license. Used for verification and audit trail purposes.',
    `certification_body` STRING COMMENT 'The name of the regulatory agency, third-party auditor, or certification organization that issued or verified the compliance certification. Examples include FDA, USDA, DEA, state boards of pharmacy, NSF International, SGS, Bureau Veritas, or industry-specific certification bodies.',
    `compliance_notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context related to the compliance record, including special conditions, exemptions, or historical compliance issues. Used for internal communication and audit documentation.',
    `compliance_requirement_type` STRING COMMENT 'The category or type of compliance obligation that this record tracks. Examples include FDA food safety certification, USDA organic certification, USDA meat and poultry inspection, DEA controlled substance registration for pharmacy suppliers, state pharmacy licensing, HACCP (Hazard Analysis Critical Control Points) certification, GMP (Good Manufacturing Practices) certification, and various product certifications (organic, kosher, halal, non-GMO). [ENUM-REF-CANDIDATE: fda_food_safety|usda_organic|usda_meat_inspection|dea_controlled_substance|state_pharmacy_license|haccp_certification|gmp_certification|organic_certification|kosher_certification|halal_certification|non_gmo_certification — 11 candidates stripped; promote to reference product]',
    `compliance_scope` STRING COMMENT 'A textual description of the scope of the compliance certification, including specific product categories, facility locations, or operational processes covered by the certification. For example, Fresh produce handling at Distribution Center 101 or Organic certification for private-label dairy products.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which the vendor must complete corrective actions to remediate non-compliance issues. Used for escalation and vendor performance scorecarding.',
    `corrective_action_plan` STRING COMMENT 'A description of the corrective actions required or planned to address non-compliance issues, including remediation steps, responsible parties, and target completion dates. Used for vendor performance management and compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance record was first created in the system. Used for audit trail and data lineage tracking.',
    `document_attachment_reference` STRING COMMENT 'A URI, file path, or document management system reference pointing to the scanned or digital copy of the compliance certificate, audit report, or supporting documentation. Used for audit trail and regulatory inspection purposes.',
    `expiration_date` DATE COMMENT 'The date on which the compliance certificate or license expires and must be renewed. Null if the certification has no expiration (perpetual until revoked).',
    `facility_location` STRING COMMENT 'The physical location (facility name, address, or site identifier) of the vendor facility or operation that is covered by this compliance certification. Relevant for multi-site vendors where certifications may be facility-specific.',
    `grace_period_days` STRING COMMENT 'The number of days after expiration during which the vendor is allowed to continue operations while renewing the certification. Zero or null indicates no grace period is permitted.',
    `issue_date` DATE COMMENT 'The date on which the compliance certificate or license was originally issued by the certification body.',
    `last_audit_date` DATE COMMENT 'The date of the most recent audit, inspection, or verification activity conducted by the certification body or internal compliance team to validate the vendors adherence to the compliance requirement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance record was most recently updated. Used for audit trail, change tracking, and data quality monitoring.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this compliance record. Used for audit trail and accountability.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next compliance audit or re-certification inspection. Used for proactive compliance management and vendor performance tracking.',
    `non_compliance_reason` STRING COMMENT 'A detailed explanation of the reason for non-compliance status, including specific deficiencies identified during audit, missing documentation, expired certifications not renewed, or regulatory violations. Null if the record is compliant.',
    `notification_sent_date` DATE COMMENT 'The date on which the most recent expiration or renewal notification was sent to the vendor. Used for tracking communication and escalation timelines.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an expiration or renewal notification has been sent to the vendor contact for this compliance record. True if notification has been sent; false otherwise. Used for compliance workflow tracking.',
    `product_category` STRING COMMENT 'The product category or merchandise classification that this compliance certification applies to. Examples include fresh produce, meat and poultry, seafood, dairy, bakery, pharmacy, private-label CPG (Consumer Packaged Goods), or DSD (Direct Store Delivery) items.',
    `regulatory_program` STRING COMMENT 'The specific regulatory program or framework under which this compliance requirement falls. Examples include FDA FSMA (Food Safety Modernization Act), USDA Organic Program, DEA Controlled Substance Registration, State Pharmacy Board Licensing, or EPA refrigerant management.',
    `risk_level` STRING COMMENT 'The assessed risk level associated with this compliance requirement for the vendor, based on product category, regulatory impact, and business criticality. Low indicates minimal regulatory or business risk; medium indicates moderate risk requiring periodic monitoring; high indicates significant risk requiring frequent oversight; critical indicates severe risk requiring immediate attention and continuous monitoring.. Valid values are `low|medium|high|critical`',
    `verification_date` DATE COMMENT 'The date on which the internal compliance team verified and approved the compliance documentation as meeting requirements.',
    `verification_status` STRING COMMENT 'The current state of the compliance record in the verification workflow. Submitted indicates the vendor has provided documentation; pending review indicates internal review is in progress; verified indicates the certification has been validated and is current; expired indicates the certification has passed its expiration date; non-compliant indicates the vendor failed to meet requirements; revoked indicates the certification was withdrawn by the issuing body.. Valid values are `submitted|pending_review|verified|expired|non_compliant|revoked`',
    `verified_by` STRING COMMENT 'The name or identifier of the internal compliance officer, quality assurance manager, or procurement specialist who verified and approved the compliance documentation. Used for audit trail and accountability.',
    CONSTRAINT pk_compliance_record PRIMARY KEY(`compliance_record_id`)
) COMMENT 'Vendor compliance certification and documentation records tracking whether each supplier has met required compliance obligations. Captures vendor, compliance requirement type, certification body, certificate number, issue date, expiration date, document attachment reference, verification status (submitted, verified, expired, non-compliant), and last audit date. Supports regulatory reporting for FDA, USDA, and DEA compliance programs.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`private_label_spec` (
    `private_label_spec_id` BIGINT COMMENT 'Unique identifier for the private label product specification record.',
    `brand_id` BIGINT COMMENT 'Reference to the Grocery private label brand under which this item is sold (e.g., store brand, premium private label tier).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Private‑label development budgets are managed per cost center for financial planning.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: SPEC OWNERSHIP: Associates owning private‑label specs are needed for change requests, compliance, and cost approval workflows.',
    `superseded_by_spec_private_label_spec_id` BIGINT COMMENT 'Reference to the newer specification that replaced this one, if applicable.',
    `supplier_id` BIGINT COMMENT 'Reference to the approved co-manufacturing vendor assigned to produce this private label item.',
    `allergen_statement` STRING COMMENT 'Allergen declaration statement identifying presence of major food allergens (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans) as required by FDA FALCPA.',
    `approval_date` DATE COMMENT 'Date when this specification was approved for production by Grocery quality assurance and category management teams.',
    `approved_by` STRING COMMENT 'Name or identifier of the Grocery team member who approved this specification for production.',
    `calories_per_serving` DECIMAL(18,2) COMMENT 'Total caloric content per serving as declared on the nutrition facts panel.',
    `category_manager` STRING COMMENT 'Name of the Grocery category manager responsible for this private label item and co-manufacturer relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'Date when this specification was discontinued and production ceased.',
    `formulation_effective_date` DATE COMMENT 'Date when this formulation version became effective for production.',
    `formulation_version` STRING COMMENT 'Version number of the product formulation specification. Incremented when ingredient composition or manufacturing process changes.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `gluten_free_flag` BOOLEAN COMMENT 'Indicates whether this item meets FDA gluten-free labeling requirements (less than 20 ppm gluten).',
    `haccp_plan_required_flag` BOOLEAN COMMENT 'Indicates whether the co-manufacturer must maintain a HACCP plan for this product category.',
    `ingredient_list` STRING COMMENT 'Complete list of ingredients in descending order by weight, as required for FDA nutrition labeling compliance.',
    `item_code` STRING COMMENT 'Internal item code or specification number for this private label product. Used for sourcing and manufacturing reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `item_description` STRING COMMENT 'Detailed description of the private label item including product type, flavor, size, and key attributes.',
    `label_compliance_requirements` STRING COMMENT 'Comprehensive list of regulatory label requirements including FDA nutrition facts, USDA organic seal, country of origin, safe handling instructions, and any other mandatory declarations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was last updated.',
    `lead_time_days` STRING COMMENT 'Standard manufacturing lead time in days from purchase order placement to delivery at distribution center.',
    `minimum_order_quantity` STRING COMMENT 'Minimum production run quantity required by the co-manufacturer for this item.',
    `non_gmo_verified_flag` BOOLEAN COMMENT 'Indicates whether this item has been verified as non-GMO by a third-party certification program.',
    `notes` STRING COMMENT 'Additional notes, special instructions, or comments related to this private label specification.',
    `nutritional_panel_requirements` STRING COMMENT 'Specification for nutrition facts panel including serving size, calories, macronutrients, vitamins, and minerals per FDA requirements.',
    `organic_certification_number` STRING COMMENT 'USDA organic certification number issued to the co-manufacturer for this product, if applicable.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this private label item is certified organic and eligible to display the USDA organic seal.',
    `package_dimensions` STRING COMMENT 'Physical dimensions of the package (length x width x height) for planogram and shelf space planning.',
    `package_size` STRING COMMENT 'Net content size of the package expressed in appropriate units (ounces, pounds, liters, count).',
    `packaging_material` STRING COMMENT 'Material composition of the primary packaging (e.g., PET plastic, glass, aluminum, paperboard, flexible film).',
    `packaging_type` STRING COMMENT 'Primary packaging format for the private label item (e.g., bottle, can, box, bag, pouch). [ENUM-REF-CANDIDATE: bottle|can|box|bag|pouch|jar|tray|carton|tube|wrapper — 10 candidates stripped; promote to reference product]',
    `quality_assurance_contact` STRING COMMENT 'Name or identifier of the Grocery quality assurance team member responsible for specification compliance and vendor audits.',
    `quality_standard_specification` STRING COMMENT 'Detailed quality standards and acceptance criteria for the finished product including appearance, taste, texture, color, and physical/chemical parameters.',
    `serving_size` STRING COMMENT 'Standardized serving size for nutritional labeling purposes, expressed in common household measures and metric units.',
    `shelf_life_days` STRING COMMENT 'Expected shelf life of the product in days from date of manufacture under proper storage conditions.',
    `specification_document_url` STRING COMMENT 'Link to the complete specification document including detailed formulation, packaging artwork, and quality standards.',
    `specification_status` STRING COMMENT 'Current lifecycle status of this private label specification in the product development and sourcing process.. Valid values are `draft|under_review|approved|active|discontinued|superseded`',
    `storage_temperature_requirements` STRING COMMENT 'Required storage temperature range and conditions (ambient, refrigerated, frozen) for maintaining product quality and safety.',
    `target_cost_per_unit` DECIMAL(18,2) COMMENT 'Target manufacturing cost per unit negotiated with the co-manufacturer. Used for private label margin analysis and pricing decisions.',
    CONSTRAINT pk_private_label_spec PRIMARY KEY(`private_label_spec_id`)
) COMMENT 'Product specifications and formulation requirements for private-label items manufactured by co-manufacturing vendors. Captures Grocery private-label brand, item description, formulation version, ingredient list, nutritional panel requirements, packaging specifications, label compliance requirements (FDA nutrition facts, USDA organic seal), quality standards, shelf life requirements, and approved co-manufacturer assignments. This entity owns the vendor-side manufacturing specification (formulation, ingredients, packaging, quality standards) while the product domain owns the sellable item attributes (retail UPC, price, category assignment, planogram placement). Supports private-label brand development, co-manufacturer qualification, and sourcing decisions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`vendor`.`quality_incident` (
    `quality_incident_id` BIGINT COMMENT 'Unique identifier for the quality incident record. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: QUALITY INVESTIGATION: Associates investigating incidents are recorded for root‑cause analysis and regulatory reporting.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this quality incident.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Quality incidents are tied to the specific vendor item that caused the issue; linking via vendor_item_id removes duplicate SKU/UPC fields.',
    `batch_number` STRING COMMENT 'The batch number assigned by the manufacturer or co-packer for production traceability.',
    `capa_reference_number` STRING COMMENT 'Reference number linking this incident to a formal CAPA (Corrective and Preventive Action) record.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action plan required or implemented to address the incident.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required from the supplier (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this quality incident record was first created in the system.',
    `customer_complaint_count` STRING COMMENT 'The number of customer complaints received related to this quality incident.',
    `discovery_point` STRING COMMENT 'The point in the supply chain where the incident was discovered (DC receiving, store backroom, store shelf, customer complaint, regulatory notification, third-party audit).. Valid values are `dc_receiving|store_backroom|store_shelf|customer_complaint|regulatory_notification|third_party_audit`',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'The estimated financial cost impact of the incident including product loss, disposal, and remediation costs.',
    `expiration_date` DATE COMMENT 'The expiration or best-by date of the affected product.',
    `fda_report_date` DATE COMMENT 'The date the incident was reported to the FDA Reportable Food Registry, if applicable.',
    `fda_report_number` STRING COMMENT 'The FDA-assigned report number for this incident submission to the Reportable Food Registry.',
    `fda_reportable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this incident must be reported to the FDA Reportable Food Registry (True/False).',
    `impact_on_scorecard_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this incident impacts the suppliers performance scorecard (True/False).',
    `incident_date` DATE COMMENT 'The date when the quality incident was discovered or reported.',
    `incident_number` STRING COMMENT 'Externally-visible unique business identifier for the quality incident, formatted as QI-YYYYMMDD.. Valid values are `^QI-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the quality incident (open, under investigation, corrective action pending, resolved, closed).. Valid values are `open|under_investigation|corrective_action_pending|resolved|closed`',
    `incident_type` STRING COMMENT 'Classification of the quality incident type (contamination, allergen mislabeling, foreign object, temperature abuse, short-coded product, HACCP violation, FSMA violation, spoilage, packaging defect, labeling error). [ENUM-REF-CANDIDATE: contamination|allergen_mislabeling|foreign_object|temperature_abuse|short_coded|haccp_violation|fsma_violation|spoilage|packaging_defect|labeling_error — 10 candidates stripped; promote to reference product]',
    `investigation_completion_date` DATE COMMENT 'The date when the investigation was completed and findings were documented.',
    `investigation_start_date` DATE COMMENT 'The date when the formal investigation of the incident began.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this quality incident record was last updated.',
    `lot_number` STRING COMMENT 'The lot or batch number of the affected product for traceability.',
    `notes` STRING COMMENT 'Additional free-form notes and comments related to the quality incident.',
    `production_date` DATE COMMENT 'The date the affected product was manufactured or produced.',
    `quantity_affected` DECIMAL(18,2) COMMENT 'The quantity of product units affected by the incident.',
    `recall_initiated_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a product recall was initiated as a result of this incident (True/False).',
    `recall_number` STRING COMMENT 'The official recall number assigned if a recall was initiated.',
    `reported_by_name` STRING COMMENT 'The name of the individual who reported or logged the quality incident.',
    `reported_by_role` STRING COMMENT 'The functional role of the individual who reported the incident (quality assurance, store manager, DC receiving, customer service, regulatory affairs, third-party auditor).. Valid values are `quality_assurance|store_manager|dc_receiving|customer_service|regulatory_affairs|third_party_auditor`',
    `resolution_date` DATE COMMENT 'The date when the incident was fully resolved and closed.',
    `root_cause_category` STRING COMMENT 'The identified root cause category of the quality incident (supplier process failure, cold chain breach, handling error, packaging failure, labeling error, ingredient contamination, equipment malfunction, human error, unknown). [ENUM-REF-CANDIDATE: supplier_process_failure|cold_chain_breach|handling_error|packaging_failure|labeling_error|ingredient_contamination|equipment_malfunction|human_error|unknown — 9 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings.',
    `severity_level` STRING COMMENT 'Severity classification of the incident: critical (immediate health risk), major (significant quality issue), or minor (cosmetic or low-impact issue).. Valid values are `critical|major|minor`',
    `supplier_notified_date` DATE COMMENT 'The date when the supplier was formally notified of the quality incident.',
    `supplier_response_date` DATE COMMENT 'The date when the supplier provided their formal response to the incident notification.',
    `supplier_response_summary` STRING COMMENT 'Summary of the suppliers response and proposed corrective actions.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity affected (each, case, pallet, pound, kilogram, liter, gallon). [ENUM-REF-CANDIDATE: each|case|pallet|pound|kilogram|liter|gallon — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_quality_incident PRIMARY KEY(`quality_incident_id`)
) COMMENT 'Quality and food safety incidents reported against vendor-supplied products including contamination findings, allergen mislabeling, foreign object complaints, temperature abuse in cold chain, short-coded product, and HACCP/FSMA violations. Captures incident date, vendor, affected SKUs and lot/batch numbers, incident type, severity level (critical/major/minor), discovery point (DC receiving, store backroom, shelf, customer complaint, regulatory notification), root cause category, corrective action required, CAPA reference, FDA reportable flag, and resolution status. Feeds into vendor scorecard, compliance tracking, and supports FDA Reportable Food Registry submissions when required.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ADD CONSTRAINT `fk_vendor_supplier_contact_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ADD CONSTRAINT `fk_vendor_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ADD CONSTRAINT `fk_vendor_trade_agreement_edi_partner_profile_id` FOREIGN KEY (`edi_partner_profile_id`) REFERENCES `grocery_ecm`.`vendor`.`edi_partner_profile`(`edi_partner_profile_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ADD CONSTRAINT `fk_vendor_trade_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ADD CONSTRAINT `fk_vendor_edi_partner_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ADD CONSTRAINT `fk_vendor_vendor_category_captain_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ADD CONSTRAINT `fk_vendor_vendor_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ADD CONSTRAINT `fk_vendor_cost_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ADD CONSTRAINT `fk_vendor_cost_schedule_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ADD CONSTRAINT `fk_vendor_compliance_requirement_superseded_requirement_compliance_requirement_id` FOREIGN KEY (`superseded_requirement_compliance_requirement_id`) REFERENCES `grocery_ecm`.`vendor`.`compliance_requirement`(`compliance_requirement_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ADD CONSTRAINT `fk_vendor_compliance_record_compliance_requirement_id` FOREIGN KEY (`compliance_requirement_id`) REFERENCES `grocery_ecm`.`vendor`.`compliance_requirement`(`compliance_requirement_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ADD CONSTRAINT `fk_vendor_compliance_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ADD CONSTRAINT `fk_vendor_private_label_spec_superseded_by_spec_private_label_spec_id` FOREIGN KEY (`superseded_by_spec_private_label_spec_id`) REFERENCES `grocery_ecm`.`vendor`.`private_label_spec`(`private_label_spec_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ADD CONSTRAINT `fk_vendor_private_label_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ADD CONSTRAINT `fk_vendor_quality_incident_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ADD CONSTRAINT `fk_vendor_quality_incident_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`vendor` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`vendor` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Default Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Manager Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type Classification');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'cpg_manufacturer|produce_grower|dsd_distributor|private_label_comanufacturer|specialty_supplier|service_provider');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `category_captain_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `edi_partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Partner ID');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `gap_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Agricultural Practices (GAP) Certified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `growing_region` SET TAGS ('dbx_business_glossary_term' = 'Growing Region');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `gtin_prefix` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Prefix');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `gtin_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `haccp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `organic_acreage` SET TAGS ('dbx_business_glossary_term' = 'Organic Acreage');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `ownership_structure` SET TAGS ('dbx_business_glossary_term' = 'Ownership Structure');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Supplier Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|blocked');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Classification');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'tier_1_strategic|tier_2_preferred|tier_3_approved|tier_4_conditional');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `veteran_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Veteran-Owned Business Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ALTER COLUMN `woman_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman-Owned Business Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `supplier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact ID');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `compliance_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notification Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `edi_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Qualified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `escalation_priority` SET TAGS ('dbx_business_glossary_term' = 'Escalation Priority');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `escalation_priority` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|emergency');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `functional_role_type` SET TAGS ('dbx_business_glossary_term' = 'Functional Role Type');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `functional_role_type` SET TAGS ('dbx_value_regex' = 'account_manager|edi_coordinator|compliance_officer|quality_assurance_lead|category_management_representative|logistics_coordinator');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `po_approval_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Approval Authority Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|edi|portal');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `quality_incident_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Incident Notification Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `capacity_units_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Day');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `cold_chain_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capable Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `cross_dock_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Capable Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `dsd_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Capable Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `fda_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registration Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Facility Registration Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `haccp_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certification Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `haccp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `haccp_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Expiration Date');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|decommissioned');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `organic_certifier_name` SET TAGS ('dbx_business_glossary_term' = 'Organic Certifier Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing_plant|distribution_warehouse|dsd_depot|co_manufacturing_facility|processing_plant|cold_storage');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `temperature_range_max_f` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `temperature_range_min_f` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `usda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Establishment Number');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `usda_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Inspection Status');
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ALTER COLUMN `usda_inspection_status` SET TAGS ('dbx_value_regex' = 'inspected|exempt|pending|suspended|revoked');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement ID');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `edi_partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Partner ID');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'master_supply_agreement|private_label_co_manufacturing|dsd_distribution_agreement|category_captain_agreement|promotional_agreement|rebate_agreement');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `category_captain_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|edi_payment|credit_card');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `performance_scorecard_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `rebate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Structure Type');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `rebate_structure_type` SET TAGS ('dbx_value_regex' = 'volume_based|growth_based|fixed_amount|tiered|promotional|none');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `srp_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Suggested Retail Price (SRP) Compliance Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signatory Name');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `supplier_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signatory Title');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `trade_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Partner Profile ID');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'Certificate|Username/Password|API Key|OAuth|SSH Key|VAN Credentials');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `certificate_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `certificate_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `compliance_validation_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validation Level');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `compliance_validation_level` SET TAGS ('dbx_value_regex' = 'Basic|Standard|Strict|Custom');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `connection_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Connection Endpoint');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `connection_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Coordinator Email');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Coordinator Name');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Coordinator Phone');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Partner Name');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_standard` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Standard');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_standard` SET TAGS ('dbx_value_regex' = 'ANSI X12|EDIFACT|XML|JSON|CSV|TRADACOMS');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `edi_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Version');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `functional_ack_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Functional Acknowledgment (997) Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `gs_receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Group Receiver ID (GS)');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `gs_sender_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Group Sender ID (GS)');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `inbound_832_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Inbound 832 Price/Sales Catalog Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `inbound_850_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Inbound 850 Purchase Order (PO) Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `isa_receiver_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Receiver Qualifier (ISA)');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `isa_sender_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Sender Qualifier (ISA)');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `last_successful_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Transmission Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `message_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Message Retry Count');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `outbound_810_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Outbound 810 Invoice Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `outbound_855_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Outbound 855 Purchase Order Acknowledgment (PO Ack) Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `outbound_856_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Outbound 856 Advance Ship Notice (ASN) Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `retry_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Retry Interval Minutes');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `supported_transaction_sets` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Sets');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `test_production_status` SET TAGS ('dbx_business_glossary_term' = 'Test/Production Status');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `test_production_status` SET TAGS ('dbx_value_regex' = 'Test|Production|Certification|Inactive');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `transmission_frequency` SET TAGS ('dbx_business_glossary_term' = 'Transmission Frequency');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `transmission_frequency` SET TAGS ('dbx_value_regex' = 'Real-time|Hourly|Daily|Weekly|On-demand|Batch');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `transmission_time_window` SET TAGS ('dbx_business_glossary_term' = 'Transmission Time Window');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `van_mailbox_code` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Network (VAN) Mailbox ID');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `van_mailbox_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`edi_partner_profile` ALTER COLUMN `van_provider` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Network (VAN) Provider');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `vendor_category_captain_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Captain ID');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `antitrust_compliance_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Antitrust Compliance Acknowledgment');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `assortment_recommendation_authority` SET TAGS ('dbx_business_glossary_term' = 'Assortment Recommendation Authority');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `compensation_model` SET TAGS ('dbx_business_glossary_term' = 'Compensation Model');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `compensation_model` SET TAGS ('dbx_value_regex' = 'fee_based|performance_based|no_compensation|hybrid');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `compensation_model` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `compensation_model` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `competitive_insights_access` SET TAGS ('dbx_business_glossary_term' = 'Competitive Insights Access');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `competitor_data_access_level` SET TAGS ('dbx_business_glossary_term' = 'Competitor Data Access Level');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `competitor_data_access_level` SET TAGS ('dbx_value_regex' = 'none|aggregated_only|brand_level|sku_level');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `conflict_of_interest_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Disclosure');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `data_sharing_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Reference');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `designation_number` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Designation Number');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `designation_status` SET TAGS ('dbx_business_glossary_term' = 'Designation Status');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `designation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|terminated');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `ftc_disclosure_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Disclosure Document Reference');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|division|district|store_cluster');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `last_performance_review_score` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Score');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `new_item_evaluation_authority` SET TAGS ('dbx_business_glossary_term' = 'New Item Evaluation Authority');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `next_scheduled_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `performance_bonus_structure` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Structure');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `performance_bonus_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `performance_evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Performance Evaluation Criteria');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `planogram_design_authority` SET TAGS ('dbx_business_glossary_term' = 'Planogram Design Authority');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `pricing_recommendation_authority` SET TAGS ('dbx_business_glossary_term' = 'Pricing Recommendation Authority');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `promotional_calendar_authority` SET TAGS ('dbx_business_glossary_term' = 'Promotional Calendar Planning Authority');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `renewal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Review Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope of Responsibilities Description');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `store_format_scope` SET TAGS ('dbx_business_glossary_term' = 'Store Format Scope');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `term_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Term Duration in Months');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `termination_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item ID');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `case_cube_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Case Cube Cubic Feet');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `case_weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Case Weight Pounds');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `cases_per_pallet` SET TAGS ('dbx_business_glossary_term' = 'Cases per Pallet');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `catch_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `inner_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inner Pack Quantity');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `last_cost_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `order_multiple_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `organic_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Number');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `pallet_hi` SET TAGS ('dbx_business_glossary_term' = 'Pallet HI (Layers per Pallet)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `pallet_ti` SET TAGS ('dbx_business_glossary_term' = 'Pallet TI (Cases per Layer)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `primary_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `vendor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `vendor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `vendor_item_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Description');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Status');
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending|seasonal');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Schedule ID');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `tpr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `allowance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allowance Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'off_invoice|bill_back|scan_based|accrual|lump_sum|none');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|under_review');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `bracket_max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Bracket Maximum Quantity');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `bracket_min_quantity` SET TAGS ('dbx_business_glossary_term' = 'Bracket Minimum Quantity');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `bracket_tier` SET TAGS ('dbx_business_glossary_term' = 'Bracket Pricing Tier');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `case_cost` SET TAGS ('dbx_business_glossary_term' = 'Case Cost');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_basis` SET TAGS ('dbx_value_regex' = 'per_unit|per_case|per_pallet|per_weight|per_volume');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Reason');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_source` SET TAGS ('dbx_business_glossary_term' = 'Cost Source');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_source` SET TAGS ('dbx_value_regex' = 'edi_invoice|manual_entry|contract_upload|vendor_portal|price_file_import');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|cancelled');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'base_cost|promotional_cost|bracket_pricing|contract_cost|spot_cost|rebate_adjusted');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `freight_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Per Unit');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `last_cost_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Change Date');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `net_cost` SET TAGS ('dbx_business_glossary_term' = 'Net Cost');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ALTER COLUMN `units_per_case` SET TAGS ('dbx_business_glossary_term' = 'Units Per Case');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `trade_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Allowance ID');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'purchase_based|sales_based|scan_based|performance_based');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Allowance Currency Code');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_number` SET TAGS ('dbx_business_glossary_term' = 'Allowance Number');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Rate Type');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_rate_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount_per_unit|fixed_amount_per_case|lump_sum');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Allowance Rate Value');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_scope` SET TAGS ('dbx_business_glossary_term' = 'Allowance Scope');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_scope` SET TAGS ('dbx_value_regex' = 'sku_specific|category|brand|supplier_wide');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_status` SET TAGS ('dbx_business_glossary_term' = 'Allowance Status');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'off_invoice|bill_back|scan_based|performance_rebate|volume_rebate|slotting_allowance');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `category_captain_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `claim_submission_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Deadline Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Transaction Set');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `maximum_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowance Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'invoice_deduction|check|eft|credit_memo|offset');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Payment Trigger');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `payment_trigger` SET TAGS ('dbx_value_regex' = 'automatic_deduction|claim_submission|performance_verification|period_end');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `performance_actual_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Actual Value');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Type');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_value_regex' = 'sales_volume|revenue_target|market_share|display_compliance|distribution_points');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `performance_target_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Target Value');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `promotion_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Period End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `promotion_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Period Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `promotional_event_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Event Name');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `qualifying_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Brand Name');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `qualifying_category_code` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Category Code');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `qualifying_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Qualifying SKU (Stock Keeping Unit) List');
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard Identifier');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Finalized By User ID');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `asn_accuracy_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Accuracy Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `case_fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Case Fill Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Score');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `contract_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `contract_renegotiation_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Renegotiation Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `edi_compliance_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Compliance Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `finalized_date` SET TAGS ('dbx_business_glossary_term' = 'Finalized Date');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `invoice_accuracy_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `lead_time_adherence_percentage` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Adherence Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `on_time_delivery_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `oos_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Incident Count');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `order_accuracy_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Order Accuracy Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `otif_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Score Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `performance_improvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `quality_defect_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Rate Percentage');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `recall_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Recall Incident Count');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `scorecard_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Period End Date');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `scorecard_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Period Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|finalized|under_review|approved|disputed');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `shrink_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Shrink Contribution Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `total_cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Total Cases Delivered');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `total_cases_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Cases Ordered');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `total_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Order Count');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `total_order_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `total_units_delivered` SET TAGS ('dbx_business_glossary_term' = 'Total Units Delivered');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `total_units_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Units Ordered');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `vendor_tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Classification');
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ALTER COLUMN `vendor_tier_classification` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|probation');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `compliance_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement ID');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `superseded_requirement_compliance_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Requirement ID');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `applicable_vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Vendor Category');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `category_captain_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Exemption Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `documentation_submission_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Submission Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `edi_integration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Integration Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `insurance_coverage_minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Minimum Amount');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `insurance_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Type');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `insurance_coverage_type` SET TAGS ('dbx_value_regex' = 'general_liability|product_liability|workers_compensation|commercial_auto|umbrella|professional_liability');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time (Days)');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `penalty_for_noncompliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Noncompliance');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `regulatory_change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Effective Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Requirement Name');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'active|superseded|pending|retired|suspended');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `standard_reference_document` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference Document');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `vendor_self_certification_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Self-Certification Allowed Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_requirement` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record ID');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `compliance_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `business_impact` SET TAGS ('dbx_value_regex' = 'no_impact|restricted_ordering|suspended_ordering|terminated_relationship');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `compliance_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Type');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Compliance Scope');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `document_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Reference');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `facility_location` SET TAGS ('dbx_business_glossary_term' = 'Facility Location');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'submitted|pending_review|verified|expired|non_compliant|revoked');
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `private_label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Private Label Specification ID');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Owner Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `superseded_by_spec_private_label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification ID');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Manufacturer ID');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `allergen_statement` SET TAGS ('dbx_business_glossary_term' = 'Allergen Statement');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `calories_per_serving` SET TAGS ('dbx_business_glossary_term' = 'Calories Per Serving');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `category_manager` SET TAGS ('dbx_business_glossary_term' = 'Category Manager');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `formulation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Effective Date');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `formulation_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten Free Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `haccp_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Plan Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Code');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `item_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `label_compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Label Compliance Requirements');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `non_gmo_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO (Genetically Modified Organism) Verified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `nutritional_panel_requirements` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Panel Requirements');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `organic_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Number');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `package_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Package Dimensions');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `quality_assurance_contact` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Contact');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `quality_standard_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Specification');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `serving_size` SET TAGS ('dbx_business_glossary_term' = 'Serving Size');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `specification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Specification Document URL');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|discontinued|superseded');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `storage_temperature_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Requirements');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `target_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Unit');
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ALTER COLUMN `target_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `quality_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Incident ID');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `customer_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Count');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `discovery_point` SET TAGS ('dbx_business_glossary_term' = 'Discovery Point');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `discovery_point` SET TAGS ('dbx_value_regex' = 'dc_receiving|store_backroom|store_shelf|customer_complaint|regulatory_notification|third_party_audit');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `fda_report_date` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Report Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `fda_report_number` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Report Number');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `fda_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Reportable Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `impact_on_scorecard_flag` SET TAGS ('dbx_business_glossary_term' = 'Impact on Scorecard Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^QI-[0-9]{8}$');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|corrective_action_pending|resolved|closed');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `recall_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated Flag');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reported By Role');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_value_regex' = 'quality_assurance|store_manager|dc_receiving|customer_service|regulatory_affairs|third_party_auditor');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `supplier_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notified Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `supplier_response_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Date');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `supplier_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Summary');
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
