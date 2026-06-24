-- Schema for Domain: customer | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 22:46:19

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
    `mdm_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-100) from the customer master data system indicating the quality and reliability of the golden record match and data completeness.',
    `mdm_last_match_date` TIMESTAMP COMMENT 'Timestamp of the last MDM matching and survivorship process execution that updated this golden record.',
    `mdm_source_system` STRING COMMENT 'Name of the primary source system that contributed the authoritative data for this golden record (e.g., the retail analytics platform, the e-commerce platform, POS).',
    `middle_name` STRING COMMENT 'Middle name or initial of the customer. Nullable field for customers without a middle name.',
    `mobile_number` BIGINT COMMENT 'Mobile phone number used for SMS notifications, mobile app authentication, and last-mile delivery coordination.',
    `nationality` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the customers nationality or citizenship.. Valid values are `^[A-Z]{3}$`',
    `phone_number` BIGINT COMMENT 'Primary contact phone number for customer service, order notifications, and BOPIS (Buy Online Pick Up In Store) communications.',
    `preferred_contact_method` STRING COMMENT 'Customers preferred method for receiving communications and notifications from the business.. Valid values are `email|phone|sms|mail|none`',
    `preferred_language` STRING COMMENT 'ISO 639-2 three-letter language code representing the customers preferred language for communication and marketing materials.. Valid values are `^[A-Z]{3}$`',
    `profile_status` STRING COMMENT 'Current operational status of the customer profile, controlling access to services and transactions across all channels.. Valid values are `active|inactive|suspended|blocked|closed`',
    `record_version` STRING COMMENT 'Monotonically increasing version number for this record in the SCD Type-2 history.',
    `scd_change_reason` STRING COMMENT 'Business reason for the change that created this version, supporting GDPR audit trail requirements.',
    `scd_change_timestamp` TIMESTAMP COMMENT 'Exact timestamp when this SCD Type-2 version was created, used for change-data-capture reconciliation and GDPR audit trails.',
    `scd_changed_by` STRING COMMENT 'Identifier of the user or system process that triggered this SCD Type-2 version change, supporting GDPR accountability requirements.',
    `version_number` STRING COMMENT 'Sequential version identifier for SCD Type-2 tracking of this record.',
    `preferred_channel` STRING COMMENT '',
    `marketing_opt_in` STRING COMMENT '',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Core customer identity record. Represents a single known individual or organization with master attributes. B2C customers typically have only a profile; B2B relationships additionally use the account entity.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the account. Primary key.',
    `associate_id` BIGINT COMMENT 'Reference to the employee assigned as the dedicated account manager for this account (typically for high-value B2B or VIP accounts). Null for standard consumer accounts without dedicated management.',
    `address_id` BIGINT COMMENT 'Reference to the default billing address for this account. Used for invoicing, credit checks, and payment processing. Null if no billing address on file.',
    `payment_method_id` DECIMAL(18,2) COMMENT 'Reference to the customers default payment method for this account (e.g., credit card on file, bank account). Null if no default set. Used for one-click checkout and recurring billing.',
    `location_id` BIGINT COMMENT 'Reference to the customers preferred or home store location for in-store pickup, returns, and personalized store-based services. Null if no preference set.',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile who owns this account. One customer may have multiple accounts (e.g., personal and business).',
    `shipping_address_id` BIGINT COMMENT 'Reference to the default shipping address for this account. Used for order fulfillment and delivery. Null if no default shipping address set.',
    `account_number` BIGINT COMMENT 'Externally-visible unique account number used for customer communication, statements, and customer service lookup. Distinct from internal account_id.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` BIGINT COMMENT 'Current status of the B2B account: active, suspended, closed, pending_approval. Only active accounts may place wholesale orders.. Valid values are `active|suspended|closed|pending_activation|frozen|dormant`',
    `account_type` BIGINT COMMENT 'Type of business account. Values: corporate, wholesale, franchise, reseller.. Valid values are `personal|business|employee|wholesale`',
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
    `address_line_1` STRING COMMENT 'Primary street address line for the household residence.',
    `address_line_2` STRING COMMENT 'Secondary address line (apartment, suite, unit) for the household residence.',
    `average_basket_value` DECIMAL(18,2) COMMENT 'Average transaction basket value across all household members.',
    `city` STRING COMMENT 'City or municipality of the household residence.',
    `combined_cltv` DECIMAL(18,2) COMMENT 'Combined customer lifetime value estimate aggregated across all household members.',
    `communication_preference` STRING COMMENT 'Preferred communication channel for household-level outreach (e.g. email, mail, phone, sms).',
    `country_code` BIGINT COMMENT 'ISO 3166-1 alpha-2 country code for the household residence.',
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
    `postal_code` STRING COMMENT 'Postal or ZIP code of the household residence.',
    `preferred_channel` STRING COMMENT 'Preferred shopping channel for the household (e.g. in_store, online, omnichannel).',
    `primary_language` STRING COMMENT 'Primary language spoken in the household, used for communication preferences.',
    `profile_id` BIGINT COMMENT 'Foreign key to the customer profile designated as the head of household or primary contact.',
    `record_version` STRING COMMENT 'Monotonically increasing version number for SCD Type 2 tracking of household changes.',
    `segment` STRING COMMENT 'Marketing or behavioral segment classification assigned to this household.',
    `size` STRING COMMENT 'Number of individuals (customer profiles) associated with this household.',
    `state_province` STRING COMMENT 'State, province, or region of the household residence.',
    `total_loyalty_points` DECIMAL(18,2) COMMENT 'Aggregate loyalty points balance across all household members.',
    `total_purchase_count` DECIMAL(18,2) COMMENT 'Total number of purchases made by all household members combined.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total monetary spend across all household members over the lifetime of the household.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this household record.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Represents a household grouping of one or more customer profiles sharing a residence or economic unit. Enables household-level analytics, marketing, and deduplication across individual profiles.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`corporate_account` (
    `corporate_account_id` DECIMAL(18,2) COMMENT 'Unique identifier for the B2B corporate customer account. Primary key for the corporate account entity.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: B2B corporate accounts require dedicated account managers (sales reps or account executives) who handle contract negotiations, pricing agreements, credit terms, and ongoing relationship management. Es',
    `address_id` BIGINT COMMENT 'FK to customer.address',
    `account_id` BIGINT COMMENT 'Reference to the parent corporate account if this account is part of a multi-location or subsidiary hierarchy. Null for standalone accounts or top-level parent accounts. Enables consolidated billing and enterprise-wide reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Corporate accounts have a designated primary contact person. Currently, corporate_account stores primary_contact_name, primary_contact_email, primary_contact_phone as denormalized columns. Adding prim',
    `shipping_address_id` BIGINT COMMENT 'FK to customer.address',
    `account_established_date` BIGINT COMMENT 'Date when the corporate account was first created in the system. Used to calculate customer tenure and lifetime value metrics.',
    `annual_spend_tier` DECIMAL(18,2) COMMENT 'Classification of the corporate account based on annual purchase volume. Used to determine discount levels, service priority, and account management resources. Tier_1 = highest spend (>$1M), Tier_5 = lowest spend (<$10K). Tiers recalculated annually.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5`',
    `business_entity_type` STRING COMMENT 'Legal structure of the corporate entity. Values: sole_proprietorship, partnership, llc (Limited Liability Company), corporation (C-Corp), s_corp (S-Corporation), non_profit (501c3 or similar), government (public sector entity). [ENUM-REF-CANDIDATE: sole_proprietorship|partnership|llc|corporation|s_corp|non_profit|government — 7 candidates stripped; promote to reference product]',
    `contract_pricing_flag` BOOLEAN COMMENT 'Indicates whether the corporate account has negotiated contract pricing that overrides standard catalog prices. True = custom pricing agreement in place; False = standard pricing applies.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this corporate account record was first created in the database. Used for audit trail and data lineage tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the corporate account before requiring payment or credit hold. Expressed in USD. Null if account is cash-only.',
    `credit_status` DECIMAL(18,2) COMMENT 'Current credit approval status for the corporate account. Determines whether the customer can purchase on credit terms. Values: approved (credit line active), pending (application submitted), declined (credit denied), under_review (periodic credit review in progress), suspended (credit privileges temporarily revoked).. Valid values are `approved|pending|declined|under_review|suspended`',
    `dba_name` STRING COMMENT 'Trade name or fictitious business name under which the corporate customer operates, if different from legal name. Used for marketing and customer-facing communications.',
    `duns_number` BIGINT COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to establish business credit profile and track commercial credit history. Used for supplier onboarding and credit evaluation.. Valid values are `^[0-9]{9}$`',
    `industry_classification_naics` STRING COMMENT 'Six-digit code classifying the corporate customers primary industry using the NAICS standard. Provides more granular industry segmentation than SIC for modern business categories.. Valid values are `^[0-9]{6}$`',
    `industry_classification_sic` STRING COMMENT 'Four-digit code classifying the corporate customers primary industry sector using the U.S. Standard Industrial Classification system. Used for market segmentation and industry analysis.. Valid values are `^[0-9]{4}$`',
    `last_order_date` DATE COMMENT 'Date of the most recent purchase order placed by this corporate account. Used for recency analysis and dormant account identification.',
    `legal_business_name` STRING COMMENT 'The official registered legal name of the corporate entity as it appears on government filings and tax documents. Used for contracts, invoicing, and legal compliance.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment terms negotiated with the corporate customer. Values: net_30 (payment due 30 days after invoice), net_45, net_60, net_90, due_on_receipt (immediate payment), prepay (payment before shipment), custom (non-standard terms documented separately). [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_90|due_on_receipt|prepay|custom — 7 candidates stripped; promote to reference product]',
    `preferred_delivery_method` STRING COMMENT 'Default shipping method preference for corporate orders. Values: standard_ground, expedited, next_day, freight (for large/bulk orders), customer_pickup (will-call).. Valid values are `standard_ground|expedited|next_day|freight|customer_pickup`',
    `tax_exempt_certificate_number` DECIMAL(18,2) COMMENT 'Government-issued tax exemption certificate number. Required for tax-exempt accounts to validate exemption status during order processing and audits.',
    `tax_exempt_flag` DECIMAL(18,2) COMMENT 'Indicates whether the corporate account is exempt from sales tax (e.g., government entities, non-profits with valid exemption certificates). True = tax exempt; False = taxable.',
    `tax_identifier` DECIMAL(18,2) COMMENT 'Federal tax identification number (EIN) assigned by the IRS for business tax reporting and compliance. Format: XX-XXXXXXX.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
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
    `country_code` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country associated with this contact method (e.g., USA, GBR, CAN). Used for regional compliance and localization of communications.. Valid values are `^[A-Z]{3}$`',
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
    `country_code` BIGINT COMMENT 'Three-letter ISO country code (e.g., USA, CAN, GBR) identifying the country of the address.. Valid values are `^[A-Z]{3}$`',
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
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Customer segments are owned by marketing analysts, merchandising managers, or CRM specialists who define qualification criteria, monitor segment performance, design targeted campaigns, and refresh mem',
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
    `discount_sensitivity` DECIMAL(18,2) COMMENT 'Behavioral classification of segments responsiveness to promotional pricing. High: primarily purchases on promotion (Hi-Lo shoppers). Medium: balanced full-price and promotional purchases. Low: primarily full-price purchases (EDLP preference or premium segment).. Valid values are `high|medium|low`',
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
    `refresh_frequency` DECIMAL(18,2) COMMENT 'Cadence at which segment membership is recalculated for auto-refresh segments. Daily: high-velocity behavioral segments. Weekly: standard RFM tiers. Monthly: demographic or lifecycle segments. Quarterly: strategic value tiers. On-Demand: manual trigger only.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition. Active: in production use for customer assignment and campaigns. Inactive: temporarily suspended, no new assignments. Archived: retired, historical reference only. Draft: under development, not yet released.. Valid values are `active|inactive|archived|draft`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology applied. RFM Tier: Recency, Frequency, Monetary analysis. Demographic: age, gender, income. Behavioral: purchase patterns, product affinity. Psychographic: lifestyle, values. Lifecycle Stage: new, active, at-risk, lapsed. Geographic: region, climate zone. Channel Preference: omnichannel, e-commerce-only, store-only. Value Tier: CLTV-based stratification. [ENUM-REF-CANDIDATE: rfm_tier|demographic|behavioral|psychographic|lifecycle_stage|geographic|channel_preference|value_tier — 8 candidates stripped; promote to reference product]',
    `target_marketing_channel` STRING COMMENT 'Primary communication channel recommended for engaging customers in this segment. Aligns segment strategy with channel preference and regulatory consent. All Channels: omnichannel engagement strategy. [ENUM-REF-CANDIDATE: email|sms|push_notification|direct_mail|in_store|call_center|social_media|all_channels — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Defines market segmentation classifications applied to customer profiles for targeted marketing, personalized pricing, and assortment decisions. Stores segment code, segment name, segment type (RFM tier, demographic, behavioral, psychographic, lifecycle stage, geographic, channel preference, value tier), segment description, qualification criteria summary, membership count, effective date range, auto-refresh flag, owning business unit, and profile-to-segment assignments with effective dates and expiry dates. Enables Retail to execute clienteling strategies, personalized promotions, and differentiated service levels across POS and e-commerce channels. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`identity_link` (
    `identity_link_id` BIGINT COMMENT 'Unique identifier for the identity link record. Primary key for the identity resolution table.',
    `rule_id` BIGINT COMMENT 'Reference to the identity resolution match rule that created this link.',
    `profile_id` BIGINT COMMENT 'Reference to the golden customer record (master profile) in the Customer domain that this identifier is linked to. This is the single source of truth customer identity.',
    `channel` STRING COMMENT 'The customer interaction channel where this identifier is primarily used. Supports omnichannel customer recognition and journey analytics.. Valid values are `in_store|online|mobile|call_center|social_media`',
    `consent_status` STRING COMMENT 'The customer consent status for using this identifier for marketing, personalization, or cross-channel tracking. Critical for GDPR and CCPA compliance.. Valid values are `granted|denied|pending|withdrawn|expired`',
    `consent_timestamp` TIMESTAMP COMMENT 'The date and time when the customer provided or updated their consent for this identifier. Required for regulatory audit trails. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.0000 to 1.0000) representing the overall quality and reliability of this identifier based on completeness, accuracy, consistency, and timeliness dimensions.',
    `identifier_first_seen_date` DATE COMMENT 'The date when this specific identifier value was first observed in any source system. Used for recency analysis in RFM (Recency Frequency Monetary) segmentation. Format: yyyy-MM-dd.',
    `identifier_last_seen_date` DATE COMMENT 'The date when this identifier was most recently used in a transaction or interaction. Critical for identifying dormant identifiers. Format: yyyy-MM-dd.',
    `identifier_type` STRING COMMENT 'The category or type of identifier being linked. Examples include loyalty card number, email hash, device ID, cookie ID, POS customer ID, Salesforce Contact ID, SAP customer number. [ENUM-REF-CANDIDATE: loyalty_card|email_hash|device_id|cookie_id|pos_customer_id|salesforce_contact_id|sap_customer_number|mobile_app_id|web_account_id|third_party_id — promote to reference product]. Valid values are `loyalty_card|email_hash|device_id|cookie_id|pos_customer_id|salesforce_contact_id`',
    `identifier_usage_count` STRING COMMENT 'The total number of times this identifier has been used across all channels and transactions. Helps assess identifier reliability and customer engagement.',
    `identifier_value` DECIMAL(18,2) COMMENT 'The identifier value (email, phone, loyalty number, device ID, etc.).',
    `is_primary_identifier` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary or preferred identifier for this customer. True if this is the main identifier used for customer recognition, False otherwise.',
    `link_confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0.0000 to 1.0000) indicating the certainty of the identity link. Deterministic matches typically score 1.0000, while probabilistic matches score lower based on matching algorithm confidence.',
    `link_created_timestamp` TIMESTAMP COMMENT 'The date and time when this identity link was first established in the MDM system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `link_effective_from_date` DATE COMMENT 'The date from which this identity link is considered valid and active for customer recognition across channels. Format: yyyy-MM-dd.',
    `link_effective_to_date` DATE COMMENT 'The date until which this identity link remains valid. Null indicates an open-ended link. Format: yyyy-MM-dd.',
    `link_method` STRING COMMENT 'The methodology used to establish the identity link. Deterministic uses exact matching rules (e.g., same email), probabilistic uses statistical algorithms, manual indicates human review, third-party indicates external data provider.. Valid values are `deterministic|probabilistic|manual|third_party`',
    `link_notes` STRING COMMENT 'Free-text notes or comments about this identity link, typically used for manual review cases or to document special circumstances in the linking decision.',
    `link_status` STRING COMMENT 'Current lifecycle status of the identity link. Active links are used for customer recognition, inactive links are deprecated, pending_review requires manual validation, rejected links failed validation, superseded links have been replaced by newer links.. Valid values are `active|inactive|pending_review|rejected|superseded`',
    `link_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this identity link was last modified or re-validated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `linked_by_user` STRING COMMENT 'The username or system identifier of the user or process that created this identity link. Used for audit and accountability purposes.',
    `match_attributes` STRING COMMENT 'Comma-separated list of attributes that were used in the matching process (e.g., email, phone, postal_code). Provides transparency into the matching logic.',
    `merge_history_reference` STRING COMMENT 'Reference identifier to the merge/split history log if this link was affected by customer profile merges or splits. Supports audit trail and rollback scenarios.',
    `validation_status` STRING COMMENT 'Indicates whether this identifier has been validated through external verification (e.g., email verification, phone verification). Validated identifiers have higher trust scores.. Valid values are `validated|unvalidated|failed|pending`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when this identifier was last validated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_identity_link PRIMARY KEY(`identity_link_id`)
) COMMENT 'Cross-channel identity resolution table managed by the customer master data system that links a single customer golden record (profile) to all their known identifiers across systems. Stores identifier type (loyalty card number, email hash, device ID, cookie ID, POS customer ID, Salesforce Contact ID, SAP customer number), identifier value, source system, link confidence score, link method (deterministic/probabilistic), and link creation timestamp. Enables omnichannel recognition across POS, e-commerce, and mobile. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for the customer interaction event. Primary key.',
    `location_id` BIGINT COMMENT 'Identifier of the physical store location where the interaction occurred. Applicable for in-store interactions (POS visit, clienteling visit, in-store event). Null for digital interactions.',
    `associate_id` BIGINT COMMENT 'Identifier of the call center or customer service agent who handled this interaction. Applicable for call center contacts, live chat, and service cases. Null for non-agent-assisted interactions.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who participated in this interaction. Links to the customer master record.',
    `service_case_id` BIGINT COMMENT 'Identifier of the customer service case or ticket associated with this interaction, if applicable. Links to the service case record. Null for non-case interactions.',
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

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`service_case` (
    `service_case_id` BIGINT COMMENT 'Unique identifier for the customer service case record. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the customer service agent or representative currently assigned to handle this case.',
    `location_id` BIGINT COMMENT 'Identifier of the retail store location involved in the case, if the issue originated from or relates to a specific store.',
    `parent_case_service_case_id` BIGINT COMMENT 'Identifier of the parent service case if this case is a child or follow-up case. Supports hierarchical case relationships and tracking of related issues.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who initiated or is associated with this service case. Links to the customer master record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: When customer service cases involve product defects, quality issues, or recalls, retailers must track the originating vendor to manage RTV requests, chargebacks, vendor scorecards, and supplier accoun',
    `assigned_team` STRING COMMENT 'Name or code of the service team or queue to which this case is assigned for resolution.',
    `case_number` BIGINT COMMENT 'Externally visible unique case number assigned by the service system for customer reference and tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `case_owner_type` STRING COMMENT 'Type of owner currently assigned to the case: individual agent, team queue, or automated system. Used for workload distribution analytics.. Valid values are `agent|queue|automated_system`',
    `case_status` STRING COMMENT 'Current lifecycle status of the service case. Tracks progression from new through resolution to closure. [ENUM-REF-CANDIDATE: new|open|in_progress|pending_customer|pending_vendor|escalated|resolved|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the service case by the nature of the customer issue or inquiry. Includes return inquiry, billing dispute, product complaint, delivery issue, loyalty query, order inquiry, technical support, and general inquiry. [ENUM-REF-CANDIDATE: return_inquiry|billing_dispute|product_complaint|delivery_issue|loyalty_query|order_inquiry|technical_support|general_inquiry — 8 candidates stripped; promote to reference product]',
    `channel` STRING COMMENT 'The customer interaction channel through which the service case was initiated. Supports omnichannel service analytics. [ENUM-REF-CANDIDATE: phone|email|chat|in_store|mobile_app|web_portal|social_media — 7 candidates stripped; promote to reference product]',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was formally closed in the system. May differ from resolution timestamp if additional verification or customer confirmation was required.',
    `contact_attempts` STRING COMMENT 'Number of times the service team attempted to contact the customer during the case lifecycle. Used for tracking customer engagement and responsiveness.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service case record was first created in the system. Represents the initiation of the service workflow.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary amounts associated with the case, such as refunds or credits.. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction score provided by the customer after case resolution, typically on a scale of 1 to 5. Used to calculate CSAT and NPS metrics.',
    `service_case_description` STRING COMMENT 'Detailed narrative description of the customer issue, inquiry, or complaint as captured by the service agent or customer.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the case was escalated to a higher support tier, supervisor, or specialized team during its lifecycle.',
    `escalation_reason` STRING COMMENT 'Reason or justification for escalating the case, such as complexity, customer request, or SLA breach.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Timestamp when the first agent response was provided to the customer after case creation. Key metric for measuring initial response time SLA.',
    `interaction_count` STRING COMMENT 'Total number of customer-agent interactions or touchpoints recorded during the lifecycle of this case. Includes calls, emails, chats, and in-person contacts.',
    `is_closed` BOOLEAN COMMENT 'Boolean indicator of whether the case is currently in a closed status. Simplifies filtering for open vs closed case analytics.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the service case record was last modified or updated. Used for audit trail and change tracking.',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score provided by the customer, typically on a scale of 0 to 10, indicating likelihood to recommend the business based on the service experience.',
    `priority` STRING COMMENT 'Business priority level assigned to the case based on urgency and impact to the customer or business operations.. Valid values are `low|medium|high|critical`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the customer as part of the case resolution, if applicable. Denominated in the transaction currency.',
    `resolution_code` STRING COMMENT 'Standardized code indicating the type of resolution or action taken to close the service case. Used for resolution analytics and process improvement. [ENUM-REF-CANDIDATE: refund_issued|replacement_sent|information_provided|escalated_to_vendor|no_action_required|customer_withdrew|policy_exception_approved — 7 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution details, actions taken, and any follow-up required for the case.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was marked as resolved by the service agent. Represents the point at which the issue was addressed.',
    `rma_number` BIGINT COMMENT 'Return Merchandise Authorization number issued for return-related cases. Links the service case to the formal return process and inventory tracking.. Valid values are `^RMA[A-Z0-9]{8,15}$`',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the case resolution exceeded the SLA target time, triggering a service level breach.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which the case should be resolved according to the applicable SLA policy based on case type and priority.',
    `subject` STRING COMMENT 'Brief summary or subject line describing the nature of the customer service case.',
    CONSTRAINT pk_service_case PRIMARY KEY(`service_case_id`)
) COMMENT 'Customer service and support case records managed through the case management system. Stores case number, case type (return inquiry, billing dispute, product complaint, delivery issue, loyalty query), case status (open/in-progress/resolved/closed), priority, channel of origin (phone/chat/email/in-store), assigned agent, store or fulfillment node involved, resolution code, resolution timestamp, customer satisfaction rating, and RMA reference for return-related cases. Distinct from interaction (which captures all touchpoints) — service_case tracks formal support workflows with SLAs. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`wishlist` (
    `wishlist_id` BIGINT COMMENT 'Primary key for wishlist',
    `location_id` BIGINT COMMENT 'Identifier of the physical store location associated with this wishlist (e.g., for BOPIS preferences, in-store registry creation, or store-specific wishlists). Nullable for online-only wishlists.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who owns this wishlist. Links to the customer master record.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Wedding and baby registry wishlists are managed by dedicated in-store registry consultants who assist customers with product selection, registry setup, gift tracking, and completion discounts. Support',
    `address_id` BIGINT COMMENT 'Identifier of the preferred shipping address for gift registry items. Links to customer address records. Nullable for non-registry wishlists.',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the wishlist was archived by the customer or system. Nullable if never archived. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `channel` STRING COMMENT 'Digital channel through which the wishlist was created: web (desktop browser), mobile_app (iOS/Android app), mobile_web (mobile browser), in_store_kiosk, or call_center (assisted creation).. Valid values are `web|mobile_app|mobile_web|in_store_kiosk|call_center`',
    `co_registrant_first_name` STRING COMMENT 'First name of the secondary registrant for gift registries (e.g., groom, co-host). Nullable for single-registrant or non-registry wishlists.',
    `co_registrant_last_name` STRING COMMENT 'Last name of the secondary registrant for gift registries. Nullable for single-registrant or non-registry wishlists.',
    `conversion_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of wishlist items that have been purchased (converted to orders). Calculated as (purchased items / total items) × 100. Key metric for wishlist effectiveness.',
    `conversion_status` STRING COMMENT 'Indicates whether items from this wishlist have been purchased: unconverted (no items purchased), partially_converted (some items purchased), fully_converted (all items purchased).. Valid values are `unconverted|partially_converted|fully_converted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the wishlist was first created by the customer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the wishlist value amount (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `data_retention_expiry_date` DATE COMMENT 'Date when this wishlist record is eligible for permanent deletion per data retention policies. Calculated based on last activity date and regulatory requirements. Format: yyyy-MM-dd.',
    `deleted_timestamp` TIMESTAMP COMMENT 'Date and time when the wishlist was soft-deleted. Nullable if not deleted. Supports data retention and recovery policies. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `wishlist_description` STRING COMMENT 'Optional customer-provided description or notes about the wishlist purpose, preferences, or special instructions (e.g., Items for new apartment, Prefer blue colors).',
    `device_type` STRING COMMENT 'Type of device used to create the wishlist: desktop, tablet, smartphone, kiosk, or unknown if not captured.. Valid values are `desktop|tablet|smartphone|kiosk|unknown`',
    `event_date` DATE COMMENT 'Target date for the event associated with this wishlist (e.g., wedding date, birthday, holiday). Applicable primarily to gift registries. Nullable for non-event wishlists. Format: yyyy-MM-dd.',
    `external_wishlist_code` STRING COMMENT 'Original wishlist identifier from the source system (e.g., the e-commerce platform wishlist GUID). Used for cross-system reconciliation and data lineage.',
    `first_conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the first item from this wishlist was purchased. Nullable if no conversions have occurred. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `is_default_flag` BOOLEAN COMMENT 'Indicates whether this is the customers default wishlist. True if default (items added without specifying a list go here), False otherwise. Each customer should have only one default wishlist.',
    `last_conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent item from this wishlist was purchased. Nullable if no conversions have occurred. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the wishlist was last updated (items added/removed, name changed, settings modified). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_viewed_timestamp` TIMESTAMP COMMENT 'Date and time when the wishlist was last viewed by any user (owner or gift-giver). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `wishlist_name` STRING COMMENT 'Customer-provided name for the wishlist (e.g., Birthday Gifts, Holiday Shopping, Wedding Registry).',
    `notification_enabled_flag` BOOLEAN COMMENT 'Indicates whether the customer has enabled notifications for this wishlist (e.g., back-in-stock alerts, price drop alerts, event reminders). True if enabled, False if disabled.',
    `notification_frequency` DECIMAL(18,2) COMMENT 'Frequency at which the customer wants to receive wishlist notifications: immediate (real-time alerts), daily digest, weekly digest, event_based (only for specific triggers), or disabled.. Valid values are `immediate|daily|weekly|event_based|disabled`',
    `privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the customer has consented to use wishlist data for personalized recommendations and marketing. True if consent given, False otherwise. Required for GDPR and CCPA compliance.',
    `registrant_first_name` STRING COMMENT 'First name of the primary registrant for gift registries (e.g., bride, birthday person). Used for registry search and display. Nullable for non-registry wishlists.',
    `registrant_last_name` STRING COMMENT 'Last name of the primary registrant for gift registries. Used for registry search and display. Nullable for non-registry wishlists.',
    `registry_number` BIGINT COMMENT 'Unique public-facing registry number for gift registries, used by gift-givers to search and locate the registry. Nullable for non-registry wishlists.',
    `share_count` STRING COMMENT 'Number of times the wishlist has been shared via email, social media, or direct link. Tracks viral/social engagement.',
    `share_url` STRING COMMENT 'Unique shareable URL for this wishlist. Generated for shared and public wishlists to enable gift-givers to view and purchase items. Nullable for private wishlists.',
    `total_item_count` DECIMAL(18,2) COMMENT 'Total number of distinct product SKUs currently in the wishlist. Calculated from wishlist item detail records.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Sum of desired quantities across all items in the wishlist. Accounts for items where customer wants multiple units.',
    `total_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all items in the wishlist at current prices. Sum of (item price × desired quantity) for all items. Used for demand forecasting and promotional targeting.',
    `view_count` STRING COMMENT 'Total number of times the wishlist has been viewed by the owner or others (for shared/public wishlists). Engagement metric.',
    `visibility` STRING COMMENT 'Privacy setting for the wishlist: private (only owner can view), shared (accessible via link), public (searchable by others), or registry (publicly searchable gift registry).. Valid values are `private|shared|public|registry`',
    `wishlist_status` STRING COMMENT 'Current lifecycle status of the wishlist: active (in use), archived (saved but inactive), deleted (soft-deleted), or expired (past event date for registries).. Valid values are `active|archived|deleted|expired`',
    `wishlist_type` STRING COMMENT 'Classification of the wishlist purpose: standard personal wishlist, gift registry for events, save-for-later cart items, favorites collection, private collection, or shared list.. Valid values are `standard|gift_registry|save_for_later|favorites|private_collection|shared_list`',
    CONSTRAINT pk_wishlist PRIMARY KEY(`wishlist_id`)
) COMMENT 'Customer-created product wishlists, saved-for-later collections, and gift registries across Retail e-commerce and mobile platforms (the e-commerce platform). Stores wishlist name, creation date, visibility (private/shared/registry), last modified date, total item count, item-level details (product SKU reference, desired quantity, priority, added date, price-at-add, availability status), associated channel, and conversion status (unconverted/partially-converted/fully-converted). Supports personalized recommendations, targeted promotions, back-in-stock notifications, gift registry workflows, and demand signal generation for merchandising. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`payment_method` (
    `payment_method_id` DECIMAL(18,2) COMMENT 'Primary key for payment_method',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: payment_method has embedded billing address fields (billing_address_line1, billing_address_line2, billing_city, billing_state_province, billing_postal_code, billing_country_code) that should be normal',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this payment method. Links to the customer master record for omnichannel recognition and clienteling.',
    `bin_number` BIGINT COMMENT 'First six digits of the card number (Bank Identification Number). Used for card type identification, fraud detection, and routing. Not considered sensitive under PCI DSS.. Valid values are `^[0-9]{6}$`',
    `bnpl_provider` STRING COMMENT 'Buy-now-pay-later provider. Free-form string; common values include: klarna, affirm, afterpay, zip, sezzle.. Valid values are `affirm|afterpay|klarna|zip|sezzle`',
    `card_brand` STRING COMMENT 'Brand of the payment card; common values include visa, mastercard, amex, discover.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_country_code` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the card was issued. Derived from BIN lookup. Used for fraud detection and international transaction processing.. Valid values are `^[A-Z]{3}$`',
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
    `payment_method_type` DECIMAL(18,2) COMMENT 'Type of payment method. Allowed values: credit_card, debit_card, wallet, gift_card, store_credit, bnpl.. Valid values are `credit_card|debit_card|digital_wallet|gift_card|store_credit|bnpl`',
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

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`privacy_request` (
    `privacy_request_id` BIGINT COMMENT 'Unique identifier for the privacy request. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee or system user assigned to process this privacy request.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who submitted the privacy request.',
    `appeal_outcome` STRING COMMENT 'Outcome of the customer appeal: upheld (original decision maintained), overturned (request re-processed), pending (under review), withdrawn (customer cancelled appeal).. Valid values are `upheld|overturned|pending|withdrawn`',
    `appeal_submitted_flag` BOOLEAN COMMENT 'Indicates whether the customer submitted an appeal or complaint regarding the handling of this privacy request.',
    `appeal_timestamp` TIMESTAMP COMMENT 'Date and time when the customer submitted an appeal or complaint.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the privacy request was assigned to a processor.',
    `audit_log_reference` STRING COMMENT 'Reference identifier to the detailed audit log entries tracking all system actions taken to fulfill this privacy request.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the privacy request was completed and the customer was notified.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this privacy request record was first created in the system.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer was notified of the request outcome via email or other channel.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified of the request outcome.',
    `data_categories_affected` STRING COMMENT 'Comma-separated list of data categories affected by this request (e.g., profile, transaction_history, loyalty, marketing_preferences, location_data).',
    `data_export_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the data export download link expires for security purposes.',
    `data_export_format` STRING COMMENT 'File format used for data portability requests: JSON, CSV, PDF, XML. Applicable only for access and portability request types.. Valid values are `JSON|CSV|PDF|XML`',
    `data_export_url` STRING COMMENT 'Secure download URL for the exported customer data package. Time-limited and encrypted. Applicable for access and portability requests.',
    `denial_reason` STRING COMMENT 'Legal or business justification for denying the privacy request (e.g., legal obligation to retain data, manifestly unfounded request, excessive requests).',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether a deadline extension was granted for this request due to complexity or volume.',
    `extension_reason` STRING COMMENT 'Business justification for granting a deadline extension (e.g., complex request, high volume, technical difficulties).',
    `outcome` STRING COMMENT 'Final outcome of the privacy request: fulfilled (completed as requested), partially_fulfilled (some data unavailable), denied (rejected with justification), withdrawn (cancelled by customer).. Valid values are `fulfilled|partially_fulfilled|denied|withdrawn`',
    `processing_deadline` DATE COMMENT 'Regulatory deadline by which the privacy request must be completed. GDPR: 30 days (extendable to 90), CCPA: 45 days (extendable to 90).',
    `processing_notes` STRING COMMENT 'Internal notes and comments from the assigned processor documenting actions taken, challenges encountered, and decisions made during request processing.',
    `records_anonymized_count` STRING COMMENT 'Number of database records anonymized (PII removed but record retained for analytics) to fulfill an erasure request.',
    `records_deleted_count` STRING COMMENT 'Number of database records deleted across all systems to fulfill an erasure request.',
    `regulatory_framework` STRING COMMENT 'Primary data protection regulation governing this request: GDPR (EU General Data Protection Regulation), CCPA (California Consumer Privacy Act), LGPD (Brazil), PIPEDA (Canada), APPI (Japan), POPIA (South Africa).. Valid values are `GDPR|CCPA|LGPD|PIPEDA|APPI|POPIA`',
    `request_number` BIGINT COMMENT 'Externally-visible unique business identifier for the privacy request, used for customer communication and tracking.. Valid values are `^PR-[0-9]{10}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the privacy request: submitted (initial receipt), pending_verification (identity check in progress), verified (identity confirmed), in_progress (being processed), completed (fulfilled), rejected (denied), cancelled (withdrawn by customer). [ENUM-REF-CANDIDATE: submitted|pending_verification|verified|in_progress|completed|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Type of privacy request: access (right to know), erasure (right to delete), portability (data export), rectification (correction), opt_out_sale (CCPA opt-out), restriction (processing limitation).. Valid values are `access|erasure|portability|rectification|opt_out_sale|restriction`',
    `submission_channel` STRING COMMENT 'Channel through which the privacy request was submitted: web_portal, mobile_app, email, phone, in_store, postal_mail.. Valid values are `web_portal|mobile_app|email|phone|in_store|postal_mail`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the privacy request was submitted by the customer. Principal business event timestamp.',
    `systems_affected` STRING COMMENT 'Comma-separated list of operational systems where data was accessed, modified, or deleted to fulfill this request (e.g., CRM, ERP, WMS, E-commerce).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this privacy request record was last modified.',
    `verification_method` STRING COMMENT 'Method used to verify the customers identity: email_token, sms_code, account_login, document_upload, phone_callback, in_person.. Valid values are `email_token|sms_code|account_login|document_upload|phone_callback|in_person`',
    `verification_status` STRING COMMENT 'Status of customer identity verification: not_started, pending (verification in progress), verified (identity confirmed), failed (verification unsuccessful), exempted (verification not required).. Valid values are `not_started|pending|verified|failed|exempted`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when customer identity verification was completed.',
    CONSTRAINT pk_privacy_request PRIMARY KEY(`privacy_request_id`)
) COMMENT 'Formal customer privacy rights requests submitted under GDPR (right to access, right to erasure, right to portability, right to rectification) and CCPA (right to know, right to delete, right to opt-out of sale). Stores request type, submission channel, submission timestamp, verification status, assigned processor, processing deadline (regulatory SLA), completion timestamp, outcome, and data categories affected. Managed in compliance with GDPR and CCPA as enforced by applicable regulatory bodies. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`customer_membership` (
    `customer_membership_id` BIGINT COMMENT 'Primary key for customer_membership',
    `segment_id` BIGINT COMMENT 'Foreign key linking to the segment definition to which this profile is assigned',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key reference to the SSOT owner loyalty.loyalty_membership.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the customer profile participating in this segment membership',
    `assignment_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00-100.00) indicating the strength of this customers qualification for this segment. For rule-based assignments, reflects how strongly the customer meets qualification criteria. For ML-based assignments, reflects model prediction confidence. Used for prioritizing marketing outreach and identifying borderline members.',
    `assignment_method` STRING COMMENT 'Mechanism by which this customer was assigned to this segment. AutoRefresh: automatically assigned via scheduled segment refresh process. ManualOverride: manually assigned by business user overriding qualification rules. RuleEngine: assigned via real-time rule evaluation. MLModel: assigned via predictive model scoring. BulkImport: assigned via batch data load.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was first created in the system. Audit field for data lineage and troubleshooting.',
    `customer_membership_status` STRING COMMENT 'Current operational status of this segment membership. Active: customer currently qualifies and membership is in effect. Expired: membership ended due to disqualification or time-based expiry. Suspended: temporarily inactive due to business rules. PendingQualification: awaiting next refresh cycle to confirm eligibility.',
    `end_date` DATE COMMENT 'Date when this customer profile exited this segment or the membership was terminated. Null for currently active memberships. Used for churn analysis and segment tenure calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was last updated (status change, confidence score update, override modification). Audit field for change tracking.',
    `last_qualification_check_date` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of this customers eligibility for this segment. Updated during auto-refresh cycles or manual re-qualification checks. Used for audit trails and determining when next qualification check is due.',
    `manual_override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this membership was manually assigned by a business user, overriding automated qualification rules. True: manual override in effect, customer may not meet standard qualification criteria. False: standard rule-based or automated assignment. Used for governance and audit purposes.',
    `membership_fee` DECIMAL(18,2) COMMENT 'The membership fee of the customer membership.',
    `override_reason` STRING COMMENT 'Free-text explanation provided by business user when manual_override_flag is true. Documents business justification for overriding automated qualification rules (e.g., VIP customer per executive request, Strategic account exception, Retention offer). Null when no override is in effect.',
    `renewal_rate` DECIMAL(18,2) COMMENT 'The renewal rate of the customer membership.',
    `start_date` DATE COMMENT 'Date when this customer profile was assigned to this segment and the membership became active. Used for lifecycle tracking and historical analysis of segment transitions.',
    CONSTRAINT pk_customer_membership PRIMARY KEY(`customer_membership_id`)
) COMMENT '[References SSOT: loyalty.loyalty_membership] Customer-to-membership assignment linking table. References loyalty.loyalty_membership as the authoritative membership record. Tracks segment-based membership assignments and qualification methods.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`issuance` (
    `issuance_id` BIGINT COMMENT 'Unique identifier for the issuance record',
    `coupon_id` BIGINT COMMENT 'Reference to the associated promotion coupon if applicable',
    `header_id` BIGINT COMMENT 'Reference to the order that triggered or is associated with this issuance',
    `associate_id` BIGINT COMMENT 'Reference to the associate who processed the issuance',
    `issuance_issued_by_associate_id` BIGINT COMMENT 'Associate who authorized or triggered the issuance.',
    `location_id` BIGINT COMMENT 'Reference to the store location where the issuance was created',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile receiving the issuance',
    `issuance_recipient_profile_id` BIGINT COMMENT 'Profile ID of the recipient if the issuance was gifted or transferred to another customer.',
    `issuance_redemption_location_id` BIGINT COMMENT 'Reference to the store location where redemption occurred',
    `loyalty_membership_id` BIGINT COMMENT 'Reference to the loyalty membership associated with this issuance',
    `original_issuance_id` BIGINT COMMENT 'Reference to the original issuance if this is a replacement or reissue.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the promotional campaign that funded this issuance',
    `activation_channel` STRING COMMENT 'Channel through which the issuance was activated such as in_store, online, or mobile_app.',
    `activation_date` DATE COMMENT 'Date when the issuance becomes active and available for redemption.',
    `actual_redemption_count` STRING COMMENT 'Number of times this issuance has been redeemed so far',
    `amount` DECIMAL(18,2) COMMENT 'Monetary face value of the issued instrument.',
    `applicable_category_list` STRING COMMENT 'Comma-separated list of merchandise categories where issuance is valid',
    `auto_reload_flag` BOOLEAN COMMENT 'Indicates whether the issuance is configured for automatic balance reload.',
    `barcode` STRING COMMENT 'Barcode or serial number printed on the physical or digital issuance.',
    `barcode_value` DECIMAL(18,2) COMMENT 'Barcode or QR code value printed on the physical or digital issuance.',
    `batch_number` BIGINT COMMENT 'Batch identifier for bulk issuance operations',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the issuance was voided',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the issuance was cancelled',
    `issuance_category` STRING COMMENT 'High-level category of the issuance such as gift_card, store_credit, voucher, or promotional_credit.',
    `channel` STRING COMMENT 'Channel through which the issuance was created (e.g. in_store, online, call_center)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the issuance record was created in the system',
    `currency_code` STRING COMMENT 'ISO currency code for the issuance value',
    `delivery_method` STRING COMMENT 'How the issuance was delivered to the customer (e.g. email, sms, print, in_app).',
    `discount_type` DECIMAL(18,2) COMMENT 'Type of discount provided (e.g. fixed_amount, percentage, free_item)',
    `excluded_sku_list` STRING COMMENT 'Comma-separated list of SKUs excluded from issuance redemption',
    `expiration_date` DECIMAL(18,2) COMMENT 'Alternative expiration date field for backward compatibility',
    `expiry_date` DATE COMMENT 'Date when the issuance expires and can no longer be redeemed',
    `face_value_amount` DECIMAL(18,2) COMMENT 'Printed or displayed face value of the issuance instrument',
    `fraud_check_status` STRING COMMENT 'Status of fraud verification for this issuance such as passed, flagged, or under_review.',
    `is_transferable` BOOLEAN COMMENT 'Whether this issuance can be transferred to another customer.',
    `issuance_number` BIGINT COMMENT 'Human-readable issuance reference number',
    `issuance_reason_code` STRING COMMENT 'Business reason for the issuance (e.g., service_recovery, birthday, promotion, referral).',
    `issuance_status` STRING COMMENT 'Current lifecycle status (e.g. active, redeemed, expired, cancelled, suspended)',
    `issuance_type` STRING COMMENT 'Type of value issued (e.g. store_credit, gift_card, coupon, voucher, rebate_check)',
    `issue_channel` STRING COMMENT 'Specific channel method used for issuance delivery (e.g. email, print, app_push)',
    `issue_date` DATE COMMENT 'Date the issuance instrument was physically or digitally delivered',
    `issued_amount` DECIMAL(18,2) COMMENT 'Original monetary value issued to the customer',
    `issued_date` DATE COMMENT 'Date when the issuance was created and made available',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the last modification to any field',
    `max_redemption_count` STRING COMMENT 'Maximum number of times this issuance can be redeemed',
    `method` STRING COMMENT 'Method of issuance delivery (e.g. physical_card, digital, barcode, qr_code)',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase amount required to redeem this issuance',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates if the customer was notified about this issuance',
    `notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification was sent to the customer',
    `partial_redemption_allowed_flag` BOOLEAN COMMENT 'Indicates if partial value redemption is permitted',
    `personalization_discount_override` DECIMAL(18,2) COMMENT 'Override discount amount for personalized issuances',
    `reason_code` STRING COMMENT 'Business reason for the issuance (e.g. return, complaint, loyalty_reward, promotion)',
    `redeemed_date` DATE COMMENT 'Date when the issuance was fully redeemed',
    `redeemed_flag` BOOLEAN COMMENT 'Indicates whether the issuance has been fully redeemed',
    `redemption_channel` STRING COMMENT 'Channel through which the issuance was redeemed (in_store, online, mobile).',
    `redemption_count` STRING COMMENT 'Number of times this issuance has been redeemed so far.',
    `redemption_date` DATE COMMENT 'Date of the most recent redemption transaction',
    `redemption_status` STRING COMMENT 'Status of redemption (e.g. not_redeemed, partial, full)',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Current remaining unredeemed monetary value',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Remaining unredeemed balance for stored-value issuances.',
    `remaining_value_amount` DECIMAL(18,2) COMMENT 'Remaining unredeemed value of the issued instrument.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates if this issuance can be combined with other offers',
    `tax_exempt_flag` DECIMAL(18,2) COMMENT 'Indicates whether the issuance value is exempt from sales tax upon redemption.',
    `terms_and_conditions_version` STRING COMMENT 'Version of T&C applicable to this issuance',
    `transfer_eligible_flag` BOOLEAN COMMENT 'Indicates if the issuance can be transferred to another customer',
    `trigger_event` STRING COMMENT 'Event that triggered the issuance (e.g. return_processed, birthday, milestone)',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record',
    `value` DECIMAL(18,2) COMMENT 'Face value amount of the issuance instrument',
    `void_reason` STRING COMMENT 'Reason for voiding the issuance if applicable.',
    `voided_flag` BOOLEAN COMMENT 'Whether the issuance has been voided or cancelled before use.',
    CONSTRAINT pk_issuance PRIMARY KEY(`issuance_id`)
) COMMENT 'Tracks customer-facing value issuances such as store credits, gift cards, coupons, and promotional vouchers including their lifecycle from creation through redemption or expiration.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`targeting` (
    `targeting_id` BIGINT COMMENT 'Unique identifier for this segment-campaign targeting record. Primary key.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to the customer segment being targeted in this campaign',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when this segment was activated for targeting within the campaign. May differ from campaign start date if segments are activated in waves.',
    `actual_reached_count` BIGINT COMMENT 'Actual number of customers from this segment who were successfully reached by campaign communications (emails delivered, ads served, SMS sent, etc.).',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'Portion of the campaign budget allocated specifically to reaching this customer segment. Sum of all segment allocations should equal or be less than total campaign budget.',
    `conversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of reached customers from this segment who completed the desired campaign conversion action (purchase, sign-up, etc.). Calculated as (converters / actual_reached_count) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this targeting record was created in the system. Audit field.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when this segment targeting was deactivated or completed. Null for currently active targeting.',
    `estimated_reach` BIGINT COMMENT 'Estimated number of customers from this segment expected to be reached by the campaign based on segment membership count and channel penetration rates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this targeting record was last updated. Audit field.',
    `priority` STRING COMMENT 'Priority level assigned to this segment within the campaigns targeting strategy. Primary: main target audience; Secondary: secondary audience for expansion; Tertiary: opportunistic reach; Excluded: explicitly excluded from campaign.',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of reached customers from this segment who responded to the campaign (clicked, opened, visited store, etc.). Calculated as (responders / actual_reached_count) * 100.',
    `targeting_status` STRING COMMENT 'Current operational status of this segment targeting within the campaign. Planned: scheduled but not yet active; Active: currently being executed; Paused: temporarily suspended; Completed: execution finished; Cancelled: targeting cancelled before completion.',
    CONSTRAINT pk_targeting PRIMARY KEY(`targeting_id`)
) COMMENT 'This association product represents the targeting relationship between customer segments and marketing campaigns. It captures the operational activation of specific customer segments within campaign execution, tracking targeting priority, budget allocation, reach metrics, and performance outcomes for each segment-campaign combination. Each record links one customer segment to one marketing campaign with attributes that exist only in the context of this targeted activation.. Existence Justification: In retail marketing operations, campaigns routinely target multiple customer segments simultaneously (e.g., a seasonal promotion targeting VIP Gold, Geographic Region A, and High-Value Lapsed segments), and customer segments participate in multiple concurrent campaigns (e.g., VIP Gold segment is targeted by loyalty rewards campaign, seasonal sale, and category-specific promotion). The business actively manages segment targeting as an operational entity, allocating budget per segment, setting targeting priorities, and measuring segment-specific performance metrics (response rates, conversion rates, reach) for campaign optimization and ROI analysis. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` (
    `segment_banner_targeting_id` BIGINT COMMENT 'Unique identifier for this segment-banner targeting relationship. Primary key.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to the customer segment being targeted by this banner placement',
    `attributed_revenue` DECIMAL(18,2) COMMENT 'Total revenue generated by customers in this segment attributed to this banner through click-through and conversion tracking. Enables segment-level ROI analysis.',
    `click_count` BIGINT COMMENT 'Total number of times customers in this segment have clicked on this banner. Used to calculate segment-specific CTR and engagement.',
    `conversion_count` BIGINT COMMENT 'Total number of conversions (orders placed) by customers in this segment attributed to this banner through click-through tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this segment targeting relationship was first configured in the campaign management system.',
    `end_date` DATE COMMENT 'Date when this banner stopped being targeted to this specific segment. May differ from the banners overall end_date if segment targeting is phased or A/B tested.',
    `impression_count` BIGINT COMMENT 'Total number of times this banner has been displayed to customers in this segment. Used to calculate segment-specific reach and CTR.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this segment targeting configuration was last updated (status change, date adjustment, etc.).',
    `start_date` DATE COMMENT 'Date when this banner began being targeted to this specific segment. May differ from the banners overall start_date if segment targeting is phased.',
    `targeting_status` STRING COMMENT 'Current status of this segment targeting configuration. Active: currently displaying to segment; Paused: temporarily disabled; Completed: ended normally; Cancelled: ended early.',
    CONSTRAINT pk_segment_banner_targeting PRIMARY KEY(`segment_banner_targeting_id`)
) COMMENT 'This association product represents the targeting relationship between customer segments and promotional banners in digital marketing campaigns. It captures campaign performance metrics specific to each segment-banner combination, enabling marketing attribution analysis, segment ROI measurement, and campaign optimization. Each record links one customer segment to one promotional banner with performance metrics and display scheduling that exist only in the context of this targeted marketing relationship.. Existence Justification: In retail digital marketing operations, promotional banners are actively targeted to multiple customer segments simultaneously through campaign management systems (e.g., VIP Gold sees Banner A, Lapsed Customers see Banner B, but both segments may also see Banner C in different placements or time windows). Each segment-banner combination generates its own performance metrics (impressions, clicks, conversions, attributed revenue) that marketing teams use for attribution analysis, segment ROI measurement, and campaign optimization. This is an operational marketing execution relationship that humans actively configure, monitor, and optimize. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`client_relationship` (
    `client_relationship_id` BIGINT COMMENT 'Unique identifier for the client relationship record',
    `account_id` BIGINT COMMENT 'Reference to the customer account for B2B relationships',
    `associate_id` BIGINT COMMENT 'Reference to the assigned client advisor or account manager',
    `location_id` BIGINT COMMENT 'Reference to the primary store location for this relationship',
    `client_store_location_id` BIGINT COMMENT 'Store location where the client relationship is primarily managed.',
    `loyalty_membership_id` BIGINT COMMENT 'Loyalty membership linked to this client relationship for personalized service.',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile in this relationship',
    `actual_annual_spend` DECIMAL(18,2) COMMENT 'Actual annual spend amount achieved in the current period',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Clients annual spend attributed to this relationship for performance tracking.',
    `annual_spend_target` DECIMAL(18,2) COMMENT 'Target annual spend amount for this client relationship',
    `assigned_team` STRING COMMENT 'Team or department responsible for this client relationship',
    `assignment_status` STRING COMMENT 'Status of the advisor assignment (e.g. confirmed, provisional, reassigning)',
    `channel_preference` STRING COMMENT 'Preferred engagement channel (e.g. in_store, virtual, hybrid)',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score indicating likelihood of relationship termination',
    `communication_preference` STRING COMMENT 'Detailed communication preferences for this relationship',
    `contract_reference` STRING COMMENT 'Reference to any formal service agreement or contract',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the relationship record was created',
    `currency_code` STRING COMMENT 'ISO currency code for monetary values in this record',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates whether the client has requested no proactive outreach.',
    `end_date` DATE COMMENT 'Date when the client relationship was terminated or expired',
    `engagement_score` DECIMAL(18,2) COMMENT 'Composite engagement score reflecting frequency and quality of interactions.',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact',
    `escalation_contact_name` STRING COMMENT 'Name of the escalation contact for this relationship',
    `gift_preference_notes` STRING COMMENT 'Notes on client gift preferences for clienteling and special occasions.',
    `interaction_count` STRING COMMENT 'Total number of recorded interactions in this relationship',
    `interaction_frequency` DECIMAL(18,2) COMMENT 'Agreed frequency of proactive outreach (e.g. weekly, monthly, quarterly)',
    `last_interaction_date` DATE COMMENT 'Date of the most recent interaction between advisor and client',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase attributed to this client relationship.',
    `last_review_date` DATE COMMENT 'Date of the last formal relationship review',
    `lifetime_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue attributed to this client relationship.',
    `lifetime_value_amount` DECIMAL(18,2) COMMENT 'Estimated lifetime value of this client relationship',
    `next_scheduled_contact_date` DATE COMMENT 'Date of the next planned outreach or appointment',
    `notes` STRING COMMENT 'Free-text notes about the relationship and client preferences',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score specific to this client relationship',
    `preferred_appointment_day` STRING COMMENT 'Preferred day of the week for scheduled appointments or contacts.',
    `preferred_contact_method` STRING COMMENT 'Customers preferred method of contact (e.g. phone, email, text, in_person)',
    `preferred_contact_time` TIMESTAMP COMMENT 'Clients preferred time window for outreach (e.g. morning, afternoon, evening).',
    `preferred_language` STRING COMMENT 'Clients preferred language for communications',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates if this is the primary advisor relationship for the customer',
    `priority_level` STRING COMMENT 'Priority classification (e.g. platinum, gold, standard)',
    `referral_count` STRING COMMENT 'Number of successful referrals generated through this relationship',
    `referral_source` STRING COMMENT 'How the client was originally referred to this associate.',
    `relationship_health_score` DECIMAL(18,2) COMMENT 'Composite health score combining engagement, satisfaction, and spend metrics',
    `relationship_manager_change_date` DATE COMMENT 'Date when the assigned relationship manager was last changed.',
    `relationship_origin` STRING COMMENT 'How the client relationship was initiated such as walk_in, referral, campaign, or corporate_assignment.',
    `relationship_status` STRING COMMENT 'Current status (e.g. active, paused, terminated, pending_assignment)',
    `relationship_tier` STRING COMMENT 'Service tier level for this relationship (e.g. vip, premium, standard)',
    `relationship_type` STRING COMMENT 'Type of relationship (e.g. personal_shopper, account_manager, stylist, concierge)',
    `renewal_date` DATE COMMENT 'Date when the relationship agreement is due for renewal',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Total revenue attributed to this client relationship',
    `satisfaction_score` DECIMAL(18,2) COMMENT 'Client satisfaction score for this relationship on a normalized scale',
    `service_level_agreement` STRING COMMENT 'Description of the agreed service level for this relationship',
    `start_date` DATE COMMENT 'Date when the client relationship was established',
    `total_transactions_count` DECIMAL(18,2) COMMENT 'Total number of transactions completed under this client relationship.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record',
    `vip_flag` BOOLEAN COMMENT 'Whether the client is flagged as a VIP within this relationship context.',
    CONSTRAINT pk_client_relationship PRIMARY KEY(`client_relationship_id`)
) COMMENT 'Manages the assignment and tracking of dedicated client advisors or account managers to customer profiles, supporting clienteling programs with relationship health metrics and engagement tracking.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`b2b_contract` (
    `b2b_contract_id` BIGINT COMMENT 'Primary key for b2b_contract',
    `associate_id` BIGINT COMMENT 'Reference to the employee who provided final approval for this contract.',
    `b2b_associate_id` BIGINT COMMENT 'Reference to the employee responsible for managing this B2B customer relationship and contract.',
    `contract_template_id` BIGINT COMMENT 'Reference to the standard contract template used as the basis for this agreement.',
    `corporate_account_id` DECIMAL(18,2) COMMENT 'Reference to the B2B customer organization that is party to this contract.',
    `master_b2b_contract_id` BIGINT COMMENT 'Self-referencing FK on b2b_contract (master_b2b_contract_id)',
    `sales_territory_id` BIGINT COMMENT 'Reference to the geographic or organizational sales territory to which this contract is assigned.',
    `approved_date` DATE COMMENT 'Date when the contract received final internal approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract is configured to automatically renew upon expiration.',
    `billing_frequency` DECIMAL(18,2) COMMENT 'Frequency at which invoices are generated and payments are due under this contract.',
    `contract_document_url` STRING COMMENT 'Reference link or storage location for the signed contract document.',
    `contract_number` BIGINT COMMENT 'Externally-known unique business identifier for the contract, used in communications and documentation.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract indicating its operational validity and enforceability.',
    `contract_type` STRING COMMENT 'Classification of the contract based on its business purpose and legal structure.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract over its full term, representing the expected revenue or commitment amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding credit amount allowed for the customer under this contract.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount rate applied to list prices for this B2B customer under the contract terms.',
    `effective_end_date` DATE COMMENT 'Date when the contract terms expire or are scheduled to terminate. Nullable for open-ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract terms become legally binding and operational.',
    `exclusive_agreement_flag` BOOLEAN COMMENT 'Indicates whether this is an exclusive supply or distribution agreement preventing the customer from engaging competitors.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law under which the contract is interpreted and enforced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated in the system.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum purchase amount required per order or billing period as stipulated in the contract.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the contract for internal reference.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Description of payment conditions including timing, method, and any special arrangements (e.g., Net 30, Net 60, advance payment).',
    `penalty_terms` STRING COMMENT 'Description of financial penalties or remedies for breach of contract terms or service level failures.',
    `pricing_tier` STRING COMMENT 'Pricing level or tier assigned to this contract, determining applicable rates and discounts.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal notice must be provided, as specified in contract terms.',
    `renewal_type` STRING COMMENT 'Indicates whether the contract automatically renews, requires manual renewal, or is non-renewable.',
    `service_level_agreement` STRING COMMENT 'Description of service level commitments including delivery times, quality standards, and performance metrics.',
    `signed_date` DATE COMMENT 'Date when the contract was executed and signed by all parties.',
    `termination_date` DATE COMMENT 'Actual date when the contract was terminated, if applicable. Null for active contracts.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for contract termination by either party.',
    `termination_reason` STRING COMMENT 'Explanation or business reason for contract termination, if terminated.',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Total volume or quantity the customer commits to purchase over the contract term.',
    CONSTRAINT pk_b2b_contract PRIMARY KEY(`b2b_contract_id`)
) COMMENT 'Master reference table for b2b_contract. Referenced by b2b_contract_id. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`contract_template` (
    `contract_template_id` BIGINT COMMENT 'Primary key for contract_template',
    `parent_contract_template_id` BIGINT COMMENT 'Self-referencing FK on contract_template (parent_contract_template_id)',
    `approval_level` STRING COMMENT 'Organizational level or role required to approve contracts generated from this template.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether contracts generated from this template require formal approval before execution.',
    `approved_by` STRING COMMENT 'Identifier or name of the user or authority who approved this template for active use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this contract template was formally approved for use.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether contracts generated from this template include automatic renewal provisions by default.',
    `compliance_tags` STRING COMMENT 'Comma-separated list of regulatory or compliance frameworks this template adheres to, such as GDPR, CCPA, SOX, or industry-specific regulations.',
    `confidentiality_clause_included` BOOLEAN COMMENT 'Indicates whether the template includes confidentiality and non-disclosure provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract template record was first created in the system.',
    `default_term_length_days` STRING COMMENT 'Standard duration in days for contracts generated from this template, representing the default commitment period.',
    `contract_template_description` STRING COMMENT 'Detailed business description of the contract template purpose, scope, and intended use cases.',
    `dispute_resolution_method` STRING COMMENT 'Primary mechanism specified in the template for resolving disputes between contracting parties.',
    `effective_end_date` DATE COMMENT 'Date after which this contract template version is no longer valid for generating new contracts. Nullable for templates with indefinite validity.',
    `effective_start_date` DATE COMMENT 'Date from which this contract template version becomes valid and available for use in generating new contracts.',
    `governing_law` STRING COMMENT 'Specific legal framework, statute, or body of law that governs contracts created from this template.',
    `language_code` STRING COMMENT 'Two-letter ISO language code indicating the primary language in which the contract template is written.',
    `last_used_date` DATE COMMENT 'Most recent date on which this template was used to generate a contract.',
    `legal_jurisdiction` STRING COMMENT 'Three-letter ISO country code indicating the primary legal jurisdiction under which contracts generated from this template are governed.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount specified in the template, representing the upper limit of financial exposure.',
    `liability_cap_currency` STRING COMMENT 'Three-letter ISO currency code for the liability cap amount.',
    `modified_by` STRING COMMENT 'Identifier or name of the user or system that most recently modified this contract template.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract template record was last modified.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or instructions related to the use or maintenance of this contract template.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before contract renewal or termination, as specified in the template.',
    `review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of this contract template to ensure continued legal and business relevance.',
    `contract_template_status` STRING COMMENT 'Current lifecycle status of the contract template indicating its availability for use in contract generation.',
    `template_category` STRING COMMENT 'High-level category indicating the primary counterparty type this template is designed for.',
    `template_code` STRING COMMENT 'Externally-known unique business identifier code for the contract template, used for reference across systems and documentation.',
    `template_content` STRING COMMENT 'Full text content of the contract template including placeholders, clauses, terms, and conditions. May contain markup or template syntax.',
    `template_format` STRING COMMENT 'Technical format or markup language used to structure the template content.',
    `template_name` STRING COMMENT 'Human-readable name of the contract template that clearly identifies its purpose and use case.',
    `template_type` STRING COMMENT 'Classification of the contract template by its primary business purpose and legal structure.',
    `termination_clause_included` BOOLEAN COMMENT 'Indicates whether the template includes standard termination provisions and exit clauses.',
    `usage_count` STRING COMMENT 'Total number of contracts that have been generated using this template, tracking template adoption and popularity.',
    `version_number` BIGINT COMMENT 'Semantic version number of the contract template following major.minor.patch convention to track template evolution.',
    `created_by` STRING COMMENT 'Identifier or name of the user or system that originally created this contract template.',
    CONSTRAINT pk_contract_template PRIMARY KEY(`contract_template_id`)
) COMMENT 'Master reference table for contract_template. Referenced by contract_template_id. Deployed to retail_mvm (MVM) and retail_mvm (ECM) as distinct schemas.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`communication_preference` (
    `communication_preference_id` BIGINT COMMENT '',
    `profile_id` BIGINT COMMENT '',
    `communication_channel` STRING COMMENT '',
    `language` STRING COMMENT '',
    `notification_frequency` STRING COMMENT '',
    `privacy_consent` BOOLEAN COMMENT '',
    `marketing_opt_in` BOOLEAN COMMENT '',
    CONSTRAINT pk_communication_preference PRIMARY KEY(`communication_preference_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`dietary_restriction` (
    `dietary_restriction_id` BIGINT COMMENT '',
    `profile_id` BIGINT COMMENT '',
    `restriction_type` STRING COMMENT '',
    `notes` STRING COMMENT '',
    CONSTRAINT pk_dietary_restriction PRIMARY KEY(`dietary_restriction_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`customer`.`customer_attribute` (
    `customer_attribute_id` BIGINT COMMENT '',
    `profile_id` BIGINT COMMENT '',
    `key` STRING COMMENT '',
    `value` STRING COMMENT '',
    CONSTRAINT pk_customer_attribute PRIMARY KEY(`customer_attribute_id`)
) COMMENT '';

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
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ADD CONSTRAINT `fk_customer_identity_link_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_retail_v1`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_parent_case_service_case_id` FOREIGN KEY (`parent_case_service_case_id`) REFERENCES `vibe_retail_v1`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ADD CONSTRAINT `fk_customer_wishlist_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ADD CONSTRAINT `fk_customer_wishlist_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ADD CONSTRAINT `fk_customer_privacy_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ADD CONSTRAINT `fk_customer_customer_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_retail_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ADD CONSTRAINT `fk_customer_customer_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ADD CONSTRAINT `fk_customer_issuance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ADD CONSTRAINT `fk_customer_issuance_issuance_recipient_profile_id` FOREIGN KEY (`issuance_recipient_profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ADD CONSTRAINT `fk_customer_issuance_original_issuance_id` FOREIGN KEY (`original_issuance_id`) REFERENCES `vibe_retail_v1`.`customer`.`issuance`(`issuance_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ADD CONSTRAINT `fk_customer_targeting_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_retail_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ADD CONSTRAINT `fk_customer_segment_banner_targeting_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_retail_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ADD CONSTRAINT `fk_customer_client_relationship_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_retail_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ADD CONSTRAINT `fk_customer_client_relationship_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ADD CONSTRAINT `fk_customer_b2b_contract_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `vibe_retail_v1`.`customer`.`contract_template`(`contract_template_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ADD CONSTRAINT `fk_customer_b2b_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_retail_v1`.`customer`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ADD CONSTRAINT `fk_customer_b2b_contract_master_b2b_contract_id` FOREIGN KEY (`master_b2b_contract_id`) REFERENCES `vibe_retail_v1`.`customer`.`b2b_contract`(`b2b_contract_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ADD CONSTRAINT `fk_customer_contract_template_parent_contract_template_id` FOREIGN KEY (`parent_contract_template_id`) REFERENCES `vibe_retail_v1`.`customer`.`contract_template`(`contract_template_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ADD CONSTRAINT `fk_customer_communication_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`dietary_restriction` ADD CONSTRAINT `fk_customer_dietary_restriction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_attribute` ADD CONSTRAINT `fk_customer_customer_attribute_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_retail_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_retail_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_subdomain' = 'identity_core');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_model_tier' = 'mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_identity_root' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_b2c_required' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` SET TAGS ('dbx_entity_role' = 'identity_core');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|none');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Customer Preferred Language');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blocked|closed');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `scd_changed_by` SET TAGS ('dbx_business_glossary_term' = 'SCD Changed By');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_overlap_owner' = 'profile');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_source' = 'profile_account_merge');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_overlap_owner' = 'profile');
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_source' = 'profile_account_merge');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'identity_core');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_model_tier' = 'mvm_optional');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_b2b_only' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_optional' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_scope' = 'b2b_wholesale');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` SET TAGS ('dbx_entity_role' = 'optional_b2b');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_retype_attribute' = 'BIGINT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `profile_id` SET TAGS ('dbx_nullable' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|frozen|dormant');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'personal|business|employee|wholesale');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`household` SET TAGS ('dbx_subdomain' = 'identity_core');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Reference');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `average_basket_value` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Value');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `combined_cltv` SET TAGS ('dbx_business_glossary_term' = 'Combined CLTV');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Head of Household Profile');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Household Segment');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_loyalty_points` SET TAGS ('dbx_business_glossary_term' = 'Total Loyalty Points');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_loyalty_points` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_loyalty_points` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_purchase_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_purchase_count` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_purchase_count` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_subdomain' = 'identity_core');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_retype_attribute' = 'BIGINT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Associate Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Corporate Account ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `account_established_date` SET TAGS ('dbx_business_glossary_term' = 'Account Established Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `account_established_date` SET TAGS ('dbx_retype_attribute' = 'DATE->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Tier');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `business_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Business Entity Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `contract_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|pending|declined|under_review|suspended');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'identity_core');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_model_tier' = 'mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|bounced|invalid|suppressed|pending_verification');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'identity_core');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_model_tier' = 'mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`address` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'engagement_intelligence');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Associate Id (Foreign Key)');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `discount_sensitivity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ALTER COLUMN `target_marketing_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Marketing Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_subdomain' = 'identity_core');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identity_link_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Link ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Match Rule ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile|call_center|social_media');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|pending|withdrawn|expired');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_first_seen_date` SET TAGS ('dbx_business_glossary_term' = 'Identifier First Seen Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_last_seen_date` SET TAGS ('dbx_business_glossary_term' = 'Identifier Last Seen Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'loyalty_card|email_hash|device_id|cookie_id|pos_customer_id|salesforce_contact_id');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Identifier Usage Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Identifier Value');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `identifier_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `is_primary_identifier` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identifier Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Link Confidence Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Link Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Link Effective From Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Link Effective To Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_method` SET TAGS ('dbx_business_glossary_term' = 'Link Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_method` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic|manual|third_party');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_notes` SET TAGS ('dbx_business_glossary_term' = 'Link Notes');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Link Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|rejected|superseded');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `link_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Link Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `linked_by_user` SET TAGS ('dbx_business_glossary_term' = 'Linked By User');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `match_attributes` SET TAGS ('dbx_business_glossary_term' = 'Match Attributes');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `merge_history_reference` SET TAGS ('dbx_business_glossary_term' = 'Merge History Reference');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|pending');
ALTER TABLE `vibe_retail_v1`.`customer`.`identity_link` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_intelligence');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_subdomain' = 'service_relationship');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `parent_case_service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Case ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `case_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Case Owner Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `case_owner_type` SET TAGS ('dbx_value_regex' = 'agent|queue|automated_system');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel of Origin');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `contact_attempts` SET TAGS ('dbx_business_glossary_term' = 'Contact Attempts');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Rating');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `service_case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `first_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Interaction Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `nps_score` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `nps_score` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA[A-Z0-9]{8,15}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `rma_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_retail_v1`.`customer`.`service_case` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_subdomain' = 'engagement_intelligence');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_id` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Consultant Associate Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Creation Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|mobile_web|in_store_kiosk|call_center');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_first_name` SET TAGS ('dbx_business_glossary_term' = 'Co-Registrant First Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_last_name` SET TAGS ('dbx_business_glossary_term' = 'Co-Registrant Last Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `co_registrant_last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `conversion_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Conversion Rate Percentage');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Conversion Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'unconverted|partially_converted|fully_converted');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deleted Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_description` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Description');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|tablet|smartphone|kiosk|unknown');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Event Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `external_wishlist_code` SET TAGS ('dbx_business_glossary_term' = 'External Wishlist ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `first_conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Conversion Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `is_default_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Default Wishlist Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `last_conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Conversion Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `last_viewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Viewed Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_name` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `notification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `notification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Notification Frequency');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `notification_frequency` SET TAGS ('dbx_value_regex' = 'immediate|daily|weekly|event_based|disabled');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `notification_frequency` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `notification_frequency` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_first_name` SET TAGS ('dbx_business_glossary_term' = 'Registrant First Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_last_name` SET TAGS ('dbx_business_glossary_term' = 'Registrant Last Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registrant_last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registry_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Registry Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `registry_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `share_count` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Share Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `share_url` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Share URL (Uniform Resource Locator)');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `total_item_count` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `total_item_count` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `total_quantity` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `total_quantity` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `total_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Wishlist Value Amount');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'Wishlist View Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `visibility` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Visibility');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `visibility` SET TAGS ('dbx_value_regex' = 'private|shared|public|registry');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_status` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted|expired');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_type` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`wishlist` ALTER COLUMN `wishlist_type` SET TAGS ('dbx_value_regex' = 'standard|gift_registry|save_for_later|favorites|private_collection|shared_list');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_subdomain' = 'service_relationship');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_deprecated' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_moved_to' = 'finance.payment_instrument');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_retype_attribute' = 'BIGINT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later (BNPL) Provider');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_value_regex' = 'affirm|afterpay|klarna|zip|sezzle');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_country_code` SET TAGS ('dbx_business_glossary_term' = 'Card Issuing Country Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `card_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|digital_wallet|gift_card|store_credit|bnpl');
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
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Processor ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|pending|withdrawn');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `appeal_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `appeal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `data_categories_affected` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Affected');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `data_export_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Export Expiry Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `data_export_format` SET TAGS ('dbx_business_glossary_term' = 'Data Export Format');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `data_export_format` SET TAGS ('dbx_value_regex' = 'JSON|CSV|PDF|XML');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `data_export_url` SET TAGS ('dbx_business_glossary_term' = 'Data Export URL');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `data_export_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Request Outcome');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'fulfilled|partially_fulfilled|denied|withdrawn');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `processing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Processing Deadline');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `processing_notes` SET TAGS ('dbx_business_glossary_term' = 'Processing Notes');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `processing_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `records_anonymized_count` SET TAGS ('dbx_business_glossary_term' = 'Records Anonymized Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `records_deleted_count` SET TAGS ('dbx_business_glossary_term' = 'Records Deleted Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|LGPD|PIPEDA|APPI|POPIA');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{10}$');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'access|erasure|portability|rectification|opt_out_sale|restriction');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|email|phone|in_store|postal_mail');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `systems_affected` SET TAGS ('dbx_business_glossary_term' = 'Systems Affected');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email_token|sms_code|account_login|document_upload|phone_callback|in_person');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|exempted');
ALTER TABLE `vibe_retail_v1`.`customer`.`privacy_request` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_subdomain' = 'engagement_intelligence');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_association_edges' = 'customer.profile,customer.segment');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_ssot_authoritative_owner' = 'loyalty.loyalty_membership');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_ssot_role' = 'non_authoritative');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_ssot_owner' = 'loyalty.loyalty_membership');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_ssot_reference' = 'loyalty.loyalty_membership');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_ssot_authoritative_source' = 'loyalty.loyalty_membership');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `customer_membership_id` SET TAGS ('dbx_business_glossary_term' = 'customer_membership Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Membership - Customer Segment Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Membership - Profile Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `assignment_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `customer_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `last_qualification_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Check Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `manual_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_membership` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_subdomain' = 'service_relationship');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_association_edges' = 'customer.profile,promotion.coupon');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `batch_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `discount_type` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `discount_type` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_retype_attribute' = 'DATE->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `issuance_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_retype_attribute' = 'BOOLEAN->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`issuance` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_subdomain' = 'engagement_intelligence');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_association_edges' = 'customer.segment,marketing.campaign');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `targeting_id` SET TAGS ('dbx_business_glossary_term' = 'Targeting Record Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Targeting - Customer Segment Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `actual_reached_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Segment Reach');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Segment Budget Allocation');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Segment Conversion Rate');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Deactivation Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Segment Reach');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Targeting Priority Level');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `response_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Segment Response Rate');
ALTER TABLE `vibe_retail_v1`.`customer`.`targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_business_glossary_term' = 'Targeting Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_subdomain' = 'engagement_intelligence');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_association_edges' = 'customer.segment,ecommerce.promotion_banner');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `segment_banner_targeting_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Banner Targeting ID');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Banner Targeting - Customer Segment Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`segment_banner_targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_business_glossary_term' = 'Targeting Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_subdomain' = 'service_relationship');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_association_edges' = 'customer.profile,workforce.associate');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `interaction_frequency` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `interaction_frequency` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `total_transactions_count` SET TAGS ('dbx_retype_attribute' = 'INT->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`client_relationship` ALTER COLUMN `total_transactions_count` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `b2b_contract_id` SET TAGS ('dbx_business_glossary_term' = 'B2B Contract Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Associate Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `b2b_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_retype_attribute' = 'BIGINT->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `master_b2b_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Master B2b Contract Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `master_b2b_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(9');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_4)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Url');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `exclusive_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Agreement Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_retype_attribute' = 'STRING->DECIMAL(18');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_2)' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `penalty_terms` SET TAGS ('dbx_business_glossary_term' = 'Penalty Terms');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `penalty_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `vibe_retail_v1`.`customer`.`b2b_contract` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_vendor_neutral' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_model_tier' = 'ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_catalog_mvm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_catalog_ecm' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_mvm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_ecm_catalog' = 'retail_mvm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Identifier');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `parent_contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Contract Template Id');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `parent_contract_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tags');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `confidentiality_clause_included` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Included');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `default_term_length_days` SET TAGS ('dbx_business_glossary_term' = 'Default Term Length Days');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `contract_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `legal_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Currency');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `contract_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_category` SET TAGS ('dbx_business_glossary_term' = 'Template Category');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_content` SET TAGS ('dbx_business_glossary_term' = 'Template Content');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_content` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_format` SET TAGS ('dbx_business_glossary_term' = 'Template Format');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `termination_clause_included` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause Included');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `version_number` SET TAGS ('dbx_retype_attribute' = 'STRING->INTEGER');
ALTER TABLE `vibe_retail_v1`.`customer`.`contract_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ALTER COLUMN `communication_preference_id` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ALTER COLUMN `communication_channel` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ALTER COLUMN `language` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ALTER COLUMN `notification_frequency` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ALTER COLUMN `privacy_consent` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`communication_preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`dietary_restriction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`dietary_restriction` ALTER COLUMN `dietary_restriction_id` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`dietary_restriction` ALTER COLUMN `profile_id` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`dietary_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`dietary_restriction` ALTER COLUMN `notes` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_attribute` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_attribute` ALTER COLUMN `customer_attribute_id` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_attribute` ALTER COLUMN `profile_id` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_attribute` ALTER COLUMN `key` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_retail_v1`.`customer`.`customer_attribute` ALTER COLUMN `value` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
