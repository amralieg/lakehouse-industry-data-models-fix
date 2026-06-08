-- Schema for Domain: customer | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`customer` COMMENT 'Single source of truth for customer identity, profiles, accounts, segments, preferences, and behavioral data across B2C, B2B, and C2C customer types. Manages unified customer views, household relationships, loyalty programs, CLTV scoring, and NPS measurement. Owns consent and preference management under GDPR and CCPA. Integrates with Customer Data Platform for unified profile orchestration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`customer_profile` (
    `customer_profile_id` BIGINT COMMENT 'Unique identifier for the customer profile. Primary key for the profile entity. Serves as the anchor for all customer domain relationships.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: KYC/AML processes require linking a customer to the specific compliance obligation they must meet; this FK supports obligation tracking and audit.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: REQUIRED: Negotiated price list per customer profile used in B2B contracts; sales team needs to retrieve the specific price list for each customer during order pricing.',
    `privacy_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_notice. Business justification: GDPR/CCPA audit requires tracking which privacy notice version each customer accepted; linking profile to privacy_notice satisfies this regulatory need.',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.retention_policy. Business justification: Data‑retention compliance mandates assigning each customer the appropriate retention policy based on jurisdiction; the FK enables policy enforcement and reporting.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.risk_assessment. Business justification: AML risk scoring assigns a risk assessment to each customer; the FK enables risk‑based monitoring and regulatory reporting.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Profile can be assigned to a primary segment; many profiles per segment, add FK to enable segment membership lookup.',
    `account_closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer account was permanently closed or deactivated. Null for active accounts. Used for churn analysis and GDPR right-to-erasure compliance.',
    `account_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer profile record was first created in the system. Used for audit trails and account age calculations.',
    `account_status` STRING COMMENT 'Current lifecycle status of the customer account. Active accounts can transact; suspended accounts are temporarily restricted; closed accounts are permanently deactivated.. Valid values are `active|inactive|suspended|closed|pending|blocked`',
    `account_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer profile record was last modified. Used for change tracking and data freshness monitoring.',
    `acquisition_channel` STRING COMMENT 'Marketing channel through which the customer was originally acquired. Used for CAC (Customer Acquisition Cost) analysis and ROAS (Return on Ad Spend) measurement. [ENUM-REF-CANDIDATE: organic_search|paid_search|social_media|email|affiliate|direct|referral|mobile_app|marketplace|offline — 10 candidates stripped; promote to reference product]',
    `acquisition_date` DATE COMMENT 'Date when the customer first registered or created an account. Used for cohort analysis and CLTV (Customer Lifetime Value) calculation.',
    `cdp_profile_code` STRING COMMENT 'External identifier from the Customer Data Platform system. Used for unified profile orchestration and cross-system reconciliation.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer provided or last updated their marketing consent preferences. Required for GDPR consent audit trails.',
    `customer_type` STRING COMMENT 'Classification of customer type: B2C (Business to Consumer individual shopper), B2B (Business to Business corporate buyer), C2C (Consumer to Consumer marketplace participant), marketplace_seller (third-party seller), or guest (one-time purchaser without account).. Valid values are `B2C|B2B|C2C|marketplace_seller|guest`',
    `data_processing_consent` BOOLEAN COMMENT 'Indicates whether the customer has consented to data processing for analytics, personalization, and AI/ML model training. Required for GDPR and CCPA compliance.',
    `date_of_birth` DATE COMMENT 'Date of birth of the customer. Used for age verification, compliance with age-restricted product regulations, and lifecycle marketing segmentation.',
    `email` STRING COMMENT 'Primary email address for customer communication, order confirmations, marketing campaigns, and account recovery. Serves as the primary digital contact channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_verified_flag` BOOLEAN COMMENT 'Indicates whether the customers email address has been verified through a confirmation link or OTP (One-Time Password). True if verified, False if pending verification.',
    `first_name` STRING COMMENT 'Given name of the customer. Used for personalized communication and segmentation.',
    `first_purchase_date` DATE COMMENT 'Date of the customers first completed order. Used to measure conversion from registration to first purchase and calculate time-to-first-purchase metrics.',
    `full_name` STRING COMMENT 'Complete legal name of the customer as provided during registration or KYC verification. Used for identity verification and personalization.',
    `gender` STRING COMMENT 'Self-identified gender of the customer. Used for personalization and demographic segmentation. Optional field respecting customer privacy preferences.. Valid values are `male|female|non-binary|prefer not to say|other|unknown`',
    `kyc_document_type` STRING COMMENT 'Type of identity document submitted for KYC verification. Used for compliance reporting and document expiry tracking. [ENUM-REF-CANDIDATE: passport|drivers_license|national_id|business_license|tax_id|bank_statement|utility_bill — 7 candidates stripped; promote to reference product]',
    `kyc_expiry_date` DATE COMMENT 'Date when the KYC verification expires and re-verification is required. Typically set based on regulatory requirements or risk assessment policies.',
    `kyc_failure_reason` STRING COMMENT 'Reason for KYC verification failure if status is failed. Examples: document expired, document unreadable, name mismatch, address mismatch, watchlist match. Used for customer support and fraud investigation.',
    `kyc_risk_level` STRING COMMENT 'Risk assessment level assigned to the customer based on KYC verification results, transaction patterns, and fraud signals. Used for enhanced due diligence and transaction monitoring.. Valid values are `low|medium|high|critical`',
    `kyc_verification_date` DATE COMMENT 'Date when the KYC identity verification was successfully completed. Used for compliance audit trails and re-verification scheduling.',
    `kyc_verification_provider` STRING COMMENT 'Name of the third-party identity verification service provider used for KYC checks (e.g., Jumio, Onfido, Trulioo). Used for audit trails and provider performance analysis.',
    `kyc_verification_status` STRING COMMENT 'Status of the KYC identity verification process. Required for high-value transactions, B2B accounts, and marketplace sellers to comply with anti-fraud and regulatory requirements.. Valid values are `not_started|pending|verified|failed|expired`',
    `kyc_verification_type` STRING COMMENT 'Type of identity verification method used for KYC compliance. Government ID includes passport, drivers license, national ID; business registration for B2B customers.. Valid values are `email|phone|government_id|business_registration|bank_account|biometric`',
    `last_active_date` DATE COMMENT 'Date of the customers most recent interaction with any platform touchpoint (login, browse, cart activity, customer service contact). Used for engagement scoring and dormancy detection.',
    `last_name` STRING COMMENT 'Family name or surname of the customer. Used for identity verification and customer matching.',
    `last_purchase_date` DATE COMMENT 'Date of the customers most recent completed order. Used for recency scoring in RFM (Recency, Frequency, Monetary) analysis and churn prediction.',
    `loyalty_points_balance` DECIMAL(18,2) COMMENT 'Current balance of loyalty reward points available for redemption. Points are earned through purchases, referrals, reviews, and promotional activities.',
    `loyalty_tier` STRING COMMENT 'Current tier level in the customer loyalty program. Determines benefits such as free shipping, exclusive discounts, early access to sales, and priority customer service.. Valid values are `bronze|silver|gold|platinum|diamond|vip`',
    `marketing_opt_in_email` BOOLEAN COMMENT 'Indicates whether the customer has consented to receive marketing emails. True if opted in, False if opted out. Required for GDPR and CAN-SPAM compliance.',
    `marketing_opt_in_push` BOOLEAN COMMENT 'Indicates whether the customer has consented to receive push notifications through the mobile app. True if opted in, False if opted out.',
    `marketing_opt_in_sms` BOOLEAN COMMENT 'Indicates whether the customer has consented to receive marketing SMS messages. True if opted in, False if opted out. Required for TCPA compliance.',
    `nps_score` STRING COMMENT 'Most recent NPS score provided by the customer on a scale of 0-10. Scores 9-10 are promoters, 7-8 are passives, 0-6 are detractors. Used for customer satisfaction measurement and churn prediction.',
    `nps_survey_date` DATE COMMENT 'Date when the most recent NPS survey response was collected. Used for tracking sentiment trends over time.',
    `phone` STRING COMMENT 'Primary contact phone number for customer service, delivery coordination, and two-factor authentication. Includes country code and area code.',
    `phone_verified_flag` BOOLEAN COMMENT 'Indicates whether the customers phone number has been verified through SMS OTP or voice call verification. True if verified, False if pending verification.',
    `preferred_currency` STRING COMMENT 'ISO 4217 three-letter currency code representing the customers preferred currency for pricing display and transactions.. Valid values are `^[A-Z]{3}$`',
    `preferred_language` STRING COMMENT 'ISO 639-2 three-letter language code representing the customers preferred language for communication, user interface, and content delivery.. Valid values are `^[A-Z]{3}$`',
    `third_party_sharing_consent` BOOLEAN COMMENT 'Indicates whether the customer has consented to sharing their data with third-party partners for marketing or analytics purposes. Required for CCPA compliance.',
    CONSTRAINT pk_customer_profile PRIMARY KEY(`customer_profile_id`)
) COMMENT 'Unified master record for every customer identity across B2C, B2B, and C2C customer types. Serves as the single source of truth for customer identity data sourced from the Customer Data Platform. Stores full name, email, phone, date of birth, gender, preferred language, preferred currency, account status, customer type (individual/business/marketplace), acquisition channel, acquisition date, first purchase date, last active date, and CDP profile ID. Owns KYC/identity verification records: verification type (email, phone, government ID, business registration), verification status, provider, verification date, expiry date, document type, risk level, and failure reason. This is the anchor entity for the entire customer domain — all other customer products reference back to profile.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the customer account. Primary key for the account entity.',
    `customer_address_id` BIGINT COMMENT 'Reference to the customers preferred shipping address for this account. Pre-populated at checkout for faster order placement.',
    `account_default_billing_address_customer_address_id` BIGINT COMMENT 'Reference to the customers preferred billing address for invoices and payment processing. May differ from shipping address for B2B accounts.',
    `agent_id` BIGINT COMMENT 'Reference to the dedicated account manager or customer success representative assigned to this account. Typically assigned to Enterprise B2B accounts and VIP customers.',
    `customer_profile_id` BIGINT COMMENT 'Foreign key linking to customer.customer_profile. Business justification: Account belongs to a single Customer Profile; adding account.customer_profile_id creates the necessary parent‑child relationship and eliminates the orphaned Account side.',
    `method_id` BIGINT COMMENT 'Reference to the customers preferred payment method for this account. Used for one-click checkout and subscription billing.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: REQUIRED: Account‑level price list assignment for corporate customers; finance reports aggregate spend by account using the linked price list.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the seller profile if marketplace_seller_flag is True. Null for buyer-only accounts. Links to the Seller domain for commission and performance tracking.',
    `account_number` STRING COMMENT 'Externally-visible unique account number used for customer communication, statements, and support interactions.. Valid values are `^[A-Z0-9]{8,16}$`',
    `account_source` STRING COMMENT 'Channel through which the account was originally created. Used for Customer Acquisition Cost (CAC) analysis and channel attribution.. Valid values are `WEB|MOBILE_APP|STORE|CALL_CENTER|API|PARTNER`',
    `account_status` STRING COMMENT 'Current lifecycle status of the account. Active for operational accounts, Suspended for temporarily restricted accounts, Closed for permanently terminated accounts, Pending for accounts awaiting verification or approval.. Valid values are `ACTIVE|SUSPENDED|CLOSED|PENDING`',
    `account_tier` STRING COMMENT 'Service tier or membership level of the account determining benefits, pricing, and service levels. Standard for basic accounts, Premium for paid memberships, VIP for high-value customers, Enterprise for B2B corporate accounts.. Valid values are `STANDARD|PREMIUM|VIP|ENTERPRISE`',
    `account_type` STRING COMMENT 'Classification of the account based on the commercial relationship: B2C (Business to Consumer) for personal shopping accounts, B2B (Business to Business) for corporate procurement accounts, C2C (Consumer to Consumer) for marketplace seller accounts.. Valid values are `B2C_PERSONAL|B2B_CORPORATE|C2C_MARKETPLACE`',
    `b2b_company_name` STRING COMMENT 'Legal company name for B2B corporate accounts. Null for B2C personal accounts. Used for invoicing, tax reporting, and corporate account management.',
    `close_date` DATE COMMENT 'Date when the account was permanently closed. Null for active and suspended accounts. Used for churn analysis and retention reporting.',
    `cltv_last_calculated_date` DATE COMMENT 'Date when the CLTV score was last recalculated. CLTV is typically refreshed monthly or quarterly based on updated transaction data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account record was first created in the system. Used for audit trails and data lineage tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the account for B2B corporate accounts or premium consumer accounts. Null for standard pay-per-order accounts. Used for order approval and risk management.',
    `credit_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit limit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_lifetime_value` DECIMAL(18,2) COMMENT 'Predicted total revenue expected from this account over its lifetime. Calculated by analytics models based on purchase history, frequency, and retention probability. Used for segmentation and marketing investment decisions.',
    `data_processing_consent` BOOLEAN COMMENT 'Indicates whether the account holder has consented to data processing for personalization, analytics, and AI/ML applications beyond core transaction processing. Required under GDPR.',
    `data_processing_consent_date` TIMESTAMP COMMENT 'Timestamp when the customer provided data processing consent. Required for GDPR compliance audit trails. Null if data_processing_consent is False.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful login to the account. Used for engagement analysis, dormancy detection, and security monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this account record was last updated. Used for change tracking, audit trails, and data synchronization.',
    `last_order_date` DATE COMMENT 'Date of the most recent order placed by this account. Used for recency-frequency-monetary (RFM) analysis and churn prediction. Null if no orders have been placed.',
    `loyalty_points_balance` STRING COMMENT 'Current balance of loyalty points or rewards currency available for redemption. Zero if not enrolled or no points earned.',
    `loyalty_program_enrolled` BOOLEAN COMMENT 'Indicates whether the account is enrolled in the companys loyalty or rewards program. True if enrolled, False otherwise.',
    `loyalty_tier` STRING COMMENT 'Current tier level within the loyalty program based on spending or engagement. Null if not enrolled in loyalty program.. Valid values are `BRONZE|SILVER|GOLD|PLATINUM`',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the account holder has consented to receive marketing communications (emails, SMS, push notifications). Managed under GDPR and CCPA consent requirements.',
    `marketing_opt_in_date` TIMESTAMP COMMENT 'Timestamp when the customer provided marketing consent. Required for GDPR and CCPA compliance audit trails. Null if marketing_opt_in is False.',
    `marketplace_seller_flag` BOOLEAN COMMENT 'Indicates whether this account is also registered as a marketplace seller (C2C model). True if the account holder sells products on the platform, False for buyer-only accounts.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) rating provided by the account holder, ranging from 0 (detractor) to 10 (promoter). Used for customer satisfaction measurement and churn prediction.',
    `nps_survey_date` DATE COMMENT 'Date when the most recent NPS survey response was collected. Null if the customer has never completed an NPS survey.',
    `open_date` DATE COMMENT 'Date when the account was first opened and activated. Used for calculating account tenure and Customer Lifetime Value (CLTV).',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance owed by the account holder for credit-based accounts. Represents unpaid invoices and charges. Zero for prepaid accounts.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the customers preferred pricing and billing currency (e.g., USD, EUR, GBP). Used for multi-currency pricing display.. Valid values are `^[A-Z]{3}$`',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the customers preferred language for communication, emails, and user interface (e.g., en, es, fr, de).. Valid values are `^[a-z]{2}$`',
    `referral_code` STRING COMMENT 'Referral or promotional code used during account registration. Used for tracking referral program effectiveness and attributing customer acquisition.',
    `risk_score` STRING COMMENT 'Fraud risk score assigned to the account by fraud detection systems, typically ranging from 0 (low risk) to 100 (high risk). Used for transaction approval, account monitoring, and fraud prevention.',
    `risk_score_last_updated` TIMESTAMP COMMENT 'Timestamp when the fraud risk score was last recalculated. Risk scores are updated in real-time or near-real-time based on transaction patterns and fraud signals.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for B2B accounts. Format varies by jurisdiction (e.g., EIN in USA, CRN in UK). Used for tax reporting and compliance.',
    `total_order_count` STRING COMMENT 'Lifetime count of orders placed by this account. Used for customer segmentation and loyalty tier calculation.',
    `vat_number` STRING COMMENT 'VAT registration number for B2B accounts in VAT-applicable jurisdictions (primarily EU). Used for VAT exemption and cross-border invoicing.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Customer account record representing the commercial relationship between a customer and the Ecommerce platform. Tracks account type (B2C personal, B2B corporate, C2C marketplace), account tier, account status (active, suspended, closed, pending), account open date, account close date, credit limit, default payment method reference, default shipping address reference, loyalty program enrollment status, marketplace seller flag, B2B company name, tax ID, VAT number, and account manager assignment. One profile may have one or more accounts (e.g., personal + business). Owns the immutable account status change audit trail: each transition records previous status, new status, change reason code, change initiated by (customer, agent, automated rule, fraud system), change timestamp, effective date, reversal flag, and associated case reference. Provides full account lifecycle audit for compliance, dispute resolution, and customer service operations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`customer_address` (
    `customer_address_id` BIGINT COMMENT 'Unique identifier for the address record. Primary key.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer profile that owns this address. Links address to unified customer view in Customer Data Platform (CDP).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active = currently usable, inactive = temporarily disabled, archived = historical record, flagged = requires review due to delivery failures or fraud indicators.. Valid values are `active|inactive|archived|flagged`',
    `address_type` STRING COMMENT 'Classification of address purpose: shipping (delivery destination), billing (invoice address), registered (legal/account address), pickup (BOPIS location), return (RMA destination).. Valid values are `shipping|billing|registered|pickup|return`',
    `city` STRING COMMENT 'City or municipality name for the address. Used for delivery routing and tax jurisdiction determination.',
    `consent_marketing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has consented to receive marketing communications at this address. Required for GDPR and CCPA compliance. Used by Marketing Automation Platform for campaign targeting.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when marketing consent was granted or last updated for this address. Required for GDPR and CCPA audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country of the address. Used for international shipping, customs, tax jurisdiction, and regulatory compliance (e.g., GDPR for EU countries).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the system. Used for audit trail, data lineage, and GDPR compliance (right to access). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delivery_instructions` STRING COMMENT 'Special delivery instructions provided by the customer for this address (e.g., gate code, leave at door, ring bell, call upon arrival). Used by last-mile delivery carriers and 3PL (Third-Party Logistics) providers.',
    `failed_delivery_count` STRING COMMENT 'Number of failed delivery attempts to this address. Used for address quality scoring and to flag problematic addresses. High count triggers address verification workflow.',
    `first_used_date` DATE COMMENT 'Date when this address was first used for an order or transaction. Used for address age analysis and Customer Lifetime Value (CLTV) modeling.',
    `geocoding_accuracy` STRING COMMENT 'Precision level of the geocoded coordinates. Rooftop = exact building location, range_interpolated = estimated within address range, geometric_center = center of postal code area, approximate = city/region level. Impacts delivery time estimation accuracy.. Valid values are `rooftop|range_interpolated|geometric_center|approximate`',
    `is_bopis_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this address is eligible for BOPIS (Buy Online Pick Up In Store) fulfillment. True if address is within serviceable radius of a store or pickup location with inventory availability.',
    `is_default_billing` BOOLEAN COMMENT 'Boolean flag indicating whether this is the customers preferred default billing address. Used for payment processing, invoice generation, and tax calculation. Only one address per customer should have this flag set to true.',
    `is_default_shipping` BOOLEAN COMMENT 'Boolean flag indicating whether this is the customers preferred default shipping address. Used for checkout pre-population and Order Management System (OMS) fulfillment routing. Only one address per customer should have this flag set to true.',
    `is_military_address` BOOLEAN COMMENT 'Boolean flag indicating whether this is a military address (APO, FPO, DPO). Military addresses have special handling requirements, customs exemptions, and carrier restrictions. Used for fulfillment routing and compliance.',
    `is_po_box` BOOLEAN COMMENT 'Boolean flag indicating whether this is a PO Box address. Some carriers and products cannot deliver to PO Boxes. Used for fulfillment eligibility checks and carrier selection.',
    `is_verified_by_customer` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has explicitly confirmed this address is correct. Used to reduce failed deliveries and Return Merchandise Authorization (RMA) costs. Set to true after successful delivery or customer confirmation.',
    `last_used_date` DATE COMMENT 'Date when this address was most recently used for an order or transaction. Used for address recency analysis and inactive address cleanup.',
    `latitude` DECIMAL(18,2) COMMENT 'Geocoded latitude coordinate in decimal degrees format. Used for delivery route optimization, last-mile logistics planning, and proximity-based services. Range: -90 to +90.',
    `line_1` STRING COMMENT 'Primary street address line including street number, street name, and unit/apartment/suite number. First line of physical or mailing address.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as building name, floor, department, or c/o information. Optional supplementary address information.',
    `longitude` DECIMAL(18,2) COMMENT 'Geocoded longitude coordinate in decimal degrees format. Used for delivery route optimization, last-mile logistics planning, and proximity-based services. Range: -180 to +180.',
    `nickname` STRING COMMENT 'Customer-defined friendly name for the address (e.g., Home, Office, Moms House, Vacation Home). Used for easy address selection during checkout in Customer Relationship Management (CRM) and e-commerce platforms.',
    `phone_number` STRING COMMENT 'Contact phone number associated with this address for delivery coordination and customer communication. Used by carriers for delivery notifications and issue resolution. May differ from customer primary phone.',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for the address. Used for delivery routing, carrier selection, and service level determination. Format varies by country (e.g., 5-digit ZIP in USA, alphanumeric in Canada/UK).',
    `residential_commercial_flag` STRING COMMENT 'Classification of address as residential (home delivery) or commercial (business delivery). Impacts carrier selection, delivery time windows, signature requirements, and shipping costs. Commercial addresses may have different Service Level Agreement (SLA) options.. Valid values are `residential|commercial|unknown`',
    `serviceable_by_carrier` STRING COMMENT 'Comma-separated list of carrier codes that can service this address (e.g., UPS, FEDEX, USPS, DHL). Determined by Transportation Management System (TMS) based on carrier coverage maps and Service Level Agreement (SLA) capabilities. Used for carrier selection during fulfillment.',
    `state_province` STRING COMMENT 'State, province, or region code or name. Used for tax calculation, shipping cost determination, and regulatory compliance (e.g., CCPA for California addresses).',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier for this address used for sales tax calculation and compliance. Links to tax rate tables in Enterprise Resource Planning (ERP) system. Critical for multi-state/multi-country tax compliance and SOX (Sarbanes-Oxley Act) reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last modified. Used for change tracking, audit trail, and data synchronization across Customer Data Platform (CDP) and downstream systems. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `usage_count` STRING COMMENT 'Total number of times this address has been used across all orders and transactions. Used for address preference analysis and fraud detection (unusually high usage may indicate drop-shipping or fraud).',
    `validation_source` STRING COMMENT 'Name of the address verification service or postal authority used to validate the address (e.g., USPS, Google Maps API, Loqate, Melissa Data, Canada Post). Null if unvalidated.',
    `validation_status` STRING COMMENT 'Status of address verification against postal authority databases. Validated = confirmed deliverable, unvalidated = not yet checked, failed = undeliverable, corrected = standardized by validation service, partial = some components verified.. Valid values are `validated|unvalidated|failed|corrected|partial`',
    CONSTRAINT pk_customer_address PRIMARY KEY(`customer_address_id`)
) COMMENT 'Physical and virtual address records associated with a customer profile. Stores address type (shipping, billing, registered, pickup), address line 1 and 2, city, state/province, postal code, country ISO code, address validation status, geocoded latitude/longitude, is_default_shipping flag, is_default_billing flag, residential vs commercial classification, BOPIS-eligible flag, and address verification source. Supports multi-address customers and international address formats per ISO 3166.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact person. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Contact belongs to an account (B2B); many contacts per account, add FK to associate contact with its owning account.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the parent customer account (typically B2B enterprise account) that this contact is associated with. Enables multi-contact account management.',
    `reports_to_contact_id` BIGINT COMMENT 'Reference to the contact_id of the person this contact reports to within the customer organization. Enables organizational hierarchy mapping and approval escalation workflows.',
    `approval_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount (in account base currency) that this contact is authorized to approve for purchase orders without escalation. Used in B2B purchase approval workflows.',
    `assistant_email` STRING COMMENT 'Email address of the contacts executive assistant. Used for meeting scheduling and communication coordination in high-value B2B accounts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assistant_name` STRING COMMENT 'Name of the contacts executive assistant or administrative support person. Used for scheduling and communication routing in enterprise B2B accounts.',
    `assistant_phone` STRING COMMENT 'Phone number of the contacts executive assistant. Used for urgent communication routing and meeting coordination.',
    `authorization_level` STRING COMMENT 'Level of authorization and permissions granted to the contact within the customer account. Determines purchase approval limits, account management capabilities, and data access rights.. Valid values are `view_only|requester|approver|admin`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Active contacts can receive communications and perform authorized actions; inactive contacts are retained for historical reference but cannot transact.. Valid values are `active|inactive|suspended|pending_verification`',
    `contact_type` STRING COMMENT 'Classification of the contact role within the account structure. Determines routing of specific communication types and approval workflows. [ENUM-REF-CANDIDATE: primary|billing|shipping|technical|procurement|finance|legal — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the system. Used for contact tenure analysis and audit trail.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact was deactivated or marked inactive. Null for active contacts. Used for contact lifecycle analysis and retention reporting.',
    `deactivation_reason` STRING COMMENT 'Free-text explanation of why the contact was deactivated (e.g., left company, role change, duplicate record, customer request). Used for contact churn analysis and data quality improvement.',
    `department` STRING COMMENT 'Department or business unit within the customer organization that the contact belongs to (e.g., Procurement, Finance, Operations, IT). Enables department-level segmentation and targeted communications.',
    `email_address` STRING COMMENT 'Primary email address for the contact. Used for order confirmations, purchase approvals, shipping notifications, and targeted B2B communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive marketing and promotional email communications. Managed under GDPR consent requirements and CAN-SPAM Act compliance.',
    `email_verified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the contacts email address has been verified through a confirmation process. Used for security and communication deliverability assurance.',
    `external_contact_code` STRING COMMENT 'Contact identifier from the source system or external CRM platform. Used for cross-system reconciliation and integration mapping.',
    `first_name` STRING COMMENT 'First name or given name of the contact person. Used for personalized communication and identification within B2B account structures.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this contact is the primary point of contact for the customer account. Primary contacts receive all general account communications and have highest authorization level.',
    `job_title` STRING COMMENT 'Job title or role of the contact within their organization (e.g., Procurement Manager, Finance Director, Shipping Coordinator). Used for routing communications and approvals to the appropriate role.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the contacts most recent login to the customer portal or B2B platform. Used for engagement tracking and inactive contact identification.',
    `last_name` STRING COMMENT 'Last name or family name of the contact person. Combined with first name for full contact identification.',
    `linkedin_profile_url` STRING COMMENT 'URL to the contacts LinkedIn professional profile. Used for B2B relationship management, account intelligence, and professional network mapping.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the contact. Used for SMS notifications, two-factor authentication, and mobile-first communication channels.',
    `phone_number` STRING COMMENT 'Primary phone number for the contact. Used for order clarifications, delivery coordination, and urgent account communications.',
    `phone_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive phone call communications for marketing purposes. Managed under TCPA compliance and do-not-call registry requirements.',
    `phone_verified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the contacts phone number has been verified through SMS or voice confirmation. Used for two-factor authentication and fraud prevention.',
    `preferred_contact_method` STRING COMMENT 'Contacts preferred method of communication for non-urgent account matters. Used to optimize communication delivery and improve contact engagement rates.. Valid values are `email|phone|mobile|sms`',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the contacts preferred language for communications (e.g., EN for English, ES for Spanish, FR for French). Used for localized email templates and customer service routing.. Valid values are `^[A-Z]{2}$`',
    `sms_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive SMS text message communications. Managed under TCPA compliance and GDPR consent requirements.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this contact record (e.g., Customer Data Platform, Salesforce Marketing Cloud, Seller Management Portal). Used for data lineage tracking and system integration management.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts location (e.g., America/New_York, Europe/London). Used for scheduling communications and calls during appropriate business hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was last modified. Used for data freshness tracking and change audit.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual contact person associated with a customer account, primarily used for B2B accounts with multiple authorized contacts (procurement officers, finance contacts, shipping coordinators). Stores contact first name, last name, job title, department, email address, phone number, contact type (primary, billing, shipping, technical), is_primary flag, communication opt-in status, authorization level, and contact status. Enables multi-contact B2B account management, purchase approval routing, and targeted communication delivery to the correct role within an enterprise account.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`household` (
    `household_id` BIGINT COMMENT 'Unique identifier for the household grouping entity. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer profile designated as the primary account holder and decision-maker for the household.',
    `customer_address_id` BIGINT COMMENT 'Reference to the primary residential address shared by household members.',
    `merged_into_household_id` BIGINT COMMENT 'Reference to the target household ID if this household was merged into another household entity.',
    `active_member_count` STRING COMMENT 'Number of customer profiles currently active and associated with this household.',
    `average_order_value` DECIMAL(18,2) COMMENT 'Average order value across all orders placed by household members. Measured in household currency.',
    `cltv_score` DECIMAL(18,2) COMMENT 'Predicted lifetime value of the household unit calculated by aggregating individual member CLTV scores and household-level behavioral patterns. Measured in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary currency used for household transactions and financial calculations.. Valid values are `^[A-Z]{3}$`',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the household has consented to sharing their data with third-party partners for personalization and analytics.',
    `dissolved_date` DATE COMMENT 'Date when the household was dissolved or deactivated, marking the end of the household entity lifecycle.',
    `external_household_code` STRING COMMENT 'Household identifier from external or legacy systems, used for cross-system reconciliation and data integration.',
    `family_plan_eligible` BOOLEAN COMMENT 'Indicates whether the household qualifies for family plan pricing, subscriptions, or bundled offers.',
    `first_order_date` DATE COMMENT 'Date of the first order placed by any household member, marking the households initial transaction.',
    `household_name` STRING COMMENT 'Human-readable name or label assigned to the household unit (e.g., Smith Family, Johnson Household).',
    `household_status` STRING COMMENT 'Current lifecycle state of the household entity indicating operational validity and activity level.. Valid values are `active|inactive|suspended|merged|dissolved`',
    `household_type` STRING COMMENT 'Classification of the household structure indicating the composition and relationship model of members.. Valid values are `single|family|shared|multi_generational|roommate|other`',
    `language_preference` STRING COMMENT 'ISO 639-1 two-letter language code representing the preferred language for household communications and content.. Valid values are `^[a-z]{2}$`',
    `last_order_date` DATE COMMENT 'Date of the most recent order placed by any household member.',
    `loyalty_tier` STRING COMMENT 'Loyalty program tier assigned to the household based on aggregated member activity and spending. Enables household-level benefits and rewards.. Valid values are `bronze|silver|gold|platinum|diamond|vip`',
    `marketing_consent_status` STRING COMMENT 'Household-level consent status for receiving marketing communications, managed under GDPR and CCPA compliance requirements.. Valid values are `opted_in|opted_out|pending|not_provided`',
    `nps_score` STRING COMMENT 'Net Promoter Score calculated at household level based on aggregated member survey responses. Range: -100 to +100.',
    `preferred_communication_channel` STRING COMMENT 'Primary channel through which the household prefers to receive marketing and transactional communications.. Valid values are `email|sms|push|mail|phone`',
    `primary_contact_email` STRING COMMENT 'Primary email address for household-level communications and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for household-level communications and customer service interactions.',
    `return_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of orders returned by household members, calculated as (returned orders / total orders) * 100.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score for the household based on payment history, fraud indicators, and return patterns. Range: 0.00 to 100.00.',
    `segment` STRING COMMENT 'Marketing or analytical segment classification assigned to the household based on behavioral, demographic, and spending patterns.',
    `shared_loyalty_pool_enabled` BOOLEAN COMMENT 'Indicates whether household members can pool and share loyalty points across the household unit.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this household record (e.g., Customer Data Platform, CRM, Order Management System).',
    `timezone` STRING COMMENT 'IANA timezone identifier for the households primary location, used for scheduling and time-sensitive communications.',
    `total_household_gmv` DECIMAL(18,2) COMMENT 'Cumulative gross merchandise value of all orders placed by household members across their lifetime. Measured in USD.',
    `total_member_count` STRING COMMENT 'Total number of customer profiles ever associated with this household, including inactive members.',
    `total_order_count` STRING COMMENT 'Total number of orders placed by all household members across their lifetime.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Household grouping entity that links individual customer profiles into a shared residential unit for B2C customers. Enables household-level analytics, shared loyalty point pooling, family plan eligibility, and household CLTV calculation. Stores household name, household type (single, family, shared), primary account holder profile reference, household address reference, total household GMV, household loyalty tier, household creation date, number of active members, and member profile references with role assignments (primary, spouse, dependent). Critical for personalization and retention strategies targeting household units rather than individuals.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` (
    `corporate_hierarchy_id` BIGINT COMMENT 'Unique identifier for the corporate hierarchy relationship record.',
    `account_id` BIGINT COMMENT 'Reference to the child corporate account in the hierarchy structure. Represents the subsidiary, division, or department entity in the parent-child relationship.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that governs this corporate hierarchy relationship. Used for regulatory reporting, compliance tracking, and legal liability determination per GDPR and SOX requirements.',
    `parent_account_id` BIGINT COMMENT 'Reference to the parent corporate account in the hierarchy structure. Represents the controlling or owning entity in the parent-child relationship.',
    `contact_id` BIGINT COMMENT 'FK to customer.contact',
    `approval_chain_required` BOOLEAN COMMENT 'Indicates whether transactions from the child account require approval escalation through the parent account hierarchy. Used for B2B procurement workflow orchestration and compliance controls.',
    `consolidated_credit_limit` DECIMAL(18,2) COMMENT 'The total credit limit available across the parent-child account relationship. Enables enterprise-wide credit management and risk assessment for B2B procurement and payment terms.',
    `consolidated_invoicing_enabled` BOOLEAN COMMENT 'Flag indicating whether invoices for the child account should be consolidated and sent to the parent account. Enables enterprise billing aggregation and centralized accounts payable processing.',
    `consolidated_spend_limit` DECIMAL(18,2) COMMENT 'The maximum spending threshold allowed across the corporate hierarchy for procurement and purchasing activities. Used for budget control and approval workflow routing in B2B order processing.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the corporate hierarchy relationship record was first created in the system. Used for audit trails, data lineage tracking, and compliance reporting per SOX and GDPR requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for consolidated credit and spend limits. Supports multi-currency B2B account management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when the corporate hierarchy relationship ceases to be active. Nullable for ongoing relationships. Supports historical tracking of organizational restructuring and M&A (Mergers and Acquisitions) activities.',
    `effective_start_date` DATE COMMENT 'The date when the corporate hierarchy relationship becomes active and binding. Used for temporal tracking of organizational structure changes and consolidated reporting periods.',
    `hierarchy_depth` STRING COMMENT 'The numerical level of the child account from the top-level parent in the corporate structure. Used for organizational chart visualization, reporting rollups, and approval chain routing.',
    `hierarchy_level` STRING COMMENT 'The organizational tier of the child account within the corporate structure. Defines the depth and classification of the relationship in the enterprise hierarchy.. Valid values are `group|subsidiary|division|department|cost_center|business_unit`',
    `hierarchy_status` STRING COMMENT 'Current lifecycle state of the corporate hierarchy relationship. Indicates whether the parent-child relationship is currently in effect and operational for business processes.. Valid values are `active|inactive|pending|suspended|terminated`',
    `intercompany_transaction_allowed` BOOLEAN COMMENT 'Indicates whether transactions between parent and child accounts are permitted. Used for transfer pricing controls, intercompany reconciliation, and elimination entries in consolidated financial statements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the corporate hierarchy relationship record was last updated. Used for change tracking, audit trails, and data quality monitoring in enterprise data governance.',
    `notes` STRING COMMENT 'Free-text field for additional information, special terms, or business context related to the corporate hierarchy relationship. Used for documenting unique arrangements, historical context, or operational considerations.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership or control the parent account holds over the child account. Used for consolidated financial reporting, revenue allocation, and determining control thresholds per IFRS and GAAP standards.',
    `relationship_type` STRING COMMENT 'The nature of the corporate relationship between parent and child entities. Defines ownership structure, control level, and legal relationship type for B2B (Business to Business) account management.. Valid values are `wholly_owned|majority_owned|minority_owned|affiliate|joint_venture|franchise`',
    `reporting_rollup_enabled` BOOLEAN COMMENT 'Flag indicating whether financial and operational metrics from the child account should be rolled up into parent account reporting. Enables consolidated KPI (Key Performance Indicator) dashboards and executive analytics.',
    `source_system` STRING COMMENT 'The operational system of record that originated this corporate hierarchy relationship. Typically Customer Data Platform (CDP), ERP (Enterprise Resource Planning), or CRM (Customer Relationship Management). Used for data lineage and integration troubleshooting.',
    `tax_consolidation_group` STRING COMMENT 'Identifier for the tax consolidation group to which this hierarchy relationship belongs. Used for consolidated tax reporting, transfer pricing, and compliance with jurisdiction-specific tax regulations.',
    `volume_discount_eligible` BOOLEAN COMMENT 'Indicates whether the child account qualifies for volume-based pricing discounts based on consolidated purchasing across the corporate hierarchy. Supports B2B pricing strategy and GMV (Gross Merchandise Value) optimization.',
    CONSTRAINT pk_corporate_hierarchy PRIMARY KEY(`corporate_hierarchy_id`)
) COMMENT 'B2B corporate account hierarchy entity representing parent-child relationships between enterprise accounts, subsidiaries, divisions, and cost centers. Stores parent account reference, child account reference, hierarchy level (group, subsidiary, division, department), relationship type, effective start and end dates, consolidated credit limit, consolidated spend limit, and hierarchy status. Enables enterprise account management, consolidated invoicing, volume discount eligibility across corporate structures, and approval chain routing for B2B procurement workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`loyalty_program` (
    `loyalty_program_id` BIGINT COMMENT 'Unique identifier for the loyalty program. Primary key.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller entity that sponsors this loyalty program. Applicable for seller-specific programs.',
    `brand_id` BIGINT COMMENT 'Reference to the brand entity that sponsors or owns this loyalty program. Nullable for platform-wide programs.',
    `applicable_customer_segments` STRING COMMENT 'Comma-separated list or description of customer segments eligible for this loyalty program (e.g., B2C, B2B, premium customers, geographic regions).',
    `auto_enrollment_flag` BOOLEAN COMMENT 'Indicates whether customers are automatically enrolled in this loyalty program upon account creation (True) or must opt-in manually (False).',
    `cashback_percentage` DECIMAL(18,2) COMMENT 'Percentage of purchase amount returned as cashback to the customer. Applicable for cashback and hybrid programs.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this loyalty program record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the loyalty programs monetary transactions and conversions.. Valid values are `^[A-Z]{3}$`',
    `current_enrollment_count` STRING COMMENT 'Current number of customers actively enrolled in this loyalty program.',
    `earn_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base earning rate for this program (e.g., 2.0 means customers earn points at twice the standard rate).',
    `end_date` DATE COMMENT 'The date when the loyalty program terminates. Nullable for open-ended programs.',
    `enrollment_eligibility_rules` STRING COMMENT 'Business rules defining which customer segments or criteria qualify for enrollment in this loyalty program (e.g., geographic restrictions, customer type requirements, minimum purchase thresholds).',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this loyalty program record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty program record was last updated.',
    `marketing_campaign_code` STRING COMMENT 'Code linking this loyalty program to a specific marketing campaign for tracking Return on Ad Spend (ROAS) and Customer Acquisition Cost (CAC).. Valid values are `^[A-Z0-9_]{0,30}$`',
    `max_enrollment_count` STRING COMMENT 'Maximum number of customers allowed to enroll in this loyalty program. Null indicates no enrollment cap.',
    `partner_coalition_flag` BOOLEAN COMMENT 'Indicates whether this loyalty program is part of a coalition with external partner brands (True) or is a standalone program (False).',
    `points_currency_conversion_rate` DECIMAL(18,2) COMMENT 'The conversion rate from loyalty points to base currency (e.g., 100 points = 1 USD). Applicable for points-based and hybrid programs.',
    `points_expiration_period_days` STRING COMMENT 'Number of days after which earned loyalty points expire if not redeemed. Null indicates points do not expire.',
    `privacy_policy_url` STRING COMMENT 'URL link to the privacy policy explaining how customer data is collected, used, and protected within the loyalty program.. Valid values are `^https?://.*$`',
    `program_code` STRING COMMENT 'Unique business identifier code for the loyalty program, used for external references and integrations.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `program_description` STRING COMMENT 'Detailed description of the loyalty program benefits, features, and value proposition for marketing and customer communication.',
    `program_manager_email` STRING COMMENT 'Email address of the program manager for internal contact and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `program_manager_name` STRING COMMENT 'Name of the business owner or manager responsible for this loyalty program.',
    `program_name` STRING COMMENT 'The marketing name of the loyalty program displayed to customers.',
    `program_status` STRING COMMENT 'Current lifecycle status of the loyalty program: active (accepting enrollments and accruals), inactive (not accepting new enrollments), suspended (temporarily paused), draft (under development), or archived (historical record).. Valid values are `active|inactive|suspended|draft|archived`',
    `program_type` STRING COMMENT 'Classification of the loyalty program structure: points-based (earn and redeem points), tier-based (status levels with benefits), cashback (percentage return), subscription (paid membership), hybrid (combination), or coalition (multi-brand partnership).. Valid values are `points_based|tier_based|cashback|subscription|hybrid|coalition`',
    `redemption_minimum_points` STRING COMMENT 'Minimum number of points required before a customer can redeem rewards. Applicable for points-based programs.',
    `start_date` DATE COMMENT 'The date when the loyalty program becomes active and customers can begin enrolling.',
    `subscription_billing_frequency` STRING COMMENT 'Frequency at which subscription fees are charged: monthly, quarterly, annual, or one-time.. Valid values are `monthly|quarterly|annual|one_time`',
    `subscription_fee_amount` DECIMAL(18,2) COMMENT 'Recurring fee amount charged for subscription-based loyalty programs (e.g., annual membership fee).',
    `terms_conditions_url` STRING COMMENT 'URL link to the full terms and conditions document governing the loyalty program, required for regulatory compliance and customer transparency.. Valid values are `^https?://.*$`',
    `tier_threshold_bronze` DECIMAL(18,2) COMMENT 'Minimum points or spend required to achieve bronze tier status. Applicable for tier-based programs.',
    `tier_threshold_gold` DECIMAL(18,2) COMMENT 'Minimum points or spend required to achieve gold tier status. Applicable for tier-based programs.',
    `tier_threshold_platinum` DECIMAL(18,2) COMMENT 'Minimum points or spend required to achieve platinum tier status. Applicable for tier-based programs.',
    `tier_threshold_silver` DECIMAL(18,2) COMMENT 'Minimum points or spend required to achieve silver tier status. Applicable for tier-based programs.',
    CONSTRAINT pk_loyalty_program PRIMARY KEY(`loyalty_program_id`)
) COMMENT 'Master definition of loyalty programs offered on the Ecommerce platform. Stores program name, program type (points-based, tier-based, cashback, subscription), program status, enrollment eligibility rules, points-to-currency conversion rate, tier thresholds, program start date, program end date, sponsoring brand or seller reference, terms and conditions URL, and applicable customer segments. This is the catalog-level definition of loyalty programs, distinct from individual customer enrollment records.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` (
    `loyalty_enrollment_id` BIGINT COMMENT 'Unique identifier for the loyalty program enrollment record. Primary key for this entity.',
    `loyalty_program_id` BIGINT COMMENT 'Unique identifier of the loyalty program in which the customer is enrolled. Supports multiple concurrent loyalty programs.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer enrolled in the loyalty program. Links to the customer master record.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the loyalty membership is set to automatically renew at the end of the term. Applicable for paid or subscription-based loyalty programs.',
    `cancellation_date` DATE COMMENT 'Date when the loyalty enrollment was cancelled. Null if enrollment has never been cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation of the loyalty enrollment, if status is cancelled. Examples include customer request, fraud, inactivity, or program termination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty enrollment record was first created in the system. Used for audit trail and data lineage.',
    `current_points_balance` DECIMAL(18,2) COMMENT 'Current available points balance that the customer can redeem. Represents the net of all earned, redeemed, expired, and adjusted points. This is the real-time spendable loyalty currency balance.',
    `current_tier` STRING COMMENT 'Current tier or level of the customer within the loyalty program hierarchy. Determines benefits, earning rates, and redemption privileges. Common tiers include Bronze, Silver, Gold, Platinum, Diamond, and VIP.. Valid values are `bronze|silver|gold|platinum|diamond|vip`',
    `enrollment_channel` STRING COMMENT 'Channel through which the customer enrolled in the loyalty program. Used for channel attribution and enrollment effectiveness analysis.. Valid values are `web|mobile_app|in_store|call_center|email|social_media`',
    `enrollment_date` DATE COMMENT 'Date when the customer enrolled in the loyalty program. Marks the beginning of the customers loyalty relationship.',
    `enrollment_number` STRING COMMENT 'Human-readable unique enrollment number or membership number assigned to the customer for this loyalty program. Used for customer service and member identification.',
    `enrollment_source_campaign` STRING COMMENT 'Marketing campaign or promotion that drove the customer to enroll in the loyalty program. Used for campaign attribution and enrollment ROI analysis.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the loyalty enrollment. Active indicates the member can earn and redeem points; suspended indicates temporary hold; expired indicates membership lapsed; cancelled indicates voluntary or involuntary termination; pending indicates enrollment awaiting activation.. Valid values are `active|suspended|expired|cancelled|pending`',
    `last_activity_date` DATE COMMENT 'Date of the most recent loyalty activity (earn, redeem, or adjustment). Used for inactivity detection and dormancy rules.',
    `last_earn_date` DATE COMMENT 'Date when the customer last earned loyalty points. Used for engagement scoring, churn prediction, and reactivation campaigns.',
    `last_redeem_date` DATE COMMENT 'Date when the customer last redeemed loyalty points. Used for engagement analysis and redemption behavior modeling.',
    `lifetime_points_earned` DECIMAL(18,2) COMMENT 'Cumulative total of all points earned by the customer since enrollment. Used for tier qualification, lifetime value analysis, and member recognition. This is a monotonically increasing counter.',
    `lifetime_points_expired` DECIMAL(18,2) COMMENT 'Cumulative total of all points that have expired due to inactivity or program rules since enrollment. Used for breakage analysis and financial reconciliation.',
    `lifetime_points_redeemed` DECIMAL(18,2) COMMENT 'Cumulative total of all points redeemed by the customer since enrollment. Used for engagement analysis and redemption behavior modeling.',
    `membership_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the membership fee. Used for multi-currency loyalty programs.. Valid values are `^[A-Z]{3}$`',
    `membership_fee_paid` DECIMAL(18,2) COMMENT 'Total membership fee paid by the customer for enrollment or renewal in the loyalty program. Zero for free programs.',
    `next_tier_gap` DECIMAL(18,2) COMMENT 'Remaining points or spend needed to reach the next tier. Calculated as next_tier_threshold minus current qualifying activity. Used for personalized tier progression campaigns.',
    `next_tier_threshold` DECIMAL(18,2) COMMENT 'Points or spend threshold required to qualify for the next loyalty tier. Used for gamification and tier progression messaging. Null if customer is already at the highest tier.',
    `opt_in_email` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive loyalty program communications via email.',
    `opt_in_marketing` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive marketing communications related to the loyalty program. Supports GDPR and CCPA consent management.',
    `opt_in_push_notification` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive loyalty program push notifications via mobile app.',
    `opt_in_sms` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive loyalty program communications via SMS text messages.',
    `points_expiry_date` DATE COMMENT 'Date when the next batch of points is scheduled to expire. Used for customer communication and expiry alerts. Null if no points are scheduled to expire or program has no expiration policy.',
    `reactivation_date` DATE COMMENT 'Date when a previously suspended or expired enrollment was reactivated. Used for win-back campaign analysis.',
    `referral_code` STRING COMMENT 'Referral code used by the customer during enrollment, if applicable. Links to the referring customer for referral bonus attribution.',
    `suspension_date` DATE COMMENT 'Date when the loyalty enrollment was suspended. Null if enrollment has never been suspended.',
    `suspension_reason` STRING COMMENT 'Reason for suspension of the loyalty enrollment, if status is suspended. Examples include fraud investigation, terms violation, payment failure, or customer request.',
    `tier_expiry_date` DATE COMMENT 'Date when the current tier status expires and the customer must re-qualify or be downgraded. Null for lifetime tiers or programs without tier expiration.',
    `tier_qualification_date` DATE COMMENT 'Date when the customer qualified for their current loyalty tier. Used to track tier tenure and calculate tier anniversary dates.',
    `tier_qualifying_period_end` DATE COMMENT 'End date of the current tier qualification period. After this date, tier status is re-evaluated based on qualifying activity.',
    `tier_qualifying_period_start` DATE COMMENT 'Start date of the current tier qualification period. Used to calculate rolling qualification windows and reset tier progress.',
    `tier_qualifying_spend` DECIMAL(18,2) COMMENT 'Total spend amount that counts toward tier qualification in the current qualification period. Used when tier status is based on spend rather than points earned.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty enrollment record was last updated. Used for audit trail and change tracking.',
    CONSTRAINT pk_loyalty_enrollment PRIMARY KEY(`loyalty_enrollment_id`)
) COMMENT 'Customer enrollment and ongoing loyalty standing for a specific loyalty program. Tracks enrollment date, current tier (Bronze, Silver, Gold, Platinum), tier qualification date, tier expiry date, current points balance, lifetime points earned, lifetime points redeemed, points expiry date, enrollment channel, enrollment status (active, suspended, expired), and next tier threshold gap. Also owns the complete loyalty point transaction history: each transaction records type (earn, redeem, expire, adjust, transfer), points amount, transaction date, triggering order reference, triggering promotion reference, balance before, balance after, expiry date of earned points, transaction status, and reversal reference. Serves as the SSOT for a customers loyalty standing, points balance, and full transaction audit trail supporting dispute resolution and financial reconciliation of loyalty currency.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the customer segment. Primary key.',
    `relevance_config_id` BIGINT COMMENT 'Foreign key linking to search.relevance_config. Business justification: Enables segment‑specific search relevance tuning used in personalized search results and segment performance reports.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Needed for segment‑to‑category targeting: segments are defined by the product categories they are intended to reach in marketing reports.',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment was first activated and made available for campaign targeting and personalization. Null if segment has never been activated.',
    `applicable_channels` STRING COMMENT 'Comma-separated list of marketing and engagement channels where this segment is intended to be used (e.g., email, SMS, push notification, display ads, social media, in-app messaging). [ENUM-REF-CANDIDATE: email|sms|push|display|social|in_app|direct_mail|call_center|web_personalization|mobile_app — promote to reference product]',
    `assignment_method` STRING COMMENT 'Method used to assign customers to this segment: rule_based (criteria-driven), ml_model (machine learning prediction), manual (curated list), hybrid (combination of methods).. Valid values are `rule_based|ml_model|manual|hybrid`',
    `baseline_metric_value` DECIMAL(18,2) COMMENT 'Baseline or benchmark value for the performance_metric_kpi, used to measure segment lift and incremental impact. Established at segment creation or from control group analysis.',
    `business_owner` STRING COMMENT 'Name or identifier of the individual business owner accountable for segment strategy, performance, and compliance.',
    `ccpa_compliant_flag` BOOLEAN COMMENT 'Indicates whether this segment definition and processing logic comply with CCPA requirements for consumer rights, opt-out mechanisms, and data sale restrictions (True) or require review (False).',
    `consent_purpose` STRING COMMENT 'Specific consent purpose or legal basis for processing customer data in this segment (e.g., marketing communications, personalized recommendations, analytics). Required when consent_required_flag is True.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer consent is required for inclusion in this segment under GDPR, CCPA, or other privacy regulations (True) or if legitimate interest applies (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment definition was first created in the Customer Data Platform. Immutable audit field.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment was deactivated or archived. Null if segment is currently active or has never been deactivated.',
    `exclusion_rules` STRING COMMENT 'Logical expression defining criteria for excluding customers from this segment (e.g., opted out of marketing, fraudulent account, employee account, test account).',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether this segment definition and processing logic comply with GDPR requirements for lawful processing, data minimization, and purpose limitation (True) or require review (False).',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent segment membership recalculation and update. Used to track data freshness and SLA compliance.',
    `member_count` BIGINT COMMENT 'Current number of active customer profiles assigned to this segment. Updated with each segment refresh.',
    `ml_model_reference` STRING COMMENT 'Reference identifier or URI to the ML model used for predictive or propensity-based segment assignment (e.g., churn prediction model, next-best-offer model). Null for rule-based segments.',
    `modified_by` STRING COMMENT 'User identifier or email of the person who last modified the segment definition. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the segment definition (name, rules, configuration). Updated with each change.',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the next scheduled segment membership recalculation. Null for on-demand or real-time segments.',
    `notes` STRING COMMENT 'Free-text field for additional context, business rationale, testing results, or operational notes about the segment. Used for knowledge sharing and documentation.',
    `overlap_allowed_flag` BOOLEAN COMMENT 'Indicates whether customers can be members of this segment and other segments simultaneously (True) or if this segment enforces mutual exclusivity (False).',
    `owning_team` STRING COMMENT 'Business team or department responsible for defining, maintaining, and governing this segment (e.g., Marketing, CRM, Analytics, Retention).',
    `performance_metric_kpi` STRING COMMENT 'Primary KPI used to measure segment performance and business impact (e.g., CVR, ROAS, CLTV, NPS, churn rate, AOV). Used for segment effectiveness tracking and optimization.',
    `priority` STRING COMMENT 'Business priority level for this segment, used for resource allocation, refresh scheduling, and conflict resolution when customers qualify for multiple segments.. Valid values are `critical|high|medium|low`',
    `refresh_frequency` STRING COMMENT 'Cadence at which segment membership is recalculated and updated: real_time (streaming), hourly, daily, weekly, monthly, on_demand (manual trigger).. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `retention_period_days` STRING COMMENT 'Number of days that segment membership records are retained for compliance, audit, and historical analysis purposes before archival or deletion.',
    `rule_expression` STRING COMMENT 'Logical expression or SQL-like query defining the segment membership criteria for rule-based segments (e.g., AOV > 200 AND purchase_count >= 3 AND last_purchase_days <= 90). Null for ML-model-based segments.',
    `segment_description` STRING COMMENT 'Detailed business description of the segment purpose, target audience characteristics, and intended use cases (e.g., marketing campaigns, personalization, retention programs).',
    `segment_name` STRING COMMENT 'Human-readable name of the customer segment (e.g., High-Value Shoppers, Cart Abandoners, Loyal Customers).',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment: active (in use), inactive (paused), draft (under development), archived (historical reference), deprecated (replaced by newer version).. Valid values are `active|inactive|draft|archived|deprecated`',
    `segment_type` STRING COMMENT 'Classification of the segment based on the segmentation methodology: behavioral (purchase patterns, engagement), demographic (age, gender, income), RFM (Recency Frequency Monetary), CLTV (Customer Lifetime Value), lifecycle (new, active, at-risk, churned), geographic (location-based), or psychographic (interests, values). [ENUM-REF-CANDIDATE: behavioral|demographic|rfm|cltv|lifecycle|geographic|psychographic — 7 candidates stripped; promote to reference product]',
    `tags` STRING COMMENT 'Comma-separated list of user-defined tags or labels for segment categorization, search, and filtering (e.g., holiday_campaign, high_value, retention, test_segment).',
    `target_size` BIGINT COMMENT 'Intended or target number of members for this segment, used for capacity planning and campaign sizing. Null if no target is defined.',
    `use_case` STRING COMMENT 'Primary business use case or campaign objective for this segment (e.g., acquisition, retention, cross-sell, upsell, win-back, personalization, A/B testing, churn prevention).',
    `version` STRING COMMENT 'Version identifier for the segment definition, enabling tracking of rule changes, A/B testing variants, and historical comparison (e.g., v1.0, v2.3, 2024-Q1).',
    `created_by` STRING COMMENT 'User identifier or email of the person who created the segment definition. Used for audit trail and accountability.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Segmentation entity defining named customer segments and managing complete membership lifecycle. Stores segment definition: name, type (behavioral, demographic, RFM-based, CLTV-based, lifecycle stage), rule expression or ML model reference, segment size, creation date, last refresh date, owning team, status, and applicable channels. Owns membership records: each membership links a profile to a segment with temporal window (start/end dates), status (active, expired), assignment method (rule-based, manual, ML-model), confidence score for ML assignments, and segment version at assignment time. Segments are managed by the Customer Data Platform and consumed by Marketing Automation. Supports point-in-time membership queries, A/B testing audience construction, segment overlap analysis, and version tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique identifier for the customer preference record. Primary key.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who owns this preference. Links to the customer master record in the Customer Data Platform.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that triggered or is associated with this preference capture. Nullable if the preference was not captured in the context of a specific campaign. Links to campaign performance analysis.',
    `parent_preference_id` BIGINT COMMENT 'Identifier of the parent preference record if this preference is a channel-specific override of a global preference. Nullable for top-level global preferences. Enables hierarchical preference inheritance.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Supports personalized recommendation engine: captures a customers explicit preference for a specific catalog item.',
    `channel` STRING COMMENT 'The channel through which this preference applies or was captured. Enables channel-specific preference management and omnichannel consent orchestration.. Valid values are `web|mobile_app|email|sms|call_center|in_store`',
    `consent_text` STRING COMMENT 'The full text of the consent statement or privacy notice that was presented to the customer at the time of preference capture. Stored for regulatory audit and proof of consent.',
    `consent_version` STRING COMMENT 'The version identifier of the consent text or privacy policy that the customer agreed to when setting this preference. Enables audit trail of consent changes over time.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this preference record was first created in the system. Establishes the initial consent capture time for regulatory compliance and audit purposes.',
    `data_retention_period_days` STRING COMMENT 'Number of days this preference record and associated consent data must be retained for regulatory compliance and audit purposes. Used to enforce data retention policies and right to erasure.',
    `device_code` STRING COMMENT 'Unique identifier of the device from which the preference was set. Used for device-level consent tracking and cross-device preference synchronization.',
    `double_opt_in_confirmed` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has confirmed their opt-in preference through a double opt-in process (e.g., email confirmation link). Required for certain marketing channels under GDPR.',
    `double_opt_in_timestamp` TIMESTAMP COMMENT 'The timestamp when the customer confirmed their opt-in preference through the double opt-in process. Nullable if double opt-in is not required or not yet completed.',
    `effective_date` DATE COMMENT 'The date from which this preference becomes active and enforceable. Used for time-bound consent management and regulatory compliance reporting.',
    `expiry_date` DATE COMMENT 'The date on which this preference expires and is no longer valid. Nullable for preferences with indefinite duration. Supports time-limited consent and periodic re-consent workflows.',
    `frequency_cap` STRING COMMENT 'Maximum number of communications allowed per time period for this preference category. Used to enforce customer-specified communication frequency limits and prevent over-messaging.',
    `frequency_period` STRING COMMENT 'The time period over which the frequency cap applies. Defines the window for counting communications against the frequency cap.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `hash` STRING COMMENT 'Cryptographic hash of the preference record content. Used for tamper detection, data integrity verification, and proof of consent immutability for regulatory audit.',
    `ip_address` STRING COMMENT 'The IP address from which the preference was set. Captured for fraud detection, audit trail, and proof of consent. May be considered PII under GDPR in certain jurisdictions.',
    `is_global_preference` BOOLEAN COMMENT 'Boolean flag indicating whether this preference applies globally across all channels and touchpoints, or is specific to a single channel. Supports hierarchical preference management.',
    `jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the legal jurisdiction under which this preference was captured. Used for jurisdiction-specific consent rules and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the consent was presented and captured. Supports multilingual consent management and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified this preference record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this preference record was last updated. Critical for audit trail, consent history tracking, and regulatory compliance reporting.',
    `legal_basis` STRING COMMENT 'The GDPR Article 6 legal basis under which this preference and associated data processing is justified. Critical for GDPR compliance and regulatory audit.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `notes` STRING COMMENT 'Free-text field for additional notes or context about this preference record. Used by customer service agents to document special circumstances or customer requests.',
    `preference_category` STRING COMMENT 'The category or type of preference being captured. Defines the communication channel or data usage purpose for which consent is being managed.. Valid values are `email_marketing|sms_marketing|push_notification|personalized_recommendations|third_party_data_sharing|cookie_consent`',
    `preference_source` STRING COMMENT 'The origin or method by which this preference was captured. Indicates whether the preference was set by the customer directly, by a customer service agent, imported from an external system, or defaulted by the system.. Valid values are `customer_self_service|agent_set|import|system_default|regulatory_requirement`',
    `preference_status` STRING COMMENT 'Current lifecycle status of this preference record. Indicates whether the preference is currently in effect, has expired, been superseded by a newer preference, or revoked by the customer.. Valid values are `active|expired|superseded|revoked`',
    `preference_value` DECIMAL(18,2) COMMENT 'The explicit choice made by the customer for this preference category. Indicates whether the customer has consented to or declined the specific communication or data usage.',
    `right_to_be_forgotten_requested` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has exercised their GDPR Article 17 right to erasure (right to be forgotten) for this preference and associated data. Triggers data deletion workflows.',
    `right_to_be_forgotten_timestamp` TIMESTAMP COMMENT 'The timestamp when the customer requested their right to be forgotten. Nullable if no such request has been made. Used for compliance tracking and audit trail.',
    `score` DECIMAL(18,2) COMMENT 'Calculated score representing the strength or confidence of this preference based on customer behavior, engagement history, and preference consistency. Used for predictive personalization and preference inference.',
    `suppression_category` STRING COMMENT 'Categorical classification of the suppression reason. Enables structured analysis of opt-out patterns and compliance reporting.. Valid values are `customer_request|regulatory_requirement|bounce|complaint|unsubscribe|data_quality`',
    `suppression_reason` STRING COMMENT 'Free-text field capturing the reason why a customer opted out or was suppressed from communications. Used for customer service insights and preference analysis.',
    `third_party_sharing_partners` STRING COMMENT 'Comma-separated list of third-party partner identifiers with whom the customer has consented to share their data. Used for granular third-party data sharing consent management under GDPR and CCPA.',
    `user_agent` STRING COMMENT 'The user agent string of the browser or application from which the preference was set. Provides technical context for audit and troubleshooting.',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Customer preference and communication opt-in/opt-out record capturing explicit customer choices for personalization, notifications, and marketing communications. Stores preference category (email marketing, SMS, push notification, personalized recommendations, third-party data sharing, cookie consent), preference value (opted-in, opted-out, not-set), channel, preference source (customer self-service, agent-set, import), effective date, expiry date, and last updated timestamp. GDPR and CCPA compliance anchor — this is the SSOT for consent and preference management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`consent_event` (
    `consent_event_id` BIGINT COMMENT 'Unique identifier for each consent event record. Primary key for the consent event log.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who performed the consent action. Links to the customer master record.',
    `parent_consent_event_id` BIGINT COMMENT 'Reference to a previous consent event that this event modifies or supersedes. Enables tracking of consent change chains and audit trail reconstruction.',
    `collection_method` STRING COMMENT 'Channel or interface through which the consent event was captured. Identifies the touchpoint where the customer interacted with consent management.. Valid values are `web-form|mobile-app|call-center|email-link|in-store-kiosk|api`',
    `communication_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the language in which the consent was presented and captured. Ensures consent was obtained in the customers preferred language.. Valid values are `^[a-z]{2}$`',
    `consent_category` STRING COMMENT 'Category of consent or preference being managed. Defines the specific processing purpose or communication channel covered by this consent event.. Valid values are `marketing-email|marketing-sms|marketing-push|personalization|analytics|third-party-sharing`',
    `consent_scope` STRING COMMENT 'Geographic or operational scope to which this consent applies. Defines the boundaries of consent applicability across different jurisdictions or business units.. Valid values are `global|regional|country-specific|channel-specific`',
    `consent_text` STRING COMMENT 'The exact consent language or terms that were displayed to the customer at the time of consent. Provides evidence of what the customer agreed to for regulatory audits.',
    `consent_version` STRING COMMENT 'Version identifier of the consent policy or terms and conditions that were presented to the customer at the time of this event. Enables tracking of policy changes over time.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this consent event record was first created in the data platform. Used for data lineage and audit trail purposes.',
    `customer_email` STRING COMMENT 'Email address of the customer at the time of the consent event. Captured for verification and communication purposes in consent lifecycle management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_retention_period_days` STRING COMMENT 'Number of days that data will be retained under this consent. Used to enforce data minimization principles and automated data deletion policies.',
    `device_code` STRING COMMENT 'Unique identifier of the device (mobile, tablet, desktop) from which the consent event was initiated. Used for cross-device consent tracking and fraud prevention.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the consent event occurred, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). This is the authoritative timestamp for regulatory audit trails.',
    `event_type` STRING COMMENT 'Type of consent event that occurred. Categorizes the nature of the customers action for regulatory reporting and lifecycle tracking.. Valid values are `consent-given|consent-withdrawn|consent-updated|data-deletion-requested|data-portability-requested|preference-updated`',
    `expiration_date` DATE COMMENT 'Date when this consent is set to expire and require renewal. Used for time-bound consent management and automated re-consent workflows.',
    `geolocation_country` STRING COMMENT 'Three-letter ISO country code representing the geographic location from which the consent event originated. Used for jurisdiction-specific compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `geolocation_region` STRING COMMENT 'State, province, or region from which the consent event originated. Provides additional geographic context for jurisdiction-specific privacy laws (e.g., CCPA for California).',
    `ip_address` STRING COMMENT 'Internet Protocol address of the device from which the consent event was initiated. Used for fraud detection and regulatory evidence of consent origin.',
    `is_minor` BOOLEAN COMMENT 'Indicates whether the customer was identified as a minor (under age of consent) at the time of this event. Critical for GDPR Article 8 and COPPA compliance.',
    `legal_basis` STRING COMMENT 'The lawful basis under which personal data processing is justified for this consent event. Required for GDPR Article 6 compliance and regulatory reporting.. Valid values are `consent|contract|legitimate-interest|legal-obligation|vital-interest|public-task`',
    `new_value` DECIMAL(18,2) COMMENT 'The consent status after this event was applied. Represents the current state resulting from the customers action.',
    `notes` STRING COMMENT 'Free-text notes or comments associated with this consent event. May include customer service representative notes for call center-originated events or system-generated messages.',
    `opt_out_sale_flag` BOOLEAN COMMENT 'Indicates whether the customer has exercised their right to opt out of the sale of personal information under CCPA. Must be honored across all business processes.',
    `parental_consent_required` BOOLEAN COMMENT 'Indicates whether parental or guardian consent was required for this event due to the customer being a minor. Used for COPPA and GDPR Article 8 compliance tracking.',
    `parental_consent_verified` BOOLEAN COMMENT 'Indicates whether parental or guardian consent was successfully verified for this event. Critical for processing consent events for minors under COPPA and GDPR.',
    `prior_value` DECIMAL(18,2) COMMENT 'The consent status before this event occurred. Captures the previous state to enable audit trail reconstruction and change tracking.',
    `processing_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the consent event was fully processed and applied across all relevant systems. Used to measure compliance with GDPRs one-month response requirement.',
    `processing_purpose` STRING COMMENT 'Detailed description of the specific purpose for which personal data will be processed under this consent. Must be explicit and granular per GDPR requirements.',
    `processing_status` STRING COMMENT 'Current processing status of the consent event. Tracks whether the event has been successfully applied to downstream systems and customer profiles.. Valid values are `pending|processed|failed|cancelled`',
    `session_code` STRING COMMENT 'Unique identifier for the user session during which the consent event occurred. Enables correlation with other user actions in the same session for behavioral analysis.',
    `source_system` STRING COMMENT 'Name or identifier of the system that originated this consent event record. Identifies the operational system of record for data lineage and troubleshooting.',
    `third_party_sharing_allowed` BOOLEAN COMMENT 'Indicates whether the customer has consented to sharing their personal data with third parties. Critical for CCPA Do Not Sell compliance and GDPR Article 6 lawful basis.',
    `user_agent` STRING COMMENT 'Browser or application user agent string at the time of consent. Provides technical context about the device and software used for the consent action.',
    `verification_method` STRING COMMENT 'Method used to verify the identity of the customer before processing the consent event. Critical for data deletion and portability requests to prevent fraud.. Valid values are `email-verification|sms-otp|two-factor-auth|none`',
    `verification_status` STRING COMMENT 'Status of identity verification for this consent event. Indicates whether the customers identity was successfully confirmed before processing the request.. Valid values are `verified|pending|failed|not-required`',
    CONSTRAINT pk_consent_event PRIMARY KEY(`consent_event_id`)
) COMMENT 'Immutable audit log of every consent change event for a customer, required for GDPR Article 7 and CCPA compliance. Stores event type (consent-given, consent-withdrawn, consent-updated, data-deletion-requested, data-portability-requested), consent category, prior value, new value, event timestamp, collection method (web form, mobile app, call center, email link), IP address at time of consent, user agent string, legal basis (legitimate interest, contract, consent), and processing purpose. This is the regulatory evidence trail for consent lifecycle.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`cltv_score` (
    `cltv_score_id` BIGINT COMMENT 'Unique identifier for the CLTV scoring record. Primary key for this operational scoring entity that drives real-time personalization and retention workflows.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer for whom this CLTV score is calculated. Links to the unified customer profile in the Customer Data Platform.',
    `aov_contribution` DECIMAL(18,2) COMMENT 'Average monetary value per order placed by this customer. Key input to CLTV calculation and used to identify high-ticket customers for upsell opportunities.',
    `churn_probability_score` DECIMAL(18,2) COMMENT 'Predicted likelihood that this customer will stop purchasing within the next 90 days. Expressed as a probability between 0 and 1. Scores above 0.7 trigger retention campaigns.',
    `cltv_tier` STRING COMMENT 'Categorical segmentation of customer value. High-value customers receive premium service and retention offers; at-risk customers trigger win-back campaigns; dormant customers enter re-engagement workflows.. Valid values are `high-value|mid-value|low-value|at-risk|new|dormant`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence level of the CLTV prediction, expressed as a probability between 0 and 1. Higher values indicate more reliable predictions based on sufficient historical data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CLTV score record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this record. Ensures correct interpretation of CLTV amounts in multi-currency environments.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Business segment classification based on CLTV tier, RFM scores, and behavioral patterns. Drives differentiated marketing strategies and service levels.. Valid values are `vip|loyal|promising|new|at-risk|lost`',
    `days_since_first_order` STRING COMMENT 'Number of days elapsed since the customer placed their first order. Represents customer tenure and is used to calculate customer lifetime metrics.',
    `days_since_last_order` STRING COMMENT 'Number of days elapsed since the customer placed their most recent order. Critical input to recency scoring and churn prediction models.',
    `frequency_score` STRING COMMENT 'RFM frequency component: score from 1 to 5 representing how often the customer purchases. 5 = most frequent, 1 = least frequent. Part of the RFM composite scoring model.',
    `historical_cltv` DECIMAL(18,2) COMMENT 'Actual cumulative revenue generated by this customer to date. Represents realized value from all completed orders and transactions.',
    `model_features_used` STRING COMMENT 'Comma-separated list of feature names used by the CLTV model for this customer. Enables model explainability and debugging of score anomalies.',
    `model_version` STRING COMMENT 'Version identifier of the CLTV prediction model used to calculate this score. Enables model performance tracking and A/B testing of scoring algorithms.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `monetary_score` STRING COMMENT 'RFM monetary component: score from 1 to 5 representing how much the customer spends. 5 = highest spender, 1 = lowest spender. Part of the RFM composite scoring model.',
    `next_recalculation_date` DATE COMMENT 'Scheduled date for the next CLTV score refresh. Ensures scores remain current and reflect recent customer behavior. Typically set to 30, 60, or 90 days from calculation date.',
    `predicted_cltv_12m` DECIMAL(18,2) COMMENT 'Forecasted revenue expected from this customer over the next 12 months. Used for short-term marketing budget allocation and campaign targeting.',
    `predicted_cltv_36m` DECIMAL(18,2) COMMENT 'Forecasted revenue expected from this customer over the next 36 months. Used for long-term strategic planning and customer segment investment decisions.',
    `preferred_category` STRING COMMENT 'Product category with the highest purchase frequency or spend for this customer. Used for personalized product recommendations and targeted marketing campaigns.',
    `purchase_frequency_score` DECIMAL(18,2) COMMENT 'Normalized score representing how often this customer makes purchases compared to the customer base average. Higher scores indicate more frequent buyers.',
    `recency_score` STRING COMMENT 'RFM recency component: score from 1 to 5 representing how recently the customer made a purchase. 5 = most recent, 1 = least recent. Part of the RFM composite scoring model.',
    `rfm_composite_score` STRING COMMENT 'Three-digit RFM score combining recency, frequency, and monetary scores. Example: 555 represents the best customers (recent, frequent, high-value). Used for customer segmentation and targeting.. Valid values are `^[1-5][1-5][1-5]$`',
    `score_calculation_date` DATE COMMENT 'Date when this CLTV score was calculated. Enables tracking of score changes over time and ensures users understand the freshness of the prediction.',
    `score_status` STRING COMMENT 'Current lifecycle status of this CLTV score record. Active scores are used in real-time decisioning; expired scores trigger recalculation workflows.. Valid values are `active|expired|pending_recalculation|archived`',
    `total_orders_count` STRING COMMENT 'Total number of orders placed by this customer to date. Used as a key input to frequency scoring and customer lifecycle stage determination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CLTV score record was last modified. Tracks the most recent change to any field in the record for change data capture and audit purposes.',
    CONSTRAINT pk_cltv_score PRIMARY KEY(`cltv_score_id`)
) COMMENT 'Customer Lifetime Value (CLTV) scoring record capturing the calculated and predicted value of a customer relationship. Stores CLTV model version, historical CLTV (actual spend to date), predicted CLTV (12-month and 36-month horizon), CLTV tier (high-value, mid-value, low-value, at-risk), AOV contribution, purchase frequency score, churn probability score, recency score, frequency score, monetary score (RFM composite), score calculation date, and next recalculation date. This is an operational scoring record, not an analytics aggregate — it drives real-time personalization and retention workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`nps_response` (
    `nps_response_id` BIGINT COMMENT 'Unique identifier for the NPS survey response record.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer who submitted this NPS response.',
    `agent_id` BIGINT COMMENT 'Reference to the customer service agent or account manager who handled the follow-up action for this response.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign or survey program that this response belongs to. Used for cohort analysis and A/B testing.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Links NPS feedback to the purchased product, enabling product‑level sentiment analysis in the NPS reporting dashboard.',
    `anonymized_flag` BOOLEAN COMMENT 'Indicates whether this response has been anonymized (customer identifier removed) for privacy compliance or public reporting.',
    `classification` STRING COMMENT 'Customer classification based on NPS score: promoter (9-10), passive (7-8), detractor (0-6).. Valid values are `promoter|passive|detractor`',
    `consent_given_flag` BOOLEAN COMMENT 'Indicates whether the customer provided explicit consent for their feedback to be used for marketing, testimonials, or case studies.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the customers location at time of response.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment classification at the time of survey (e.g., VIP, regular, new, at-risk). Used for segment-level NPS analysis.',
    `customer_tenure_days` STRING COMMENT 'Number of days the customer has been active with the company at the time of survey response. Used to correlate NPS with customer lifecycle stage.',
    `device_type` STRING COMMENT 'Type of device used by the customer to complete the survey: desktop, mobile, tablet, or unknown.. Valid values are `desktop|mobile|tablet|unknown`',
    `follow_up_action_taken` STRING COMMENT 'Action taken in response to customer feedback: none (no action needed), contacted (customer reached out to), resolved (issue addressed), escalated (sent to management), pending (awaiting action).. Valid values are `none|contacted|resolved|escalated|pending`',
    `follow_up_date` DATE COMMENT 'Date when follow-up action was completed or customer was contacted regarding their feedback.',
    `follow_up_notes` STRING COMMENT 'Internal notes documenting the follow-up action taken, customer conversation summary, and resolution details. Business-confidential operational data.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether this response requires follow-up action from customer service or management (typically true for detractors with critical feedback).',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the survey was presented and response was submitted.. Valid values are `^[A-Z]{3}$`',
    `nps_score` STRING COMMENT 'Customer rating on 0-10 scale indicating likelihood to recommend the company to others. 0 = not at all likely, 10 = extremely likely.',
    `previous_nps_score` STRING COMMENT 'The customers most recent prior NPS score before this response. Used to track individual customer sentiment trends and score changes.',
    `response_date` DATE COMMENT 'Date when the customer submitted their NPS response.',
    `response_status` STRING COMMENT 'Status of the survey response: completed (full response received), partial (started but not finished), bounced (delivery failed), opted_out (customer declined), expired (survey window closed).. Valid values are `completed|partial|bounced|opted_out|expired`',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Time elapsed in hours between survey send and customer response submission. Used to measure survey engagement speed.',
    `response_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the customer submitted their NPS response.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'AI-derived sentiment analysis score of the verbatim comment text, ranging from -1.0 (very negative) to +1.0 (very positive). Generated by natural language processing engine.',
    `sentiment_topics` STRING COMMENT 'Comma-separated list of topics or themes extracted from verbatim comment via natural language processing (e.g., delivery_speed, product_quality, customer_service, pricing).',
    `survey_channel` STRING COMMENT 'Channel through which the NPS survey was delivered and completed: email, in-app notification, SMS, web intercept, IVR (Interactive Voice Response), or post-purchase embedded.. Valid values are `email|in_app|sms|web|ivr|post_purchase`',
    `survey_send_date` DATE COMMENT 'Date when the NPS survey invitation was sent to the customer.',
    `survey_send_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the NPS survey invitation was sent to the customer.',
    `survey_type` STRING COMMENT 'Type of NPS survey administered: transactional NPS (triggered by specific event), relational NPS (periodic relationship health check), onboarding, post-purchase, post-support, or annual.. Valid values are `transactional|relational|onboarding|post_purchase|post_support|annual`',
    `survey_version` STRING COMMENT 'Version identifier of the survey template used. Tracks survey design changes over time for longitudinal analysis.',
    `triggering_event_code` STRING COMMENT 'Identifier of the specific business event that triggered this survey (e.g., order number, return RMA number, support case ID). Format varies by event type.',
    `triggering_event_type` STRING COMMENT 'Type of business event that triggered this transactional NPS survey: order fulfillment, return processing, support case closure, delivery completion, account creation, or subscription renewal.. Valid values are `order|return|support_case|delivery|account_creation|subscription_renewal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was last modified (e.g., follow-up action added, sentiment score updated).',
    `verbatim_comment` STRING COMMENT 'Free-text customer feedback explaining the reason for their NPS score. May contain sensitive customer opinions and business-confidential feedback.',
    CONSTRAINT pk_nps_response PRIMARY KEY(`nps_response_id`)
) COMMENT 'Net Promoter Score (NPS) survey response record capturing individual customer feedback events. Stores survey type (transactional NPS, relational NPS), NPS score (0-10), promoter/passive/detractor classification, verbatim comment text, survey channel (email, in-app, SMS, post-purchase), triggering event reference (order, return, support case), survey send date, response date, follow-up action taken, follow-up agent reference, and response status. SSOT for customer satisfaction measurement and NPS program management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`wishlist` (
    `wishlist_id` BIGINT COMMENT 'Unique identifier for the wishlist. Primary key.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer who owns this wishlist. Links to the customer master record in the Customer Data Platform.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was archived by the customer or system. Null if never archived. Supports lifecycle reporting and data retention policies.',
    `conversion_count` STRING COMMENT 'Number of items from this wishlist that have been purchased by the owner or gift contributors. Measures wishlist effectiveness and purchase intent conversion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was first created by the customer. Immutable. Used for lifecycle analytics and customer engagement measurement.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this wishlist (e.g., USD, EUR, GBP). Supports multi-currency e-commerce operations.. Valid values are `^[A-Z]{3}$`',
    `deleted_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was soft-deleted. Null if active. Supports GDPR right-to-erasure and data retention compliance. Hard deletion occurs after retention period.',
    `event_date` DATE COMMENT 'Target date for gift registries (wedding date, baby due date, birthday). Used to trigger expiration logic and prioritize gift-giving urgency. Null for non-event wishlists.',
    `expiry_date` DATE COMMENT 'Date when the wishlist automatically transitions to expired status. Typically set for gift registries (e.g., 90 days post-event). Null for permanent wishlists.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this is the customers default wishlist. When a customer adds an item without specifying a wishlist, it goes to the default. Only one wishlist per customer can be default.',
    `item_count` STRING COMMENT 'Total number of active line items currently in the wishlist. Excludes removed or purchased items. Updated in real-time as items are added or removed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist metadata (name, type, visibility, preferences) was last updated. Excludes line item changes. Used for audit and sync purposes.',
    `last_viewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer last opened or viewed this wishlist. Used for engagement scoring and re-engagement campaign targeting.',
    `notes` STRING COMMENT 'Free-form internal notes or metadata about the wishlist. May include customer service annotations, special handling instructions, or system-generated insights. Not visible to customer.',
    `notification_back_in_stock_enabled` BOOLEAN COMMENT 'Customer preference flag indicating whether to send notifications when out-of-stock items in this wishlist become available again. Drives conversion from latent demand.',
    `notification_event_reminder_enabled` BOOLEAN COMMENT 'Customer preference flag for gift registries indicating whether to send reminders as the event date approaches. Helps drive gift purchases from registry contributors.',
    `notification_price_drop_enabled` BOOLEAN COMMENT 'Customer preference flag indicating whether to send notifications when any item in this wishlist experiences a price reduction. Supports re-engagement campaigns.',
    `priority_rank` STRING COMMENT 'Customer-assigned priority ranking for this wishlist relative to other wishlists owned by the same customer. Lower numbers indicate higher priority. Used for personalization and recommendation engines.',
    `privacy_consent_marketing` BOOLEAN COMMENT 'Customer consent flag indicating permission to use wishlist data for personalized marketing campaigns (price drop alerts, recommendations, promotions). Required under GDPR and CCPA.',
    `privacy_consent_sharing` BOOLEAN COMMENT 'Customer consent flag indicating explicit permission to share wishlist data with third parties (e.g., gift registry partners, social media). Required under GDPR and CCPA.',
    `registry_completion_percentage` DECIMAL(18,2) COMMENT 'For gift registries, the percentage of items that have been purchased by contributors. Calculated as (purchased_items / total_items) * 100. Null for non-registry wishlists.',
    `share_count` STRING COMMENT 'Number of times the wishlist sharing URL has been generated or distributed. Tracks viral/social engagement for gift registries.',
    `sharing_token` STRING COMMENT 'Secure token embedded in sharing URL for access control. Prevents unauthorized access to shared wishlists. Regenerated if sharing is disabled and re-enabled.',
    `sharing_url` STRING COMMENT 'Unique shareable URL for gift registries and shared wishlists. Enables customers to distribute wishlist access to friends and family without requiring account login.',
    `source_channel` STRING COMMENT 'Channel through which the wishlist was originally created (web browser, mobile app, API integration, customer service agent). Used for channel attribution and UX optimization.. Valid values are `web|mobile_app|tablet_app|api|customer_service`',
    `source_device_type` STRING COMMENT 'Device type used when the wishlist was created. Supports device-specific personalization and responsive design optimization.. Valid values are `desktop|mobile|tablet|unknown`',
    `total_current_value` DECIMAL(18,2) COMMENT 'Sum of all item prices at current market rates. Recalculated nightly or on-demand. Enables price drop alerts and conversion optimization. Currency is USD unless otherwise specified.',
    `total_value_at_save` DECIMAL(18,2) COMMENT 'Sum of all item prices at the time they were added to the wishlist. Provides baseline for price change tracking and demand forecasting. Currency is USD unless otherwise specified.',
    `view_count_by_others` STRING COMMENT 'Number of times the wishlist has been viewed by users other than the owner (gift contributors, shared link recipients). Measures gift registry engagement.',
    `visibility` STRING COMMENT 'Access control setting for the wishlist. Private: only owner can view; Public: discoverable by others; Shared Link: accessible via unique URL.. Valid values are `private|public|shared_link`',
    `wishlist_description` STRING COMMENT 'Optional customer-provided description or notes about the wishlist purpose, occasion, or preferences. Supports gift registry messaging and personalization.',
    `wishlist_name` STRING COMMENT 'Customer-defined name for the wishlist (e.g., Birthday Gifts, Home Office Setup, Wedding Registry). Enables customers to organize multiple wishlists by purpose.',
    `wishlist_status` STRING COMMENT 'Current lifecycle state of the wishlist. Active: in use; Archived: preserved but inactive; Expired: past event date for registries; Deleted: soft-deleted pending purge.. Valid values are `active|archived|expired|deleted`',
    `wishlist_type` STRING COMMENT 'Classification of the wishlist purpose. Personal wishlists are private shopping lists; gift registries are shared for events (weddings, baby showers); shared wishlists allow collaborative curation. [ENUM-REF-CANDIDATE: personal|gift_registry|shared|wedding_registry|baby_registry|holiday|wishlist — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_wishlist PRIMARY KEY(`wishlist_id`)
) COMMENT 'Customer wishlist representing products explicitly saved for future consideration. Stores wishlist header: name, type (personal, gift-registry, shared), visibility setting, creation date, sharing URL, expiry date for gift registries. Owns individual line items: each item records SKU reference, product name at save time, price at save time, current price, price change indicator, availability status, priority rank, customer notes, date added, date removed, and notification preferences for price drops and back-in-stock alerts. Supports personalization, re-engagement campaigns, and gift registry workflows. Distinct from cart (active purchase intent) — wishlist represents longer-term interest signals and demand forecasting inputs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`merge_event` (
    `merge_event_id` BIGINT COMMENT 'Unique identifier for each merge event record.',
    `agent_id` BIGINT COMMENT 'System user (e.g., data steward or automated process) that initiated the merge.',
    `created_by_user_agent_id` BIGINT COMMENT 'User ID of the person or service that initially created the merge event record.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer profile that remains active after the merge.',
    `reversed_by_merge_event_id` BIGINT COMMENT 'Self-referencing FK on merge_event (reversed_by_merge_event_id)',
    `conflict_resolution_log` STRING COMMENT 'Narrative or structured log describing how attribute conflicts were resolved during the merge.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the merge event record was first inserted into the lakehouse.',
    `is_test_event` BOOLEAN COMMENT 'True if the merge event was generated in a test environment; otherwise False.',
    `merge_method` STRING COMMENT 'Method used to resolve the duplicate profiles: golden‑record algorithm or manual selection.. Valid values are `golden_record|manual_selection`',
    `merge_reason` STRING COMMENT 'Reason why the merge was performed: automatic match, agent‑initiated, or customer‑requested.. Valid values are `auto_match|agent_initiated|customer_requested`',
    `merge_status` STRING COMMENT 'Current lifecycle state of the merge event.. Valid values are `pending|completed|rolled_back`',
    `merge_timestamp` TIMESTAMP COMMENT 'Exact date and time when the merge operation was executed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the merge event record.',
    `rollback_reason` STRING COMMENT 'Explanation provided when a merge is rolled back or undone.',
    `source_system` STRING COMMENT 'Originating system that emitted the merge event (e.g., Customer Data Platform, Order Management System).. Valid values are `cdp|oms|custom`',
    CONSTRAINT pk_merge_event PRIMARY KEY(`merge_event_id`)
) COMMENT 'Tracks customer identity merge and deduplication events when the Customer Data Platform identifies duplicate profiles. Stores surviving profile reference, merged (retired) profile reference, merge reason (CDP auto-match, agent-initiated, customer-requested), merge method (golden record, manual selection), merge timestamp, merged-by reference, merge status (pending, completed, rolled-back), rollback reason, and data conflict resolution log. Critical for maintaining SSOT integrity in the profile entity and supporting audit trails when customer records are consolidated. Enables downstream systems to redirect references from retired profiles to surviving profiles.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`wishlist_item` (
    `wishlist_item_id` BIGINT COMMENT 'Primary key for the wishlist_item association',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item',
    `wishlist_id` BIGINT COMMENT 'Foreign key linking to the wishlist',
    `added_timestamp` TIMESTAMP COMMENT 'Date and time when the item was added to the wishlist',
    `notes` STRING COMMENT 'Free‑form notes the customer adds for the item',
    `priority_rank` STRING COMMENT 'Customer-assigned priority for this item within the wishlist',
    `quantity` STRING COMMENT 'Desired quantity of the catalog item in the wishlist',
    CONSTRAINT pk_wishlist_item PRIMARY KEY(`wishlist_item_id`)
) COMMENT 'This association product represents the relationship between a customer wishlist and a catalog item. It captures when an item was added to a wishlist, the desired quantity, priority ranking, and any user notes. Each record links one wishlist to one catalog item and stores data that belongs only to the association.. Existence Justification: Customers actively create and manage wishlists, adding multiple catalog items to each wishlist. Each catalog item can appear in many different customers wishlists. The platform records attributes such as when an item was added, desired quantity, priority, and user notes, making the association a managed business entity.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for organization',
    `parent_organization_id` BIGINT COMMENT 'Identifier of the parent organization in a corporate hierarchy, if applicable.',
    `buyer_org_id` BIGINT COMMENT 'Self-referencing FK on organization (buyer_org_id)',
    `address_line1` STRING COMMENT 'First line of the organization’s mailing address.',
    `address_line2` STRING COMMENT 'Second line of the organization’s mailing address (optional).',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported annual revenue of the organization in US dollars.',
    `city` STRING COMMENT 'City component of the organization’s address.',
    `classification` STRING COMMENT 'Business classification used for segmentation and reporting.',
    `compliance_status` STRING COMMENT 'Current compliance posture with GDPR, CCPA, and other regulatory frameworks.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the organization’s primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the organization record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for financial reporting.',
    `data_protection_officer` STRING COMMENT 'Name of the individual responsible for data protection compliance.',
    `dba_name` STRING COMMENT 'Alternative name used for marketing or sales purposes.',
    `organization_description` STRING COMMENT 'Free‑form textual description of the organization’s business purpose.',
    `effective_from` DATE COMMENT 'Date when the organization became active in the system.',
    `effective_until` DATE COMMENT 'Date when the organization’s record is considered inactive or superseded (nullable).',
    `email_address` STRING COMMENT 'Primary email address used for business correspondence.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems to reference the organization.',
    `industry_code` STRING COMMENT 'Standard industry code (e.g., NAICS) describing the organization’s primary activity.',
    `industry_sector` STRING COMMENT 'Higher‑level sector grouping (e.g., Retail, Logistics, Technology).',
    `is_subsidiary` BOOLEAN COMMENT 'True if the organization is a subsidiary of another entity.',
    `market_segment` STRING COMMENT 'Target market segment for the organization (e.g., B2C, B2B, C2C).',
    `organization_name` STRING COMMENT 'Full legal name of the organization as registered.',
    `number_of_employees` STRING COMMENT 'Total number of employees employed by the organization.',
    `organization_type` STRING COMMENT 'Category describing the legal form of the organization.',
    `phone_number` STRING COMMENT 'Main telephone number for the organization.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the organization’s address.',
    `primary_contact_detail` STRING COMMENT 'Contact information (e.g., email address or phone number) used for the primary contact method.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for official communications with the organization.',
    `privacy_consent_timestamp` TIMESTAMP COMMENT 'Date‑time when the organization provided consent for data processing.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the jurisdiction of incorporation.',
    `risk_score` STRING COMMENT 'Numerical risk rating assigned based on compliance and financial factors.',
    `state` STRING COMMENT 'State or province component of the organization’s address.',
    `organization_status` STRING COMMENT 'Current operational status of the organization within the ecosystem.',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the organization is exempt from tax under applicable regulations.',
    `trade_name` STRING COMMENT 'Business name under which the organization operates publicly.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the organization record.',
    `website_url` STRING COMMENT 'Public website address of the organization.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master reference table for organization. Referenced by buyer_org_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`customer`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `parent_party_id` BIGINT COMMENT 'Self-referencing FK on party (parent_party_id)',
    `account_creation_date` DATE COMMENT 'Date when the partys account was initially created.',
    `address_line1` STRING COMMENT 'First line of the partys primary mailing address.',
    `address_line2` STRING COMMENT 'Second line of the partys primary mailing address.',
    `city` STRING COMMENT 'City of the primary address.',
    `cltv_score` DECIMAL(18,2) COMMENT 'Estimated lifetime value score for the party.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the party has given consent for marketing communications.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when consent was recorded.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the primary address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the party record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level of the party data.',
    `date_of_birth` DATE COMMENT 'Birth date of the party (if a person).',
    `deactivation_reason` STRING COMMENT 'Reason for deactivating the party record, if applicable.',
    `email` STRING COMMENT 'Primary email address for electronic communication.',
    `external_party_id` STRING COMMENT 'Identifier used for the party in external partner systems.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Risk score indicating likelihood of fraudulent activity.',
    `gender` STRING COMMENT 'Gender of the party (if applicable).',
    `is_active` BOOLEAN COMMENT 'Indicates if the party record is currently active.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the partys most recent login to the platform.',
    `loyalty_program_member` BOOLEAN COMMENT 'Indicates if the party is enrolled in the loyalty program.',
    `loyalty_tier` STRING COMMENT 'Current loyalty tier of the party.',
    `marketing_opt_out` BOOLEAN COMMENT 'Flag indicating the party has opted out of marketing communications.',
    `party_name` STRING COMMENT 'The full legal name of the party.',
    `national_id` STRING COMMENT 'Government-issued national identification number.',
    `notes` STRING COMMENT 'Free-text internal notes about the party.',
    `nps_score` STRING COMMENT 'Latest Net Promoter Score for the party.',
    `party_type` STRING COMMENT 'Classification of the party indicating its role in the business ecosystem.',
    `phone_number` STRING COMMENT 'Primary telephone number for contact.',
    `postal_code` STRING COMMENT 'Postal code of the primary address.',
    `preferred_contact_method` STRING COMMENT 'Preferred channel for contacting the party.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO currency code preferred by the party.',
    `preferred_language` STRING COMMENT 'Preferred language for communications.',
    `profile_picture_url` STRING COMMENT 'URL to the partys profile picture.',
    `registration_number` STRING COMMENT 'Official registration number for organizational parties.',
    `source_system` STRING COMMENT 'Originating source system of the party record.',
    `state` STRING COMMENT 'State or province of the primary address.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party.',
    `tax_id` STRING COMMENT 'Tax registration number for the party.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ADD CONSTRAINT `fk_customer_customer_profile_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_account_default_billing_address_customer_address_id` FOREIGN KEY (`account_default_billing_address_customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ADD CONSTRAINT `fk_customer_customer_address_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_reports_to_contact_id` FOREIGN KEY (`reports_to_contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_merged_into_household_id` FOREIGN KEY (`merged_into_household_id`) REFERENCES `ecommerce_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `ecommerce_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_parent_preference_id` FOREIGN KEY (`parent_preference_id`) REFERENCES `ecommerce_ecm`.`customer`.`preference`(`preference_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ADD CONSTRAINT `fk_customer_consent_event_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ADD CONSTRAINT `fk_customer_consent_event_parent_consent_event_id` FOREIGN KEY (`parent_consent_event_id`) REFERENCES `ecommerce_ecm`.`customer`.`consent_event`(`consent_event_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ADD CONSTRAINT `fk_customer_cltv_score_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ADD CONSTRAINT `fk_customer_wishlist_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ADD CONSTRAINT `fk_customer_merge_event_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ADD CONSTRAINT `fk_customer_merge_event_reversed_by_merge_event_id` FOREIGN KEY (`reversed_by_merge_event_id`) REFERENCES `ecommerce_ecm`.`customer`.`merge_event`(`merge_event_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ADD CONSTRAINT `fk_customer_wishlist_item_wishlist_id` FOREIGN KEY (`wishlist_id`) REFERENCES `ecommerce_ecm`.`customer`.`wishlist`(`wishlist_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `ecommerce_ecm`.`customer`.`organization`(`organization_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_buyer_org_id` FOREIGN KEY (`buyer_org_id`) REFERENCES `ecommerce_ecm`.`customer`.`organization`(`organization_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `ecommerce_ecm`.`customer`.`party`(`party_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ecommerce_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `privacy_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `account_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `account_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending|blocked');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `account_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Channel');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `cdp_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Data Platform (CDP) Profile ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `customer_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Type Classification');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `customer_type` SET TAGS ('dbx_value_regex' = 'B2C|B2B|C2C|marketplace_seller|guest');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `data_processing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Customer Date of Birth');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Customer Email Address');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Verified Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Customer First Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `first_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'First Purchase Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Full Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Customer Gender');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|prefer not to say|other|unknown');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_document_type` SET TAGS ('dbx_business_glossary_term' = 'KYC Document Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'KYC Expiry Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'KYC Failure Reason');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_risk_level` SET TAGS ('dbx_business_glossary_term' = 'KYC Risk Level');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_verification_provider` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Provider');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|expired');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_verification_type` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `kyc_verification_type` SET TAGS ('dbx_value_regex' = 'email|phone|government_id|business_registration|bank_account|biometric');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `last_active_date` SET TAGS ('dbx_business_glossary_term' = 'Last Active Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Last Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Tier');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond|vip');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `marketing_opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Marketing Email Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `marketing_opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `marketing_opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `marketing_opt_in_push` SET TAGS ('dbx_business_glossary_term' = 'Marketing Push Notification Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `marketing_opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'Marketing SMS Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Phone Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `phone_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Phone Verified Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `phone_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `phone_verified_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ALTER COLUMN `third_party_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Consent Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Default Shipping Address Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_default_billing_address_customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Default Billing Address Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_default_billing_address_customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_default_billing_address_customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Method Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_source` SET TAGS ('dbx_business_glossary_term' = 'Account Source Channel');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_source` SET TAGS ('dbx_value_regex' = 'WEB|MOBILE_APP|STORE|CALL_CENTER|API|PARTNER');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|SUSPENDED|CLOSED|PENDING');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'STANDARD|PREMIUM|VIP|ENTERPRISE');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'B2C_PERSONAL|B2B_CORPORATE|C2C_MARKETPLACE');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `b2b_company_name` SET TAGS ('dbx_business_glossary_term' = 'Business-to-Business (B2B) Company Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `cltv_last_calculated_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Last Calculated Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `customer_lifetime_value` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `customer_lifetime_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `data_processing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `data_processing_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `loyalty_program_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrollment Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Tier');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'BRONZE|SILVER|GOLD|PLATINUM');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Communication Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `marketplace_seller_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Seller Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `risk_score_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `total_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Order Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ALTER COLUMN `vat_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|flagged');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'shipping|billing|registered|pickup|return');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `consent_marketing_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `failed_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Delivery Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `first_used_date` SET TAGS ('dbx_business_glossary_term' = 'First Used Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Accuracy Level');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|range_interpolated|geometric_center|approximate');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_bopis_eligible` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_default_billing` SET TAGS ('dbx_business_glossary_term' = 'Is Default Billing Address Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_default_shipping` SET TAGS ('dbx_business_glossary_term' = 'Is Default Shipping Address Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_military_address` SET TAGS ('dbx_business_glossary_term' = 'Military Address (APO/FPO/DPO) Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_military_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_military_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_po_box` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_po_box` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_po_box` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `is_verified_by_customer` SET TAGS ('dbx_business_glossary_term' = 'Customer Verified Address Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Geocoded)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geocoded)');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Address Nickname');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Address Contact Phone Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `residential_commercial_flag` SET TAGS ('dbx_business_glossary_term' = 'Residential or Commercial Classification');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `residential_commercial_flag` SET TAGS ('dbx_value_regex' = 'residential|commercial|unknown');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `serviceable_by_carrier` SET TAGS ('dbx_business_glossary_term' = 'Serviceable Carrier List');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Address Usage Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Source');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|corrected|partial');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `reports_to_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `approval_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Contact Approval Limit Amount');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `approval_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_business_glossary_term' = 'Executive Assistant Email Address');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_business_glossary_term' = 'Executive Assistant Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_business_glossary_term' = 'Executive Assistant Phone Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Contact Authorization Level');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'view_only|requester|approver|admin');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Deactivated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Contact Deactivation Reason');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Communication Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Verified Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `email_verified_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `external_contact_code` SET TAGS ('dbx_business_glossary_term' = 'External Contact ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Phone Communication Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Phone Verified Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `phone_verified_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|sms');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'SMS Communication Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `ecommerce_ecm`.`customer`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Holder ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Household Address ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `merged_into_household_id` SET TAGS ('dbx_business_glossary_term' = 'Merged Into Household ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `active_member_count` SET TAGS ('dbx_business_glossary_term' = 'Active Member Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Household Customer Lifetime Value (CLTV) Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Household Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `dissolved_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolved Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `external_household_code` SET TAGS ('dbx_business_glossary_term' = 'External Household ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `family_plan_eligible` SET TAGS ('dbx_business_glossary_term' = 'Family Plan Eligible');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `first_order_date` SET TAGS ('dbx_business_glossary_term' = 'First Order Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|merged|dissolved');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_value_regex' = 'single|family|shared|multi_generational|roommate|other');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Household Language Preference');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Household Loyalty Tier');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond|vip');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `marketing_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `marketing_consent_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|pending|not_provided');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Household Net Promoter Score (NPS)');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|mail|phone');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `return_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Household Risk Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Household Segment');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `shared_loyalty_pool_enabled` SET TAGS ('dbx_business_glossary_term' = 'Shared Loyalty Pool Enabled');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Household Timezone');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `total_household_gmv` SET TAGS ('dbx_business_glossary_term' = 'Total Household Gross Merchandise Value (GMV)');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `total_member_count` SET TAGS ('dbx_business_glossary_term' = 'Total Member Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `total_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Order Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `corporate_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `contact_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `approval_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain Required');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `consolidated_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Credit Limit');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `consolidated_credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `consolidated_invoicing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Invoicing Enabled');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `consolidated_spend_limit` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Spend Limit');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `consolidated_spend_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'group|subsidiary|division|department|cost_center|business_unit');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `intercompany_transaction_allowed` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Allowed');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'wholly_owned|majority_owned|minority_owned|affiliate|joint_venture|franchise');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `reporting_rollup_enabled` SET TAGS ('dbx_business_glossary_term' = 'Reporting Rollup Enabled');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `tax_consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Tax Consolidation Group');
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `volume_discount_eligible` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Eligible');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` SET TAGS ('dbx_subdomain' = 'loyalty_management');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Seller Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Brand Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `applicable_customer_segments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segments');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `auto_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Enrollment Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `cashback_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cashback Percentage');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `current_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `earn_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Earn Rate Multiplier');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `enrollment_eligibility_rules` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Rules');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{0,30}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `max_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `partner_coalition_flag` SET TAGS ('dbx_business_glossary_term' = 'Partner Coalition Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_currency_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Points to Currency Conversion Rate');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_expiration_period_days` SET TAGS ('dbx_business_glossary_term' = 'Points Expiration Period (Days)');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Description');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Email Address');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|draft|archived');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'points_based|tier_based|cashback|subscription|hybrid|coalition');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `redemption_minimum_points` SET TAGS ('dbx_business_glossary_term' = 'Redemption Minimum Points');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `subscription_billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Subscription Billing Frequency');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `subscription_billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|one_time');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `subscription_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Subscription Fee Amount');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `terms_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `terms_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_threshold_bronze` SET TAGS ('dbx_business_glossary_term' = 'Bronze Tier Threshold');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_threshold_gold` SET TAGS ('dbx_business_glossary_term' = 'Gold Tier Threshold');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_threshold_platinum` SET TAGS ('dbx_business_glossary_term' = 'Platinum Tier Threshold');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_threshold_silver` SET TAGS ('dbx_business_glossary_term' = 'Silver Tier Threshold');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` SET TAGS ('dbx_subdomain' = 'loyalty_management');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `current_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Points Balance');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `current_tier` SET TAGS ('dbx_business_glossary_term' = 'Current Loyalty Tier');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `current_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond|vip');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_store|call_center|email|social_media');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Number');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_source_campaign` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source Campaign');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|cancelled|pending');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Loyalty Activity Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `last_earn_date` SET TAGS ('dbx_business_glossary_term' = 'Last Points Earn Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `last_redeem_date` SET TAGS ('dbx_business_glossary_term' = 'Last Points Redemption Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_expired` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Expired');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `membership_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `membership_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `membership_fee_paid` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Paid');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `next_tier_gap` SET TAGS ('dbx_business_glossary_term' = 'Next Tier Gap');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `next_tier_threshold` SET TAGS ('dbx_business_glossary_term' = 'Next Tier Threshold');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_push_notification` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Opt-In Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `points_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `reactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Reactivation Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_qualifying_period_end` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualifying Period End Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_qualifying_period_start` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualifying Period Start Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_qualifying_spend` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualifying Spend');
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'loyalty_management');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `relevance_config_id` SET TAGS ('dbx_business_glossary_term' = 'Relevance Config Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Activated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Marketing Channels');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Method');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual|hybrid');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `baseline_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Performance Metric Value');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `business_owner` SET TAGS ('dbx_business_glossary_term' = 'Segment Business Owner');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Deactivated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `exclusion_rules` SET TAGS ('dbx_business_glossary_term' = 'Segment Exclusion Rules');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Segment Refresh Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Member Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `ml_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Reference');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Segment Modified By User');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `next_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Refresh Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `overlap_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Overlap Allowed Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Segment Owning Team');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `performance_metric_kpi` SET TAGS ('dbx_business_glossary_term' = 'Segment Performance Metric Key Performance Indicator (KPI)');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Refresh Frequency');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Segment Data Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Segment Rule Expression');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|deprecated');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Segment Tags');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `target_size` SET TAGS ('dbx_business_glossary_term' = 'Segment Target Size');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `use_case` SET TAGS ('dbx_business_glossary_term' = 'Segment Use Case');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Segment Version');
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Segment Created By User');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` SET TAGS ('dbx_subdomain' = 'loyalty_management');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `parent_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Preference ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Preference Channel');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|email|sms|call_center|in_store');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `consent_text` SET TAGS ('dbx_business_glossary_term' = 'Consent Text');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `double_opt_in_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmed');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `double_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Expiry Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `frequency_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Period');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `frequency_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Preference Hash');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `is_global_preference` SET TAGS ('dbx_business_glossary_term' = 'Is Global Preference');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_business_glossary_term' = 'Preference Category');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_value_regex' = 'email_marketing|sms_marketing|push_notification|personalized_recommendations|third_party_data_sharing|cookie_consent');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_business_glossary_term' = 'Preference Source');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_value_regex' = 'customer_self_service|agent_set|import|system_default|regulatory_requirement');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|expired|superseded|revoked');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `preference_value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `right_to_be_forgotten_requested` SET TAGS ('dbx_business_glossary_term' = 'Right to Be Forgotten Requested');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `right_to_be_forgotten_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Right to Be Forgotten Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Preference Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `suppression_category` SET TAGS ('dbx_business_glossary_term' = 'Suppression Category');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `suppression_category` SET TAGS ('dbx_value_regex' = 'customer_request|regulatory_requirement|bounce|complaint|unsubscribe|data_quality');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `third_party_sharing_partners` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Partners');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `consent_event_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Event ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `parent_consent_event_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consent Event ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'web-form|mobile-app|call-center|email-link|in-store-kiosk|api');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `communication_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `consent_category` SET TAGS ('dbx_value_regex' = 'marketing-email|marketing-sms|marketing-push|personalization|analytics|third-party-sharing');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country-specific|channel-specific');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `consent_text` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Presented');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `customer_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Email Address');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `customer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `customer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `customer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'consent-given|consent-withdrawn|consent-updated|data-deletion-requested|data-portability-requested|preference-updated');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `geolocation_country` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `geolocation_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `geolocation_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `geolocation_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Region');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `is_minor` SET TAGS ('dbx_business_glossary_term' = 'Is Minor Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legitimate-interest|legal-obligation|vital-interest|public-task');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Consent Value');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `opt_out_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out of Sale Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `parental_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Required Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `parental_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Verified Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `prior_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Consent Value');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `processing_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Event Processing Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|cancelled');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `third_party_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Allowed Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email-verification|sms-otp|two-factor-auth|none');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not-required');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `cltv_score_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Score ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `aov_contribution` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV) Contribution');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `churn_probability_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Probability Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Tier');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_value_regex' = 'high-value|mid-value|low-value|at-risk|new|dormant');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Prediction Confidence Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'vip|loyal|promising|new|at-risk|lost');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `days_since_first_order` SET TAGS ('dbx_business_glossary_term' = 'Days Since First Order');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `days_since_last_order` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Order');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `frequency_score` SET TAGS ('dbx_business_glossary_term' = 'Frequency Score (RFM)');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `historical_cltv` SET TAGS ('dbx_business_glossary_term' = 'Historical Customer Lifetime Value (CLTV)');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `model_features_used` SET TAGS ('dbx_business_glossary_term' = 'Model Features Used');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'CLTV Model Version');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `monetary_score` SET TAGS ('dbx_business_glossary_term' = 'Monetary Score (RFM)');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `next_recalculation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recalculation Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `predicted_cltv_12m` SET TAGS ('dbx_business_glossary_term' = 'Predicted Customer Lifetime Value (CLTV) 12-Month Horizon');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `predicted_cltv_36m` SET TAGS ('dbx_business_glossary_term' = 'Predicted Customer Lifetime Value (CLTV) 36-Month Horizon');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `preferred_category` SET TAGS ('dbx_business_glossary_term' = 'Preferred Product Category');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `purchase_frequency_score` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `recency_score` SET TAGS ('dbx_business_glossary_term' = 'Recency Score (RFM)');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `rfm_composite_score` SET TAGS ('dbx_business_glossary_term' = 'Recency Frequency Monetary (RFM) Composite Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `rfm_composite_score` SET TAGS ('dbx_value_regex' = '^[1-5][1-5][1-5]$');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `score_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Score Calculation Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `score_status` SET TAGS ('dbx_business_glossary_term' = 'Score Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `score_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_recalculation|archived');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `total_orders_count` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`cltv_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `nps_response_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Response ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Agent ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Campaign ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `anonymized_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymized Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Classification');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `consent_given_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `customer_tenure_days` SET TAGS ('dbx_business_glossary_term' = 'Customer Tenure Days');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|unknown');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `follow_up_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Taken');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `follow_up_action_taken` SET TAGS ('dbx_value_regex' = 'none|contacted|resolved|escalated|pending');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Notes');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `previous_nps_score` SET TAGS ('dbx_business_glossary_term' = 'Previous Net Promoter Score (NPS) Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'completed|partial|bounced|opted_out|expired');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `sentiment_topics` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Topics');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Channel');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_value_regex' = 'email|in_app|sms|web|ivr|post_purchase');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_send_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Send Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Send Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'transactional|relational|onboarding|post_purchase|post_support|annual');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `triggering_event_code` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_value_regex' = 'order|return|support_case|delivery|account_creation|subscription_renewal');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comment Text');
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `wishlist_id` SET TAGS ('dbx_business_glossary_term' = 'Wishlist ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Archived Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Conversion Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Deleted Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Event Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Expiry Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Wishlist Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Item Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `last_viewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Viewed Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Internal Notes');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `notification_back_in_stock_enabled` SET TAGS ('dbx_business_glossary_term' = 'Back-In-Stock Notification Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `notification_event_reminder_enabled` SET TAGS ('dbx_business_glossary_term' = 'Event Reminder Notification Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `notification_price_drop_enabled` SET TAGS ('dbx_business_glossary_term' = 'Price Drop Notification Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Priority Rank');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `privacy_consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent for Wishlist Marketing');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `privacy_consent_sharing` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent for Wishlist Sharing');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `registry_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gift Registry Completion Percentage');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `share_count` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Share Count');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `sharing_token` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Sharing Token');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `sharing_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `sharing_url` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Sharing URL (Uniform Resource Locator)');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Source Channel');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|tablet_app|api|customer_service');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `source_device_type` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Source Device Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `source_device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|unknown');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `total_current_value` SET TAGS ('dbx_business_glossary_term' = 'Total Wishlist Current Value');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `total_value_at_save` SET TAGS ('dbx_business_glossary_term' = 'Total Wishlist Value at Save Time');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `view_count_by_others` SET TAGS ('dbx_business_glossary_term' = 'Wishlist View Count by Others');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `visibility` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Visibility');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `visibility` SET TAGS ('dbx_value_regex' = 'private|public|shared_link');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `wishlist_description` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Description');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `wishlist_name` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Name');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `wishlist_status` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `wishlist_status` SET TAGS ('dbx_value_regex' = 'active|archived|expired|deleted');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ALTER COLUMN `wishlist_type` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Type');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Merge Event Identifier');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Merged By User Identifier');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `created_by_user_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `created_by_user_agent_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `created_by_user_agent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Surviving Profile Identifier');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `reversed_by_merge_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `conflict_resolution_log` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Log');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `is_test_event` SET TAGS ('dbx_business_glossary_term' = 'Test Event Flag');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_method` SET TAGS ('dbx_business_glossary_term' = 'Merge Method');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_method` SET TAGS ('dbx_value_regex' = 'golden_record|manual_selection');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_reason` SET TAGS ('dbx_business_glossary_term' = 'Merge Reason');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_reason` SET TAGS ('dbx_value_regex' = 'auto_match|agent_initiated|customer_requested');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_status` SET TAGS ('dbx_business_glossary_term' = 'Merge Status');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rolled_back');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `merge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Merge Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'cdp|oms|custom');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` SET TAGS ('dbx_association_edges' = 'customer.wishlist,product.catalog_item');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ALTER COLUMN `wishlist_item_id` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Item - Wishlist Item Id');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Item - Catalog Item Id');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ALTER COLUMN `wishlist_id` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Item - Wishlist Id');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ALTER COLUMN `added_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Item Added Date');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Item Notes');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Item Priority');
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Desired Quantity');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `buyer_org_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `data_protection_officer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `dba_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `organization_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`organization` ALTER COLUMN `trade_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` SET TAGS ('dbx_subdomain' = 'customer_identity');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `cltv_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `national_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `national_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `nps_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `nps_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`customer`.`party` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
