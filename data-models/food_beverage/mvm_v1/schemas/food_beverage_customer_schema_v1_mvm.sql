-- Schema for Domain: customer | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`customer` COMMENT 'SSOT for all customer identities across retail, foodservice, and DTC channels — retailer accounts, foodservice operators, distributors, wholesalers, end consumers, and e-commerce buyers. Manages customer hierarchy, account segmentation, ship-to/bill-to locations, credit terms, loyalty programs, NPS scores, and CRM interactions across B2B and B2C channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'System-generated unique identifier for the account record.',
    `bill_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.bill_to_location. Business justification: Account billing address fields are duplicated; linking to bill_to_location centralizes address data and removes redundant columns.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Credit information is detailed in credit_profile; moving credit_rating and payment_terms to credit_profile normalizes credit data.',
    `edi_trading_partner_id` BIGINT COMMENT 'Foreign key linking to customer.edi_trading_partner. Business justification: EDI trading partner configuration belongs to a B2B account; adding FK enables direct association without creating a bidirectional link.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Preferred Supplier Assignment process links each key account to its primary supplier for contract negotiation and service level management.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Retailers and distributors must verify their primary supplier facilities hold valid FDA/USDA establishment registrations for food safety compliance, supply chain audits, and customer assurance program',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory responsible for the account.',
    `account_name` STRING COMMENT 'Human‑readable name of the account (e.g., retailer name, consumer name).',
    `account_number` STRING COMMENT 'External business number used to identify the account in contracts and transactions.',
    `account_status` STRING COMMENT 'Current operational status of the account.. Valid values are `active|inactive|suspended|pending|closed`',
    `account_type` STRING COMMENT 'Category that defines the nature of the account holder.. Valid values are `retailer|foodservice|distributor|wholesale|consumer|ecommerce`',
    `annual_revenue_band` STRING COMMENT 'Revenue range band for the account (e.g., <$1M, $1‑5M, $5‑10M, >$10M).',
    `channel` STRING COMMENT 'Primary sales channel through which the account purchases products.. Valid values are `retail|foodservice|direct|online`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the account record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the account agreement ends or is scheduled to terminate (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the account agreement becomes effective.',
    `first_order_date` DATE COMMENT 'Date of the first recorded purchase from this account.',
    `key_account_flag` BOOLEAN COMMENT 'Indicates whether the account is designated as a strategic key account.',
    `last_order_date` DATE COMMENT 'Date of the most recent purchase from this account.',
    `market_segment` STRING COMMENT 'Segment of the market to which the account belongs (e.g., mass market, premium).',
    `nps_score` STRING COMMENT 'Latest Net Promoter Score for the account (0‑10).',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person for the account.',
    `primary_email` STRING COMMENT 'Email address of the primary contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `primary_phone` STRING COMMENT 'Phone number of the primary contact.',
    `shipping_address_line1` STRING COMMENT 'First line of the shipping address.',
    `shipping_address_line2` STRING COMMENT 'Second line of the shipping address (optional).',
    `shipping_city` STRING COMMENT 'City component of the shipping address.',
    `shipping_country` STRING COMMENT 'Three‑letter ISO country code of the shipping address.',
    `shipping_postal_code` STRING COMMENT 'Postal/ZIP code of the shipping address.',
    `shipping_state` STRING COMMENT 'State or province of the shipping address.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status of the account.',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the account is tax‑exempt under applicable regulations.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identification number for the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the account record.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for all customer accounts across B2B and B2C channels — retailer accounts (grocery, mass, club, convenience), foodservice operators (QSR, casual dining, institutional), distributors, wholesalers, and DTC/e-commerce consumers. Each account has a unique business identity with attributes including account type, channel, status, credit rating, payment terms, assigned sales territory, key account flag, annual revenue band, and first-order date. The single authoritative source for who is our customer across all commercial systems.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'System-generated unique identifier for the contact.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Contacts (buyers, category managers, AP contacts) belong to B2B customer accounts — this is the foundational CRM parent-child relationship. The contact table currently has no FK to account, leaving it',
    `address_line1` STRING COMMENT 'Primary street address of the contact.',
    `address_line2` STRING COMMENT 'Secondary address information (apartment, suite, etc.).',
    `birth_date` DATE COMMENT 'Date of birth of the contact (used for age-based analytics).',
    `city` STRING COMMENT 'City component of the contacts address.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact.. Valid values are `active|inactive|pending|deceased`',
    `contact_type` STRING COMMENT 'Classification of the contact based on relationship to the company.. Valid values are `internal|external|partner|consumer`',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the contacts country.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contact record was first created.',
    `email` STRING COMMENT 'Primary email address for electronic communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the contact.',
    `full_name` STRING COMMENT 'Complete legal name of the individual contact.',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|de|zh|ja`',
    `last_name` STRING COMMENT 'Family name of the contact.',
    `nps_eligible_flag` BOOLEAN COMMENT 'True if the contact is eligible to receive Net Promoter Score surveys.',
    `opt_in_flag` BOOLEAN COMMENT 'Indicates if the contact has opted in to marketing communications.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates if the contact has opted out of marketing communications.',
    `phone_number` STRING COMMENT 'Primary telephone number for voice contact.. Valid values are `^+?[0-9]{1,3}[ -]?(?[0-9]{1,4})?[ -]?[0-9]{3,4}[ -]?[0-9]{3,4}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the contacts address.',
    `preferred_communication_channel` STRING COMMENT 'Channel the contact prefers for outreach.. Valid values are `email|phone|sms|mail`',
    `role` STRING COMMENT 'Business role of the contact (e.g., buyer, category manager, accounts payable).',
    `source_system` STRING COMMENT 'Originating system that supplied the contact data.. Valid values are `Salesforce|Oracle|SAP|Manual`',
    `source_system_code` STRING COMMENT 'Original identifier of the contact in the source system.',
    `state` STRING COMMENT 'State or province component of the contacts address.',
    `time_zone` STRING COMMENT 'Time zone of the contact for scheduling communications.',
    `title` STRING COMMENT 'Professional title or position of the contact within the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the contact record.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual contacts associated with B2B customer accounts — buyers, category managers, accounts payable contacts, foodservice operators, and DTC consumers. Stores full name, title, role, email, phone, preferred communication channel, opt-in/opt-out flags, and NPS survey eligibility. Sourced from Salesforce CRM Contact object.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`ship_to_location` (
    `ship_to_location_id` BIGINT COMMENT 'System-generated unique identifier for each ship-to location record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Ship-to delivery locations (retail stores, foodservice establishments, DTC addresses) belong to customer accounts. Without an account_id FK on ship_to_location, there is no in-domain link between deli',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Ship-to locations (distribution centers, retail stores) must track which registered manufacturing facilities are authorized to supply them, essential for traceability, recall management, and complianc',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Delivery Routing maps each ship‑to location to its serving distribution center (network node), essential for logistics optimization and carrier planning.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.center. Business justification: In F&B supply chain, each customer ship-to location is assigned a primary serving distribution center for replenishment routing, delivery scheduling, and freight cost allocation. This DC-to-location a',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Assigning a ship‑to address to an internal storage location supports dedicated inventory allocation and location‑based availability reporting.',
    `address_line1` STRING COMMENT 'Primary street address of the ship‑to location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum volume the location can store, expressed in cubic meters.',
    `city` STRING COMMENT 'City where the ship‑to location is situated.',
    `contact_email` STRING COMMENT 'Email address for the primary contact at the location.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the ship‑to location.',
    `contact_phone` STRING COMMENT 'Phone number for the primary contact at the location.. Valid values are `^[0-9+-]{7,15}$`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the ship‑to location record was first created.',
    `delivery_window_end_time` TIMESTAMP COMMENT 'Latest time a delivery may be accepted at this location.',
    `delivery_window_start_time` TIMESTAMP COMMENT 'Earliest time a delivery may be accepted at this location.',
    `dock_requirements` STRING COMMENT 'Specific dock or equipment requirements for receiving shipments (e.g., dock height, trailer type).',
    `effective_from` DATE COMMENT 'Date when the location becomes valid for shipping.',
    `effective_until` DATE COMMENT 'Date when the location is no longer valid for shipping (null if indefinite).',
    `geocode_accuracy_m` STRING COMMENT 'Estimated accuracy of the geocoded coordinates in meters.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary ship‑to address for the parent account.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location in decimal degrees.',
    `location_code` STRING COMMENT 'Business identifier used in ERP and logistics systems to reference the location.',
    `location_name` STRING COMMENT 'Human‑readable name of the ship‑to location (e.g., store name, warehouse name).',
    `location_type` STRING COMMENT 'Category of the ship‑to location indicating its role in the supply chain.. Valid values are `store|warehouse|distribution_center|foodservice|consumer`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location in decimal degrees.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight the location can receive per delivery, in kilograms.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the ship‑to location.. Valid values are `^[A-Za-z0-9]{1,10}$`',
    `receiving_hours` STRING COMMENT 'Standard hours during which the location accepts deliveries (e.g., 08:00‑17:00).',
    `ship_to_location_status` STRING COMMENT 'Current lifecycle status of the location record.. Valid values are `active|inactive|pending|closed`',
    `special_instructions` STRING COMMENT 'Any additional handling or access instructions for deliveries.',
    `state_province` STRING COMMENT 'State or province of the ship‑to location.',
    `temperature_zone` STRING COMMENT 'Temperature control category required for the location.. Valid values are `ambient|chilled|frozen`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the ship‑to location record.',
    CONSTRAINT pk_ship_to_location PRIMARY KEY(`ship_to_location_id`)
) COMMENT 'All ship-to delivery addresses for customer accounts — retail store locations, foodservice establishment addresses, DC receiving docks, and DTC consumer delivery addresses. Captures address, geolocation, delivery window constraints, dock requirements, temperature zone requirements (ambient, chilled, frozen), and active/inactive status. Supports OTIF and DSD routing.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`bill_to_location` (
    `bill_to_location_id` BIGINT COMMENT 'System-generated unique identifier for the bill-to location record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Billing locations must be associated with legal entities (company codes) for tax compliance, statutory invoicing requirements, intercompany billing rules, and VAT/GST registration alignment. Critical ',
    `address_line1` STRING COMMENT 'Primary street address of the billing location.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite or floor).',
    `bill_to_location_status` STRING COMMENT 'Current lifecycle status of the billing location.. Valid values are `active|inactive|suspended`',
    `billing_contact_email` STRING COMMENT 'Email address of the billing contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the primary contact for billing communications.',
    `billing_contact_phone` STRING COMMENT 'Phone number of the billing contact.',
    `city` STRING COMMENT 'City of the billing address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the billing location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bill-to location record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the billing location.',
    `credit_status` STRING COMMENT 'Current status of the credit limit approval process.. Valid values are `approved|pending|rejected|on_hold`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for invoicing this location.',
    `e_invoicing_enabled` BOOLEAN COMMENT 'Indicates whether the location accepts electronic invoicing.',
    `edi_billing_enabled` BOOLEAN COMMENT 'Indicates whether the location supports EDI billing transactions.',
    `effective_from` DATE COMMENT 'Date when the billing location becomes active for invoicing.',
    `effective_until` DATE COMMENT 'Date when the billing location ceases to be active (null if open‑ended).',
    `is_default_bill_to` BOOLEAN COMMENT 'Indicates whether this location is the default billing address for the associated customer account.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bill-to location record.',
    `location_code` STRING COMMENT 'Internal code used to reference the billing location within ERP systems.',
    `location_name` STRING COMMENT 'Descriptive name of the billing location (e.g., Corporate HQ Billing).',
    `location_type` STRING COMMENT 'Classification of the billing location indicating its business role.. Valid values are `corporate|regional|dtc|third_party|other`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the billing location.',
    `payment_terms` STRING COMMENT 'Standard payment terms applied to invoices for this location.. Valid values are `net_30|net_45|net_60|cash|prepaid|other`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the billing location.',
    `state_province` STRING COMMENT 'State or province component of the billing address.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the location is exempt from sales tax.',
    `tax_exempt_reason` STRING COMMENT 'Reason or certification supporting tax exemption status.',
    `tax_registration_number` STRING COMMENT 'Government‑issued tax identifier (e.g., VAT number, EIN).',
    `tax_registration_type` STRING COMMENT 'Type of tax registration number associated with the billing location.. Valid values are `VAT|EIN|GST|Other`',
    CONSTRAINT pk_bill_to_location PRIMARY KEY(`bill_to_location_id`)
) COMMENT 'Bill-to addresses and invoicing entities for customer accounts — corporate billing offices, AP departments, and DTC billing addresses. Stores billing address, invoicing currency, tax registration numbers (VAT/EIN), e-invoicing preferences, and EDI billing capability flags. Distinct from ship-to to support split billing scenarios common in retail and foodservice.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'System generated unique identifier for each node in the account hierarchy.',
    `account_id` BIGINT COMMENT 'Identifier of the immediate parent account in the hierarchy.',
    `account_hierarchy_description` STRING COMMENT 'Free‑form text describing the account or its role in the hierarchy.',
    `account_hierarchy_status` STRING COMMENT 'Current lifecycle state of the account hierarchy node.. Valid values are `active|inactive|pending|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hierarchy record was first created in the source system.',
    `credit_terms` STRING COMMENT 'Payment terms agreed with the account (e.g., Net 30).. Valid values are `net30|net45|net60|net90|cash`',
    `effective_end_date` DATE COMMENT 'Date when the hierarchy relationship ends (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the hierarchy relationship becomes effective.',
    `hierarchy_level` STRING COMMENT 'Depth of the account within the hierarchy (1 = top level).',
    `hierarchy_type` STRING COMMENT 'Specifies the type of hierarchy relationship (e.g., retail banner to store).. Valid values are `retail|foodservice|distributor|corporate`',
    `loyalty_program_flag` BOOLEAN COMMENT 'True if the account participates in the company loyalty program.',
    `market` STRING COMMENT 'Geographic market classification for the account.. Valid values are `US|EU|APAC|LATAM|MEA`',
    `nps_score` DECIMAL(18,2) COMMENT 'Latest Net Promoter Score for the account, ranging from 0 to 10.',
    `region_code` STRING COMMENT 'Three‑letter ISO country or region code where the account is primarily located.. Valid values are `[A-Z]{3}`',
    `rollup_acv_flag` BOOLEAN COMMENT 'Indicates whether All Commodity Volume (ACV) should be rolled up to the parent.',
    `rollup_tdp_flag` BOOLEAN COMMENT 'Indicates whether Total Distribution Points (TDP) should be rolled up to the parent.',
    `sales_channel` STRING COMMENT 'Primary sales channel through which the account purchases products.. Valid values are `retail|foodservice|direct|ecommerce|wholesale`',
    `segment` STRING COMMENT 'Business segment classification used for reporting and planning.. Valid values are `key_account|mid_market|small_business|consumer`',
    `source_system` STRING COMMENT 'Originating system of record for the hierarchy data.. Valid values are `SAP|Salesforce|Oracle|JDA|MES|Workday`',
    `source_system_code` STRING COMMENT 'Native identifier of the account in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the hierarchy record.',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Parent-child hierarchy relationships for customer accounts — retail banner to store, foodservice chain to operator, distributor to sub-distributor, and corporate parent to subsidiary. Captures hierarchy level, parent account reference, hierarchy type (retail, foodservice, distributor), effective dates, and roll-up flags for ACV and TDP reporting. Enables consolidated reporting across account groups.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique surrogate key for the customer segment record.',
    `acv_band` STRING COMMENT 'All Commodity Volume band associated with the segment.. Valid values are `low|mid|high`',
    `assignment_method` STRING COMMENT 'Method used to assign accounts to this segment.. Valid values are `manual|rule_based|model_driven`',
    `audience` STRING COMMENT 'Target audience classification of the segment.. Valid values are `b2b|b2c|both`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created in the system.',
    `criteria` STRING COMMENT 'Expression or rule text that defines the inclusion criteria for the segment.',
    `effective_end_date` DATE COMMENT 'Date when the segment definition expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the segment definition becomes effective.',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this segment is the default assignment for accounts without explicit segment.',
    `last_review_date` DATE COMMENT 'Date when the segment definition was last reviewed for relevance.',
    `nielsen_iri_alignment` STRING COMMENT 'Code linking the segment to Nielsen or IRI market data taxonomy.',
    `owner` STRING COMMENT 'Name or identifier of the business owner responsible for the segment.',
    `primary_flag` BOOLEAN COMMENT 'Indicates whether this segment is the primary segment for an account when multiple assignments exist.',
    `priority` STRING COMMENT 'Numeric priority used to rank segments when multiple apply; lower number = higher priority.',
    `segment_code` STRING COMMENT 'Short business code used to reference the segment in systems.',
    `segment_description` STRING COMMENT 'Free‑text description of the segment purpose and characteristics.',
    `segment_name` STRING COMMENT 'Human‑readable name of the segment.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment.. Valid values are `active|inactive|archived`',
    `segment_type` STRING COMMENT 'Category defining the basis of the segment (e.g., channel, tier, strategic priority).. Valid values are `channel|tier|strategic|acv|nielsen_iri|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the segment record.',
    `version` STRING COMMENT 'Version number of the segment definition, incremented on each change.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Market segmentation taxonomy and account-to-segment assignment management — segment definitions (channel segment, tier classification, strategic priority, ACV band, Nielsen/IRI alignment) plus temporal assignment records linking accounts to segments with effective dating, assignment method (manual, rule-based, model-driven), primary segment flags, and assignment audit trail. Single product owns both the segment master data and the many-to-many account assignments. Supports trade promotion targeting, pricing strategy differentiation, demand planning segmentation, and account evolution tracking across the F&B customer lifecycle.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique surrogate key for the credit profile record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Credit profiles require GL account mapping for bad debt reserve provisioning, credit loss accounting (IFRS 9/ASC 326), and aging bucket financial reporting. Essential for month-end close processes and',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit profile record was created.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the account is currently on credit hold.',
    `credit_hold_reason` STRING COMMENT 'Reason why the credit hold was applied.',
    `credit_insurance_coverage` STRING COMMENT 'Indicates whether the credit is insured and the coverage level.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum amount of credit extended to the customer under this profile.',
    `credit_limit_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount by which the credit limit was increased or decreased.',
    `credit_limit_adjustment_date` DATE COMMENT 'Date when the credit limit was last adjusted.',
    `credit_limit_adjustment_reason` STRING COMMENT 'Reason for the most recent credit limit change.',
    `credit_limit_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the credit limit.. Valid values are `[A-Z]{3}`',
    `credit_limit_override_amount` DECIMAL(18,2) COMMENT 'Override amount applied to the credit limit.',
    `credit_limit_override_flag` BOOLEAN COMMENT 'Indicates if the credit limit has been manually overridden.',
    `credit_limit_override_reason` STRING COMMENT 'Reason for manually overriding the credit limit.',
    `credit_limit_override_timestamp` TIMESTAMP COMMENT 'Date‑time when the credit limit override was applied.',
    `credit_limit_override_user` STRING COMMENT 'User identifier who performed the credit limit override.',
    `credit_limit_review_frequency` STRING COMMENT 'How often the credit limit is reviewed (e.g., quarterly, annually).',
    `credit_limit_review_last_done` DATE COMMENT 'Date when the most recent credit limit review was performed.',
    `credit_limit_review_next_due` DATE COMMENT 'Planned date for the next credit limit review.',
    `credit_limit_review_notes` STRING COMMENT 'Free‑form notes captured during the credit limit review.',
    `credit_limit_review_owner` STRING COMMENT 'Identifier of the person or team responsible for the credit review.',
    `credit_profile_status` STRING COMMENT 'Current lifecycle status of the credit profile.. Valid values are `active|inactive|on_hold|closed|pending`',
    `credit_profile_type` STRING COMMENT 'Classification of the credit profile based on the level of service or risk exposure.. Valid values are `standard|enhanced|custom`',
    `credit_rating` STRING COMMENT 'Internal or external rating indicating creditworthiness of the account.',
    `credit_review_date` DATE COMMENT 'Scheduled date for the next formal credit review.',
    `credit_score` STRING COMMENT 'Numerical credit score derived from internal or external models.',
    `credit_score_source` STRING COMMENT 'Origin of the credit score (e.g., internal model, external agency).',
    `credit_status_reason` STRING COMMENT 'Narrative explanation for the current credit status.',
    `credit_terms_notes` STRING COMMENT 'Additional free‑form notes about the credit terms.',
    `credit_utilization_percent` DECIMAL(18,2) COMMENT 'Current utilization of the credit limit expressed as a percentage.',
    `duns_rating` STRING COMMENT 'External credit rating from Dun & Bradstreet.',
    `effective_from` DATE COMMENT 'Date when the credit profile becomes effective.',
    `effective_until` DATE COMMENT 'Date when the credit profile expires or is terminated; null for open‑ended.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum amount covered by the credit insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Policy identifier for the credit insurance.',
    `insurance_provider` STRING COMMENT 'Name of the insurer providing credit insurance.',
    `last_credit_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the most recent credit review was completed.',
    `outstanding_balance_threshold` DECIMAL(18,2) COMMENT 'Maximum allowable outstanding balance before triggering alerts.',
    `payment_terms` STRING COMMENT 'Standard payment condition associated with the credit profile.. Valid values are `Net 30|Net 60|COD|Prepay|EOM`',
    `profile_number` STRING COMMENT 'Business identifier assigned to the credit profile, used for external reference.',
    `source_system` STRING COMMENT 'Name of the operational system of record providing the credit data (e.g., SAP S/4HANA FI).',
    `source_system_code` STRING COMMENT 'Unique identifier of the source system record for traceability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit profile record.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Credit and payment terms profile for B2B customer accounts — credit limit, credit rating, payment terms (Net 30, Net 60, COD), credit hold status, credit review date, outstanding balance threshold, Dun & Bradstreet rating, and credit insurance coverage. Sourced from SAP S/4HANA FI credit management and Oracle Cloud Financials.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`segment_assignment` (
    `segment_assignment_id` BIGINT COMMENT 'System-generated unique identifier for each segment assignment record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account to which the segment is assigned.',
    `segment_id` BIGINT COMMENT 'Identifier of the customer segment classification.',
    `assignment_date` DATE COMMENT 'Date on which the segment assignment was initially made.',
    `assignment_method` STRING COMMENT 'Mechanism used to assign the segment: manual, rule‑based, or model‑driven.. Valid values are `manual|rule_based|model_driven`',
    `assignment_reason` STRING COMMENT 'Business rationale or trigger for assigning the segment (e.g., new product launch, market shift).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment assignment record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date the segment assignment ceases to be active; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'First date the segment assignment becomes active for the account.',
    `is_current` BOOLEAN COMMENT 'True if the assignment is currently effective (today falls between start and end dates).',
    `notes` STRING COMMENT 'Free‑form text for any additional information about the assignment.',
    `primary_flag` BOOLEAN COMMENT 'Indicates whether this segment is the primary classification for the account at the effective date.',
    `segment_assignment_status` STRING COMMENT 'Current lifecycle status of the segment assignment record.. Valid values are `active|inactive|historical`',
    `segment_priority` STRING COMMENT 'Numeric priority of the segment; lower numbers indicate higher priority.',
    `segment_version` STRING COMMENT 'Version identifier of the segment definition used at assignment time.',
    `source_system` STRING COMMENT 'Name of the source system that originated the segment assignment record.',
    `source_system_code` STRING COMMENT 'Original identifier of the record in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the segment assignment record.',
    CONSTRAINT pk_segment_assignment PRIMARY KEY(`segment_assignment_id`)
) COMMENT 'Association table linking customer accounts to their active segment classifications with effective dating — segment assignment date, assigned-by user, assignment method (manual, rule-based, model-driven), effective start and end dates, and primary segment flag. Supports temporal segmentation changes as accounts evolve across channels and tiers.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` (
    `edi_trading_partner_id` BIGINT COMMENT 'System-generated unique identifier for the EDI trading partner configuration.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: EDI trading partners must be mapped to company codes for automated invoice transmission (EDI 810), payment remittance (EDI 820), and intercompany EDI transactions. Critical for retailer compliance (Wa',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Food & Beverage companies establish EDI connections with suppliers for automated PO transmission, ASN receipt, and invoice processing. EDI trading partner records track technical integration details (',
    `communication_endpoint` STRING COMMENT 'URL or network address of the partners EDI gateway.',
    `communication_protocol` STRING COMMENT 'Network protocol used to exchange EDI messages with the partner.. Valid values are `AS2|SFTP|VAN`',
    `compliance_requirements` STRING COMMENT 'Regulatory or industry compliance constraints applicable to the partner (e.g., FDA, GFSI).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the trading partner record was first created.',
    `edi_contact_email` STRING COMMENT 'Email address of the technical EDI contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `edi_contact_name` STRING COMMENT 'Name of the technical contact responsible for EDI integration.',
    `edi_contact_phone` STRING COMMENT 'Phone number of the technical EDI contact.. Valid values are `^+?[0-9]{7,15}$`',
    `edi_standard` STRING COMMENT 'Standard used for EDI messages with this partner.. Valid values are `ANSI_X12|EDIFACT`',
    `edi_trading_partner_status` STRING COMMENT 'Current lifecycle state of the trading partner configuration.. Valid values are `active|inactive|pending|suspended`',
    `effective_end_date` DATE COMMENT 'Date when the EDI partnership ends or is scheduled to be retired.',
    `effective_start_date` DATE COMMENT 'Date when the EDI partnership becomes active.',
    `is_test_environment` BOOLEAN COMMENT 'True if the partner configuration is for testing; false for production.',
    `last_onboarded_timestamp` TIMESTAMP COMMENT 'Date and time when the partner was most recently onboarded or re‑validated.',
    `notes` STRING COMMENT 'Free‑form notes regarding the partner, special handling, or exceptions.',
    `onboarding_status` STRING COMMENT 'Current status of the partners EDI onboarding process.. Valid values are `pending|in_progress|completed|rejected`',
    `partner_code` STRING COMMENT 'Business‑assigned code used to reference the partner in internal systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `partner_name` STRING COMMENT 'Human‑readable name of the trading partner organization.',
    `partner_type` STRING COMMENT 'Category of the partner based on its role in the supply chain.. Valid values are `retailer|distributor|wholesaler|foodservice|direct_consumer`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for EDI communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `primary_contact_method` STRING COMMENT 'Preferred communication channel for the primary contact.. Valid values are `email|phone|fax`',
    `primary_contact_name` STRING COMMENT 'Name of the main person to contact at the trading partner organization.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact for EDI communications.. Valid values are `^+?[0-9]{7,15}$`',
    `supported_transaction_sets` STRING COMMENT 'Comma‑separated list of EDI transaction sets (e.g., 850,855,856,810) supported for this partner.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the trading partner record.',
    `version` STRING COMMENT 'Version identifier for the partner configuration record.',
    CONSTRAINT pk_edi_trading_partner PRIMARY KEY(`edi_trading_partner_id`)
) COMMENT 'EDI trading partner configuration for B2B customers — EDI partner ID, EDI standard (ANSI X12, EDIFACT), supported transaction sets (850 PO, 855 PO Ack, 856 ASN, 810 Invoice), communication protocol (AS2, SFTP, VAN), test vs production flag, EDI contact, and onboarding status. Manages electronic commerce connectivity for retail and distributor accounts.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'System-generated unique identifier for the consent record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: GDPR/CCPA compliance requires tracking which marketing campaign a consent record authorizes. Food & beverage companies must link consent to specific campaign usage for regulatory audit trails and priv',
    `contact_id` BIGINT COMMENT 'Identifier of the consumer to whom the consent applies.',
    `consent_given_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was granted.',
    `consent_source` STRING COMMENT 'Origin of the consent capture (e.g., web form, mobile app, in‑store, call center).. Valid values are `web_form|mobile_app|in_store|call_center`',
    `consent_status` STRING COMMENT 'Current status of the consent record.. Valid values are `granted|withdrawn|pending`',
    `consent_type` STRING COMMENT 'Category of consent (e.g., marketing email, SMS, push notification, data sharing, profiling).. Valid values are `marketing_email|marketing_sms|push_notification|data_sharing|profiling`',
    `consent_version` STRING COMMENT 'Version identifier of the consent text or policy at the time of capture.',
    `consent_withdrawn_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was withdrawn, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_processing_purpose` STRING COMMENT 'Intended purpose for processing the consumers data under this consent.. Valid values are `marketing|analytics|personalization`',
    `effective_from` DATE COMMENT 'Date when the consent becomes effective.',
    `effective_until` DATE COMMENT 'Date when the consent expires or is no longer valid (nullable).',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction governing the consent (e.g., GDPR, CCPA, CASL).. Valid values are `GDPR|CCPA|CASL|PDPA|Other`',
    `legal_basis` STRING COMMENT 'Legal basis for processing under the consent (typically consent).. Valid values are `consent|legitimate_interest|contract`',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the consent record.',
    `privacy_policy_version` STRING COMMENT 'Version of the overall privacy policy referenced by this consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Data privacy and marketing consent records for DTC and B2C consumers — consent type (marketing email, SMS, push notification, data sharing, profiling), consent status (granted, withdrawn, pending), consent date, withdrawal date, consent source (web form, mobile app, in-store), regulatory jurisdiction (GDPR, CCPA, CASL), and consent version. Supports FDA, FTC, and global privacy compliance obligations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `food_beverage_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_edi_trading_partner_id` FOREIGN KEY (`edi_trading_partner_id`) REFERENCES `food_beverage_ecm`.`customer`.`edi_trading_partner`(`edi_trading_partner_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ADD CONSTRAINT `fk_customer_ship_to_location_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Trading Partner Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'retailer|foodservice|distributor|wholesale|consumer|ecommerce');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Band');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct|online');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `first_order_date` SET TAGS ('dbx_business_glossary_term' = 'First Order Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `key_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Account Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 1');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 2');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_business_glossary_term' = 'Shipping City');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_country` SET TAGS ('dbx_business_glossary_term' = 'Shipping Country');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Postal Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `shipping_state` SET TAGS ('dbx_business_glossary_term' = 'Shipping State/Province');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Status Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Date of Birth');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deceased');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'internal|external|partner|consumer');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `nps_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Eligibility Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{1,3}[ -]?(?[0-9]{1,4})?[ -]?[0-9]{3,4}[ -]?[0-9]{3,4}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce|Oracle|SAP|Manual');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Title');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Source Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR_LINE1)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR_LINE2)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Capacity (CAPACITY_CBM)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (CONTACT_EMAIL)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name (CONTACT_NAME)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (CONTACT_PHONE)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^[0-9+-]{7,15}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CD)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `delivery_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End (DELIV_WIN_END)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `delivery_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start (DELIV_WIN_START)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `dock_requirements` SET TAGS ('dbx_business_glossary_term' = 'Dock Requirements (DOCK_REQ)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `geocode_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (GEOCODE_ACC_M)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Ship‑To Flag (IS_PRIMARY)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code (LOC_CODE)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name (LOC_NAME)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type (LOC_TYPE)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|warehouse|distribution_center|foodservice|consumer');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Load Weight (MAX_WEIGHT_KG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL_CD)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `receiving_hours` SET TAGS ('dbx_business_glossary_term' = 'Receiving Hours (RECV_HOURS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `ship_to_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status (LOC_STATUS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `ship_to_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Delivery Instructions (SPECIAL_INSTR)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (STATE_PROV)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone (TEMP_ZONE)');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen');
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-to Location ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `bill_to_location_status` SET TAGS ('dbx_business_glossary_term' = 'Bill-to Location Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `bill_to_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|on_hold');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `e_invoicing_enabled` SET TAGS ('dbx_business_glossary_term' = 'E‑Invoicing Enabled Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `edi_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'EDI Billing Enabled Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `is_default_bill_to` SET TAGS ('dbx_business_glossary_term' = 'Default Bill-to Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Bill-to Location Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Bill-to Location Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `location_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Bill-to Location Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'corporate|regional|dtc|third_party|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bill-to Location Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|cash|prepaid|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `tax_registration_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ALTER COLUMN `tax_registration_type` SET TAGS ('dbx_value_regex' = 'VAT|EIN|GST|Other');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `credit_terms` SET TAGS ('dbx_business_glossary_term' = 'Credit Terms');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `credit_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|net90|cash');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'retail|foodservice|distributor|corporate');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `loyalty_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `market` SET TAGS ('dbx_value_regex' = 'US|EU|APAC|LATAM|MEA');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `rollup_acv_flag` SET TAGS ('dbx_business_glossary_term' = 'Roll‑up ACV Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `rollup_tdp_flag` SET TAGS ('dbx_business_glossary_term' = 'Roll‑up TDP Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct|ecommerce|wholesale');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Account Segment');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'key_account|mid_market|small_business|consumer');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Salesforce|Oracle|JDA|MES|Workday');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'classification_strategy');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `acv_band` SET TAGS ('dbx_business_glossary_term' = 'Segment ACV Band');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `acv_band` SET TAGS ('dbx_value_regex' = 'low|mid|high');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Method');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|rule_based|model_driven');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `audience` SET TAGS ('dbx_business_glossary_term' = 'Segment Audience');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `audience` SET TAGS ('dbx_value_regex' = 'b2b|b2c|both');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `criteria` SET TAGS ('dbx_business_glossary_term' = 'Segment Criteria Definition');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Segment Indicator');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Review Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `nielsen_iri_alignment` SET TAGS ('dbx_business_glossary_term' = 'Nielsen/IRI Alignment Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `primary_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'channel|tier|strategic|acv|nielsen_iri|custom');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Segment Version Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'credit_terms');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_coverage` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Coverage');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (USD)');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Amount');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_override_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override Amount');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_override_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_override_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_override_user` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override User');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Review Frequency');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_review_last_done` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Limit Review Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_review_next_due` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Limit Review Due Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Review Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_review_owner` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Review Owner');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|closed|pending');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_type` SET TAGS ('dbx_value_regex' = 'standard|enhanced|custom');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_score_source` SET TAGS ('dbx_business_glossary_term' = 'Credit Score Source');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Status Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_terms_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Terms Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Percent');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_utilization_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_utilization_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `duns_rating` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet Rating');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `duns_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `duns_rating` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `last_credit_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Threshold');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance_threshold` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net 30|Net 60|COD|Prepay|EOM');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `profile_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` SET TAGS ('dbx_subdomain' = 'classification_strategy');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `segment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|rule_based|model_driven');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Assignment Indicator');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `primary_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `segment_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `segment_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|historical');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `segment_priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `segment_version` SET TAGS ('dbx_business_glossary_term' = 'Segment Version');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` SET TAGS ('dbx_subdomain' = 'credit_terms');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'EDI Trading Partner Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `communication_endpoint` SET TAGS ('dbx_business_glossary_term' = 'EDI Communication Endpoint');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'EDI Communication Protocol');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'AS2|SFTP|VAN');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_email` SET TAGS ('dbx_business_glossary_term' = 'EDI Technical Contact Email');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_name` SET TAGS ('dbx_business_glossary_term' = 'EDI Technical Contact Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'EDI Technical Contact Phone');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_standard` SET TAGS ('dbx_business_glossary_term' = 'EDI Standard');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_standard` SET TAGS ('dbx_value_regex' = 'ANSI_X12|EDIFACT');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `is_test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment Indicator');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `last_onboarded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Onboarded Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'EDI Onboarding Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'retailer|distributor|wholesaler|foodservice|direct_consumer');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|fax');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `supported_transaction_sets` SET TAGS ('dbx_business_glossary_term' = 'Supported EDI Transaction Sets');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` SET TAGS ('dbx_subdomain' = 'credit_terms');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_given_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_value_regex' = 'web_form|mobile_app|in_store|call_center');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing_email|marketing_sms|push_notification|data_sharing|profiling');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_withdrawn_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawn Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `data_processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Purpose');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `data_processing_purpose` SET TAGS ('dbx_value_regex' = 'marketing|analytics|personalization');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|CASL|PDPA|Other');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `privacy_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Version');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
