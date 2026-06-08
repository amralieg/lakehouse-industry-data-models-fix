-- Schema for Domain: reference | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`reference` COMMENT 'Centralized reference and master data domain owning standardized code tables — country codes, currency codes, MCC lists, BIN ranges, reason codes, response codes, decline codes, card scheme identifiers, timezone mappings, holiday calendars, and regulatory jurisdiction mappings. Ensures consistency across all operational domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`country` (
    `country_id` BIGINT COMMENT 'Surrogate primary key for the country record.',
    `holiday_calendar_id` BIGINT COMMENT 'Surrogate key linking to the country‑specific holiday calendar.',
    `timezone_id` BIGINT COMMENT 'Foreign key linking to reference.timezone. Business justification: Linking country to timezone for consistent timestamp handling; time_zone string becomes redundant.',
    `capital_city` STRING COMMENT 'Official capital city of the country.',
    `country_name` STRING COMMENT 'Official short name of the sovereign nation or territory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the country record was first inserted.',
    `dialing_code` STRING COMMENT 'Country calling code used for telephone numbers.. Valid values are `^+d{1,4}$`',
    `effective_from` DATE COMMENT 'Date from which the country record is considered active.',
    `effective_until` DATE COMMENT 'Date after which the country record is no longer active; null if still active.',
    `fatf_high_risk_flag` BOOLEAN COMMENT 'True if the country is identified by FATF as high‑risk for money‑laundering or terrorism financing.',
    `is_amex_supported` BOOLEAN COMMENT 'Indicates whether American Express transactions are supported in the country.',
    `is_eu_member` BOOLEAN COMMENT 'True if the country is a member of the European Union.',
    `is_g20_member` BOOLEAN COMMENT 'True if the country participates in the Group of Twenty.',
    `is_g7_member` BOOLEAN COMMENT 'True if the country is part of the Group of Seven economies.',
    `is_mastercard_supported` BOOLEAN COMMENT 'Indicates whether Mastercard transactions are supported in the country.',
    `is_rtp_supported` BOOLEAN COMMENT 'True if real‑time payment infrastructure is available in the country.',
    `is_swift_supported` BOOLEAN COMMENT 'True if the country participates in the SWIFT global payments network.',
    `is_un_member` BOOLEAN COMMENT 'True if the country is a member of the United Nations.',
    `is_unionpay_supported` BOOLEAN COMMENT 'Indicates whether UnionPay transactions are supported in the country.',
    `is_visa_supported` BOOLEAN COMMENT 'Indicates whether Visa card transactions are supported in the country.',
    `iso_alpha2_code` STRING COMMENT 'Two‑letter country code defined by ISO 3166‑1.. Valid values are `^[A-Z]{2}$`',
    `iso_alpha3_code` STRING COMMENT 'Three‑letter country code defined by ISO 3166‑1.. Valid values are `^[A-Z]{3}$`',
    `iso_currency_code` STRING COMMENT 'Primary ISO 4217 currency code used for transactions in the country.. Valid values are `^[A-Z]{3}$`',
    `iso_numeric_code` STRING COMMENT 'Three‑digit numeric country code defined by ISO 3166‑1.. Valid values are `^d{3}$`',
    `language_codes` STRING COMMENT 'Comma‑separated list of ISO 639‑1 language codes spoken officially in the country.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the countrys centroid.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the countrys centroid.',
    `ofac_sanctions_flag` BOOLEAN COMMENT 'Indicates whether the country appears on the OFAC sanctions list.',
    `operational_status` STRING COMMENT 'Current usage status of the country record within the platform.. Valid values are `active|inactive|deprecated`',
    `psd2_applicability` BOOLEAN COMMENT 'True if the country falls under the EU PSD2 regulatory regime.',
    `region` STRING COMMENT 'Broad geographic region grouping (e.g., Africa, Americas).. Valid values are `Africa|Americas|Asia|Europe|Oceania`',
    `sub_region` STRING COMMENT 'More granular sub‑region classification (e.g., Western Europe, Southern Asia).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the country record.',
    CONSTRAINT pk_country PRIMARY KEY(`country_id`)
) COMMENT 'Global country reference master defining all sovereign nations and territories recognized by ISO 3166-1. Stores alpha-2 code, alpha-3 code, numeric code, country name, region, sub-region, dialing code, OFAC sanctions flag, FATF high-risk jurisdiction flag, PSD2 applicability, and operational status. Used across all domains for geographic classification, regulatory jurisdiction mapping, and cross-border payment routing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`currency` (
    `currency_id` BIGINT COMMENT 'Unique surrogate identifier for the currency record.',
    `country_code` STRING COMMENT 'Three-letter country code of the primary issuing country for the currency.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the currency record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter alphabetic code representing the currency per ISO 4217.. Valid values are `^[A-Z]{3}$`',
    `currency_description` STRING COMMENT 'Additional free-text description or notes about the currency.',
    `currency_name` STRING COMMENT 'Full official name of the currency.',
    `currency_type` STRING COMMENT 'Classification of the currency as fiat, digital (e.g., cryptocurrency), or commodity-backed.. Valid values are `fiat|digital|commodity`',
    `effective_from` DATE COMMENT 'Date when the currency became valid for use.',
    `effective_to` DATE COMMENT 'Date when the currency was retired or became invalid; null if still active.',
    `exchange_rate_source` STRING COMMENT 'Identifier of the source used for exchange rate data for this currency.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the currency is currently active for transactions.',
    `is_crypto` BOOLEAN COMMENT 'True if the currency is a cryptocurrency.',
    `is_fiat` BOOLEAN COMMENT 'True if the currency is a traditional fiat currency.',
    `is_historic` BOOLEAN COMMENT 'True if the currency is no longer in active circulation.',
    `iso_3166_numeric_country_code` STRING COMMENT 'Numeric country code associated with the currencys primary country.. Valid values are `^[0-9]{3}$`',
    `minor_unit` STRING COMMENT 'Number of decimal places used by the currency (e.g., 2 for USD).',
    `numeric_code` STRING COMMENT 'Three-digit numeric code for the currency per ISO 4217.. Valid values are `^[0-9]{3}$`',
    `rounding_rule` STRING COMMENT 'Rounding rule applied for the currency (e.g., round half up).',
    `symbol` STRING COMMENT 'Common symbol used to represent the currency (e.g., $).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the currency record.',
    CONSTRAINT pk_currency PRIMARY KEY(`currency_id`)
) COMMENT 'ISO 4217 currency reference master covering all active and historic currencies used in payment processing, FX conversion, and settlement. Stores currency code, numeric code, currency name, minor unit (decimal places), currency symbol, active flag, and associated country. Supports DCC, cross-border payment routing, and multi-currency settlement calculations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`mcc` (
    `mcc_id` BIGINT COMMENT 'System-generated surrogate key uniquely identifying each MCC record.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Linking MCC to transaction type for transaction categorization; transaction_type string becomes redundant.',
    `average_transaction_amount` DECIMAL(18,2) COMMENT 'Average monetary value per transaction for this MCC (currency‑agnostic).',
    `average_transaction_volume` DECIMAL(18,2) COMMENT 'Average number of transactions per month for merchants in this category (historical baseline).',
    `card_scheme_applicability` STRING COMMENT 'List of payment card schemes for which the MCC is valid (e.g., Visa, Mastercard, Amex, Discover).. Valid values are `visa|mastercard|amex|discover`',
    `category_group` STRING COMMENT 'Higher‑level grouping of MCCs (e.g., Retail, Services, Travel).',
    `compliance_status` STRING COMMENT 'Current compliance state of the MCC with applicable regulations (e.g., PCI DSS, AML).. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the MCC record was first created in the reference catalog.',
    `effective_from` DATE COMMENT 'Date on which the MCC definition becomes active for processing.',
    `effective_until` DATE COMMENT 'Date after which the MCC definition is retired or superseded (null if still active).',
    `high_risk_flag` BOOLEAN COMMENT 'True if the merchant category is considered high risk for fraud or compliance monitoring.',
    `industry_sector` STRING COMMENT 'Broad industry sector associated with the merchant category (e.g., Food & Beverage, Transportation).',
    `interchange_eligibility` STRING COMMENT 'Indicates whether transactions using this MCC qualify for standard interchange rates.. Valid values are `eligible|ineligible|partial`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the MCC record was last reviewed for accuracy and compliance.',
    `match_list_indicator` BOOLEAN COMMENT 'True if the MCC is included in the industry MATCH list for heightened monitoring.',
    `mcc_code` STRING COMMENT 'Four‑digit code that classifies the merchants primary business activity as defined by ISO 18245.. Valid values are `^d{4}$`',
    `mcc_description` STRING COMMENT 'Human‑readable description of the merchant category represented by the MCC.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information or remarks about the MCC.',
    `regulatory_jurisdiction` STRING COMMENT 'ISO‑3 country code indicating the primary regulatory jurisdiction for the MCC.. Valid values are `^[A-Z]{3}$`',
    `restricted_category_flag` BOOLEAN COMMENT 'True if the MCC falls under a regulatory restricted category (e.g., gambling, adult services).',
    `risk_score` STRING COMMENT 'Numeric risk rating (0‑100) derived from fraud and compliance analytics for the MCC.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the MCC record (e.g., Merchant Management System).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the MCC record.',
    `version_number` STRING COMMENT 'Incremental version of the MCC record to support change tracking.',
    CONSTRAINT pk_mcc PRIMARY KEY(`mcc_id`)
) COMMENT 'Merchant Category Code (MCC) reference catalog as defined by ISO 18245 and adopted by Visa, Mastercard, Amex, and Discover. Stores the 4-digit MCC code, merchant category description, card scheme applicability, interchange program eligibility, high-risk flag, restricted category flag, and MATCH list association indicator. Authoritative lookup used by merchant onboarding, interchange qualification, and fraud scoring.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`bin_range` (
    `bin_range_id` BIGINT COMMENT 'Unique surrogate key for the BIN range record. _canonical_skip_reason: Entity is a reference lookup table for BIN/IIN ranges.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: reference_bin_range references a card scheme; linking to reference_card_scheme via reference_card_scheme_id removes the duplicated string and enforces referential integrity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Linking bin range to country for standardized country reference; country_code becomes redundant.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Linking bin range to currency for standardized currency reference; currency_code becomes redundant.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: Linking bin range to MCC for merchant categorization; merchant_category_code becomes redundant.',
    `bin_end` STRING COMMENT 'Ending numeric prefix of the BIN/IIN range (inclusive).. Valid values are `^[0-9]{6,8}$`',
    `bin_length` STRING COMMENT 'Length of the BIN prefix (6, 7, or 8 digits).',
    `bin_range_description` STRING COMMENT 'Human‑readable description of the BIN range purpose or product line.',
    `bin_range_status` STRING COMMENT 'Current lifecycle status of the BIN range.. Valid values are `active|inactive|retired|pending`',
    `bin_start` STRING COMMENT 'Starting numeric prefix of the BIN/IIN range (6 to 8 digits).. Valid values are `^[0-9]{6,8}$`',
    `card_brand` STRING COMMENT 'Specific brand or product line of the card (e.g., Visa Signature).',
    `card_type` STRING COMMENT 'Category of card product associated with the BIN.. Valid values are `credit|debit|prepaid|commercial|virtual|fleet`',
    `compliance_status` STRING COMMENT 'Compliance status with relevant regulations (PCI DSS, PSD2, etc.).. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BIN range record was created in the system.',
    `effective_date` DATE COMMENT 'Date when the BIN range became effective for issuance.',
    `expiry_date` DATE COMMENT 'Date when the BIN range is no longer valid for new issuances.',
    `interchange_fee_category` STRING COMMENT 'Interchange fee category associated with the BIN range.. Valid values are `low|mid|high|standard|premium`',
    `is_3ds_supported` BOOLEAN COMMENT 'Indicates if the card supports 3‑D Secure authentication.',
    `is_commercial` BOOLEAN COMMENT 'Flag indicating the card is a commercial (business) card.',
    `is_contactless` BOOLEAN COMMENT 'Indicates if the card supports contactless (NFC) transactions.',
    `is_dcc_supported` BOOLEAN COMMENT 'Indicates if Dynamic Currency Conversion is supported for this BIN range.',
    `is_mcc_specific` BOOLEAN COMMENT 'Flag indicating if the BIN range is restricted to specific MCCs.',
    `is_prepaid` BOOLEAN COMMENT 'Flag indicating the card is a prepaid product.',
    `is_sca_exempt` BOOLEAN COMMENT 'Indicates if transactions with this BIN range are exempt from Strong Customer Authentication.',
    `is_tokenization_supported` BOOLEAN COMMENT 'Indicates if tokens can be generated for cards in this BIN range.',
    `is_virtual` BOOLEAN COMMENT 'Flag indicating the card is a virtual (non‑physical) card.',
    `issuing_bank_name` STRING COMMENT 'Legal name of the issuing financial institution.',
    `last_updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum allowed transaction amount per transaction for this BIN range.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum allowed transaction amount per transaction for this BIN range.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory jurisdiction applicable to the BIN range (e.g., US, EU).',
    `risk_score` STRING COMMENT 'Risk score assigned to the BIN range for fraud assessment (0‑100).',
    `source_system` STRING COMMENT 'Name of the source system that supplied the BIN range data.',
    `token_service_provider` STRING COMMENT 'Identifier of the token service provider (TSP) for this BIN range.',
    `transaction_currency_code` STRING COMMENT 'Default currency for transactions using this BIN range.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BIN range record.',
    CONSTRAINT pk_bin_range PRIMARY KEY(`bin_range_id`)
) COMMENT 'Bank Identification Number (BIN) / Issuer Identification Number (IIN) range registry defining the mapping of 6-to-8 digit BIN prefixes to issuing institutions, card schemes, card products, and funding types. Stores BIN range start/end, IIN, issuing bank name, card scheme, card type (credit/debit/prepaid), card brand, country of issuance, 3DS capability flag, contactless flag, and commercial card indicator. Critical for transaction routing, interchange qualification, and fraud risk assessment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` (
    `authorization_response_code_id` BIGINT COMMENT 'Unique surrogate identifier for each authorization response code record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Linking authorization response code to card scheme for scheme‑specific handling; scheme string becomes redundant.',
    `authorization_response_code_category` STRING COMMENT 'High‑level classification of the response: approved, declined, referral (e.g., need for additional authentication), or error.. Valid values are `approved|declined|referral|error`',
    `authorization_response_code_code` STRING COMMENT 'Standardized two- to four-character code returned by the issuing bank or scheme (e.g., "00", "05", "51").. Valid values are `^[A-Z0-9]{2,4}$`',
    `authorization_response_code_status` STRING COMMENT 'Current lifecycle status of the code record.. Valid values are `active|inactive|deprecated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first inserted into the reference table.',
    `effective_from` DATE COMMENT 'Date on which the response code becomes valid for processing.',
    `effective_until` DATE COMMENT 'Date after which the response code is no longer valid (null if still active).',
    `is_retriable` BOOLEAN COMMENT 'Indicates whether the transaction may be automatically retried (true) or must be halted (false).',
    `is_soft_decline` BOOLEAN COMMENT 'True when the decline is considered soft (e.g., insufficient funds) and may be resolved without cardholder action.',
    `message` STRING COMMENT 'Human‑readable description associated with the response code (e.g., "Approved", "Do not honour").',
    `notes` STRING COMMENT 'Optional free‑text field for additional remarks, change‑log entries, or governance comments.',
    `scheme_override_message` STRING COMMENT 'Optional scheme‑specific description that overrides the generic message for this code.',
    `source_system` STRING COMMENT 'Identifier of the originating system or standard (e.g., "ISO8583", "VisaCore").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_authorization_response_code PRIMARY KEY(`authorization_response_code_id`)
) COMMENT 'Standardized authorization response code reference table defining all ISO 8583 and card scheme response codes returned by issuing banks during transaction authorization. Stores response code, response message, response category (approved, declined, referral, error), retriable flag, soft decline indicator, and scheme-specific override descriptions for Visa, Mastercard, Amex, and Discover. Used by the authorization engine for decline management and retry logic.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`decline_code` (
    `decline_code_id` BIGINT COMMENT 'Unique surrogate identifier for each decline code record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Linking decline code to card scheme for decline categorization; scheme string becomes redundant.',
    `cardholder_message` STRING COMMENT 'Message displayed to the cardholder when decline occurs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the decline code record was created in the system.',
    `decline_code_category` STRING COMMENT 'High-level classification of decline reason (e.g., do-not-honor, insufficient-funds, fraud-suspected). [ENUM-REF-CANDIDATE: do_not_honor|insufficient_funds|lost_card|stolen_card|fraud_suspected|expired_card|invalid_cvv|invalid_pin|restricted_card|generic_decline — promote to reference product]',
    `decline_code_code` STRING COMMENT 'Standardized decline code used in transaction processing.',
    `decline_code_description` STRING COMMENT 'Human readable description of the decline reason.',
    `decline_code_status` STRING COMMENT 'Current lifecycle status of the decline code.. Valid values are `active|inactive|deprecated`',
    `effective_from` DATE COMMENT 'Date when the decline code becomes effective.',
    `effective_until` DATE COMMENT 'Date when the decline code is retired or superseded.',
    `is_default` BOOLEAN COMMENT 'Indicates if this decline code is the default for its category.',
    `merchant_message` STRING COMMENT 'Message provided to the merchant for the decline reason.',
    `retry_eligible` BOOLEAN COMMENT 'Indicates whether the transaction can be retried after this decline.',
    `source_system` STRING COMMENT 'Originating system that supplied the decline code (e.g., Payment Gateway, Authorization Engine).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the decline code record.',
    `version` STRING COMMENT 'Version of the decline code definition for change management.',
    CONSTRAINT pk_decline_code PRIMARY KEY(`decline_code_id`)
) COMMENT 'Decline code reference catalog mapping internal and scheme-level decline codes to standardized decline reason categories. Stores decline code, decline reason description, decline category (do-not-honor, insufficient-funds, lost-card, stolen-card, fraud-suspected, expired-card, etc.), retry eligibility flag, cardholder-facing message, and merchant-facing message. Distinct from authorization response codes — these are the business-level decline classifications used for reporting, retry orchestration, and cardholder communication.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`timezone` (
    `timezone_id` BIGINT COMMENT 'Surrogate primary key for the timezone record. _canonical_skip_reason: Inferred role REFERENCE_LOOKUP; no minimum category enforcement required.',
    `abbreviation` STRING COMMENT 'Common abbreviation for the time zone, e.g., EST.. Valid values are `^[A-Z]{2,5}$`',
    `associated_country_codes` STRING COMMENT 'Comma‑separated list of ISO 3166‑1 alpha‑3 country codes where the time zone is applicable.. Valid values are `^[A-Z]{3}(,[A-Z]{3})*$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the time zone record was created in the system.',
    `dst_observed` BOOLEAN COMMENT 'Indicates whether the time zone observes daylight saving time.',
    `effective_end_date` DATE COMMENT 'Date until which the time zone definition is effective; null if currently active.',
    `effective_start_date` DATE COMMENT 'Date from which the time zone definition is effective.',
    `iana_name` STRING COMMENT 'Standard IANA time zone identifier, e.g., America/New_York.. Valid values are `^[A-Za-z_]+/[A-Za-z_]+$`',
    `is_active` BOOLEAN COMMENT 'Indicates if the time zone record is currently active for use.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the time zone entry.',
    `source_system` STRING COMMENT 'Identifier of the source system that supplied the time zone data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the time zone record.',
    `utc_offset_dst` STRING COMMENT 'UTC offset during daylight saving time period, expressed as ±HH:MM.. Valid values are `^([+-][0-1][0-9]:[0-5][0-9])$`',
    `utc_offset_standard` STRING COMMENT 'UTC offset during standard (non-DST) period, expressed as ±HH:MM.. Valid values are `^([+-][0-1][0-9]:[0-5][0-9])$`',
    CONSTRAINT pk_timezone PRIMARY KEY(`timezone_id`)
) COMMENT 'Timezone reference master covering all IANA timezone identifiers used for timestamp normalization, settlement cutoff scheduling, and regulatory reporting. Stores IANA timezone ID, UTC offset (standard), UTC offset (DST), DST observance flag, timezone abbreviation, associated country codes, and effective date range. Ensures consistent timestamp handling across multi-region payment processing and settlement batch scheduling.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` (
    `holiday_calendar_id` BIGINT COMMENT 'System-generated unique identifier for each holiday calendar record.',
    `payment_rail_id` BIGINT COMMENT 'Foreign key linking to reference.payment_rail. Business justification: Linking holiday calendar to payment rail for rail‑specific holiday schedules; payment_rail string becomes redundant.',
    `applicable_scheme` STRING COMMENT 'Card scheme(s) for which the holiday is observed.. Valid values are `visa|mastercard|amex|discover|unionpay|other`',
    `calendar_name` STRING COMMENT 'Human‑readable name of the holiday calendar (e.g., "US National Holidays").',
    `calendar_type` STRING COMMENT 'Category of holiday (national, banking, scheme, ACH, RTGS, or other).. Valid values are `national|banking|scheme|ach|rtgs|other`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code to which the holiday applies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the holiday record was first created in the system.',
    `effective_from` DATE COMMENT 'Start date from which the holiday definition is valid.',
    `effective_until` DATE COMMENT 'End date after which the holiday definition is no longer valid (null if indefinite).',
    `holiday_calendar_description` STRING COMMENT 'Optional free‑text description providing additional context about the holiday.',
    `holiday_calendar_status` STRING COMMENT 'Current lifecycle status of the holiday record.. Valid values are `active|inactive|deprecated`',
    `holiday_date` DATE COMMENT 'Calendar date on which the holiday occurs.',
    `holiday_name` STRING COMMENT 'Descriptive name of the holiday (e.g., "Independence Day").',
    `is_recurring` BOOLEAN COMMENT 'True if the holiday recurs annually on the same date.',
    `is_settlement_holiday` BOOLEAN COMMENT 'True if the holiday prevents settlement processing for the applicable rail.',
    `timezone` STRING COMMENT 'IANA timezone identifier used to interpret the holiday date for regions spanning multiple time zones.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the holiday record.',
    CONSTRAINT pk_holiday_calendar PRIMARY KEY(`holiday_calendar_id`)
) COMMENT 'Business holiday calendar master defining non-processing days for each country, payment rail, and card scheme. Stores calendar name, country code, calendar type (national holiday, banking holiday, scheme holiday, ACH holiday, RTGS holiday), holiday date, holiday name, and applicable payment rails. Used by settlement batch scheduling, RTGS/RTP cutoff management, and SLA calculation engines to determine valid processing days.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`card_scheme` (
    `card_scheme_id` BIGINT COMMENT 'Unique surrogate key for each card scheme record. _canonical_skip_reason: Inferred role REFERENCE_LOOKUP; no minimum categories required.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Adds a foreign key from reference_card_scheme to regulatory_jurisdiction, replacing the string column and providing a normalized relationship.',
    `card_scheme_description` STRING COMMENT 'Free‑form description of the scheme, including business purpose and key characteristics.',
    `card_scheme_name` STRING COMMENT 'Full legal name of the card scheme.',
    `card_scheme_status` STRING COMMENT 'Current operational status of the scheme within the platform.. Valid values are `active|inactive|deprecated`',
    `card_scheme_type` STRING COMMENT 'Classification of the scheme based on network structure.. Valid values are `four_party|three_party|domestic`',
    `chargeback_time_limit_days` STRING COMMENT 'Maximum number of days a cardholder can initiate a chargeback under this scheme.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the scheme with relevant standards.. Valid values are `compliant|non_compliant|pending_review`',
    `contact_email` STRING COMMENT 'Primary email address for scheme support and communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for scheme support.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scheme record was first created.',
    `effective_from` DATE COMMENT 'Date when the scheme record became effective in the system.',
    `effective_until` DATE COMMENT 'Date when the scheme record expires or is superseded; null if indefinite.',
    `headquarters_country` STRING COMMENT 'Country where the schemes corporate headquarters is located.',
    `iso_20022_message_schemes` STRING COMMENT 'Comma‑separated list of ISO 20022 message families (e.g., pain.001, camt.053) used by the scheme.',
    `iso_8583_message_type_codes` STRING COMMENT 'Comma‑separated list of ISO 8583 MTI values supported by the scheme.',
    `scheme_code` STRING COMMENT 'Standard short code identifying the payment network (e.g., VISA, MC, AMEX).',
    `supported_card_types` STRING COMMENT 'Comma‑separated list of card product types the scheme supports (e.g., credit, debit, prepaid, commercial).',
    `supported_transaction_types` STRING COMMENT 'Comma‑separated list of transaction categories (e.g., purchase, cash‑advance, refund, recurring).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scheme record.',
    `website_url` STRING COMMENT 'Official public website of the card scheme.',
    CONSTRAINT pk_card_scheme PRIMARY KEY(`card_scheme_id`)
) COMMENT 'Card scheme (payment network brand) reference master defining all payment networks supported by the platform — Visa, Mastercard, American Express, Discover, UnionPay, JCB, Diners Club, and domestic schemes. Stores scheme code, scheme name, scheme type (four-party, three-party, domestic), headquarters country, supported card types, supported transaction types, chargeback time limits, and scheme contact details. SSOT for card scheme identity referenced across transaction, interchange, dispute, and network domains.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`payment_rail` (
    `payment_rail_id` BIGINT COMMENT 'Unique surrogate identifier for the payment rail record. _canonical_skip_reason: inferred role REFERENCE_LOOKUP, no minimum categories required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the rail became effective for use.',
    `effective_until` DATE COMMENT 'Date when the rail is retired or no longer supported (null if indefinite).',
    `geographic_coverage` STRING COMMENT 'Regions or countries where the rail is available, expressed as 3‑letter ISO country codes.',
    `message_standard` STRING COMMENT 'Financial messaging standard used by the rail.. Valid values are `iso_8583|iso_20022|nacha|swift|sepa`',
    `payment_rail_description` STRING COMMENT 'Free‑form description providing additional details about the rail.',
    `payment_rail_status` STRING COMMENT 'Current lifecycle status of the rail.. Valid values are `active|inactive|deprecated`',
    `rail_code` STRING COMMENT 'Standard short code identifying the payment rail (e.g., VISA, ACH, SWIFT).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `rail_name` STRING COMMENT 'Human‑readable name of the payment rail.',
    `rail_type` STRING COMMENT 'Category of the rail indicating the underlying payment mechanism.. Valid values are `card|ach|wire|rtp|rtgs|crypto`',
    `settlement_finality` STRING COMMENT 'Indicates whether settlement is final on gross, net, or deferred basis.. Valid values are `gross|net|deferred`',
    `stp_capability` BOOLEAN COMMENT 'Indicates whether the rail supports end‑to‑end straight‑through processing without manual intervention.',
    `supported_currencies` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes supported by the rail.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_payment_rail PRIMARY KEY(`payment_rail_id`)
) COMMENT 'Payment rail reference master defining all electronic payment networks and clearing rails supported by the platform — Visa, Mastercard, ACH, SWIFT, SEPA, RTP, RTGS, UPI, FedWire, CHIPS, and domestic real-time rails. Stores rail code, rail name, rail type (card, ACH, wire, RTP, RTGS, crypto), settlement finality type (gross, net, deferred), supported currencies, geographic coverage, message standard (ISO 8583, ISO 20022, NACHA), and STP capability flag.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` (
    `regulatory_jurisdiction_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory jurisdiction record.',
    `jurisdiction_parent_regulatory_jurisdiction_id` BIGINT COMMENT 'Identifier of the parent jurisdiction in hierarchical structures (e.g., EU as parent of member states).',
    `aml_ctf_regime` STRING COMMENT 'Anti‑Money‑Laundering / Counter‑Terrorism Financing regime governing the jurisdiction.. Valid values are `FinCEN|FATF|EU_AML_Directive`',
    `applicable_regulations` STRING COMMENT 'Comma‑separated list of regulatory frameworks that apply to the jurisdiction (e.g., GDPR, PSD2, CCPA). [ENUM-REF-CANDIDATE: GDPR|PSD2|CCPA|BSA|SOX|FATF|AML|CTF|PCI_DSS|SOX|GLBA|HIPAA — promote to reference product]',
    `compliance_contact_email` STRING COMMENT 'Email address of the compliance officer responsible for this jurisdiction.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `country_iso_code` STRING COMMENT 'Three‑letter ISO country code associated with the jurisdiction, if applicable.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the jurisdiction record was first created in the system.',
    `cross_border_data_transfer` STRING COMMENT 'Policy governing cross‑border data transfers from this jurisdiction.. Valid values are `allowed|restricted|prohibited`',
    `data_residency_requirement` STRING COMMENT 'Requirement for where data must be stored for entities operating in the jurisdiction.. Valid values are `onshore|offshore|hybrid`',
    `effective_date` DATE COMMENT 'Date when the jurisdictions regulatory profile became effective.',
    `expiry_date` DATE COMMENT 'Date when the regulatory profile expires or is superseded; null if indefinite.',
    `financial_law` STRING COMMENT 'Key financial regulatory statutes relevant to the jurisdiction.',
    `is_anti_money_laundering_required` BOOLEAN COMMENT 'Indicates whether AML controls are mandatory in the jurisdiction.',
    `is_ccpa_applicable` BOOLEAN COMMENT 'True if the California Consumer Privacy Act applies to the jurisdiction.',
    `is_data_protection_officer_required` BOOLEAN COMMENT 'Indicates whether the jurisdiction mandates a Data Protection Officer under privacy law.',
    `is_fatf_member` BOOLEAN COMMENT 'Indicates whether the jurisdiction is a member of the Financial Action Task Force.',
    `is_financial_reporting_required` BOOLEAN COMMENT 'Indicates if entities must file periodic financial reports to the regulator.',
    `is_gdpr_applicable` BOOLEAN COMMENT 'True if the General Data Protection Regulation applies to the jurisdiction.',
    `is_psd2_applicable` BOOLEAN COMMENT 'True if the EU Payment Services Directive 2 applies to the jurisdiction.',
    `is_sar_filing_required` BOOLEAN COMMENT 'Indicates whether Suspicious Activity Reports must be filed under local law.',
    `jurisdiction_code` STRING COMMENT 'Standardized code representing the jurisdiction, following ISO 3166-2 where applicable.. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{1,3})?$`',
    `jurisdiction_currency_code` STRING COMMENT 'ISO 4217 currency code used primarily within the jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_language` STRING COMMENT 'Primary language code of the jurisdiction.. Valid values are `^[a-z]{2}$`',
    `jurisdiction_name` STRING COMMENT 'Full descriptive name of the jurisdiction (e.g., United Kingdom, European Union).',
    `jurisdiction_time_zone` STRING COMMENT 'Primary IANA time‑zone identifier for the jurisdiction.. Valid values are `^[A-Za-z_]+/[A-Za-z_]+$`',
    `jurisdiction_type` STRING COMMENT 'Classification of the jurisdictions scope: national, supranational, state/provincial, or regional.. Valid values are `national|supranational|state_provincial|regional`',
    `last_review_date` DATE COMMENT 'Date when the jurisdictions regulatory information was last reviewed for accuracy.',
    `notes` STRING COMMENT 'Internal notes or comments related to the jurisdiction entry.',
    `primary_regulator` STRING COMMENT 'Name of the principal regulatory authority overseeing the jurisdiction (e.g., FCA, ECB).',
    `privacy_law` STRING COMMENT 'Primary privacy legislation applicable (e.g., GDPR, CCPA).',
    `region_name` STRING COMMENT 'Geographic region or sub‑region the jurisdiction belongs to (e.g., Europe, Asia‑Pacific).',
    `regulator_type` STRING COMMENT 'Category of the regulator: supervisory agency, self‑regulatory organization, or government body.. Valid values are `supervisory|self_regulatory|government`',
    `regulatory_jurisdiction_description` STRING COMMENT 'Free‑form description providing additional context about the jurisdiction.',
    `regulatory_jurisdiction_status` STRING COMMENT 'Current lifecycle status of the jurisdiction record.. Valid values are `active|inactive|deprecated`',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the jurisdictions regulatory profile.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the jurisdiction data (e.g., Risk and Compliance Management System).',
    `tax_identification_number_format` STRING COMMENT 'Pattern or description of the tax identification number format used in the jurisdiction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the jurisdiction record.',
    CONSTRAINT pk_regulatory_jurisdiction PRIMARY KEY(`regulatory_jurisdiction_id`)
) COMMENT 'Regulatory jurisdiction reference master mapping geographic regions and countries to their applicable regulatory frameworks, governing bodies, and compliance requirements. Stores jurisdiction code, jurisdiction name, jurisdiction type (national, supranational, state/provincial), primary regulator, applicable regulations (PSD2, GDPR, CCPA, BSA, Regulation E, Regulation II), AML/CTF regime, data residency requirements, and cross-border data transfer restrictions. Used by compliance, AML screening, and regulatory reporting modules.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`transaction_type` (
    `transaction_type_id` BIGINT COMMENT 'Unique surrogate key for each transaction type record. _canonical_skip_reason: Entity is a reference lookup, no mandatory minimum categories required.',
    `applicable_payment_rails` STRING COMMENT 'Comma‑separated list of payment rails that can process this transaction type.. Valid values are `card|ach|wire|digital_wallet|p2p|a2a`',
    `card_scheme` STRING COMMENT 'Payment card network(s) that support this transaction type.. Valid values are `visa|mastercard|amex|unionpay|discover|others`',
    `chargeback_timeframe_days` STRING COMMENT 'Number of days after settlement during which a chargeback may be initiated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the transaction type record was first created.',
    `cross_border_fee_indicator` STRING COMMENT 'Indicates whether a cross‑border fee is applied, waived, or not applicable.. Valid values are `applied|waived|none`',
    `currency_code` STRING COMMENT 'Three‑letter currency code used for the transaction type when fixed.',
    `effective_from` DATE COMMENT 'Date from which the transaction type is valid for processing.',
    `effective_until` DATE COMMENT 'Date after which the transaction type is no longer valid; null if open‑ended.',
    `financial_impact` STRING COMMENT 'Indicates whether the transaction type results in a debit, credit, or neutral effect on the account balance.. Valid values are `debit|credit|neutral`',
    `is_chargeback_possible` BOOLEAN COMMENT 'True if a chargeback can be filed against this transaction type.',
    `is_cross_border` BOOLEAN COMMENT 'True if the transaction type is used for cross‑border payments.',
    `is_default` BOOLEAN COMMENT 'True if this type is used as the default when no explicit type is supplied.',
    `is_external` BOOLEAN COMMENT 'True if the transaction type is defined by an external payment scheme rather than internal policy.',
    `is_fraud_sensitive` BOOLEAN COMMENT 'Indicates whether the transaction type is subject to heightened fraud monitoring.',
    `is_recurring_allowed` BOOLEAN COMMENT 'True if the transaction type can be used in recurring payment schedules.',
    `is_settlement_required` BOOLEAN COMMENT 'Indicates whether the transaction type must go through settlement processing.',
    `is_tokenizable` BOOLEAN COMMENT 'Indicates whether the transaction type can be tokenized.',
    `iso_20022_message_type` STRING COMMENT 'Corresponding ISO 20022 message identifier (e.g., pain.001).',
    `iso_8583_processing_code` STRING COMMENT 'Six‑digit processing code defined by ISO 8583 for routing and handling.',
    `max_amount_limit` DECIMAL(18,2) COMMENT 'Upper monetary limit for transactions of this type.',
    `min_amount_limit` DECIMAL(18,2) COMMENT 'Lower monetary threshold for transactions of this type.',
    `processing_fee_indicator` STRING COMMENT 'Who bears the processing fee for this transaction type.. Valid values are `merchant|issuer|none`',
    `recurring_interval` STRING COMMENT 'Default interval for recurring instances of this transaction type.. Valid values are `daily|weekly|monthly|yearly|none`',
    `requires_3ds` BOOLEAN COMMENT 'True if the transaction type mandates 3‑Domain Secure authentication.',
    `requires_authentication` BOOLEAN COMMENT 'True if the transaction type requires real‑time authentication (e.g., 3‑DS).',
    `requires_sca` BOOLEAN COMMENT 'True if Strong Customer Authentication is required per PSD2.',
    `reversal_eligibility_reason` STRING COMMENT 'Business rule description why a type is or isn’t reversible.',
    `reversal_eligible` BOOLEAN COMMENT 'True if the transaction type can be reversed (e.g., refund, void).',
    `settlement_cycle` STRING COMMENT 'Typical settlement timing for this transaction type.. Valid values are `same_day|next_day|t+2|t+3|custom`',
    `settlement_treatment` STRING COMMENT 'Defines how the transaction is settled: immediate, deferred, or netted.. Valid values are `immediate|deferred|netting`',
    `tokenization_method` STRING COMMENT 'Method of token generation for tokenizable transaction types.. Valid values are `static|dynamic|none`',
    `transaction_category` STRING COMMENT 'High‑level category aligning with ISO 20022 (e.g., purchase, refund, cash‑advance).',
    `transaction_fee_amount` DECIMAL(18,2) COMMENT 'Flat fee charged per transaction when fee type is fixed.',
    `transaction_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction amount charged as fee when fee type is percentage.',
    `transaction_fee_type` STRING COMMENT 'Method used to calculate any fee associated with the transaction type.. Valid values are `fixed|percentage|none`',
    `transaction_type_code` STRING COMMENT 'Short alphanumeric code representing the transaction type (e.g., PUR for Purchase).',
    `transaction_type_description` STRING COMMENT 'Full textual description of the transaction type, its purpose and typical usage.',
    `transaction_type_name` STRING COMMENT 'Descriptive name of the transaction type (e.g., Purchase, Refund).',
    `transaction_type_status` STRING COMMENT 'Current lifecycle status of the transaction type.. Valid values are `active|inactive|deprecated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the record.',
    CONSTRAINT pk_transaction_type PRIMARY KEY(`transaction_type_id`)
) COMMENT 'Transaction type reference catalog defining all standardized payment transaction types processed on the platform — purchase, refund, authorization, pre-authorization, capture, void, reversal, balance inquiry, cash advance, quasi-cash, P2P transfer, A2A transfer, BNPL disbursement, and more. Stores transaction type code, transaction type name, ISO 8583 processing code, financial impact (debit/credit/neutral), reversal eligibility, settlement treatment, and applicable payment rails.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` (
    `chargeback_reason_code_id` BIGINT COMMENT 'System‑generated unique identifier for each chargeback reason code record.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Linking chargeback reason code to regulatory jurisdiction for dispute handling; jurisdiction string becomes redundant.',
    `chargeback_reason_code_code` STRING COMMENT 'Alphanumeric identifier assigned by the card scheme (e.g., 4837, R01).. Valid values are `^[A-Z0-9]{1,10}$`',
    `chargeback_reason_code_description` STRING COMMENT 'Full textual explanation of the chargeback reason as defined by the scheme.',
    `chargeback_reason_code_status` STRING COMMENT 'Operational status indicating whether the code is currently usable.. Valid values are `active|inactive|deprecated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the reason code entry was first inserted.',
    `dispute_category` STRING COMMENT 'Broad category indicating why the chargeback was raised (e.g., fraud, authorization error).. Valid values are `fraud|authorization|processing_error|consumer_dispute`',
    `documentation_requirements` STRING COMMENT 'List of required supporting documents (e.g., receipt, proof of delivery) for this reason code.',
    `effective_from` DATE COMMENT 'First date on which the reason code is valid for use.',
    `effective_until` DATE COMMENT 'Last date on which the reason code may be used; null if still active.',
    `is_mandatory` BOOLEAN COMMENT 'True when regulatory or scheme rules require this reason code to be captured.',
    `last_reviewed_by` STRING COMMENT 'Identifier of the data steward responsible for the most recent review.',
    `last_reviewed_date` DATE COMMENT 'Calendar date when the reason code was last validated by data governance.',
    `legacy_code` STRING COMMENT 'Previous code value retained for backward compatibility.',
    `notes` STRING COMMENT 'Additional comments or clarifications about the reason code.',
    `reason_code_type` STRING COMMENT 'Specifies whether the entry is a chargeback, retrieval request, or representment reason.. Valid values are `chargeback|retrieval|representment`',
    `response_time_limit_days` STRING COMMENT 'Allowed response window in calendar days for the merchant to address the chargeback.',
    `risk_level` STRING COMMENT 'Indicates the typical fraud risk severity for disputes under this reason.. Valid values are `low|medium|high`',
    `scheme` STRING COMMENT 'Payment network that issued the reason code (Visa, Mastercard, Amex, Discover).. Valid values are `visa|mastercard|amex|discover`',
    `subcategory` STRING COMMENT 'Secondary classification providing finer detail (e.g., duplicate_processing, counterfeit_card).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the reason code entry.',
    `version` STRING COMMENT 'Semantic version of the reason code entry (e.g., v1.0, v2.3).. Valid values are `^vd+.d+$`',
    CONSTRAINT pk_chargeback_reason_code PRIMARY KEY(`chargeback_reason_code_id`)
) COMMENT 'Comprehensive chargeback and dispute reason code reference catalog covering all card scheme reason code taxonomies — Visa Dispute Resolution (VDR), Mastercard Dispute Resolution (MDR), Amex, and Discover. Stores scheme-specific reason code, reason code description, dispute category (fraud, authorization, processing error, consumer dispute), response time limit (days), documentation requirements, and effective/expiry dates. Distinct from dispute.reason_code which is the operational instance — this is the authoritative reference definition owned by the reference domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`fx_rate` (
    `fx_rate_id` BIGINT COMMENT 'System-generated unique identifier for each FX rate record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Linking FX rate to base currency for accurate currency conversion; base_currency_code becomes redundant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate record was first created in the system.',
    `effective_timestamp` TIMESTAMP COMMENT 'Date‑time when the rate becomes effective for transaction conversion.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Numeric exchange rate representing how many units of the quote currency equal one unit of the base currency.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the rate expires or is superseded by a newer rate.',
    `fx_rate_description` STRING COMMENT 'Free‑form description or notes about the rate, such as market conditions or special handling.',
    `fx_rate_status` STRING COMMENT 'Current lifecycle status of the rate record.. Valid values are `active|inactive|deprecated|pending`',
    `is_intraday` BOOLEAN COMMENT 'True if the rate is an intraday (real‑time) quote; false for end‑of‑day rates.',
    `market` STRING COMMENT 'Geographic market or region where the rate is primarily used (e.g., "EMEA", "APAC").',
    `precision` STRING COMMENT 'Number of decimal places the rate is rounded to.',
    `provider_identifier` STRING COMMENT 'Alphanumeric identifier of the external or internal provider supplying the rate.',
    `quote_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the quote currency in the pair.',
    `rate_category` STRING COMMENT 'Business classification of the rate based on market segment.. Valid values are `interbank|retail|wholesale|central_bank`',
    `rate_pair` STRING COMMENT 'Human‑readable identifier of the currency pair, e.g., "USD_EUR".',
    `rate_source` STRING COMMENT 'Origin of the rate data – European Central Bank (ECB), Reuters, or internal pricing engine.. Valid values are `ecb|reuters|internal`',
    `rate_type` STRING COMMENT 'Classification of the rate: spot, mid, buy, sell, or dynamic currency conversion (DCC).. Valid values are `spot|mid|buy|sell|dcc`',
    `source_system` STRING COMMENT 'Name of the upstream system or feed that supplied the rate record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate record.',
    CONSTRAINT pk_fx_rate PRIMARY KEY(`fx_rate_id`)
) COMMENT 'Foreign exchange rate reference feed capturing daily and intraday FX rates for all currency pairs used in cross-border payment processing and DCC. Stores base currency, quote currency, exchange rate, rate type (spot, mid, buy, sell, DCC), rate source (ECB, Reuters, internal), effective timestamp, expiry timestamp, and rate provider identifier. Serves as the authoritative FX rate reference for transaction conversion, settlement FX, and DCC pricing across the platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`swift_bic` (
    `swift_bic_id` BIGINT COMMENT 'System-generated unique identifier for the SWIFT BIC record.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Linking SWIFT BIC to country for jurisdictional reporting; country_code becomes redundant.',
    `address_line1` STRING COMMENT 'Primary street address of the institution.',
    `address_line2` STRING COMMENT 'Secondary address information (optional).',
    `bic_code` STRING COMMENT '8‑ or 11‑character SWIFT BIC code as defined by ISO 9362.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `branch_code` STRING COMMENT 'Three‑character branch identifier (optional for 11‑character BICs).. Valid values are `^[A-Z0-9]{3}$`',
    `city` STRING COMMENT 'City where the institutions head office or branch is situated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the BIC record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the BIC became valid for routing.',
    `effective_until` DATE COMMENT 'Date when the BIC ceased to be valid (null if still active).',
    `email_address` STRING COMMENT 'Primary contact email for the institution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `institution_name` STRING COMMENT 'Legal name of the financial institution associated with the BIC.',
    `institution_type` STRING COMMENT 'Category of the institution (e.g., bank, broker, PSP).. Valid values are `bank|broker|payment_service_provider|clearing_house|central_bank|other`',
    `is_gpi_supported` BOOLEAN COMMENT 'True if the institution supports SWIFT Global Payments Innovation.',
    `is_iban_supported` BOOLEAN COMMENT 'True if the institution can receive IBAN‑based transfers.',
    `is_rtp_supported` BOOLEAN COMMENT 'True if the institution can receive RTP payments.',
    `is_sepa_supported` BOOLEAN COMMENT 'True if the institution participates in the SEPA scheme.',
    `is_swift_supported` BOOLEAN COMMENT 'True if the institution participates in SWIFT messaging.',
    `iso_9362_compliance_flag` BOOLEAN COMMENT 'Indicates whether the institution complies with ISO 9362 standards.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the BIC record was last reviewed for accuracy.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the institution.. Valid values are `^+?[0-9]{7,15}$`',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the institutions address.. Valid values are `^[A-Z0-9]{3,10}$`',
    `sepa_reachability_flag` BOOLEAN COMMENT 'True if the institution can receive SEPA payments.',
    `swift_bic_status` STRING COMMENT 'Overall lifecycle status of the BIC record.. Valid values are `active|inactive|deprecated|pending`',
    `swift_connectivity_status` STRING COMMENT 'Current operational status of the institution on the SWIFT network.. Valid values are `active|inactive|suspended`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the BIC record.',
    `website_url` STRING COMMENT 'Public website URL of the institution.. Valid values are `^https?://.+$`',
    CONSTRAINT pk_swift_bic PRIMARY KEY(`swift_bic_id`)
) COMMENT 'SWIFT BIC (Bank Identifier Code) reference registry covering all financial institutions registered in the SWIFT network. Stores BIC code (8 or 11 character), institution name, institution type, country code, city, branch code, SWIFT connectivity status, ISO 9362 compliance flag, and SEPA reachability flag. Used for cross-border payment routing, IBAN validation, correspondent banking lookups, and SWIFT gpi message addressing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`iban_structure` (
    `iban_structure_id` BIGINT COMMENT 'Unique identifier for the IBAN structure record. _canonical_skip_reason: Inferred role REFERENCE_LOOKUP; no minimum category enforcement required.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Linking IBAN structure to country for validation rules; country_code becomes redundant.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Linking IBAN structure to currency for validation rules; currency_code becomes redundant.',
    `account_number_length` STRING COMMENT 'Length of the account number segment in characters.',
    `account_number_position` STRING COMMENT 'Location of the account number within the BBAN.',
    `bank_identifier_length` STRING COMMENT 'Length of the bank identifier segment in characters.',
    `bank_identifier_position` STRING COMMENT 'Location of the bank identifier within the BBAN (e.g., start, middle, end).',
    `bban_length` STRING COMMENT 'Number of characters in the BBAN portion of the IBAN.',
    `bban_pattern` STRING COMMENT 'Pattern describing the structure of the BBAN portion of the IBAN (e.g., 4!a6!n2!a).',
    `bban_regex` STRING COMMENT 'Regular expression used to validate the BBAN portion of the IBAN.',
    `branch_identifier_length` STRING COMMENT 'Length of the branch identifier segment in characters.',
    `branch_identifier_position` STRING COMMENT 'Location of the branch identifier within the BBAN.',
    `check_digit_algorithm` STRING COMMENT 'Algorithm used to calculate the two check digits of the IBAN, typically MOD‑97‑10.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IBAN structure record was first created.',
    `effective_from` DATE COMMENT 'Date from which the IBAN format definition is valid.',
    `effective_until` DATE COMMENT 'Date after which the IBAN format definition is no longer valid (null if still active).',
    `example_iban` STRING COMMENT 'A valid example IBAN for the country, used for testing and documentation.',
    `iban_length` STRING COMMENT 'Total number of characters in a valid IBAN for the country.',
    `iban_regex` STRING COMMENT 'Regular expression used by validation engines to verify the full IBAN format.',
    `iban_structure_description` STRING COMMENT 'Human‑readable description of the IBAN format and any special notes.',
    `iban_structure_status` STRING COMMENT 'Current lifecycle status of the IBAN definition.. Valid values are `active|inactive|deprecated`',
    `last_validated_date` DATE COMMENT 'Date when the IBAN format definition was last validated against live data.',
    `national_check_digit_length` STRING COMMENT 'Length of the national check digit segment in characters.',
    `national_check_digit_position` STRING COMMENT 'Location of any national check digit within the BBAN.',
    `sepa_member_flag` BOOLEAN COMMENT 'True if the country participates in the Single Euro Payments Area (SEPA).',
    `source_system` STRING COMMENT 'Originating system or standard that supplied the IBAN definition.. Valid values are `SWIFT|ISO20022|SEPA`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the IBAN structure record.',
    `validation_rule_version` STRING COMMENT 'Version identifier of the validation rule set applied to this IBAN structure.',
    CONSTRAINT pk_iban_structure PRIMARY KEY(`iban_structure_id`)
) COMMENT 'IBAN (International Bank Account Number) structure reference defining the format, length, and validation rules for IBANs by country. Stores country code, IBAN length, BBAN format pattern, check digit algorithm, example IBAN, SEPA membership flag, and effective date. Used by payment validation engines to verify IBAN format correctness before cross-border payment submission, reducing SWIFT rejection rates.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` (
    `nacha_return_code_id` BIGINT COMMENT 'System‑generated unique identifier for each NACHA return code record.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Linking NACHA return code to regulatory jurisdiction for compliance tracking; regulatory_reference string becomes redundant.',
    `applicable_sec_codes` STRING COMMENT 'Comma‑separated list of Standard Entry Class (SEC) codes to which the return code applies (e.g., PPD, CCD, WEB, TEL). [ENUM-REF-CANDIDATE: PPD|CCD|WEB|TEL|CTX|BCH|RCK|POP|POS|ARC|BOC|CIE|CIP|CNR|DNE|EPN|IAT|MTE|PPD|TEL|WEB|XCK] ',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the return code record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the return code definition becomes effective.',
    `effective_until` DATE COMMENT 'Date after which the return code definition is no longer valid (null if still active).',
    `is_noc` BOOLEAN COMMENT 'Indicates whether the return code also serves as a Notification of Change (NOC) code.',
    `nacha_return_code_status` STRING COMMENT 'Current lifecycle status of the return code record.. Valid values are `active|inactive|deprecated`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or business comments about the return code.',
    `reinitiation_eligible` BOOLEAN COMMENT 'True if the originating institution may re‑initiate the ACH entry after this return; otherwise false.',
    `return_category` STRING COMMENT 'Broad classification of the return reason (administrative, account, authorization, or network).. Valid values are `administrative|account|authorization|network`',
    `return_code` STRING COMMENT 'Standard four‑character NACHA return code (e.g., R01, R02).',
    `return_reason_description` STRING COMMENT 'Human‑readable description of the return reason associated with the return code.',
    `return_time_limit_days` STRING COMMENT 'Maximum number of banking days allowed for the return to be processed.',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the return code definition (e.g., ACH Processor, Core Banking).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the return code record.',
    CONSTRAINT pk_nacha_return_code PRIMARY KEY(`nacha_return_code_id`)
) COMMENT 'NACHA ACH return and notification of change (NOC) code reference catalog defining all standardized return reason codes for ACH transactions. Stores return code, return reason description, return category (administrative, account, authorization, network), NOC flag, re-initiation eligibility, time limit for return (banking days), and applicable SEC codes (PPD, CCD, WEB, TEL). Used by ACH processing and settlement reconciliation modules.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`emv_tag` (
    `emv_tag_id` BIGINT COMMENT 'Unique surrogate key for each EMV tag record. _canonical_skip_reason: Entity is a reference lookup catalog of EMV data elements, thus no minimum role categories required.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Linking EMV tag to regulatory jurisdiction for security standards mapping; regulatory_jurisdiction string becomes redundant.',
    `compliance_status` STRING COMMENT 'Compliance verification status against EMVCo and PCI DSS requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tag record was first created in the reference catalog.',
    `data_format` STRING COMMENT 'Format of the tag value as defined by EMVCo.. Valid values are `numeric|alphanumeric|binary`',
    `effective_from` DATE COMMENT 'Date from which the tag definition is considered active.',
    `effective_until` DATE COMMENT 'Date after which the tag definition is no longer active (null if indefinite).',
    `emv_tag_status` STRING COMMENT 'Current lifecycle status of the tag definition.. Valid values are `active|inactive|deprecated`',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the tag is deprecated and should no longer be used.',
    `iso_7816_reference` STRING COMMENT 'Reference to the ISO 7816 standard clause that defines the tag.',
    `kernel_applicability` STRING COMMENT 'Kernel types that support the tag (contact, contactless, NFC, or both).. Valid values are `contact|contactless|nfc|both`',
    `length_max` STRING COMMENT 'Maximum number of bytes for the tag value.',
    `length_min` STRING COMMENT 'Minimum number of bytes for the tag value.',
    `notes` STRING COMMENT 'Free‑form notes for additional context, such as implementation tips or historical changes.',
    `source` STRING COMMENT 'Origin of the tag data: card, terminal, or issuer.. Valid values are `card|terminal|issuer`',
    `tag_description` STRING COMMENT 'Detailed description of the data element represented by the tag.',
    `tag_hex` STRING COMMENT 'Hexadecimal code of the EMV tag as defined by EMVCo (e.g., 9F02).. Valid values are `^[0-9A-Fa-f]{2,4}$`',
    `tag_name` STRING COMMENT 'Human‑readable name of the EMV tag (e.g., Amount, Authorised (Numeric)).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tag record.',
    `version_number` STRING COMMENT 'Version of the tag definition for change management.',
    CONSTRAINT pk_emv_tag PRIMARY KEY(`emv_tag_id`)
) COMMENT 'EMV tag reference catalog defining all standardized EMV data elements used in chip card transaction processing per EMVCo specifications. Stores EMV tag identifier (hex), tag name, tag description, data format, length (min/max), source (card, terminal, issuer), kernel applicability (contact, contactless, NFC), and ISO 7816 reference. Used by the authorization engine and terminal management system for EMV transaction parsing and cryptogram validation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` (
    `kyc_document_type_id` BIGINT COMMENT 'Surrogate key for KYC document type. _canonical_skip_reason: Role inferred as REFERENCE_LOOKUP; minimum categories not applicable.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Linking KYC document type to regulatory jurisdiction for KYC compliance rules; regulatory_basis string becomes redundant.',
    `accepted_jurisdictions` STRING COMMENT 'Comma‑separated list of ISO‑3166‑1 alpha‑2 country codes where the document type is accepted. [ENUM-REF-CANDIDATE: US|CA|GB|AU|DE|FR|JP|CN|IN|BR|... — promote to reference product]',
    `applicable_processes` STRING COMMENT 'Comma‑separated list of business processes where this document type is used.. Valid values are `merchant_onboarding|cardholder_kyc|partner_kyb|risk_assessment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document type record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Reference to the internal policy governing how long the document is stored and when it is archived or destroyed.',
    `document_format` STRING COMMENT 'Allowed file format for the uploaded document.. Valid values are `PDF|JPEG|PNG|XML`',
    `document_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the KYC document type (e.g., PASSPORT, DRIVER_LICENSE).',
    `document_type_name` STRING COMMENT 'Human‑readable name of the KYC document type.',
    `effective_from` DATE COMMENT 'Date from which the document type becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the document type is no longer valid (nullable for open‑ended).',
    `expiry_required_flag` BOOLEAN COMMENT 'Indicates whether the document type requires expiry date tracking for compliance.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the document type is currently active and usable in onboarding workflows.',
    `is_mandatory` BOOLEAN COMMENT 'True if this document type is mandatory for the associated onboarding process.',
    `issuing_authority` STRING COMMENT 'Name of the government or agency that issues the document (e.g., DMV, Passport Office).',
    `kyc_document_type_category` STRING COMMENT 'Broad classification of the document type for KYC processes.. Valid values are `government_id|proof_of_address|business_registration|beneficial_ownership|financial_statement`',
    `kyc_document_type_description` STRING COMMENT 'Detailed description of the document type, its purpose and typical usage.',
    `max_file_size_mb` STRING COMMENT 'Maximum permissible file size for the document upload, expressed in megabytes.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or special handling instructions.',
    `requires_manual_review` BOOLEAN COMMENT 'True if submissions of this document type must be manually verified by compliance staff.',
    `requires_ocr` BOOLEAN COMMENT 'True if optical character recognition is required to extract data from the document.',
    `retention_period_days` STRING COMMENT 'Number of days the document must be retained to satisfy regulatory requirements.',
    `source_system` STRING COMMENT 'Name of the operational system of record that originated the document type definition.',
    `supporting_documents_required` BOOLEAN COMMENT 'Indicates whether additional supporting documents must accompany this document type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document type record.',
    `version_number` STRING COMMENT 'Version of the document type definition, incremented on changes to attributes or rules.',
    CONSTRAINT pk_kyc_document_type PRIMARY KEY(`kyc_document_type_id`)
) COMMENT 'KYC (Know Your Customer) and KYB (Know Your Business) document type reference catalog defining all accepted identity and business verification document types. Stores document type code, document name, document category (government ID, proof of address, business registration, beneficial ownership, financial statement), accepted jurisdictions, expiry tracking required flag, and regulatory basis (BSA, AML, PSD2 SCA). Used by merchant onboarding, cardholder KYC, and compliance verification workflows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`pci_control` (
    `pci_control_id` BIGINT COMMENT 'Unique surrogate key for each PCI DSS control record.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Linking PCI control to regulatory jurisdiction for audit scope; regulatory_jurisdiction string becomes redundant.',
    `applicability_scope` STRING COMMENT 'Indicates whether the control applies to merchants, service providers, or both.. Valid values are `merchant|service_provider|both`',
    `compliance_owner` STRING COMMENT 'Name of the individual or team responsible for the control.',
    `compliance_owner_role` STRING COMMENT 'Functional role of the compliance owner.. Valid values are `security|audit|risk|operations`',
    `control_assessment_method` STRING COMMENT 'Method used to assess compliance with the control.. Valid values are `self_assessment|external_audit|automated_scan`',
    `control_category` STRING COMMENT 'High‑level classification of the control.. Valid values are `network_security|access_control|encryption|monitoring|policy|vulnerability_management`',
    `control_comments` STRING COMMENT 'Free‑form notes or observations about the control.',
    `control_documentation_url` STRING COMMENT 'Link to detailed documentation or policy for the control.',
    `control_frequency` STRING COMMENT 'How often the control must be performed.. Valid values are `continuous|daily|weekly|monthly|quarterly|annually`',
    `control_is_applicable_to_application` BOOLEAN COMMENT 'True if the control applies to application layer components.',
    `control_is_applicable_to_cardholder_data` BOOLEAN COMMENT 'True if the control applies to cardholder data environments.',
    `control_is_applicable_to_network` BOOLEAN COMMENT 'True if the control applies to network infrastructure.',
    `control_is_applicable_to_physical` BOOLEAN COMMENT 'True if the control applies to physical security.',
    `control_is_applicable_to_process` BOOLEAN COMMENT 'True if the control applies to business processes.',
    `control_is_mandatory` BOOLEAN COMMENT 'Indicates whether the control is mandatory under PCI DSS.',
    `control_is_tested` BOOLEAN COMMENT 'Indicates whether the control has been tested in the current assessment cycle.',
    `control_last_assessed_date` DATE COMMENT 'Date of the most recent assessment.',
    `control_mechanism` STRING COMMENT 'Technical or procedural mechanism used to satisfy the control.',
    `control_next_assessment_due` DATE COMMENT 'Planned date for the next assessment.',
    `control_number` STRING COMMENT 'Standardized control identifier as defined by PCI DSS (e.g., 12.3.1).. Valid values are `^d+(.d+)*$`',
    `control_reference_standard` STRING COMMENT 'External standard(s) that the control aligns with.. Valid values are `PCI DSS|ISO 27001|NIST SP 800-53`',
    `control_remediation_action` STRING COMMENT 'Planned or executed remediation steps for any identified gaps.',
    `control_revision_number` STRING COMMENT 'Sequential revision number for change tracking.',
    `control_risk_rating` STRING COMMENT 'Risk rating assigned to the control based on impact and likelihood.. Valid values are `low|medium|high|critical`',
    `control_status` STRING COMMENT 'Current lifecycle status of the control.. Valid values are `active|deprecated|planned`',
    `control_test_result` STRING COMMENT 'Outcome of the most recent test.. Valid values are `pass|fail|not_applicable|partial`',
    `control_tested_by` STRING COMMENT 'Name or role of the individual/team that performed the test.',
    `control_tested_timestamp` TIMESTAMP COMMENT 'Timestamp when the control test was performed.',
    `control_title` STRING COMMENT 'Brief title summarizing the control purpose.',
    `control_type` STRING COMMENT 'Nature of the control in the security lifecycle.. Valid values are `preventive|detective|corrective`',
    `control_version` STRING COMMENT 'Version identifier for the control definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was first created.',
    `effective_from` DATE COMMENT 'Date when the control became effective.',
    `effective_until` DATE COMMENT 'Date when the control is no longer effective (null if indefinite).',
    `nist_csf_category` STRING COMMENT 'Corresponding NIST Cybersecurity Framework category.. Valid values are `identify|protect|detect|respond|recover`',
    `nist_csf_subcategory` STRING COMMENT 'Specific NIST CSF subcategory mapping.',
    `pci_version` STRING COMMENT 'Version of the PCI DSS standard that defines the control.. Valid values are `3.2.1|4.0`',
    `requirement_description` STRING COMMENT 'Full text of the PCI DSS requirement.',
    `requirement_number` STRING COMMENT 'Number of the PCI DSS requirement to which the control maps.',
    `saq_type` STRING COMMENT 'Applicable SAQ type for the control. [ENUM-REF-CANDIDATE: SAQ A|SAQ A-EP|SAQ B|SAQ B-IP|SAQ C|SAQ C-VT|SAQ D — promote to reference product]',
    `testing_procedure` STRING COMMENT 'Step‑by‑step method for testing compliance with the control.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    CONSTRAINT pk_pci_control PRIMARY KEY(`pci_control_id`)
) COMMENT 'PCI DSS control reference catalog defining all PCI DSS requirements, sub-requirements, and testing procedures applicable to the payments platform. Stores PCI DSS version, requirement number, requirement description, control category (network security, access control, encryption, monitoring, policy), applicability scope (SAQ type, merchant level, service provider), and NIST CSF mapping. Used by compliance management, audit, and security assessment workflows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` (
    `ofac_sanctions_list_id` BIGINT COMMENT 'Unique surrogate key for each sanctions list entry.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Linking OFAC sanctions list to country for jurisdictional compliance; country_code becomes redundant.',
    `address` STRING COMMENT 'Physical address associated with the entity, if available.',
    `aliases` STRING COMMENT 'Other names or spellings the entity is known by, delimited by semicolon.',
    `birth_date` DATE COMMENT 'Birth date of the individual, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `effective_date` DATE COMMENT 'Date when the sanction entry became effective.',
    `entity_type` STRING COMMENT 'Category of the sanctioned party.. Valid values are `individual|organization|vessel|aircraft|entity`',
    `is_narcotics_designation` BOOLEAN COMMENT 'Indicates if the entity is designated for narcotics trafficking.',
    `is_proliferation_designation` BOOLEAN COMMENT 'Indicates if the entity is designated for weapons proliferation.',
    `is_special_designation` BOOLEAN COMMENT 'Indicates if the entity has a special designation (e.g., OFAC Specially Designated Nationals).',
    `is_terrorist_designation` BOOLEAN COMMENT 'Indicates if the entity is designated as a terrorist under OFAC regulations.',
    `is_wmd_designation` BOOLEAN COMMENT 'Indicates if the entity is designated for weapons of mass destruction.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the entry was last reviewed for accuracy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `list_type` STRING COMMENT 'Specific list category the entry belongs to.. Valid values are `SDN|Consolidated|EU|UN|Non-SDN|Other`',
    `national_id_number` STRING COMMENT 'Government-issued ID number for the individual, if available.',
    `ofac_sanctions_list_name` STRING COMMENT 'Legal name of the sanctioned individual or organization.',
    `ofac_sanctions_list_status` STRING COMMENT 'Current status of the sanctions entry.. Valid values are `active|removed|pending`',
    `passport_number` STRING COMMENT 'Passport number of the individual, if available.',
    `primary_contact` STRING COMMENT 'Primary method used to contact the sanctioned entity, if known.. Valid values are `email|phone|address|none`',
    `program` STRING COMMENT 'OFAC sanctions program under which the entity is listed.. Valid values are `IRAN|RUSSIA|DPRK|CUBA|VIOLATORS|OTHER`',
    `remarks` STRING COMMENT 'Free-text field for any additional notes or comments about the entry.',
    `removal_date` DATE COMMENT 'Date when the entity was removed from the sanctions list, if applicable.',
    `source_system` STRING COMMENT 'System that supplied the sanctions data (e.g., OFAC feed, internal compliance system).',
    `source_url` STRING COMMENT 'URL to the official OFAC source document for this entry.',
    CONSTRAINT pk_ofac_sanctions_list PRIMARY KEY(`ofac_sanctions_list_id`)
) COMMENT 'OFAC Specially Designated Nationals (SDN) and sanctions list reference master capturing all sanctioned individuals, entities, and countries published by the Office of Foreign Assets Control. Stores SDN entry ID, entity name, entity type (individual, organization, vessel, aircraft), aliases, country, program (IRAN, RUSSIA, DPRK, etc.), list type (SDN, OFAC Consolidated, EU, UN), effective date, and removal date. Used by real-time sanctions screening in transaction processing and merchant onboarding.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` (
    `aml_risk_country_id` BIGINT COMMENT 'Unique surrogate key for each AML risk country record.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Adds a foreign key from aml_risk_country to country, enabling proper country lookup and eliminating the need for separate country_code string column.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Adds a foreign key from aml_risk_country to regulatory_jurisdiction, replacing the redundant string column and establishing proper jurisdiction linkage.',
    `aml_risk_country_status` STRING COMMENT 'Lifecycle status indicating whether the record is currently used in risk decisions.. Valid values are `active|inactive|deprecated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was first inserted into the reference table.',
    `effective_date` DATE COMMENT 'Date from which the risk classification becomes effective.',
    `enhanced_dd_required_flag` BOOLEAN COMMENT 'True when enhanced due‑diligence procedures must be applied for customers from this jurisdiction.',
    `eu_high_risk_third_country_flag` BOOLEAN COMMENT 'True if the country is considered a high‑risk third country under EU regulations.',
    `expiration_date` DATE COMMENT 'Date on which the risk classification ceases to be effective (null if open‑ended).',
    `fatf_status` STRING COMMENT 'FATF classification of the jurisdiction (blacklist, greylist, compliant).. Valid values are `blacklist|greylist|compliant`',
    `fincen_advisory_flag` BOOLEAN COMMENT 'Indicates whether FinCEN has issued a specific advisory for the country.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was last reviewed or updated by risk analysts.',
    `notes` STRING COMMENT 'Additional commentary or observations about the countrys risk profile.',
    `risk_tier` STRING COMMENT 'Overall AML risk tier assigned to the country (high, medium, low).. Valid values are `high|medium|low`',
    `source_system` STRING COMMENT 'Name of the upstream system or feed that provided the risk information.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    `version_number` STRING COMMENT 'Incremental version of the record for audit and change tracking.',
    CONSTRAINT pk_aml_risk_country PRIMARY KEY(`aml_risk_country_id`)
) COMMENT 'AML/CTF high-risk country and jurisdiction reference list maintained per FATF mutual evaluation outcomes, FinCEN advisories, and internal risk policy. Stores country code, risk tier (high, medium, low), FATF status (blacklist, greylist, compliant), FinCEN advisory flag, EU high-risk third country flag, enhanced due diligence required flag, and effective date. Used by AML screening, transaction monitoring, and merchant risk underwriting to apply jurisdiction-based risk controls.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` (
    `iso_message_field_id` BIGINT COMMENT 'Unique surrogate identifier for each ISO message field record.',
    `iso_message_type_id` BIGINT COMMENT 'Foreign key linking to reference.iso_message_type. Business justification: iso_message_field belongs to a single iso_message_type; adding iso_message_type_id normalises the relationship and removes the redundant string list.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Linking ISO message field to regulatory jurisdiction for compliance mapping; regulatory_jurisdiction string becomes redundant.',
    `compliance_status` STRING COMMENT 'Compliance assessment of the field with applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the field record was created in the reference catalog.',
    `data_classification` STRING COMMENT 'Data classification level for the fields content.. Valid values are `restricted|confidential|internal|public`',
    `data_type` STRING COMMENT 'Technical data type of the field value.. Valid values are `numeric|alphanumeric|binary|date|time|datetime`',
    `effective_from` DATE COMMENT 'Date from which this field definition is valid.',
    `effective_until` DATE COMMENT 'Date after which this field definition is no longer valid (null if indefinite).',
    `field_category` STRING COMMENT 'High‑level category of the fields business purpose.. Valid values are `transaction|security|routing|settlement|risk|metadata`',
    `field_description` STRING COMMENT 'Detailed description of the fields purpose and usage.',
    `field_name` STRING COMMENT 'Human‑readable name of the message field.',
    `field_number` STRING COMMENT 'Position or tag identifier of the field within the message standard.',
    `format` STRING COMMENT 'Representation format of the field value.. Valid values are `numeric|alphanumeric|binary`',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the field is deprecated and should not be used for new messages.',
    `iso_message_field_status` STRING COMMENT 'Current lifecycle status of the field definition.. Valid values are `active|inactive|deprecated`',
    `length` STRING COMMENT 'Allowed length or length range of the field value.. Valid values are `^d+(-d+)?$`',
    `mandatory_indicator` STRING COMMENT 'Indicates whether the field is mandatory (Y) or optional (N) for the given message type.. Valid values are `Y|N`',
    `message_standard` STRING COMMENT 'Standard defining the message format for the field.. Valid values are `ISO8583|ISO20022`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the field.',
    `source_system` STRING COMMENT 'System of origin where the field definition was sourced (e.g., Payment Gateway, Transaction Processor).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the field record.',
    `version` STRING COMMENT 'Version of the message standard or field definition.',
    `version_number` STRING COMMENT 'Sequential version number for change tracking.',
    CONSTRAINT pk_iso_message_field PRIMARY KEY(`iso_message_field_id`)
) COMMENT 'ISO 8583 and ISO 20022 financial message field reference catalog defining all standard data elements, field positions, and format specifications for payment messaging. Stores message standard (ISO 8583, ISO 20022), field number/tag, field name, field description, data type, length, format (numeric, alphanumeric, binary), mandatory/optional indicator, and applicable message types (authorization, clearing, reversal). Used by the payment gateway and transaction processing platform for message parsing and validation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` (
    `settlement_cycle_id` BIGINT COMMENT 'System-generated unique identifier for each settlement cycle configuration.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Linking settlement cycle to card scheme for scheme‑specific settlement rules; card_scheme string becomes redundant.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Linking settlement cycle to currency for currency‑specific settlement processing; currency_code string becomes redundant.',
    `payment_rail_id` BIGINT COMMENT 'Foreign key linking to reference.payment_rail. Business justification: Linking settlement cycle to payment rail for settlement timing; payment_rail string becomes redundant.',
    `applicable_country_codes` STRING COMMENT 'Comma‑separated list of ISO‑3166‑1 alpha‑3 country codes where the cycle is valid.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement cycle record was first created in the system.',
    `cutoff_time` TIMESTAMP COMMENT 'Local time of day when the cut‑off for the settlement batch occurs.',
    `cutoff_timezone` STRING COMMENT 'IANA timezone identifier for the cut‑off time (e.g., "America/New_York").. Valid values are `^[A-Za-z_]+/[A-Za-z_]+$`',
    `cycle_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the settlement cycle within the reference domain.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `cycle_name` STRING COMMENT 'Human‑readable name describing the settlement cycle (e.g., "T+1 US Card Settlement").',
    `effective_from` DATE COMMENT 'Date when the settlement cycle becomes active.',
    `effective_until` DATE COMMENT 'Date when the settlement cycle expires or is superseded (null if open‑ended).',
    `funding_lag_days` STRING COMMENT 'Number of days between settlement execution and merchant funding.',
    `is_default_cycle` BOOLEAN COMMENT 'Indicates whether this cycle is the default for its payment rail and card scheme.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement cycle configuration was last reviewed for compliance or operational relevance.',
    `notes` STRING COMMENT 'Additional free‑form notes for operational or compliance teams.',
    `processing_fee_percent` DECIMAL(18,2) COMMENT 'Standard processing fee expressed as a percentage of the settled amount for this cycle.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory domain (e.g., PCI DSS, PSD2, AML) governing the settlement cycle.',
    `settlement_cycle_description` STRING COMMENT 'Free‑form description providing additional context or business rules.',
    `settlement_cycle_status` STRING COMMENT 'Current lifecycle status of the settlement cycle configuration.. Valid values are `active|inactive|deprecated|pending`',
    `settlement_frequency` STRING COMMENT 'How often settlements are executed for the cycle (e.g., real‑time, daily, T+1).. Valid values are `real_time|daily|t+1|t+2|t+3|weekly`',
    `settlement_window_end` STRING COMMENT 'End time (HH:mm) of the daily settlement processing window.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `settlement_window_start` STRING COMMENT 'Start time (HH:mm) of the daily settlement processing window.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement cycle record.',
    `version_number` STRING COMMENT 'Incremental version of the settlement cycle definition for change management.',
    CONSTRAINT pk_settlement_cycle PRIMARY KEY(`settlement_cycle_id`)
) COMMENT 'Settlement cycle reference configuration defining the settlement timing, cutoff schedules, and funding windows for each payment rail, card scheme, and geographic region. Stores cycle code, cycle name, payment rail, card scheme, settlement frequency (daily, T+1, T+2, T+3, real-time), cutoff time, cutoff timezone, funding lag (days), applicable country codes, and effective date range. Used by the settlement engine to determine batch generation schedules and merchant funding timelines.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`network_error_code` (
    `network_error_code_id` BIGINT COMMENT 'Unique surrogate key for network error code. _canonical_skip_reason: Entity serves as reference lookup for error codes, no mandatory categories required.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Linking network error code to regulatory jurisdiction for compliance reporting; regulatory_jurisdiction string becomes redundant.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the error code with relevant regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the error code record was first created.',
    `effective_from` DATE COMMENT 'Date when the error code becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the error code is no longer valid.',
    `error_category` STRING COMMENT 'High‑level classification of the error type for reporting and handling.. Valid values are `connectivity|timeout|format|authentication|business_rule|system_error`',
    `error_source` STRING COMMENT 'Originating component that generated the error, such as gateway, network, scheme, acquirer, or issuer.. Valid values are `gateway|network|scheme|acquirer|issuer`',
    `escalation_required` BOOLEAN COMMENT 'Indicates if the error requires manual investigation or escalation to support.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the error code has been superseded and should no longer be used.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent governance review of the error code.',
    `network_error_code_code` STRING COMMENT 'Alphanumeric identifier assigned to the network error (e.g., ERR001).',
    `network_error_code_description` STRING COMMENT 'Human‑readable explanation of the error condition and its typical cause.',
    `network_error_code_status` STRING COMMENT 'Current lifecycle status of the error code entry.. Valid values are `active|inactive|deprecated`',
    `notes` STRING COMMENT 'Free‑form field for additional context, remediation steps, or operational comments.',
    `retry_recommended` BOOLEAN COMMENT 'Indicates whether the transaction should be automatically retried after this error.',
    `severity_level` STRING COMMENT 'Business impact rating of the error, used for prioritization.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Name of the operational system that originated the error code (e.g., Payment Gateway, Authorization Engine).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the error code record.',
    `version_number` STRING COMMENT 'Version identifier for the error code definition, incremented on changes.',
    CONSTRAINT pk_network_error_code PRIMARY KEY(`network_error_code_id`)
) COMMENT 'Payment network and gateway error code reference catalog defining all technical and business error codes returned during transaction processing, network connectivity failures, and message validation rejections. Stores error code, error source (gateway, network, scheme, acquirer, issuer), error category (connectivity, timeout, format, authentication, business rule), error description, retry recommended flag, and escalation required flag. Used by the payment gateway and authorization engine for error handling and SLA monitoring.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`qr_code` (
    `qr_code_id` BIGINT COMMENT 'System-generated unique identifier for each QR code record.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with a static QR code.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount encoded in a dynamic QR code for a specific transaction.',
    `channel` STRING COMMENT 'Channel or ecosystem through which the QR code is intended to be used.. Valid values are `upi|proprietary|other`',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the QR code (e.g., PCI DSS, PSD2).. Valid values are `compliant|non_compliant|pending`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the amount.. Valid values are `^[A-Z]{3}$`',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the QR code becomes invalid.',
    `generation_timestamp` TIMESTAMP COMMENT 'Date‑time when the QR code was created in the system.',
    `is_test_code` BOOLEAN COMMENT 'Indicates whether the QR code is generated for testing purposes.',
    `last_scanned_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent scan of the QR code.',
    `payload` STRING COMMENT 'Encoded data that the QR code carries (e.g., payment reference, UPI VPA, merchant ID).',
    `qr_code_status` STRING COMMENT 'Current lifecycle status of the QR code.. Valid values are `active|expired|used|revoked`',
    `qr_code_type` STRING COMMENT 'Indicates whether the QR code is static (merchant), dynamic (transaction), or peer‑to‑peer.. Valid values are `static|dynamic|p2p`',
    `qr_version` STRING COMMENT 'Version identifier of the QR code format or specification used.',
    `scan_count` BIGINT COMMENT 'Number of times the QR code has been scanned.',
    `scheme` STRING COMMENT 'Name of the wallet or payment scheme that generated the QR code (e.g., UPI, proprietary).',
    `usage_limit` BIGINT COMMENT 'Maximum number of allowed scans before the QR code is automatically deactivated.',
    CONSTRAINT pk_qr_code PRIMARY KEY(`qr_code_id`)
) COMMENT 'QR code payment artifact record — static or dynamic QR codes generated for merchant acceptance or P2P payment initiation. Captures QR code ID, QR type (static merchant, dynamic transaction, P2P), QR payload (encoded reference), wallet scheme, merchant reference, amount (for dynamic), currency, expiry timestamp, scan count, status (active, expired, used), and generation timestamp. Supports QR-based payment flows including UPI and proprietary schemes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` (
    `wallet_scheme_id` BIGINT COMMENT 'Unique system-generated identifier for each digital wallet scheme record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Scheme settlement currency aligns with reference.currency to enforce settlement rules and fee calculations.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Scheme supports specific transaction types; linking to reference.transaction_type enables validation and fee logic.',
    `certification_status` STRING COMMENT 'Result of the schemes compliance certification process.. Valid values are `certified|pending|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scheme record was first created.',
    `cross_border_supported` BOOLEAN COMMENT 'Indicates whether the scheme can be used for cross‑border transactions.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code representing the primary currency used for fees and limits.',
    `dcc_supported` BOOLEAN COMMENT 'Indicates whether Dynamic Currency Conversion is available for the scheme.',
    `dispute_resolution_policy` STRING COMMENT 'Policy governing how disputes are settled for this scheme.. Valid values are `merchant_favor|issuer_favor|neutral`',
    `effective_from` DATE COMMENT 'Date on which the scheme becomes effective for use.',
    `effective_until` DATE COMMENT 'Date on which the scheme ceases to be effective (null if open‑ended).',
    `geographic_coverage` STRING COMMENT 'Comma‑separated list of ISO‑3 country codes where the scheme is available.',
    `go_live_date` DATE COMMENT 'Calendar date when the scheme was first made available to customers.',
    `interchange_fee_model` STRING COMMENT 'Model used to calculate interchange fees for the scheme.. Valid values are `flat|percentage|tiered`',
    `interchange_fee_rate` DECIMAL(18,2) COMMENT 'Base interchange fee rate expressed as a percentage (e.g., 0.1500 = 0.15%).',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the schemes parameters.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount allowed per transaction under this scheme.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum monetary amount required per transaction under this scheme.',
    `pci_dss_compliant` BOOLEAN COMMENT 'True if the scheme meets PCI DSS requirements.',
    `psd2_compliant` BOOLEAN COMMENT 'True if the scheme complies with PSD2 strong customer authentication rules.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk rating (0‑100) assigned to the scheme based on security and compliance factors.',
    `scheme_agreement_reference` STRING COMMENT 'Identifier or document reference for the legal agreement governing the scheme.',
    `scheme_code` STRING COMMENT 'Short alphanumeric code used internally to reference the scheme.',
    `scheme_name` STRING COMMENT 'Human‑readable name of the wallet scheme (e.g., Apple Pay, Google Pay).',
    `scheme_type` STRING COMMENT 'Classification of the scheme: OEM wallet, proprietary, UPI, or QR based.. Valid values are `OEM|proprietary|UPI|QR`',
    `supported_nfc_kernels` STRING COMMENT 'List of NFC kernel versions supported by the scheme (e.g., NXP, STMicro).',
    `supported_provisioning_methods` STRING COMMENT 'Provisioning channels supported (online, offline, in‑app, API).',
    `supported_token_requestor_ids` STRING COMMENT 'Comma‑separated list of token requestor identifiers authorized for this scheme.',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether the scheme supports tokenization of payment credentials.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scheme record.',
    `version_number` STRING COMMENT 'Incremental version of the scheme definition.',
    `wallet_scheme_description` STRING COMMENT 'Free‑form description of the scheme, its purpose and key characteristics.',
    `wallet_scheme_status` STRING COMMENT 'Current lifecycle status of the scheme within the platform.. Valid values are `active|inactive|suspended|pending|retired`',
    CONSTRAINT pk_wallet_scheme PRIMARY KEY(`wallet_scheme_id`)
) COMMENT 'Reference master for supported digital wallet schemes and their operational parameters — Apple Pay, Google Pay, Samsung Pay, proprietary wallet brands, and UPI. Captures scheme ID, scheme name, scheme type (OEM wallet, proprietary, UPI, QR), supported token requestor IDs, supported NFC kernels, supported provisioning methods, scheme certification status, scheme agreement reference, and go-live date. Governs which wallet schemes are active on the platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` (
    `issuer_wallet_config_id` BIGINT COMMENT 'Unique surrogate key for each issuer wallet configuration record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Reference to the issuing financial institution that owns the BIN range.',
    `issuer_id` BIGINT COMMENT 'Reference to the issuing financial institution that owns the BIN range.',
    `wallet_scheme_id` BIGINT COMMENT 'Reference to the digital wallet scheme (e.g., Apple Pay, Google Pay) for which this configuration applies.',
    `allowed_card_schemes` STRING COMMENT 'Comma‑separated list of card scheme codes (e.g., VISA, MASTERCARD) that may be tokenized.',
    `allowed_countries` STRING COMMENT 'Comma‑separated list of three‑letter country codes where token usage is permitted.',
    `compliance_pci_dss_version` STRING COMMENT 'Version of the PCI DSS standard that this configuration complies with.',
    `compliance_psd2_version` STRING COMMENT 'Version of the PSD2 regulatory framework applicable to the configuration.',
    `config_name` STRING COMMENT 'Human‑readable name for the configuration used by operations and reporting.',
    `config_status` STRING COMMENT 'Current lifecycle status of the configuration.. Valid values are `active|inactive|pending|deprecated|suspended|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the configuration ceases to be effective; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the configuration becomes effective for the issuer.',
    `green_path_threshold` DECIMAL(18,2) COMMENT 'Risk score percentage below which transactions follow the green (low‑risk) path.',
    `is_cross_border_supported` BOOLEAN COMMENT 'Indicates whether cross‑border transactions are allowed for tokens issued under this configuration.',
    `is_dynamic_currency_conversion_supported` BOOLEAN COMMENT 'Indicates support for DCC in tokenized transactions.',
    `is_tokenization_supported` BOOLEAN COMMENT 'Indicates whether tokenization is enabled for this issuer under the configuration.',
    `issuer_wallet_config_description` STRING COMMENT 'Free‑form description of the configuration purpose and scope.',
    `last_updated_by` STRING COMMENT 'User or system identifier that performed the last update.',
    `max_tokens_per_fpan` STRING COMMENT 'Maximum number of active tokens that may be issued for a single primary account number.',
    `otp_delivery_method` STRING COMMENT 'Channel used to deliver the OTP for step‑up authentication.. Valid values are `sms|email|push_notification|voice_call`',
    `provisioning_rule_set` STRING COMMENT 'JSON or structured text describing the step‑by‑step provisioning flow for tokens.',
    `red_path_threshold` DECIMAL(18,2) COMMENT 'Risk score percentage above which transactions follow the red (high‑risk) path.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Maximum risk score allowed for automatic token issuance without manual review.',
    `step_up_auth_required` BOOLEAN COMMENT 'Indicates whether additional authentication is required during token provisioning.',
    `step_up_trigger_condition` STRING COMMENT 'Condition that triggers step‑up authentication.. Valid values are `amount_threshold|risk_score|geolocation|device_change`',
    `token_assurance_level` STRING COMMENT 'Assurance classification of tokens issued under this configuration.. Valid values are `low|medium|high|critical`',
    `token_expiry_days` STRING COMMENT 'Number of days after issuance that a token automatically expires if not used.',
    `token_expiry_policy` STRING COMMENT 'Policy governing token lifetime: rolling (renew on use), fixed (static date), or session‑based.. Valid values are `rolling|fixed|session`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration.',
    `yellow_path_threshold` DECIMAL(18,2) COMMENT 'Risk score percentage range for the yellow (moderate‑risk) path.',
    CONSTRAINT pk_issuer_wallet_config PRIMARY KEY(`issuer_wallet_config_id`)
) COMMENT 'Issuer-specific configuration governing how a card issuer participates in the wallet tokenization platform — provisioning rules, step-up authentication requirements, token assurance levels, and green/yellow/red path thresholds. Captures config ID, issuer BIN range, wallet scheme ID, provisioning path rules, step-up trigger conditions, OTP delivery method, maximum tokens per FPAN, token expiry policy, and last updated timestamp. Enables per-issuer customization of the tokenization flow.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`scheme_message` (
    `scheme_message_id` BIGINT COMMENT 'Unique identifier for the scheme message record.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment scheme (e.g., Visa, Mastercard, EMVCo) associated with the message.',
    `correlation_code` STRING COMMENT 'Identifier used to correlate this message with related processing flows or transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scheme message record was first created in the data lake.',
    `direction` STRING COMMENT 'Indicates whether the message was received from the scheme (inbound) or sent to the scheme (outbound).. Valid values are `inbound|outbound`',
    `error_code` STRING COMMENT 'Error identifier returned when processing fails, aligned with scheme-specific error taxonomy.',
    `message_timestamp` TIMESTAMP COMMENT 'Exact date and time when the scheme message was generated or received.',
    `message_type` STRING COMMENT 'Category of the scheme communication, such as provisioning response, token status update, lifecycle notification, or cryptogram validation.. Valid values are `provisioning_response|token_status_update|lifecycle_notification|cryptogram_validation`',
    `notes` STRING COMMENT 'Free‑form field for additional context, comments, or audit remarks related to the message.',
    `payload_hash` STRING COMMENT 'Cryptographic hash of the raw message payload for integrity verification.',
    `processing_status` STRING COMMENT 'Current processing state of the message within the wallet platform.. Valid values are `pending|processed|failed|retrying`',
    `raw_message_uri` STRING COMMENT 'Pointer (URI) to the encrypted raw message payload stored in secure storage.',
    `retry_count` STRING COMMENT 'Number of retry attempts performed for this message after a failure.',
    `source_system` STRING COMMENT 'Name of the originating system that produced the scheme message (e.g., Digital Wallet Platform).',
    `status_code` STRING COMMENT 'Standardized code representing the outcome or state of the message processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scheme message record.',
    CONSTRAINT pk_scheme_message PRIMARY KEY(`scheme_message_id`)
) COMMENT 'Network scheme messaging record for wallet-related scheme communications — EMVCo token lifecycle notifications, Visa VTS and Mastercard MDES API messages, provisioning responses, and token status updates received from or sent to card schemes. Captures message ID, scheme ID, message type (provisioning response, token status update, lifecycle notification, cryptogram validation), direction (inbound, outbound), message timestamp, processing status, retry count, and raw message reference (pointer to encrypted store). Supports scheme integration audit trail.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` (
    `iso_message_type_id` BIGINT COMMENT 'System-generated unique identifier for each ISO message type record.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Linking ISO message type to transaction type for message routing; transaction_type string becomes redundant.',
    `response_iso_message_type_id` BIGINT COMMENT 'Self-referencing FK on iso_message_type (response_iso_message_type_id)',
    `applicable_payment_rail` STRING COMMENT 'Payment rail(s) that can carry this message type (e.g., card, ACH, SWIFT, SEPA, RTP, P2P).. Valid values are `card|ach|swift|sepa|rtp|p2p`',
    `compliance_status` STRING COMMENT 'Indicates whether the message type meets all applicable regulatory and standards requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the message type record was first created in the catalog.',
    `direction` STRING COMMENT 'Indicates whether the message initiates a request, provides a response, or is a standalone notification.. Valid values are `request|response|notification`',
    `effective_from` DATE COMMENT 'Date on which the message type becomes valid for processing.',
    `effective_until` DATE COMMENT 'Date after which the message type must no longer be used (null if indefinite).',
    `example_message` STRING COMMENT 'A representative example of a fully populated message instance in XML/JSON format.',
    `fee_indicator` STRING COMMENT 'Indicates whether fees are always applied, never applied, or applied conditionally for this message type.. Valid values are `yes|no|conditional`',
    `field_count` STRING COMMENT 'Total count of data elements defined for this message type.',
    `is_batch` BOOLEAN COMMENT 'True if the message type is typically transmitted in batch files rather than real‑time.',
    `is_cross_border` BOOLEAN COMMENT 'True if the message type supports or is commonly used for cross‑border transactions.',
    `is_deprecated` BOOLEAN COMMENT 'True if the message type is retired or superseded by a newer definition.',
    `is_fee_applicable` BOOLEAN COMMENT 'True if the message type may incur processing fees or interchange charges.',
    `is_fraud_sensitive` BOOLEAN COMMENT 'True if transactions using this message type are subject to heightened fraud monitoring.',
    `is_real_time` BOOLEAN COMMENT 'True if the message type is used in real‑time processing flows.',
    `iso_message_type_description` STRING COMMENT 'Detailed textual description of the message purpose, structure, and usage.',
    `iso_message_type_status` STRING COMMENT 'Current lifecycle status of the message type within the organization.. Valid values are `active|inactive|retired`',
    `message_category` STRING COMMENT 'Broad category of the message (e.g., financial, status, reporting). [ENUM-REF-CANDIDATE: financial|status|reporting|reconciliation|settlement|risk|compliance — promote to reference product]',
    `message_name` STRING COMMENT 'Human‑readable name or title of the ISO message type.',
    `message_standard` STRING COMMENT 'The ISO family to which the message belongs: ISO 8583 (card‑based) or ISO 20022 (financial messaging).. Valid values are `ISO8583|ISO20022`',
    `message_type_code` STRING COMMENT 'Standard code that uniquely identifies the message type within ISO 20022 or ISO 8583 specifications.',
    `notes` STRING COMMENT 'Free‑form notes for internal commentary, version history, or special handling instructions.',
    `processing_code` STRING COMMENT 'ISO 8583 processing code that defines the transaction processing logic (e.g., "000000" for purchase).',
    `regulatory_jurisdiction` STRING COMMENT 'Code of the jurisdiction whose regulations apply to the use of this message type (e.g., "US", "EU").',
    `requires_authentication` BOOLEAN COMMENT 'True if processing this message type mandates a prior authentication step.',
    `schema_url` STRING COMMENT 'Link to the official schema definition (XSD, XSD, or JSON Schema) for the message type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the message type record.',
    `version` STRING COMMENT 'Version identifier of the message definition (e.g., "2021-09", "v2.1").',
    CONSTRAINT pk_iso_message_type PRIMARY KEY(`iso_message_type_id`)
) COMMENT 'ISO 20022 and ISO 8583 message type reference catalog defining all standard financial message types (pacs.008, pacs.002, pain.001, camt.053, etc.) used in payment processing, clearing, and settlement messaging.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`financial_institution` (
    `financial_institution_id` BIGINT COMMENT 'Primary key for financial_institution',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Replace string country_code with a proper foreign key to the country master for referential integrity and enable joins to country attributes.',
    `parent_institution_id` BIGINT COMMENT 'Identifier of the parent institution in hierarchical structures, if applicable.',
    `parent_financial_institution_id` BIGINT COMMENT 'Self-referencing FK on financial_institution (parent_financial_institution_id)',
    `address_line1` STRING COMMENT 'First line of the institutions street address.',
    `city` STRING COMMENT 'City of the institutions primary address.',
    `compliance_status` STRING COMMENT 'Current compliance standing with relevant regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the record was first created.',
    `data_classification_level` STRING COMMENT 'Classification indicating the sensitivity of the institutions data.',
    `financial_institution_description` STRING COMMENT 'Free‑form textual description of the financial institution.',
    `established_date` DATE COMMENT 'Date when the institution was legally established.',
    `institution_type` STRING COMMENT 'Category describing the kind of financial institution.',
    `is_fiat_supported` BOOLEAN COMMENT 'Indicates whether the institution supports fiat currency transactions.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `legal_name` STRING COMMENT 'Full legal registered name of the financial institution.',
    `financial_institution_name` STRING COMMENT 'Commonly used display name of the financial institution.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the institutions address.',
    `primary_contact_email` STRING COMMENT 'Main email address for contacting the institution.',
    `primary_contact_phone` STRING COMMENT 'Main telephone number for the institution.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory regime governing the institution.',
    `risk_rating` STRING COMMENT 'Internal risk rating assigned to the institution.',
    `routing_number` STRING COMMENT 'Domestic routing number (e.g., ABA) for the institution.',
    `financial_institution_status` STRING COMMENT 'Current lifecycle status of the institution.',
    `supported_currencies` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes the institution supports.',
    `swift_code` STRING COMMENT 'International bank identifier code for the institution.',
    `tax_id_number` STRING COMMENT 'Government‑issued tax identifier for the institution.',
    `termination_date` DATE COMMENT 'Date when the institution ceased operations, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the record.',
    `website_url` STRING COMMENT 'Public website address of the financial institution.',
    CONSTRAINT pk_financial_institution PRIMARY KEY(`financial_institution_id`)
) COMMENT 'Master reference table for financial_institution. Referenced by issuing_bank_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`reference`.`issuer` (
    `issuer_id` BIGINT COMMENT 'Primary key for issuer',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Add country reference to issuer to link issuer to its jurisdictional country, replacing the free‑text country_code.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Add currency reference to issuer to link issuer to its base currency, replacing the free‑text currency_code.',
    `parent_issuer_id` BIGINT COMMENT 'Self-referencing FK on issuer (parent_issuer_id)',
    `abbreviation` STRING COMMENT 'Standard abbreviation or ticker symbol for the issuer.',
    `address_line1` STRING COMMENT 'First line of the issuers primary business address.',
    `address_line2` STRING COMMENT 'Second line of the issuers primary business address (optional).',
    `city` STRING COMMENT 'City of the issuers primary business location.',
    `classification` STRING COMMENT 'Business classification based on market reach.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the issuer with regulatory requirements.',
    `contact_email` STRING COMMENT 'Primary email address for issuer communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the issuer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the issuer record was first created.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by rating agencies.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Aggregate daily transaction amount limit for the issuer.',
    `issuer_description` STRING COMMENT 'Free‑form description of the issuers business and services.',
    `effective_from` DATE COMMENT 'Date when the issuer became effective for processing.',
    `effective_until` DATE COMMENT 'Date when the issuer ceased to be effective (null if still active).',
    `is_preferred` BOOLEAN COMMENT 'Indicates whether this issuer is preferred for routing decisions.',
    `is_test_issuer` BOOLEAN COMMENT 'True if the issuer is used for testing environments only.',
    `is_virtual` BOOLEAN COMMENT 'True if the issuer represents a virtual or tokenized entity.',
    `issuer_code` STRING COMMENT 'ISO 9362 Business Identifier Code uniquely identifying the issuer.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum single transaction amount the issuer permits.',
    `issuer_name` STRING COMMENT 'Full legal name of the issuing institution.',
    `notes` STRING COMMENT 'Additional internal notes or remarks about the issuer.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the issuers primary address.',
    `processing_mode` STRING COMMENT 'Mode of transaction processing (e.g., real‑time, batch).',
    `registration_number` STRING COMMENT 'Official registration identifier assigned by the jurisdiction of incorporation.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory authority governing the issuer (e.g., FCA, OCC).',
    `risk_rating` STRING COMMENT 'Internal risk assessment rating for the issuer.',
    `settlement_currency` STRING COMMENT 'Currency used for settlement of transactions with this issuer.',
    `settlement_cycle` STRING COMMENT 'Frequency of settlement processing (e.g., T+1, T+2).',
    `settlement_method` STRING COMMENT 'Method used for settlement (e.g., ACH, SWIFT).',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the issuer.',
    `state_province` STRING COMMENT 'State or province of the issuers primary address.',
    `issuer_status` STRING COMMENT 'Current operational status of the issuer.',
    `supported_card_schemes` STRING COMMENT 'Comma‑separated list of card schemes the issuer supports (e.g., Visa,MasterCard,Amex). [ENUM-REF-CANDIDATE: Visa|MasterCard|Amex|Discover|JCB|UnionPay — promote to reference product]',
    `supported_payment_methods` STRING COMMENT 'Comma‑separated list of payment methods (e.g., credit,debit,prepaid). [ENUM-REF-CANDIDATE: credit|debit|prepaid|digital_wallet|contactless — promote to reference product]',
    `tax_identifier` STRING COMMENT 'Tax identification number for the issuer (e.g., EIN, VAT).',
    `timezone` STRING COMMENT 'IANA timezone identifier for the issuers headquarters (e.g., America/New_York).',
    `issuer_type` STRING COMMENT 'Category of the issuing organization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the issuer record.',
    `website_url` STRING COMMENT 'Public website address of the issuer.',
    CONSTRAINT pk_issuer PRIMARY KEY(`issuer_id`)
) COMMENT 'Master reference table for issuer. Referenced by issuer_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ADD CONSTRAINT `fk_reference_country_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `payments_fintech_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ADD CONSTRAINT `fk_reference_country_timezone_id` FOREIGN KEY (`timezone_id`) REFERENCES `payments_fintech_ecm`.`reference`.`timezone`(`timezone_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ADD CONSTRAINT `fk_reference_mcc_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ADD CONSTRAINT `fk_reference_bin_range_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ADD CONSTRAINT `fk_reference_bin_range_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ADD CONSTRAINT `fk_reference_bin_range_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ADD CONSTRAINT `fk_reference_bin_range_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ADD CONSTRAINT `fk_reference_authorization_response_code_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ADD CONSTRAINT `fk_reference_decline_code_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ADD CONSTRAINT `fk_reference_holiday_calendar_payment_rail_id` FOREIGN KEY (`payment_rail_id`) REFERENCES `payments_fintech_ecm`.`reference`.`payment_rail`(`payment_rail_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ADD CONSTRAINT `fk_reference_card_scheme_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ADD CONSTRAINT `fk_reference_regulatory_jurisdiction_jurisdiction_parent_regulatory_jurisdiction_id` FOREIGN KEY (`jurisdiction_parent_regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ADD CONSTRAINT `fk_reference_chargeback_reason_code_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ADD CONSTRAINT `fk_reference_fx_rate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ADD CONSTRAINT `fk_reference_swift_bic_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ADD CONSTRAINT `fk_reference_iban_structure_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ADD CONSTRAINT `fk_reference_iban_structure_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ADD CONSTRAINT `fk_reference_nacha_return_code_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ADD CONSTRAINT `fk_reference_emv_tag_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ADD CONSTRAINT `fk_reference_kyc_document_type_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ADD CONSTRAINT `fk_reference_pci_control_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ADD CONSTRAINT `fk_reference_ofac_sanctions_list_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ADD CONSTRAINT `fk_reference_aml_risk_country_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ADD CONSTRAINT `fk_reference_aml_risk_country_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ADD CONSTRAINT `fk_reference_iso_message_field_iso_message_type_id` FOREIGN KEY (`iso_message_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`iso_message_type`(`iso_message_type_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ADD CONSTRAINT `fk_reference_iso_message_field_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ADD CONSTRAINT `fk_reference_settlement_cycle_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ADD CONSTRAINT `fk_reference_settlement_cycle_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ADD CONSTRAINT `fk_reference_settlement_cycle_payment_rail_id` FOREIGN KEY (`payment_rail_id`) REFERENCES `payments_fintech_ecm`.`reference`.`payment_rail`(`payment_rail_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ADD CONSTRAINT `fk_reference_network_error_code_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ADD CONSTRAINT `fk_reference_wallet_scheme_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ADD CONSTRAINT `fk_reference_wallet_scheme_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ADD CONSTRAINT `fk_reference_issuer_wallet_config_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `payments_fintech_ecm`.`reference`.`issuer`(`issuer_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ADD CONSTRAINT `fk_reference_issuer_wallet_config_wallet_scheme_id` FOREIGN KEY (`wallet_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`wallet_scheme`(`wallet_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ADD CONSTRAINT `fk_reference_iso_message_type_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ADD CONSTRAINT `fk_reference_iso_message_type_response_iso_message_type_id` FOREIGN KEY (`response_iso_message_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`iso_message_type`(`iso_message_type_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ADD CONSTRAINT `fk_reference_financial_institution_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ADD CONSTRAINT `fk_reference_financial_institution_parent_institution_id` FOREIGN KEY (`parent_institution_id`) REFERENCES `payments_fintech_ecm`.`reference`.`financial_institution`(`financial_institution_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ADD CONSTRAINT `fk_reference_financial_institution_parent_financial_institution_id` FOREIGN KEY (`parent_financial_institution_id`) REFERENCES `payments_fintech_ecm`.`reference`.`financial_institution`(`financial_institution_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ADD CONSTRAINT `fk_reference_issuer_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ADD CONSTRAINT `fk_reference_issuer_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ADD CONSTRAINT `fk_reference_issuer_parent_issuer_id` FOREIGN KEY (`parent_issuer_id`) REFERENCES `payments_fintech_ecm`.`reference`.`issuer`(`issuer_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`reference` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `payments_fintech_ecm`.`reference` SET TAGS ('dbx_domain' = 'reference');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` SET TAGS ('dbx_subdomain' = 'geographic_metadata');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Identifier (Country ID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Identifier (Holiday Calendar ID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `timezone_id` SET TAGS ('dbx_business_glossary_term' = 'Timezone Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `capital_city` SET TAGS ('dbx_business_glossary_term' = 'Capital City (Capital)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `country_name` SET TAGS ('dbx_business_glossary_term' = 'Country Name (CN)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `dialing_code` SET TAGS ('dbx_business_glossary_term' = 'International Dialing Code (Dialing Code)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `dialing_code` SET TAGS ('dbx_value_regex' = '^+d{1,4}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (Effective From)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (Effective Until)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `fatf_high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'FATF High‑Risk Jurisdiction Flag (FATF Flag)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_amex_supported` SET TAGS ('dbx_business_glossary_term' = 'American Express Network Support Flag (Amex Supported)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_eu_member` SET TAGS ('dbx_business_glossary_term' = 'EU Membership Flag (EU Member)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_g20_member` SET TAGS ('dbx_business_glossary_term' = 'G20 Membership Flag (G20 Member)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_g7_member` SET TAGS ('dbx_business_glossary_term' = 'G7 Membership Flag (G7 Member)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_mastercard_supported` SET TAGS ('dbx_business_glossary_term' = 'Mastercard Network Support Flag (Mastercard Supported)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_rtp_supported` SET TAGS ('dbx_business_glossary_term' = 'RTP Network Support Flag (RTP Supported)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_swift_supported` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Network Support Flag (SWIFT Supported)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_swift_supported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_swift_supported` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_un_member` SET TAGS ('dbx_business_glossary_term' = 'UN Membership Flag (UN Member)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_unionpay_supported` SET TAGS ('dbx_business_glossary_term' = 'UnionPay Network Support Flag (UnionPay Supported)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `is_visa_supported` SET TAGS ('dbx_business_glossary_term' = 'Visa Network Support Flag (Visa Supported)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha2_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-2 Country Code (ISO-Alpha2)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha2_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha3_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-3 Country Code (ISO-Alpha3)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha3_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_currency_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Currency Code (ISO‑Currency)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Numeric Country Code (ISO-Numeric)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_value_regex' = '^d{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `language_codes` SET TAGS ('dbx_business_glossary_term' = 'Official Language Codes (Languages)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Lat)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Long)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `ofac_sanctions_flag` SET TAGS ('dbx_business_glossary_term' = 'OFAC Sanctions Flag (OFAC Flag)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status (Status)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `psd2_applicability` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Applicability Flag (PSD2 Flag)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (Region)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'Africa|Americas|Asia|Europe|Oceania');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `sub_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Sub‑Region (Sub‑Region)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`country` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` SET TAGS ('dbx_subdomain' = 'geographic_metadata');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Associated Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 4217 Currency Code (ISO)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `currency_description` SET TAGS ('dbx_business_glossary_term' = 'Currency Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Currency Name (ISO)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'fiat|digital|commodity');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `exchange_rate_source` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Source');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Currency Active Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `is_crypto` SET TAGS ('dbx_business_glossary_term' = 'Is Cryptocurrency');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `is_fiat` SET TAGS ('dbx_business_glossary_term' = 'Is Fiat Currency');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `is_historic` SET TAGS ('dbx_business_glossary_term' = 'Is Historic Currency');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `iso_3166_numeric_country_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 3166 Numeric Country Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `iso_3166_numeric_country_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `minor_unit` SET TAGS ('dbx_business_glossary_term' = 'Minor Unit (Decimal Places)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `numeric_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 4217 Numeric Currency Code (ISO)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `symbol` SET TAGS ('dbx_business_glossary_term' = 'Currency Symbol');
ALTER TABLE `payments_fintech_ecm`.`reference`.`currency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `average_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `average_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `card_scheme_applicability` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Applicability');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `card_scheme_applicability` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `category_group` SET TAGS ('dbx_business_glossary_term' = 'Category Group');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'High‑Risk Category Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `interchange_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Interchange Eligibility');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `interchange_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|partial');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `match_list_indicator` SET TAGS ('dbx_business_glossary_term' = 'MATCH List Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `mcc_description` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `restricted_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Category Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'MCC Risk Score');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`mcc` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_range_id` SET TAGS ('dbx_business_glossary_term' = 'Reference BIN Range ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_end` SET TAGS ('dbx_business_glossary_term' = 'BIN End Prefix');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_length` SET TAGS ('dbx_business_glossary_term' = 'BIN Length');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_range_description` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_range_status` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_range_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Start Prefix');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `bin_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type (Product)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|virtual|fleet');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `interchange_fee_category` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `interchange_fee_category` SET TAGS ('dbx_value_regex' = 'low|mid|high|standard|premium');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_3ds_supported` SET TAGS ('dbx_business_glossary_term' = '3‑DS Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_commercial` SET TAGS ('dbx_business_glossary_term' = 'Commercial Card Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_dcc_supported` SET TAGS ('dbx_business_glossary_term' = 'DCC Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_mcc_specific` SET TAGS ('dbx_business_glossary_term' = 'MCC Specific Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_prepaid` SET TAGS ('dbx_business_glossary_term' = 'Prepaid Card Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_sca_exempt` SET TAGS ('dbx_business_glossary_term' = 'SCA Exemption Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Virtual Card Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `issuing_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`bin_range` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `authorization_response_code_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Response Code Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `authorization_response_code_category` SET TAGS ('dbx_business_glossary_term' = 'Response Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `authorization_response_code_category` SET TAGS ('dbx_value_regex' = 'approved|declined|referral|error');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `authorization_response_code_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `authorization_response_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `authorization_response_code_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `authorization_response_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `is_retriable` SET TAGS ('dbx_business_glossary_term' = 'Retriable Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `is_soft_decline` SET TAGS ('dbx_business_glossary_term' = 'Soft Decline Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `message` SET TAGS ('dbx_business_glossary_term' = 'Response Message');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `scheme_override_message` SET TAGS ('dbx_business_glossary_term' = 'Scheme Override Message');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`authorization_response_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `decline_code_id` SET TAGS ('dbx_business_glossary_term' = 'Decline Code Identifier (DCID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `cardholder_message` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Facing Message (CFM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `decline_code_category` SET TAGS ('dbx_business_glossary_term' = 'Decline Category (DCAT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `decline_code_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Code (DC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `decline_code_description` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Description (DRD)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `decline_code_status` SET TAGS ('dbx_business_glossary_term' = 'Decline Code Status (DCS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `decline_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Flag (DF)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `merchant_message` SET TAGS ('dbx_business_glossary_term' = 'Merchant Facing Message (MFM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `retry_eligible` SET TAGS ('dbx_business_glossary_term' = 'Retry Eligibility Flag (REF)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`decline_code` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` SET TAGS ('dbx_subdomain' = 'geographic_metadata');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `timezone_id` SET TAGS ('dbx_business_glossary_term' = 'Timezone Identifier (TZ_ID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Abbreviation (TZ_ABBR)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `abbreviation` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `associated_country_codes` SET TAGS ('dbx_business_glossary_term' = 'Associated Country Codes (ISO 3166-1 Alpha-3)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `associated_country_codes` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}(,[A-Z]{3})*$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `dst_observed` SET TAGS ('dbx_business_glossary_term' = 'Daylight Saving Time Observed (DST)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `iana_name` SET TAGS ('dbx_business_glossary_term' = 'IANA Time Zone Identifier (TZ)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `iana_name` SET TAGS ('dbx_value_regex' = '^[A-Za-z_]+/[A-Za-z_]+$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag (ACTIVE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `utc_offset_dst` SET TAGS ('dbx_business_glossary_term' = 'Daylight Saving UTC Offset (DST)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `utc_offset_dst` SET TAGS ('dbx_value_regex' = '^([+-][0-1][0-9]:[0-5][0-9])$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `utc_offset_standard` SET TAGS ('dbx_business_glossary_term' = 'Standard UTC Offset (STD)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`timezone` ALTER COLUMN `utc_offset_standard` SET TAGS ('dbx_value_regex' = '^([+-][0-1][0-9]:[0-5][0-9])$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` SET TAGS ('dbx_subdomain' = 'geographic_metadata');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `applicable_scheme` SET TAGS ('dbx_business_glossary_term' = 'Applicable Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `applicable_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|other');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_value_regex' = 'national|banking|scheme|ach|rtgs|other');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `holiday_calendar_description` SET TAGS ('dbx_business_glossary_term' = 'Holiday Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `holiday_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `holiday_calendar_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `holiday_date` SET TAGS ('dbx_business_glossary_term' = 'Holiday Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `holiday_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Holiday Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `is_settlement_holiday` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `card_scheme_description` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `card_scheme_name` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `card_scheme_status` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `card_scheme_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `card_scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `card_scheme_type` SET TAGS ('dbx_value_regex' = 'four_party|three_party|domestic');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `chargeback_time_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Time Limit (Days)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Contact Email');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `iso_20022_message_schemes` SET TAGS ('dbx_business_glossary_term' = 'ISO 20022 Message Schemes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `iso_8583_message_type_codes` SET TAGS ('dbx_business_glossary_term' = 'ISO 8583 Message Type Codes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `supported_card_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Types');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `supported_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`card_scheme` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Website URL');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage (GEOGRAPHIC_COVERAGE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `message_standard` SET TAGS ('dbx_business_glossary_term' = 'Message Standard (MESSAGE_STANDARD)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `message_standard` SET TAGS ('dbx_value_regex' = 'iso_8583|iso_20022|nacha|swift|sepa');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `payment_rail_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Description (DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `payment_rail_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `payment_rail_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `rail_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Code (RAIL_CODE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `rail_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `rail_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Name (RAIL_NAME)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `rail_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Type (RAIL_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `rail_type` SET TAGS ('dbx_value_regex' = 'card|ach|wire|rtp|rtgs|crypto');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `settlement_finality` SET TAGS ('dbx_business_glossary_term' = 'Settlement Finality Type (SETTLEMENT_FINALITY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `settlement_finality` SET TAGS ('dbx_value_regex' = 'gross|net|deferred');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `stp_capability` SET TAGS ('dbx_business_glossary_term' = 'Straight‑Through Processing Capability (STP_CAPABILITY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies (SUPPORTED_CURRENCIES)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`payment_rail` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_parent_regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Jurisdiction Identifier (PARENT_JUR_ID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `aml_ctf_regime` SET TAGS ('dbx_business_glossary_term' = 'AML/CTF Regime (AML_CTF)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `aml_ctf_regime` SET TAGS ('dbx_value_regex' = 'FinCEN|FATF|EU_AML_Directive');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations (APPL_REGS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `compliance_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Compliance Contact Email (COMP_EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `compliance_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `compliance_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `compliance_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `country_iso_code` SET TAGS ('dbx_business_glossary_term' = 'Country ISO Code (ISO_COUNTRY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `country_iso_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `cross_border_data_transfer` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Data Transfer (XFER_POLICY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `cross_border_data_transfer` SET TAGS ('dbx_value_regex' = 'allowed|restricted|prohibited');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `data_residency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Requirement (DATA_RESID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `data_residency_requirement` SET TAGS ('dbx_value_regex' = 'onshore|offshore|hybrid');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXP_DATE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `financial_law` SET TAGS ('dbx_business_glossary_term' = 'Financial Law (FIN_LAW)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_anti_money_laundering_required` SET TAGS ('dbx_business_glossary_term' = 'AML Requirement (AML_REQ)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'CCPA Applicable (CCPA_APPL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_data_protection_officer_required` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer Required (DPO_REQ)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_fatf_member` SET TAGS ('dbx_business_glossary_term' = 'FATF Member (FATF_MEMBER)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_financial_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Required (FIN_REP_REQ)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicable (GDPR_APPL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_psd2_applicable` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Applicable (PSD2_APPL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `is_sar_filing_required` SET TAGS ('dbx_business_glossary_term' = 'SAR Filing Required (SAR_REQ)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code (JUR_CODE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{1,3})?$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Currency Code (CURR_CODE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_language` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Language (LANG)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name (JUR_NAME)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_time_zone` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Time Zone (TZ)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z_]+/[A-Za-z_]+$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type (JUR_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'national|supranational|state_provincial|regional');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `primary_regulator` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulator (PRIM_REG)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `privacy_law` SET TAGS ('dbx_business_glossary_term' = 'Privacy Law (PRIV_LAW)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name (REG_NAME)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `regulator_type` SET TAGS ('dbx_business_glossary_term' = 'Regulator Type (REG_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `regulator_type` SET TAGS ('dbx_value_regex' = 'supervisory|self_regulatory|government');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `regulatory_jurisdiction_description` SET TAGS ('dbx_business_glossary_term' = 'Description (DESC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `regulatory_jurisdiction_status` SET TAGS ('dbx_business_glossary_term' = 'Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `regulatory_jurisdiction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (REVIEW_FREQ_DAYS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `tax_identification_number_format` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number Format (TIN_FMT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `applicable_payment_rails` SET TAGS ('dbx_business_glossary_term' = 'Applicable Payment Rails');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `applicable_payment_rails` SET TAGS ('dbx_value_regex' = 'card|ach|wire|digital_wallet|p2p|a2a');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|unionpay|discover|others');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `chargeback_timeframe_days` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Timeframe (Days)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `cross_border_fee_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Fee Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `cross_border_fee_indicator` SET TAGS ('dbx_value_regex' = 'applied|waived|none');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact (Debit/Credit/Neutral)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `financial_impact` SET TAGS ('dbx_value_regex' = 'debit|credit|neutral');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_chargeback_possible` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Possibility Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Transaction Type Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'External Origin Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_fraud_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Fraud Sensitivity Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_recurring_allowed` SET TAGS ('dbx_business_glossary_term' = 'Recurring Transaction Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_settlement_required` SET TAGS ('dbx_business_glossary_term' = 'Settlement Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `is_tokenizable` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `iso_20022_message_type` SET TAGS ('dbx_business_glossary_term' = 'ISO 20022 Message Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `iso_8583_processing_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 8583 Processing Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `max_amount_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount Limit');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `min_amount_limit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount Limit');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `processing_fee_indicator` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Responsibility');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `processing_fee_indicator` SET TAGS ('dbx_value_regex' = 'merchant|issuer|none');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `recurring_interval` SET TAGS ('dbx_business_glossary_term' = 'Recurring Interval');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `recurring_interval` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|yearly|none');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `requires_3ds` SET TAGS ('dbx_business_glossary_term' = '3‑DS Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `requires_authentication` SET TAGS ('dbx_business_glossary_term' = 'Authentication Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `requires_sca` SET TAGS ('dbx_business_glossary_term' = 'SCA Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `reversal_eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Eligibility Reason');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `reversal_eligible` SET TAGS ('dbx_business_glossary_term' = 'Reversal Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'same_day|next_day|t+2|t+3|custom');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `settlement_treatment` SET TAGS ('dbx_business_glossary_term' = 'Settlement Treatment');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `settlement_treatment` SET TAGS ('dbx_value_regex' = 'immediate|deferred|netting');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `settlement_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `settlement_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'static|dynamic|none');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category (ISO 20022)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_fee_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_fee_type` SET TAGS ('dbx_value_regex' = 'fixed|percentage|none');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_type_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_type_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_type_name` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_type_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `transaction_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`transaction_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `chargeback_reason_code_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `chargeback_reason_code_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code (CODE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `chargeback_reason_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `chargeback_reason_code_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description (DESC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `chargeback_reason_code_status` SET TAGS ('dbx_business_glossary_term' = 'Reason Code Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `chargeback_reason_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category (CATEGORY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'fraud|authorization|processing_error|consumer_dispute');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `documentation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirements (DOCS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag (MANDATORY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By (REVIEWED_BY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `legacy_code` SET TAGS ('dbx_business_glossary_term' = 'Legacy Reason Code (LEGACY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Steward Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `reason_code_type` SET TAGS ('dbx_business_glossary_term' = 'Reason Code Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `reason_code_type` SET TAGS ('dbx_value_regex' = 'chargeback|retrieval|representment');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `response_time_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Response Time Limit (DAYS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme (SCHEME)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Reason Subcategory (SUBCAT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Definition Version (VER)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`chargeback_reason_code` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` SET TAGS ('dbx_subdomain' = 'geographic_metadata');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `fx_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Reference FX Rate ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (BASE/QUOTE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `fx_rate_description` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `fx_rate_status` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `fx_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `is_intraday` SET TAGS ('dbx_business_glossary_term' = 'Intraday Rate Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'FX Market Region');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `precision` SET TAGS ('dbx_business_glossary_term' = 'Rate Precision');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `provider_identifier` SET TAGS ('dbx_business_glossary_term' = 'Rate Provider Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `quote_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quote Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `rate_category` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `rate_category` SET TAGS ('dbx_value_regex' = 'interbank|retail|wholesale|central_bank');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `rate_pair` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair (BASE/QUOTE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Source');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'ecb|reuters|internal');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'spot|mid|buy|sell|dcc');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`fx_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_bic_id` SET TAGS ('dbx_business_glossary_term' = 'SWIFT BIC Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_bic_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_bic_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `bic_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `branch_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Institution Email Address');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `institution_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `institution_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `institution_type` SET TAGS ('dbx_value_regex' = 'bank|broker|payment_service_provider|clearing_house|central_bank|other');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_gpi_supported` SET TAGS ('dbx_business_glossary_term' = 'SWIFT gpi Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_iban_supported` SET TAGS ('dbx_business_glossary_term' = 'IBAN Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_iban_supported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_iban_supported` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_rtp_supported` SET TAGS ('dbx_business_glossary_term' = 'Real‑Time Payments (RTP) Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_sepa_supported` SET TAGS ('dbx_business_glossary_term' = 'SEPA Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_swift_supported` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_swift_supported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `is_swift_supported` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `iso_9362_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9362 Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Institution Phone Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `sepa_reachability_flag` SET TAGS ('dbx_business_glossary_term' = 'SEPA Reachability Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_bic_status` SET TAGS ('dbx_business_glossary_term' = 'BIC Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_bic_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_bic_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_bic_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_connectivity_status` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Connectivity Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_connectivity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_connectivity_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `swift_connectivity_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Institution Website URL');
ALTER TABLE `payments_fintech_ecm`.`reference`.`swift_bic` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_id` SET TAGS ('dbx_business_glossary_term' = 'IBAN Structure Identifier (IBAN_STRUCTURE_ID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `account_number_length` SET TAGS ('dbx_business_glossary_term' = 'Account Number Length (ACCOUNT_NUMBER_LENGTH)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `account_number_length` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `account_number_length` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `account_number_position` SET TAGS ('dbx_business_glossary_term' = 'Account Number Position within BBAN (ACCOUNT_NUMBER_POSITION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `account_number_position` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `account_number_position` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `bank_identifier_length` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Length (BANK_IDENTIFIER_LENGTH)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `bank_identifier_position` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Position within BBAN (BANK_IDENTIFIER_POSITION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `bban_length` SET TAGS ('dbx_business_glossary_term' = 'BBAN Length (BBAN_LENGTH)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `bban_pattern` SET TAGS ('dbx_business_glossary_term' = 'Basic Bank Account Number (BBAN) Format Pattern (BBAN_PATTERN)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `bban_regex` SET TAGS ('dbx_business_glossary_term' = 'BBAN Validation Regular Expression (BBAN_REGEX)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `branch_identifier_length` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier Length (BRANCH_IDENTIFIER_LENGTH)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `branch_identifier_position` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier Position within BBAN (BRANCH_IDENTIFIER_POSITION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `check_digit_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Check Digit Algorithm (CHECK_DIGIT_ALGORITHM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `example_iban` SET TAGS ('dbx_business_glossary_term' = 'Example IBAN (EXAMPLE_IBAN)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `example_iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `example_iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_length` SET TAGS ('dbx_business_glossary_term' = 'IBAN Total Length (IBAN_LENGTH)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_length` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_length` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_regex` SET TAGS ('dbx_business_glossary_term' = 'IBAN Validation Regular Expression (IBAN_REGEX)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_regex` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_regex` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_description` SET TAGS ('dbx_business_glossary_term' = 'Description of IBAN Structure (DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_description` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_status` SET TAGS ('dbx_business_glossary_term' = 'IBAN Structure Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `iban_structure_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `last_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Last Validation Check (LAST_VALIDATED_DATE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `national_check_digit_length` SET TAGS ('dbx_business_glossary_term' = 'National Check Digit Length (NATIONAL_CHECK_DIGIT_LENGTH)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `national_check_digit_position` SET TAGS ('dbx_business_glossary_term' = 'National Check Digit Position within BBAN (NATIONAL_CHECK_DIGIT_POSITION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `sepa_member_flag` SET TAGS ('dbx_business_glossary_term' = 'SEPA Membership Indicator (SEPA_MEMBER_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of IBAN Definition (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SWIFT|ISO20022|SEPA');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iban_structure` ALTER COLUMN `validation_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Version Identifier (VALIDATION_RULE_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `nacha_return_code_id` SET TAGS ('dbx_business_glossary_term' = 'NACHA Return Code Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `applicable_sec_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable SEC Codes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `is_noc` SET TAGS ('dbx_business_glossary_term' = 'Notification of Change Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `nacha_return_code_status` SET TAGS ('dbx_business_glossary_term' = 'Return Code Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `nacha_return_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `reinitiation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Re‑initiation Eligibility');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `return_category` SET TAGS ('dbx_business_glossary_term' = 'Return Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `return_category` SET TAGS ('dbx_value_regex' = 'administrative|account|authorization|network');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `return_code` SET TAGS ('dbx_business_glossary_term' = 'NACHA Return Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `return_time_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Return Time Limit (Banking Days)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`nacha_return_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `emv_tag_id` SET TAGS ('dbx_business_glossary_term' = 'EMV Tag Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format (DATA_FORMAT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'numeric|alphanumeric|binary');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `emv_tag_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `emv_tag_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Flag (IS_DEPRECATED)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `iso_7816_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO 7816 Reference (ISO_7816_REFERENCE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `kernel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Kernel Applicability (KERNEL_APPLICABILITY)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `kernel_applicability` SET TAGS ('dbx_value_regex' = 'contact|contactless|nfc|both');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `length_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length (LENGTH_MAX)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `length_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length (LENGTH_MIN)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Tag Source (SOURCE)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'card|terminal|issuer');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `tag_description` SET TAGS ('dbx_business_glossary_term' = 'EMV Tag Description (TAG_DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `tag_hex` SET TAGS ('dbx_business_glossary_term' = 'EMV Tag Hexadecimal Identifier (TAG_HEX)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `tag_hex` SET TAGS ('dbx_value_regex' = '^[0-9A-Fa-f]{2,4}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'EMV Tag Name (TAG_NAME)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`emv_tag` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `kyc_document_type_id` SET TAGS ('dbx_business_glossary_term' = 'KYC Document Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `accepted_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Accepted Jurisdictions');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `applicable_processes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Processes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `applicable_processes` SET TAGS ('dbx_value_regex' = 'merchant_onboarding|cardholder_kyc|partner_kyb|risk_assessment');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'PDF|JPEG|PNG|XML');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `document_type_code` SET TAGS ('dbx_business_glossary_term' = 'KYC Document Type Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `document_type_name` SET TAGS ('dbx_business_glossary_term' = 'KYC Document Type Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `expiry_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiry Tracking Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `kyc_document_type_category` SET TAGS ('dbx_business_glossary_term' = 'KYC Document Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `kyc_document_type_category` SET TAGS ('dbx_value_regex' = 'government_id|proof_of_address|business_registration|beneficial_ownership|financial_statement');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `kyc_document_type_description` SET TAGS ('dbx_business_glossary_term' = 'KYC Document Type Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `max_file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Maximum File Size (MB)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `requires_manual_review` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `requires_ocr` SET TAGS ('dbx_business_glossary_term' = 'OCR Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `supporting_documents_required` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`kyc_document_type` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `pci_control_id` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Control Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Control Applicability Scope');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_value_regex' = 'merchant|service_provider|both');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Control Compliance Owner');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `compliance_owner_role` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner Role');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `compliance_owner_role` SET TAGS ('dbx_value_regex' = 'security|audit|risk|operations');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Control Assessment Method');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_assessment_method` SET TAGS ('dbx_value_regex' = 'self_assessment|external_audit|automated_scan');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_category` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Control Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_category` SET TAGS ('dbx_value_regex' = 'network_security|access_control|encryption|monitoring|policy|vulnerability_management');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_comments` SET TAGS ('dbx_business_glossary_term' = 'Control Comments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation URL');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_is_applicable_to_application` SET TAGS ('dbx_business_glossary_term' = 'Applicable to Application Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_is_applicable_to_cardholder_data` SET TAGS ('dbx_business_glossary_term' = 'Applicable to Cardholder Data Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_is_applicable_to_network` SET TAGS ('dbx_business_glossary_term' = 'Applicable to Network Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_is_applicable_to_physical` SET TAGS ('dbx_business_glossary_term' = 'Applicable to Physical Environment Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_is_applicable_to_process` SET TAGS ('dbx_business_glossary_term' = 'Applicable to Process Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Control Mandatory Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_is_tested` SET TAGS ('dbx_business_glossary_term' = 'Control Tested Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_last_assessed_date` SET TAGS ('dbx_business_glossary_term' = 'Control Last Assessed Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Control Mechanism');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_next_assessment_due` SET TAGS ('dbx_business_glossary_term' = 'Control Next Assessment Due Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_number` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Control Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_number` SET TAGS ('dbx_value_regex' = '^d+(.d+)*$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_reference_standard` SET TAGS ('dbx_business_glossary_term' = 'Control Reference Standard');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_reference_standard` SET TAGS ('dbx_value_regex' = 'PCI DSS|ISO 27001|NIST SP 800-53');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Control Remediation Action');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Control Revision Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|planned');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_test_result` SET TAGS ('dbx_business_glossary_term' = 'Control Test Result');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|partial');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_tested_by` SET TAGS ('dbx_business_glossary_term' = 'Control Tested By');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_tested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Control Test Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_title` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Control Title');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `control_version` SET TAGS ('dbx_business_glossary_term' = 'Control Version');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Control Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Control Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Control Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `nist_csf_category` SET TAGS ('dbx_business_glossary_term' = 'NIST CSF Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `nist_csf_category` SET TAGS ('dbx_value_regex' = 'identify|protect|detect|respond|recover');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `nist_csf_subcategory` SET TAGS ('dbx_business_glossary_term' = 'NIST CSF Subcategory');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `pci_version` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Version');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `pci_version` SET TAGS ('dbx_value_regex' = '3.2.1|4.0');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Requirement Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `requirement_number` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Requirement Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `saq_type` SET TAGS ('dbx_business_glossary_term' = 'Self‑Assessment Questionnaire Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `testing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Control Testing Procedure');
ALTER TABLE `payments_fintech_ecm`.`reference`.`pci_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Control Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `ofac_sanctions_list_id` SET TAGS ('dbx_business_glossary_term' = 'OFAC Sanctions List Entry ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Address (Physical Location)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `aliases` SET TAGS ('dbx_business_glossary_term' = 'Aliases (Alternative Names)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `aliases` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `aliases` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Date of Entry)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type (Individual, Organization, Vessel, Aircraft)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'individual|organization|vessel|aircraft|entity');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `is_narcotics_designation` SET TAGS ('dbx_business_glossary_term' = 'Narcotics Designation Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `is_proliferation_designation` SET TAGS ('dbx_business_glossary_term' = 'Proliferation Designation Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `is_special_designation` SET TAGS ('dbx_business_glossary_term' = 'Special Designation Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `is_terrorist_designation` SET TAGS ('dbx_business_glossary_term' = 'Terrorist Designation Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `is_wmd_designation` SET TAGS ('dbx_business_glossary_term' = 'WMD Designation Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `list_type` SET TAGS ('dbx_business_glossary_term' = 'List Type (OFAC List Category)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `list_type` SET TAGS ('dbx_value_regex' = 'SDN|Consolidated|EU|UN|Non-SDN|Other');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `ofac_sanctions_list_name` SET TAGS ('dbx_business_glossary_term' = 'Sanctioned Entity Name (Full Name)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `ofac_sanctions_list_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `ofac_sanctions_list_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `ofac_sanctions_list_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Entry Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `ofac_sanctions_list_status` SET TAGS ('dbx_value_regex' = 'active|removed|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `primary_contact` SET TAGS ('dbx_value_regex' = 'email|phone|address|none');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `program` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Program (OFAC Program)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `program` SET TAGS ('dbx_value_regex' = 'IRAN|RUSSIA|DPRK|CUBA|VIOLATORS|OTHER');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (Additional Notes)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date (Date of De-listing)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (Originating System)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`ofac_sanctions_list` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source URL');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `aml_risk_country_id` SET TAGS ('dbx_business_glossary_term' = 'AML Risk Country Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `aml_risk_country_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `aml_risk_country_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `enhanced_dd_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `eu_high_risk_third_country_flag` SET TAGS ('dbx_business_glossary_term' = 'EU High‑Risk Third‑Country Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `fatf_status` SET TAGS ('dbx_business_glossary_term' = 'FATF Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `fatf_status` SET TAGS ('dbx_value_regex' = 'blacklist|greylist|compliant');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `fincen_advisory_flag` SET TAGS ('dbx_business_glossary_term' = 'FinCEN Advisory Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`aml_risk_country` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `iso_message_field_id` SET TAGS ('dbx_business_glossary_term' = 'ISO Message Field ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `iso_message_type_id` SET TAGS ('dbx_business_glossary_term' = 'Iso Message Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'numeric|alphanumeric|binary|date|time|datetime');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `field_category` SET TAGS ('dbx_business_glossary_term' = 'Field Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `field_category` SET TAGS ('dbx_value_regex' = 'transaction|security|routing|settlement|risk|metadata');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `field_description` SET TAGS ('dbx_business_glossary_term' = 'Field Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `field_number` SET TAGS ('dbx_business_glossary_term' = 'Field Number / Tag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Field Format');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'numeric|alphanumeric|binary');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `iso_message_field_status` SET TAGS ('dbx_business_glossary_term' = 'Field Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `iso_message_field_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `length` SET TAGS ('dbx_business_glossary_term' = 'Field Length');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `length` SET TAGS ('dbx_value_regex' = '^d+(-d+)?$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `mandatory_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `mandatory_indicator` SET TAGS ('dbx_value_regex' = 'Y|N');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `message_standard` SET TAGS ('dbx_business_glossary_term' = 'Message Standard (ISO 8583 / ISO 20022)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `message_standard` SET TAGS ('dbx_value_regex' = 'ISO8583|ISO20022');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_field` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `applicable_country_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Country Codes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Cut‑off Time');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `cutoff_timezone` SET TAGS ('dbx_business_glossary_term' = 'Cut‑off Timezone');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `cutoff_timezone` SET TAGS ('dbx_value_regex' = '^[A-Za-z_]+/[A-Za-z_]+$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `funding_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Funding Lag (Days)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `is_default_cycle` SET TAGS ('dbx_business_glossary_term' = 'Default Settlement Cycle Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `processing_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|t+1|t+2|t+3|weekly');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_window_end` SET TAGS ('dbx_business_glossary_term' = 'Settlement Window End Time');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_window_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_window_start` SET TAGS ('dbx_business_glossary_term' = 'Settlement Window Start Time');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `settlement_window_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`settlement_cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `network_error_code_id` SET TAGS ('dbx_business_glossary_term' = 'Network Error Code Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `error_category` SET TAGS ('dbx_business_glossary_term' = 'Error Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `error_category` SET TAGS ('dbx_value_regex' = 'connectivity|timeout|format|authentication|business_rule|system_error');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `error_source` SET TAGS ('dbx_business_glossary_term' = 'Error Source');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `error_source` SET TAGS ('dbx_value_regex' = 'gateway|network|scheme|acquirer|issuer');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `network_error_code_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `network_error_code_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `network_error_code_status` SET TAGS ('dbx_business_glossary_term' = 'Error Code Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `network_error_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `retry_recommended` SET TAGS ('dbx_business_glossary_term' = 'Retry Recommended Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`network_error_code` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `qr_code_id` SET TAGS ('dbx_business_glossary_term' = 'QR Code Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'QR Code Channel');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'upi|proprietary|other');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'QR Code Expiry Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'QR Code Generation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `is_test_code` SET TAGS ('dbx_business_glossary_term' = 'Test QR Code Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `last_scanned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Scan Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `payload` SET TAGS ('dbx_business_glossary_term' = 'QR Code Payload');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `qr_code_status` SET TAGS ('dbx_business_glossary_term' = 'QR Code Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `qr_code_status` SET TAGS ('dbx_value_regex' = 'active|expired|used|revoked');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `qr_code_type` SET TAGS ('dbx_business_glossary_term' = 'QR Code Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `qr_code_type` SET TAGS ('dbx_value_regex' = 'static|dynamic|p2p');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `qr_version` SET TAGS ('dbx_business_glossary_term' = 'QR Code Version');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `scan_count` SET TAGS ('dbx_business_glossary_term' = 'QR Code Scan Count');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme');
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ALTER COLUMN `usage_limit` SET TAGS ('dbx_business_glossary_term' = 'QR Code Usage Limit');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `wallet_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Scheme Certification Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `cross_border_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Support Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Currency Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `dcc_supported` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Supported Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `dispute_resolution_policy` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Policy');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `dispute_resolution_policy` SET TAGS ('dbx_value_regex' = 'merchant_favor|issuer_favor|neutral');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Scheme Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Scheme Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Scheme Go‑Live Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `interchange_fee_model` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Model');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `interchange_fee_model` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `interchange_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Rate');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `pci_dss_compliant` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `psd2_compliant` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Scheme Risk Score');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `scheme_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Agreement Reference');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `scheme_name` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Type');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `scheme_type` SET TAGS ('dbx_value_regex' = 'OEM|proprietary|UPI|QR');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `supported_nfc_kernels` SET TAGS ('dbx_business_glossary_term' = 'Supported NFC Kernels');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `supported_provisioning_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Provisioning Methods');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `supported_token_requestor_ids` SET TAGS ('dbx_business_glossary_term' = 'Supported Token Requestor IDs');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Scheme Version Number');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `wallet_scheme_description` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `wallet_scheme_status` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`wallet_scheme` ALTER COLUMN `wallet_scheme_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `issuer_wallet_config_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Wallet Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `wallet_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `allowed_card_schemes` SET TAGS ('dbx_business_glossary_term' = 'Allowed Card Schemes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `allowed_countries` SET TAGS ('dbx_business_glossary_term' = 'Allowed Countries (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `compliance_pci_dss_version` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Version');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `compliance_psd2_version` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Version');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|suspended|archived');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `green_path_threshold` SET TAGS ('dbx_business_glossary_term' = 'Green Path Threshold (%)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `is_cross_border_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Support');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `is_dynamic_currency_conversion_supported` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Supported');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `is_tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `issuer_wallet_config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `max_tokens_per_fpan` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tokens per FPAN');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `otp_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'One‑Time Password Delivery Method');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `otp_delivery_method` SET TAGS ('dbx_value_regex' = 'sms|email|push_notification|voice_call');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `provisioning_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Rule Set');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `red_path_threshold` SET TAGS ('dbx_business_glossary_term' = 'Red Path Threshold (%)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `step_up_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Step‑Up Authentication Required');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `step_up_trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Step‑Up Trigger Condition');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `step_up_trigger_condition` SET TAGS ('dbx_value_regex' = 'amount_threshold|risk_score|geolocation|device_change');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `token_assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Token Assurance Level');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `token_assurance_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `token_expiry_days` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry (Days)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `token_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Policy');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `token_expiry_policy` SET TAGS ('dbx_value_regex' = 'rolling|fixed|session');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ALTER COLUMN `yellow_path_threshold` SET TAGS ('dbx_business_glossary_term' = 'Yellow Path Threshold (%)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `scheme_message_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Message Identifier (SMI)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Identifier (SID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `correlation_code` SET TAGS ('dbx_business_glossary_term' = 'Correlation Identifier (CID)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Message Direction (DIR)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code (EC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `message_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Timestamp (TS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'Message Type (MT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `message_type` SET TAGS ('dbx_value_regex' = 'provisioning_response|token_status_update|lifecycle_notification|cryptogram_validation');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `payload_hash` SET TAGS ('dbx_business_glossary_term' = 'Payload Hash (PH)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status (PS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|retrying');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `raw_message_uri` SET TAGS ('dbx_business_glossary_term' = 'Raw Message URI (RMU)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count (RC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `status_code` SET TAGS ('dbx_business_glossary_term' = 'Status Code (SC)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` SET TAGS ('dbx_subdomain' = 'transaction_classification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `iso_message_type_id` SET TAGS ('dbx_business_glossary_term' = 'ISO Message Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `response_iso_message_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `applicable_payment_rail` SET TAGS ('dbx_business_glossary_term' = 'Applicable Payment Rail');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `applicable_payment_rail` SET TAGS ('dbx_value_regex' = 'card|ach|swift|sepa|rtp|p2p');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Message Direction');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'request|response|notification');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `example_message` SET TAGS ('dbx_business_glossary_term' = 'Example Message Payload');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `fee_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fee Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `fee_indicator` SET TAGS ('dbx_value_regex' = 'yes|no|conditional');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `field_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Fields');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `is_batch` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `is_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fee Applicability Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `is_fraud_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Fraud Sensitive Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `is_real_time` SET TAGS ('dbx_business_glossary_term' = 'Real‑Time Indicator');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `iso_message_type_description` SET TAGS ('dbx_business_glossary_term' = 'Message Type Description');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `iso_message_type_status` SET TAGS ('dbx_business_glossary_term' = 'Message Type Status');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `iso_message_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `message_category` SET TAGS ('dbx_business_glossary_term' = 'Message Category');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `message_name` SET TAGS ('dbx_business_glossary_term' = 'Message Type Name');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `message_standard` SET TAGS ('dbx_business_glossary_term' = 'Message Standard');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `message_standard` SET TAGS ('dbx_value_regex' = 'ISO8583|ISO20022');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `message_type_code` SET TAGS ('dbx_business_glossary_term' = 'Message Type Code (e.g., pacs.008, 0200)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `processing_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `requires_authentication` SET TAGS ('dbx_business_glossary_term' = 'Requires Authentication Flag');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `schema_url` SET TAGS ('dbx_business_glossary_term' = 'Schema URL');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`reference`.`iso_message_type` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Message Version');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `financial_institution_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `parent_financial_institution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`financial_institution` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` SET TAGS ('dbx_subdomain' = 'payment_instruments');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `parent_issuer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
