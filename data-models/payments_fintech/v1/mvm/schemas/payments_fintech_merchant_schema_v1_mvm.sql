-- Schema for Domain: merchant | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`merchant` COMMENT 'SSOT for merchant identity, onboarding, and relationship management. Owns MID provisioning, MCC classification, merchant KYC/KYB verification, PayFac and ISO sub-merchant hierarchies, terminal registration, pricing configuration, settlement accounts, processing limits, and merchant lifecycle from application through offboarding.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`merchant` (
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant entity. Primary key. System-of-record identifier assigned during merchant onboarding and provisioning.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Internal cost allocation and profitability analysis map each merchant to a cost center, supporting budgeting and expense tracking reports.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Pricing engine needs a default IRF rate category per merchant to calculate fees; merchants are enrolled in a rate category for fee simulation and reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key reference to the ISO (Independent Sales Organization) partner responsible for merchant acquisition and relationship management. Null for direct merchants. Used for commission calculation and partner performance tracking.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Merchants operate under jurisdiction-specific AML/CTF regimes, transaction limits, and data residency requirements. The jurisdiction_profile governs which compliance controls apply to the merchant. Co',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory consolidation requires each merchant to be linked to its legal entity for tax, KYC, and financial statement reporting.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Required for participant onboarding and daily settlement reporting; each merchant must be linked to a settlement participant for AML/KYC and regulatory reporting.',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: In compliance architecture, every AML/KYC-screened entity is a party. Merchants are compliance parties subject to AML screening, SAR filing, and watchlist monitoring. This foundational link enables co',
    `payfac_parent_merchant_id` BIGINT COMMENT 'Foreign key reference to the parent Payment Facilitator (PayFac) merchant if this merchant is a sub-merchant operating under a PayFac model. Null for direct merchants and top-level PayFacs. Used for hierarchical reporting and liability management.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Cross-border merchants are assigned a default payment corridor governing FX rules, transaction limits, regulatory restrictions, and settlement instructions. Required for cross-border merchant onboardi',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: Every merchant is onboarded with a primary acquirer responsible for settlement processing. This link is essential for acquirer-level merchant portfolio reporting, settlement limit enforcement, and reg',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Revenue from merchant transactions must be posted to a specific GL account; linking enables automated journal entry generation for compliance and audit.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: Required for assigning a specific network endpoint for transaction routing during merchant onboarding, enabling routing decisions per merchant.',
    `underwriting_policy_id` BIGINT COMMENT 'Foreign key linking to risk.underwriting_policy. Business justification: Every merchant is assigned an underwriting policy that defines risk limits; this link supports policy enforcement and compliance reporting.',
    `activation_date` DATE COMMENT 'The date when the merchant was activated for live transaction processing. May differ from onboarding_date if there is a testing or approval period. Marks the start of revenue-generating activity.',
    `business_address_line1` STRING COMMENT 'The first line of the merchants registered business address (street number and name). Used for KYB verification, regulatory reporting, and correspondence. Organizational contact data classified as confidential.',
    `business_address_line2` STRING COMMENT 'The second line of the merchants registered business address (suite, floor, building name). Optional field. Organizational contact data classified as confidential.',
    `business_city` STRING COMMENT 'The city or municipality of the merchants registered business address. Used for geographic analysis, tax jurisdiction determination, and regulatory reporting. Organizational contact data classified as confidential.',
    `business_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the merchants registered business address. Used for sanctions screening, cross-border rules, and regulatory reporting. Organizational contact data classified as confidential.. Valid values are `^[A-Z]{3}$`',
    `business_postal_code` STRING COMMENT 'The postal code or ZIP code of the merchants registered business address. Used for address verification, tax calculation, and geographic analysis. Format varies by country. Organizational contact data classified as confidential.',
    `business_registration_number` STRING COMMENT 'The official business registration or company number issued by the government authority in the incorporation jurisdiction. Used for KYB (Know Your Business) verification and legal entity validation.',
    `business_state_province` STRING COMMENT 'The state, province, or administrative region of the merchants registered business address. Used for tax jurisdiction, regulatory compliance, and geographic segmentation. Organizational contact data classified as confidential.',
    `business_type` STRING COMMENT 'The legal structure and classification of the merchant business entity. Determines regulatory requirements, tax treatment, and liability structure.. Valid values are `sole_proprietorship|partnership|corporation|llc|non_profit|government`',
    `chargeback_threshold_count` STRING COMMENT 'The maximum number of chargebacks allowed per month before the merchant is flagged for review or placed in a monitoring program. Exceeding this threshold may result in increased reserves, fines, or termination.',
    `chargeback_threshold_ratio` DECIMAL(18,2) COMMENT 'The maximum allowed chargeback ratio (chargebacks divided by total transactions) expressed as a decimal (e.g., 0.0100 for 1.00%). Exceeding this threshold triggers card scheme monitoring programs and potential penalties.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this merchant record was first created in the system. Used for audit trail, data lineage, and record retention compliance. Immutable after initial creation.',
    `dba_name` STRING COMMENT 'The trade name or DBA (Doing Business As) name under which the merchant operates and is publicly known. May differ from legal business name. Displayed on cardholder statements.',
    `incorporation_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the merchant business is legally incorporated or registered. Used for regulatory compliance, sanctions screening, and cross-border payment rules.. Valid values are `^[A-Z]{3}$`',
    `kyc_verification_date` DATE COMMENT 'The date when KYC/KYB verification was successfully completed for the merchant. Used for compliance audit trails and periodic re-verification scheduling.',
    `kyc_verification_status` STRING COMMENT 'Current status of the KYC/KYB (Know Your Business) verification process for the merchant. Indicates whether identity verification, business documentation, and beneficial ownership checks have been completed and approved.. Valid values are `not_started|in_progress|verified|failed|expired`',
    `legal_business_name` STRING COMMENT 'The official registered legal name of the merchant business entity as recorded in incorporation or business registration documents. Used for regulatory reporting, compliance verification, and legal contracts.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the merchant in the payment platform lifecycle. Governs transaction processing eligibility, settlement, and platform access. Transitions managed through merchant lifecycle workflow. [ENUM-REF-CANDIDATE: application|pending_review|approved|active|suspended|terminated|offboarded — 7 candidates stripped; promote to reference product]',
    `mdr_rate` DECIMAL(18,2) COMMENT 'The percentage rate charged to the merchant for payment processing services, expressed as a decimal (e.g., 0.0275 for 2.75%). Represents the merchants cost of acceptance. Varies by card type, transaction type, and merchant volume tier.',
    `mid` STRING COMMENT 'The externally-known unique Merchant Identification Number (MID) assigned by the acquiring bank or payment processor. Used for transaction routing, authorization, settlement, and reporting. Distinct from internal merchant_id surrogate key.. Valid values are `^[A-Z0-9]{8,15}$`',
    `monthly_processing_limit` DECIMAL(18,2) COMMENT 'The maximum total payment volume (in processing currency) that the merchant is authorized to process per calendar month. Used for risk management and fraud prevention. Exceeding this limit may trigger holds or additional review.',
    `onboarding_date` DATE COMMENT 'The date when the merchant was successfully onboarded to the payment platform and assigned a MID. Marks the start of the merchant relationship and eligibility for transaction processing.',
    `operating_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary country where the merchant conducts business operations. May differ from incorporation country for multinational merchants.. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for the merchant account. Used for operational notifications, settlement reports, dispute alerts, and compliance communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact person for the merchant account. Used for operational communication, support escalation, and account management.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary business contact for the merchant account. Used for urgent operational communication, fraud alerts, and account verification. Format varies by country.',
    `risk_rating` STRING COMMENT 'The risk classification assigned to the merchant based on MCC, transaction patterns, chargeback history, geographic location, and business model. Determines monitoring intensity, reserve requirements, and processing limits.. Valid values are `low|medium|high|prohibited`',
    `settlement_account_number` STRING COMMENT 'The bank account number where merchant settlement funds are deposited. Encrypted at rest. Used for ACH, wire transfer, or RTGS settlement processing. Format varies by country and payment rail.',
    `settlement_frequency` STRING COMMENT 'The frequency at which settled funds are transferred to the merchants bank account. Configured based on merchant agreement, risk profile, and processing volume.. Valid values are `daily|weekly|monthly|on_demand`',
    `settlement_routing_number` STRING COMMENT 'The bank routing number, sort code, or SWIFT/BIC code for the merchants settlement account. Used to route settlement funds to the correct financial institution. Format varies by jurisdiction (e.g., ABA routing number in USA, sort code in UK, SWIFT BIC internationally).',
    `tax_identifier` STRING COMMENT 'The government-issued tax identification number for the merchant business entity. Format varies by jurisdiction (e.g., EIN in USA, VAT number in EU, GST number in India). Used for tax reporting, regulatory compliance, and identity verification.',
    `termination_date` DATE COMMENT 'The date when the merchant relationship was terminated and the merchant was offboarded from the payment platform. Nullable for active merchants. Used for retention analysis and regulatory record-keeping.',
    `transaction_limit_single` DECIMAL(18,2) COMMENT 'The maximum amount (in processing currency) allowed for a single transaction. Transactions exceeding this limit are declined at authorization. Set based on merchant risk profile and business model.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this merchant record was last modified. Updated automatically on any field change. Used for change tracking, data synchronization, and audit compliance.',
    `website_url` STRING COMMENT 'The primary website URL of the merchant business. Used for business verification, fraud screening, and customer service reference. Required for e-commerce merchants.',
    CONSTRAINT pk_merchant PRIMARY KEY(`merchant_id`)
) COMMENT 'Core master entity representing a merchant business entity onboarded to the payments platform. Owns the authoritative merchant identity record including legal business name, DBA name, MID (Merchant Identification Number), business registration details, tax identification, business type, incorporation country, operational status, and lifecycle stage from application through offboarding. SSOT for all merchant identity data.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`application` (
    `application_id` BIGINT COMMENT 'Unique identifier for the merchant application record. Primary key for the merchant application entity.',
    `merchant_id` BIGINT COMMENT 'Identifier of the parent Payment Facilitator if this is a sub-merchant application. Establishes hierarchical relationship for settlement and liability.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the ISO partner who referred or manages this merchant relationship. Used for commission calculation and relationship management.',
    `kyb_verification_id` BIGINT COMMENT 'Foreign key linking to merchant.kyb_verification. Business justification: The merchant onboarding application triggers KYB verification. application currently stores kyb_verification_status as a denormalized field. Adding kyb_verification_id links the application to its aut',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Merchant applications are submitted by legal entities. Underwriting and KYB processes require linking the application to the legal entity being onboarded for AML screening, OFAC checks, and regulatory',
    `onboarding_application_id` BIGINT COMMENT 'Foreign key linking to partner.onboarding_application. Business justification: A merchant application submitted through a partner channel is directly spawned from or linked to the partners onboarding application. This FK is required for partner-driven merchant acquisition repor',
    `parent_payfac_merchant_id` BIGINT COMMENT 'Identifier of the parent Payment Facilitator if this is a sub-merchant application. Establishes hierarchical relationship for settlement and liability.',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: During merchant onboarding, the application captures the interchange program the merchant is being enrolled in. This link is required for underwriting decisions, program eligibility validation, and on',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Every merchant application requires OFAC/sanctions screening before approval. The ofac_screening_status field is denormalized — the FK to the sanctions_check record that performed this screening is re',
    `underwriting_policy_id` BIGINT COMMENT 'Foreign key linking to risk.underwriting_policy. Business justification: Merchant applications are evaluated against a specific underwriting_policy. The application has underwriting_start/complete timestamps confirming underwriting occurs at application stage. Onboarding c',
    `application_number` STRING COMMENT 'Externally visible unique application reference number assigned at submission. Used for tracking and customer communication throughout the onboarding lifecycle.. Valid values are `^APP-[0-9]{10}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the merchant application. Tracks progression from initial draft through underwriting review to final disposition. [ENUM-REF-CANDIDATE: draft|submitted|under_review|pending_documentation|approved|rejected|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `application_type` STRING COMMENT 'Classification of the application purpose: new merchant onboarding, change to existing merchant profile, reinstatement after termination, upgrade or downgrade of service tier, or reactivation of dormant account.. Valid values are `new|change|reinstatement|upgrade|downgrade|reactivation`',
    `bank_account_number` STRING COMMENT 'Bank account number for merchant settlement deposits. Used for ACH credit transfers of processed transaction funds. Subject to account verification before approval.. Valid values are `^[0-9]{8,17}$`',
    `bank_account_type` STRING COMMENT 'Type of bank account designated for settlement. Determines ACH transaction codes and processing rules.. Valid values are `checking|savings|business_checking`',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing number for the merchants settlement bank. Used for ACH settlement processing and account verification.. Valid values are `^[0-9]{9}$`',
    `business_address_line1` STRING COMMENT 'Primary street address line for the merchants principal place of business. Used for KYB verification and AVS validation.',
    `business_address_line2` STRING COMMENT 'Secondary address line for suite, unit, or building information. Optional field for complete business address.',
    `business_city` STRING COMMENT 'City or municipality of the merchants principal place of business.',
    `business_country_code` STRING COMMENT 'Three-letter ISO country code for the merchants principal place of business. Used for cross-border risk assessment and sanctions screening.. Valid values are `^[A-Z]{3}$`',
    `business_description` STRING COMMENT 'Detailed narrative description of the merchants business model, products sold, services offered, and target customer base. Used by underwriters to assess risk and validate MCC classification.',
    `business_postal_code` STRING COMMENT 'Postal or ZIP code for the merchants business address. Used for AVS verification and geographic risk assessment.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `business_state_province` STRING COMMENT 'Two-letter state or province code for the merchants business address. Used for tax jurisdiction determination and regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `business_type` STRING COMMENT 'Legal structure of the merchant entity. Determines underwriting requirements, liability assessment, and documentation checklist.. Valid values are `sole_proprietor|partnership|llc|corporation|non_profit|government`',
    `business_website_url` STRING COMMENT 'Primary website URL for the merchants business. Used for business verification, fraud screening, and brand reputation assessment.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `contact_email` STRING COMMENT 'Email address of the primary business contact. Used for application status notifications and ongoing merchant communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_first_name` STRING COMMENT 'First name of the primary business contact or authorized representative for the merchant application.',
    `contact_last_name` STRING COMMENT 'Last name of the primary business contact or authorized representative for the merchant application.',
    `contact_phone` STRING COMMENT 'Primary phone number for the business contact. Used for verification calls and urgent communication during underwriting.. Valid values are `^+?[0-9]{10,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the merchant application record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_check_performed_flag` BOOLEAN COMMENT 'Indicates whether a credit bureau check was performed on the business owner. Required for most merchant applications per underwriting policy.',
    `credit_score` STRING COMMENT 'Personal credit score of the principal business owner obtained from credit bureau. Used for creditworthiness assessment and pricing determination.',
    `decision_code` STRING COMMENT 'Final underwriting decision outcome. Determines next steps in merchant onboarding workflow and triggers downstream provisioning or notification processes.. Valid values are `approved|declined|conditional_approval|pending_info|withdrawn|expired`',
    `decision_rationale` STRING COMMENT 'Detailed explanation of the underwriting decision including risk factors considered, policy violations identified, or conditions imposed. Used for adverse action notices and audit trail.',
    `documentation_received_flag` BOOLEAN COMMENT 'Indicates whether all required documentation has been received and validated. Gates progression to final approval stage.',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the merchant operates. May differ from legal name and appears on customer-facing materials.',
    `estimated_average_ticket` DECIMAL(18,2) COMMENT 'Projected average transaction amount in base currency. Used for fraud risk modeling and chargeback exposure assessment.',
    `estimated_monthly_volume` DECIMAL(18,2) COMMENT 'Merchants projected monthly payment processing volume in base currency. Used for risk assessment, pricing tier determination, and reserve calculation.',
    `kyc_verification_status` STRING COMMENT 'Status of KYC identity verification process for business owners and authorized signers. Must pass before final approval per AML regulations.. Valid values are `not_started|in_progress|passed|failed|manual_review`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the merchant application record was last updated. Used for audit trail and change tracking.',
    `legal_business_name` STRING COMMENT 'Official registered legal name of the merchant entity as it appears on incorporation documents. Used for KYB (Know Your Business) verification and regulatory reporting.',
    `owner_date_of_birth` DATE COMMENT 'Date of birth of the principal business owner. Used for identity verification and age validation during KYC process.',
    `owner_first_name` STRING COMMENT 'First name of the principal business owner or majority stakeholder. Required for KYC verification and beneficial ownership identification per FinCEN rules.',
    `owner_last_name` STRING COMMENT 'Last name of the principal business owner or majority stakeholder. Required for KYC verification and beneficial ownership identification per FinCEN rules.',
    `owner_ssn` STRING COMMENT 'Social Security Number of the principal business owner. Required for personal credit check, identity verification, and OFAC screening during underwriting.. Valid values are `^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of business ownership held by the principal owner. Used to determine beneficial ownership reporting requirements per FinCEN 25% threshold rule.',
    `payfac_sub_merchant_flag` BOOLEAN COMMENT 'Indicates whether this application is for a sub-merchant under a Payment Facilitator model. Determines underwriting requirements and settlement hierarchy.',
    `referral_source` STRING COMMENT 'Source of the merchant application referral (e.g., direct, partner, web, sales_rep). Used for marketing attribution and channel performance analysis.',
    `requested_mcc` STRING COMMENT 'Four-digit MCC code requested by the merchant that classifies their business type. Subject to underwriter validation and may be adjusted based on actual business model. Determines interchange rates and risk profile.. Valid values are `^[0-9]{4}$`',
    `requested_processing_methods` STRING COMMENT 'Comma-separated list of payment processing methods requested by merchant (e.g., card_present, card_not_present, ecommerce, moto, recurring). Determines equipment needs and risk profile.',
    `required_documentation_checklist` STRING COMMENT 'Comma-separated list of required documents for application completion (e.g., articles_of_incorporation, bank_statement, voided_check, government_id). Varies by business type and risk profile.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment score assigned during underwriting. Combines credit risk, fraud risk, and business risk factors. Used for pricing tier assignment and reserve determination.',
    `submission_channel` STRING COMMENT 'Channel through which the merchant application was submitted. Used for channel performance analysis and fraud pattern detection.. Valid values are `web_portal|mobile_app|partner_api|sales_rep|call_center|branch`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the merchant application was formally submitted for underwriting review. Represents the business event timestamp for SLA tracking.',
    `tax_identifier` STRING COMMENT 'Federal tax identification number (EIN for businesses, SSN for sole proprietors). Used for IRS reporting, KYB verification, and OFAC screening.. Valid values are `^[0-9]{2}-[0-9]{7}$|^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `underwriting_complete_timestamp` TIMESTAMP COMMENT 'Date and time when underwriting review was completed and final decision was rendered. Used for SLA compliance reporting and cycle time analysis.',
    `underwriting_start_timestamp` TIMESTAMP COMMENT 'Date and time when the application entered underwriting review. Used for SLA tracking and process efficiency measurement.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Captures the full merchant onboarding application lifecycle — from initial submission through underwriting review, KYC/KYB verification, and final approval or rejection. Tracks application type (new, change, reinstatement), submission channel, assigned underwriter, decision rationale, required documentation checklist, and timestamps for each stage. Source of record for the Merchant Management System onboarding workflow.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the merchant location. Primary key.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Each merchant location has its own MCC and may qualify for a different IRF rate category than the parent merchant default. Location-level interchange qualification tracking is essential for acquirer i',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Each merchant location operates under a specific jurisdictions AML/CTF regime, transaction limits, and data residency rules. Compliance teams require this link to enforce jurisdiction-specific contro',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: A merchant_location (physical or virtual outlet) operates under a specific merchant_account for transaction processing. The account governs which payment methods, card schemes, and processing rules ap',
    `merchant_id` BIGINT COMMENT 'Reference to the parent merchant entity that owns this location.',
    `merchant_settlement_account_id` BIGINT COMMENT 'Reference to the settlement account where funds for transactions at this location are deposited.',
    `pci_compliance_id` BIGINT COMMENT 'Foreign key linking to merchant.pci_compliance. Business justification: merchant_location stores pci_compliance_level and pci_attestation_date as denormalized fields. In PCI DSS, each physical location (especially those with card-present terminals) may have its own PCI co',
    `activation_date` DATE COMMENT 'Date when this location was activated and began processing live transactions.',
    `address_line_1` STRING COMMENT 'Primary street address line for the merchant location (street number, street name, suite/unit).',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details (building, floor, department).',
    `chargeback_threshold_count` STRING COMMENT 'Maximum number of chargebacks allowed per monitoring period before triggering compliance review or location suspension.',
    `chargeback_threshold_ratio` DECIMAL(18,2) COMMENT 'Maximum chargeback-to-transaction ratio allowed (e.g., 0.0090 for 0.9%) before triggering compliance action per card scheme rules.',
    `city` STRING COMMENT 'City or municipality where the merchant location is situated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this merchant location record was first created in the system.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total transaction volume allowed per day for this location, used for risk management and fraud prevention.',
    `dba_name` STRING COMMENT 'The trade name or Doing Business As name under which this location operates, if different from the legal merchant name.',
    `deactivation_date` DATE COMMENT 'Date when this location was deactivated or closed, ceasing transaction processing.',
    `email_address` STRING COMMENT 'Primary email address for location-specific communications and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fraud_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether real-time fraud detection and prevention monitoring is enabled for transactions at this location.',
    `kyc_verification_date` DATE COMMENT 'Date when KYC/KYB verification was completed for this location.',
    `kyc_verification_status` STRING COMMENT 'Status of Know Your Customer (KYC) and Know Your Business (KYB) verification for this location: verified, pending review, failed verification, or expired requiring re-verification.. Valid values are `verified|pending|failed|expired`',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction processed at this location, used for dormancy monitoring and lifecycle management.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the merchant location in decimal degrees for mapping and proximity analytics.',
    `location_name` STRING COMMENT 'Business name or identifier for this specific merchant location (e.g., Downtown Store, Airport Terminal 3).',
    `location_status` STRING COMMENT 'Current operational status of the merchant location in its lifecycle: active (processing transactions), inactive (temporarily not processing), suspended (compliance hold), pending (onboarding), or closed (permanently offboarded).. Valid values are `active|inactive|suspended|pending|closed`',
    `location_type` STRING COMMENT 'Classification of the merchant location type: physical storefront, kiosk, online, mobile Point of Sale (mPOS), virtual, or pop-up.. Valid values are `physical_storefront|kiosk|online|mpos|virtual|pop_up`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the merchant location in decimal degrees for mapping and proximity analytics.',
    `mcc` STRING COMMENT 'Four-digit Merchant Category Code (MCC) classification for this location, which may override the parent merchant MCC for location-specific business activities.. Valid values are `^[0-9]{4}$`',
    `mid` STRING COMMENT 'Unique Merchant Identification Number (MID) assigned to this location by the acquiring bank or payment processor for transaction routing and settlement.',
    `onboarding_date` DATE COMMENT 'Date when this merchant location was successfully onboarded and provisioned in the payment processing system.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the location (e.g., Mon-Fri 9AM-5PM, Sat 10AM-2PM) used for customer service and transaction pattern analysis.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the merchant location.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the merchant location address.',
    `risk_score` DECIMAL(18,2) COMMENT 'Current risk assessment score for this location (0-100 scale) based on transaction patterns, chargeback history, fraud indicators, and compliance factors.',
    `risk_tier` STRING COMMENT 'Risk classification tier for this location: low, medium, high, or critical, determining monitoring intensity and processing controls.. Valid values are `low|medium|high|critical`',
    `single_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount allowed for a single transaction at this location, enforced during authorization.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the merchant location.',
    `three_ds_required` BOOLEAN COMMENT 'Indicates whether 3-D Secure (3DS) authentication is mandatory for card-not-present transactions at this location, per PSD2 Strong Customer Authentication (SCA) or merchant policy.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the merchant location (e.g., America/New_York, Europe/London) used for transaction timestamp normalization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this merchant location record was last modified.',
    `website_url` STRING COMMENT 'Website URL specific to this merchant location, if applicable (e.g., location-specific landing page).',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Represents a physical or virtual merchant outlet location associated with a merchant entity. Stores location name, address (street, city, state, postal code, country), location type (physical storefront, kiosk, online, mPOS), operating hours, geo-coordinates, timezone, and location-level MCC override. A single merchant may operate multiple locations each with independent settlement and terminal configurations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` (
    `merchant_contact_id` BIGINT COMMENT 'Unique identifier for the merchant contact record. Primary key.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant entity this contact is associated with. Links contact to the parent merchant record for relationship management.',
    `can_receive_dispute_notifications` BOOLEAN COMMENT 'Indicates whether this contact should receive chargeback and dispute notifications. Enables targeted communication for time-sensitive dispute response requirements.',
    `can_receive_pci_data` BOOLEAN COMMENT 'Indicates whether this contact is authorized to receive communications containing Payment Card Industry (PCI) sensitive data. Ensures PCI DSS compliance in data transmission.',
    `can_receive_settlement_reports` BOOLEAN COMMENT 'Indicates whether this contact should receive settlement and funding reports. Used for financial reconciliation and treasury management communications.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the merchant contact record. Determines whether the contact should receive communications and appear in active contact lists.. Valid values are `active|inactive|suspended|pending_verification`',
    `contact_type` STRING COMMENT 'Classification of the contact role within the merchant organization. Determines the purpose and scope of communication with this contact.. Valid values are `primary_business|billing|technical|dispute|compliance|support`',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this contact record. Supports audit trail and accountability for data governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was first created in the system. Provides audit trail for data lineage and compliance reporting.',
    `department` STRING COMMENT 'Business unit or department within the merchant organization where the contact works. Used for routing communications to appropriate functional areas.',
    `effective_from_date` DATE COMMENT 'Date when this contact record became active and valid for the merchant relationship. Supports temporal tracking and audit requirements.',
    `effective_to_date` DATE COMMENT 'Date when this contact record ceased to be active for the merchant relationship. Null for currently active contacts. Supports historical tracking and compliance audit trails.',
    `email_address` STRING COMMENT 'Primary email address for electronic communication with the merchant contact. Used for transaction notifications, dispute correspondence, and operational alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the contact has opted out of marketing or non-essential email communications. Required for GDPR and CCPA compliance.',
    `fax_number` STRING COMMENT 'Facsimile number for document transmission. Used for formal dispute documentation and regulatory correspondence requiring written records.',
    `first_name` STRING COMMENT 'Given name of the merchant contact person. Used for personalized communication and identification.',
    `is_authorized_signer` BOOLEAN COMMENT 'Indicates whether this contact has legal authority to sign contracts and agreements on behalf of the merchant. Critical for KYC and contract execution workflows.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for the merchant. Used to prioritize communication routing and escalation paths.',
    `job_title` STRING COMMENT 'Professional title or position of the contact within the merchant organization. Indicates authority level and functional responsibility.',
    `kyc_expiry_date` DATE COMMENT 'Date when the current KYC verification expires and re-verification is required. Supports periodic review requirements under AML and CTF regulations.',
    `kyc_verification_date` DATE COMMENT 'Date when KYC verification was completed for this contact. Used to track verification currency and trigger re-verification workflows per regulatory requirements.',
    `kyc_verification_status` STRING COMMENT 'Status of identity verification and KYC checks for this contact. Required for compliance with AML and CTF regulations for authorized signers and key contacts.. Valid values are `not_started|pending|verified|failed|expired`',
    `last_contact_date` DATE COMMENT 'Date of the most recent communication or interaction with this contact. Used for relationship management and contact data quality maintenance.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system account that last modified this contact record. Supports audit trail and accountability for data changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this contact record. Critical for change tracking, audit trails, and data synchronization.',
    `last_name` STRING COMMENT 'Family name or surname of the merchant contact person. Used for formal identification and communication.',
    `middle_name` STRING COMMENT 'Middle name or initial of the merchant contact person. Optional field for complete name representation.',
    `mobile_number` STRING COMMENT 'Mobile or cellular phone number for SMS notifications and mobile communication. Used for time-sensitive alerts and two-factor authentication.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special instructions, or relationship notes about the contact. Supports relationship management and customer service quality.',
    `phone_extension` STRING COMMENT 'Internal extension number for direct routing within the merchant organization phone system. Enables direct contact bypass of main switchboard.',
    `phone_number` STRING COMMENT 'Primary telephone number for voice communication with the merchant contact. Used for urgent matters, dispute resolution, and relationship management.',
    `preferred_communication_channel` STRING COMMENT 'Contacts preferred method for receiving communications from the payment processor. Ensures compliance with communication preferences and improves response rates.. Valid values are `email|phone|mobile|fax|portal`',
    `preferred_language` STRING COMMENT 'ISO 639-2 three-letter language code indicating the contacts preferred language for communication. Supports multilingual merchant base and regulatory compliance in international markets.. Valid values are `^[A-Z]{3}$`',
    `sms_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the contact has opted out of SMS or text message communications. Required for compliance with telecommunications regulations and privacy laws.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this contact record. Supports data lineage tracking and multi-system integration scenarios.',
    `source_system_code` STRING COMMENT 'Unique identifier of this contact in the source operational system. Enables cross-system reconciliation and bidirectional data synchronization.',
    `status_reason` STRING COMMENT 'Explanation or reason code for the current contact status. Provides audit trail for status changes and supports compliance documentation.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts location. Used for scheduling communications during business hours and timestamping interactions appropriately.',
    CONSTRAINT pk_merchant_contact PRIMARY KEY(`merchant_contact_id`)
) COMMENT 'Stores named contacts associated with a merchant entity — including primary business contact, billing contact, technical integration contact, and dispute contact. Captures full name, title, role type, email, phone, preferred communication channel, and contact status. Supports multi-contact management per merchant for relationship and operational communications.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` (
    `kyb_verification_id` BIGINT COMMENT 'Unique identifier for the KYB verification record. Primary key for the KYB verification entity.',
    `compliance_kyc_verification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_kyc_verification. Business justification: KYB verification results are derived from detailed compliance KYC verification records; linking provides traceability for regulatory audits and risk assessments.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: KYB verifications are performed on legal entities per AML/FATF regulatory requirements. Linking kyb_verification to legal_entity enables regulatory reporting of entity-level KYB status and supports on',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: KYB verification includes sanctions screening as a mandatory component. The sanctions_screening_result on kyb_verification is denormalized — the FK to the sanctions_check record that performed the scr',
    `adverse_media_check_result` STRING COMMENT 'Outcome of adverse media screening to identify negative news, criminal activity, fraud, or reputational risks associated with the business entity.. Valid values are `pass|fail|negative_news_found|not_performed`',
    `aml_screening_result` STRING COMMENT 'Outcome of Anti-Money Laundering screening checks to identify potential money laundering risks or suspicious activity patterns.. Valid values are `pass|fail|alert_triggered|not_performed`',
    `business_identity_check_result` STRING COMMENT 'Outcome of the business entity identity verification check confirming legal existence, registration status, and business name match against official registries.. Valid values are `pass|fail|inconclusive|not_performed`',
    `business_type` STRING COMMENT 'Legal structure type of the business entity verified during KYB (e.g., corporation, limited liability company, partnership, sole proprietorship).. Valid values are `corporation|llc|partnership|sole_proprietorship|non_profit|trust`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYB verification record was first created in the system, marking the initiation of the verification process.',
    `ctf_screening_result` STRING COMMENT 'Outcome of Counter-Terrorism Financing screening checks to identify potential terrorism financing risks or connections to terrorist organizations.. Valid values are `pass|fail|alert_triggered|not_performed`',
    `data_sources_used` STRING COMMENT 'Comma-separated list of data sources and registries consulted during KYB verification (e.g., Companies House, Dun & Bradstreet, OFAC SDN, Dow Jones Watchlist).',
    `document_types_verified` STRING COMMENT 'Comma-separated list of document types that were verified during the KYB process (e.g., articles of incorporation, business license, tax ID certificate, bank statement).',
    `document_verification_status` STRING COMMENT 'Status of business document verification including articles of incorporation, business licenses, tax certificates, and other supporting documentation.. Valid values are `verified|failed|incomplete|pending|not_required`',
    `incorporation_date` DATE COMMENT 'Date when the business entity was officially incorporated or registered as verified during KYB checks.',
    `manual_review_reason` STRING COMMENT 'Explanation of why manual compliance review is required, detailing specific alerts, inconclusive checks, or policy triggers.',
    `manual_review_required_flag` BOOLEAN COMMENT 'Boolean indicator that the KYB verification results require manual review by compliance officers due to inconclusive results, risk alerts, or policy exceptions.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic KYB re-verification or refresh based on risk tier and regulatory requirements for ongoing due diligence.',
    `ofac_screening_result` STRING COMMENT 'Specific outcome of screening against the US Office of Foreign Assets Control Specially Designated Nationals and Blocked Persons List.. Valid values are `pass|fail|match_found|not_performed`',
    `overall_kyb_decision` STRING COMMENT 'Final pass or fail decision for the KYB verification determining whether the merchant is approved for onboarding, rejected, conditionally approved, or requires manual review.. Valid values are `approved|rejected|conditional_approval|manual_review_required`',
    `pep_screening_result` STRING COMMENT 'Outcome of screening to identify if the business or its beneficial owners are politically exposed persons requiring enhanced due diligence.. Valid values are `pass|fail|match_found|not_performed`',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the KYB verification was rejected or failed, including specific check failures and compliance concerns.',
    `review_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when manual compliance review of the KYB verification was completed and final decision was rendered.',
    `review_notes` STRING COMMENT 'Internal compliance notes and comments recorded by the reviewer during manual review of the KYB verification, documenting decision rationale.',
    `risk_factors` STRING COMMENT 'Comma-separated list of specific risk factors identified during KYB verification (e.g., high-risk MCC, high-risk jurisdiction, adverse media, PEP association).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score calculated by the verification provider based on all KYB checks, typically ranging from 0 to 100 with higher scores indicating greater risk.',
    `risk_tier` STRING COMMENT 'Risk classification tier assigned to the merchant based on KYB verification results, determining the level of ongoing monitoring and due diligence required.. Valid values are `low|medium|high|prohibited`',
    `ubo_count` STRING COMMENT 'Number of Ultimate Beneficial Owners identified and verified during the KYB process who meet the ownership or control threshold.',
    `ubo_screening_result` STRING COMMENT 'Outcome of the Ultimate Beneficial Owner screening check verifying individuals who own or control 25% or more of the business entity.. Valid values are `pass|fail|inconclusive|not_performed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYB verification record was last modified, tracking changes to verification status, results, or review outcomes.',
    `verification_cost_amount` DECIMAL(18,2) COMMENT 'Cost charged by the verification provider for performing the KYB verification checks, used for cost tracking and merchant billing.',
    `verification_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the verification cost amount.. Valid values are `^[A-Z]{3}$`',
    `verification_date` DATE COMMENT 'Date when the KYB verification was performed and results were received from the verification provider.',
    `verification_expiry_date` DATE COMMENT 'Date when the current KYB verification expires and requires renewal to maintain merchant compliance status.',
    `verification_method` STRING COMMENT 'Method used to perform the KYB verification indicating whether checks were fully automated, manual, or a hybrid combination.. Valid values are `automated|manual|hybrid`',
    `verification_provider` STRING COMMENT 'Name of the third-party KYB verification service provider that performed the business identity and compliance checks (e.g., Refinitiv, LexisNexis, Dow Jones).',
    `verification_reference_number` STRING COMMENT 'External reference number assigned by the verification provider for tracking and audit purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `verification_status` STRING COMMENT 'Current lifecycle status of the KYB verification process indicating whether checks are pending, in progress, completed successfully, failed, expired, or require manual review.. Valid values are `pending|in_progress|completed|failed|expired|manual_review`',
    CONSTRAINT pk_kyb_verification PRIMARY KEY(`kyb_verification_id`)
) COMMENT 'Records the Know Your Business (KYB) verification outcome for a merchant entity. Captures verification provider, verification date, business identity check result, UBO (Ultimate Beneficial Owner) screening result, sanctions/OFAC screening result, adverse media check, document verification status, risk tier assigned, and overall KYB pass/fail decision. Supports AML and regulatory compliance requirements for merchant onboarding.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` (
    `beneficial_owner_id` BIGINT COMMENT 'Unique identifier for the beneficial owner record. Primary key for the beneficial owner entity.',
    `application_id` BIGINT COMMENT 'Foreign key linking to merchant.application. Business justification: Beneficial owner (UBO) records are initially submitted as part of the merchant onboarding application. application captures owner_first_name, owner_last_name, owner_ssn, owner_date_of_birth, and owner',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: Beneficial owners who are PEPs, sanctions matches, or adverse media subjects trigger compliance cases for investigation. The beneficial_owner record must reference the compliance case opened against t',
    `kyb_verification_id` BIGINT COMMENT 'Foreign key linking to merchant.kyb_verification. Business justification: Beneficial owner (UBO) records are collected and screened as part of the KYB verification process. kyb_verification has ubo_count and ubo_screening_result fields that aggregate UBO data, confirming th',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant entity for which this beneficial owner record applies. Links the UBO to the merchant undergoing KYC/KYB verification.',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Beneficial owners are the primary subjects of KYC/AML screening in the compliance domain and must be represented as compliance parties. This foundational link enables AML screening results, SAR filing',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Each beneficial owner undergoes mandatory sanctions screening as part of KYB onboarding and periodic refresh. The sanctions_screening_status on beneficial_owner is denormalized — the FK to the actual ',
    `watchlist_entry_id` BIGINT COMMENT 'Foreign key linking to compliance.watchlist_entry. Business justification: When a beneficial owner matches a sanctions/watchlist entry, that match must be recorded on the beneficial_owner record for ongoing monitoring and SAR filing decisions. This is a core KYB/AML requirem',
    `adverse_media_screening_date` TIMESTAMP COMMENT 'Timestamp when the most recent adverse media screening was performed on the beneficial owner.',
    `adverse_media_screening_status` STRING COMMENT 'Result of adverse media screening to identify negative news or reputational risks associated with the beneficial owner. Part of enhanced due diligence process.. Valid values are `clear|match|potential_match|pending|not_screened`',
    `aml_risk_rating` STRING COMMENT 'Overall AML risk rating assigned to the beneficial owner based on risk factors including PEP status, sanctions screening, country risk, and ownership structure.. Valid values are `low|medium|high|prohibited`',
    `beneficial_owner_status` STRING COMMENT 'Current lifecycle status of the beneficial owner record. Indicates whether the record is active, under review, or has been rejected due to compliance issues.. Valid values are `active|inactive|suspended|under_review|rejected`',
    `control_role` STRING COMMENT 'Role or position held by the beneficial owner that grants significant control over the merchant entity. Required for FinCEN CDD Rule compliance to identify individuals with control authority. [ENUM-REF-CANDIDATE: director|officer|shareholder|trustee|beneficiary|authorized_signatory|other — 7 candidates stripped; promote to reference product]',
    `control_role_description` STRING COMMENT 'Detailed description of the beneficial owners control role and responsibilities within the merchant entity. Provides context for the nature of control exercised.',
    `country_of_residence` STRING COMMENT 'Country where the beneficial owner currently resides using ISO 3166-1 alpha-3 country code. Used for tax reporting and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the beneficial owner record was first created in the system. Used for audit trail and data lineage.',
    `date_of_birth` DATE COMMENT 'Date of birth of the beneficial owner in yyyy-MM-dd format. Required for identity verification, age validation, and AML screening under FinCEN CDD Rule.',
    `effective_from_date` DATE COMMENT 'Date from which the beneficial owner relationship with the merchant entity became effective. Used for temporal tracking of ownership changes.',
    `effective_to_date` DATE COMMENT 'Date when the beneficial owner relationship with the merchant entity ended. Null for currently active beneficial owners.',
    `first_name` STRING COMMENT 'Given name or first name of the beneficial owner. Used for identity verification and screening purposes.',
    `full_legal_name` STRING COMMENT 'Complete legal name of the beneficial owner as it appears on government-issued identification documents. Required for BSA/AML compliance and identity verification.',
    `government_id_expiration_date` DATE COMMENT 'Expiration date of the government-issued identification document. Used to ensure validity of identity verification.',
    `government_id_issuing_country` STRING COMMENT 'Country that issued the government identification document using ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `government_id_number` STRING COMMENT 'Unique identification number from the government-issued document. Encrypted at rest and used for identity verification and AML screening.',
    `government_id_type` STRING COMMENT 'Type of government-issued identification document provided by the beneficial owner for identity verification. Required under FinCEN CDD Rule.. Valid values are `passport|national_id|drivers_license|tax_id|social_security|other`',
    `identity_verification_date` TIMESTAMP COMMENT 'Timestamp when the beneficial owners identity was successfully verified. Required for audit trail and compliance reporting.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the identity of the beneficial owner. Supports multiple verification channels to meet regulatory requirements.. Valid values are `document_upload|in_person|video_call|third_party_service|database_verification|biometric`',
    `identity_verification_provider` STRING COMMENT 'Name of the third-party service or internal system used to perform identity verification. Used for audit trail and vendor management.',
    `identity_verification_status` STRING COMMENT 'Status of the identity verification process for the beneficial owner. Indicates whether identity has been successfully verified, is pending review, or has failed verification checks.. Valid values are `verified|pending|failed|expired|not_started`',
    `is_pep` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficial owner is a Politically Exposed Person. PEPs require enhanced due diligence under FATF recommendations and AML regulations.',
    `kyc_refresh_due_date` DATE COMMENT 'Date when the beneficial owner KYC information is due for periodic refresh and re-verification. Required for ongoing due diligence under AML regulations.',
    `last_name` STRING COMMENT 'Surname or family name of the beneficial owner. Required for identity verification and AML screening.',
    `middle_name` STRING COMMENT 'Middle name or initial of the beneficial owner. Optional field for enhanced identity matching.',
    `nationality` STRING COMMENT 'Country of citizenship of the beneficial owner using ISO 3166-1 alpha-3 country code. Required for sanctions screening and cross-border compliance.. Valid values are `^[A-Z]{3}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership stake held by the beneficial owner in the merchant entity. FinCEN CDD Rule requires disclosure for owners with 25% or more equity interest.',
    `pep_classification` STRING COMMENT 'Classification of the PEP status indicating whether the individual is a domestic PEP, foreign PEP, member of international organization, family member, or close associate of a PEP.. Valid values are `domestic|foreign|international_organization|family_member|close_associate|not_applicable`',
    `pep_position_title` STRING COMMENT 'Title or position held by the beneficial owner that qualifies them as a PEP. Examples include government official, senior executive of state-owned enterprise, or high-ranking military officer.',
    `residential_address_line1` STRING COMMENT 'Primary street address line of the beneficial owners residential address. Required for identity verification and KYC compliance.',
    `residential_address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number of the beneficial owners residential address.',
    `residential_city` STRING COMMENT 'City or municipality of the beneficial owners residential address.',
    `residential_country` STRING COMMENT 'Country of the beneficial owners residential address using ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `residential_postal_code` STRING COMMENT 'Postal or ZIP code of the beneficial owners residential address.',
    `residential_state_province` STRING COMMENT 'State, province, or region of the beneficial owners residential address.',
    `sanctions_match_details` STRING COMMENT 'Details of any sanctions list matches including list name, match score, and reason for match. Used for investigation and resolution of potential sanctions violations.',
    `sanctions_screening_date` TIMESTAMP COMMENT 'Timestamp when the most recent sanctions screening was performed on the beneficial owner. Required for audit trail and compliance monitoring.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions screening against OFAC, UN, EU, and other sanctions lists. Indicates whether the beneficial owner is clear, has a match, or requires further review.. Valid values are `clear|match|potential_match|pending|not_screened`',
    `source_of_funds` STRING COMMENT 'Description of the origin of funds used by the beneficial owner in the merchant relationship. Required for enhanced due diligence and AML compliance.',
    `source_of_wealth` STRING COMMENT 'Description of how the beneficial owner accumulated their wealth. Required for enhanced due diligence on high-risk individuals and PEPs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the beneficial owner record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_beneficial_owner PRIMARY KEY(`beneficial_owner_id`)
) COMMENT 'Captures the Ultimate Beneficial Owner (UBO) records for a merchant entity as required by BSA/AML regulations. Stores owner full name, date of birth, nationality, government ID type and number, ownership percentage, control role (director, officer, shareholder), PEP (Politically Exposed Person) flag, sanctions screening status, and identity verification outcome. Regulatory requirement for FinCEN CDD Rule compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` (
    `merchant_account_id` BIGINT COMMENT 'Unique identifier for the merchant processing account. Primary key.',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: A merchant account is processed by a specific acquirer that handles its transaction settlement. Acquirer-level processing limits, settlement currency, and cutoff times are configured per merchant acco',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Merchant processing accounts map to GL clearing accounts for transaction posting and daily settlement reconciliation. Each merchant account (card-present, card-not-present) posts to a specific GL clea',
    `dcc_config_id` BIGINT COMMENT 'Foreign key linking to fx.dcc_config. Business justification: DCC is enabled at account level (dynamic_currency_conversion_enabled flag exists). Different merchant accounts (e.g., card-present vs CNP) may use distinct DCC configs. This link operationalizes which',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Merchant accounts with multi_currency_enabled or dynamic_currency_conversion_enabled are subject to FX fee schedules. This link drives accurate FX fee billing, merchant statement generation, and prici',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: A merchant accounts processing capabilities (card-present, CNP, 3DS, tokenization) determine its interchange qualification tier. Linking merchant_account to irf_rate_category enables account-level in',
    `merchant_id` BIGINT COMMENT 'Reference to the parent merchant entity that owns this processing account.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: A merchant_accounts processing capabilities (CNP, tokenization, 3DS, multi-currency) are governed by its gateway integration configuration. Authorization routing and capability checks require this li',
    `merchant_pricing_plan_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_pricing_plan. Business justification: A merchant_account (the operational processing account) must reference the pricing plan that governs its MDR, fee structure, and interchange markup. This is a fundamental operational link: the account',
    `merchant_settlement_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_settlement_account. Business justification: A merchant_account (processing account) must be linked to the settlement account where funds are disbursed after batch settlement. This is a core operational relationship in payments: the processing a',
    `multi_network_routing_id` BIGINT COMMENT 'Foreign key linking to network.multi_network_routing. Business justification: Durbin Amendment (Regulation II) requires debit transactions to be routable over at least two unaffiliated networks. Each merchant account must be assigned a multi-network routing profile governing de',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Each merchant account maps to a settlement participant for net position calculation and settlement instruction routing. Large multi-account merchants may have account-level participant assignments dis',
    `pci_compliance_id` BIGINT COMMENT 'Foreign key linking to merchant.pci_compliance. Business justification: merchant_account currently stores pci_compliance_level, pci_compliance_status, and pci_validation_date as denormalized fields. pci_compliance is the authoritative SSOT for PCI DSS compliance tracking.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Transaction authorization and real-time fraud monitoring systems look up the risk_profile associated with a merchant_account to apply account-level risk controls (velocity limits, 3DS requirements, SC',
    `threeds_config_id` BIGINT COMMENT 'Foreign key linking to gateway.threeds_config. Business justification: merchant_account has three_ds_required and three_ds_version as denormalized fields. The authoritative 3DS configuration (challenge preference, exemption rules, protocol version) governing a merchant_a',
    `account_number` STRING COMMENT 'Externally-visible unique account number assigned to this processing account for identification in statements and reports.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the merchant processing account. Active accounts can process transactions; suspended/restricted accounts have limited processing; closed accounts are terminated.. Valid values are `active|suspended|closed|pending_activation|restricted|frozen`',
    `account_type` STRING COMMENT 'Classification of the processing account model: standard merchant account, Payment Facilitator (PayFac) sub-merchant account, Independent Sales Organization (ISO) account, aggregator account, marketplace account, or direct acquiring account.. Valid values are `standard|payfac|iso|aggregator|marketplace|direct`',
    `activation_date` DATE COMMENT 'Date when the merchant account was activated and became eligible to process transactions.',
    `avs_check_enabled` BOOLEAN COMMENT 'Indicates whether Address Verification System checks are enabled for card-not-present transactions to validate cardholder billing address.',
    `batch_settlement_enabled` BOOLEAN COMMENT 'Indicates whether this account uses batch settlement processing where transactions are grouped and settled in scheduled batches rather than real-time settlement.',
    `card_not_present_enabled` BOOLEAN COMMENT 'Indicates whether this account is authorized to process card-not-present transactions such as e-commerce, mail order, or telephone order (MOTO) payments.',
    `card_present_enabled` BOOLEAN COMMENT 'Indicates whether this account is authorized to process card-present transactions via Point of Sale (POS) or mobile Point of Sale (mPOS) terminals.',
    `chargeback_threshold_percentage` DECIMAL(18,2) COMMENT 'Maximum acceptable chargeback ratio (chargebacks divided by total transactions) expressed as a percentage. Exceeding this threshold may trigger account review or restrictions per card scheme monitoring programs.',
    `closure_date` DATE COMMENT 'Date when the merchant account was closed or terminated. Null for active accounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this merchant account record was first created in the system.',
    `cross_border_processing_enabled` BOOLEAN COMMENT 'Indicates whether this account is authorized to process cross-border transactions where the cardholder and merchant are in different countries.',
    `cvv_check_enabled` BOOLEAN COMMENT 'Indicates whether Card Verification Value (CVV/CVV2/CVC) validation is enabled for card-not-present transactions to verify card possession.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total transaction volume (in processing currency) that this account is permitted to process within a single calendar day. Used for risk management and velocity controls.',
    `dynamic_currency_conversion_enabled` BOOLEAN COMMENT 'Indicates whether this account is enabled for Dynamic Currency Conversion, allowing cardholders to see and pay in their home currency at the point of sale.',
    `enhanced_monitoring_required` BOOLEAN COMMENT 'Indicates whether this account is subject to enhanced transaction monitoring due to elevated risk profile, regulatory requirements, or past compliance issues.',
    `fraud_threshold_percentage` DECIMAL(18,2) COMMENT 'Maximum acceptable fraud ratio (fraudulent transactions divided by total transactions) expressed as a percentage. Exceeding this threshold may trigger enhanced fraud controls or account restrictions.',
    `installment_payment_enabled` BOOLEAN COMMENT 'Indicates whether this account supports installment payment plans where a single purchase is split into multiple scheduled payments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this merchant account record was last updated or modified.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction processed through this merchant account. Used for account activity monitoring and dormancy detection.',
    `monthly_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total transaction volume (in processing currency) that this account is permitted to process within a single calendar month. Used for risk management and underwriting controls.',
    `multi_currency_enabled` BOOLEAN COMMENT 'Indicates whether this account is configured to accept and process transactions in multiple currencies beyond the primary processing currency.',
    `real_time_settlement_enabled` BOOLEAN COMMENT 'Indicates whether this account supports real-time or near-real-time settlement where funds are transferred to the merchant immediately or within minutes of transaction authorization.',
    `recurring_billing_enabled` BOOLEAN COMMENT 'Indicates whether this account is configured to support recurring or subscription-based billing transactions.',
    `reserve_account_required` BOOLEAN COMMENT 'Indicates whether this merchant account is required to maintain a reserve account (holdback) to cover potential chargebacks, refunds, or other liabilities.',
    `reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction volume withheld in reserve account to cover potential chargebacks and refunds. Null if no reserve is required.',
    `risk_tier` STRING COMMENT 'Risk classification tier assigned to this merchant account based on underwriting assessment, industry category, transaction patterns, and fraud/chargeback history.. Valid values are `low|medium|high|critical`',
    `sca_exemption_allowed` BOOLEAN COMMENT 'Indicates whether this account is permitted to apply Strong Customer Authentication exemptions for low-risk or low-value transactions under PSD2 regulations.',
    `settlement_delay_days` STRING COMMENT 'Number of business days between transaction capture and settlement disbursement to the merchant. Standard is T+1 or T+2; higher-risk accounts may have longer delays.',
    `single_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount (in processing currency) permitted for a single transaction on this account. Transactions exceeding this limit will be declined.',
    `supported_card_schemes` STRING COMMENT 'Comma-separated list of card payment networks enabled for this account (e.g., Visa, Mastercard, Amex, Discover, JCB, UnionPay, Diners).',
    `supported_payment_methods` STRING COMMENT 'Comma-separated list of payment methods enabled for this account (e.g., card_present, card_not_present, digital_wallet, ach, bank_transfer, qr_code, bnpl).',
    `three_ds_required` BOOLEAN COMMENT 'Indicates whether 3-D Secure authentication is mandatory for card-not-present transactions on this account to comply with Strong Customer Authentication (SCA) requirements.',
    `tokenization_enabled` BOOLEAN COMMENT 'Indicates whether payment tokenization is enabled for this account to replace sensitive Primary Account Number (PAN) data with non-sensitive tokens.',
    CONSTRAINT pk_merchant_account PRIMARY KEY(`merchant_account_id`)
) COMMENT 'Represents the processing account configuration for a merchant — the operational account that governs transaction processing parameters. Stores account status, processing currency, accepted card schemes (Visa, Mastercard, Amex, Discover), enabled payment methods, 3DS configuration, SCA requirements, AVS/CVV policy settings, transaction velocity limits, and account-level risk controls. Distinct from the merchant settlement bank account.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` (
    `mcc_assignment_id` BIGINT COMMENT 'Unique identifier for the MCC assignment record. Primary key for the MCC assignment entity.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: mcc_assignment has interchange_qualification_impact as a plain denormalized attribute. MCC directly determines IRF rate category qualification. Linking mcc_assignment to irf_rate_category replaces the',
    `location_id` BIGINT COMMENT 'Reference to the specific merchant location or outlet for which this MCC is assigned. Nullable if MCC applies to the entire merchant entity rather than a specific location.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant to whom this MCC is assigned. Links to the merchant master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MCC codes trigger specific regulatory reporting obligations (e.g., gambling MCCs require enhanced monitoring under BSA/AML; certain MCCs trigger CTR filing requirements). The regulatory_reporting_cate',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: MCC assignments require scheme approval (Visa/Mastercard must approve MCC changes). The mcc_assignment already tracks scheme_approval_date, scheme_approval_reference, and scheme_approval_required_flag',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the MCC assignment was approved by the designated approver. Nullable if approval is not required or has not yet occurred.',
    `assigning_authority` STRING COMMENT 'Entity that assigned or approved the MCC. Can be a card scheme (Visa, Mastercard, Amex, Discover) or the acquiring bank/payment facilitator. Determines the authoritative source for the MCC classification.. Valid values are `visa|mastercard|amex|discover|acquirer|internal`',
    `assignment_date` DATE COMMENT 'Date on which the MCC was assigned to the merchant or merchant location. Represents the business event date of the assignment decision.',
    `assignment_rationale` STRING COMMENT 'Free-text explanation or business justification for the MCC assignment. May include details about the merchants primary business activity, product mix, or regulatory considerations that influenced the MCC selection.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the MCC assignment. Active assignments are used for transaction processing; pending assignments await approval; suspended or revoked assignments are temporarily or permanently disabled.. Valid values are `active|inactive|pending|suspended|expired|revoked`',
    `change_reason` STRING COMMENT 'Categorized reason for changing the MCC from a previous assignment. Applicable only when previous_mcc_code is populated. Used for audit trail and compliance reporting. [ENUM-REF-CANDIDATE: business_change|correction|scheme_mandate|fraud_mitigation|merchant_request|regulatory_requirement|audit_finding|other — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MCC assignment record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date from which the MCC assignment becomes active and is used for transaction processing, interchange qualification, and reporting. May differ from assignment_date if there is a planned future activation.',
    `expiry_date` DATE COMMENT 'Date on which the MCC assignment expires or is no longer valid. Nullable for open-ended assignments. Used to track MCC changes and historical assignments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MCC assignment record was last updated or modified. Used for audit trail and change tracking.',
    `mcc_code` STRING COMMENT 'Four-digit code that classifies the merchants type of business. Determines interchange rates, spending category analytics, and fraud risk profiling. Assigned by card schemes (Visa, Mastercard) or acquirer.. Valid values are `^[0-9]{4}$`',
    `mcc_description` STRING COMMENT 'Human-readable description of the MCC code, describing the business category (e.g., Grocery Stores and Supermarkets, Airlines, Hotels and Motels).',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this MCC assignment. May include operational details, special instructions, or historical context.',
    `previous_mcc_code` STRING COMMENT 'The MCC code that was previously assigned to this merchant or location before the current assignment. Nullable for initial assignments. Used to track MCC change history and analyze reclassification patterns.. Valid values are `^[0-9]{4}$`',
    `risk_category` STRING COMMENT 'Risk classification associated with this MCC for fraud detection and prevention purposes. High-risk MCCs (e.g., gambling, adult entertainment, travel) trigger enhanced monitoring and fraud rules.. Valid values are `low|medium|high|prohibited`',
    `scheme_approval_date` DATE COMMENT 'Date on which the card scheme approved this MCC assignment. Nullable if scheme approval is not required or has not yet been obtained.',
    `scheme_approval_reference` STRING COMMENT 'Reference number or case ID provided by the card scheme when approving this MCC assignment. Used for audit trail and dispute resolution.',
    `scheme_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this MCC assignment requires explicit approval from the card scheme (Visa, Mastercard, etc.) before it can be activated. True for high-risk or restricted MCCs.',
    `source_system` STRING COMMENT 'Name or identifier of the operational system from which this MCC assignment record originated (e.g., Merchant Management System, CRM, card scheme portal).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this MCC assignment record in the source operational system. Used for data lineage and reconciliation.',
    CONSTRAINT pk_mcc_assignment PRIMARY KEY(`mcc_assignment_id`)
) COMMENT 'Records the Merchant Category Code (MCC) assignment for a merchant or merchant location, including the assigned MCC value, assignment date, assigning authority (card scheme or acquirer), assignment rationale, previous MCC if changed, effective date, and expiry date. Tracks MCC history for interchange qualification, fraud risk profiling, and regulatory reporting. MCC drives interchange rate eligibility and spending category analytics.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` (
    `merchant_pricing_plan_id` BIGINT COMMENT 'Unique identifier for the pricing plan. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Pricing plans define fee structures (MDR, interchange markup, per-transaction fees) that map to GL revenue accounts for automated subledger posting. Payments fintechs require this link to drive GL der',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: merchant_pricing_plan has interchange_markup_percentage and interchange_passthrough_flag defined relative to a specific IRF rate category baseline. This link is required for interchange-plus pricing c',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: A merchant pricing plan (especially interchange-plus or tiered models) is built on a specific interchange program. Linking pricing plan to program is required for interchange-plus margin calculation, ',
    `revenue_share_schedule_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_schedule. Business justification: In ISO/PayFac models, a merchant pricing plans MDR split and residual rates are directly governed by the partners revenue share schedule. This link is essential for pricing configuration, partner re',
    `ach_transaction_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per ACH (bank transfer) transaction processed for the merchant, expressed in the plans base currency. Typically lower than card transaction fees.',
    `amex_rate_percentage` DECIMAL(18,2) COMMENT 'Separate MDR percentage applied specifically to American Express card transactions, which often have different pricing than Visa/Mastercard, expressed as a decimal.',
    `avs_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per transaction when Address Verification System (AVS) checks are performed, expressed in the plans base currency. Helps reduce fraud risk for card-not-present transactions.',
    `batch_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per settlement batch submitted by the merchant, expressed in the plans base currency. Applies to merchants using batch settlement rather than real-time capture.',
    `chargeback_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the merchant for each chargeback dispute, regardless of outcome, expressed in the plans base currency. Covers administrative and processing costs.',
    `contract_term_months` STRING COMMENT 'The minimum contract duration in months that the merchant must commit to when assigned this pricing plan. Null for month-to-month plans.',
    `created_by_user` STRING COMMENT 'Identifier of the system user or administrator who created this pricing plan record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing plan record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_conversion_markup_percentage` DECIMAL(18,2) COMMENT 'Markup percentage applied to the foreign exchange (FX) rate when Dynamic Currency Conversion (DCC) is offered to cardholders, expressed as a decimal (e.g., 0.0300 for 3.00% above spot rate).',
    `debit_card_rate_percentage` DECIMAL(18,2) COMMENT 'MDR percentage applied specifically to debit card transactions, typically lower than credit card rates due to Regulation II (Durbin Amendment) caps, expressed as a decimal.',
    `early_termination_fee_amount` DECIMAL(18,2) COMMENT 'Penalty fee charged if the merchant terminates the agreement before the contract term expires, expressed in the plans base currency. Null if no early termination penalty applies.',
    `effective_date` DATE COMMENT 'The date from which this pricing plan becomes binding and applicable to assigned merchants. Transactions on or after this date are governed by this plans terms.',
    `expiry_date` DATE COMMENT 'The date on which this pricing plan ceases to be valid. Nullable for open-ended plans. Transactions after this date require a new plan assignment.',
    `interchange_markup_percentage` DECIMAL(18,2) COMMENT 'The markup percentage added on top of the actual interchange cost in interchange-plus pricing models (e.g., 0.0050 for 0.50% above interchange). Null for non-interchange-plus models.',
    `interchange_passthrough_flag` BOOLEAN COMMENT 'Indicates whether actual interchange fees (IRF) are passed through to the merchant at cost (true) or absorbed into a blended rate (false). True for interchange-plus and cost-plus models.',
    `international_transaction_fee_percentage` DECIMAL(18,2) COMMENT 'Additional percentage fee applied to cross-border transactions where the card issuer is in a different country than the merchant, expressed as a decimal (e.g., 0.0100 for 1.00%).',
    `mdr_rate_percentage` DECIMAL(18,2) COMMENT 'The base percentage rate charged to the merchant per transaction, expressed as a decimal (e.g., 0.0275 for 2.75%). This is the primary revenue component for flat-rate and blended pricing models.',
    `merchant_pricing_plan_status` STRING COMMENT 'Current lifecycle status of the pricing plan. Active plans are available for assignment; inactive plans are no longer offered but may still govern existing merchants; pending plans are under approval; suspended plans are temporarily unavailable; archived plans are historical records only.. Valid values are `active|inactive|pending|suspended|archived`',
    `mid_qualified_rate_percentage` DECIMAL(18,2) COMMENT 'The middle MDR percentage tier in tiered pricing models, applied to transactions that partially meet qualification criteria (e.g., keyed-in transactions, rewards cards), expressed as a decimal.',
    `monthly_account_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monthly account maintenance or service fee charged to the merchant, independent of transaction volume, expressed in the plans base currency.',
    `monthly_minimum_fee_amount` DECIMAL(18,2) COMMENT 'The minimum monthly fee the merchant must pay regardless of transaction volume, expressed in the plans base currency. If monthly processing fees fall below this threshold, the merchant is charged the difference.',
    `non_qualified_rate_percentage` DECIMAL(18,2) COMMENT 'The highest MDR percentage tier in tiered pricing models, applied to transactions that fail qualification criteria (e.g., corporate cards, international cards, manually entered), expressed as a decimal.',
    `payfac_sub_merchant_eligible_flag` BOOLEAN COMMENT 'Indicates whether this pricing plan is available for assignment to sub-merchants under a Payment Facilitator (PayFac) model. True if eligible for PayFac sub-merchants; false if only for direct merchants.',
    `pci_compliance_fee_amount` DECIMAL(18,2) COMMENT 'Annual or monthly fee charged to merchants for PCI DSS compliance program administration, security scanning, and attestation support, expressed in the plans base currency.',
    `pci_non_compliance_penalty_amount` DECIMAL(18,2) COMMENT 'Monthly penalty fee charged to merchants who fail to maintain PCI DSS compliance, expressed in the plans base currency. Escalates with duration of non-compliance.',
    `per_transaction_fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee charged per transaction in addition to the percentage-based MDR, expressed in the plans base currency (e.g., 0.10 for $0.10 per transaction).',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the pricing plan, used in contracts and merchant communications.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the pricing plan, including key features, target merchant segments, and value proposition.',
    `plan_name` STRING COMMENT 'Human-readable name of the pricing plan (e.g., Standard Retail, Enterprise Plus, Startup Flat Rate).',
    `pricing_model_type` STRING COMMENT 'The fundamental pricing structure applied to merchant transactions. Flat-rate charges a single percentage; interchange-plus passes through interchange costs plus a markup; tiered groups transactions into qualified/mid-qualified/non-qualified buckets; blended averages all transaction types; cost-plus adds a fixed margin to actual costs; custom indicates bespoke negotiated terms.. Valid values are `flat_rate|interchange_plus|tiered|blended|cost_plus|custom`',
    `qualified_rate_percentage` DECIMAL(18,2) COMMENT 'The lowest MDR percentage tier in tiered pricing models, applied to transactions that meet all qualification criteria (e.g., swiped consumer credit cards), expressed as a decimal.',
    `refund_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the merchant for processing a refund or credit transaction, expressed in the plans base currency. Some plans waive this fee; others charge per refund.',
    `retrieval_request_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the merchant for each retrieval request (pre-chargeback inquiry) from the issuing bank, expressed in the plans base currency.',
    `setup_fee_amount` DECIMAL(18,2) COMMENT 'One-time fee charged when a merchant is onboarded and assigned to this pricing plan, covering account setup, KYC processing, and initial configuration, expressed in the plans base currency.',
    `statement_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for generating and delivering monthly merchant statements (paper or electronic), expressed in the plans base currency.',
    `updated_by_user` STRING COMMENT 'Identifier of the system user or administrator who last modified this pricing plan record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing plan record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and change tracking.',
    `voice_authorization_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged when a merchant obtains authorization via phone call to the authorization center rather than electronic authorization, expressed in the plans base currency.',
    `volume_tier_threshold_amount` DECIMAL(18,2) COMMENT 'Monthly transaction volume threshold (in base currency) that triggers preferential pricing or tier upgrades. Used in volume-based pricing models where rates decrease as volume increases.',
    CONSTRAINT pk_merchant_pricing_plan PRIMARY KEY(`merchant_pricing_plan_id`)
) COMMENT 'Defines the commercial pricing plan assigned to a merchant — the fee structure governing MDR (Merchant Discount Rate), interchange pass-through model, flat-rate or tiered pricing, monthly minimums, setup fees, PCI compliance fees, and chargeback fees. Stores plan name, pricing model type (flat-rate, interchange-plus, tiered, blended), effective date, expiry date, and negotiated rate overrides. SSOT for merchant commercial pricing configuration.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` (
    `merchant_fee_schedule_id` BIGINT COMMENT 'System-generated unique identifier for each merchant fee schedule record.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Fee schedules in acquiring are often acquirer-specific — different acquirers carry different transaction fees and interchange pass-through rates. Billing reconciliation, acquirer cost analysis, and fe',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee schedule entries must post to specific GL accounts (MDR income, interchange markup, per-transaction fee revenue). Payments fintechs automate journal entry derivation by mapping each fee type to a ',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant to which this fee schedule applies.',
    `merchant_pricing_plan_id` BIGINT COMMENT 'Reference to the merchant pricing plan that owns this fee schedule.',
    `merchant_settlement_account_id` BIGINT COMMENT 'Settlement account used for fee revenue collection.',
    `product_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to product.product_fee_schedule. Business justification: Merchant fee schedules are derived from product-level fee schedules. When a product fee schedule is updated, all merchant fee schedules referencing it must be reviewed. Fee management and billing reco',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: merchant_fee_schedule has applicable_scheme and applicable_transaction_type. For interchange-passthrough fee schedules, the fee is defined relative to a specific interchange program. This link is requ',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Fee schedules are scheme-specific (Visa fees differ from Mastercard fees). The existing applicable_scheme plain-text column is a denormalization of network.scheme. Replacing it with a proper FK enab',
    `applicable_transaction_type` STRING COMMENT 'Transaction type that triggers the fee.. Valid values are `purchase|refund|reversal|cashback|auth|capture`',
    `billing_cycle` STRING COMMENT 'Frequency at which a recurring fee is billed.. Valid values are `monthly|quarterly|annually|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee schedule record was first created.',
    `effective_from` DATE COMMENT 'Date when the fee schedule becomes binding.',
    `effective_until` DATE COMMENT 'Date when the fee schedule expires or is superseded (null for open‑ended).',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount applied when fee_basis is flat_monthly or per_transaction.',
    `fee_basis` STRING COMMENT 'Determines how the fee amount is calculated.. Valid values are `per_transaction|percentage|flat_monthly|tiered`',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total fee that can be charged within a billing period.',
    `fee_cap_currency` STRING COMMENT 'Currency for the fee cap amount.',
    `fee_category` STRING COMMENT 'High‑level grouping of the fee purpose.. Valid values are `processing|service|compliance|risk|settlement`',
    `fee_exempt_flag` BOOLEAN COMMENT 'True if the merchant is exempt from this fee under special conditions.',
    `fee_exempt_reason` STRING COMMENT 'Narrative explaining why the fee is exempted.',
    `fee_override_allowed_flag` BOOLEAN COMMENT 'True if the fee amount or rate can be manually overridden for a specific merchant.',
    `fee_override_reason` STRING COMMENT 'Explanation for any manual override of the fee.',
    `fee_percentage` DECIMAL(18,2) COMMENT 'Percentage applied to the transaction amount when fee_basis is percentage.',
    `fee_source` STRING COMMENT 'Origin of the fee definition.. Valid values are `internal|partner|third_party`',
    `fee_taxable_flag` BOOLEAN COMMENT 'Indicates whether the fee is subject to tax.',
    `fee_type` STRING COMMENT 'Specific fee line item such as authorization fee, capture fee, refund fee, chargeback fee, monthly service fee, PCI non‑compliance fee, or early termination fee. [ENUM-REF-CANDIDATE: authorization|capture|refund|chargeback|monthly_service|pci_non_compliance|early_termination — promote to reference product]',
    `fee_version` STRING COMMENT 'Incremental version number for change management.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether the fee recurs on a regular billing cycle.',
    `last_review_date` DATE COMMENT 'Date when the fee schedule was last reviewed for accuracy or compliance.',
    `max_fee_amount` DECIMAL(18,2) COMMENT 'Ceiling amount that the fee will not exceed.',
    `merchant_fee_schedule_description` STRING COMMENT 'Human‑readable description of the fee schedule purpose and any special conditions.',
    `merchant_fee_schedule_status` STRING COMMENT 'Current lifecycle state of the fee schedule.. Valid values are `active|inactive|terminated|pending`',
    `min_fee_amount` DECIMAL(18,2) COMMENT 'Floor amount that the fee will not go below.',
    `priority` STRING COMMENT 'Numeric priority used when multiple schedules could apply; lower numbers have higher precedence.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the fee is mandated by regulatory requirements (e.g., interchange fees).',
    `schedule_code` STRING COMMENT 'Human‑readable code used to reference the fee schedule in merchant contracts and internal systems.',
    `schedule_type` STRING COMMENT 'Indicates the structural type of the fee schedule.. Valid values are `flat|tiered|volume|per_transaction`',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Applicable tax rate when fee_taxable_flag is true.',
    `tier_end_amount` DECIMAL(18,2) COMMENT 'Upper bound of transaction amount for a tiered fee range (exclusive).',
    `tier_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage applied within the defined tier range.',
    `tier_start_amount` DECIMAL(18,2) COMMENT 'Lower bound of transaction amount for a tiered fee range (inclusive).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fee schedule record.',
    CONSTRAINT pk_merchant_fee_schedule PRIMARY KEY(`merchant_fee_schedule_id`)
) COMMENT 'Granular fee line-item schedule associated with a merchant pricing plan. Captures individual fee types (authorization fee, capture fee, refund fee, chargeback fee, monthly service fee, PCI non-compliance fee, early termination fee), fee amount or rate, fee basis (per-transaction, percentage, flat monthly), applicable card scheme, applicable transaction type, and effective date range. Enables detailed merchant billing and revenue recognition.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` (
    `merchant_settlement_account_id` BIGINT COMMENT 'System-generated unique identifier for the settlement account record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Settlement accounts map to GL clearing/suspense accounts for bank reconciliation and settlement accounting. Payments fintechs require this link to reconcile settlement funds in transit against the GL ',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to fx.correspondent_bank. Business justification: International merchant settlement accounts route funds through correspondent banks for cross-border FX settlement. Treasury and settlement operations teams require this link for nostro account reconci',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that owns this settlement account.',
    `account_close_date` DATE COMMENT 'Date when the bank account was closed or de‑activated (nullable).',
    `account_holder_name` STRING COMMENT 'Legal name of the individual or organization that holds the settlement bank account.',
    `account_holder_type` STRING COMMENT 'Indicates whether the account holder is an individual or a legal entity.. Valid values are `individual|organization`',
    `account_number_masked` STRING COMMENT 'Bank account number displayed with masking for security (e.g., ****1234).',
    `account_number_token` STRING COMMENT 'PCI‑P2PE token representing the underlying bank account number.',
    `account_open_date` DATE COMMENT 'Date when the bank account was originally opened.',
    `account_type` STRING COMMENT 'Classification of the settlement account (checking, savings, or current).. Valid values are `checking|savings|current`',
    `bank_branch` STRING COMMENT 'Branch or location identifier of the bank (e.g., city or branch code).',
    `bank_name` STRING COMMENT 'Name of the financial institution where the settlement account is held.',
    `bic_swift` STRING COMMENT 'SWIFT code identifying the bank for international transfers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement account record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the settlement account. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CHF|AUD|CAD|... — promote to reference product]',
    `effective_from` DATE COMMENT 'Date when the settlement account became active for the merchant.',
    `effective_until` DATE COMMENT 'Date when the settlement account is scheduled to be deactivated or closed (nullable).',
    `iban` STRING COMMENT 'Standardized international bank account number used for cross‑border settlements.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the merchants primary settlement account.',
    `is_tokenized` BOOLEAN COMMENT 'True if the account number is stored as a token rather than clear text.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful verification of the account.',
    `merchant_settlement_account_status` STRING COMMENT 'Current lifecycle state of the settlement account.. Valid values are `active|inactive|pending|suspended|closed`',
    `pci_compliant` BOOLEAN COMMENT 'True if the settlement account handling meets PCI DSS requirements.',
    `routing_number` STRING COMMENT 'Domestic routing number used for ACH or wire transfers.',
    `settlement_delay_days` STRING COMMENT 'Number of days between transaction finalization and fund disbursement.',
    `settlement_frequency` STRING COMMENT 'How often settlement funds are transferred to the account.. Valid values are `daily|weekly|monthly|quarterly`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement account record.',
    `verification_method` STRING COMMENT 'Method used to verify the settlement account.. Valid values are `micro_deposit|document|online|none`',
    `verification_status` STRING COMMENT 'Current status of the settlement account verification process.. Valid values are `verified|pending|failed`',
    CONSTRAINT pk_merchant_settlement_account PRIMARY KEY(`merchant_settlement_account_id`)
) COMMENT 'Stores the merchants designated bank account(s) for settlement fund disbursement. Captures bank name, account holder name, account type (checking, savings), IBAN, account number (tokenized/masked), routing number, BIC/SWIFT code, currency, settlement frequency (daily, weekly, monthly), settlement delay days, and account verification status. Supports multi-currency and multi-bank settlement configurations per merchant.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` (
    `processing_limit_id` BIGINT COMMENT 'System-generated unique identifier for the processing limit record.',
    `control_id` BIGINT COMMENT 'Reference to the specific compliance rule governing this limit.',
    `fraud_velocity_control_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_velocity_control. Business justification: Processing limits are frequently set or tightened in direct response to fraud velocity control breaches. Risk operations teams need to reference the specific velocity control that mandated a limit cha',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Processing limits (velocity controls, daily/monthly caps, CNP limits) are configured at the merchant_account level — the operational processing account. Currently processing_limit only FKs to merchant',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant to which this processing limit applies.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Cross-border processing limits are corridor-specific — a merchant may have different volume caps for USD→EUR vs USD→MXN corridors. This link enables corridor-specific limit enforcement, regulatory com',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Processing limits are set per payment product — a merchant has different transaction and volume limits for card-present vs. BNPL vs. cross-border products. Risk and regulatory decisions require produc',
    `underwriting_decision_id` BIGINT COMMENT 'Reference to the underwriting decision record that approved the limit.',
    `card_not_present_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount allowed for card‑not‑present (CNP) transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the processing limit record was first created in the system.',
    `cross_border_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary value for cross‑border transactions.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of monetary limits.',
    `daily_transaction_count_limit` STRING COMMENT 'Maximum number of individual transactions permitted per day.',
    `daily_volume_cap_amount` DECIMAL(18,2) COMMENT 'Total monetary volume limit for transactions within a calendar day.',
    `effective_from` DATE COMMENT 'Date on which the limit becomes enforceable.',
    `effective_until` DATE COMMENT 'Date on which the limit expires or is superseded; null for open‑ended limits.',
    `is_compliant` BOOLEAN COMMENT 'True when the limit configuration satisfies all applicable regulatory and internal compliance rules.',
    `is_manual_review_required` BOOLEAN COMMENT 'Indicates if transactions breaching the limit trigger a manual review workflow.',
    `is_override_allowed` BOOLEAN COMMENT 'Indicates whether authorized personnel may temporarily override the limit.',
    `limit_change_reason` STRING COMMENT 'Free‑text description explaining why the limit was created or modified.',
    `limit_code` STRING COMMENT 'Business code that uniquely identifies the type of limit configuration.',
    `limit_review_date` DATE COMMENT 'Scheduled date for periodic review and possible adjustment of the limit.',
    `limit_source` STRING COMMENT 'Origin of the limit configuration – whether set by underwriting, risk model, or manual policy.. Valid values are `underwriting|risk_model|manual`',
    `limit_type` STRING COMMENT 'Category of the limit, indicating which transaction dimension it governs. [ENUM-REF-CANDIDATE: single_transaction|daily_volume|monthly_tpv|transaction_count|cnp|cross_border|refund — 7 candidates stripped; promote to reference product]',
    `monthly_tpv_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cumulative transaction value allowed in a month.',
    `notes` STRING COMMENT 'Optional free‑form notes or comments about the limit.',
    `processing_limit_status` STRING COMMENT 'Current lifecycle status of the limit configuration.. Valid values are `active|inactive|pending|suspended|revoked`',
    `refund_limit_amount` DECIMAL(18,2) COMMENT 'Maximum total amount that can be refunded within the limit period.',
    `risk_score_at_set` DECIMAL(18,2) COMMENT 'Risk model score associated with the merchant at the time the limit was established.',
    `single_transaction_max_amount` DECIMAL(18,2) COMMENT 'Maximum monetary value allowed for any single transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the processing limit record.',
    `version_number` STRING COMMENT 'Incremental version number tracking revisions to the limit configuration.',
    CONSTRAINT pk_processing_limit PRIMARY KEY(`processing_limit_id`)
) COMMENT 'Defines the transaction processing limits and velocity controls configured for a merchant account. Stores single transaction maximum amount, daily transaction volume cap, monthly TPV (Total Payment Volume) limit, maximum transaction count per day, card-not-present limit, cross-border transaction limit, refund limit, and limit review date. Limits are set during underwriting and adjusted based on risk profile changes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique system-generated identifier for each merchant hierarchy relationship record.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that is the subordinate entity in the hierarchy.',
    `parent_merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that acts as the parent in the relationship (e.g., PayFac, ISO, corporate parent).',
    `compliance_status` STRING COMMENT 'Indicates whether the relationship meets applicable AML, KYC, and PCI‑DSS requirements.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the hierarchy record was initially inserted into the lakehouse.',
    `effective_from` DATE COMMENT 'Calendar date on which the parent‑child relationship starts to apply.',
    `effective_until` DATE COMMENT 'Calendar date on which the relationship terminates; null for open‑ended relationships.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the child merchant relative to the root of the hierarchy (root = 0).',
    `hierarchy_type` STRING COMMENT 'Classification of the relationship (e.g., PayFac to sub‑merchant, ISO portfolio, corporate parent‑subsidiary, aggregator‑merchant).. Valid values are `payfac|iso|corporate|aggregator|partner`',
    `is_exclusive` BOOLEAN COMMENT 'True if the child merchant may belong to only this parent; false if multi‑parenting is allowed.',
    `is_primary` BOOLEAN COMMENT 'True when the child merchant is designated as the primary account within the parent grouping.',
    `last_review_date` DATE COMMENT 'Calendar date when the hierarchy relationship was last examined for regulatory or risk compliance.',
    `merchant_hierarchy_status` STRING COMMENT 'Operational state of the relationship (e.g., active, pending approval, suspended).. Valid values are `active|inactive|pending|suspended|terminated`',
    `notes` STRING COMMENT 'Optional textual comments or business rationale for the hierarchy entry.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑99.99) reflecting the aggregate risk of the parent‑child grouping.',
    `source_system` STRING COMMENT 'Name of the operational system of record that created or last updated the hierarchy entry. [ENUM-REF-CANDIDATE: gateway|transaction_platform|merchant_mgmt|fraud_platform|digital_wallet|risk_compliance|crm|erp|analytics — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to any field in the hierarchy record.',
    `version_number` STRING COMMENT 'Monotonically increasing integer used to manage concurrent updates.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Models the organizational hierarchy relationships between merchant entities — including PayFac (Payment Facilitator) to sub-merchant relationships, ISO (Independent Sales Organization) portfolios, corporate parent-to-subsidiary chains, and aggregator-to-merchant structures. Captures parent merchant ID, child merchant ID, hierarchy type (PayFac, ISO, corporate, aggregator), effective date, and hierarchy level. Enables consolidated reporting and risk exposure aggregation across merchant groups.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` (
    `sub_merchant_id` BIGINT COMMENT 'System-generated unique identifier for the sub-merchant entity.',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: PayFac sub-merchant onboarding: sole traders and micro-merchants registered as sub-merchants are frequently also account_holders on the same platform. Linking enables KYC identity reuse, AML deduplica',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Sub-merchants in a PayFac model are directly sponsored by a specific ecosystem partner. This FK enables sub-merchant portfolio reporting by partner, compliance tracking of partner-sponsored sub-mercha',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: PayFac platforms track sub-merchant revenue in separate GL accounts for income attribution, regulatory reporting, and PayFac-level P&L. Each sub-merchants processing revenue posts to a designated GL ',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Sub-merchants in PayFac models operate in specific jurisdictions with distinct AML/CTF and transaction limit requirements. The country_code on sub_merchant is insufficient — the jurisdiction_profile F',
    `kyb_verification_id` BIGINT COMMENT 'Foreign key linking to merchant.kyb_verification. Business justification: Sub-merchants under a PayFac must undergo KYB verification as required by BSA/AML regulations and card network rules. sub_merchant has kyc_status, aml_check_status, and sanctions_screening_status fiel',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: A sub_merchant operates under a PayFac or aggregator and processes transactions through a specific merchant_account. The merchant_account governs the processing configuration (supported payment method',
    `merchant_id` BIGINT COMMENT 'Identifier of the PayFac (Payment Facilitator) that sponsors the sub‑merchant.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: Sub-merchants in PayFac models are onboarded with specific gateway integrations tied to their sub-MID. Transaction routing, compliance checks, and processing capability determination for sub-merchant ',
    `merchant_pricing_plan_id` BIGINT COMMENT 'Identifier of the pricing plan assigned to the sub‑merchant.',
    `merchant_settlement_account_id` BIGINT COMMENT 'Reference to the bank account used for settlement payouts.',
    `parent_aggregator_merchant_id` BIGINT COMMENT 'Identifier of the aggregator (if any) that the sub‑merchant is linked to.',
    `parent_payfac_merchant_id` BIGINT COMMENT 'Identifier of the PayFac (Payment Facilitator) that sponsors the sub‑merchant.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Sub-merchants under a PayFac are enrolled for specific payment products. PayFac onboarding, risk monitoring, and scheme compliance reporting require knowing which payment product each sub-merchant pro',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: Sub-merchants may be enrolled in specific interchange programs (e.g., small merchant programs, PayFac programs). This link is required for PayFac program enrollment management, interchange optimizatio',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: PayFac risk monitoring requires each sub-merchant to have a linked risk_profile for ongoing exposure limit tracking, AML monitoring, and chargeback threshold management. Sub-merchants are distinct ris',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Sub-merchants undergo mandatory sanctions screening during PayFac onboarding. The sanctions_screening_status field is denormalized — the FK to the actual sanctions_check record is required for PayFac ',
    `underwriting_decision_id` BIGINT COMMENT 'Foreign key linking to risk.underwriting_decision. Business justification: Visa/Mastercard PayFac rules require each sub-merchant to have a documented underwriting_decision for regulatory compliance. Sub-merchants undergo independent underwriting; this FK enables PayFac comp',
    `activation_date` DATE COMMENT 'Date the sub‑merchant became active for processing transactions.',
    `address_line1` STRING COMMENT 'First line of the sub‑merchants physical address.',
    `address_line2` STRING COMMENT 'Second line of the sub‑merchants physical address (optional).',
    `aml_check_status` STRING COMMENT 'Outcome of AML screening for the sub‑merchant.. Valid values are `clear|flagged|pending`',
    `average_monthly_volume` DECIMAL(18,2) COMMENT 'Average monetary volume of transactions per month for the sub‑merchant.',
    `average_ticket_size` DECIMAL(18,2) COMMENT 'Average monetary value per individual transaction.',
    `business_type` STRING COMMENT 'Categorization of the sub-merchants primary business activity.. Valid values are `retail|ecommerce|services|hospitality|travel|other`',
    `city` STRING COMMENT 'City component of the sub‑merchants address.',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the sub‑merchant.. Valid values are `compliant|non_compliant|pending_review`',
    `contact_email` STRING COMMENT 'Primary email address for sub‑merchant communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for the sub‑merchant.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the sub‑merchants location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sub‑merchant record was first created in the system.',
    `currency_code` STRING COMMENT 'Default settlement currency for the sub‑merchant.. Valid values are `USD|EUR|GBP|JPY|AUD|CAD`',
    `dba_name` STRING COMMENT 'Trade name under which the sub-merchant operates.',
    `industry_code` STRING COMMENT 'Standard industry code describing the sub-merchants sector.',
    `kyc_status` STRING COMMENT 'Result of the KYC verification process for the sub‑merchant.. Valid values are `verified|unverified|pending`',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or risk review for the sub‑merchant.',
    `mcc` STRING COMMENT 'Four‑digit code that classifies the sub-merchants transaction type.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the sub‑merchant.',
    `onboarding_date` DATE COMMENT 'Date the sub‑merchant completed the onboarding process.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the sub‑merchants address.',
    `processing_status` STRING COMMENT 'Indicates whether the sub‑merchant is currently allowed to process transactions.. Valid values are `enabled|disabled|paused`',
    `risk_classification` STRING COMMENT 'Risk tier assigned to the sub‑merchant based on underwriting and fraud scoring.. Valid values are `low|medium|high|critical`',
    `state` STRING COMMENT 'State or province component of the sub‑merchants address.',
    `sub_merchant_name` STRING COMMENT 'Full legal name of the sub-merchant as registered.',
    `sub_merchant_status` STRING COMMENT 'Current lifecycle status of the sub‑merchant.. Valid values are `active|inactive|suspended|pending|closed`',
    `sub_mid` STRING COMMENT 'Unique identifier assigned to the sub-merchant by the acquiring bank.',
    `termination_date` DATE COMMENT 'Date the sub‑merchant relationship was terminated or closed.',
    `transaction_volume_tier` STRING COMMENT 'Tier classification based on historical transaction volume.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sub‑merchant record.',
    `version_number` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    CONSTRAINT pk_sub_merchant PRIMARY KEY(`sub_merchant_id`)
) COMMENT 'Represents a sub-merchant entity operating under a PayFac or aggregator umbrella. Stores sub-merchant name, sub-MID, parent PayFac or aggregator reference, business type, onboarding date, processing status, assigned MCC, transaction volume tier, and sub-merchant-level risk classification. Sub-merchants are distinct from direct merchants in that they are sponsored and managed by a PayFac rather than directly contracted with the acquirer.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` (
    `acquiring_agreement_id` BIGINT COMMENT 'Unique system-generated identifier for the acquiring agreement record.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: An acquiring agreement is a contract with a specific acquirer. The acquirer_endpoint is the technical representation of that acquirer. Contract compliance audits, settlement reconciliation, and regula',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: An acquiring agreement is a bilateral contract between a merchant and a specific acquirer defining settlement terms, fees, and processing conditions. The acquirer is the named counterparty to the agre',
    `control_id` BIGINT COMMENT 'Reference to the specific compliance rule set governing this agreement.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Business need: Acquiring agreements bind a merchant to an acquiring partner (bank). Required for settlement reporting, regulatory compliance, and partner performance metrics.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Acquiring agreements are governed by specific jurisdictions determining applicable law, regulatory requirements, and enforcement penalties. The governing_law_jurisdiction text field is denormalized — ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Acquiring agreements are legal contracts between the processors legal entity and the merchant. Regulatory reporting, contract management, and financial consolidation require identifying which legal e',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: An acquiring agreement (merchant services agreement) governs the terms under which a specific processing account operates. The agreement defines the commercial and legal framework for the merchant_acc',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant party to which the agreement applies.',
    `merchant_pricing_plan_id` BIGINT COMMENT 'Reference to the pricing plan associated with this agreement.',
    `merchant_settlement_account_id` BIGINT COMMENT 'Identifier of the bank account where settlement funds are transferred.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Acquiring agreements for cross-border merchants contractually specify covered payment corridors. This link supports contract management, corridor-specific compliance verification, and dispute resoluti',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Acquiring agreements are negotiated and executed for specific payment products. The agreement governs commercial terms, rates, and compliance obligations for that product. Legal and commercial teams r',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: An acquiring agreement contractually specifies the interchange program governing the merchants processing rates. This link is required for contract management, interchange-plus agreement audits, and ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Acquiring agreements generate contract-specific revenue (setup fees, early termination fees, contract amounts) that must post to designated GL accounts for revenue recognition under ASC 606/IFRS 15. C',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Acquiring agreements are scheme-specific contracts (a Visa merchant agreement is distinct from a Mastercard agreement). Acquirers must track which scheme each agreement governs for scheme compliance a',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: Acquiring agreements embed SLA commitments (uptime, latency, error rate thresholds). The sla_profile captures these operational targets. Contract management, SLA breach reporting, and penalty calculat',
    `underwriting_decision_id` BIGINT COMMENT 'Foreign key linking to risk.underwriting_decision. Business justification: Acquiring agreements encode terms (reserve rate, TPV cap, MCC restrictions) that are directly authorized by an underwriting_decision. Contract management and scheme compliance audits require tracing w',
    `acquiring_agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `draft|active|suspended|terminated|pending|expired`',
    `agreement_category` STRING COMMENT 'High‑level business category of the agreement.. Valid values are `legal|financial|operational|other`',
    `agreement_type` STRING COMMENT 'Classification of the agreement based on its purpose and parties involved.. Valid values are `master_service_agreement|merchant_services_agreement|partner_agreement|other`',
    `amendment_date` DATE COMMENT 'Date on which a specific amendment to the agreement took effect.',
    `amendment_description` STRING COMMENT 'Narrative description of the changes introduced by the amendment.',
    `amendment_history_reference` STRING COMMENT 'Reference to the historical log of all amendments made to the agreement.',
    `amendment_version` STRING COMMENT 'Version identifier for the specific amendment.',
    `auto_renewal_flag` BOOLEAN COMMENT 'True if the agreement automatically renews at expiry.',
    `contract_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the agreement.',
    `contract_closure_date` DATE COMMENT 'Date on which the agreement was formally closed or terminated.',
    `contract_closure_reason` STRING COMMENT 'Reason why the agreement was closed or terminated.',
    `contract_status_reason` STRING COMMENT 'Explanation for the current status of the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `early_termination_fee_amount` DECIMAL(18,2) COMMENT 'Monetary penalty payable if the agreement is terminated early.',
    `early_termination_fee_currency` STRING COMMENT 'ISO 4217 currency code for the early termination fee.',
    `end_date` DATE COMMENT 'Date on which the agreement terminates or expires; null for open‑ended contracts.',
    `mcc_code` STRING COMMENT 'Four‑digit code classifying the merchants primary business activity.. Valid values are `^d{4}$`',
    `mid` STRING COMMENT 'Acquirer‑assigned merchant identification number.',
    `payment_terms` STRING COMMENT 'Standard payment condition defined in the agreement.. Valid values are `net30|net45|due_on_receipt|custom`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the agreement meets all applicable regulatory requirements.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that renewal notice must be provided.',
    `signatory_date` DATE COMMENT 'Date on which the agreement was signed.',
    `signatory_name` STRING COMMENT 'Legal name of the individual who signed the agreement on behalf of the acquirer.',
    `signatory_title` STRING COMMENT 'Job title or role of the signatory at the time of signing.',
    `start_date` DATE COMMENT 'Date on which the agreement becomes binding.',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to notify the counter‑party before terminating the agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `version_number` STRING COMMENT 'Version identifier for the agreement document.',
    CONSTRAINT pk_acquiring_agreement PRIMARY KEY(`acquiring_agreement_id`)
) COMMENT 'Stores the formal acquiring agreement (merchant services agreement) between the acquirer and the merchant. Captures agreement type, contract start date, contract end date, auto-renewal flag, early termination fee terms, governing law jurisdiction, signatory name and date, agreement version, and amendment history reference. Distinct from pricing plan — this is the legal contract record, not the fee configuration.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` (
    `pci_compliance_id` BIGINT COMMENT 'Unique identifier for the PCI compliance record.',
    `pci_dss_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.pci_dss_audit. Business justification: A merchants PCI compliance record is directly produced by a PCI DSS audit. QSA assessments (pci_dss_audit) determine the merchants compliance level and next assessment date. Payments compliance team',
    `aoc_reference` STRING COMMENT 'Identifier or URI of the Attestation of Compliance (AOC) document submitted by the merchant.',
    `assigned_qsa_name` STRING COMMENT 'Full name of the Qualified Security Assessor responsible for the merchants assessment.',
    `asv_scan_date` DATE COMMENT 'Date when the ASV scan was performed.',
    `asv_scan_status` STRING COMMENT 'Result of the Approved Scanning Vendor (ASV) vulnerability scan.. Valid values are `passed|failed|not_applicable`',
    `compliance_document_reference` STRING COMMENT 'Identifier or URI of supporting documentation (e.g., scan reports, policies).',
    `compliance_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any fee associated with compliance monitoring or certification.',
    `compliance_fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the compliance fee.. Valid values are `^[A-Z]{3}$`',
    `compliance_level` STRING COMMENT 'Level of PCI DSS compliance achieved by the merchant (e.g., SAQ A, SAQ B, SAQ D, ROC).. Valid values are `SAQ_A|SAQ_B|SAQ_D|ROC`',
    `compliance_notes` STRING COMMENT 'Additional remarks, observations, or actions related to the compliance record.',
    `compliance_record_number` STRING COMMENT 'Business-visible identifier for the compliance record, often used in reporting and audits.',
    `compliance_review_date` DATE COMMENT 'Date when the compliance record was last reviewed for accuracy.',
    `compliance_review_status` STRING COMMENT 'Current status of the compliance review process.. Valid values are `completed|pending|overdue`',
    `compliance_type` STRING COMMENT 'Specifies the compliance framework, fixed to PCI DSS for this product.. Valid values are `PCI_DSS`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the compliance status started to apply.',
    `effective_until` DATE COMMENT 'Date when the compliance status ends or must be renewed.',
    `is_waiver_approved` BOOLEAN COMMENT 'True if a waiver for non‑compliance fees has been formally approved.',
    `last_assessment_date` DATE COMMENT 'Date when the merchant last completed a PCI DSS assessment.',
    `next_assessment_due_date` DATE COMMENT 'Planned date for the merchants next PCI DSS assessment.',
    `non_compliance_fee_waiver` BOOLEAN COMMENT 'Indicates whether the merchant has been granted a waiver for non‑compliance fees.',
    `pci_compliance_status` STRING COMMENT 'Overall compliance status of the merchant.. Valid values are `compliant|non_compliant|pending|revoked`',
    `penetration_test_date` DATE COMMENT 'Date when the penetration test was conducted.',
    `penetration_test_status` STRING COMMENT 'Outcome of the merchants penetration testing.. Valid values are `passed|failed|not_applicable`',
    `qsa_contact_email` STRING COMMENT 'Email address of the assigned QSA.',
    `qsa_contact_phone` STRING COMMENT 'Phone number of the assigned QSA.',
    `risk_score_at_assessment` STRING COMMENT 'Numerical risk rating assigned during the PCI assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the compliance record.',
    `waiver_approval_date` DATE COMMENT 'Date the waiver was granted.',
    `waiver_reason` STRING COMMENT 'Explanation for why the non‑compliance fee waiver was issued.',
    CONSTRAINT pk_pci_compliance PRIMARY KEY(`pci_compliance_id`)
) COMMENT 'Tracks PCI DSS (Payment Card Industry Data Security Standard) compliance status for each merchant. Stores compliance level (SAQ A, SAQ B, SAQ D, ROC), current compliance status, last assessment date, next assessment due date, AOC (Attestation of Compliance) reference, ASV scan status, penetration test date, non-compliance fee waiver status, and assigned QSA (Qualified Security Assessor). Mandatory for all card-accepting merchants per card scheme rules.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` (
    `risk_profile_id` BIGINT COMMENT 'Unique surrogate key for each merchant risk profile record.',
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Merchant risk profiles are directly informed by AML screening outcomes. The aml_check_status field on merchant_risk_profile is denormalized — risk analysts require the FK to the actual AML screening r',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Risk thresholds, reserve percentages, and chargeback limits are jurisdiction-specific. Linking merchant_risk_profile to jurisdiction_profile enables jurisdiction-aware risk decisioning and ensures com',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: A merchant_risk_profile governs the risk posture of a merchants processing account — including reserve requirements, chargeback thresholds, and fraud rates. Linking merchant_risk_profile to merchant_',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant to which this risk profile belongs.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Compliance and risk teams must trace which risk_policy version governed reserve requirements, risk tier classification, and monitoring thresholds at the time a merchant_risk_profile was created or upd',
    `processing_limit_id` BIGINT COMMENT 'Reference to the merchants processing limit configuration.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Risk profiles drive reserve requirements; reserve balances are held in specific GL liability accounts. Payments fintechs link risk profiles to reserve GL accounts for financial reporting of merchant r',
    `underwriting_decision_id` BIGINT COMMENT 'Reference to the underwriting decision record that created the profile.',
    `aml_check_status` STRING COMMENT 'Anti‑Money‑Laundering screening result for the merchant.. Valid values are `passed|failed|pending`',
    `average_monthly_volume` DECIMAL(18,2) COMMENT 'Mean monetary value of transactions per month.',
    `average_ticket_size` DECIMAL(18,2) COMMENT 'Mean value per individual transaction.',
    `business_model_risk_classification` STRING COMMENT 'Risk classification based on the merchants business model and industry exposure.. Valid values are `low|medium|high|critical`',
    `chargeback_rate_3m_rolling` DECIMAL(18,2) COMMENT 'Average chargeback rate over the trailing three‑month window.',
    `chargeback_rate_current` DECIMAL(18,2) COMMENT 'Percentage of total transactions that have resulted in chargebacks in the most recent reporting period.',
    `compliance_flag` STRING COMMENT 'Indicates whether the merchant complies with applicable regulations.. Valid values are `compliant|non_compliant|exception`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk profile record was first created.',
    `effective_from` DATE COMMENT 'Date when the risk profile becomes effective.',
    `effective_until` DATE COMMENT 'Date when the risk profile expires or is superseded (nullable).',
    `fraud_rate` DECIMAL(18,2) COMMENT 'Proportion of transactions flagged as fraudulent for the merchant.',
    `is_manual_review_required` BOOLEAN COMMENT 'Indicates whether a manual risk review is required.',
    `is_override_allowed` BOOLEAN COMMENT 'Indicates whether risk parameters can be overridden by authorized personnel.',
    `kyc_status` STRING COMMENT 'Current Know‑Your‑Customer verification status for the merchant.. Valid values are `verified|unverified|pending`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to any field in the record.',
    `last_risk_review_date` DATE COMMENT 'Date when the most recent risk assessment was performed.',
    `notes` STRING COMMENT 'Additional free‑form information about the risk profile.',
    `override_reason` STRING COMMENT 'Reason provided for any manual override of risk settings.',
    `refund_rate` DECIMAL(18,2) COMMENT 'Percentage of transaction value refunded to cardholders within the reporting period.',
    `reserve_balance` DECIMAL(18,2) COMMENT 'Current monetary amount held in reserve for the merchant.',
    `reserve_balance_currency` STRING COMMENT 'Currency of the reserve balance amount.',
    `reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of the merchants transaction volume that must be held as reserve.',
    `reserve_requirement_type` STRING COMMENT 'Method used to hold a financial reserve for the merchant (none, rolling, or capped).. Valid values are `none|rolling|capped`',
    `risk_review_notes` STRING COMMENT 'Free‑form notes captured during the risk review.',
    `risk_review_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the latest risk review was completed.',
    `risk_review_trigger` STRING COMMENT 'Event or condition that initiated the latest risk review.. Valid values are `periodic|threshold_exceeded|manual|regulatory`',
    `risk_score` STRING COMMENT 'Numerical risk score derived from underwriting models (0‑100).',
    `risk_score_explanation` STRING COMMENT 'Narrative explanation of factors influencing the risk score.',
    `risk_score_source` STRING COMMENT 'Origin of the risk score (e.g., model, manual).',
    `risk_score_version` STRING COMMENT 'Version identifier of the scoring model used.',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk profile.. Valid values are `active|inactive|pending|closed`',
    `risk_tier` STRING COMMENT 'Overall risk tier assigned to the merchant after underwriting and ongoing assessment.. Valid values are `low|medium|high|prohibited`',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions list screening for the merchant.. Valid values are `cleared|blocked|pending`',
    `transaction_volume_tier` STRING COMMENT 'Categorization of merchant based on average transaction volume.. Valid values are `low|medium|high`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk profile.',
    `version_number` STRING COMMENT 'Incremental version number for the risk profile record.',
    CONSTRAINT pk_risk_profile PRIMARY KEY(`risk_profile_id`)
) COMMENT 'Stores the underwriting and ongoing risk assessment profile for a merchant. Captures risk tier (low, medium, high, prohibited), business model risk classification, chargeback rate (current and rolling 3-month), refund rate, fraud rate, reserve requirement type (none, rolling, capped), reserve percentage, reserve balance, last risk review date, and risk review trigger. Owned by the merchant domain as the operational risk configuration record; distinct from the enterprise risk domains scoring models.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_payfac_parent_merchant_id` FOREIGN KEY (`payfac_parent_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_kyb_verification_id` FOREIGN KEY (`kyb_verification_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`kyb_verification`(`kyb_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_parent_payfac_merchant_id` FOREIGN KEY (`parent_payfac_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ADD CONSTRAINT `fk_merchant_location_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ADD CONSTRAINT `fk_merchant_location_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ADD CONSTRAINT `fk_merchant_location_merchant_settlement_account_id` FOREIGN KEY (`merchant_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_settlement_account`(`merchant_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ADD CONSTRAINT `fk_merchant_location_pci_compliance_id` FOREIGN KEY (`pci_compliance_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`pci_compliance`(`pci_compliance_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ADD CONSTRAINT `fk_merchant_merchant_contact_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ADD CONSTRAINT `fk_merchant_beneficial_owner_application_id` FOREIGN KEY (`application_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`application`(`application_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ADD CONSTRAINT `fk_merchant_beneficial_owner_kyb_verification_id` FOREIGN KEY (`kyb_verification_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`kyb_verification`(`kyb_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ADD CONSTRAINT `fk_merchant_beneficial_owner_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_merchant_pricing_plan_id` FOREIGN KEY (`merchant_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`(`merchant_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_merchant_settlement_account_id` FOREIGN KEY (`merchant_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_settlement_account`(`merchant_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_pci_compliance_id` FOREIGN KEY (`pci_compliance_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`pci_compliance`(`pci_compliance_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_merchant_pricing_plan_id` FOREIGN KEY (`merchant_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`(`merchant_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_merchant_settlement_account_id` FOREIGN KEY (`merchant_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_settlement_account`(`merchant_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ADD CONSTRAINT `fk_merchant_merchant_settlement_account_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ADD CONSTRAINT `fk_merchant_hierarchy_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ADD CONSTRAINT `fk_merchant_hierarchy_parent_merchant_id` FOREIGN KEY (`parent_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_kyb_verification_id` FOREIGN KEY (`kyb_verification_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`kyb_verification`(`kyb_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_merchant_pricing_plan_id` FOREIGN KEY (`merchant_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`(`merchant_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_merchant_settlement_account_id` FOREIGN KEY (`merchant_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_settlement_account`(`merchant_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_parent_aggregator_merchant_id` FOREIGN KEY (`parent_aggregator_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_parent_payfac_merchant_id` FOREIGN KEY (`parent_payfac_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_merchant_pricing_plan_id` FOREIGN KEY (`merchant_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`(`merchant_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_merchant_settlement_account_id` FOREIGN KEY (`merchant_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_settlement_account`(`merchant_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_processing_limit_id` FOREIGN KEY (`processing_limit_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`processing_limit`(`processing_limit_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`merchant` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`merchant` SET TAGS ('dbx_domain' = 'merchant');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` SET TAGS ('dbx_subdomain' = 'merchant_onboarding');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Default Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Independent Sales Organization (ISO) Partner ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `payfac_parent_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Facilitator (PayFac) Parent Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `underwriting_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Merchant Activation Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_country` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Business State or Province');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'sole_proprietorship|partnership|corporation|llc|non_profit|government');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `chargeback_threshold_count` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Count Threshold');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `chargeback_threshold_ratio` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Ratio Threshold');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `incorporation_country` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Country Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `incorporation_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|failed|expired');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `legal_business_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Business Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Merchant Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `mdr_rate` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `mdr_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `mid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `monthly_processing_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Processing Volume Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Merchant Onboarding Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `operating_country` SET TAGS ('dbx_business_glossary_term' = 'Operating Country Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `operating_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Merchant Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Account Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|on_demand');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `settlement_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Routing Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `settlement_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Merchant Termination Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `transaction_limit_single` SET TAGS ('dbx_business_glossary_term' = 'Single Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Merchant Website URL');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` SET TAGS ('dbx_subdomain' = 'merchant_onboarding');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Application ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Payment Facilitator (PayFac) ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Independent Sales Organization (ISO) Partner ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `kyb_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Kyb Verification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `onboarding_application_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Application Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `parent_payfac_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Payment Facilitator (PayFac) ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `underwriting_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{10}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new|change|reinstatement|upgrade|downgrade|reactivation');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Account Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8,17}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Account Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|business_checking');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Routing Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_description` SET TAGS ('dbx_business_glossary_term' = 'Business Description');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Business State or Province');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'sole_proprietor|partnership|llc|corporation|non_profit|government');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_website_url` SET TAGS ('dbx_business_glossary_term' = 'Business Website URL');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `business_website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact First Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Last Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `credit_check_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Performed Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `decision_code` SET TAGS ('dbx_value_regex' = 'approved|declined|conditional_approval|pending_info|withdrawn|expired');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `documentation_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Received Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `estimated_average_ticket` SET TAGS ('dbx_business_glossary_term' = 'Estimated Average Ticket Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `estimated_average_ticket` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `estimated_monthly_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Monthly Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `estimated_monthly_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|manual_review');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `legal_business_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Business Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `legal_business_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Date of Birth');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_first_name` SET TAGS ('dbx_business_glossary_term' = 'Business Owner First Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_last_name` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Last Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_ssn` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Social Security Number (SSN)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_ssn` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `owner_ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `payfac_sub_merchant_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Facilitator (PayFac) Sub-Merchant Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `requested_mcc` SET TAGS ('dbx_business_glossary_term' = 'Requested Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `requested_mcc` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `requested_processing_methods` SET TAGS ('dbx_business_glossary_term' = 'Requested Processing Methods');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `required_documentation_checklist` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation Checklist');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|partner_api|sales_rep|call_center|branch');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$|^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `underwriting_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Complete Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ALTER COLUMN `underwriting_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `merchant_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `pci_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Pci Compliance Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `chargeback_threshold_count` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Threshold Count');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `chargeback_threshold_ratio` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Threshold Ratio');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `fraud_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fraud Monitoring Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'physical_storefront|kiosk|online|mpos|virtual|pop_up');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `mcc` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `mcc` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `mid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `single_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Single Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `single_transaction_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `three_ds_required` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Required');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` SET TAGS ('dbx_subdomain' = 'merchant_onboarding');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `merchant_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Contact ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `can_receive_dispute_notifications` SET TAGS ('dbx_business_glossary_term' = 'Can Receive Dispute Notifications Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `can_receive_pci_data` SET TAGS ('dbx_business_glossary_term' = 'Can Receive PCI Data Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `can_receive_settlement_reports` SET TAGS ('dbx_business_glossary_term' = 'Can Receive Settlement Reports Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'primary_business|billing|technical|dispute|compliance|support');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `email_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-Out Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `email_opt_out_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `email_opt_out_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `is_authorized_signer` SET TAGS ('dbx_business_glossary_term' = 'Is Authorized Signer Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `kyc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|expired');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_business_glossary_term' = 'Phone Extension');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `sms_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS Opt-Out Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` SET TAGS ('dbx_subdomain' = 'merchant_onboarding');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `kyb_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Business (KYB) Verification ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `compliance_kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Kyc Verification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `adverse_media_check_result` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Check Result');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `adverse_media_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|negative_news_found|not_performed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Result');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|alert_triggered|not_performed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `business_identity_check_result` SET TAGS ('dbx_business_glossary_term' = 'Business Identity Check Result');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `business_identity_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive|not_performed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'corporation|llc|partnership|sole_proprietorship|non_profit|trust');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `ctf_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Counter-Terrorism Financing (CTF) Screening Result');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `ctf_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|alert_triggered|not_performed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `data_sources_used` SET TAGS ('dbx_business_glossary_term' = 'Data Sources Used');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `document_types_verified` SET TAGS ('dbx_business_glossary_term' = 'Document Types Verified');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `document_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Document Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `document_verification_status` SET TAGS ('dbx_value_regex' = 'verified|failed|incomplete|pending|not_required');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `manual_review_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `manual_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `ofac_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Screening Result');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `ofac_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|match_found|not_performed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `overall_kyb_decision` SET TAGS ('dbx_business_glossary_term' = 'Overall Know Your Business (KYB) Decision');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `overall_kyb_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|manual_review_required');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `pep_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Screening Result');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `pep_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|match_found|not_performed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `review_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `risk_factors` SET TAGS ('dbx_business_glossary_term' = 'Risk Factors');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `ubo_count` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Count');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `ubo_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Screening Result');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `ubo_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive|not_performed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Verification Cost Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Verification Cost Currency');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_provider` SET TAGS ('dbx_business_glossary_term' = 'Verification Provider Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Reference Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|expired|manual_review');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` SET TAGS ('dbx_subdomain' = 'merchant_onboarding');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `beneficial_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `kyb_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Kyb Verification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `watchlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `adverse_media_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `adverse_media_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `adverse_media_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|potential_match|pending|not_screened');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `beneficial_owner_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `beneficial_owner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|rejected');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `control_role` SET TAGS ('dbx_business_glossary_term' = 'Control Role');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `control_role_description` SET TAGS ('dbx_business_glossary_term' = 'Control Role Description');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_business_glossary_term' = 'Country of Residence');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `full_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Full Legal Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `full_legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `full_legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_expiration_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Issuing Country');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_issuing_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_issuing_country` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_number` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_type` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|drivers_license|tax_id|social_security|other');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `government_id_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `identity_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'document_upload|in_person|video_call|third_party_service|database_verification|biometric');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `identity_verification_provider` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Provider');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_started');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `is_pep` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `kyc_refresh_due_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Refresh Due Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `pep_classification` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Classification');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `pep_classification` SET TAGS ('dbx_value_regex' = 'domestic|foreign|international_organization|family_member|close_associate|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `pep_position_title` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Position Title');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Residential Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Residential Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_city` SET TAGS ('dbx_business_glossary_term' = 'Residential City');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_country` SET TAGS ('dbx_business_glossary_term' = 'Residential Country');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Residential Postal Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_state_province` SET TAGS ('dbx_business_glossary_term' = 'Residential State or Province');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `residential_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `sanctions_match_details` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Match Details');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|potential_match|pending|not_screened');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `dcc_config_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `merchant_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Pricing Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `merchant_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `multi_network_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Multi Network Routing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `pci_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Pci Compliance Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `threeds_config_id` SET TAGS ('dbx_business_glossary_term' = 'Threeds Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|restricted|frozen');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'standard|payfac|iso|aggregator|marketplace|direct');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Activation Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `avs_check_enabled` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Check Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `batch_settlement_enabled` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Processing Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `card_not_present_enabled` SET TAGS ('dbx_business_glossary_term' = 'Card Not Present (CNP) Processing Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `card_present_enabled` SET TAGS ('dbx_business_glossary_term' = 'Card Present (CP) Processing Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `chargeback_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Threshold Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `cross_border_processing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Processing Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `cvv_check_enabled` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Check Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `cvv_check_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `cvv_check_enabled` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Volume Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `dynamic_currency_conversion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion (DCC) Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `enhanced_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Transaction Monitoring Required');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `fraud_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fraud Threshold Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `installment_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Processing Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Volume Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `multi_currency_enabled` SET TAGS ('dbx_business_glossary_term' = 'Multi-Currency Processing Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `real_time_settlement_enabled` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Settlement Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `recurring_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Recurring Billing Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `reserve_account_required` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Required');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reserve Holdback Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Merchant Risk Tier Classification');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `sca_exemption_allowed` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Exemption Allowed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `settlement_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Delay Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `single_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Single Transaction Amount Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `supported_card_schemes` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Schemes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `supported_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Methods');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `three_ds_required` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Authentication Required');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ALTER COLUMN `tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Payment Tokenization Enabled');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `mcc_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Assignment ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification (MID) Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'MCC Assignment Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `assigning_authority` SET TAGS ('dbx_business_glossary_term' = 'MCC Assigning Authority');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `assigning_authority` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|acquirer|internal');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'MCC Assignment Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `assignment_rationale` SET TAGS ('dbx_business_glossary_term' = 'MCC Assignment Rationale');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'MCC Assignment Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired|revoked');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'MCC Change Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'MCC Effective Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'MCC Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `mcc_description` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Description');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'MCC Assignment Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `previous_mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `previous_mcc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'MCC Risk Category');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `scheme_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Approval Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `scheme_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Approval Reference Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `scheme_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Approval Required Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `merchant_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `revenue_share_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `ach_transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `amex_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'American Express (AMEX) Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `avs_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `batch_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `chargeback_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `currency_conversion_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Markup Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `debit_card_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Debit Card Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `debit_card_rate_percentage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `debit_card_rate_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `early_termination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `interchange_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interchange Markup Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `interchange_passthrough_flag` SET TAGS ('dbx_business_glossary_term' = 'Interchange Pass-Through Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `international_transaction_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'International Transaction Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `mdr_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `merchant_pricing_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `merchant_pricing_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `mid_qualified_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Mid-Qualified Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `monthly_account_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Account Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `monthly_minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Minimum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `non_qualified_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Non-Qualified Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `payfac_sub_merchant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Facilitator (PayFac) Sub-Merchant Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `pci_compliance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `pci_non_compliance_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Non-Compliance Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `per_transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Per-Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_value_regex' = 'flat_rate|interchange_plus|tiered|blended|cost_plus|custom');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `qualified_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Qualified Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `refund_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Processing Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `retrieval_request_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Request Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `setup_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Setup Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `statement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Statement Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `voice_authorization_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Voice Authorization Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ALTER COLUMN `volume_tier_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `merchant_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Fee Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `merchant_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `merchant_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `applicable_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `applicable_transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|reversal|cashback|auth|capture');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|none');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis (Per Transaction, Percentage, Flat Monthly, Tiered)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'per_transaction|percentage|flat_monthly|tiered');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category (Processing, Service, Compliance, Risk, Settlement)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_category` SET TAGS ('dbx_value_regex' = 'processing|service|compliance|risk|settlement');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Exemption Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_override_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Override Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Override Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_source` SET TAGS ('dbx_business_glossary_term' = 'Fee Source');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_source` SET TAGS ('dbx_value_regex' = 'internal|partner|third_party');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Taxable Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `fee_version` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Version');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Fee');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `max_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `merchant_fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `merchant_fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `merchant_fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `min_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Priority');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Fee Schedule Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type (FLAT|TIERED|VOLUME|PER_TRANSACTION)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'flat|tiered|volume|per_transaction');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `tier_end_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier End Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `tier_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tier Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `tier_start_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier Start Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `merchant_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Full Name (NAME)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_holder_type` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_holder_type` SET TAGS ('dbx_value_regex' = 'individual|organization');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_number_token` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Bank Account Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_number_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_number_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|current');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `bank_branch` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `bic_swift` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code / SWIFT Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `bic_swift` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `bic_swift` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Settlement Account Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Indicator');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `merchant_settlement_account_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `merchant_settlement_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `pci_compliant` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Indicator');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `pci_compliant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (RTN)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `settlement_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Delay (DAYS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'micro_deposit|document|online|none');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Account Verification Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `processing_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Limit Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `fraud_velocity_control_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Velocity Control Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `underwriting_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `card_not_present_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Card‑Not‑Present Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `cross_border_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `daily_transaction_count_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Count Limit');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `daily_volume_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Volume Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `is_manual_review_required` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `is_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `limit_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Limit Change Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Limit Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Limit Review Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `limit_source` SET TAGS ('dbx_business_glossary_term' = 'Limit Source');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `limit_source` SET TAGS ('dbx_value_regex' = 'underwriting|risk_model|manual');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Processing Limit Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `monthly_tpv_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Total Payment Volume Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Processing Limit Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `processing_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Limit Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `processing_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|revoked');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `refund_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `risk_score_at_set` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Limit Set');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `single_transaction_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Single Transaction Maximum Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Limit Version Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Hierarchy ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Child Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `parent_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'payfac|iso|corporate|aggregator|partner');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Relationship Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Relationship Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `merchant_hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `merchant_hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`hierarchy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sub_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `kyb_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Kyb Verification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent PayFac Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `merchant_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `merchant_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `parent_aggregator_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Aggregator Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `parent_payfac_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent PayFac Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `underwriting_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML (Anti‑Money Laundering) Check Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'clear|flagged|pending');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `average_monthly_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `average_ticket_size` SET TAGS ('dbx_business_glossary_term' = 'Average Ticket Size');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'retail|ecommerce|services|hospitality|travel|other');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|AUD|CAD');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `dba_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code (NAICS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC (Know Your Customer) Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `mcc` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free‑Form Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'enabled|disabled|paused');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sub_merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sub_merchant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sub_merchant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sub_merchant_status` SET TAGS ('dbx_business_glossary_term' = 'Sub‑Merchant Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sub_merchant_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `sub_mid` SET TAGS ('dbx_business_glossary_term' = 'Sub‑Merchant Identification Number (SUB‑MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (SUB-MERCHANT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `transaction_volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Tier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `transaction_volume_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `acquiring_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Agreement Identifier (AGMT_ID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Identifier (COMPLIANCE_RULE_ID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCHANT_ID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `merchant_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Identifier (PRICING_PLAN_ID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `merchant_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Identifier (SETTLEMENT_ACC_ID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `underwriting_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `acquiring_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Agreement Lifecycle Status (AGMT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `acquiring_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|pending|expired');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `agreement_category` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Agreement Category (AGMT_CAT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `agreement_category` SET TAGS ('dbx_value_regex' = 'legal|financial|operational|other');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Agreement Type (AGMT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'master_service_agreement|merchant_services_agreement|partner_agreement|other');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date (AMEND_DATE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description (AMEND_DESC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `amendment_history_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment History Reference (AMEND_HISTORY_REF)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `amendment_version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version (AMEND_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Indicator (AUTO_RENEW_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Amount (CONTRACT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `contract_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Closure Date (CLOSURE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `contract_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Closure Reason (CLOSURE_REASON)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `contract_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason (STATUS_REASON)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `early_termination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee Amount (EARLY_TERM_FEE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `early_termination_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee Currency (EARLY_TERM_FEE_CURR)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date (AGMT_END_DATE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|due_on_receipt|custom');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Indicator (REG_COMPL_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days) (RENEW_NOTICE_DAYS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `signatory_date` SET TAGS ('dbx_business_glossary_term' = 'Signatory Date (SIGNATORY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Full Name (SIGNATORY_NAME)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title (SIGNATORY_TITLE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date (AGMT_START_DATE)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days) (TERM_NOTICE_DAYS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version Number (AGMT_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `pci_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Record ID');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `pci_dss_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Pci Dss Audit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `aoc_reference` SET TAGS ('dbx_business_glossary_term' = 'Attestation of Compliance Reference');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `assigned_qsa_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned QSA Name');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `assigned_qsa_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `assigned_qsa_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `asv_scan_date` SET TAGS ('dbx_business_glossary_term' = 'ASV Scan Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `asv_scan_status` SET TAGS ('dbx_business_glossary_term' = 'ASV Scan Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `asv_scan_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Compliance Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Fee Currency');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_level` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Level');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_level` SET TAGS ('dbx_value_regex' = 'SAQ_A|SAQ_B|SAQ_D|ROC');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Number');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'completed|pending|overdue');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type (PCI DSS)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `compliance_type` SET TAGS ('dbx_value_regex' = 'PCI_DSS');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `is_waiver_approved` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `non_compliance_fee_waiver` SET TAGS ('dbx_business_glossary_term' = 'Non‑Compliance Fee Waiver Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `penetration_test_date` SET TAGS ('dbx_business_glossary_term' = 'Penetration Test Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `penetration_test_status` SET TAGS ('dbx_business_glossary_term' = 'Penetration Test Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `penetration_test_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `qsa_contact_email` SET TAGS ('dbx_business_glossary_term' = 'QSA Contact Email');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `qsa_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `qsa_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `qsa_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'QSA Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `qsa_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `qsa_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `risk_score_at_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Assessment');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Risk Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `processing_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Limit Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `underwriting_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Identifier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `average_monthly_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Transaction Volume (Monetary)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `average_ticket_size` SET TAGS ('dbx_business_glossary_term' = 'Average Ticket Size (Monetary)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `business_model_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Business Model Risk Classification');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `business_model_risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `chargeback_rate_3m_rolling` SET TAGS ('dbx_business_glossary_term' = 'Rolling 3‑Month Chargeback Rate (Percent)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `chargeback_rate_current` SET TAGS ('dbx_business_glossary_term' = 'Current Chargeback Rate (Percent)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exception');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `fraud_rate` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rate (Percent)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `is_manual_review_required` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `is_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `last_risk_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Review Date');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `refund_rate` SET TAGS ('dbx_business_glossary_term' = 'Refund Rate (Percent)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `reserve_balance` SET TAGS ('dbx_business_glossary_term' = 'Reserve Balance (Monetary)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `reserve_balance_currency` SET TAGS ('dbx_business_glossary_term' = 'Reserve Balance Currency Code');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reserve Percentage (Percent)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `reserve_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Requirement Type');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `reserve_requirement_type` SET TAGS ('dbx_value_regex' = 'none|rolling|capped');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Notes');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_review_trigger` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Trigger');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_review_trigger` SET TAGS ('dbx_value_regex' = 'periodic|threshold_exceeded|manual|regulatory');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Numeric)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_score_explanation` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Explanation');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_score_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Version');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier (Low, Medium, High, Prohibited)');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|blocked|pending');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `transaction_volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Tier');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `transaction_volume_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
