-- Schema for Domain: customer | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`customer` COMMENT 'SSOT for all customer identities across retail, foodservice, and DTC channels — retailer accounts, foodservice operators, distributors, wholesalers, end consumers, and e-commerce buyers. Manages customer hierarchy, account segmentation, ship-to/bill-to locations, credit terms, loyalty programs, NPS scores, and CRM interactions across B2B and B2C channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'System-generated unique identifier for the account record.',
    `bill_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.bill_to_location. Business justification: Account billing address fields are duplicated; linking to bill_to_location centralizes address data and removes redundant columns.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Credit information is detailed in credit_profile; moving credit_rating and payment_terms to credit_profile normalizes credit data.',
    `edi_trading_partner_id` BIGINT COMMENT 'Foreign key linking to customer.edi_trading_partner. Business justification: EDI trading partner configuration belongs to a B2B account; adding FK enables direct association without creating a bidirectional link.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal sales representative managing the account.',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty program to which the account belongs.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Preferred Supplier Assignment process links each key account to its primary supplier for contract negotiation and service level management.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: REQUIRED: Assign a default price list to each customer account for pricing engine calculations; standard practice in F&B account‑level pricing.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Account Management: assigns each contact an account manager employee for sales territory planning and performance reporting.',
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
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Delivery Routing maps each ship‑to location to its serving distribution center (network node), essential for logistics optimization and carrier planning.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`loyalty_program` (
    `loyalty_program_id` BIGINT COMMENT 'System-generated unique identifier for the loyalty program.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal team or business unit responsible for the program.',
    `compliance_requirements` STRING COMMENT 'Regulatory or policy constraints applicable to the program (e.g., GDPR, CCPA).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the program record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level for the program data per corporate policy.. Valid values are `public|internal|confidential|restricted`',
    `earn_rate` DECIMAL(18,2) COMMENT 'Number of loyalty points awarded per base monetary unit (e.g., per $1).',
    `earn_rate_currency` STRING COMMENT 'ISO 4217 currency code for the earn rate.. Valid values are `^[A-Z]{3}$`',
    `earn_rule_description` STRING COMMENT 'Narrative description of how points are earned.',
    `earn_rule_type` STRING COMMENT 'Category of activity that triggers point accrual.. Valid values are `purchase|referral|promotion|social|event|other`',
    `effective_end_date` DATE COMMENT 'Date when the program is terminated or expires; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the program becomes legally effective.',
    `enrollment_channel` STRING COMMENT 'Primary channel through which members enroll in the program.. Valid values are `web|mobile|in_store|call_center|partner|other`',
    `enrollment_end_date` DATE COMMENT 'Date after which new enrollments are closed; null if ongoing.',
    `enrollment_start_date` DATE COMMENT 'Date when members may begin enrolling in the program.',
    `loyalty_program_status` STRING COMMENT 'Current lifecycle status of the loyalty program.. Valid values are `active|inactive|suspended|planned|retired`',
    `max_points_balance` STRING COMMENT 'Upper limit on the number of points a member may hold.',
    `points_balance_reset_flag` BOOLEAN COMMENT 'Indicates whether points balances reset on a periodic basis (e.g., annually).',
    `points_expiry_days` STRING COMMENT 'Number of days after earning that points expire.',
    `points_expiry_policy` STRING COMMENT 'Policy governing how point expiry is calculated.. Valid values are `rolling|fixed|none|custom`',
    `program_code` STRING COMMENT 'Business code used to uniquely reference the program in external systems.',
    `program_description` STRING COMMENT 'Full textual description of the loyalty programs purpose and benefits.',
    `program_name` STRING COMMENT 'Descriptive name of the loyalty program as presented to members.',
    `program_type` STRING COMMENT 'Classification of the program based on reward mechanics.. Valid values are `points|tier|cashback|hybrid|gift|other`',
    `redeem_rule_description` STRING COMMENT 'Narrative description of how points can be redeemed.',
    `redeem_rule_type` STRING COMMENT 'Category of redemption option offered to members.. Valid values are `points_for_discount|free_product|gift|voucher|cashback|other`',
    `redemption_rate` DECIMAL(18,2) COMMENT 'Monetary value of a single loyalty point when redeemed.',
    `tier_1_min_points` STRING COMMENT 'Minimum accumulated points required to attain Tier 1.',
    `tier_1_name` STRING COMMENT 'Display name of the first loyalty tier.',
    `tier_2_min_points` STRING COMMENT 'Minimum accumulated points required to attain Tier 2.',
    `tier_2_name` STRING COMMENT 'Display name of the second loyalty tier.',
    `tier_3_min_points` STRING COMMENT 'Minimum accumulated points required to attain Tier 3.',
    `tier_3_name` STRING COMMENT 'Display name of the third loyalty tier.',
    `tier_4_min_points` STRING COMMENT 'Minimum accumulated points required to attain Tier 4.',
    `tier_4_name` STRING COMMENT 'Display name of the fourth loyalty tier.',
    `tier_5_min_points` STRING COMMENT 'Minimum accumulated points required to attain Tier 5.',
    `tier_5_name` STRING COMMENT 'Display name of the fifth loyalty tier.',
    `tier_levels` STRING COMMENT 'Total count of distinct loyalty tiers defined in the program.',
    `tier_structure` STRING COMMENT 'Structured definition (e.g., JSON) of tier levels, benefits, and thresholds.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the program record.',
    `created_by` STRING COMMENT 'User or system identifier that created the program record.',
    CONSTRAINT pk_loyalty_program PRIMARY KEY(`loyalty_program_id`)
) COMMENT 'Complete loyalty lifecycle management for DTC and B2C consumer engagement — program definitions (name, type, earn/redeem rules, tier thresholds, expiry policy), individual consumer enrollments (tier, points balance, lifetime value, enrollment channel, tier qualification dates), and points transaction activity (earn, redeem, adjust, expire events with triggering purchase/referral/promotion context). Single product owns the full loyalty lifecycle from program design through member enrollment to transaction-level audit trail across DTC web, mobile app, and in-store channels. Supports program ROI analysis, tier migration tracking, redemption analytics, and consumer lifetime value calculation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` (
    `loyalty_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for each loyalty enrollment record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the consumer who is enrolled in the loyalty program.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Captures which employee enrolled the account into the loyalty program, supporting incentive calculations and enrollment audit.',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty program to which the consumer is enrolled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty enrollment record was first created in the system.',
    `enrollment_channel` STRING COMMENT 'Channel through which the consumer enrolled (e.g., website, mobile app, in‑store).. Valid values are `web|mobile_app|in_store|call_center|partner`',
    `enrollment_date` DATE COMMENT 'Date the consumer officially joined the loyalty program.',
    `expiration_date` DATE COMMENT 'Date the enrollment expires or is scheduled to terminate, if applicable.',
    `lifetime_points_earned` BIGINT COMMENT 'Total points the consumer has earned over the lifetime of the enrollment.',
    `loyalty_enrollment_status` STRING COMMENT 'Current lifecycle status of the loyalty enrollment.. Valid values are `active|inactive|suspended|pending|closed`',
    `next_tier_threshold` BIGINT COMMENT 'Points required to reach the next tier level.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the enrollment.',
    `opt_in_communication_preferences` STRING COMMENT 'Preferred communication channel(s) the consumer has opted into for loyalty messages.. Valid values are `email|sms|push|none`',
    `points_balance` DECIMAL(18,2) COMMENT 'Current points balance available for redemption.',
    `preferred_language` STRING COMMENT 'Consumers preferred language for loyalty communications.',
    `program_tier` STRING COMMENT 'Current tier level of the consumer within the loyalty program.. Valid values are `bronze|silver|gold|platinum`',
    `redemption_history_summary` STRING COMMENT 'Brief textual summary of the consumers redemption activity (e.g., number of redemptions, recent reward types).',
    `source_system` STRING COMMENT 'Name of the source system that originated the enrollment record (e.g., Salesforce CRM).',
    `source_system_code` STRING COMMENT 'Identifier of the record in the source system.',
    `tier_qualification_date` DATE COMMENT 'Date the consumer qualified for the current tier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the loyalty enrollment record.',
    CONSTRAINT pk_loyalty_enrollment PRIMARY KEY(`loyalty_enrollment_id`)
) COMMENT 'Individual consumer enrollments in loyalty programs — enrollment date, program tier, current points balance, lifetime points earned, redemption history summary, tier qualification date, next tier threshold, opt-in communication preferences, and enrollment channel (DTC web, mobile app, in-store). Links consumers to loyalty programs with their own lifecycle.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` (
    `loyalty_transaction_id` BIGINT COMMENT 'System-generated unique identifier for each loyalty transaction record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who earned or redeemed the points.',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty program under which this transaction is recorded.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Records the employee who processed the loyalty points transaction, required for audit trails and employee commission reporting.',
    `channel` STRING COMMENT 'Channel through which the loyalty activity was captured.. Valid values are `online|in_store|mobile_app`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty transaction record was first inserted into the lakehouse.',
    `expiration_date` DATE COMMENT 'Date on which earned points are scheduled to expire, if applicable.',
    `is_manual_adjustment` BOOLEAN COMMENT 'True if the transaction was entered manually by an operator, false otherwise.',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the transaction.',
    `order_reference` BIGINT COMMENT 'Identifier of the order that generated the loyalty points (if applicable).',
    `points_amount` DECIMAL(18,2) COMMENT 'Number of loyalty points associated with this transaction (positive for earn, negative for redeem/adjust).',
    `points_balance_after` DECIMAL(18,2) COMMENT 'Customers loyalty points balance immediately after this transaction was applied.',
    `points_balance_before` DECIMAL(18,2) COMMENT 'Customers loyalty points balance immediately before this transaction was applied.',
    `processing_status` STRING COMMENT 'Result of the backend processing for the transaction.. Valid values are `success|failed|pending`',
    `reward_type` STRING COMMENT 'Type of reward associated with a redemption transaction.. Valid values are `discount|gift|voucher|product`',
    `source_system` STRING COMMENT 'Name of the operational system that originated the loyalty transaction record.',
    `source_system_code` STRING COMMENT 'Identifier of the transaction in the source system.',
    `transaction_reference` STRING COMMENT 'External reference code used in loyalty program communications and reporting.',
    `transaction_status` STRING COMMENT 'Current processing state of the loyalty transaction.. Valid values are `pending|posted|cancelled|reversed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the loyalty event actually occurred.',
    `transaction_type` STRING COMMENT 'Indicates whether the transaction earned, redeemed, adjusted, or expired points.. Valid values are `earn|redeem|adjust|expire`',
    `triggering_event` STRING COMMENT 'Business event that caused the points transaction (e.g., a purchase, referral, survey completion, or promotion).. Valid values are `purchase|referral|survey|promotion`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the loyalty transaction record.',
    CONSTRAINT pk_loyalty_transaction PRIMARY KEY(`loyalty_transaction_id`)
) COMMENT 'Individual loyalty points earn and redemption events — transaction type (earn, redeem, adjust, expire), points amount, triggering event (purchase, referral, survey, promotion), transaction date, associated order reference, redemption reward type, and processing status. Provides full audit trail of consumer loyalty activity for DTC and e-commerce channels.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`nps_survey` (
    `nps_survey_id` BIGINT COMMENT 'Unique identifier for each NPS survey response record.',
    `contact_id` BIGINT COMMENT 'Unique identifier of the respondent (contact or account) who answered the survey.',
    `segment_id` BIGINT COMMENT 'Identifier of the customer segment to which the respondent belongs.',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the location (ship‑to) associated with the respondent.',
    `cadence` STRING COMMENT 'Frequency at which the survey is sent (e.g., weekly, monthly).. Valid values are `weekly|monthly|quarterly|ad_hoc`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NPS response record was first created in the system.',
    `dispatch_method` STRING COMMENT 'Method used to deliver the NPS survey to the respondent.. Valid values are `email|sms|phone|in_app|mail`',
    `effective_end_date` DATE COMMENT 'Date when the survey campaign was closed or expired (nullable for open‑ended campaigns).',
    `effective_start_date` DATE COMMENT 'Date when the survey campaign became active for respondents.',
    `follow_up_action` STRING COMMENT 'Planned action to address the respondents feedback.. Valid values are `none|call|email|survey|escalate`',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow‑up action should be completed.',
    `nps_classification` STRING COMMENT 'Categorization of the NPS score: promoter (9‑10), passive (7‑8), or detractor (0‑6).. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'Numeric Net Promoter Score provided by the respondent (0‑10).',
    `respondent_email` STRING COMMENT 'Primary email address of the respondent for communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `respondent_name` STRING COMMENT 'Full legal name of the individual respondent.',
    `respondent_phone` STRING COMMENT 'Contact phone number of the respondent.',
    `respondent_type` STRING COMMENT 'Indicates whether the respondent is a B2B account or a B2C consumer.. Valid values are `b2b|b2c`',
    `response_channel` STRING COMMENT 'Channel through which the respondent submitted the survey.. Valid values are `email|sms|phone|in_app|mail`',
    `response_date` DATE COMMENT 'Calendar date of the NPS response (derived from response_timestamp).',
    `response_device_type` STRING COMMENT 'Device category used by the respondent to submit the survey.. Valid values are `mobile|desktop|tablet|phone|other`',
    `response_ip_address` STRING COMMENT 'IP address captured at the time of survey submission.',
    `response_language` STRING COMMENT 'Language in which the respondent completed the survey.. Valid values are `en|es|fr|de|zh`',
    `response_source` STRING COMMENT 'Origin of the response within the organization (e.g., web portal, mobile app, call center, in‑store kiosk).. Valid values are `web|app|call_center|in_store`',
    `response_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the respondent submitted the NPS survey.',
    `survey_code` BIGINT COMMENT 'Identifier of the NPS survey campaign definition that this response belongs to.',
    `survey_name` STRING COMMENT 'Descriptive name of the NPS survey campaign.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey response record.. Valid values are `draft|active|completed|closed|cancelled`',
    `survey_type` STRING COMMENT 'Category of the NPS survey (e.g., post‑purchase, periodic, event‑driven).. Valid values are `post_purchase|post_interaction|periodic|event|custom`',
    `survey_version` STRING COMMENT 'Version label of the survey definition (e.g., v1.0, v2.1).',
    `target_channel` STRING COMMENT 'Primary distribution channel for which the survey is intended (e.g., retail, foodservice, direct‑to‑consumer).. Valid values are `retail|foodservice|direct|online|mobile`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the NPS response record.',
    `verbatim_comments` STRING COMMENT 'Open‑ended feedback text entered by the respondent.',
    CONSTRAINT pk_nps_survey PRIMARY KEY(`nps_survey_id`)
) COMMENT 'Net Promoter Score measurement program and individual response capture — survey campaign definitions (name, type, target channel, cadence, dispatch method) and respondent-level response records (NPS score 0-10, promoter/passive/detractor classification, verbatim comments, response dates, follow-up actions, response channel, associated account or contact). Single product owns both the survey design and all response data. Supports transactional and relational NPS across B2B account health and B2C brand sentiment, closed-loop detractor follow-up, promoter advocacy identification, and NPS trend analysis by segment, channel, and account tier.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`nps_response` (
    `nps_response_id` BIGINT COMMENT 'Unique identifier for the NPS response record.',
    `contact_id` BIGINT COMMENT 'Identifier of the respondent (customer contact) who provided the NPS response.',
    `nps_survey_id` BIGINT COMMENT 'Identifier of the NPS survey definition.',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the location associated with the respondent for this response.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NPS response record was created in the system.',
    `follow_up_action_flag` BOOLEAN COMMENT 'Indicates whether a follow‑up action is required for this response.',
    `nps_category` STRING COMMENT 'Classification of the NPS score: promoter (9-10), passive (7-8), detractor (0-6).. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'NPS rating provided by the respondent on a scale of 0 to 10.',
    `respondent_type` STRING COMMENT 'Indicates if the respondent is a business (B2B) or consumer (B2C) entity.. Valid values are `b2b|b2c`',
    `response_channel` STRING COMMENT 'Channel through which the respondent submitted the NPS response.. Valid values are `email|sms|phone|web|in_app|post`',
    `response_date` DATE COMMENT 'Date when the respondent submitted the NPS response.',
    `response_status` STRING COMMENT 'Current processing status of the NPS response.. Valid values are `new|reviewed|closed`',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the NPS response was recorded.',
    `source_system` STRING COMMENT 'Source system that captured the NPS response (e.g., Salesforce, SurveyMonkey).',
    `source_system_code` STRING COMMENT 'Unique identifier of the response in the source system.',
    `survey_dispatch_date` DATE COMMENT 'Date when the NPS survey was dispatched to the respondent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the NPS response record.',
    `verbatim_comment` STRING COMMENT 'Open‑ended comment provided by the respondent.',
    CONSTRAINT pk_nps_response PRIMARY KEY(`nps_response_id`)
) COMMENT 'Individual NPS survey responses from customers and consumers — respondent account or contact reference, survey dispatch date, response date, NPS score (0-10), promoter/passive/detractor classification, verbatim comment, response channel, and follow-up action flag. Captures the voice-of-customer signal for brand and account health monitoring.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Primary key for interaction',
    `rep_id` BIGINT COMMENT 'Identifier of the sales or service representative assigned to this interaction.',
    `case_id` BIGINT COMMENT 'Identifier of the service case linked to this interaction, if any.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who logged the interaction.',
    `account_id` BIGINT COMMENT 'Identifier of the account (if B2B) associated with the interaction.',
    `interaction_customer_account_id` BIGINT COMMENT 'Identifier of the customer (B2B or B2C) involved in the interaction.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the interaction, if any.',
    `opportunity_id` BIGINT COMMENT 'Identifier of the sales opportunity linked to this interaction, if any.',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the ship‑to or service location relevant to the interaction.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether any attachment (e.g., document, image) is associated with the interaction.',
    `audit_trail` STRING COMMENT 'JSON string capturing audit trail of changes for compliance purposes.',
    `channel` STRING COMMENT 'Medium through which the interaction occurred.. Valid values are `phone|email|in_person|web|social_media|chat`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the interaction required compliance review (e.g., regulatory, privacy).',
    `compliance_review_status` STRING COMMENT 'Status of the compliance review for the interaction.. Valid values are `pending|approved|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interaction record was first created in the system.',
    `duration_minutes` STRING COMMENT 'Length of the interaction in minutes.',
    `escalation_reason` STRING COMMENT 'Reason provided for escalation, if applicable.',
    `follow_up_due_date` DATE COMMENT 'Date by which the required follow‑up should be completed.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether a follow‑up action is required after the interaction.',
    `interaction_number` STRING COMMENT 'Human‑readable reference number for the interaction.',
    `interaction_status` STRING COMMENT 'Current processing status of the interaction record.. Valid values are `logged|in_progress|completed|closed|cancelled`',
    `interaction_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction took place.',
    `interaction_type` STRING COMMENT 'Category of the interaction such as call, email, visit, trade show, complaint, inquiry, or meeting. [ENUM-REF-CANDIDATE: call|email|visit|trade_show|complaint|inquiry|meeting — 7 candidates stripped; promote to reference product]',
    `is_escalated_flag` BOOLEAN COMMENT 'Flag indicating if the interaction was escalated to a higher support tier.',
    `is_internal_flag` BOOLEAN COMMENT 'True if the interaction is internal (e.g., between employees) rather than external customer.',
    `is_test_interaction` BOOLEAN COMMENT 'Indicates whether the record is a test or training interaction.',
    `language_code` STRING COMMENT 'ISO 639‑1 language code of the interaction.. Valid values are `^[a-z]{2}$`',
    `notes` STRING COMMENT 'Free‑form notes captured by the representative.',
    `nps_score` STRING COMMENT 'Net Promoter Score captured during the interaction, if collected.',
    `outcome` STRING COMMENT 'Result or outcome of the interaction (e.g., resolved, pending, escalated).',
    `priority_level` STRING COMMENT 'Priority assigned to the interaction for handling.. Valid values are `low|medium|high|critical`',
    `product_sku` STRING COMMENT 'SKU of the product discussed during the interaction, if applicable.',
    `product_upc` STRING COMMENT 'UPC code of the product discussed, if applicable.',
    `rating` STRING COMMENT 'Rating (1‑5) given by the customer for the interaction.',
    `regulatory_reference` STRING COMMENT 'Reference to any regulatory case or filing linked to the interaction.',
    `response_channel` STRING COMMENT 'Channel used to deliver the response.. Valid values are `phone|email|in_person|web|social_media|chat`',
    `response_timestamp` TIMESTAMP COMMENT 'Timestamp when a response was sent back to the customer.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Sentiment score derived from interaction content (range -1.00 to 1.00).',
    `source_system` STRING COMMENT 'Source system that originated the interaction record (e.g., Salesforce, Service Cloud).',
    `source_system_code` STRING COMMENT 'Identifier of the record in the source system.',
    `subject` STRING COMMENT 'Brief subject or title of the interaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the interaction record.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'CRM interaction records capturing all touchpoints between Food Beverage and its customers — interaction type (call, email, visit, trade show, complaint, inquiry), interaction date, channel, subject, outcome, follow-up required flag, associated opportunity or case reference, and assigned rep. Sourced from Salesforce CRM Activity and Task objects. Covers both B2B account management and B2C consumer service interactions.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`case` (
    `case_id` BIGINT COMMENT 'Unique system-generated identifier for the case.',
    `account_id` BIGINT COMMENT 'Identifier of the account associated with the case (for B2B customers).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed to track the employee responsible for each customer service case, enabling SLA monitoring and case ownership reporting.',
    `capa_id` BIGINT COMMENT 'Identifier of the corrective action record linked to this case.',
    `contact_id` BIGINT COMMENT 'Identifier of the customer (B2B or B2C) who reported the case.',
    `related_case_id` BIGINT COMMENT 'Identifier of a related case if this case is a follow-up or duplicate.',
    `sku_id` BIGINT COMMENT 'Identifier of the product involved in the case, if applicable.',
    `attached_file_count` STRING COMMENT 'Number of files attached to the case (e.g., photos, documents).',
    `case_category` STRING COMMENT 'Broad category of the case for reporting purposes.. Valid values are `product|service|delivery|billing|other`',
    `case_number` STRING COMMENT 'Unique case identifier assigned by the system.',
    `case_status` STRING COMMENT 'Current lifecycle status of the case.. Valid values are `open|in_progress|resolved|closed|cancelled`',
    `case_type` STRING COMMENT 'Category of the case indicating the nature of the issue.. Valid values are `quality_complaint|delivery_shortage|billing_dispute|recall_notification|food_safety_contact`',
    `channel` STRING COMMENT 'Channel through which the case was submitted.. Valid values are `phone|email|web_portal|social_media|in_store|mobile_app`',
    `channel_detail` STRING COMMENT 'Additional details about the channel (e.g., email address, phone number).',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was closed or resolved.',
    `complaint_description` STRING COMMENT 'Detailed description of the issue reported by the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|MXN`',
    `escalation_level` STRING COMMENT 'Escalation tier reached for the case.. Valid values are `tier1|tier2|tier3|management`',
    `impact_severity` STRING COMMENT 'Severity of the impact on the customer or business.. Valid values are `low|moderate|high|critical`',
    `is_duplicate` BOOLEAN COMMENT 'Flag indicating whether this case is identified as a duplicate of another case.',
    `is_escalated` BOOLEAN COMMENT 'Flag indicating whether the case was escalated to higher support tier.',
    `is_financial_impact` BOOLEAN COMMENT 'Flag indicating whether the case has a financial impact (e.g., refund, credit).',
    `monetary_amount_refunded` DECIMAL(18,2) COMMENT 'Monetary amount actually refunded to the customer.',
    `monetary_amount_requested` DECIMAL(18,2) COMMENT 'Monetary amount requested by the customer (e.g., refund amount).',
    `notes` STRING COMMENT 'Additional internal notes or comments related to the case.',
    `nps_score` STRING COMMENT 'Net Promoter Score captured from the customer after case resolution.',
    `opened_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was initially opened (business event).',
    `origin` STRING COMMENT 'Origin of the case: internal (initiated by staff) or external (customer initiated).. Valid values are `internal|external`',
    `priority` STRING COMMENT 'Priority level assigned to the case based on impact and urgency.. Valid values are `low|medium|high|critical`',
    `regulatory_report_type` STRING COMMENT 'Type of regulatory report associated with the case.. Valid values are `adverse_event|labeling_error|contamination|recall|other`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates if the case is reportable to regulatory bodies (e.g., FDA adverse event).',
    `resolution_action` STRING COMMENT 'Action taken to resolve the case (e.g., replacement, refund, corrective action).',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the resolution action was completed.',
    `root_cause_category` STRING COMMENT 'High-level root cause classification determined during investigation.. Valid values are `manufacturing|packaging|labeling|distribution|supplier|other`',
    `satisfaction_rating` STRING COMMENT 'Customer satisfaction rating (1-5) for the case handling.',
    `sku` STRING COMMENT 'Stock Keeping Unit of the product related to the case.',
    `sla_actual_hours` STRING COMMENT 'Actual time taken to resolve the case in hours.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates if the case met the SLA target (true) or missed (false).',
    `sla_target_hours` STRING COMMENT 'Target resolution time in hours as defined by SLA for this case type.',
    `updated_by` STRING COMMENT 'User ID of the employee who last updated the case record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the case record.',
    `created_by` STRING COMMENT 'User ID of the employee who created the case record.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Customer service cases and complaint records tracking issue resolution from open to close — case type (product quality complaint, delivery shortage, billing dispute, recall notification, food safety consumer contact), priority, SLA tracking, root cause categorization, resolution actions, and escalation history. Covers B2B account issues (delivery, billing, quality) and B2C consumer complaints including FDA-reportable adverse events. Supports CAPA linkage for quality-driven cases.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`segment_assignment` (
    `segment_assignment_id` BIGINT COMMENT 'System-generated unique identifier for each segment assignment record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account to which the segment is assigned.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the segment assignment.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`preference` (
    `preference_id` BIGINT COMMENT 'Primary key for preference',
    `account_id` BIGINT COMMENT 'Identifier of the consumer to whom this preference belongs.',
    `age_group` STRING COMMENT 'Age segment of the consumer.. Valid values are `child|teen|adult|senior`',
    `alcohol_preference` STRING COMMENT 'Consumers preferred alcohol content level.. Valid values are `none|low|medium|high`',
    `allergen_free_flag` BOOLEAN COMMENT 'Indicates if the consumer avoids all allergens.',
    `caffeine_preference` STRING COMMENT 'Consumers preferred caffeine level.. Valid values are `none|low|medium|high`',
    `communication_opt_in_email` BOOLEAN COMMENT 'True if the consumer has opted in to receive email communications.',
    `communication_opt_in_push` BOOLEAN COMMENT 'True if the consumer has opted in to receive push notifications.',
    `communication_opt_in_sms` BOOLEAN COMMENT 'True if the consumer has opted in to receive SMS communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the preference record was first created.',
    `data_consent_ccpa` BOOLEAN COMMENT 'Indicates CCPA consent status for personal data processing.',
    `data_consent_gdpr` BOOLEAN COMMENT 'Indicates GDPR consent status for personal data processing.',
    `dietary_gluten_free_flag` BOOLEAN COMMENT 'Indicates if the consumer prefers gluten‑free products.',
    `dietary_halal_flag` BOOLEAN COMMENT 'Indicates if the consumer prefers halal‑certified products.',
    `dietary_kosher_flag` BOOLEAN COMMENT 'Indicates if the consumer prefers kosher‑certified products.',
    `dietary_vegan_flag` BOOLEAN COMMENT 'Indicates if the consumer prefers vegan products.',
    `gender` STRING COMMENT 'Self‑identified gender of the consumer.. Valid values are `male|female|nonbinary|prefer_not_to_say`',
    `health_condition_flag` BOOLEAN COMMENT 'True if the consumer has health‑related dietary restrictions (e.g., diabetic).',
    `income_bracket` STRING COMMENT 'Income level category of the consumer.. Valid values are `low|medium|high`',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|de|zh|other`',
    `last_preference_update_date` DATE COMMENT 'Date of the most recent preference change.',
    `loyalty_program_opt_in` BOOLEAN COMMENT 'Indicates if the consumer has opted into loyalty programs.',
    `notes` STRING COMMENT 'Free‑form notes about the consumers preferences.',
    `nps_opt_in` BOOLEAN COMMENT 'Indicates if the consumer consents to receive NPS surveys.',
    `organic_preference_flag` BOOLEAN COMMENT 'True if the consumer prefers organically certified products.',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record.. Valid values are `active|inactive|opt_out`',
    `preferred_flavor_profile` STRING COMMENT 'Flavor profile the consumer favors (e.g., sweet, salty, spicy). [ENUM-REF-CANDIDATE: sweet|salty|spicy|sour|umami|bitter|other — promote to reference product]',
    `preferred_pack_size` STRING COMMENT 'Typical pack size the consumer prefers when purchasing.. Valid values are `single|multi|family|bulk`',
    `preferred_product_category` STRING COMMENT 'Primary product category the consumer prefers (e.g., snacks, beverages, dairy). [ENUM-REF-CANDIDATE: snacks|beverages|dairy|convenience|organic|health|other — promote to reference product]',
    `preferred_purchase_channel` STRING COMMENT 'Channel through which the consumer most often purchases.. Valid values are `online|in_store|direct|mobile_app|call_center`',
    `source_system` STRING COMMENT 'Name of the source system that supplied the preference data.',
    `source_system_code` STRING COMMENT 'Identifier of the record in the source system.',
    `sugar_content_preference` STRING COMMENT 'Preferred sugar content level in products.. Valid values are `low|medium|high`',
    `sustainable_packaging_preference_flag` BOOLEAN COMMENT 'True if the consumer prefers sustainable/eco‑friendly packaging.',
    `timezone_preference` STRING COMMENT 'Preferred timezone of the consumer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the preference record.',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'DTC and B2C consumer dietary preferences, product affinities, and communication preferences — dietary flags (gluten-free, vegan, halal, kosher, allergen-free), preferred product categories, flavor preferences, pack size preferences, preferred purchase channel, communication opt-ins (email, SMS, push), and data consent flags (GDPR, CCPA). Supports personalization and clean label consumer targeting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` (
    `edi_trading_partner_id` BIGINT COMMENT 'System-generated unique identifier for the EDI trading partner configuration.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`recall_notification` (
    `recall_notification_id` BIGINT COMMENT 'Primary key for the RecallNotification association',
    `account_id` BIGINT COMMENT 'Foreign key linking to the customer account',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to the recall event',
    `acknowledgment_status` STRING COMMENT 'Current status of the accounts acknowledgment of the recall notification',
    `notification_date` TIMESTAMP COMMENT 'Date and time the recall notification was sent to the account',
    CONSTRAINT pk_recall_notification PRIMARY KEY(`recall_notification_id`)
) COMMENT 'Represents the notification sent from the company to a customer account about a specific recall event, capturing when the notification was sent and whether the account acknowledged it.. Existence Justification: Each recall event can affect many customer accounts, and a single account can be impacted by multiple recall events over time. The business actively tracks the date a notification was sent to an account and whether the account has acknowledged the recall. This information is managed as a distinct record linking an account to a recall event.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`customer`.`sponsorship` (
    `sponsorship_id` BIGINT COMMENT 'Primary key for the Sponsorship association',
    `account_id` BIGINT COMMENT 'Foreign key linking to the sponsoring account',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to the sponsored R&D project',
    `amount` DECIMAL(18,2) COMMENT 'Monetary contribution of the account to the project',
    CONSTRAINT pk_sponsorship PRIMARY KEY(`sponsorship_id`)
) COMMENT 'Represents the contractual sponsorship relationship between a customer account and an R&D project. Each record captures the amount contributed, the period of sponsorship, and the role of the sponsor.. Existence Justification: An account (customer) can sponsor multiple R&D projects and a single R&D project can receive sponsorship from multiple accounts. The sponsorship relationship is actively managed, with amounts, dates, and roles recorded for each sponsorship, and stakeholders track these records for revenue sharing and strategic reporting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `food_beverage_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_edi_trading_partner_id` FOREIGN KEY (`edi_trading_partner_id`) REFERENCES `food_beverage_ecm`.`customer`.`edi_trading_partner`(`edi_trading_partner_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `food_beverage_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `food_beverage_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ADD CONSTRAINT `fk_customer_loyalty_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ADD CONSTRAINT `fk_customer_loyalty_transaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `food_beverage_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ADD CONSTRAINT `fk_customer_nps_survey_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ADD CONSTRAINT `fk_customer_nps_survey_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ADD CONSTRAINT `fk_customer_nps_survey_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `food_beverage_ecm`.`customer`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_case_id` FOREIGN KEY (`case_id`) REFERENCES `food_beverage_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_interaction_customer_account_id` FOREIGN KEY (`interaction_customer_account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_related_case_id` FOREIGN KEY (`related_case_id`) REFERENCES `food_beverage_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` ADD CONSTRAINT `fk_customer_recall_notification_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` ADD CONSTRAINT `fk_customer_sponsorship_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Trading Partner Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'market_segmentation');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` SET TAGS ('dbx_subdomain' = 'loyalty_program');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier (Loyalty Program ID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Earn Rate');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `earn_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Earn Rate Currency');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `earn_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `earn_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Earn Rule Description');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `earn_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Earn Rule Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `earn_rule_type` SET TAGS ('dbx_value_regex' = 'purchase|referral|promotion|social|event|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|in_store|call_center|partner|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `loyalty_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `loyalty_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|retired');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `max_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Balance');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_balance_reset_flag` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Reset Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_expiry_days` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Days');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Policy');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_value_regex' = 'rolling|fixed|none|custom');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code (LPC)');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name (LPN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Type (LPT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'points|tier|cashback|hybrid|gift|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `redeem_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Redeem Rule Description');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `redeem_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Redeem Rule Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `redeem_rule_type` SET TAGS ('dbx_value_regex' = 'points_for_discount|free_product|gift|voucher|cashback|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_1_min_points` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Minimum Points');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_1_name` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_2_min_points` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Minimum Points');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_2_name` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_3_min_points` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Minimum Points');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_3_name` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_4_min_points` SET TAGS ('dbx_business_glossary_term' = 'Tier 4 Minimum Points');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_4_name` SET TAGS ('dbx_business_glossary_term' = 'Tier 4 Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_5_min_points` SET TAGS ('dbx_business_glossary_term' = 'Tier 5 Minimum Points');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_5_name` SET TAGS ('dbx_business_glossary_term' = 'Tier 5 Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_levels` SET TAGS ('dbx_business_glossary_term' = 'Number of Tier Levels');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Tier Structure Definition');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` SET TAGS ('dbx_subdomain' = 'loyalty_program');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrolling Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_store|call_center|partner');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Expiration Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `next_tier_threshold` SET TAGS ('dbx_business_glossary_term' = 'Next Tier Threshold');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_communication_preferences` SET TAGS ('dbx_business_glossary_term' = 'Communication Opt‑In Preference');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_communication_preferences` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `points_balance` SET TAGS ('dbx_business_glossary_term' = 'Points Balance');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `redemption_history_summary` SET TAGS ('dbx_business_glossary_term' = 'Redemption History Summary');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` SET TAGS ('dbx_subdomain' = 'loyalty_program');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile_app');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiration Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Indicator');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `order_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Reference Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `points_amount` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Amount');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Points Balance After Transaction');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `points_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Before Transaction');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Processing Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'success|failed|pending');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Reward Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'discount|gift|voucher|product');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|posted|cancelled|reversed');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earn|redeem|adjust|expire');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Triggering Event');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `triggering_event` SET TAGS ('dbx_value_regex' = 'purchase|referral|survey|promotion');
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` SET TAGS ('dbx_subdomain' = 'customer_feedback');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score Survey Response ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Segment Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Location Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `cadence` SET TAGS ('dbx_business_glossary_term' = 'Survey Cadence');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `cadence` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|ad_hoc');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `dispatch_method` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Method');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `dispatch_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|in_app|mail');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Effective End Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_value_regex' = 'none|call|email|survey|escalate');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `nps_classification` SET TAGS ('dbx_business_glossary_term' = 'NPS Classification');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `nps_classification` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'NPS Score');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_email` SET TAGS ('dbx_business_glossary_term' = 'Respondent Email Address');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent Full Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_phone` SET TAGS ('dbx_business_glossary_term' = 'Respondent Phone Number');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `respondent_type` SET TAGS ('dbx_value_regex' = 'b2b|b2c');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|in_app|mail');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_device_type` SET TAGS ('dbx_business_glossary_term' = 'Response Device Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet|phone|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Response IP Address');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_language` SET TAGS ('dbx_business_glossary_term' = 'Response Language');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_source` SET TAGS ('dbx_business_glossary_term' = 'Response Source');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_source` SET TAGS ('dbx_value_regex' = 'web|app|call_center|in_store');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Campaign ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Campaign Name');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'post_purchase|post_interaction|periodic|event|custom');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `target_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct|online|mobile');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_survey` ALTER COLUMN `verbatim_comments` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comments');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` SET TAGS ('dbx_subdomain' = 'customer_feedback');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `nps_response_id` SET TAGS ('dbx_business_glossary_term' = 'NPS Response ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Location Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `follow_up_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'NPS Category');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'NPS Score');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `respondent_type` SET TAGS ('dbx_value_regex' = 'b2b|b2c');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|web|in_app|post');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'new|reviewed|closed');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Dispatch Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`nps_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comment');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'customer_feedback');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Representative ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Case ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Opportunity ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|in_person|web|social_media|chat');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Number (ID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'logged|in_progress|completed|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `is_escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `is_internal_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Interaction Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `is_test_interaction` SET TAGS ('dbx_business_glossary_term' = 'Test Interaction Flag');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Notes');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority Level');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `product_upc` SET TAGS ('dbx_business_glossary_term' = 'Product UPC');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Interaction Rating');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'phone|email|in_person|web|social_media|chat');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` SET TAGS ('dbx_subdomain' = 'customer_feedback');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (CID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (AID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier (CAI)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `related_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case Identifier (RCI)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `attached_file_count` SET TAGS ('dbx_business_glossary_term' = 'Attached File Count (AFC)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category (CC)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_category` SET TAGS ('dbx_value_regex' = 'product|service|delivery|billing|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number (CN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status (CS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type (CT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'quality_complaint|delivery_shortage|billing_dispute|recall_notification|food_safety_contact');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel (SC)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|web_portal|social_media|in_store|mobile_app');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `channel_detail` SET TAGS ('dbx_business_glossary_term' = 'Channel Detail (CD)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp (CCT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description (CD)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Record Created Timestamp (CRCT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|MXN');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level (EL)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|management');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity (IS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Flag (DF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag (EF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `is_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Flag (FIF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `monetary_amount_refunded` SET TAGS ('dbx_business_glossary_term' = 'Refunded Monetary Amount (RFA)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `monetary_amount_requested` SET TAGS ('dbx_business_glossary_term' = 'Requested Monetary Amount (RMA)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes (CN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp (COT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Case Origin (CO)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority (CP)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `regulatory_report_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Type (RRT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `regulatory_report_type` SET TAGS ('dbx_value_regex' = 'adverse_event|labeling_error|contamination|recall|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag (RRF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action (RA)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp (RT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (RCC)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'manufacturing|packaging|labeling|distribution|supplier|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating (SR)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Hours (SAH)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Flag (SMF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours (STH)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID (UBU)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Record Updated Timestamp (CRUT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID (CBU)');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` SET TAGS ('dbx_subdomain' = 'market_segmentation');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `segment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` SET TAGS ('dbx_subdomain' = 'market_segmentation');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Identifier');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID (CID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group (AGE_GROUP)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `age_group` SET TAGS ('dbx_value_regex' = 'child|teen|adult|senior');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `alcohol_preference` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Preference (ALCOHOL_PREF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `alcohol_preference` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `allergen_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen-Free Preference Flag (ALLERGEN_FREE_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `caffeine_preference` SET TAGS ('dbx_business_glossary_term' = 'Caffeine Preference (CAFFEINE_PREF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `caffeine_preference` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `communication_opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Communication Opt-In Flag (EMAIL_OPT_IN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `communication_opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `communication_opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `communication_opt_in_push` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Flag (PUSH_OPT_IN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `communication_opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Communication Opt-In Flag (SMS_OPT_IN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Creation Timestamp (PRCT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `data_consent_ccpa` SET TAGS ('dbx_business_glossary_term' = 'CCPA Data Consent Flag (CCPA_CONSENT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `data_consent_gdpr` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Consent Flag (GDPR_CONSENT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `dietary_gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten-Free Dietary Preference Flag (GF_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `dietary_halal_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Dietary Preference Flag (HALAL_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `dietary_kosher_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Dietary Preference Flag (KOSHER_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `dietary_vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Dietary Preference Flag (VEGAN_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender (GENDER)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|nonbinary|prefer_not_to_say');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `health_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Condition Preference Flag (HEALTH_COND_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `health_condition_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `health_condition_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Income Bracket (INCOME_BRACKET)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `income_bracket` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG_PREF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `last_preference_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preference Update Date (LAST_UPDATE_DATE)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `loyalty_program_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Opt-In Flag (LOYALTY_OPT_IN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes (PREF_NOTES)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `nps_opt_in` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Opt-In Flag (NPS_OPT_IN)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `organic_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Preference Flag (ORGANIC_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status (PREF_STATUS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|opt_out');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preferred_flavor_profile` SET TAGS ('dbx_business_glossary_term' = 'Preferred Flavor Profile (PFP)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preferred_pack_size` SET TAGS ('dbx_business_glossary_term' = 'Preferred Pack Size (PPS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preferred_pack_size` SET TAGS ('dbx_value_regex' = 'single|multi|family|bulk');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preferred_product_category` SET TAGS ('dbx_business_glossary_term' = 'Preferred Product Category (PPC)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preferred_purchase_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Purchase Channel (PURCHASE_CH)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `preferred_purchase_channel` SET TAGS ('dbx_value_regex' = 'online|in_store|direct|mobile_app|call_center');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name (SRC_SYS)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (SRC_SYS_ID)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `sugar_content_preference` SET TAGS ('dbx_business_glossary_term' = 'Sugar Content Preference (SUGAR_PREF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `sugar_content_preference` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `sustainable_packaging_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Packaging Preference Flag (SUSTAINABLE_PACK_FLAG)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `timezone_preference` SET TAGS ('dbx_business_glossary_term' = 'Timezone Preference (TZ_PREF)');
ALTER TABLE `food_beverage_ecm`.`customer`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Update Timestamp (PRUT)');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'EDI Trading Partner Identifier');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
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
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` SET TAGS ('dbx_association_edges' = 'customer.account,regulatory.recall_event');
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` ALTER COLUMN `recall_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Recallnotification - Recall Notification Id');
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Recallnotification - Account Id');
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recallnotification - Recall Event Id');
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` SET TAGS ('dbx_association_edges' = 'customer.account,research.rd_project');
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship - Sponsorship Id');
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship - Account Id');
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship - Rd Project Id');
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Amount');
