-- Schema for Domain: customer | Business: Retail | Version: v2_mvm
-- Generated on: 2026-06-24 00:49:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_retail_v1`.`customer` COMMENT 'Single source of truth for all customer identity, profiles, households, segments (B2C and B2B), contact information, preferences, and RFM (Recency Frequency Monetary) analytics. Manages customer lifecycle, NPS scores, CLTV (Customer Lifetime Value), CAC (Customer Acquisition Cost), consent/privacy preferences, and omnichannel interaction history. Supports personalized clienteling and customer recognition across POS, e-commerce, and mobile.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique identifier for the customer profile. Primary key for the golden customer record in the customer master data system.',
    `household_id` BIGINT COMMENT 'Identifier linking this customer to a household group for family-level analytics and shared loyalty benefits.',
    `location_id` BIGINT COMMENT 'Identifier of the customers preferred or most frequently visited store location, used for localized assortment and clienteling.',
    `acquisition_channel` STRING COMMENT 'The channel through which the customer was originally acquired, used for CAC (Customer Acquisition Cost) analysis and channel effectiveness measurement.. Valid values are `store|ecommerce|mobile_app|social_media|referral|partner`',
    `acquisition_date` DATE COMMENT 'Date when the customer first engaged with the business, marking the start of the customer lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer profile record was first created in the master data management system.',
    `customer_role` STRING COMMENT 'Business relationship role the customer plays. Allowed values: consumer, employee, wholesale_buyer, corporate',
    `date_of_birth` DATE COMMENT 'Date of birth of the customer, used for age verification, lifecycle marketing, and personalized birthday promotions.',
    `effective_end_date` DATE COMMENT 'End date of this record version in the SCD Type-2 history; NULL or 9999-12-31 indicates the current active version.',
    `effective_start_date` DATE COMMENT 'Start date of this record version in the SCD Type-2 history; the date from which this version of the record is considered active.',
    `email_address` STRING COMMENT 'Primary email address for customer communication across all channels including e-commerce, loyalty programs, and promotional campaigns.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `entity_type` STRING COMMENT 'Legal entity classification of the customer. Allowed values: individual, organization. Valid values are `individual|corporate|employee|vip|wholesale`',
    `first_name` STRING COMMENT 'Legal first name or given name of the customer as recorded in the master data management system.',
    `full_name` STRING COMMENT 'Complete legal name of the customer, typically concatenated from first, middle, and last name components.',
    `gender` STRING COMMENT 'Self-identified gender of the customer, used for personalized merchandising and assortment planning.. Valid values are `male|female|non_binary|prefer_not_to_say|other|unknown`',
    `is_current` BOOLEAN COMMENT 'Flag indicating this is the current active version of the profile record.',
    `is_current_flag` BOOLEAN COMMENT 'Indicates whether this is the currently active version of the record in the SCD Type-2 history.',
    `last_name` STRING COMMENT 'Legal last name or family name of the customer as recorded in the master data management system.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the customer lifecycle journey, used for targeted marketing campaigns and retention strategies. [ENUM-REF-CANDIDATE: prospect|new|active|at_risk|dormant|churned|reactivated — 7 candidates stripped; promote to reference product]',
    `loyalty_tier` STRING COMMENT 'Current tier level in the loyalty program, determining benefits, discounts, and personalized services.. Valid values are `bronze|silver|gold|platinum|diamond`',
    `marketing_opt_in` STRING COMMENT '',
    `mdm_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-100) from the customer master data system indicating the quality and reliability of the golden record match and data completeness.',
    `mdm_last_match_date` TIMESTAMP COMMENT 'Timestamp of the last MDM matching and survivorship process execution that updated this golden record.',
    `mdm_source_system` STRING COMMENT 'Name of the primary source system that contributed the authoritative data for this golden record (e.g., the retail analytics platform, the e-commerce platform, POS).',
    `middle_name` STRING COMMENT 'Middle name or initial of the customer. Nullable field for customers without a middle name.',
    `mobile_number` BIGINT COMMENT 'Mobile phone number used for SMS notifications, mobile app authentication, and last-mile delivery coordination.',
    `nationality` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the customers nationality or citizenship.. Valid values are `^[A-Z]{3}$`',
    `phone_number` BIGINT COMMENT 'Primary contact phone number for customer service, order notifications, and BOPIS (Buy Online Pick Up In Store) communications.',
    `preferred_channel` STRING COMMENT '',
    `preferred_contact_method` STRING COMMENT 'Customers preferred method for receiving communications and notifications from the business.. Valid values are `email|phone|sms|mail|none`',
    `preferred_language` STRING COMMENT 'ISO 639-2 three-letter language code representing the customers preferred language for communication and marketing materials.. Valid values are `^[A-Z]{3}$`',
    `profile_status` STRING COMMENT 'Current operational status of the customer profile, controlling access to services and transactions across all channels.. Valid values are `active|inactive|suspended|blocked|closed`',
    `record_version` STRING COMMENT 'Monotonically increasing version number for this record in the SCD Type-2 history.',
    `scd_change_reason` STRING COMMENT 'Business reason for the change that created this version, supporting GDPR audit trail requirements.',
    `scd_change_timestamp` TIMESTAMP COMMENT 'Exact timestamp when this SCD Type-2 version was created, used for change-data-capture reconciliation and GDPR audit trails.',
    `scd_changed_by` STRING COMMENT 'Identifier of the user or system process that triggered this SCD Type-2 version change, supporting GDPR accountability requirements.',
    `version_number` STRING COMMENT 'Sequential version identifier for SCD Type-2 tracking of this record.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Core customer identity record. Represents a single known individual or organization with master attributes. B2C customers typically have only a profile; B2B relationships additionally use the account entity.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the account. Primary key.',
    `address_id` BIGINT COMMENT 'Reference to the default billing address for this account. Used for invoicing, credit checks, and payment processing. Null if no billing address on file.',
    `payment_method_id` DECIMAL(18,2) COMMENT 'Reference to the customers default payment method for this account (e.g., credit card on file, bank account). Null if no default set. Used for one-click checkout and recurring billing.',
    `location_id` BIGINT COMMENT 'Reference to the customers preferred or home store location for in-store pickup, returns, and personalized store-based services. Null if no preference set.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Retail B2B accounts with contract_pricing_flag, employee_discount_eligible, or loyalty_program_enrolled are assigned specific price lists. Pricing teams and POS systems resolve the correct price list ',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile who owns this account. One customer may have multiple accounts (e.g., personal and business).',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to store.sales_territory. Business justification: B2B sales territory management assigns customer accounts to territories for sales rep coverage, quota tracking, and revenue reporting. sales_territory.customer_count implies accounts are territory-sco',
    `shipping_address_id` BIGINT COMMENT 'Reference to the default shipping address for this account. Used for order fulfillment and delivery. Null if no default shipping address set.',
    `account_number` BIGINT COMMENT 'Externally-visible unique account number used for customer communication, statements, and customer service lookup. Distinct from internal account_id.',
    `account_status` BIGINT COMMENT 'Current status of the B2B account: active, suspended, closed, pending_approval. Only active accounts may place wholesale orders.',
    `account_type` BIGINT COMMENT 'Type of business account. Values: corporate, wholesale, franchise, reseller.',
    `b2b_pricing_flag` BOOLEAN COMMENT 'Always TRUE for account records since accounts exist only for B2B relationships. Retained for backward compatibility with legacy integrations.',
    `close_date` DATE COMMENT 'Date when the account was permanently closed. Null for active accounts. Used for churn analysis and account lifecycle reporting.',
    `company_name` STRING COMMENT 'Legal company or organization name for B2B/wholesale accounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit extended to this B2B account for net-terms purchasing. NULL for prepay-only accounts.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accounts base currency (e.g., USD, EUR, GBP). All monetary transactions and balances for this account are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'End date of this record version in the SCD Type-2 history; NULL or 9999-12-31 indicates the current active version.',
    `effective_start_date` DATE COMMENT 'Start date of this record version in the SCD Type-2 history; the date from which this version of the record is considered active.',
    `employee_discount_eligible` DECIMAL(18,2) COMMENT 'Indicates whether this account is eligible for employee discount pricing. True for employee accounts and authorized family members; false otherwise.',
    `is_current` BOOLEAN COMMENT 'Flag indicating this is the current active version of the account record.',
    `is_current_flag` BOOLEAN COMMENT 'Indicates whether this is the currently active version of the record in the SCD Type-2 history.',
    `loyalty_program_enrolled` BOOLEAN COMMENT 'Indicates whether this account is enrolled in the retailers loyalty or rewards program. True if enrolled; false otherwise. Used for loyalty analytics and targeted promotions.',
    `notes` STRING COMMENT 'Free-text field for internal notes about the account (e.g., special handling instructions, VIP preferences, service history, escalation notes). Used by customer service and account management teams.',
    `open_date` DATE COMMENT 'Date when the account was first opened and activated. Used for account age calculations, tenure-based benefits, and lifecycle analytics.',
    `record_version` STRING COMMENT 'Monotonically increasing version number for this record in the SCD Type-2 history.',
    `scd_change_reason` STRING COMMENT 'Business reason for the change that created this version, supporting GDPR audit trail requirements.',
    `scd_change_timestamp` TIMESTAMP COMMENT 'Exact timestamp when this SCD Type-2 version was created, used for change-data-capture reconciliation and GDPR audit trails.',
    `scd_changed_by` STRING COMMENT 'Identifier of the user or system process that triggered this SCD Type-2 version change, supporting GDPR accountability requirements.',
    `suspension_date` DATE COMMENT 'Date when the account was most recently suspended. Null if never suspended or currently active. Used for compliance and risk management reporting.',
    `suspension_reason` STRING COMMENT 'Free-text explanation of why the account was suspended (e.g., payment default, fraud investigation, customer request, policy violation). Null if never suspended.',
    `tax_exempt_certificate_number` DECIMAL(18,2) COMMENT 'Government-issued tax exemption certificate number for tax-exempt accounts. Null for non-exempt accounts. Required for audit and compliance verification.',
    `tax_exempt_expiry_date` DECIMAL(18,2) COMMENT 'Expiration date of the tax exemption certificate. Null for non-exempt accounts or perpetual exemptions. Used for compliance monitoring and renewal reminders.',
    `tax_exempt_flag` DECIMAL(18,2) COMMENT 'Indicates whether this account is exempt from sales tax (e.g., non-profit organizations, government entities, resellers with valid tax exemption certificates). True if exempt; false otherwise.',
    `version_number` STRING COMMENT 'Sequential version identifier for SCD Type-2 tracking of this record.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Optional B2B/wholesale account entity. Exists only for corporate, wholesale, or multi-user business relationships. Most B2C customers do not have an account record; their identity lives solely on the profile.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`household` (
    `household_id` BIGINT COMMENT 'Unique surrogate key identifying a household grouping of customer profiles.',
    `location_id` BIGINT COMMENT 'Reference to the store location nearest to or preferred by this household.',
    `average_basket_value` DECIMAL(18,2) COMMENT 'Average transaction basket value across all household members.',
    `combined_cltv` DECIMAL(18,2) COMMENT 'Combined customer lifetime value estimate aggregated across all household members.',
    `communication_preference` STRING COMMENT 'Preferred communication channel for household-level outreach (e.g. email, mail, phone, sms).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system.',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the household has consented to data sharing for analytics purposes.',
    `effective_end_date` TIMESTAMP COMMENT 'SCD Type 2 effective end timestamp; NULL indicates the current active version.',
    `effective_start_date` TIMESTAMP COMMENT 'SCD Type 2 effective start timestamp for this version of the household record.',
    `estimated_income_band` STRING COMMENT 'Estimated household income bracket used for segmentation (e.g. low, medium, high, affluent).',
    `external_household_code` STRING COMMENT 'Identifier for this household in an external system or third-party data provider.',
    `household_status` STRING COMMENT 'Current lifecycle status of the household record (e.g. active, inactive, merged, dissolved).',
    `household_type` STRING COMMENT 'Classification of the household (e.g. single, family, multi-generational, shared).',
    `is_current_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active version of the household record (SCD Type 2).',
    `last_purchase_date` DATE COMMENT 'Most recent purchase date across all household members.',
    `loyalty_tier` STRING COMMENT 'Highest loyalty program tier achieved by any member of the household.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the household has opted in to receive marketing communications.',
    `household_name` STRING COMMENT 'Display name or surname associated with the household grouping.',
    `preferred_channel` STRING COMMENT 'Preferred shopping channel for the household (e.g. in_store, online, omnichannel).',
    `primary_language` STRING COMMENT 'Primary language spoken in the household, used for communication preferences.',
    `record_version` STRING COMMENT 'Monotonically increasing version number for SCD Type 2 tracking of household changes.',
    `segment` STRING COMMENT 'Marketing or behavioral segment classification assigned to this household.',
    `size` STRING COMMENT 'Number of individuals (customer profiles) associated with this household.',
    `total_loyalty_points` DECIMAL(18,2) COMMENT 'Aggregate loyalty points balance across all household members.',
    `total_purchase_count` DECIMAL(18,2) COMMENT 'Total number of purchases made by all household members combined.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total monetary spend across all household members over the lifetime of the household.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this household record.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Represents a household grouping of one or more customer profiles sharing a residence or economic unit. Enables household-level analytics, marketing, and deduplication across individual profiles.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`corporate_account` (
    `corporate_account_id` DECIMAL(18,2) COMMENT 'Unique identifier for the B2B corporate customer account. Primary key for the corporate account entity.',
    `address_id` BIGINT COMMENT 'FK to customer.address',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: B2B account management assigns corporate accounts to a primary store location for dedicated servicing, sales rep assignment, and account-level revenue reporting. No existing FK from corporate_account ',
    `account_id` BIGINT COMMENT 'Reference to the parent corporate account if this account is part of a multi-location or subsidiary hierarchy. Null for standalone accounts or top-level parent accounts. Enables consolidated billing and enterprise-wide reporting.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: corporate_account.contract_pricing_flag explicitly signals a negotiated price list is assigned. B2B retail operations require corporate accounts to reference their contracted price list for order pric',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Corporate accounts have a designated primary contact person. Currently, corporate_account stores primary_contact_name, primary_contact_email, primary_contact_phone as denormalized columns. Adding prim',
    `shipping_address_id` BIGINT COMMENT 'FK to customer.address',
    `account_established_date` BIGINT COMMENT 'Date when the corporate account was first created in the system. Used to calculate customer tenure and lifetime value metrics.',
    `annual_spend_tier` DECIMAL(18,2) COMMENT 'Classification of the corporate account based on annual purchase volume. Used to determine discount levels, service priority, and account management resources. Tier_1 = highest spend (>$1M), Tier_5 = lowest spend (<$10K). Tiers recalculated annually.',
    `business_entity_type` STRING COMMENT 'Legal structure of the corporate entity. Values: sole_proprietorship, partnership, llc (Limited Liability Company), corporation (C-Corp), s_corp (S-Corporation), non_profit (501c3 or similar), government (public sector entity). [ENUM-REF-CANDIDATE: sole_proprietorship|partnership|llc|corporation|s_corp|non_profit|government — 7 candidates stripped; promote to reference product]',
    `contract_pricing_flag` BOOLEAN COMMENT 'Indicates whether the corporate account has negotiated contract pricing that overrides standard catalog prices. True = custom pricing agreement in place; False = standard pricing applies.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this corporate account record was first created in the database. Used for audit trail and data lineage tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the corporate account before requiring payment or credit hold. Expressed in USD. Null if account is cash-only.',
    `credit_status` DECIMAL(18,2) COMMENT 'Current credit approval status for the corporate account. Determines whether the customer can purchase on credit terms. Values: approved (credit line active), pending (application submitted), declined (credit denied), under_review (periodic credit review in progress), suspended (credit privileges temporarily revoked).',
    `dba_name` STRING COMMENT 'Trade name or fictitious business name under which the corporate customer operates, if different from legal name. Used for marketing and customer-facing communications.',
    `duns_number` BIGINT COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to establish business credit profile and track commercial credit history. Used for supplier onboarding and credit evaluation.',
    `industry_classification_naics` STRING COMMENT 'Six-digit code classifying the corporate customers primary industry using the NAICS standard. Provides more granular industry segmentation than SIC for modern business categories.. Valid values are `^[0-9]{6}$`',
    `industry_classification_sic` STRING COMMENT 'Four-digit code classifying the corporate customers primary industry sector using the U.S. Standard Industrial Classification system. Used for market segmentation and industry analysis.. Valid values are `^[0-9]{4}$`',
    `last_order_date` DATE COMMENT 'Date of the most recent purchase order placed by this corporate account. Used for recency analysis and dormant account identification.',
    `legal_business_name` STRING COMMENT 'The official registered legal name of the corporate entity as it appears on government filings and tax documents. Used for contracts, invoicing, and legal compliance.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment terms negotiated with the corporate customer. Values: net_30 (payment due 30 days after invoice), net_45, net_60, net_90, due_on_receipt (immediate payment), prepay (payment before shipment), custom (non-standard terms documented separately). [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_90|due_on_receipt|prepay|custom — 7 candidates stripped; promote to reference product]',
    `preferred_delivery_method` STRING COMMENT 'Default shipping method preference for corporate orders. Values: standard_ground, expedited, next_day, freight (for large/bulk orders), customer_pickup (will-call).. Valid values are `standard_ground|expedited|next_day|freight|customer_pickup`',
    `tax_exempt_certificate_number` DECIMAL(18,2) COMMENT 'Government-issued tax exemption certificate number. Required for tax-exempt accounts to validate exemption status during order processing and audits.',
    `tax_exempt_flag` DECIMAL(18,2) COMMENT 'Indicates whether the corporate account is exempt from sales tax (e.g., government entities, non-profits with valid exemption certificates). True = tax exempt; False = taxable.',
    `tax_identifier` DECIMAL(18,2) COMMENT 'Federal tax identification number (EIN) assigned by the IRS for business tax reporting and compliance. Format: XX-XXXXXXX.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this corporate account record was last modified. Used for change tracking and data synchronization across systems.',
    CONSTRAINT pk_corporate_account PRIMARY KEY(`corporate_account_id`)
) COMMENT 'B2B corporate customer entity representing business clients such as small businesses, restaurants, and institutional buyers purchasing from Retail. Stores legal business name, tax ID / EIN, DUNS number, industry classification (SIC/NAICS), credit terms, assigned account manager, annual spend tier, contract pricing flag, and parent-subsidiary hierarchy reference. Supports B2B procurement workflows distinct from B2C consumer accounts. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact method record. Primary key.',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile or corporate account that owns this contact method. Links to the customer master record in the customer master data system.',
    `bounce_count` STRING COMMENT 'The cumulative number of times communication attempts via this contact method have bounced or failed. Used to trigger contact validation workflows and suppress invalid addresses.',
    `consent_source` STRING COMMENT 'The channel or touchpoint where the customer provided consent for this contact method (e.g., web registration, mobile app, POS, call center, in-store signup). Supports consent audit trails. [ENUM-REF-CANDIDATE: web|mobile_app|pos|call_center|email|in_store|third_party — 7 candidates stripped; promote to reference product]',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact method. Active indicates usable for communication; bounced/invalid indicates delivery failure; suppressed indicates customer request or compliance block; pending_verification indicates awaiting confirmation.. Valid values are `active|inactive|bounced|invalid|suppressed|pending_verification`',
    `contact_type` STRING COMMENT 'The type or category of contact method (e.g., primary email, mobile phone, work phone, WhatsApp, SMS, fax). Determines the channel and priority for omnichannel outreach. [ENUM-REF-CANDIDATE: primary_email|secondary_email|mobile|home_phone|work_phone|whatsapp|sms|fax — 8 candidates stripped; promote to reference product]',
    `country_code` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country associated with this contact method (e.g., USA, GBR, CAN). Used for regional compliance and localization of communications.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact method record was first created in the system. Supports audit trails and data lineage.',
    `effective_end_date` DATE COMMENT 'The date when this contact method ceased to be active or valid. Nullable for currently active contact methods. Supports temporal tracking and historical analysis.',
    `effective_start_date` DATE COMMENT 'The date from which this contact method became active and valid for customer communication. Supports temporal tracking and historical analysis.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary contact method for the customer. Used to prioritize communication channels in omnichannel campaigns and clienteling.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the contact method has been verified (e.g., email verification link clicked, phone number confirmed via OTP). Ensures data quality for marketing and transactional communications.',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the customers preferred language for communications via this contact method (e.g., en, es, fr). Supports personalized omnichannel outreach.. Valid values are `^[a-z]{2}$`',
    `last_bounce_date` DATE COMMENT 'The date of the most recent bounce or delivery failure for this contact method. Nullable if no bounces have occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact method record was last updated. Supports change tracking and audit trails.',
    `last_used_date` DATE COMMENT 'The date when this contact method was last successfully used for customer communication (email sent, SMS delivered, call completed). Helps identify stale or inactive contact points.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority order of this contact method relative to other contact methods for the same customer. Lower numbers indicate higher priority. Used for fallback logic in omnichannel campaigns.',
    `source_system_code` STRING COMMENT 'The unique identifier for this contact method in the source system. Enables traceability and cross-system reconciliation.',
    `value` DECIMAL(18,2) COMMENT 'The actual contact value (email address, phone number, social handle, etc.).',
    `verification_date` DATE COMMENT 'The date when the contact method was last verified by the customer. Used to track data freshness and trigger re-verification workflows.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Stores all contact points for a customer profile or corporate account including email addresses, phone numbers, and social handles. Each row represents a single contact method with type (primary email, mobile, work phone, WhatsApp), verification status, opt-in/opt-out flags per channel, verification date, and source system. Supports omnichannel outreach, CRM campaigns via the case management system, and GDPR/CCPA consent enforcement at the contact-method level. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'Unique identifier for the address record. Primary key.',
    `profile_id` BIGINT COMMENT 'Reference to the customer or corporate account associated with this address.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active addresses are available for use in orders and shipments.. Valid values are `active|inactive|archived|pending_verification`',
    `address_type` STRING COMMENT 'Classification of the address purpose: billing, shipping, store pickup (BOPIS/ROPIS), home, work, or mailing.. Valid values are `billing|shipping|home|work|store_pickup|mailing`',
    `city` STRING COMMENT 'City or municipality name for the address.',
    `country_code` BIGINT COMMENT 'Three-letter ISO country code (e.g., USA, CAN, GBR) identifying the country of the address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the system.',
    `delivery_instructions` STRING COMMENT 'Special delivery instructions provided by the customer (e.g., gate code, leave at door, ring bell).',
    `delivery_point_barcode` STRING COMMENT 'USPS Delivery Point Barcode (DPBC) or equivalent postal barcode for automated mail sorting and delivery.',
    `effective_end_date` TIMESTAMP COMMENT 'End date of this record version in the SCD Type-2 history; NULL or 9999-12-31 indicates the current active version.',
    `effective_start_date` TIMESTAMP COMMENT 'Start date of this record version in the SCD Type-2 history; the date from which this version of the record is considered active.',
    `is_current_flag` BOOLEAN COMMENT 'Indicates whether this is the currently active version of the record in the SCD Type-2 history.',
    `is_default_billing` BOOLEAN COMMENT 'Flag indicating whether this address is the default billing address for the customer.',
    `is_default_shipping` BOOLEAN COMMENT 'Flag indicating whether this address is the default shipping destination for the customer.',
    `last_used_date` DATE COMMENT 'Date when this address was last used in a transaction (order, shipment, or billing event).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for geolocation and last-mile delivery optimization.',
    `line_1` STRING COMMENT 'Primary street address line including street number, street name, and unit/apartment number.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as building name, floor, suite, or department.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for geolocation and last-mile delivery optimization.',
    `military_address_flag` BOOLEAN COMMENT 'Indicates whether the address is a military address (APO/FPO/DPO). Requires special handling for international military mail.',
    `nickname` STRING COMMENT 'Customer-provided friendly name for the address (e.g., Home, Office, Moms House) for easy identification.',
    `po_box_flag` BOOLEAN COMMENT 'Indicates whether the address is a PO Box. Some carriers and products cannot deliver to PO Boxes.',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for the address. Used for delivery routing and tax jurisdiction determination.',
    `record_version` STRING COMMENT 'Monotonically increasing version number for this record in the SCD Type-2 history.',
    `residential_flag` BOOLEAN COMMENT 'Indicates whether the address is a residential location (true) or commercial/business location (false). Impacts shipping rates and delivery windows.',
    `scd_change_reason` STRING COMMENT 'Business reason for the change that created this version, supporting GDPR audit trail requirements.',
    `scd_change_timestamp` TIMESTAMP COMMENT 'Exact timestamp when this SCD Type-2 version was created, used for change-data-capture reconciliation and GDPR audit trails.',
    `scd_changed_by` STRING COMMENT 'Identifier of the user or system process that triggered this SCD Type-2 version change, supporting GDPR accountability requirements.',
    `standardization_flag` BOOLEAN COMMENT 'Indicates whether the address has been standardized to postal service formatting rules (USPS Publication 28, etc.).',
    `state_province` STRING COMMENT 'State, province, or region code or name. For US addresses, use two-letter state abbreviation (e.g., CA, NY).',
    `tax_jurisdiction_code` DECIMAL(18,2) COMMENT 'Tax jurisdiction identifier derived from the address, used to determine applicable sales tax rates and rules.',
    `validation_status` STRING COMMENT 'Status of address validation against postal service standards (USPS, Canada Post, etc.). Validated addresses reduce delivery failures.. Valid values are `validated|unvalidated|invalid|pending`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the address was last verified against postal service databases or address validation services.',
    `version_number` STRING COMMENT 'Sequential version identifier for SCD Type-2 tracking of this record.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Customer postal/delivery address with SCD Type 2 versioning for full change history and GDPR audit trails.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Primary key for segment',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Retail segment-based pricing assigns a specific price list to each customer segment (VIP, B2B, discount-sensitive). The price_list.loyalty_tier_code and segment.discount_sensitivity confirm this desig',
    `auto_refresh_flag` BOOLEAN COMMENT 'Indicates whether customer membership in this segment is automatically recalculated on a scheduled basis (True) or manually managed (False). True for dynamic segments (e.g., RFM tiers recalculated nightly); False for static segments (e.g., one-time campaign lists).',
    `average_aov` DECIMAL(18,2) COMMENT 'Mean Average Order Value for customers in this segment over the measurement period. Key metric for pricing strategy, promotion design, and basket optimization. Expressed in base currency (USD).',
    `average_cltv` DECIMAL(18,2) COMMENT 'Mean Customer Lifetime Value across all customers currently assigned to this segment. Used for segment valuation, investment prioritization, and ROI forecasting. Expressed in base currency (USD).',
    `average_purchase_frequency` DECIMAL(18,2) COMMENT 'Mean number of transactions per customer in this segment over the measurement period (typically 12 months). Used for replenishment forecasting, loyalty program design, and churn prediction.',
    `avg_basket_size` STRING COMMENT 'Average basket size for the segment in the customer domain (avg basket size).',
    `avg_transaction_value` DECIMAL(18,2) COMMENT '',
    `b2b_b2c_indicator` STRING COMMENT 'Indicates whether this segment applies to B2B customers (business accounts, wholesale, corporate), B2C customers (individual consumers), or both. Drives differentiated engagement strategies, pricing models, and service levels.. Valid values are `b2b|b2c|both`',
    `ccpa_opt_out_honored_flag` BOOLEAN COMMENT 'Indicates whether this segment respects CCPA Do Not Sell My Personal Information opt-out requests (True) or is exempt (False, e.g., service-related communications). Ensures compliance for California residents.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Aggregate churn risk score for this segment, ranging from 0.00 (no risk) to 100.00 (high risk). Calculated from recency, frequency, and engagement metrics. Drives retention campaign prioritization and at-risk customer interventions.',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the segment for operational use (e.g., VIP_GOLD, LAPSED_90D, HIGH_VALUE_B2B). Used in marketing campaigns, pricing rules, and POS systems.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this segment definition was first created in the system. Audit trail for segment lifecycle tracking and governance.',
    `segment_description` STRING COMMENT 'Detailed narrative describing the segments defining characteristics, business rationale, and strategic purpose. Includes target customer profile, expected behaviors, and recommended engagement strategies.',
    `discount_sensitivity` DECIMAL(18,2) COMMENT 'Behavioral classification of segments responsiveness to promotional pricing. High: primarily purchases on promotion (Hi-Lo shoppers). Medium: balanced full-price and promotional purchases. Low: primarily full-price purchases (EDLP preference or premium segment).',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or superseded. Null for currently active segments. Enables segment lifecycle management and historical reporting.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became active and available for customer assignment. Supports temporal segmentation strategies and historical analysis.',
    `gdpr_consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer consent is required under GDPR for marketing communications to this segment (True) or whether legitimate interest or other legal basis applies (False). Ensures regulatory compliance for EU customers.',
    `geographic_scope` STRING COMMENT 'Geographic boundary or region to which this segment applies (e.g., USA, Northeast Region, Urban Markets, Global). Supports localized segmentation strategies and regional campaign targeting. Use ISO 3166-1 alpha-3 country codes where applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this segment definition was last updated (criteria, name, status, or any other attribute). Supports change tracking and audit compliance.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when segment membership was last recalculated and customer assignments were updated. Critical for data freshness validation and SLA monitoring.',
    `max_rfm_score` DECIMAL(18,2) COMMENT 'Maximum RFM composite score for customer assignment to this segment (if segment_type is rfm_tier). Defines the upper bound of the RFM tier. Null for non-RFM segments.',
    `member_count` STRING COMMENT '',
    `membership_count` BIGINT COMMENT 'Current count of customers assigned to this segment. Updated periodically based on auto-refresh schedule. Used for segment sizing, campaign planning, and capacity forecasting.',
    `min_rfm_score` DECIMAL(18,2) COMMENT 'Minimum RFM composite score required for customer assignment to this segment (if segment_type is rfm_tier). RFM scores typically range from 3 (lowest: 1-1-1) to 15 (highest: 5-5-5). Null for non-RFM segments.',
    `segment_name` STRING COMMENT 'Human-readable name of the segment (e.g., VIP Gold Tier, Lapsed Customers - 90 Days, High-Value B2B Accounts). Used in reporting, dashboards, and customer-facing communications.',
    `nps_score` DECIMAL(18,2) COMMENT 'Average Net Promoter Score for customers in this segment, ranging from -100.00 (all detractors) to +100.00 (all promoters). Measures customer satisfaction, loyalty, and likelihood to recommend. Used for segment health monitoring and experience improvement prioritization.',
    `owning_business_unit` STRING COMMENT 'Name of the business unit or department responsible for defining, maintaining, and governing this segment (e.g., Marketing Analytics, Customer Insights, Loyalty Program Management). Establishes accountability for segment quality and usage.',
    `priority_tier` STRING COMMENT 'Service and engagement priority level assigned to this segment. Platinum: highest CLTV, white-glove service. Gold: high-value, priority support. Silver: mid-value, standard service. Bronze: emerging value. Standard: baseline service. Drives clienteling strategies and resource allocation.. Valid values are `platinum|gold|silver|bronze|standard`',
    `qualification_criteria` STRING COMMENT 'Summary of the business rules and thresholds used to assign customers to this segment (e.g., Purchased in last 30 days AND total spend > $5000 in last 12 months, RFM Score >= 9, Age 25-34 AND lives in urban area). Human-readable representation of the segmentation logic.',
    `refresh_frequency` DECIMAL(18,2) COMMENT 'Cadence at which segment membership is recalculated for auto-refresh segments. Daily: high-velocity behavioral segments. Weekly: standard RFM tiers. Monthly: demographic or lifecycle segments. Quarterly: strategic value tiers. On-Demand: manual trigger only.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition. Active: in production use for customer assignment and campaigns. Inactive: temporarily suspended, no new assignments. Archived: retired, historical reference only. Draft: under development, not yet released.. Valid values are `active|inactive|archived|draft`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology applied. RFM Tier: Recency, Frequency, Monetary analysis. Demographic: age, gender, income. Behavioral: purchase patterns, product affinity. Psychographic: lifestyle, values. Lifecycle Stage: new, active, at-risk, lapsed. Geographic: region, climate zone. Channel Preference: omnichannel, e-commerce-only, store-only. Value Tier: CLTV-based stratification. [ENUM-REF-CANDIDATE: rfm_tier|demographic|behavioral|psychographic|lifecycle_stage|geographic|channel_preference|value_tier — 8 candidates stripped; promote to reference product]',
    `target_marketing_channel` STRING COMMENT 'Primary communication channel recommended for engaging customers in this segment. Aligns segment strategy with channel preference and regulatory consent. All Channels: omnichannel engagement strategy. [ENUM-REF-CANDIDATE: email|sms|push_notification|direct_mail|in_store|call_center|social_media|all_channels — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Defines market segmentation classifications applied to customer profiles for targeted marketing, personalized pricing, and assortment decisions. Stores segment code, segment name, segment type (RFM tier, demographic, behavioral, psychographic, lifecycle stage, geographic, channel preference, value tier), segment description, qualification criteria summary, membership count, effective date range, auto-refresh flag, owning business unit, and profile-to-segment assignments with effective dates and expiry dates. Enables Retail to execute clienteling strategies, personalized promotions, and differentiated service levels across POS and e-commerce channels. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for the customer interaction event. Primary key.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: In-store customer service tracking and department-level NPS/sentiment reporting requires knowing which department an interaction occurred in. Retail operations teams report on service quality and comp',
    `location_id` BIGINT COMMENT 'Identifier of the physical store location where the interaction occurred. Applicable for in-store interactions (POS visit, clienteling visit, in-store event). Null for digital interactions.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who participated in this interaction. Links to the customer master record.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Campaign response tracking — email opens, clicks, and digital interactions are attributed to specific promotional campaigns in retail. This FK enables campaign engagement reporting, A/B test analysis,',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Customer service operations log interactions (calls, chats, emails) against specific RMAs — a named retail customer service process. Enables RMA-level interaction history reporting, SLA tracking, and ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Product Interaction Tracking: retail customer service and digital analytics require linking interaction events (product views, support calls, complaints, returns inquiries) to the specific SKU involve',
    `browser` STRING COMMENT 'The web browser used by the customer during this interaction (e.g., Chrome, Safari, Firefox, Edge). Applicable for web-based interactions. Null for non-web interactions.',
    `channel` STRING COMMENT 'The channel or medium through which the interaction occurred (e.g., store, web, mobile app, call center, email, SMS, push notification, social media, kiosk). [ENUM-REF-CANDIDATE: store|web|mobile_app|call_center|email|sms|push|social_media|kiosk|chat|video — promote to reference product]. Valid values are `store|web|mobile_app|call_center|email|sms`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this interaction record was first created in the data platform. Audit field for data lineage and compliance.',
    `delivery_status` STRING COMMENT 'The delivery and engagement status for outbound communication interactions (email, SMS, push notification). Indicates whether the message was delivered, opened, clicked, bounced, or failed. Null for inbound or non-message interactions.. Valid values are `delivered|opened|clicked|bounced|failed|pending`',
    `device_type` STRING COMMENT 'The type of device used by the customer during this interaction (e.g., desktop, mobile, tablet, kiosk, POS terminal). Applicable for digital and in-store interactions. Null if device type is unknown.. Valid values are `desktop|mobile|tablet|kiosk|pos_terminal|other`',
    `digital_property` STRING COMMENT 'The specific digital asset or platform where the interaction occurred (e.g., main website, mobile app, partner site, social media platform name). Applicable for digital interactions. Null for in-store interactions.',
    `direction` STRING COMMENT 'Indicates whether the interaction was initiated by the customer (inbound) or by Retail (outbound).. Valid values are `inbound|outbound`',
    `duration_seconds` DECIMAL(18,2) COMMENT 'The length of the interaction in seconds. Applicable for sessions, calls, chats, and visits. Null for instantaneous events (e.g., email send, SMS send).',
    `email_clicked_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer clicked a link within an outbound email. Applicable only for email interactions. Null for non-email interactions.',
    `email_opened_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an outbound email was opened by the customer. Applicable only for email interactions. Null for non-email interactions.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate of the customer location at the time of this interaction, if available. Applicable for mobile app interactions with location services enabled. Null if location data is unavailable.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate of the customer location at the time of this interaction, if available. Applicable for mobile app interactions with location services enabled. Null if location data is unavailable.',
    `interaction_timestamp` TIMESTAMP COMMENT 'The date and time when the interaction event occurred. This is the business event timestamp (when the customer engaged), distinct from record audit timestamps.',
    `interaction_type` STRING COMMENT 'The category of customer touchpoint or engagement event. Defines the nature of the interaction (e.g., POS visit, website session, app open, call center contact, email send, SMS send, push notification, chat, clienteling visit, NPS survey response). [ENUM-REF-CANDIDATE: pos_visit|website_session|mobile_app_open|call_center_contact|email_campaign|sms_campaign|push_notification|live_chat|clienteling_visit|nps_survey|social_media_engagement|kiosk_interaction|video_call|in_store_event — promote to reference product]. Valid values are `pos_visit|website_session|mobile_app_open|call_center_contact|email_campaign|sms_campaign`',
    `ip_address` STRING COMMENT 'The IP address of the customer device during this interaction. Applicable for digital interactions. Null for in-store interactions. May be considered PII in some jurisdictions.',
    `landing_page_url` STRING COMMENT 'The URL of the first page visited by the customer during this interaction session. Applicable for web-based interactions. Null for non-web interactions.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the associate or agent during or after the interaction. Captures additional context, customer requests, or follow-up actions. Null if no notes were recorded.',
    `nps_score` DECIMAL(18,2) COMMENT 'The Net Promoter Score (NPS) provided by the customer during or after this interaction, if applicable. Scale 0-10. Null if no NPS was collected.',
    `operating_system` STRING COMMENT 'The operating system of the device used during this interaction (e.g., Windows, macOS, iOS, Android). Applicable for digital interactions. Null for non-digital interactions.',
    `outcome` STRING COMMENT 'The result or resolution status of the interaction (e.g., completed, abandoned, escalated, resolved, converted, bounced, unsubscribed). [ENUM-REF-CANDIDATE: completed|abandoned|escalated|resolved|converted|bounced|unsubscribed|pending|transferred|no_response — promote to reference product]',
    `referrer_url` STRING COMMENT 'The URL of the page or source that referred the customer to this interaction (e.g., search engine, social media, email link). Applicable for web-based interactions. Null for non-web interactions.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'A numeric score representing the sentiment or emotional tone of the interaction, derived from text analytics or voice analytics. Scale typically -1.0 (negative) to +1.0 (positive). Null if sentiment analysis was not performed.',
    `sms_delivered_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an outbound SMS message was successfully delivered to the customer. Applicable only for SMS interactions. Null for non-SMS interactions.',
    `subject` STRING COMMENT 'A brief subject or title describing the purpose or topic of the interaction (e.g., product inquiry, order status check, complaint, feedback). Applicable for call center contacts, service cases, and clienteling visits. Null for automated or non-subject-based interactions.',
    `unsubscribed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer unsubscribed from communications as a result of this interaction. Applicable for outbound communication interactions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this interaction record was last updated in the data platform. Audit field for data lineage and compliance.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Records every customer touchpoint, engagement event, and outbound communication across all Retail channels sourced from SAP Customer Activity Repository (CAR) and the case management system. Stores interaction type (POS visit, website session, app open, call center contact, email send/open/click, SMS send/delivery, push notification, chat, clienteling visit, NPS survey response), direction (inbound/outbound), channel, store or digital property, timestamp, duration, outcome, NPS score (when applicable), associated campaign or promotion ID, delivery status and engagement metrics for outbound messages (delivered/opened/clicked/bounced/unsubscribed), and agent/associate ID. This is the single consolidated product for all customer communication and engagement history — foundation for omnichannel interaction timeline, communication audit trail, campaign response tracking, and CLTV modeling. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`payment_method` (
    `payment_method_id` DECIMAL(18,2) COMMENT 'Primary key for payment_method',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: payment_method has embedded billing address fields (billing_address_line1, billing_address_line2, billing_city, billing_state_province, billing_postal_code, billing_country_code) that should be normal',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this payment method. Links to the customer master record for omnichannel recognition and clienteling.',
    `bin_number` BIGINT COMMENT 'First six digits of the card number (Bank Identification Number). Used for card type identification, fraud detection, and routing. Not considered sensitive under PCI DSS.',
    `bnpl_provider` STRING COMMENT 'Buy-now-pay-later provider. Free-form string; common values include: klarna, affirm, afterpay, zip, sezzle.. Valid values are `affirm|afterpay|klarna|zip|sezzle`',
    `card_brand` STRING COMMENT 'Brand of the payment card; common values include visa, mastercard, amex, discover.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_country_code` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the card was issued. Derived from BIN lookup. Used for fraud detection and international transaction processing.',
    `cardholder_name` STRING COMMENT 'Full name of the cardholder. PII-sensitive; masked in non-production environments. Canonical source now in finance.payment_instrument.',
    `consent_channel` STRING COMMENT 'Channel through which the customer provided consent to store this payment method (web, mobile app, POS, call center, in-store). Required for GDPR and CCPA compliance.. Valid values are `web|mobile_app|pos|call_center|in_store`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer provided consent to store this payment method. Required for GDPR and CCPA compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment method record was first created in the system. Used for audit trail and customer lifecycle analysis.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment method was deactivated. Null if the payment method is still active. Used for lifecycle tracking and compliance reporting.',
    `deactivation_reason` STRING COMMENT 'Reason why the payment method was deactivated. Used for customer service, fraud analysis, and operational reporting.. Valid values are `expired|customer_request|fraud_suspected|lost_stolen|replaced`',
    `digital_wallet_provider` STRING COMMENT 'Digital wallet provider. Free-form string; common values include: apple_pay, google_pay, paypal, samsung_pay, venmo.. Valid values are `apple_pay|google_pay|paypal|samsung_pay|venmo`',
    `expiry_month` STRING COMMENT 'Expiration month of the payment card (1-12). Used to validate card validity at checkout and trigger proactive customer notifications for expiring cards.',
    `expiry_year` STRING COMMENT 'Expiration year of the payment card (four-digit year). Used to validate card validity at checkout and trigger proactive customer notifications for expiring cards.',
    `gift_card_balance` DECIMAL(18,2) COMMENT 'Current balance remaining on the gift card. Updated after each transaction. Applicable only when payment_method_type is gift_card.',
    `gift_card_number` BIGINT COMMENT 'Tokenized or masked gift card number. Applicable only when payment_method_type is gift_card. Used for gift card balance inquiries and redemption.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this payment method is currently active and available for use. Inactive methods are retained for historical transaction reference but cannot be used for new purchases.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this is the customers default payment method for one-click checkout and recurring purchases. Only one payment method per customer should be marked as default.',
    `issuing_bank` STRING COMMENT 'Name of the bank or financial institution that issued the payment card. Used for transaction routing and fraud detection.',
    `last_four_digits` STRING COMMENT 'Last four digits of the card number for customer recognition and display purposes. Used in clienteling and checkout confirmation screens.. Valid values are `^[0-9]{4}$`',
    `last_used_date` DATE COMMENT 'Date when this payment method was last used for a transaction. Used for RFM (Recency Frequency Monetary) analytics and customer engagement.',
    `nickname` STRING COMMENT 'Customer-defined nickname for this payment method (e.g., My Visa, Work Card, Personal Checking). Used for customer convenience in payment selection.',
    `payment_method_type` DECIMAL(18,2) COMMENT 'Type of payment method. Allowed values: credit_card, debit_card, wallet, gift_card, store_credit, bnpl.',
    `payment_processor` DECIMAL(18,2) COMMENT 'Name of the payment processor or gateway used to process transactions with this payment method (e.g., Stripe, Adyen, Braintree, Cybersource). Used for transaction routing and reconciliation.',
    `primary_digital_wallet_account_reference` BIGINT COMMENT 'Tokenized identifier for the digital wallet account. Used for digital wallet transactions and reconciliation.',
    `processor_token` STRING COMMENT 'Payment processor-specific token for this payment method. Used for transaction processing and vault management.',
    `store_credit_balance` DECIMAL(18,2) COMMENT 'Current balance of store credit available to the customer. Typically issued from returns or promotional campaigns. Applicable only when payment_method_type is store_credit.',
    `token` STRING COMMENT 'PCI DSS compliant tokenized reference to the payment instrument. No raw PAN (Primary Account Number) is stored. Token is used for recurring purchases and one-click checkout.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment method record was last updated. Used for audit trail and data quality monitoring.',
    `usage_count` STRING COMMENT 'Total number of times this payment method has been used for transactions. Used for RFM analytics and customer behavior analysis.',
    `verification_date` DATE COMMENT 'Date when the payment method was last verified. Used for compliance and fraud prevention tracking.',
    `verification_status` STRING COMMENT 'Status of payment method verification (e.g., AVS check, CVV verification, micro-deposit confirmation). Used for fraud prevention and risk management.. Valid values are `verified|pending|failed|not_verified`',
    `wallet_provider` STRING COMMENT 'Digital wallet provider; common values include apple_pay, google_pay, paypal.',
    CONSTRAINT pk_payment_method PRIMARY KEY(`payment_method_id`)
) COMMENT 'DEPRECATED: Payment method records for customers. This table is superseded by finance.payment_instrument for PCI DSS isolation. Retained as a view/reference for backward compatibility; new integrations should use finance.payment_instrument.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`membership` (
    `membership_id` BIGINT COMMENT 'Primary key for customer_membership',
    `segment_id` BIGINT COMMENT 'Foreign key linking to the segment definition to which this profile is assigned',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Loyalty membership tiers directly determine price list eligibility in retail. price_list.loyalty_tier_code confirms this design intent. The POS and e-commerce pricing engine resolves the active member',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the customer profile participating in this segment membership',
    `assignment_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00-100.00) indicating the strength of this customers qualification for this segment. For rule-based assignments, reflects how strongly the customer meets qualification criteria. For ML-based assignments, reflects model prediction confidence. Used for prioritizing marketing outreach and identifying borderline members.',
    `assignment_method` STRING COMMENT 'Mechanism by which this customer was assigned to this segment. AutoRefresh: automatically assigned via scheduled segment refresh process. ManualOverride: manually assigned by business user overriding qualification rules. RuleEngine: assigned via real-time rule evaluation. MLModel: assigned via predictive model scoring. BulkImport: assigned via batch data load.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was first created in the system. Audit field for data lineage and troubleshooting.',
    `customer_membership_status` STRING COMMENT 'Current operational status of this segment membership. Active: customer currently qualifies and membership is in effect. Expired: membership ended due to disqualification or time-based expiry. Suspended: temporarily inactive due to business rules. PendingQualification: awaiting next refresh cycle to confirm eligibility.',
    `end_date` DATE COMMENT 'Date when this customer profile exited this segment or the membership was terminated. Null for currently active memberships. Used for churn analysis and segment tenure calculations.',
    `fee` DECIMAL(18,2) COMMENT 'The membership fee of the customer membership.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was last updated (status change, confidence score update, override modification). Audit field for change tracking.',
    `last_qualification_check_date` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of this customers eligibility for this segment. Updated during auto-refresh cycles or manual re-qualification checks. Used for audit trails and determining when next qualification check is due.',
    `manual_override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this membership was manually assigned by a business user, overriding automated qualification rules. True: manual override in effect, customer may not meet standard qualification criteria. False: standard rule-based or automated assignment. Used for governance and audit purposes.',
    `override_reason` STRING COMMENT 'Free-text explanation provided by business user when manual_override_flag is true. Documents business justification for overriding automated qualification rules (e.g., VIP customer per executive request, Strategic account exception, Retention offer). Null when no override is in effect.',
    `renewal_rate` DECIMAL(18,2) COMMENT 'The renewal rate of the customer membership.',
    `start_date` DATE COMMENT 'Date when this customer profile was assigned to this segment and the membership became active. Used for lifecycle tracking and historical analysis of segment transitions.',
    CONSTRAINT pk_membership PRIMARY KEY(`membership_id`)
) COMMENT '[References SSOT: loyalty.loyalty_membership] Customer-to-membership assignment linking table. References loyalty.loyalty_membership as the authoritative membership record. Tracks segment-based membership assignments and qualification methods.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_retail_v1`.`customer`.`household`(`household_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_retail_v1`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ADD CONSTRAINT `fk_customer_corporate_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ADD CONSTRAINT `fk_customer_corporate_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_retail_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ADD CONSTRAINT `fk_customer_corporate_account_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_retail_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ADD CONSTRAINT `fk_customer_corporate_account_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ADD CONSTRAINT `fk_customer_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_retail_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ADD CONSTRAINT `fk_customer_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_retail_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_retail_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Store ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_value_regex' = 'store|ecommerce|mobile_app|social_media|referral|partner');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Customer Date of Birth');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Customer Email Address');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Type Classification');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|employee|vip|wholesale');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Customer First Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Full Legal Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Customer Gender');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other|unknown');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Last Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifecycle Stage');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Loyalty Tier');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_overlap_owner' = 'profile');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_source' = 'profile_account_merge');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mdm_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Confidence Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mdm_last_match_date` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Last Match Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mdm_source_system` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Source System');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Middle Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Mobile Phone Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Customer Nationality');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Phone Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_overlap_owner' = 'profile');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_source' = 'profile_account_merge');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|none');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Customer Preferred Language');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blocked|closed');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `scd_changed_by` SET TAGS ('dbx_business_glossary_term' = 'SCD Changed By');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_retype_attribute' = 'BIGINT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `profile_id` SET TAGS ('dbx_nullable' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_enum' = 'corporate');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_wholesale' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_franchise' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_trade' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_government' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `b2b_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Business-to-Business (B2B) Pricing Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Limit');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `employee_discount_eligible` SET TAGS ('dbx_business_glossary_term' = 'Employee Discount Eligible Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `employee_discount_eligible` SET TAGS ('dbx_retype_attribute' = 'BOOLEAN->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `employee_discount_eligible` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `loyalty_program_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrolled Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `scd_changed_by` SET TAGS ('dbx_business_glossary_term' = 'SCD Changed By');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Expiry Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_expiry_date` SET TAGS ('dbx_retype_attribute' = 'DATE->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_expiry_date` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_retype_attribute' = 'BOOLEAN->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Reference');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `average_basket_value` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Value');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `combined_cltv` SET TAGS ('dbx_business_glossary_term' = 'Combined CLTV');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `estimated_income_band` SET TAGS ('dbx_business_glossary_term' = 'Estimated Income Band');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `external_household_code` SET TAGS ('dbx_business_glossary_term' = 'External Household Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `is_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Household Segment');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_loyalty_points` SET TAGS ('dbx_business_glossary_term' = 'Total Loyalty Points');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_loyalty_points` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_loyalty_points` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_purchase_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_purchase_count` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_purchase_count` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_retype_attribute' = 'BIGINT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Corporate Account ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `account_established_date` SET TAGS ('dbx_business_glossary_term' = 'Account Established Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `account_established_date` SET TAGS ('dbx_retype_attribute' = 'DATE->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Tier');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `business_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Business Entity Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `contract_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `industry_classification_naics` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `industry_classification_naics` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `industry_classification_sic` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `industry_classification_sic` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `legal_business_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Business Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `legal_business_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `preferred_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Delivery Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `preferred_delivery_method` SET TAGS ('dbx_value_regex' = 'standard_ground|expedited|next_day|freight|customer_pickup');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_retype_attribute' = 'BOOLEAN->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN) / Employer Identification Number (EIN)');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|bounced|invalid|suppressed|pending_verification');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `last_bounce_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bounce Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Contact Value');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `value` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending_verification');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|home|work|store_pickup|mailing');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `delivery_point_barcode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Barcode');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `delivery_point_barcode` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `delivery_point_barcode` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `is_default_billing` SET TAGS ('dbx_business_glossary_term' = 'Is Default Billing Address');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `is_default_shipping` SET TAGS ('dbx_business_glossary_term' = 'Is Default Shipping Address');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Military Address Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Address Nickname');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `nickname` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `residential_flag` SET TAGS ('dbx_business_glossary_term' = 'Residential Address Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `scd_changed_by` SET TAGS ('dbx_business_glossary_term' = 'SCD Changed By');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `standardization_flag` SET TAGS ('dbx_business_glossary_term' = 'Postal Standardization Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|pending');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `auto_refresh_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Refresh Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `average_aov` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `average_aov` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `average_cltv` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Lifetime Value (CLTV)');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `average_cltv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `average_purchase_frequency` SET TAGS ('dbx_business_glossary_term' = 'Average Purchase Frequency');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `b2b_b2c_indicator` SET TAGS ('dbx_business_glossary_term' = 'Business-to-Business (B2B) / Business-to-Consumer (B2C) Indicator');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `b2b_b2c_indicator` SET TAGS ('dbx_value_regex' = 'b2b|b2c|both');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `ccpa_opt_out_honored_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Honored Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Segment Churn Risk Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `discount_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Discount Sensitivity Level');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `discount_sensitivity` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `discount_sensitivity` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `gdpr_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Required Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Refresh Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `max_rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Recency Frequency Monetary (RFM) Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `max_rfm_score` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `max_rfm_score` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `membership_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `min_rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Recency Frequency Monetary (RFM) Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `min_rfm_score` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `min_rfm_score` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority Tier');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `qualification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria Summary');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Refresh Frequency');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `target_marketing_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Marketing Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'store|web|mobile_app|call_center|email|sms');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Message Delivery Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|opened|clicked|bounced|failed|pending');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|pos_terminal|other');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `digital_property` SET TAGS ('dbx_business_glossary_term' = 'Digital Property');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Interaction Direction');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Seconds)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_clicked_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Clicked Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_clicked_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_clicked_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_clicked_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_opened_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Opened Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_opened_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_opened_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `email_opened_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'pos_visit|website_session|mobile_app_open|call_center_contact|email_campaign|sms_campaign');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP (Internet Protocol) Address');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL (Uniform Resource Locator)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Notes');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL (Uniform Resource Locator)');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `sms_delivered_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Delivered Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `unsubscribed_flag` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribed Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_retype_attribute' = 'BIGINT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later (BNPL) Provider');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_value_regex' = 'affirm|afterpay|klarna|zip|sezzle');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_country_code` SET TAGS ('dbx_business_glossary_term' = 'Card Issuing Country Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_country_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_country_code` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `consent_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|pos|call_center|in_store');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_value_regex' = 'expired|customer_request|fraud_suspected|lost_stolen|replaced');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `digital_wallet_provider` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Provider');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `digital_wallet_provider` SET TAGS ('dbx_value_regex' = 'apple_pay|google_pay|paypal|samsung_pay|venmo');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Expiry Month');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Expiry Year');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `gift_card_balance` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Balance');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `gift_card_balance` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Payment Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Last Four Digits');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Nickname');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `nickname` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_enum_values' = 'credit_card');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_debit_card' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_wallet' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_gift_card' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_store_credit' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_bnpl' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_allowed_values' = 'credit_card');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_debit_card' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_wallet' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_gift_card' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_store_credit' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_bnpl' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_enum' = 'credit_card');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_debit_card' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_wallet' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_gift_card' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_store_credit' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_bnpl' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_processor` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_processor` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `primary_digital_wallet_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Account ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `primary_digital_wallet_account_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `primary_digital_wallet_account_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `processor_token` SET TAGS ('dbx_business_glossary_term' = 'Processor Token');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `processor_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `processor_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `processor_token` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `store_credit_balance` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Balance');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Token');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_verified');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'customer_membership Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Membership - Customer Segment Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Membership - Profile Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `assignment_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `customer_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `last_qualification_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Check Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `manual_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
