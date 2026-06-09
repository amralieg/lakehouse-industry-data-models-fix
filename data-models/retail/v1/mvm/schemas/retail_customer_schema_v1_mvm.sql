-- Schema for Domain: customer | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`customer` COMMENT 'Single source of truth for all customer identity, profiles, households, segments (B2C and B2B), contact information, preferences, and RFM (Recency Frequency Monetary) analytics. Manages customer lifecycle, NPS scores, CLTV (Customer Lifetime Value), CAC (Customer Acquisition Cost), consent/privacy preferences, and omnichannel interaction history. Supports personalized clienteling and customer recognition across POS, e-commerce, and mobile.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique identifier for the customer profile. Primary key for the golden customer record in Informatica MDM.',
    `location_id` BIGINT COMMENT 'Identifier of the customers preferred or most frequently visited store location, used for localized assortment and clienteling.',
    `acquisition_channel` STRING COMMENT 'The channel through which the customer was originally acquired, used for CAC (Customer Acquisition Cost) analysis and channel effectiveness measurement.. Valid values are `store|ecommerce|mobile_app|social_media|referral|partner`',
    `acquisition_date` DATE COMMENT 'Date when the customer first engaged with the business, marking the start of the customer lifecycle.',
    `cac_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to acquire this customer, including marketing spend, promotional discounts, and channel costs. Used for CLTV (Customer Lifetime Value) to CAC ratio analysis.',
    `ccpa_opt_out_date` TIMESTAMP COMMENT 'Timestamp when CCPA opt-out request was processed, required for compliance audit trails.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted out of personal data sale under CCPA regulations.',
    `cltv_score` DECIMAL(18,2) COMMENT 'Predicted total revenue value this customer will generate over their entire relationship with the business, calculated using RFM (Recency Frequency Monetary) models and predictive analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer profile record was first created in the master data management system.',
    `customer_type` STRING COMMENT 'Classification of customer as individual consumer (B2C) or corporate buyer (B2B), including special categories such as employee or VIP.. Valid values are `individual|corporate|employee|vip|wholesale`',
    `date_of_birth` DATE COMMENT 'Date of birth of the customer, used for age verification, lifecycle marketing, and personalized birthday promotions.',
    `email_address` STRING COMMENT 'Primary email address for customer communication across all channels including e-commerce, loyalty programs, and promotional campaigns.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_in_flag` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive promotional emails and newsletters.',
    `employee_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer is an employee eligible for employee discount programs.',
    `first_name` STRING COMMENT 'Legal first name or given name of the customer as recorded in the master data management system.',
    `full_name` STRING COMMENT 'Complete legal name of the customer, typically concatenated from first, middle, and last name components.',
    `gdpr_consent_date` TIMESTAMP COMMENT 'Timestamp when GDPR consent was granted by the customer, required for compliance audit trails.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has provided explicit consent for data processing under GDPR requirements.',
    `gender` STRING COMMENT 'Self-identified gender of the customer, used for personalized merchandising and assortment planning.. Valid values are `male|female|non_binary|prefer_not_to_say|other|unknown`',
    `last_interaction_date` DATE COMMENT 'Date of the customers most recent interaction with the business across any touchpoint including POS, e-commerce, mobile app, or customer service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any attribute in the customer profile record.',
    `last_name` STRING COMMENT 'Legal last name or family name of the customer as recorded in the master data management system.',
    `last_purchase_date` DATE COMMENT 'Date of the customers most recent purchase transaction across all channels, used for recency analysis in RFM (Recency Frequency Monetary) segmentation.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the customer lifecycle journey, used for targeted marketing campaigns and retention strategies. [ENUM-REF-CANDIDATE: prospect|new|active|at_risk|dormant|churned|reactivated — 7 candidates stripped; promote to reference product]',
    `loyalty_tier` STRING COMMENT 'Current tier level in the loyalty program, determining benefits, discounts, and personalized services.. Valid values are `bronze|silver|gold|platinum|diamond`',
    `marketing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has consented to receive marketing communications including email, SMS, and direct mail.',
    `mdm_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-100) from Informatica MDM indicating the quality and reliability of the golden record match and data completeness.',
    `mdm_last_match_date` TIMESTAMP COMMENT 'Timestamp of the last MDM matching and survivorship process execution that updated this golden record.',
    `mdm_source_system` STRING COMMENT 'Name of the primary source system that contributed the authoritative data for this golden record (e.g., SAP CAR, Salesforce Commerce Cloud, POS).',
    `middle_name` STRING COMMENT 'Middle name or initial of the customer. Nullable field for customers without a middle name.',
    `mobile_number` STRING COMMENT 'Mobile phone number used for SMS notifications, mobile app authentication, and last-mile delivery coordination.',
    `nationality` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the customers nationality or citizenship.. Valid values are `^[A-Z]{3}$`',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score indicating customer satisfaction and likelihood to recommend, scored from -100 to 100.',
    `phone_number` STRING COMMENT 'Primary contact phone number for customer service, order notifications, and BOPIS (Buy Online Pick Up In Store) communications.',
    `preferred_contact_method` STRING COMMENT 'Customers preferred method for receiving communications and notifications from the business.. Valid values are `email|phone|sms|mail|none`',
    `preferred_language` STRING COMMENT 'ISO 639-2 three-letter language code representing the customers preferred language for communication and marketing materials.. Valid values are `^[A-Z]{3}$`',
    `profile_status` STRING COMMENT 'Current operational status of the customer profile, controlling access to services and transactions across all channels.. Valid values are `active|inactive|suspended|blocked|closed`',
    `sms_opt_in_flag` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive promotional SMS messages and mobile notifications.',
    `vip_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer is designated as a VIP for special clienteling services and exclusive offers.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Golden record for every customer (B2C and B2B) served by Retail. Stores core identity attributes sourced from Informatica MDM including full legal name, date of birth, gender, preferred language, nationality, customer type (individual/corporate), acquisition channel, CAC, CLTV score, NPS score, lifecycle stage, privacy consent flags (GDPR/CCPA), and golden-record confidence score. This is the single authoritative master entity for all customer identity data across POS, e-commerce, and mobile channels.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the account. Primary key.',
    `buyer_id` BIGINT COMMENT 'Foreign key linking to merchandising.buyer. Business justification: In B2B retail, customer accounts are assigned a dedicated merchandising buyer who manages product selection and vendor negotiations on their behalf. This account-level buyer assignment drives B2B acco',
    `address_id` BIGINT COMMENT 'Reference to the default billing address for this account. Used for invoicing, credit checks, and payment processing. Null if no billing address on file.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retail B2B and employee customer accounts are mapped to cost centers for internal charge-back, departmental billing, and cost allocation reporting. Corporate account management and employee discount p',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: B2B account default storefront assignment: corporate accounts are routed to dedicated storefronts (procurement portals, wholesale channels). Retail B2B operations use account-storefront assignment for',
    `location_id` BIGINT COMMENT 'Reference to the customers preferred or home store location for in-store pickup, returns, and personalized store-based services. Null if no preference set.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: B2B and corporate accounts require contract-specific pricing (volume discounts, negotiated rates, special terms). Account managers assign custom price lists during contract setup. Essential for wholes',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: B2B account price zone assignment: retail accounts (especially wholesale/B2B) are assigned to geographic price zones determining their applicable pricing tier. This drives account-level pricing execut',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile who owns this account. One customer may have multiple accounts (e.g., personal and business).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Retail customer accounts (especially B2B/corporate) are assigned to profit centers for channel-level P&L reporting and revenue attribution. Finance requires account-to-profit-center mapping for segmen',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: Account enrollment management: retail accounts must reference the specific loyalty program they are enrolled in for benefit application, billing, and tier evaluation. The existing loyalty_program_enr',
    `shipping_address_id` BIGINT COMMENT 'Reference to the default shipping address for this account. Used for order fulfillment and delivery. Null if no default shipping address set.',
    `account_number` STRING COMMENT 'Externally-visible unique account number used for customer communication, statements, and customer service lookup. Distinct from internal account_id.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle state of the account. Active accounts can transact; suspended accounts are temporarily blocked; closed accounts are permanently terminated; pending_activation awaits customer verification; frozen accounts are under investigation; dormant accounts have no recent activity.. Valid values are `active|suspended|closed|pending_activation|frozen|dormant`',
    `account_tier` STRING COMMENT 'Service tier or membership level of the account, determining benefits, discounts, and service priority. Standard is base tier; premium, VIP, and platinum offer escalating benefits.. Valid values are `standard|premium|vip|platinum`',
    `account_type` STRING COMMENT 'Classification of the account indicating the nature of the commercial relationship: personal (B2C consumer), business (B2B corporate), employee (staff discount account), or wholesale (bulk buyer).. Valid values are `personal|business|employee|wholesale`',
    `b2b_pricing_flag` BOOLEAN COMMENT 'Indicates whether this account receives B2B contract pricing instead of standard retail pricing. True for wholesale and corporate accounts; false for consumer accounts.',
    `close_date` DATE COMMENT 'Date when the account was permanently closed. Null for active accounts. Used for churn analysis and account lifecycle reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount (in base currency) extended to this account for deferred payment or credit purchases. Null for cash-only accounts. Used for credit management and risk assessment.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accounts base currency (e.g., USD, EUR, GBP). All monetary transactions and balances for this account are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the account holder has consented to sharing their data with third-party partners for analytics, advertising, or personalization. True if consented; false otherwise. Required for GDPR and CCPA compliance.',
    `employee_discount_eligible` BOOLEAN COMMENT 'Indicates whether this account is eligible for employee discount pricing. True for employee accounts and authorized family members; false otherwise.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent purchase or transaction on this account. Used for recency analysis, dormancy detection, and customer lifecycle segmentation (RFM analysis).',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the account holder has consented to receive marketing communications (email, SMS, direct mail). True if opted in; false if opted out. Required for GDPR and CCPA compliance.',
    `marketing_opt_in_date` TIMESTAMP COMMENT 'Timestamp when the account holder provided marketing consent. Null if never opted in. Used for consent audit trail and compliance reporting.',
    `marketing_opt_out_date` TIMESTAMP COMMENT 'Timestamp when the account holder withdrew marketing consent. Null if currently opted in or never opted in. Used for consent audit trail and compliance reporting.',
    `notes` STRING COMMENT 'Free-text field for internal notes about the account (e.g., special handling instructions, VIP preferences, service history, escalation notes). Used by customer service and account management teams.',
    `open_date` DATE COMMENT 'Date when the account was first opened and activated. Used for account age calculations, tenure-based benefits, and lifecycle analytics.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance owed by the account holder (in base currency). Positive values indicate amounts owed to Retail; negative values indicate credit balances. Used for accounts receivable and collections.',
    `preferred_channel` STRING COMMENT 'Customers preferred interaction channel for shopping and service. Used for omnichannel routing, personalized marketing, and channel-specific offers.. Valid values are `in_store|online|mobile_app|call_center`',
    `source_system` STRING COMMENT 'Name of the operational system that is the authoritative source for this account record (e.g., Salesforce Commerce Cloud, Oracle Retail, Informatica MDM). Used for data lineage and master data management.',
    `suspension_date` DATE COMMENT 'Date when the account was most recently suspended. Null if never suspended or currently active. Used for compliance and risk management reporting.',
    `suspension_reason` STRING COMMENT 'Free-text explanation of why the account was suspended (e.g., payment default, fraud investigation, customer request, policy violation). Null if never suspended.',
    `tax_exempt_certificate_number` STRING COMMENT 'Government-issued tax exemption certificate number for tax-exempt accounts. Null for non-exempt accounts. Required for audit and compliance verification.',
    `tax_exempt_expiry_date` DATE COMMENT 'Expiration date of the tax exemption certificate. Null for non-exempt accounts or perpetual exemptions. Used for compliance monitoring and renewal reminders.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this account is exempt from sales tax (e.g., non-profit organizations, government entities, resellers with valid tax exemption certificates). True if exempt; false otherwise.',
    `total_lifetime_orders` STRING COMMENT 'Cumulative count of all orders placed by this account since inception. Used for frequency analysis in RFM segmentation and customer value scoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this account record was last modified. Used for audit trail, change tracking, and data synchronization.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Commercial relationship record between a customer and Retail, distinct from profile (identity). Tracks account number, status (active/suspended/closed), open date, tier (standard/premium/VIP), credit limit, preferred store, preferred channel (in-store/online/mobile), default payment method reference, and account-level flags (employee discount eligibility, tax-exempt status, B2B pricing flag). One profile may have multiple accounts (e.g., personal + business). Supports account-level reporting, credit management, and omnichannel preference routing.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact method record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: The contact table description explicitly states it stores contact points for a customer profile OR corporate account. Currently contact only has profile_id, leaving B2B corporate account contacts un',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile or corporate account that owns this contact method. Links to the customer master record in Informatica MDM.',
    `bounce_count` STRING COMMENT 'The cumulative number of times communication attempts via this contact method have bounced or failed. Used to trigger contact validation workflows and suppress invalid addresses.',
    `consent_source` STRING COMMENT 'The channel or touchpoint where the customer provided consent for this contact method (e.g., web registration, mobile app, POS, call center, in-store signup). Supports consent audit trails. [ENUM-REF-CANDIDATE: web|mobile_app|pos|call_center|email|in_store|third_party — 7 candidates stripped; promote to reference product]',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact method. Active indicates usable for communication; bounced/invalid indicates delivery failure; suppressed indicates customer request or compliance block; pending_verification indicates awaiting confirmation.. Valid values are `active|inactive|bounced|invalid|suppressed|pending_verification`',
    `contact_type` STRING COMMENT 'The type or category of contact method (e.g., primary email, mobile phone, work phone, WhatsApp, SMS, fax). Determines the channel and priority for omnichannel outreach. [ENUM-REF-CANDIDATE: primary_email|secondary_email|mobile|home_phone|work_phone|whatsapp|sms|fax — 8 candidates stripped; promote to reference product]',
    `contact_value` DECIMAL(18,2) COMMENT 'The actual contact point value: email address, phone number, or social media handle. This is the primary data element used for customer communication and CRM campaigns via Salesforce Service Cloud. Classified as restricted PII as it may contain email, phone, or other personal identifiers.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country associated with this contact method (e.g., USA, GBR, CAN). Used for regional compliance and localization of communications.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact method record was first created in the system. Supports audit trails and data lineage.',
    `effective_end_date` DATE COMMENT 'The date when this contact method ceased to be active or valid. Nullable for currently active contact methods. Supports temporal tracking and historical analysis.',
    `effective_start_date` DATE COMMENT 'The date from which this contact method became active and valid for customer communication. Supports temporal tracking and historical analysis.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary contact method for the customer. Used to prioritize communication channels in omnichannel campaigns and clienteling.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the contact method has been verified (e.g., email verification link clicked, phone number confirmed via OTP). Ensures data quality for marketing and transactional communications.',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the customers preferred language for communications via this contact method (e.g., en, es, fr). Supports personalized omnichannel outreach.. Valid values are `^[a-z]{2}$`',
    `last_bounce_date` DATE COMMENT 'The date of the most recent bounce or delivery failure for this contact method. Nullable if no bounces have occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact method record was last updated. Supports change tracking and audit trails.',
    `last_used_date` DATE COMMENT 'The date when this contact method was last successfully used for customer communication (email sent, SMS delivered, call completed). Helps identify stale or inactive contact points.',
    `opt_in_date` DATE COMMENT 'The date when the customer provided consent for communication via this contact method. Required for audit trails under GDPR and CCPA.',
    `opt_in_marketing` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive marketing communications via this contact method. Critical for GDPR and CCPA consent enforcement.',
    `opt_in_transactional` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive transactional communications (order confirmations, shipping updates, receipts) via this contact method.',
    `opt_out_date` DATE COMMENT 'The date when the customer withdrew consent or opted out of communications via this contact method. Nullable if customer has not opted out.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority order of this contact method relative to other contact methods for the same customer. Lower numbers indicate higher priority. Used for fallback logic in omnichannel campaigns.',
    `source_system` STRING COMMENT 'The operational system or platform that originally captured this contact method (e.g., Salesforce Service Cloud, SAP CAR, Salesforce Commerce Cloud, POS, Informatica MDM). Supports data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier for this contact method in the source system. Enables traceability and cross-system reconciliation.',
    `verification_date` DATE COMMENT 'The date when the contact method was last verified by the customer. Used to track data freshness and trigger re-verification workflows.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Stores all contact points for a customer profile or corporate account including email addresses, phone numbers, and social handles. Each row represents a single contact method with type (primary email, mobile, work phone, WhatsApp), verification status, opt-in/opt-out flags per channel, verification date, and source system. Supports omnichannel outreach, CRM campaigns via Salesforce Service Cloud, and GDPR/CCPA consent enforcement at the contact-method level.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'Unique identifier for the address record. Primary key.',
    `profile_id` BIGINT COMMENT 'Reference to the customer or corporate account associated with this address.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active addresses are available for use in orders and shipments.. Valid values are `active|inactive|archived|pending_verification`',
    `address_type` STRING COMMENT 'Classification of the address purpose: billing, shipping, store pickup (BOPIS/ROPIS), home, work, or mailing.. Valid values are `billing|shipping|home|work|store_pickup|mailing`',
    `city` STRING COMMENT 'City or municipality name for the address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, GBR) identifying the country of the address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the system.',
    `delivery_instructions` STRING COMMENT 'Special delivery instructions provided by the customer (e.g., gate code, leave at door, ring bell).',
    `delivery_point_barcode` STRING COMMENT 'USPS Delivery Point Barcode (DPBC) or equivalent postal barcode for automated mail sorting and delivery.',
    `effective_from_date` DATE COMMENT 'Date from which this address becomes active and valid for use in transactions.',
    `effective_to_date` DATE COMMENT 'Date until which this address remains active. Null indicates the address is currently active with no end date.',
    `is_default_billing` BOOLEAN COMMENT 'Flag indicating whether this address is the default billing address for the customer.',
    `is_default_shipping` BOOLEAN COMMENT 'Flag indicating whether this address is the default shipping destination for the customer.',
    `last_used_date` DATE COMMENT 'Date when this address was last used in a transaction (order, shipment, or billing event).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for geolocation and last-mile delivery optimization.',
    `line_1` STRING COMMENT 'Primary street address line including street number, street name, and unit/apartment number.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as building name, floor, suite, or department.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for geolocation and last-mile delivery optimization.',
    `military_address_flag` BOOLEAN COMMENT 'Indicates whether the address is a military address (APO/FPO/DPO). Requires special handling for international military mail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was last modified or updated.',
    `nickname` STRING COMMENT 'Customer-provided friendly name for the address (e.g., Home, Office, Moms House) for easy identification.',
    `po_box_flag` BOOLEAN COMMENT 'Indicates whether the address is a PO Box. Some carriers and products cannot deliver to PO Boxes.',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for the address. Used for delivery routing and tax jurisdiction determination.',
    `residential_flag` BOOLEAN COMMENT 'Indicates whether the address is a residential location (true) or commercial/business location (false). Impacts shipping rates and delivery windows.',
    `standardization_flag` BOOLEAN COMMENT 'Indicates whether the address has been standardized to postal service formatting rules (USPS Publication 28, etc.).',
    `state_province` STRING COMMENT 'State, province, or region code or name. For US addresses, use two-letter state abbreviation (e.g., CA, NY).',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier derived from the address, used to determine applicable sales tax rates and rules.',
    `validation_status` STRING COMMENT 'Status of address validation against postal service standards (USPS, Canada Post, etc.). Validated addresses reduce delivery failures.. Valid values are `validated|unvalidated|invalid|pending`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the address was last verified against postal service databases or address validation services.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing addresses associated with a customer profile or corporate account. Stores address type (billing, shipping, store pickup, home, work), full address lines, city, state/province, postal code, country, geocoordinates (lat/lng), address validation status, USPS/postal standardization flag, and default shipping flag. Critical for last-mile delivery, BOPIS/ROPIS fulfillment, and tax jurisdiction determination.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Primary key for segment',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-affinity segmentation is a core retail CRM process — segments like premium brand loyalists or private label shoppers are defined by brand preference. This FK enables brand-targeted campaign ',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.format. Business justification: Retail marketers define customer segments by the store format customers primarily shop (hypermarket vs. discount outlet vs. e-commerce). Format-based segmentation drives targeted assortment, pricing s',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Customer segments defined by category affinity ("Premium Electronics Buyers", "Organic Enthusiasts") for category-targeted campaigns and segment-aware assortment planning. Replaces denormalized prefer',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Customer segments are often defined by product category affinity. Existing preferred_product_category text field should be proper FK to item_hierarchy for segment-based assortment planning, targeted',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Customer segments drive targeted pricing strategies (loyalty tier pricing, VIP exclusive pricing, student/senior discounts). Merchandising teams create segment-specific price lists to optimize convers',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Segment-level price zone targeting: customer segments in retail are scoped to geographic price zones for regional promotional planning and targeted pricing campaigns. Segment already has geographic_sc',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Retail customer segments (loyalty tiers, B2B segments) are aligned to profit centers for segment-level P&L and marketing ROI reporting. Finance and marketing jointly track revenue and margin by custom',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Retail segments are built around seasonal buying behavior (e.g., Holiday Shoppers, Back-to-School Buyers). Linking segment to season enables seasonal campaign targeting, assortment alignment, and ',
    `auto_refresh_flag` BOOLEAN COMMENT 'Indicates whether customer membership in this segment is automatically recalculated on a scheduled basis (True) or manually managed (False). True for dynamic segments (e.g., RFM tiers recalculated nightly); False for static segments (e.g., one-time campaign lists).',
    `average_aov` DECIMAL(18,2) COMMENT 'Mean Average Order Value for customers in this segment over the measurement period. Key metric for pricing strategy, promotion design, and basket optimization. Expressed in base currency (USD).',
    `average_cltv` DECIMAL(18,2) COMMENT 'Mean Customer Lifetime Value across all customers currently assigned to this segment. Used for segment valuation, investment prioritization, and ROI forecasting. Expressed in base currency (USD).',
    `average_purchase_frequency` DECIMAL(18,2) COMMENT 'Mean number of transactions per customer in this segment over the measurement period (typically 12 months). Used for replenishment forecasting, loyalty program design, and churn prediction.',
    `b2b_b2c_indicator` STRING COMMENT 'Indicates whether this segment applies to B2B customers (business accounts, wholesale, corporate), B2C customers (individual consumers), or both. Drives differentiated engagement strategies, pricing models, and service levels.. Valid values are `b2b|b2c|both`',
    `ccpa_opt_out_honored_flag` BOOLEAN COMMENT 'Indicates whether this segment respects CCPA Do Not Sell My Personal Information opt-out requests (True) or is exempt (False, e.g., service-related communications). Ensures compliance for California residents.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Aggregate churn risk score for this segment, ranging from 0.00 (no risk) to 100.00 (high risk). Calculated from recency, frequency, and engagement metrics. Drives retention campaign prioritization and at-risk customer interventions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this segment definition was first created in the system. Audit trail for segment lifecycle tracking and governance.',
    `discount_sensitivity` STRING COMMENT 'Behavioral classification of segments responsiveness to promotional pricing. High: primarily purchases on promotion (Hi-Lo shoppers). Medium: balanced full-price and promotional purchases. Low: primarily full-price purchases (EDLP preference or premium segment).. Valid values are `high|medium|low`',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or superseded. Null for currently active segments. Enables segment lifecycle management and historical reporting.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became active and available for customer assignment. Supports temporal segmentation strategies and historical analysis.',
    `gdpr_consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer consent is required under GDPR for marketing communications to this segment (True) or whether legitimate interest or other legal basis applies (False). Ensures regulatory compliance for EU customers.',
    `geographic_scope` STRING COMMENT 'Geographic boundary or region to which this segment applies (e.g., USA, Northeast Region, Urban Markets, Global). Supports localized segmentation strategies and regional campaign targeting. Use ISO 3166-1 alpha-3 country codes where applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this segment definition was last updated (criteria, name, status, or any other attribute). Supports change tracking and audit compliance.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when segment membership was last recalculated and customer assignments were updated. Critical for data freshness validation and SLA monitoring.',
    `max_rfm_score` STRING COMMENT 'Maximum RFM composite score for customer assignment to this segment (if segment_type is rfm_tier). Defines the upper bound of the RFM tier. Null for non-RFM segments.',
    `membership_count` BIGINT COMMENT 'Current count of customers assigned to this segment. Updated periodically based on auto-refresh schedule. Used for segment sizing, campaign planning, and capacity forecasting.',
    `min_rfm_score` STRING COMMENT 'Minimum RFM composite score required for customer assignment to this segment (if segment_type is rfm_tier). RFM scores typically range from 3 (lowest: 1-1-1) to 15 (highest: 5-5-5). Null for non-RFM segments.',
    `nps_score` DECIMAL(18,2) COMMENT 'Average Net Promoter Score for customers in this segment, ranging from -100.00 (all detractors) to +100.00 (all promoters). Measures customer satisfaction, loyalty, and likelihood to recommend. Used for segment health monitoring and experience improvement prioritization.',
    `owning_business_unit` STRING COMMENT 'Name of the business unit or department responsible for defining, maintaining, and governing this segment (e.g., Marketing Analytics, Customer Insights, Loyalty Program Management). Establishes accountability for segment quality and usage.',
    `priority_tier` STRING COMMENT 'Service and engagement priority level assigned to this segment. Platinum: highest CLTV, white-glove service. Gold: high-value, priority support. Silver: mid-value, standard service. Bronze: emerging value. Standard: baseline service. Drives clienteling strategies and resource allocation.. Valid values are `platinum|gold|silver|bronze|standard`',
    `qualification_criteria` STRING COMMENT 'Summary of the business rules and thresholds used to assign customers to this segment (e.g., Purchased in last 30 days AND total spend > $5000 in last 12 months, RFM Score >= 9, Age 25-34 AND lives in urban area). Human-readable representation of the segmentation logic.',
    `refresh_frequency` STRING COMMENT 'Cadence at which segment membership is recalculated for auto-refresh segments. Daily: high-velocity behavioral segments. Weekly: standard RFM tiers. Monthly: demographic or lifecycle segments. Quarterly: strategic value tiers. On-Demand: manual trigger only.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `segment_description` STRING COMMENT 'Detailed narrative describing the segments defining characteristics, business rationale, and strategic purpose. Includes target customer profile, expected behaviors, and recommended engagement strategies.',
    `segment_name` STRING COMMENT 'Human-readable name of the segment (e.g., VIP Gold Tier, Lapsed Customers - 90 Days, High-Value B2B Accounts). Used in reporting, dashboards, and customer-facing communications.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition. Active: in production use for customer assignment and campaigns. Inactive: temporarily suspended, no new assignments. Archived: retired, historical reference only. Draft: under development, not yet released.. Valid values are `active|inactive|archived|draft`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology applied. RFM Tier: Recency, Frequency, Monetary analysis. Demographic: age, gender, income. Behavioral: purchase patterns, product affinity. Psychographic: lifestyle, values. Lifecycle Stage: new, active, at-risk, lapsed. Geographic: region, climate zone. Channel Preference: omnichannel, e-commerce-only, store-only. Value Tier: CLTV-based stratification. [ENUM-REF-CANDIDATE: rfm_tier|demographic|behavioral|psychographic|lifecycle_stage|geographic|channel_preference|value_tier — 8 candidates stripped; promote to reference product]',
    `target_marketing_channel` STRING COMMENT 'Primary communication channel recommended for engaging customers in this segment. Aligns segment strategy with channel preference and regulatory consent. All Channels: omnichannel engagement strategy. [ENUM-REF-CANDIDATE: email|sms|push_notification|direct_mail|in_store|call_center|social_media|all_channels — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Defines market segmentation classifications applied to customer profiles for targeted marketing, personalized pricing, and assortment decisions. Stores segment code, segment name, segment type (RFM tier, demographic, behavioral, psychographic, lifecycle stage, geographic, channel preference, value tier), segment description, qualification criteria summary, membership count, effective date range, auto-refresh flag, owning business unit, and profile-to-segment assignments with effective dates and expiry dates. Enables Retail to execute clienteling strategies, personalized promotions, and differentiated service levels across POS and e-commerce channels.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique identifier for the customer preference record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Customers express merchandise category preferences ("interested in electronics", "loves organic food") for personalized marketing, homepage customization, and category affinity scoring. Retail standar',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Category and department preferences enable targeted marketing campaigns and personalized navigation. Retail marketing segments customers by preferred categories (e.g., Beauty shoppers, Electronics ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Retail CRM captures explicit brand preferences for personalization, brand-specific email campaigns, and loyalty program brand partnerships. Customers opt into brand communications (e.g., Nike, store p',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Customer product preferences at SKU level (favorite items, repeat purchases) drive personalization engines, targeted promotions, and replenishment recommendations. Retail personalization requires link',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who holds this preference. Links to the customer master record.',
    `superseded_by_preference_id` BIGINT COMMENT 'Identifier of the preference record that supersedes or replaces this preference. Nullable if this is the current active preference. Supports preference lineage and history tracking.',
    `application_count` STRING COMMENT 'The cumulative number of times this preference has been applied or used in customer interactions, recommendations, or personalization events. Supports preference effectiveness measurement and RFM (Recency Frequency Monetary) analytics.',
    `channel_captured` STRING COMMENT 'The channel or touchpoint through which the preference was originally captured (e.g., web, mobile app, POS (Point of Sale), call center, in-store kiosk, email, survey, third-party). Supports omnichannel attribution and data quality assessment. [ENUM-REF-CANDIDATE: web|mobile_app|pos|call_center|in_store_kiosk|email|survey|third_party — 8 candidates stripped; promote to reference product]',
    `confidence_level` DECIMAL(18,2) COMMENT 'Numeric confidence score (0.00 to 100.00) indicating the reliability or certainty of the preference, especially for inferred or behavioral preferences. Higher values indicate stronger confidence. Self-declared preferences typically have 100.00 confidence.',
    `consent_given` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has provided explicit consent for this preference to be used for personalization, marketing, or data processing. True indicates consent granted; False indicates consent not granted or withdrawn.',
    `consent_timestamp` TIMESTAMP COMMENT 'The timestamp when the customer provided or withdrew consent for this preference. Required for GDPR and CCPA compliance audit trails. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this preference record was first created in the system. Supports audit trail and lifecycle analysis. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_source_system` STRING COMMENT 'The name or identifier of the source system or application that originally captured or provided this preference data (e.g., Salesforce Commerce Cloud, SAP CAR, Informatica MDM, Mobile App v2.3). Supports data lineage and troubleshooting.',
    `effective_end_date` DATE COMMENT 'The date on which this preference expires or is no longer valid. Nullable for open-ended preferences. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date from which this preference becomes active and should be applied in personalization and customer interactions. Format: yyyy-MM-dd.',
    `geographic_scope` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the geographic region or country to which this preference applies (e.g., USA, CAN, MEX, GBR). Supports region-specific personalization and compliance with local regulations.. Valid values are `^[A-Z]{3}$`',
    `language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the preference was captured or should be displayed (e.g., ENG for English, SPA for Spanish, FRA for French). Supports multilingual customer experience and localization.. Valid values are `^[A-Z]{3}$`',
    `last_applied_timestamp` TIMESTAMP COMMENT 'The timestamp when this preference was last actively used or applied in a customer interaction, personalization event, or recommendation. Supports preference relevance scoring and decay analysis. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this preference record was last modified or refreshed. Used for data freshness tracking and synchronization with downstream systems. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the preference. Used by customer service representatives for clienteling and personalized service. May contain customer service agent observations or customer-provided explanations.',
    `opt_out_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted out of having this preference used for personalization or marketing. True indicates customer has opted out; False indicates customer has not opted out. Supports GDPR right to object and CCPA opt-out requirements.',
    `opt_out_timestamp` TIMESTAMP COMMENT 'The timestamp when the customer opted out of this preference. Required for compliance audit trails. Nullable if customer has not opted out. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `preference_category` STRING COMMENT 'The category or type of preference being captured (e.g., communication channel, product category affinity, dietary restriction, brand preference, store preference, language, notification frequency, privacy consent, marketing opt-in, delivery preference, payment method preference, shopping time preference). Supports segmentation and personalization across all Retail channels. [ENUM-REF-CANDIDATE: communication_channel|product_category_affinity|dietary_restriction|brand_preference|store_preference|language|notification_frequency|privacy_consent|marketing_opt_in|delivery_preference|payment_method_preference|shopping_time_preference — 12 candidates stripped; promote to reference product]',
    `preference_description` STRING COMMENT 'Free-text description or additional context about the preference, especially useful for complex or custom preferences that require explanation. Supports customer service and clienteling use cases.',
    `preference_source` STRING COMMENT 'The origin of the preference data. Self-declared indicates customer explicitly provided the preference; behavioral indicates derived from purchase or browsing history; inferred indicates algorithmic prediction; third-party indicates sourced from external data provider; imported indicates migrated from legacy system.. Valid values are `self_declared|behavioral|inferred|third_party|imported`',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference. Active indicates currently in use; inactive indicates temporarily disabled; expired indicates no longer valid due to time constraints; superseded indicates replaced by a newer preference.. Valid values are `active|inactive|expired|superseded`',
    `preference_value` DECIMAL(18,2) COMMENT 'The specific value or selection for the preference category (e.g., email, organic produce, Nike, Store #1234, Spanish, weekly). Free-text or structured value depending on category.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the relative priority or importance of this preference when multiple preferences exist for the same customer and category. Lower numbers indicate higher priority (e.g., 1 is highest priority).',
    `subcategory` STRING COMMENT 'Optional granular subcategory within the preference category for more detailed segmentation (e.g., within product_category_affinity, subcategory could be organic_produce, gluten_free_bakery, athletic_footwear). Supports fine-grained personalization.',
    `verification_status` STRING COMMENT 'Indicates whether the preference has been verified or validated through customer confirmation, behavioral validation, or data quality checks. Verified indicates confirmed accuracy; unverified indicates not yet validated; pending_verification indicates in validation process; verification_failed indicates validation attempt unsuccessful.. Valid values are `verified|unverified|pending_verification|verification_failed`',
    `verification_timestamp` TIMESTAMP COMMENT 'The timestamp when the preference verification status was last updated or when verification was completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `version` STRING COMMENT 'Version number of this preference record, incremented each time the preference is updated. Supports preference history tracking and change management. Initial version is 1.',
    `weight` DECIMAL(18,2) COMMENT 'Numeric weight (0.00 to 100.00) assigned to this preference for use in recommendation algorithms and personalization scoring. Higher weights indicate stronger influence on recommendations. Used by AI/ML models for CLTV (Customer Lifetime Value) and next-best-action predictions.',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Captures customer-declared and inferred preferences for personalization across all Retail channels. Stores preference category (communication channel, product category affinity, dietary restriction, brand preference, store preference, language, notification frequency), preference value, preference source (self-declared/behavioral/inferred), confidence level, and last updated timestamp. Feeds Salesforce Commerce Cloud personalization engine and in-store clienteling tools.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`consent` (
    `consent_id` BIGINT COMMENT 'Primary key for consent',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Consent is the authoritative GDPR/CCPA audit trail. For B2B corporate accounts, consent decisions (data sharing, marketing opt-in) must be tracked at the account level in addition to the individual pr',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: GDPR/CCPA brand-specific marketing consent is a real retail compliance requirement — customers consent to communications from specific brands (e.g., I consent to receive Nike promotions). The consen',
    `profile_id` BIGINT COMMENT 'Reference to the customer who provided or withdrew consent. Links to the customer master record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: GDPR/CCPA compliance: in multi-program retail environments, consent records must be scoped to the specific loyalty program whose data-sharing terms the customer accepted. Regulators and auditors requi',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: GDPR/CCPA compliance requires tracking which promotional campaign triggered consent collection. Retailers must demonstrate consent was obtained for specific marketing campaigns. This FK enables campai',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: GDPR/CCPA compliance in retail requires tracking which specific vendor receives customer data under a consent record. The existing plain-text third_party_recipient column is a denormalized vendor re',
    `collection_channel` STRING COMMENT 'The channel through which the consent was collected: web (e-commerce site), mobile app, POS (point of sale terminal), paper form (in-store signup), call center, email campaign, or in-store kiosk. [ENUM-REF-CANDIDATE: web|mobile_app|pos|paper_form|call_center|email|in_store_kiosk — 7 candidates stripped; promote to reference product]',
    `consent_method` STRING COMMENT 'The method by which consent was obtained: explicit opt-in (customer actively checked box), implicit opt-in (inferred from action), pre-checked box (legacy, non-compliant), verbal (phone), or written signature (paper form).. Valid values are `explicit_opt_in|implicit_opt_in|pre_checked_box|verbal|written_signature`',
    `consent_scope` STRING COMMENT 'Detailed description of the scope and purpose of the consent. Explains what data will be used for and how, ensuring transparency and specificity required by privacy regulations.',
    `consent_status` STRING COMMENT 'Current status of the consent: granted (customer opted in), withdrawn (customer opted out), pending (awaiting customer action), expired (consent period ended), or revoked (administratively cancelled).. Valid values are `granted|withdrawn|pending|expired|revoked`',
    `consent_timestamp` TIMESTAMP COMMENT 'The exact date and time when the consent decision was captured. Critical for audit trails and regulatory proof of consent timing.',
    `consent_type` STRING COMMENT 'The specific type of consent being recorded: marketing email, SMS, push notifications, data sharing with partners, profiling for personalization, cookie tracking, or third-party data sharing. [ENUM-REF-CANDIDATE: marketing_email|marketing_sms|marketing_push|data_sharing|profiling|cookies|third_party_sharing — 7 candidates stripped; promote to reference product]',
    `data_subject_rights_notice` BOOLEAN COMMENT 'Boolean flag indicating whether the customer was informed of their data subject rights (right to access, rectification, erasure, restriction, portability, objection) at the time of consent collection.',
    `double_opt_in_confirmed` BOOLEAN COMMENT 'Boolean flag indicating whether the customer confirmed their consent via a double opt-in process (e.g., email confirmation link). Best practice for email marketing consent.',
    `double_opt_in_timestamp` TIMESTAMP COMMENT 'The date and time when the customer confirmed their consent via double opt-in. Null if double opt-in was not used or not yet confirmed.',
    `expiration_date` DATE COMMENT 'The date on which this consent expires and must be re-obtained. Null if consent does not expire. Used for consent refresh workflows.',
    `granularity` STRING COMMENT 'The level of granularity at which consent was obtained: global (all purposes), channel-specific (email vs SMS), purpose-specific (marketing vs analytics), or brand-specific (for multi-brand retailers).. Valid values are `global|channel_specific|purpose_specific|brand_specific`',
    `ip_address` STRING COMMENT 'The IP address from which the consent was submitted. Used as proof of consent origin for regulatory compliance and fraud detection.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction (country or state code) under which this consent was collected and is governed. Determines applicable privacy regulations (GDPR, CCPA, etc.).',
    `language` STRING COMMENT 'The language in which the consent form was presented to the customer (ISO 639-1 two-letter code, e.g., EN, ES, FR). Required for multi-lingual compliance.',
    `legal_basis` STRING COMMENT 'The legal basis under GDPR for processing this data: consent, contract fulfillment, legal obligation, vital interest, public task, or legitimate interest. Required for GDPR Article 6 compliance.. Valid values are `consent|contract|legal_obligation|vital_interest|public_task|legitimate_interest`',
    `minor_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this consent record pertains to a minor (under age of digital consent in jurisdiction). Triggers additional parental consent requirements under GDPR Article 8 and COPPA.',
    `parental_consent_verified` BOOLEAN COMMENT 'Boolean flag indicating whether parental or guardian consent has been verified for a minor. Required for COPPA and GDPR Article 8 compliance.',
    `privacy_policy_version` STRING COMMENT 'The specific version of the privacy policy document that was in effect and accepted by the customer at the time of consent. Required for regulatory audit trails.',
    `proof_document_url` STRING COMMENT 'URL or storage path to the digitally signed or archived copy of the consent form as presented to the customer. Used for audit and regulatory inspection.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this consent record was first created in the data platform. Immutable. Used for audit trail and data lineage.',
    `record_source_system` STRING COMMENT 'The name or identifier of the source system that originated this consent record (e.g., Salesforce Commerce Cloud, POS system, call center CRM). Used for data lineage and troubleshooting.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured at the time of consent. Provides additional context for consent collection environment.',
    `version` STRING COMMENT 'Version identifier of the consent form or privacy policy that was presented to the customer at the time of consent. Enables tracking of which policy version the customer agreed to.',
    `withdrawal_reason` STRING COMMENT 'Optional free-text reason provided by the customer for withdrawing consent. Used for customer experience analysis and compliance documentation.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'The exact date and time when the customer withdrew their consent. Null if consent has not been withdrawn. Critical for right-to-erasure workflows.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Authoritative audit trail of customer privacy consent decisions required for GDPR and CCPA compliance. Each row captures consent type (marketing email, SMS, data sharing, profiling, cookies), consent status (granted/withdrawn/pending), consent version, collection channel (web/POS/mobile/paper), collection timestamp, IP address at time of consent, the specific privacy policy version accepted, and the profile reference for the consenting customer. Immutable append-only records supporting regulatory reporting, right-to-erasure workflows, and consent proof during audits.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`service_case` (
    `service_case_id` BIGINT COMMENT 'Unique identifier for the customer service case record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Service cases in a retail B2B context are frequently raised by corporate accounts (e.g., bulk order disputes, invoice discrepancies, account-level refund requests). The service_case already has profil',
    `buyer_id` BIGINT COMMENT 'Foreign key linking to merchandising.buyer. Business justification: Complex product quality issues, specification disputes, or vendor-related complaints escalated to merchandise buyers for resolution and vendor coordination. Real escalation path in retail operations f',
    `checkout_id` BIGINT COMMENT 'Foreign key linking to ecommerce.checkout. Business justification: Service cases for checkout failures: CS agents investigating payment-declined errors, double-charge complaints, or abandoned checkout issues need direct linkage to the specific checkout session for ga',
    `compliance_id` BIGINT COMMENT 'Foreign key linking to product.product_compliance. Business justification: Product recall management is a critical retail regulatory process — when a recall is issued, service cases are opened for affected customers. Linking service_case to product_compliance supports recall',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Service cases are initiated through a specific contact channel (e.g., a customer calls a phone number, sends an email, or uses a chat contact). Linking service_case.contact_id → contact.contact_id ide',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Customer service operations (returns, refunds, escalations) incur costs allocated to specific cost centers in retail. Cost center attribution on service cases enables customer service cost reporting, ',
    `coupon_id` BIGINT COMMENT 'Foreign key linking to promotion.coupon. Business justification: Service recovery coupon issuance is a standard retail customer service process — agents issue goodwill coupons to resolve complaints. Linking service_case to the specific coupon issued enables trackin',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Retail service cases are routed to specific store departments for resolution (electronics returns to electronics dept, apparel exchanges to apparel dept). Department-level SLA tracking, case volume re',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Service cases frequently track delivery issues, damaged shipments, missing packages, and late deliveries. Linking case to fulfillment_order enables agents to view fulfillment status, tracking, and exc',
    `header_id` BIGINT COMMENT 'Identifier of the customer order associated with this service case, if the case relates to a specific order transaction.',
    `location_id` BIGINT COMMENT 'Identifier of the retail store location involved in the case, if the issue originated from or relates to a specific store.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_membership. Business justification: Loyalty membership dispute resolution: service cases for points balance disputes, tier status complaints, or enrollment issues must reference the specific loyalty membership involved. The existing red',
    `outbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_shipment. Business justification: Customer service resolution process: agents handling missing/damaged delivery complaints must link the service case to the specific DC outbound shipment to initiate claims, re-shipments, or carrier di',
    `parent_case_service_case_id` BIGINT COMMENT 'Identifier of the parent service case if this case is a child or follow-up case. Supports hierarchical case relationships and tracking of related issues.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to customer.payment_method. Business justification: A significant proportion of retail service cases involve payment-related issues: disputed charges, failed transactions, refund requests, gift card balance disputes, or BNPL payment problems. The servi',
    `price_override_id` BIGINT COMMENT 'Foreign key linking to pricing.price_override. Business justification: Customer service resolution process: CSRs issue price overrides when resolving cases (price matches, goodwill adjustments). Linking service_case to price_override enables case-resolution audit trails,',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who initiated or is associated with this service case. Links to the customer master record.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: Service cases frequently involve loyalty redemption disputes (points not credited, voucher not working, reward not received). CSRs need direct link to redemption record to investigate complaints, proc',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Shipment-level customer service: retail CS agents handling delivery complaints (damaged goods, missing packages, wrong delivery) must reference the specific shipment to initiate carrier claims and ret',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Service cases for returns, defects, warranty claims reference specific products. Quality tracking, recall management, and vendor chargebacks require linking cases to SKUs. Existing product_sku text ',
    `vendor_contact_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contact. Business justification: In retail customer service operations, when a case involves a defective or disputed vendor product, agents must engage a specific vendor representative. Linking service_case to vendor_contact enables ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: When customer service cases involve product defects, quality issues, or recalls, retailers must track the originating vendor to manage RTV requests, chargebacks, vendor scorecards, and supplier accoun',
    `assigned_team` STRING COMMENT 'Name or code of the service team or queue to which this case is assigned for resolution.',
    `case_number` STRING COMMENT 'Externally visible unique case number assigned by the service system for customer reference and tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `case_owner_type` STRING COMMENT 'Type of owner currently assigned to the case: individual agent, team queue, or automated system. Used for workload distribution analytics.. Valid values are `agent|queue|automated_system`',
    `case_status` STRING COMMENT 'Current lifecycle status of the service case. Tracks progression from new through resolution to closure. [ENUM-REF-CANDIDATE: new|open|in_progress|pending_customer|pending_vendor|escalated|resolved|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the service case by the nature of the customer issue or inquiry. Includes return inquiry, billing dispute, product complaint, delivery issue, loyalty query, order inquiry, technical support, and general inquiry. [ENUM-REF-CANDIDATE: return_inquiry|billing_dispute|product_complaint|delivery_issue|loyalty_query|order_inquiry|technical_support|general_inquiry — 8 candidates stripped; promote to reference product]',
    `channel` STRING COMMENT 'The customer interaction channel through which the service case was initiated. Supports omnichannel service analytics. [ENUM-REF-CANDIDATE: phone|email|chat|in_store|mobile_app|web_portal|social_media — 7 candidates stripped; promote to reference product]',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was formally closed in the system. May differ from resolution timestamp if additional verification or customer confirmation was required.',
    `contact_attempts` STRING COMMENT 'Number of times the service team attempted to contact the customer during the case lifecycle. Used for tracking customer engagement and responsiveness.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service case record was first created in the system. Represents the initiation of the service workflow.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary amounts associated with the case, such as refunds or credits.. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction score provided by the customer after case resolution, typically on a scale of 1 to 5. Used to calculate CSAT and NPS metrics.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the case was escalated to a higher support tier, supervisor, or specialized team during its lifecycle.',
    `escalation_reason` STRING COMMENT 'Reason or justification for escalating the case, such as complexity, customer request, or SLA breach.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Timestamp when the first agent response was provided to the customer after case creation. Key metric for measuring initial response time SLA.',
    `interaction_count` STRING COMMENT 'Total number of customer-agent interactions or touchpoints recorded during the lifecycle of this case. Includes calls, emails, chats, and in-person contacts.',
    `is_closed` BOOLEAN COMMENT 'Boolean indicator of whether the case is currently in a closed status. Simplifies filtering for open vs closed case analytics.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the service case record was last modified or updated. Used for audit trail and change tracking.',
    `nps_score` STRING COMMENT 'Net Promoter Score provided by the customer, typically on a scale of 0 to 10, indicating likelihood to recommend the business based on the service experience.',
    `priority` STRING COMMENT 'Business priority level assigned to the case based on urgency and impact to the customer or business operations.. Valid values are `low|medium|high|critical`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the customer as part of the case resolution, if applicable. Denominated in the transaction currency.',
    `resolution_code` STRING COMMENT 'Standardized code indicating the type of resolution or action taken to close the service case. Used for resolution analytics and process improvement. [ENUM-REF-CANDIDATE: refund_issued|replacement_sent|information_provided|escalated_to_vendor|no_action_required|customer_withdrew|policy_exception_approved — 7 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution details, actions taken, and any follow-up required for the case.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was marked as resolved by the service agent. Represents the point at which the issue was addressed.',
    `rma_number` STRING COMMENT 'Return Merchandise Authorization number issued for return-related cases. Links the service case to the formal return process and inventory tracking.. Valid values are `^RMA[A-Z0-9]{8,15}$`',
    `service_case_description` STRING COMMENT 'Detailed narrative description of the customer issue, inquiry, or complaint as captured by the service agent or customer.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the case resolution exceeded the SLA target time, triggering a service level breach.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which the case should be resolved according to the applicable SLA policy based on case type and priority.',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which the case was created or integrated, such as Salesforce Service Cloud, POS system, or e-commerce platform.',
    `subject` STRING COMMENT 'Brief summary or subject line describing the nature of the customer service case.',
    CONSTRAINT pk_service_case PRIMARY KEY(`service_case_id`)
) COMMENT 'Customer service and support case records managed through Salesforce Service Cloud. Stores case number, case type (return inquiry, billing dispute, product complaint, delivery issue, loyalty query), case status (open/in-progress/resolved/closed), priority, channel of origin (phone/chat/email/in-store), assigned agent, store or fulfillment node involved, resolution code, resolution timestamp, customer satisfaction rating, and RMA reference for return-related cases. Distinct from interaction (which captures all touchpoints) — service_case tracks formal support workflows with SLAs.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`payment_method` (
    `payment_method_id` BIGINT COMMENT 'Primary key for payment_method',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: payment_method has embedded billing address fields (billing_address_line1, billing_address_line2, billing_city, billing_state_province, billing_postal_code, billing_country_code) that should be normal',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Gift cards and store credit (payment_method has gift_card_balance, store_credit_balance) represent deferred revenue liabilities that must be tracked in specific GL accounts. Required for ASC 606 reven',
    `account_id` BIGINT COMMENT 'Tokenized identifier for the digital wallet account. Used for digital wallet transactions and reconciliation.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this payment method. Links to the customer master record for omnichannel recognition and clienteling.',
    `bin_number` STRING COMMENT 'First six digits of the card number (Bank Identification Number). Used for card type identification, fraud detection, and routing. Not considered sensitive under PCI DSS.. Valid values are `^[0-9]{6}$`',
    `bnpl_provider` STRING COMMENT 'Provider of the BNPL service (Affirm, Afterpay, Klarna, Zip, Sezzle). Applicable only when payment_method_type is bnpl.. Valid values are `affirm|afterpay|klarna|zip|sezzle`',
    `card_brand` STRING COMMENT 'Brand of the payment card (Visa, Mastercard, American Express, Discover, JCB, UnionPay). Applicable for credit and debit card payment methods.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the card was issued. Derived from BIN lookup. Used for fraud detection and international transaction processing.. Valid values are `^[A-Z]{3}$`',
    `cardholder_name` STRING COMMENT 'Name of the cardholder as it appears on the payment card. Used for verification and fraud prevention.',
    `consent_channel` STRING COMMENT 'Channel through which the customer provided consent to store this payment method (web, mobile app, POS, call center, in-store). Required for GDPR and CCPA compliance.. Valid values are `web|mobile_app|pos|call_center|in_store`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer provided consent to store this payment method. Required for GDPR and CCPA compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment method record was first created in the system. Used for audit trail and customer lifecycle analysis.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment method was deactivated. Null if the payment method is still active. Used for lifecycle tracking and compliance reporting.',
    `deactivation_reason` STRING COMMENT 'Reason why the payment method was deactivated. Used for customer service, fraud analysis, and operational reporting.. Valid values are `expired|customer_request|fraud_suspected|lost_stolen|replaced`',
    `digital_wallet_provider` STRING COMMENT 'Provider of the digital wallet (Apple Pay, Google Pay, PayPal, Samsung Pay, Venmo). Applicable only when payment_method_type is digital_wallet.. Valid values are `apple_pay|google_pay|paypal|samsung_pay|venmo`',
    `expiry_month` STRING COMMENT 'Expiration month of the payment card (1-12). Used to validate card validity at checkout and trigger proactive customer notifications for expiring cards.',
    `expiry_year` STRING COMMENT 'Expiration year of the payment card (four-digit year). Used to validate card validity at checkout and trigger proactive customer notifications for expiring cards.',
    `gift_card_balance` DECIMAL(18,2) COMMENT 'Current balance remaining on the gift card. Updated after each transaction. Applicable only when payment_method_type is gift_card.',
    `gift_card_number` STRING COMMENT 'Tokenized or masked gift card number. Applicable only when payment_method_type is gift_card. Used for gift card balance inquiries and redemption.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this payment method is currently active and available for use. Inactive methods are retained for historical transaction reference but cannot be used for new purchases.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this is the customers default payment method for one-click checkout and recurring purchases. Only one payment method per customer should be marked as default.',
    `issuing_bank` STRING COMMENT 'Name of the bank or financial institution that issued the payment card. Used for transaction routing and fraud detection.',
    `last_four_digits` STRING COMMENT 'Last four digits of the card number for customer recognition and display purposes. Used in clienteling and checkout confirmation screens.. Valid values are `^[0-9]{4}$`',
    `last_used_date` DATE COMMENT 'Date when this payment method was last used for a transaction. Used for RFM (Recency Frequency Monetary) analytics and customer engagement.',
    `nickname` STRING COMMENT 'Customer-defined nickname for this payment method (e.g., My Visa, Work Card, Personal Checking). Used for customer convenience in payment selection.',
    `payment_method_type` STRING COMMENT 'Type of payment instrument. BNPL = Buy Now Pay Later. Supports diverse payment options across POS, e-commerce, and mobile channels.. Valid values are `credit_card|debit_card|digital_wallet|gift_card|store_credit|bnpl`',
    `payment_processor` STRING COMMENT 'Name of the payment processor or gateway used to process transactions with this payment method (e.g., Stripe, Adyen, Braintree, Cybersource). Used for transaction routing and reconciliation.',
    `processor_token` STRING COMMENT 'Payment processor-specific token for this payment method. Used for transaction processing and vault management.',
    `store_credit_balance` DECIMAL(18,2) COMMENT 'Current balance of store credit available to the customer. Typically issued from returns or promotional campaigns. Applicable only when payment_method_type is store_credit.',
    `token` STRING COMMENT 'PCI DSS compliant tokenized reference to the payment instrument. No raw PAN (Primary Account Number) is stored. Token is used for recurring purchases and one-click checkout.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment method record was last updated. Used for audit trail and data quality monitoring.',
    `usage_count` STRING COMMENT 'Total number of times this payment method has been used for transactions. Used for RFM analytics and customer behavior analysis.',
    `verification_date` DATE COMMENT 'Date when the payment method was last verified. Used for compliance and fraud prevention tracking.',
    `verification_status` STRING COMMENT 'Status of payment method verification (e.g., AVS check, CVV verification, micro-deposit confirmation). Used for fraud prevention and risk management.. Valid values are `verified|pending|failed|not_verified`',
    CONSTRAINT pk_payment_method PRIMARY KEY(`payment_method_id`)
) COMMENT 'Stores customer-saved payment instruments on file for recurring purchases, one-click checkout, and in-store clienteling. Stores payment method type (credit card, debit card, digital wallet, gift card, store credit, BNPL), tokenized card reference (PCI DSS compliant — no raw PAN), card brand, last four digits, expiry month/year, billing address reference, default flag, and active status. Managed in compliance with PCI DSS standards enforced by PCI SSC.';

CREATE OR REPLACE TABLE `retail_ecm`.`customer`.`customer_membership` (
    `customer_membership_id` BIGINT COMMENT 'Primary key for customer_membership',
    `segment_id` BIGINT COMMENT 'Foreign key linking to the segment definition to which this profile is assigned',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Retail loyalty programs track the enrolling store location for attribution reporting, localized loyalty benefit activation, and store-level membership KPIs. The enrollment store is a distinct business',
    `loyalty_membership_id` BIGINT COMMENT 'Unique identifier for this segment membership record. Primary key.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Loyalty membership tier pricing: each membership tier in retail maps to a specific price list (member pricing, VIP pricing). customer_membership has no FK to price_list despite being the operational r',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the customer profile participating in this segment membership',
    `assignment_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00-100.00) indicating the strength of this customers qualification for this segment. For rule-based assignments, reflects how strongly the customer meets qualification criteria. For ML-based assignments, reflects model prediction confidence. Used for prioritizing marketing outreach and identifying borderline members.',
    `assignment_method` STRING COMMENT 'Mechanism by which this customer was assigned to this segment. AutoRefresh: automatically assigned via scheduled segment refresh process. ManualOverride: manually assigned by business user overriding qualification rules. RuleEngine: assigned via real-time rule evaluation. MLModel: assigned via predictive model scoring. BulkImport: assigned via batch data load.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was first created in the system. Audit field for data lineage and troubleshooting.',
    `customer_membership_status` STRING COMMENT 'Current operational status of this segment membership. Active: customer currently qualifies and membership is in effect. Expired: membership ended due to disqualification or time-based expiry. Suspended: temporarily inactive due to business rules. PendingQualification: awaiting next refresh cycle to confirm eligibility.',
    `end_date` DATE COMMENT 'Date when this customer profile exited this segment or the membership was terminated. Null for currently active memberships. Used for churn analysis and segment tenure calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was last updated (status change, confidence score update, override modification). Audit field for change tracking.',
    `last_qualification_check_date` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of this customers eligibility for this segment. Updated during auto-refresh cycles or manual re-qualification checks. Used for audit trails and determining when next qualification check is due.',
    `manual_override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this membership was manually assigned by a business user, overriding automated qualification rules. True: manual override in effect, customer may not meet standard qualification criteria. False: standard rule-based or automated assignment. Used for governance and audit purposes.',
    `override_reason` STRING COMMENT 'Free-text explanation provided by business user when manual_override_flag is true. Documents business justification for overriding automated qualification rules (e.g., VIP customer per executive request, Strategic account exception, Retention offer). Null when no override is in effect.',
    `start_date` DATE COMMENT 'Date when this customer profile was assigned to this segment and the membership became active. Used for lifecycle tracking and historical analysis of segment transitions.',
    CONSTRAINT pk_customer_membership PRIMARY KEY(`customer_membership_id`)
) COMMENT 'This association product represents the assignment of customer profiles to market segments for targeted marketing, personalized pricing, and differentiated service delivery. It captures the operational reality that customers can simultaneously belong to multiple segments (e.g., VIP Gold + High CLTV + Geographic Northeast) and that segments contain many customers. Each record links one profile to one segment with lifecycle attributes (start/end dates, status), assignment metadata (method, confidence, override flags), and qualification tracking that exist only in the context of this membership relationship.. Existence Justification: Customer segmentation in retail operates as a true many-to-many relationship where individual customer profiles are simultaneously assigned to multiple segments (e.g., a customer can be both VIP Gold Tier and High CLTV and Northeast Geographic at the same time), and each segment definition contains thousands of customer profiles. Marketing teams actively manage these memberships as operational business entities, tracking when customers enter/exit segments, how they were assigned (auto-refresh vs. manual override), and qualification confidence scores. The segment table currently has no FK relationships to profile—it is a definition table that requires an association product to operationalize the membership relationship.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_superseded_by_preference_id` FOREIGN KEY (`superseded_by_preference_id`) REFERENCES `retail_ecm`.`customer`.`preference`(`preference_id`);
ALTER TABLE `retail_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `retail_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_parent_case_service_case_id` FOREIGN KEY (`parent_case_service_case_id`) REFERENCES `retail_ecm`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ADD CONSTRAINT `fk_customer_customer_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `retail_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ADD CONSTRAINT `fk_customer_customer_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `retail_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `retail_ecm`.`customer`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`customer`.`profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile ID');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Store ID');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Channel');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_value_regex' = 'store|ecommerce|mobile_app|social_media|referral|partner');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Date');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `cac_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Cost (CAC) Amount');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `cac_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `ccpa_opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Date');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Score');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `customer_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Type Classification');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `customer_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|employee|vip|wholesale');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Customer Date of Birth');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Customer Email Address');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Opt-In Flag');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `employee_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Customer Flag');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Customer First Name');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Full Legal Name');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Customer Gender');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other|unknown');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Last Name');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifecycle Stage');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Loyalty Tier');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Communication Consent Flag');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `mdm_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Confidence Score');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `mdm_last_match_date` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Last Match Date');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `mdm_source_system` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Source System');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Middle Name');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Mobile Phone Number');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Customer Nationality');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Phone Number');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|none');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Customer Preferred Language');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile Status');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blocked|closed');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `sms_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Opt-In Flag');
ALTER TABLE `retail_ecm`.`customer`.`profile` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP Customer Flag');
ALTER TABLE `retail_ecm`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Buyer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Default Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store ID');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|frozen|dormant');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|vip|platinum');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'personal|business|employee|wholesale');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `b2b_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Business-to-Business (B2B) Pricing Flag');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Limit');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `employee_discount_eligible` SET TAGS ('dbx_business_glossary_term' = 'Employee Discount Eligible Flag');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Date');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `marketing_opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Date');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Channel');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|call_center');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Date');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Reason');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Number');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `tax_exempt_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Expiry Date');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `total_lifetime_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Orders');
ALTER TABLE `retail_ecm`.`customer`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|bounced|invalid|suppressed|pending_verification');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_business_glossary_term' = 'Contact Value');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `contact_value` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `last_bounce_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bounce Date');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Date');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_marketing` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Marketing');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `opt_in_transactional` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Transactional');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `retail_ecm`.`customer`.`contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `retail_ecm`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending_verification');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|home|work|store_pickup|mailing');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `delivery_point_barcode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Barcode');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `is_default_billing` SET TAGS ('dbx_business_glossary_term' = 'Is Default Billing Address');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `is_default_shipping` SET TAGS ('dbx_business_glossary_term' = 'Is Default Shipping Address');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Military Address Flag');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `military_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Address Nickname');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box Flag');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `residential_flag` SET TAGS ('dbx_business_glossary_term' = 'Residential Address Flag');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `standardization_flag` SET TAGS ('dbx_business_glossary_term' = 'Postal Standardization Flag');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|pending');
ALTER TABLE `retail_ecm`.`customer`.`address` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Format Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `auto_refresh_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Refresh Flag');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `average_aov` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `average_aov` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `average_cltv` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Lifetime Value (CLTV)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `average_cltv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `average_purchase_frequency` SET TAGS ('dbx_business_glossary_term' = 'Average Purchase Frequency');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `b2b_b2c_indicator` SET TAGS ('dbx_business_glossary_term' = 'Business-to-Business (B2B) / Business-to-Consumer (B2C) Indicator');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `b2b_b2c_indicator` SET TAGS ('dbx_value_regex' = 'b2b|b2c|both');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `ccpa_opt_out_honored_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Honored Flag');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Segment Churn Risk Score');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `discount_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Discount Sensitivity Level');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `discount_sensitivity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective End Date');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Start Date');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `gdpr_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Required Flag');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Refresh Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `max_rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Recency Frequency Monetary (RFM) Score');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `membership_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Count');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `min_rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Recency Frequency Monetary (RFM) Score');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority Tier');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `qualification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria Summary');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Refresh Frequency');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `retail_ecm`.`customer`.`segment` ALTER COLUMN `target_marketing_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Marketing Channel');
ALTER TABLE `retail_ecm`.`customer`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`customer`.`preference` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `superseded_by_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Preference ID');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `application_count` SET TAGS ('dbx_business_glossary_term' = 'Application Count');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `channel_captured` SET TAGS ('dbx_business_glossary_term' = 'Channel Captured');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Preference Language');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `last_applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Applied Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `opt_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_business_glossary_term' = 'Preference Category');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_description` SET TAGS ('dbx_business_glossary_term' = 'Preference Description');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_business_glossary_term' = 'Preference Source');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_value_regex' = 'self_declared|behavioral|inferred|third_party|imported');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|superseded');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `preference_value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Preference Subcategory');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|verification_failed');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Preference Version');
ALTER TABLE `retail_ecm`.`customer`.`preference` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Preference Weight');
ALTER TABLE `retail_ecm`.`customer`.`consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`customer`.`consent` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Collection Channel');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit_opt_in|implicit_opt_in|pre_checked_box|verbal|written_signature');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired|revoked');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `data_subject_rights_notice` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Rights Notice');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `double_opt_in_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmed');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `double_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `granularity` SET TAGS ('dbx_business_glossary_term' = 'Consent Granularity');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `granularity` SET TAGS ('dbx_value_regex' = 'global|channel_specific|purpose_specific|brand_specific');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interest|public_task|legitimate_interest');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `minor_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Consent Flag');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `parental_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Verified');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `privacy_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Version');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `proof_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Document URL');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `retail_ecm`.`customer`.`consent` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`service_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`customer`.`service_case` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `checkout_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Product Compliance Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `outbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `parent_case_service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Case ID');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `price_override_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `case_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Case Owner Type');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `case_owner_type` SET TAGS ('dbx_value_regex' = 'agent|queue|automated_system');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel of Origin');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `contact_attempts` SET TAGS ('dbx_business_glossary_term' = 'Contact Attempts');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Rating');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `first_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Interaction Count');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA[A-Z0-9]{8,15}$');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `service_case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`customer`.`service_case` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Identifier');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Account ID');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later (BNPL) Provider');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_value_regex' = 'affirm|afterpay|klarna|zip|sezzle');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `card_country_code` SET TAGS ('dbx_business_glossary_term' = 'Card Issuing Country Code');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `card_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `consent_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|pos|call_center|in_store');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_value_regex' = 'expired|customer_request|fraud_suspected|lost_stolen|replaced');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `digital_wallet_provider` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Provider');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `digital_wallet_provider` SET TAGS ('dbx_value_regex' = 'apple_pay|google_pay|paypal|samsung_pay|venmo');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Expiry Month');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Expiry Year');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `gift_card_balance` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Balance');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Number');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `gift_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Payment Method');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Last Four Digits');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Nickname');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|digital_wallet|gift_card|store_credit|bnpl');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `processor_token` SET TAGS ('dbx_business_glossary_term' = 'Processor Token');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `processor_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `processor_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `store_credit_balance` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Balance');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Token');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_verified');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `customer_membership_id` SET TAGS ('dbx_business_glossary_term' = 'customer_membership Identifier');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Membership - Customer Segment Id');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Identifier');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Membership - Profile Id');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `assignment_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `customer_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `last_qualification_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Check Timestamp');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `manual_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
