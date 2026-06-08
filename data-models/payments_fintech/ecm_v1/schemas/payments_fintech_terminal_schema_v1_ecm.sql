-- Schema for Domain: terminal | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`terminal` COMMENT 'Point-of-sale and terminal management including TID provisioning, terminal configuration, EMV parameter management, contactless enablement, terminal software updates, device inventory, terminal deployment, POS hardware lifecycle, and device security configurations per PCI PTS standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` (
    `payment_instrument_id` BIGINT COMMENT 'System-generated unique identifier for each payment instrument record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Instrument-level currency must align with reference.currency for transaction routing and compliance with currency-specific rules.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Required for Issuer‑Partner reporting: links each payment instrument to the issuing partner for settlement, KYC, AML, and revenue‑share calculations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Required for posting instrument fees and balances to the General Ledger; finance teams need a direct GL account per payment instrument for accurate accounting.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Needed to determine the applicable interchange rate category for a payment instrument during transaction processing and fee calculation.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Required for fee schedule, compliance and reporting: each funding instrument is issued under a specific payment product.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: REQUIRED: Interchange fee calculation and compliance reporting need to know the network scheme of each instrument.',
    `wallet_transaction_id` BIGINT COMMENT 'Identifier of the most recent transaction linked to this instrument.',
    `available_balance` DECIMAL(18,2) COMMENT 'Current spendable balance after pending authorizations.',
    `bin` STRING COMMENT 'First six digits of the PAN identifying the issuing bank and card brand.',
    `card_scheme` STRING COMMENT 'Payment network brand associated with the card (e.g., Visa, Mastercard).. Valid values are `visa|mastercard|amex|discover|unionpay|other`',
    `cardholder_name` STRING COMMENT 'Legal name of the individual to whom the instrument is issued.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment instrument record was first created in the system.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate amount allowed per day.',
    `expiry_date` DATE COMMENT 'Date after which the instrument is no longer valid.',
    `fraud_reason_code` STRING COMMENT 'Code indicating the reason for fraud flagging (e.g., stolen, counterfeit, suspicious_activity).',
    `iin` STRING COMMENT 'Extended identifier (first 6‑8 digits) used for routing and fraud checks.',
    `instrument_type` STRING COMMENT 'Category of the payment instrument (e.g., physical card, virtual card, ACH account, UPI ID, digital wallet).. Valid values are `card|virtual_card|ach|upi|digital_wallet|other`',
    `is_3ds_enrolled` BOOLEAN COMMENT 'Indicates whether the instrument is enrolled in 3‑Domain Secure authentication.',
    `is_contactless` BOOLEAN COMMENT 'True if the instrument supports contactless (NFC) transactions.',
    `is_fraud_flagged` BOOLEAN COMMENT 'True if the instrument has been flagged for suspected fraud.',
    `is_hce_enabled` BOOLEAN COMMENT 'True if the instrument can be used via HCE on mobile devices.',
    `is_nfc_enabled` BOOLEAN COMMENT 'Indicates NFC hardware support for the instrument.',
    `is_sca_compliant` BOOLEAN COMMENT 'True if the instrument meets PSD2 SCA requirements.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether the instrument is a virtual (non‑physical) representation.',
    `issuance_date` DATE COMMENT 'Date the payment instrument was issued to the holder.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful transaction using the instrument.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit amount authorized for the instrument.',
    `monthly_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate amount allowed per calendar month.',
    `network_brand` STRING COMMENT 'Underlying interchange network used for transaction routing.. Valid values are `visa|mastercard|interac|rupay|others`',
    `pan_masked` STRING COMMENT 'Human‑readable masked PAN (e.g., 1234******5678) for display in UI and reports.',
    `pan_token` STRING COMMENT 'PCI‑DSS token representing the full PAN; used for internal processing without exposing the actual number.',
    `payment_instrument_status` STRING COMMENT 'Current lifecycle state of the instrument.. Valid values are `active|inactive|blocked|suspended|closed|pending`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) generated by fraud detection models.',
    `token_service_provider` STRING COMMENT 'Entity that issued the token for the instrument.',
    `token_type` STRING COMMENT 'Classification of the tokens usage scope.. Valid values are `single_use|multi_use|session|device`',
    `updated_by` STRING COMMENT 'Name or identifier of the source system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment instrument record.',
    `created_by` STRING COMMENT 'Name or identifier of the source system that created the record.',
    CONSTRAINT pk_payment_instrument PRIMARY KEY(`payment_instrument_id`)
) COMMENT 'Master record for all payment instruments issued or managed by the platform — physical cards, virtual cards, ACH account credentials, UPI IDs, and alternative payment methods. Stores instrument type, status, issuance date, expiry, PAN (tokenized/masked), BIN, IIN, card scheme, network brand, currency, and PCI DSS classification. SSOT for instrument identity across the enterprise.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`card` (
    `card_id` BIGINT COMMENT 'System-generated unique identifier for the card record.',
    `card_program_id` BIGINT COMMENT 'Reference to the card program that defines pricing, limits, and rules for this card.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Reference to the individual or entity that owns the card.',
    `cardholder_profile_id` BIGINT COMMENT 'Reference to the individual or entity that owns the card.',
    `activation_date` DATE COMMENT 'Date the card became active for transactions.',
    `available_balance` DECIMAL(18,2) COMMENT 'Current available balance for prepaid or debit cards.',
    `card_art_code` BIGINT COMMENT 'Reference to the visual design (artwork) applied to the card.',
    `card_status` STRING COMMENT 'Current operational status of the card.. Valid values are `active|suspended|expired|lost|stolen|cancelled`',
    `card_type` STRING COMMENT 'Category of the card product (e.g., credit, debit, prepaid, commercial, virtual).. Valid values are `credit|debit|prepaid|commercial|virtual`',
    `contactless` BOOLEAN COMMENT 'True if the card can be used for contactless (NFC) transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the card record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cards monetary values.',
    `cvv_indicator` STRING COMMENT 'Indicates whether the CVV value is stored, masked, or unavailable.. Valid values are `present|absent|unknown`',
    `deactivation_date` DATE COMMENT 'Date the card was deactivated or closed (nullable).',
    `embossed_name` STRING COMMENT 'Name printed on the front of the physical card.',
    `emv_capable` BOOLEAN COMMENT 'True if the card supports EMV chip technology.',
    `expiry_month` STRING COMMENT 'Two‑digit month (01‑12) when the card expires.',
    `expiry_year` STRING COMMENT 'Four‑digit year when the card expires.',
    `is_tokenized` BOOLEAN COMMENT 'True if the card number is stored only as a token.',
    `is_virtual` BOOLEAN COMMENT 'True if the card exists only in digital form (no physical card).',
    `issuance_channel` STRING COMMENT 'Channel through which the card was provisioned.. Valid values are `online|branch|partner|api`',
    `issue_date` DATE COMMENT 'Date the card was issued to the cardholder.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction or activity using the card.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit authorized for the card (applicable to credit cards).',
    `magnetic_stripe` BOOLEAN COMMENT 'True if the card includes a magnetic stripe.',
    `number_last4` STRING COMMENT 'Last four digits of the card number, displayed for identification purposes.',
    `pan_token` STRING COMMENT 'Tokenized representation of the cards Primary Account Number, used for secure processing.',
    `pin_change_date` DATE COMMENT 'Date the PIN was last changed.',
    `pin_set` BOOLEAN COMMENT 'True if a personal identification number (PIN) has been set for the card.',
    `scheme` STRING COMMENT 'Payment network scheme associated with the card.. Valid values are `visa|mastercard|amex|discover|unionpay|other`',
    `token` STRING COMMENT 'Token value representing the card number for transaction processing.',
    `tokenization_service` STRING COMMENT 'Name of the token service provider that issued the token for this card.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the card record.',
    CONSTRAINT pk_card PRIMARY KEY(`card_id`)
) COMMENT 'Physical and virtual card master entity representing a specific card product instance — credit, debit, prepaid, or commercial card. Captures card number (PAN masked/tokenized), card type, card program reference, embossed name, expiry date (MM/YY), CVV indicator, EMV chip capability, contactless (NFC) flag, magnetic stripe flag, card art reference, and card status lifecycle (active, suspended, expired, lost, stolen, cancelled).';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` (
    `wallet_bin_range_id` BIGINT COMMENT 'Surrogate primary key for the BIN range record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Bin range may be currency-specific; linking to reference.currency supports cross-border fee calculations.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Bin range configuration is defined per wallet; linking to digital_wallet enables lookup of scheme and limits.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal or external identifier for the issuing bank.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Bin range issuing country compliance requires reference.country for sanctions and regulatory checks.',
    `partner_profile_id` BIGINT COMMENT 'Internal or external identifier for the issuing bank.. Valid values are `^[A-Z0-9]{8,12}$`',
    `bin_length` STRING COMMENT 'Length of the BIN prefix (number of digits).',
    `bin_prefix` STRING COMMENT 'Numeric prefix (6-11 digits) identifying the issuing institution.. Valid values are `^[0-9]{6,11}$`',
    `bin_range_end` STRING COMMENT 'Ending numeric value of the BIN/IIN range.. Valid values are `^[0-9]{6,19}$`',
    `bin_range_start` STRING COMMENT 'Starting numeric value of the BIN/IIN range.. Valid values are `^[0-9]{6,19}$`',
    `card_scheme` STRING COMMENT 'Payment network brand associated with the BIN.. Valid values are `Visa|Mastercard|Amex|Discover|JCB|UnionPay`',
    `card_type` STRING COMMENT 'Classification of the card product.. Valid values are `credit|debit|prepaid|commercial|corporate|government`',
    `compliance_flags` STRING COMMENT 'Comma-separated list of compliance regimes applicable to the BIN.. Valid values are `pci|psd2|sox|gdpr|ccpa|ofac`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `dpan_supported` BOOLEAN COMMENT 'Indicates if Device PAN (DPAN) is issued for this BIN.',
    `effective_from` DATE COMMENT 'Date when the BIN range becomes effective.',
    `effective_until` DATE COMMENT 'Date when the BIN range expires or is retired (nullable).',
    `funding_type` STRING COMMENT 'Whether the card is funded directly from an account or prepaid.. Valid values are `funded|non_funded|prepaid|debit`',
    `interchange_eligible` BOOLEAN COMMENT 'Indicates if the BIN is eligible for interchange fee processing.',
    `interchange_fee_rate` DECIMAL(18,2) COMMENT 'Standard interchange fee percentage for the BIN.',
    `issuing_bank_name` STRING COMMENT 'Legal name of the issuing financial institution.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum allowed transaction amount for this BIN (currency unspecified).',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum allowed transaction amount for this BIN.',
    `network` STRING COMMENT 'Network through which transactions are routed. [ENUM-REF-CANDIDATE: Visa|Mastercard|Amex|Discover|JCB|UnionPay|Other — 7 candidates stripped; promote to reference product]',
    `product_category` STRING COMMENT 'Broad category of the card product.. Valid values are `consumer|business|government|travel|rewards|corporate`',
    `risk_level` STRING COMMENT 'Risk assessment classification for the BIN range.. Valid values are `low|medium|high|critical`',
    `surcharge_applicable` BOOLEAN COMMENT 'Whether surcharges may be applied to transactions using this BIN.',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates if the BIN supports tokenization services.',
    `transaction_routing_indicator` STRING COMMENT 'Indicates typical channels for routing transactions using this BIN.. Valid values are `online|pos|mpos|ecom|atm|mobile`',
    `updated_by` STRING COMMENT 'Identifier of the system or user that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `wallet_bin_range_status` STRING COMMENT 'Current lifecycle status of the BIN range.. Valid values are `active|inactive|suspended|pending|retired`',
    `created_by` STRING COMMENT 'Identifier of the system or user that created the record.',
    CONSTRAINT pk_wallet_bin_range PRIMARY KEY(`wallet_bin_range_id`)
) COMMENT 'BIN/IIN range registry defining the authoritative mapping of Bank Identification Number (BIN) and Issuer Identification Number (IIN) ranges to issuing institutions, card schemes, card types, and product categories. Stores BIN prefix (6–11 digits), range start/end, card scheme (Visa, Mastercard, Amex, Discover), card type (credit/debit/prepaid), issuing country, issuing bank, funding type, and interchange eligibility flags. Critical for transaction routing and authorization decisions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` (
    `wallet_card_scheme_id` BIGINT COMMENT 'Unique surrogate key for each card scheme record.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Card scheme reference is scoped to a specific wallet; linking provides direct access to scheme details.',
    `contact_email` STRING COMMENT 'Primary email address for scheme operator communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for scheme operator communications.. Valid values are `^[+]?d{1,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the scheme record was initially loaded.',
    `cross_border_supported` BOOLEAN COMMENT 'True if the scheme is authorized for international transactions.',
    `dispute_resolution_policy` STRING COMMENT 'Identifier or URL of the policy governing dispute handling for the scheme.',
    `dynamic_currency_conversion_supported` BOOLEAN COMMENT 'True if the scheme supports dynamic currency conversion at point of sale.',
    `effective_date` DATE COMMENT 'Calendar date on which the scheme version started to apply.',
    `geographic_coverage` STRING COMMENT 'List of ISO‑3166‑1 alpha‑3 country codes where the scheme operates. [ENUM-REF-CANDIDATE: many values — promote to reference product]',
    `interchange_fee_model` STRING COMMENT 'Methodology for determining interchange fees for the scheme.. Valid values are `percentage|flat|tiered|mixed`',
    `operator_name` STRING COMMENT 'Name of the organization that governs the card scheme.',
    `pci_dss_compliant` BOOLEAN COMMENT 'True if the scheme meets PCI DSS security standards.',
    `psd2_compliant` BOOLEAN COMMENT 'True if the scheme complies with the Payment Services Directive 2.',
    `retirement_date` DATE COMMENT 'Calendar date on which the scheme version ceased to be active (nullable if still active).',
    `rule_version` STRING COMMENT 'Identifier for the version of the schemes processing rules (e.g., 2023‑01).',
    `scheme_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the card network scheme.. Valid values are `^[A-Z0-9]{2,6}$`',
    `scheme_name` STRING COMMENT 'Full descriptive name of the card network (e.g., Visa, Mastercard).',
    `scheme_type` STRING COMMENT 'Category of the scheme (e.g., network, brand, regional). [ENUM-REF-CANDIDATE: network|brand|regional|private|co‑branded|other — promote to reference product]',
    `settlement_currency` STRING COMMENT 'ISO 4217 three‑letter currency code for settlement of interchange and fees.. Valid values are `^[A-Z]{3}$`',
    `supported_card_types` STRING COMMENT 'Comma‑separated list of card types the scheme issues.. Valid values are `credit|debit|prepaid|commercial|corporate`',
    `supported_transaction_types` STRING COMMENT 'Comma‑separated list of transaction types allowed under the scheme.. Valid values are `purchase|refund|cash_advance|preauth|auth_capture|reversal`',
    `tokenization_supported` BOOLEAN COMMENT 'True if the scheme allows tokenized card representations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the scheme record.',
    `wallet_card_scheme_description` STRING COMMENT 'Narrative description providing additional context about the scheme.',
    `wallet_card_scheme_status` STRING COMMENT 'Operational status of the scheme version.. Valid values are `active|inactive|deprecated|pending`',
    `website_url` STRING COMMENT 'Official web address for the scheme operator.. Valid values are `^https?://.+$`',
    CONSTRAINT pk_wallet_card_scheme PRIMARY KEY(`wallet_card_scheme_id`)
) COMMENT 'Reference master for payment card network brands and schemes — Visa, Mastercard, American Express, Discover, UnionPay, RuPay, JCB, etc. Stores scheme code, scheme name, scheme operator, supported card types, supported transaction types, geographic coverage, settlement currency, and scheme-specific rule version references. Used for routing, interchange qualification, and compliance alignment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`emv_config` (
    `emv_config_id` BIGINT COMMENT 'Unique surrogate key for each EMV configuration record.',
    `card_id` BIGINT COMMENT 'Foreign key linking to wallet.card. Business justification: EMV configuration belongs to a specific card; linking enables card‑level EMV parameter retrieval.',
    `aid` STRING COMMENT 'Hexadecimal identifier of the EMV application stored on the chip.',
    `app_version` STRING COMMENT 'Version string of the EMV application (e.g., 1.0.3).',
    `compliance_pci_dss_version` STRING COMMENT 'Version of the PCI DSS standard to which this configuration complies.',
    `config_code` STRING COMMENT 'Business identifier code used to reference the EMV configuration in downstream systems.',
    `config_name` STRING COMMENT 'Human‑readable name identifying the EMV configuration.',
    `config_type` STRING COMMENT 'Category of the EMV configuration based on supported interface types.. Valid values are `contactless|magstripe|chip|dual_interface`',
    `contactless_capability_flag` BOOLEAN COMMENT 'Indicates whether contactless transactions are permitted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the EMV configuration record was first created.',
    `cryptogram_type` STRING COMMENT 'Type of cryptogram generated during transaction (Authorization Request Cryptogram, Transaction Cryptogram, or Application Authentication Cryptogram).. Valid values are `ARQC|TC|AAC`',
    `cumulative_limit` DECIMAL(18,2) COMMENT 'Overall cumulative amount limit over a defined period (e.g., monthly).',
    `cvm_required_flag` BOOLEAN COMMENT 'Indicates whether a Cardholder Verification Method is mandatory for this configuration.',
    `cvm_requirements` STRING COMMENT 'Rules describing required CVM (e.g., PIN, signature, biometrics) for the configuration.',
    `daily_limit` DECIMAL(18,2) COMMENT 'Cumulative transaction amount limit for a cardholder within a calendar day.',
    `dynamic_currency_conversion_supported_flag` BOOLEAN COMMENT 'Indicates if the configuration supports Dynamic Currency Conversion (DCC).',
    `dynamic_data_authentication_flag` BOOLEAN COMMENT 'Indicates whether Dynamic Data Authentication (DDA) is enabled.',
    `effective_from` DATE COMMENT 'Date on which the EMV configuration becomes effective for processing.',
    `effective_until` DATE COMMENT 'Date on which the EMV configuration ceases to be effective (null if open‑ended).',
    `emv_config_description` STRING COMMENT 'Free‑form description providing additional context for the configuration.',
    `emv_config_status` STRING COMMENT 'Current lifecycle status of the EMV configuration.. Valid values are `active|inactive|retired`',
    `emvco_spec_version` STRING COMMENT 'Version of the EMVCo specification governing this configuration.',
    `floor_limit` DECIMAL(18,2) COMMENT 'Maximum transaction amount that can be approved offline without online authorization.',
    `issuer_action_codes` STRING COMMENT 'Issuer‑defined action codes governing risk and decline decisions.',
    `issuer_country_code` STRING COMMENT 'Three‑letter ISO country code of the issuing bank or entity.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance or policy review of the configuration.',
    `offline_data_auth_method` STRING COMMENT 'Method used for offline data authentication of the chip (Static, Dynamic, or Combined DDA).. Valid values are `SDA|DDA|CDA`',
    `offline_pin_verification_flag` BOOLEAN COMMENT 'Indicates support for offline PIN verification.',
    `online_pin_verification_flag` BOOLEAN COMMENT 'Indicates support for online PIN verification.',
    `personalization_profile_code` STRING COMMENT 'Identifier of the chip personalization profile linked to this EMV configuration.',
    `risk_score_threshold` STRING COMMENT 'Numeric threshold above which a transaction is flagged for additional risk checks.',
    `static_data_authentication_flag` BOOLEAN COMMENT 'Indicates whether Static Data Authentication (SDA) is enabled.',
    `supported_card_schemes` STRING COMMENT 'List of payment network schemes supported by this EMV configuration.. Valid values are `Visa|Mastercard|Amex|Discover|JCB|UnionPay`',
    `supported_currencies` STRING COMMENT 'Currency codes for which the configuration is valid.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `terminal_action_codes` STRING COMMENT 'Concatenated terminal action codes controlling transaction flow (e.g., TAC‑Default, TAC‑Denial).',
    `terminal_capability` STRING COMMENT 'Capabilities of the terminal (e.g., offline, online, contactless) as defined by EMV.',
    `tokenization_supported_flag` BOOLEAN COMMENT 'Indicates if tokenization of PAN is enabled for this configuration.',
    `transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount allowed for a single transaction under this EMV configuration.',
    `transaction_type_supported` STRING COMMENT 'Types of transactions that this EMV configuration can process.. Valid values are `purchase|cash|refund|preauth`',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the EMV configuration record.',
    `version_number` STRING COMMENT 'Sequential version number incremented on each change to the configuration.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_emv_config PRIMARY KEY(`emv_config_id`)
) COMMENT 'EMV chip configuration master for card instruments — stores EMV application identifiers (AIDs), application version numbers, terminal action codes (TAC), issuer action codes (IAC), cryptogram types (ARQC, TC, AAC), offline data authentication method (SDA, DDA, CDA), risk management parameters, and chip personalization profile references. Governs how EMV chip transactions are processed at POS terminals per EMVCo specifications.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`token` (
    `token_id` BIGINT COMMENT 'Unique system-generated identifier for the token record.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Token usage analytics and fraud detection depend on linking each token to the cardholder profile that generated it.',
    `fpan_holder_cardholder_profile_id` BIGINT COMMENT 'Government or internal identifier of the PAN holder (e.g., SSN, national ID).',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Tokens are generated for a specific payment product; linking enables token lifecycle management and compliance tracking.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: REQUIRED: Token‑scheme mapping is required for token‑registry reporting and scheme‑specific risk analytics.',
    `token_requestor_id` BIGINT COMMENT 'Identifier of the party (e.g., merchant, app) that requested token creation.',
    `assurance_level` STRING COMMENT 'Risk/verification level assigned to the token (e.g., based on KYC/AML checks).. Valid values are `LOW|MEDIUM|HIGH`',
    `device_binding_reference` STRING COMMENT 'Reference to the device (e.g., device ID) to which the token is bound.',
    `expiry_date` DATE COMMENT 'Date after which the token is no longer valid.',
    `fpan_account_type` STRING COMMENT 'Type of account linked to the Funding PAN.. Valid values are `CHECKING|SAVINGS|CREDIT|DEBIT|PREPAID`',
    `fpan_currency` STRING COMMENT 'Currency code of the underlying Funding PAN.',
    `fpan_expiry` DATE COMMENT 'Expiration date of the underlying Funding PAN.',
    `fpan_hash` STRING COMMENT 'Secure hash of the underlying Funding PAN stored for verification.',
    `fpan_holder_name` STRING COMMENT 'Legal name of the individual or entity that owns the Funding PAN.',
    `fpan_issuer` STRING COMMENT 'Bank or institution that issued the underlying Funding PAN.',
    `fpan_last4` STRING COMMENT 'Last four digits of the underlying Funding PAN for reference and reconciliation.',
    `fpan_network` STRING COMMENT 'Payment network (e.g., Visa, Mastercard) of the underlying Funding PAN.',
    `fpan_tokenization_algorithm` STRING COMMENT 'Cryptographic algorithm used for token generation.',
    `fpan_tokenization_compliance` STRING COMMENT 'Compliance standards satisfied (e.g., PCI DSS, EMVCo).',
    `fpan_tokenization_key_reference` STRING COMMENT 'Identifier of the cryptographic key used in tokenization.',
    `fpan_tokenization_key_version` STRING COMMENT 'Version of the cryptographic key used.',
    `fpan_tokenization_method` STRING COMMENT 'Method used to tokenize the Funding PAN (e.g., EMVCo, PCI DSS, proprietary).',
    `fpan_tokenization_notes` STRING COMMENT 'Free‑form notes about the tokenization process or exceptions.',
    `fpan_tokenization_status` STRING COMMENT 'Result of the tokenization process.. Valid values are `SUCCESS|FAILED|PENDING`',
    `fpan_tokenization_timestamp` TIMESTAMP COMMENT 'Timestamp when the Funding PAN was tokenized.',
    `issue_date` DATE COMMENT 'Date the token was provisioned and became active.',
    `last_used_location` STRING COMMENT 'Geographic location (city, country code) of the most recent token use.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction where the token was presented.',
    `provisioning_channel` STRING COMMENT 'Channel through which the token was provisioned.. Valid values are `NFC|IN_APP|E_COMMERCE|API`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the token record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the token record.',
    `scheme` STRING COMMENT 'Payment network or scheme associated with the token.. Valid values are `VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|OTHER`',
    `service_provider` STRING COMMENT 'Entity that performed the tokenization service.',
    `token_status` STRING COMMENT 'Current lifecycle state of the token.. Valid values are `ACTIVE|INACTIVE|SUSPENDED|REVOKED|EXPIRED`',
    `token_type` STRING COMMENT 'Classification of the token based on its generation method: Device Primary Account Number (DPAN), Host Card Emulation (HCE), or cloud‑based token.. Valid values are `DPAN|HCE|CLOUD`',
    `token_value` DECIMAL(18,2) COMMENT 'Alphanumeric token string that replaces the underlying PAN for transactions.',
    `usage_count` BIGINT COMMENT 'Cumulative number of successful transactions using the token.',
    `wallet_provider` STRING COMMENT 'Name of the digital wallet platform (e.g., Apple Pay, Google Pay) that holds the token.',
    CONSTRAINT pk_token PRIMARY KEY(`token_id`)
) COMMENT 'Payment token master record representing a DPAN (Device Primary Account Number) or network token mapped to an underlying FPAN (Funding PAN). Stores token value, token type (DPAN, HCE, cloud-based), token requestor ID, token service provider (TSP), token status, token expiry, device binding reference, wallet provider, provisioning channel (NFC, in-app, e-commerce), and assurance level. Supports PCI DSS tokenization and EMVCo token framework compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` (
    `token_lifecycle_event_id` BIGINT COMMENT 'Surrogate primary key for the token lifecycle event record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet instance associated with the token.',
    `token_id` BIGINT COMMENT 'Unique token value assigned to the payment instrument.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was first created in the data store.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this event record.',
    `channel` STRING COMMENT 'Channel through which the event was triggered.. Valid values are `online|mobile_app|pos|nfc|qr`',
    `compliance_check_code` STRING COMMENT 'Code representing the specific compliance rule evaluated.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the token passed compliance checks at the time of the event.',
    `device_reference` STRING COMMENT 'Identifier of the device involved in the event, such as a POS terminal or mobile device.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the token lifecycle event occurred.',
    `event_type` STRING COMMENT 'Category of the lifecycle event for the token.. Valid values are `provisioning|activation|suspension|resumption|deletion|expiry`',
    `initiating_actor` STRING COMMENT 'Entity that initiated the token lifecycle event.. Valid values are `cardholder|wallet_provider|issuer|tsp`',
    `ip_address` STRING COMMENT 'IP address from which the event originated.',
    `is_restricted_token` BOOLEAN COMMENT 'Flag indicating whether the token is subject to additional restrictions (e.g., high-value transactions).',
    `is_test_token` BOOLEAN COMMENT 'Flag indicating whether the token is used for testing purposes.',
    `location_city` STRING COMMENT 'City name of the event location.',
    `location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the event location. [ENUM-REF-CANDIDATE: list of country codes — promote to reference product]',
    `new_status` STRING COMMENT 'Status of the token after the event.. Valid values are `inactive|active|suspended|expired|deleted|pending`',
    `notes` STRING COMMENT 'Free-form notes or comments associated with the event.',
    `previous_status` STRING COMMENT 'Status of the token before the event.. Valid values are `inactive|active|suspended|expired|deleted|pending`',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the event.',
    `source_system` STRING COMMENT 'Originating system that recorded the event.. Valid values are `digital_wallet_platform|gateway|fraud_system`',
    `token_activation_date` DATE COMMENT 'Date when the token was initially activated.',
    `token_deletion_reason` STRING COMMENT 'Reason provided for token deletion, if applicable.',
    `token_expiry_date` DATE COMMENT 'Date when the token is set to expire.',
    `token_scheme` STRING COMMENT 'Tokenization scheme or standard applied to the token.. Valid values are `EMV|PCI|Visa|Mastercard`',
    `token_suspension_reason` STRING COMMENT 'Reason provided for token suspension, if applicable.',
    `token_type` STRING COMMENT 'Type of token representing the underlying payment instrument.. Valid values are `DPAN|virtual_card|mobile_token|contactless`',
    `token_version` STRING COMMENT 'Version number of the token record, incremented on each lifecycle change.',
    CONSTRAINT pk_token_lifecycle_event PRIMARY KEY(`token_lifecycle_event_id`)
) COMMENT 'Transactional record capturing every state transition in a payment tokens lifecycle — provisioning, activation, suspension, resumption, deletion, and expiry. Stores event type, event timestamp, initiating actor (cardholder, wallet provider, issuer, TSP), previous status, new status, reason code, device reference, and channel. Provides full audit trail for token lifecycle management per EMVCo and PCI DSS requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`ach_account` (
    `ach_account_id` BIGINT COMMENT 'System-generated unique identifier for the ACH account record.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: ACH account can be used as a funding source for a wallet; linking enables wallet‑level aggregation.',
    `account_number_masked` STRING COMMENT 'Account number stored in masked form (first six digits hidden, last four visible) for security.. Valid values are `^*{6}d{4}$`',
    `account_type` STRING COMMENT 'Category of the ACH account based on its usage and ownership.. Valid values are `checking|savings|corporate|government|loan`',
    `ach_account_status` STRING COMMENT 'Current operational status of the ACH account.. Valid values are `active|inactive|closed|suspended|pending`',
    `address_line1` STRING COMMENT 'First line of the banks physical address.',
    `address_line2` STRING COMMENT 'Second line of the banks physical address (optional).',
    `authorization_type` STRING COMMENT 'Standard ACH entry class code indicating the purpose of the transaction.. Valid values are `PPD|CCD|WEB|TEL`',
    `balance` DECIMAL(18,2) COMMENT 'Current monetary balance associated with the ACH account (if tracked).',
    `bank_name` STRING COMMENT 'Legal name of the financial institution that holds the ACH account.',
    `city` STRING COMMENT 'City component of the banks address.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the ACH account.. Valid values are `compliant|non_compliant|pending_review`',
    `country` STRING COMMENT 'Three‑letter ISO country code for the banks location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the ACH account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the account (e.g., USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the ACH account became effective for transactions.',
    `expiration_date` DATE COMMENT 'Date when the ACH account is scheduled to be closed or become inactive (nullable).',
    `holder_id_number` STRING COMMENT 'Government‑issued or tax identifier for the account holder (e.g., SSN, EIN).',
    `holder_name` STRING COMMENT 'Legal name of the individual or organization that owns the ACH account.',
    `holder_type` STRING COMMENT 'Indicates whether the account holder is an individual person or a business entity.. Valid values are `individual|business`',
    `is_ach_enabled` BOOLEAN COMMENT 'Indicates whether ACH transactions are currently permitted for this account.',
    `last_verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful verification of the ACH account.',
    `micro_deposit_amount` DECIMAL(18,2) COMMENT 'Amount of the micro‑deposit used for account verification (if applicable).',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the banks address.. Valid values are `^d{5}(-d{4})?$`',
    `prenote_status` STRING COMMENT 'State of the prenote verification process for the ACH account.. Valid values are `not_prenoted|prenoted|failed`',
    `routing_number` STRING COMMENT '9‑digit routing number identifying the financial institution that holds the ACH account.. Valid values are `^d{9}$`',
    `state` STRING COMMENT 'State or province component of the banks address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the ACH account record.',
    `verification_method` STRING COMMENT 'Method used to verify ownership of the ACH account.. Valid values are `micro_deposit|instant|none`',
    `verification_status` STRING COMMENT 'Current verification state of the ACH account.. Valid values are `verified|unverified|failed`',
    CONSTRAINT pk_ach_account PRIMARY KEY(`ach_account_id`)
) COMMENT 'ACH bank account credential master for electronic fund transfer instruments. Stores account holder name, routing number (ABA), account number (masked), account type (checking, savings, corporate), bank name, account status, prenote status, verification method (micro-deposit, instant verification), and ACH authorization type (PPD, CCD, WEB, TEL). SSOT for ACH instrument credentials used in A2A transfers, payroll, and bill payment rails.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`upi` (
    `upi_id` BIGINT COMMENT 'System-generated unique identifier for the UPI virtual payment address record.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: UPI virtual address is owned by a wallet; linking provides direct wallet context.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the PSP that hosts or processes the UPI address.',
    `linked_account_id` BIGINT COMMENT 'Reference to the bank account that funds are drawn from or credited to for this VPA.',
    `linked_linked_account_id` BIGINT COMMENT 'Reference to the bank account that funds are drawn from or credited to for this VPA.',
    `partner_profile_id` BIGINT COMMENT 'Identifier of the PSP that hosts or processes the UPI address.',
    `aml_check_status` STRING COMMENT 'Result of AML screening performed on the VPA holder.. Valid values are `not_started|passed|failed|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this UPI record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for limits and settlements.. Valid values are `USD|EUR|INR|GBP|JPY|AUD`',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate value of transactions allowed per calendar day for this VPA.',
    `device_binding_reference` BIGINT COMMENT 'Reference to the device (e.g., mobile phone) bound to the VPA for authentication.',
    `failed_auth_attempts` STRING COMMENT 'Count of consecutive failed authentication attempts since the last successful login.',
    `kyc_status` STRING COMMENT 'Current state of KYC verification for the VPA holder.. Valid values are `not_started|in_progress|completed|failed`',
    `last_successful_auth_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful authentication (e.g., PIN entry, biometric) for the VPA.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this UPI record.',
    `max_failed_attempts` STRING COMMENT 'Configured threshold after which the VPA is locked pending reset.',
    `monthly_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate value of transactions allowed per calendar month for this VPA.',
    `nfc_enabled` BOOLEAN COMMENT 'Indicates whether NFC‑based tap‑to‑pay is enabled for this VPA.',
    `pin_set` BOOLEAN COMMENT 'Indicates whether the user has configured a UPI PIN for authorising transactions.',
    `privacy_consent_given` BOOLEAN COMMENT 'Indicates whether the VPA holder has consented to data processing under GDPR/CCPA.',
    `registration_status` STRING COMMENT 'Current lifecycle state of the VPA registration process.. Valid values are `pending|registered|rejected|suspended`',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the VPA was initially registered.',
    `sanction_check_status` STRING COMMENT 'Outcome of sanctions list screening for the VPA holder.. Valid values are `not_started|passed|failed|exempt`',
    `source_channel` STRING COMMENT 'Origin channel through which the VPA was registered.. Valid values are `mobile_app|web|api|pos`',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current registration or verification status.',
    `tokenization_status` STRING COMMENT 'State of tokenization for the VPAs underlying payment credentials.. Valid values are `not_tokenized|tokenized|failed`',
    `verification_status` STRING COMMENT 'Result of the VPA verification (e.g., OTP, micro‑deposit) process.. Valid values are `unverified|verified|failed`',
    `vpa` STRING COMMENT 'The UPI ID in the format address@bank, used for peer-to-peer and peer-to-merchant payments.',
    `vpa_type` STRING COMMENT 'Indicates whether the VPA is for a personal or business entity.. Valid values are `personal|business`',
    CONSTRAINT pk_upi PRIMARY KEY(`upi_id`)
) COMMENT 'UPI (Unified Payments Interface) virtual payment address (VPA) master record. Stores UPI ID (VPA string), linked bank account reference, PSP handle, registration status, verification status, daily transaction limit, monthly transaction limit, UPI PIN set flag, device binding reference, and registration timestamp. Supports P2P and P2M UPI payment flows per NPCI UPI specifications.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` (
    `alt_payment_method_id` BIGINT COMMENT 'System‑generated unique identifier for each alternative payment method record.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Alternative payment method is attached to a wallet; replace virtual_wallet_id with proper FK to digital_wallet.',
    `alt_payment_method_description` STRING COMMENT 'Free‑form description of the payment method and its use cases.',
    `alt_payment_method_status` STRING COMMENT 'Current operational status of the payment method.. Valid values are `active|inactive|suspended|pending|closed`',
    `aml_check_status` STRING COMMENT 'Result of the most recent Anti‑Money‑Laundering screening.. Valid values are `passed|failed|pending`',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status (e.g., PCI DSS, AML).',
    `contactless_type` STRING COMMENT 'Technology used for contactless interaction.. Valid values are `nfc|qr|bluetooth|none`',
    `country_of_issuance` STRING COMMENT 'Country where the alternative payment method was issued or registered.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment method record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the payment method.. Valid values are `^[A-Z]{3}$`',
    `daily_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cumulative amount allowed in a calendar day.',
    `effective_from` DATE COMMENT 'Date when the payment method becomes active for transactions.',
    `effective_until` DATE COMMENT 'Date when the payment method expires or is de‑activated (null if open‑ended).',
    `external_account_reference` STRING COMMENT 'Identifier assigned by the external provider for the linked account or wallet.',
    `fee_fixed_amount` DECIMAL(18,2) COMMENT 'Flat fee charged per transaction, expressed in the methods currency.',
    `fee_percentage` DECIMAL(18,2) COMMENT 'Percentage fee applied to each transaction using this method.',
    `is_contactless` BOOLEAN COMMENT 'True if the method supports contactless transactions (NFC, QR, etc.).',
    `is_tokenized` BOOLEAN COMMENT 'Indicates whether the payment method data is stored as a token.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether the method exists only in digital form (no physical token).',
    `kyc_status` STRING COMMENT 'Current KYC verification state of the payment method.. Valid values are `verified|unverified|pending`',
    `last_aml_check_timestamp` TIMESTAMP COMMENT 'When the last AML screening was performed.',
    `last_sanction_check_timestamp` TIMESTAMP COMMENT 'When the last sanctions screening was performed.',
    `method_code` STRING COMMENT 'Internal code used to uniquely reference the payment method within the platform.',
    `method_name` STRING COMMENT 'Human‑readable name of the payment method (e.g., "Buy Now Pay Later – 30 Days").',
    `method_type` STRING COMMENT 'Category of the alternative payment method.. Valid values are `bnpl|qr|voucher|crypto|open_banking|stored_value`',
    `monthly_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cumulative amount allowed in a calendar month.',
    `provider_name` STRING COMMENT 'Name of the external service provider offering the payment method.',
    `requires_kyc` BOOLEAN COMMENT 'True if the method requires Know‑Your‑Customer verification before activation.',
    `risk_category` STRING COMMENT 'Risk tier derived from the risk score.. Valid values are `low|medium|high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating assigned by the fraud platform (0‑100).',
    `sanction_check_status` STRING COMMENT 'Result of the most recent sanctions screening.. Valid values are `passed|failed|pending`',
    `supporting_documents` STRING COMMENT 'List of document types required for onboarding (e.g., "business_license, tax_id").',
    `tokenization_scheme` STRING COMMENT 'Standard used for tokenizing the payment method.. Valid values are `DPAN|HCE|PCI_P2PE`',
    `transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount allowed per single transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment method record.',
    `created_by` STRING COMMENT 'User or system that created the payment method record.',
    CONSTRAINT pk_alt_payment_method PRIMARY KEY(`alt_payment_method_id`)
) COMMENT 'Alternative payment method master covering non-card, non-ACH, non-UPI instruments — BNPL accounts, QR code payment handles, digital vouchers, cryptocurrency wallets, open banking payment initiation credentials, and stored value accounts. Stores method type, provider name, external account reference, currency, country of issuance, status, and applicable transaction limits. Enables the platform to support diverse global payment rails beyond traditional card networks.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` (
    `instrument_status_history_id` BIGINT COMMENT 'Unique surrogate identifier for each status change event of a payment instrument.',
    `payment_instrument_id` BIGINT COMMENT 'Unique identifier of the payment instrument (card, token, digital wallet) whose status transition is recorded.',
    `change_reason_code` STRING COMMENT 'Code describing why the status change was triggered (e.g., fraud_alert, KYC_failure, customer_request).',
    `change_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the status transition occurred in the source system.',
    `event_type` STRING COMMENT 'High‑level classification of the status change event.. Valid values are `status_change|suspension|reactivation|cancellation|expiry|lost_theft`',
    `initiating_actor` STRING COMMENT 'Entity or system that initiated the status change.. Valid values are `cardholder|issuer|fraud_system|compliance|system_admin`',
    `is_manual_change` BOOLEAN COMMENT 'True if a human operator performed the change; false for automated system actions.',
    `new_status` STRING COMMENT 'The status of the instrument after the change event.. Valid values are `active|suspended|inactive|expired|cancelled|lost_theft`',
    `notes` STRING COMMENT 'Optional free‑text comments providing additional context for the status transition.',
    `previous_status` STRING COMMENT 'The status of the instrument before the change event.. Valid values are `active|suspended|inactive|expired|cancelled|lost_theft`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this history record was first inserted into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this history record.',
    `source_system` STRING COMMENT 'Name of the operational system that generated the status change event.. Valid values are `digital_wallet|payment_gateway|fraud_platform|risk_compliance`',
    `supporting_reference` STRING COMMENT 'Identifier of the related case, dispute, compliance event, or other artifact that justified the status change.',
    CONSTRAINT pk_instrument_status_history PRIMARY KEY(`instrument_status_history_id`)
) COMMENT 'Audit history table recording every status change for a payment instrument throughout its lifecycle — activation, suspension, reactivation, expiry, cancellation, loss/theft reporting, and replacement. Stores previous status, new status, change timestamp, change reason code, initiating actor (cardholder, issuer, fraud system, compliance), and supporting reference (case ID, dispute ID, compliance event ID). Enables full lifecycle traceability for regulatory and fraud investigations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` (
    `card_personalization_id` BIGINT COMMENT 'Unique surrogate key for each card personalization specification record.',
    `card_id` BIGINT COMMENT 'Foreign key linking to terminal.card. Business justification: Personalization specifications apply to a specific card; adding card_id creates proper parent‑child relationship and allows removal of duplicated card attributes stored in personalization.',
    `card_program_id` BIGINT COMMENT 'Identifier of the card program to which this personalization belongs.',
    `card_art_template_code` BIGINT COMMENT 'Reference to the graphic template used for card front design.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the personalization record was first created.',
    `cvv_cvc_generation_method` STRING COMMENT 'Method used to generate the card verification value.. Valid values are `algorithmic|random|issuer_defined`',
    `cvv_cvc_key` STRING COMMENT 'Secret key material for CVV generation; PCI‑DSS protected.',
    `effective_date` DATE COMMENT 'Date when the personalization specification becomes active.',
    `expiration_date` DATE COMMENT 'Date after which the personalization specification is retired.',
    `personalization_batch_number` STRING COMMENT 'External batch identifier assigned by the personalization bureau.',
    `personalization_bureau_reference` STRING COMMENT 'External reference number supplied by the card personalization bureau.',
    `personalization_name` STRING COMMENT 'Human‑readable name identifying the personalization profile.',
    `personalization_status` STRING COMMENT 'Current lifecycle state of the personalization record.. Valid values are `pending|in_progress|completed|failed`',
    `personalization_type` STRING COMMENT 'Category of personalization workflow (e.g., standard, instant issuance, virtual, tokenized).. Valid values are `standard|instant|virtual|tokenized`',
    `pin_offset` STRING COMMENT 'Derived value used by the chip to validate the cardholder PIN; PCI‑DSS protected.',
    `risk_score` STRING COMMENT 'Numeric risk rating assigned during personalization based on fraud models.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the personalization record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_card_personalization PRIMARY KEY(`card_personalization_id`)
) COMMENT 'Card personalization specification record defining the data elements written to a card during manufacturing and personalization — embossed name format, magnetic stripe track data layout, EMV chip data elements, PIN offset, CVV/CVC generation parameters, card art template, and personalization bureau reference. Links card programs to their physical or virtual personalization profiles. Critical for card manufacturing and instant issuance workflows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`pin_management` (
    `pin_management_id` BIGINT COMMENT 'Unique surrogate key for each PIN lifecycle record.',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the card or token to which this PIN applies.',
    `hsm_key_reference` STRING COMMENT 'Identifier of the HSM key used to encrypt/decrypt the PIN block.',
    `pin_block_format` STRING COMMENT 'Format used to encrypt the PIN as defined by ISO 9564.. Valid values are `iso_9564_1|iso_9564_2|custom`',
    `pin_blocked_flag` BOOLEAN COMMENT 'Indicates whether the PIN is currently blocked due to exceeded attempts.',
    `pin_blocked_timestamp` TIMESTAMP COMMENT 'Date and time when the PIN became blocked.',
    `pin_change_count` STRING COMMENT 'Total number of times the PIN has been changed since creation.',
    `pin_compliance_status` STRING COMMENT 'Compliance assessment of the PIN against PCI and regulatory rules.. Valid values are `compliant|non_compliant|exception`',
    `pin_encryption_algorithm` STRING COMMENT 'Cryptographic algorithm used to protect the PIN block.. Valid values are `tdes|aes|rsa`',
    `pin_failed_attempts` STRING COMMENT 'Count of consecutive failed PIN entry attempts since last successful entry.',
    `pin_label` STRING COMMENT 'Human‑readable label for the PIN (e.g., "Primary PIN").',
    `pin_last_changed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent successful PIN change.',
    `pin_last_failed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent failed PIN entry.',
    `pin_last_successful_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent successful PIN entry.',
    `pin_reset_method` STRING COMMENT 'Channel used to reset the PIN.. Valid values are `ivr|online|branch|atm`',
    `pin_reset_timestamp` TIMESTAMP COMMENT 'Date and time when the PIN was last reset.',
    `pin_set_timestamp` TIMESTAMP COMMENT 'Date and time when the PIN was initially set for the instrument.',
    `pin_status` STRING COMMENT 'Current lifecycle state of the PIN.. Valid values are `active|blocked|reset_pending|expired`',
    `pin_tries_remaining` STRING COMMENT 'Number of remaining allowed PIN entry attempts before the PIN is blocked.',
    `pin_type` STRING COMMENT 'Classification of the PIN based on its usage scenario.. Valid values are `primary|secondary|virtual`',
    `pin_version` STRING COMMENT 'Version number of the PIN record for optimistic concurrency control.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PIN management record was first created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PIN management record.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_pin_management PRIMARY KEY(`pin_management_id`)
) COMMENT 'PIN (Personal Identification Number) management record for card instruments — stores PIN set status, PIN change history count, PIN block format (ISO 9564), HSM key reference, PIN tries remaining, PIN blocked flag, PIN blocked timestamp, and PIN reset method (IVR, online, branch). Does NOT store the PIN value itself — only metadata for PIN lifecycle management per PCI PIN Security Requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` (
    `credential_vault_id` BIGINT COMMENT 'Unique system-generated identifier for each credential vault entry.',
    `payment_instrument_id` BIGINT COMMENT 'Foreign key linking to wallet.payment_instrument. Business justification: Credential vault stores credentials for a payment instrument; linking enforces one‑to‑many relationship.',
    `token_pan_mapping_id` BIGINT COMMENT 'Identifier linking this vault entry to the tokenization mapping record.',
    `access_control_policy_reference` BIGINT COMMENT 'Reference to the policy governing who may read or modify this credential.',
    `audit_log_reference` STRING COMMENT 'Reference string to the detailed audit log entry for this credential.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the immutable audit log for this credential entry.',
    `business_identifier` STRING COMMENT 'External business reference code for the credential, e.g., merchant‑provided token ID.',
    `classification` STRING COMMENT 'Classification of the credential according to PCI standards.. Valid values are `PCI|PCI_DSS|PCI_P2PE|PCI_PIN`',
    `compliance_status` STRING COMMENT 'Current compliance posture of the credential with PCI DSS requirements.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the credential vault record was created.',
    `credential_status` STRING COMMENT 'Current lifecycle status of the credential entry.. Valid values are `active|inactive|revoked|compromised|pending`',
    `credential_type` STRING COMMENT 'Specifies the type of credential stored, such as PAN, CVV, token, or PIN.. Valid values are `pan|cvv|cvc|token|pin|account_number`',
    `credential_vault_description` STRING COMMENT 'Free‑form description or notes about the credential entry.',
    `cvv_vault_reference` STRING COMMENT 'Reference to the secure vault location where the CVV/CVC is stored.',
    `data_sensitivity_level` STRING COMMENT 'Organizational data classification for the credential record.. Valid values are `restricted|confidential|internal|public`',
    `encryption_algorithm` STRING COMMENT 'Algorithm used to encrypt the credential data.. Valid values are `AES-256|RSA-2048|SM4`',
    `encryption_key_reference` BIGINT COMMENT 'Reference to the HSM‑protected encryption key used to encrypt the credential data.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time after which the credential is considered expired and must not be used.',
    `hsm_module_reference` STRING COMMENT 'Identifier of the specific HSM module used for encryption.',
    `is_hsm_protected` BOOLEAN COMMENT 'Indicates whether the credential is stored in a Hardware Security Module.',
    `is_tokenized` BOOLEAN COMMENT 'Indicates whether the stored credential is a tokenized representation.',
    `key_expiry_timestamp` TIMESTAMP COMMENT 'Timestamp when the associated encryption key expires.',
    `key_management_service` STRING COMMENT 'Service responsible for managing encryption keys.. Valid values are `AWS_KMS|Azure_KeyVault|Google_KMS|OnPrem`',
    `key_rotation_interval_days` STRING COMMENT 'Configured interval in days for periodic key rotation.',
    `key_rotation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent key rotation for this credential.',
    `key_version` STRING COMMENT 'Version label of the encryption key for key‑rotation tracking.',
    `last_accessed_by` STRING COMMENT 'Identifier of the user or service that last accessed the credential.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent access to the credential data.',
    `owner_party_reference` BIGINT COMMENT 'Identifier of the party (merchant, cardholder, or partner) that owns the credential.',
    `pan_token_reference` STRING COMMENT 'Token that represents the Primary Account Number; actual PAN is never stored.',
    `region_code` STRING COMMENT 'Three‑letter ISO country code representing the geographic region of the credential.',
    `retention_period_days` STRING COMMENT 'Number of days the credential must be retained before mandatory deletion.',
    `tokenization_scheme` STRING COMMENT 'Standard or scheme used for tokenizing the credential.. Valid values are `PCI_DSS|EMV|3DS|DCC`',
    `updated_by` STRING COMMENT 'System user or process that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the credential vault record.',
    `vault_location` STRING COMMENT 'Logical location or container identifier within the secure vault where the credential reference is stored.',
    `version_number` STRING COMMENT 'Version counter for the credential record, incremented on each change.',
    `created_by` STRING COMMENT 'System user or process that created the credential vault entry.',
    CONSTRAINT pk_credential_vault PRIMARY KEY(`credential_vault_id`)
) COMMENT 'Secure credential storage registry for sensitive payment instrument data managed under PCI DSS controls — stores references to HSM-protected cryptographic keys, encrypted PAN storage pointers, CVV/CVC vault references, and tokenization mapping pointers. Does NOT store raw PANs or CVVs — stores vault location references, encryption key IDs, key rotation timestamps, and access control metadata. Provides the PCI DSS-compliant credential management layer for the instrument domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` (
    `instrument_limit_id` BIGINT COMMENT 'Unique surrogate key for each instrument limit configuration record.',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the payment instrument to which this limit applies.',
    `atm_withdrawal_limit` DECIMAL(18,2) COMMENT 'Maximum cash withdrawal amount allowed at ATMs for the instrument.',
    `compliance_check_passed` BOOLEAN COMMENT 'Result of the latest regulatory compliance validation for the limit configuration.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent compliance check was performed.',
    `contactless_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount for a single contactless (tap‑and‑go) transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which limits are expressed.. Valid values are `^[A-Z]{3}$`',
    `daily_spend_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate spend allowed for the instrument in a single calendar day.',
    `daily_spend_used_amount` DECIMAL(18,2) COMMENT 'Cumulative amount spent on the instrument today, used to compare against daily_spend_limit.',
    `ecommerce_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount for a single online purchase transaction.',
    `effective_end_date` DATE COMMENT 'Date on which the limit configuration expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the limit configuration becomes active.',
    `enforcement_mode` STRING COMMENT 'Mechanism by which the limit is applied: hard (transaction declined), soft (warning), or dynamic (adjusted by risk engine).. Valid values are `hard|soft|dynamic`',
    `fraud_reason_code` STRING COMMENT 'Code representing the reason for a fraud flag, aligned with internal fraud taxonomy.',
    `instrument_limit_status` STRING COMMENT 'Current lifecycle status of the limit configuration.. Valid values are `active|inactive|pending|suspended|retired`',
    `international_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount allowed for cross‑border transactions.',
    `is_fraud_flagged` BOOLEAN COMMENT 'Indicates whether the instrument has been flagged for fraud during limit evaluation.',
    `is_override_allowed` BOOLEAN COMMENT 'Indicates whether a merchant or cardholder can request a temporary limit increase.',
    `last_enforced_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction where this limit was evaluated.',
    `limit_group_code` STRING COMMENT 'Logical grouping identifier for related limit records (e.g., program‑wide, regional).',
    `limit_scope` STRING COMMENT 'Entity level at which the limit is applied: individual instrument, card program, cardholder, or merchant.. Valid values are `instrument|card_program|cardholder|merchant`',
    `limit_type` STRING COMMENT 'Category of the limit, indicating the transaction scenario it governs.. Valid values are `spending|withdrawal|international|contactless|ecommerce|atm`',
    `limit_version` STRING COMMENT 'Monotonically increasing version number for change‑control and audit.',
    `monthly_spend_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate spend allowed for the instrument in a calendar month.',
    `monthly_spend_used_amount` DECIMAL(18,2) COMMENT 'Cumulative amount spent on the instrument this month, used to compare against monthly_spend_limit.',
    `notes` STRING COMMENT 'Free‑form comments or operational notes about the limit configuration.',
    `override_reason` STRING COMMENT 'Free‑text explanation for why an override was granted or requested.',
    `per_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount permitted for a single transaction using the instrument.',
    `risk_score` STRING COMMENT 'Numeric risk assessment (0‑100) associated with the instrument at the time of limit definition.',
    `source_system` STRING COMMENT 'Originating system that created or last modified the limit configuration.. Valid values are `gateway|wallet|fraud_engine|settlement|compliance|admin`',
    `transaction_count_month` STRING COMMENT 'Number of transactions processed this month for the instrument.',
    `transaction_count_today` STRING COMMENT 'Number of transactions processed today for the instrument.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the limit record.',
    `created_by` STRING COMMENT 'User or system identifier that created the limit record.',
    CONSTRAINT pk_instrument_limit PRIMARY KEY(`instrument_limit_id`)
) COMMENT 'Transaction and velocity limit configuration for a payment instrument — stores daily spend limit, monthly spend limit, per-transaction limit, ATM withdrawal limit, international transaction limit, contactless transaction limit, and e-commerce transaction limit. Limits can be set at instrument level, card program level, or cardholder-requested level. Supports real-time authorization limit enforcement and risk-based limit adjustments.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` (
    `instrument_feature_id` BIGINT COMMENT 'Unique surrogate key for the instrument feature record.',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the payment instrument to which this feature applies.',
    `activation_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the feature was activated for the instrument.',
    `compliance_flags` STRING COMMENT 'Comma‑separated list of compliance flags applicable to this feature (e.g., PCI_DSS, PSD2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature record was initially created.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the feature was deactivated for the instrument.',
    `effective_from` DATE COMMENT 'Date when the feature becomes effective for the instrument.',
    `effective_until` DATE COMMENT 'Date when the feature expires or is scheduled to be deactivated; null if indefinite.',
    `feature_category` STRING COMMENT 'Broad category of the feature (e.g., contactless, international usage). [ENUM-REF-CANDIDATE: contactless|international|ecommerce|atm|recurring|3ds|dcc|bnpl — 8 candidates stripped; promote to reference product]',
    `feature_code` STRING COMMENT 'Unique code identifying the feature in the internal feature catalog.',
    `feature_name` STRING COMMENT 'Human‑readable name of the feature.',
    `instrument_feature_status` STRING COMMENT 'Current lifecycle status of the feature for the instrument.. Valid values are `enabled|disabled|pending`',
    `limit_amount` DECIMAL(18,2) COMMENT 'Monetary limit associated with the feature (e.g., per‑transaction or daily limit).',
    `limit_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the limit amount.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form notes regarding the feature configuration or special conditions.',
    `risk_score` STRING COMMENT 'Risk score assigned to the feature usage for this instrument.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this feature record.',
    `usage_counter` BIGINT COMMENT 'Number of times the feature has been used since activation.',
    `usage_reset_period` STRING COMMENT 'Period after which the usage_counter resets.. Valid values are `daily|weekly|monthly|yearly`',
    CONSTRAINT pk_instrument_feature PRIMARY KEY(`instrument_feature_id`)
) COMMENT 'Feature and capability enablement record for a payment instrument — tracks which features are enabled or disabled per instrument: contactless payments, international usage, e-commerce transactions, ATM access, recurring billing, 3DS enrollment, DCC opt-in/opt-out, and BNPL eligibility. Supports cardholder self-service feature management and issuer-controlled feature provisioning.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` (
    `card_replacement_id` BIGINT COMMENT 'System-generated unique identifier for the card replacement event.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder requesting the replacement.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder requesting the replacement.',
    `card_id` BIGINT COMMENT 'Identifier of the card being replaced.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the replacement card became active for transactions.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when the replacement card was actually delivered to the cardholder.',
    `card_replacement_status` STRING COMMENT 'Current lifecycle status of the replacement process.. Valid values are `requested|approved|delivered|activated|cancelled|rejected`',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the replacement request passed AML/KYC compliance checks.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance check was performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the replacement record was first created in the system.',
    `delivery_tracking_number` STRING COMMENT 'Carrier tracking identifier for the shipped replacement card.',
    `estimated_delivery_date` DATE COMMENT 'Projected date on which the replacement card will be delivered.',
    `fee_waiver_indicator` BOOLEAN COMMENT 'True if the replacement fee was waived for this request.',
    `fee_waiver_reason` STRING COMMENT 'Reason why the replacement fee was waived (e.g., promotional, dispute).',
    `fulfillment_method` STRING COMMENT 'Method used to deliver the replacement card to the cardholder.. Valid values are `mail|courier|in_branch|digital`',
    `is_replacement_card_contactless` BOOLEAN COMMENT 'Indicates whether the replacement card supports contactless transactions.',
    `is_replacement_card_hce_enabled` BOOLEAN COMMENT 'True if Host Card Emulation is enabled for the replacement card.',
    `is_replacement_card_nfc_enabled` BOOLEAN COMMENT 'True if NFC (tap‑to‑pay) is enabled on the replacement card.',
    `is_replacement_card_tokenized` BOOLEAN COMMENT 'True if the replacement card is issued as a token rather than a physical PAN.',
    `notes` STRING COMMENT 'Free‑form notes entered by agents or system regarding the replacement.',
    `replacement_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for the card replacement, if applicable.',
    `replacement_fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the replacement fee.',
    `replacement_reason_code` STRING COMMENT 'Code indicating why the card is being replaced (e.g., lost, stolen, damaged).. Valid values are `lost|stolen|damaged|expired|upgrade|other`',
    `replacement_reference_number` STRING COMMENT 'External reference number assigned to the replacement request for tracking and customer communication.',
    `request_channel` STRING COMMENT 'Channel through which the replacement request was submitted.. Valid values are `online|mobile_app|phone|branch|mail`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the replacement request was received.',
    `risk_score` STRING COMMENT 'Risk rating assigned to the replacement request based on fraud detection models.',
    `rush_delivery_flag` BOOLEAN COMMENT 'Indicates whether the replacement was expedited for faster delivery.',
    `token_service_provider` STRING COMMENT 'Entity providing tokenization services for the replacement card.. Valid values are `visa|mastercard|tsp`',
    `updated_by` STRING COMMENT 'System user or process that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the replacement record.',
    `created_by` STRING COMMENT 'System user or process that created the replacement record.',
    CONSTRAINT pk_card_replacement PRIMARY KEY(`card_replacement_id`)
) COMMENT 'Transactional record for card replacement events — covers lost/stolen replacements, damaged card replacements, expiry renewals, and upgrade replacements. Stores replacement reason code, original card reference, replacement card reference, request channel, request timestamp, fulfillment method, estimated delivery date, rush delivery flag, and replacement fee waiver indicator. Tracks the full replacement workflow from request to activation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` (
    `instrument_verification_id` BIGINT COMMENT 'Unique surrogate key for each instrument verification event record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (person) linked to the instrument.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (person) linked to the instrument.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the verification (if applicable).',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the payment instrument (card, token, bank account) that was verified.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the verification (if any).',
    `wallet_device_id` BIGINT COMMENT 'Unique identifier of the device used to perform the verification.',
    `attempt_number` STRING COMMENT 'Sequential number of the verification attempt for the same instrument.',
    `avs_response_code` STRING COMMENT 'Code returned by the Address Verification System (e.g., Y, N, A).',
    `biometric_match_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0‑100) for biometric verification.',
    `compliance_pci_dss` BOOLEAN COMMENT 'Indicates whether the verification process adheres to PCI DSS requirements.',
    `compliance_psd2_sca` BOOLEAN COMMENT 'Indicates whether the verification satisfies Strong Customer Authentication requirements under PSD2.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the verification record was first created in the system.',
    `cvv_response_code` STRING COMMENT 'Code indicating result of CVV/CVC check (e.g., M, N, P).',
    `expiration_timestamp` TIMESTAMP COMMENT 'Time after which the verification request is considered expired.',
    `fraud_reason_code` STRING COMMENT 'Code describing the reason for fraud flagging (e.g., high_risk_score, mismatched_address).',
    `ip_address` STRING COMMENT 'Source IP address from which the verification request originated.',
    `is_fraud_flagged` BOOLEAN COMMENT 'Indicates whether the verification triggered a fraud alert.',
    `location_country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 country code of the requestors location.',
    `max_attempts_allowed` STRING COMMENT 'Configured maximum number of verification attempts before lockout.',
    `micro_deposit_amount` DECIMAL(18,2) COMMENT 'Amount of the micro‑deposit used for ACH account verification.',
    `micro_deposit_status` STRING COMMENT 'Current status of the micro‑deposit verification process.. Valid values are `pending|completed|failed`',
    `notes` STRING COMMENT 'Free‑form notes or comments added by operators or automated systems.',
    `processing_status` STRING COMMENT 'Current processing state of the verification record.. Valid values are `pending|completed|error|rejected`',
    `risk_score_at_verification` DECIMAL(18,2) COMMENT 'Fraud risk score assigned to the instrument at the moment of verification (0‑100 scale).',
    `source_system` STRING COMMENT 'Name of the upstream system that generated the verification event.',
    `three_ds_authentication_status` STRING COMMENT 'Result of 3‑Domain Secure authentication flow.. Valid values are `authenticated|challenge_required|failed|not_applicable`',
    `tokenization_status` STRING COMMENT 'Current tokenization state of the instrument after verification.. Valid values are `tokenized|not_tokenized|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the verification record.',
    `user_agent` STRING COMMENT 'User‑agent string of the client application initiating verification.',
    `verification_channel` STRING COMMENT 'Interface or channel through which the verification was initiated.. Valid values are `online|pos|mobile_app|api|call_center`',
    `verification_method_detail` STRING COMMENT 'Free‑text description of the method or technology used for verification (e.g., HCE, NFC, OTP).',
    `verification_result` STRING COMMENT 'Outcome of the verification: pass, fail, or partial (e.g., address matched but CVV did not).. Valid values are `pass|fail|partial`',
    `verification_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the verification attempt occurred.',
    `verification_type` STRING COMMENT 'Category of verification performed (e.g., Address Verification System, Card Verification Value, 3‑DS, Biometric, Micro‑Deposit, Tokenization).. Valid values are `avs|cvv|3ds|biometric|micro_deposit|tokenization`',
    CONSTRAINT pk_instrument_verification PRIMARY KEY(`instrument_verification_id`)
) COMMENT 'Verification event record for payment instrument authentication checks — AVS (Address Verification System), CVV/CVC verification, 3DS authentication, biometric verification, and micro-deposit verification for ACH accounts. Stores verification type, verification timestamp, verification result (pass/fail/partial), verification channel, risk score at time of verification, and verification method details. Supports fraud prevention and SCA compliance under PSD2.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` (
    `instrument_block_id` BIGINT COMMENT 'Unique surrogate identifier for each instrument block record.',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the payment instrument (card, token, etc.) to which the block applies.',
    `affected_transaction_types` STRING COMMENT 'Comma‑separated list of transaction types that the block restricts.. Valid values are `purchase|cash_advance|refund|transfer|settlement|authorization`',
    `block_amount_limit` DECIMAL(18,2) COMMENT 'Monetary ceiling that may still be processed under the block (e.g., limit for low‑value transactions).',
    `block_category` STRING COMMENT 'High‑level grouping of the block used for reporting and analytics.. Valid values are `spending|withdrawal|online|offline|cross_border|contactless`',
    `block_reason` STRING COMMENT 'Human‑readable description of the reason for the block.',
    `block_reference` STRING COMMENT 'External reference number or code assigned to the block for audit and lookup.',
    `block_type` STRING COMMENT 'Category indicating why the instrument is blocked.. Valid values are `fraud|compliance|cardholder|issuer|regulatory|system`',
    `blocking_authority` STRING COMMENT 'Source system or party that initiated the block.. Valid values are `fraud_system|compliance|cardholder|issuer|regulatory|system`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the block record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter currency code associated with block_amount_limit.. Valid values are `^[A-Z]{3}$`',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the block expires or is lifted; null if indefinite.',
    `instrument_block_status` STRING COMMENT 'Operational status of the block record.. Valid values are `active|inactive|pending|expired|revoked`',
    `is_cardholder_requested` BOOLEAN COMMENT 'True if the block was requested directly by the cardholder (e.g., travel block).',
    `is_compliance_triggered` BOOLEAN COMMENT 'True if the block was generated to satisfy regulatory or AML requirements.',
    `is_fraud_triggered` BOOLEAN COMMENT 'True if the block was generated by the fraud detection engine.',
    `is_issuer_requested` BOOLEAN COMMENT 'True if the issuing bank placed the block.',
    `is_temporary` BOOLEAN COMMENT 'True if the block is intended to be temporary (has an end timestamp).',
    `mcc_restriction_list` STRING COMMENT 'Comma‑separated list of MCC codes that are blocked for this instrument.',
    `notes` STRING COMMENT 'Additional context, comments, or audit information related to the block.',
    `regulatory_hold` BOOLEAN COMMENT 'True if the block is due to a regulatory or sanctions requirement.',
    `source_system` STRING COMMENT 'Name of the operational system that originated the block (e.g., Fraud Detection Platform).',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the block starts to apply.',
    `updated_by` STRING COMMENT 'Identifier of the user or service that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the block record.',
    `created_by` STRING COMMENT 'Identifier of the user or service that initially created the block.',
    CONSTRAINT pk_instrument_block PRIMARY KEY(`instrument_block_id`)
) COMMENT 'Instrument blocking and restriction record capturing active blocks placed on a payment instrument — fraud-triggered blocks, compliance-triggered blocks, cardholder-requested blocks (travel, merchant category), and regulatory holds. Stores block type, block reason, blocking authority (fraud system, compliance, cardholder, issuer), block start timestamp, block end timestamp, affected transaction types, and MCC restriction list. Enables granular instrument-level controls beyond simple status flags.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`secure_element` (
    `secure_element_id` BIGINT COMMENT 'Unique system-generated identifier for each secure element record.',
    `wallet_device_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_device. Business justification: Secure element is provisioned to a specific wallet device; linking reflects the ownership relationship.',
    `compliance_emvco` BOOLEAN COMMENT 'True if the secure element complies with EMVCo standards.',
    `compliance_pci_dss` BOOLEAN COMMENT 'True if the secure element configuration meets PCI DSS requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the secure element record was first created.',
    `cross_border_supported` BOOLEAN COMMENT 'True if the secure element can be used for cross‑border transactions.',
    `cryptographic_key_set_reference` STRING COMMENT 'Reference identifier for the set of cryptographic keys associated with the secure element.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for transaction limits.',
    `decommission_timestamp` TIMESTAMP COMMENT 'Date‑time when the secure element was retired or decommissioned.',
    `device_identifier` STRING COMMENT 'Unique identifier of the mobile device hosting the secure element (e.g., IMEI).',
    `dynamic_currency_conversion_supported` BOOLEAN COMMENT 'True if the secure element supports Dynamic Currency Conversion.',
    `firmware_version` STRING COMMENT 'Version of the firmware running on the secure element.',
    `hce_enabled` BOOLEAN COMMENT 'True if the secure element is provisioned for Host Card Emulation.',
    `is_test_se` BOOLEAN COMMENT 'True if the record represents a test or sandbox secure element.',
    `key_set_expiry` DATE COMMENT 'Date on which the current key set expires and must be rotated.',
    `key_set_version` STRING COMMENT 'Version label of the cryptographic key set.',
    `last_provisioned_by` STRING COMMENT 'Identifier of the user or system that performed the last provisioning action.',
    `last_provisioned_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent provisioning event.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle stage of the secure element.. Valid values are `created|provisioned|active|decommissioned|failed`',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit for a single transaction processed via this secure element.',
    `nfc_capable` BOOLEAN COMMENT 'Indicates whether the device supports Near‑Field Communication for contactless payments.',
    `os_version` STRING COMMENT 'Version of the host operating system that interacts with the secure element.',
    `provisioning_status` STRING COMMENT 'Current status of the secure element provisioning workflow.. Valid values are `pending|provisioned|failed|deprovisioned`',
    `provisioning_timestamp` TIMESTAMP COMMENT 'Date‑time when the secure element was last provisioned.',
    `risk_score` STRING COMMENT 'Numerical risk rating (0‑100) assigned to the secure element based on security posture.',
    `se_manufacturer` STRING COMMENT 'Name of the vendor that produced the secure element hardware.',
    `se_model` STRING COMMENT 'Model identifier of the secure element hardware.',
    `se_serial_number` STRING COMMENT 'Factory‑assigned serial number of the secure element.',
    `se_type` STRING COMMENT 'Classification of the secure element technology: embedded, SIM‑based, or cloud‑hosted HCE.. Valid values are `embedded|sim|cloud_hce`',
    `secure_element_status` STRING COMMENT 'Current operational status of the secure element.. Valid values are `active|inactive|suspended|retired`',
    `security_level` STRING COMMENT 'Overall security classification of the secure element based on protection mechanisms.. Valid values are `low|medium|high`',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether the secure element can store tokenized payment credentials.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the secure element record.',
    `wallet_provider` STRING COMMENT 'Name of the digital‑wallet provider that owns the secure element.',
    CONSTRAINT pk_secure_element PRIMARY KEY(`secure_element_id`)
) COMMENT 'Secure element (SE) and HCE (Host Card Emulation) provisioning record for NFC-enabled mobile payment instruments. Stores SE type (embedded SE, SIM-based SE, cloud HCE), device identifier, SE application identifier, provisioning status, provisioning timestamp, wallet provider, NFC capability flag, and cryptographic key set reference. Manages the hardware and software security modules that store payment credentials on mobile devices per EMVCo and GlobalPlatform standards.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` (
    `instrument_expiry_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each expiry schedule entry.',
    `payment_instrument_id` BIGINT COMMENT 'Unique identifier of the payment instrument (card, token, etc.) whose expiry is being tracked.',
    `auto_renewal_flag` BOOLEAN COMMENT 'True when the system should automatically issue a replacement before expiry.',
    `block_reason_code` STRING COMMENT 'Standardized reason for instrument blockage.',
    `compliance_check_code` STRING COMMENT 'Standardized code indicating the specific compliance rule evaluated.',
    `compliance_check_passed` BOOLEAN COMMENT 'True if the instrument satisfied all regulatory checks (PCI DSS, AML, etc.) at schedule creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule record was first created.',
    `expiry_date` DATE COMMENT 'Calendar date on which the payment instrument expires.',
    `instrument_expiry_schedule_status` STRING COMMENT 'Operational status of the expiry schedule entry.. Valid values are `active|inactive|suspended|closed`',
    `instrument_type` STRING COMMENT 'Category of the payment instrument (e.g., physical card, digital wallet token).. Valid values are `card|digital_wallet|token|virtual_card`',
    `is_blocked` BOOLEAN COMMENT 'True when the instrument is blocked for fraud or compliance reasons.',
    `last_renewal_attempt_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest attempt to renew the instrument.',
    `next_action_due_date` DATE COMMENT 'Target date for the next scheduled activity related to the instrument.',
    `notes` STRING COMMENT 'Additional comments or observations about the expiry schedule.',
    `notification_sent_flag` BOOLEAN COMMENT 'True when the renewal reminder has been communicated.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date‑time the renewal reminder was dispatched.',
    `reissuance_lead_time_days` STRING COMMENT 'Configured lead time used for scheduling renewal batches.',
    `renewal_attempt_count` STRING COMMENT 'Number of times renewal has been tried for this schedule.',
    `renewal_batch_reference` BIGINT COMMENT 'Reference to the batch job that will process the renewal.',
    `renewal_eligibility_flag` BOOLEAN COMMENT 'True if the instrument meets business rules for renewal.',
    `renewal_failure_reason` STRING COMMENT 'Business code describing why a renewal attempt failed.',
    `renewal_status` STRING COMMENT 'Lifecycle status of the renewal operation.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `renewal_suppression_flag` BOOLEAN COMMENT 'True when renewal should be skipped (e.g., instrument is blocked).',
    `renewal_window_end_date` DATE COMMENT 'Latest date by which renewal must be completed.',
    `renewal_window_start_date` DATE COMMENT 'Earliest date on which renewal actions may be initiated.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating (0‑99.99) used to prioritize renewal actions.',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the schedule data.',
    `updated_by` STRING COMMENT 'Identifier of the internal user or service that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the schedule record.',
    `created_by` STRING COMMENT 'Identifier of the internal user or service that created the record.',
    CONSTRAINT pk_instrument_expiry_schedule PRIMARY KEY(`instrument_expiry_schedule_id`)
) COMMENT 'Expiry and renewal schedule master for payment instruments — tracks upcoming expiry dates, auto-renewal eligibility, renewal batch assignment, reissuance lead time, and renewal suppression flags (for inactive or blocked instruments). Enables proactive card renewal operations, batch reissuance planning, and cardholder communication scheduling ahead of expiry. Supports operational SLA management for card lifecycle teams.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` (
    `pan_alias_id` BIGINT COMMENT 'Unique surrogate identifier for the PAN alias record.',
    `payment_instrument_id` BIGINT COMMENT 'Foreign key to the underlying payment instrument (card, token, etc.) that this alias represents.',
    `alias_description` STRING COMMENT 'Human‑readable description or notes about the alias purpose or usage.',
    `alias_purpose` STRING COMMENT 'Intended business use of the alias, such as customer‑facing display, statement line, receipt line, or internal processing.. Valid values are `customer_display|statement|receipt|internal_use`',
    `alias_type` STRING COMMENT 'Category of the alias representation, e.g., masked PAN, last four digits, display token, or reference number.. Valid values are `masked_pan|last_four|display_token|reference_number`',
    `alias_value` DECIMAL(18,2) COMMENT 'The actual alias string presented to downstream systems; may be a masked PAN, last‑four digits, token, or reference number.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit entry for creation was recorded.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit entry for the latest modification was recorded.',
    `compliance_check_code` STRING COMMENT 'Code indicating the specific compliance rule or test applied.',
    `compliance_check_passed` BOOLEAN COMMENT 'Result of the most recent PCI/DSS compliance validation for the alias.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the alias record was created in the system.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the alias becomes invalid or must be retired.',
    `is_pci_compliant` BOOLEAN COMMENT 'True if the alias complies with PCI DSS requirements for storage and display.',
    `is_restricted_alias` BOOLEAN COMMENT 'True if the alias is subject to additional access controls or usage limits.',
    `is_test_alias` BOOLEAN COMMENT 'Indicates whether the alias is used for testing or sandbox environments.',
    `is_tokenized` BOOLEAN COMMENT 'Indicates whether the underlying PAN has been tokenized.',
    `notes` STRING COMMENT 'Free‑form comments or operational notes related to the alias.',
    `pan_alias_status` STRING COMMENT 'Current lifecycle state of the alias.. Valid values are `active|inactive|expired|revoked`',
    `source_system` STRING COMMENT 'Name of the source system that generated the alias record.',
    `token_service_provider` STRING COMMENT 'Provider responsible for issuing or managing the token associated with the alias.',
    `token_type` STRING COMMENT 'Classification of the token (e.g., single‑use, multi‑use, session‑based, device‑bound).. Valid values are `single_use|multi_use|session|device`',
    `updated_by` STRING COMMENT 'User or process that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the alias record.',
    `version_number` STRING COMMENT 'Incremental version of the alias record for optimistic concurrency control.',
    `created_by` STRING COMMENT 'User or process that created the alias record.',
    CONSTRAINT pk_pan_alias PRIMARY KEY(`pan_alias_id`)
) COMMENT 'PAN alias and surrogate identifier registry mapping masked PANs, last-four-digit references, and display tokens to underlying instrument records. Stores alias type (masked PAN, last four, display token, reference number), alias value, alias purpose (customer display, statement, receipt), creation timestamp, and expiry. Ensures PCI DSS compliance by providing safe display representations of card numbers without exposing the full PAN in downstream systems.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` (
    `pos_terminal_id` BIGINT COMMENT 'System-generated surrogate primary key for the POS terminal record.',
    `acceptance_type_id` BIGINT COMMENT 'Foreign key linking to terminal.terminal_acceptance_type. Business justification: Terminal specifies acceptance type; no redundant columns.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: REQUIRED: Expense allocation and maintenance cost reporting assign each terminal to a cost center for internal budgeting.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Regulatory compliance reporting requires mapping each terminal to its operating country for AML and tax jurisdiction analysis.',
    `dcc_config_id` BIGINT COMMENT 'Foreign key linking to fx.dcc_config. Business justification: Required for Dynamic Currency Conversion (DCC) processing at the POS; each terminal must reference the DCC configuration defining margin, currency pairs, and disclosure rules.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Required for Acquirer Ownership Report: each terminal must be linked to its acquiring partner for settlement, compliance, and risk reporting.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: During terminal provisioning, assigning a network endpoint defines routing path and settlement routing for each terminal.',
    `ledger_config_id` BIGINT COMMENT 'Foreign key linking to ledger.ledger_config. Business justification: REQUIRED: Transaction posting rules (chart of accounts, currency) are defined per ledger config; terminals must reference the config they use.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: REQUIRED: Regulatory and tax reporting require each terminal to be linked to its owning legal entity.',
    `merchant_location_id` BIGINT COMMENT 'Identifier of the physical site where the terminal is installed.',
    `region_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_region. Business justification: Assigning each POS terminal to a gateway region determines routing, latency SLA, and regulatory jurisdiction for transactions.',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: Linking terminal to an SLA profile enables monitoring of terminal availability and latency against contractual service levels.',
    `software_id` BIGINT COMMENT 'Foreign key linking to terminal.terminal_software. Business justification: Direct link to installed software; removes duplicated version fields.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: REQUIRED: Daily settlement report posts terminal revenue to a specific GL account; terminals need a direct GL account reference for accurate posting.',
    `compliance_status` STRING COMMENT 'Current PCI/EMV compliance status of the terminal.. Valid values are `compliant|non_compliant|pending_audit`',
    `connectivity_type` STRING COMMENT 'Primary network connectivity method used by the terminal.. Valid values are `wired|wifi|cellular|ethernet`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the terminal record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the terminal was retired or removed from service (null if still active).',
    `deployment_date` DATE COMMENT 'Date the terminal was first installed at a merchant location.',
    `device_certification_body` STRING COMMENT 'Organization that issued the terminals security or compliance certification.',
    `emv_capable` BOOLEAN COMMENT 'Indicates whether the terminal can process EMV chip card transactions.',
    `form_factor` STRING COMMENT 'Physical deployment style of the terminal.. Valid values are `countertop|mpos|kiosk|softpos`',
    `hardware_model` STRING COMMENT 'Model name/number of the terminal hardware as defined by the OEM.',
    `hce_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports Host Card Emulation for mobile wallet payments.',
    `ip_address` STRING COMMENT 'IP address assigned to the terminal for network communication.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit performed on the terminal.',
    `last_maintenance_date` DATE COMMENT 'Date the terminal last underwent preventive maintenance.',
    `last_software_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent software/firmware update applied to the terminal.',
    `mac_address` STRING COMMENT 'Media Access Control address of the terminals network interface.',
    `maintenance_status` STRING COMMENT 'Current maintenance state of the terminal.. Valid values are `scheduled|completed|overdue|none`',
    `manufacture_date` DATE COMMENT 'Date the terminal was manufactured.',
    `nfc_capable` BOOLEAN COMMENT 'Indicates whether the terminal supports Near Field Communication for contactless payments.',
    `pci_pts_cert_level` STRING COMMENT 'PCI Point‑to‑Point Encryption (PTS) certification level achieved by the terminal.. Valid values are `level1|level2|level3|level4`',
    `pos_terminal_status` STRING COMMENT 'Current operational status of the terminal.. Valid values are `active|inactive|maintenance|decommissioned|retired`',
    `serial_number` STRING COMMENT 'Manufacturer‑issued serial number that uniquely identifies the physical terminal hardware.',
    `tamper_seal_status` STRING COMMENT 'Current status of the physical tamper‑evident seal on the terminal.. Valid values are `intact|broken|unknown`',
    `terminal_capabilities` STRING COMMENT 'Comma‑separated list of functional capabilities supported by the terminal.. Valid values are `contactless|chip|magstripe|contact|nfc|tokenization`',
    `terminal_city` STRING COMMENT 'City where the terminal is installed.',
    `terminal_code` STRING COMMENT 'Unique alphanumeric identifier assigned to each point‑of‑sale terminal by the acquiring network.',
    `terminal_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the terminal.',
    `terminal_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the terminal.',
    `terminal_owner_type` STRING COMMENT 'Indicates whether the terminal is owned by the fintech, a partner, or a third‑party provider.. Valid values are `internal|partner|third_party`',
    `terminal_region` STRING COMMENT 'State, province, or region of the terminals location.',
    `terminal_security_cert_expiry` DATE COMMENT 'Expiration date of the terminals security certificate used for TLS/SSL connections.',
    `terminal_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., reason for maintenance or decommission).',
    `tokenization_enabled` BOOLEAN COMMENT 'Indicates whether the terminal is configured to use tokenization for card data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the terminal record.',
    CONSTRAINT pk_pos_terminal PRIMARY KEY(`pos_terminal_id`)
) COMMENT 'Master record for every physical or virtual point-of-sale terminal deployed across the merchant estate. Owns the TID (Terminal Identification Number), device serial number, hardware model, form factor (countertop, mPOS, unattended kiosk, SoftPOS), NFC capability flag, EMV chip capability, PCI PTS certification level, tamper-evident seal status, manufacture date, and current operational lifecycle stage. This is the SSOT for terminal identity within the payments-fintech platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`deployment` (
    `deployment_id` BIGINT COMMENT 'Unique surrogate key for each terminal deployment event.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Deployment records must associate each terminal installation site with a country to calculate local tax, compliance, and shipping logistics.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Deployment cost fields are recorded in a specific currency; linking to the currency master enables accurate financial reporting and multi‑currency settlement.',
    `employee_id` BIGINT COMMENT 'Identifier of the technician who performed the installation.',
    `installation_technician_employee_id` BIGINT COMMENT 'Identifier of the technician who performed the installation.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant where the terminal is deployed.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the terminal device being deployed.',
    `activation_date` DATE COMMENT 'Date when the terminal became active for processing transactions.',
    `compliance_audit_date` DATE COMMENT 'Date when the most recent compliance audit was performed.',
    `compliance_audit_result` STRING COMMENT 'Outcome of the compliance audit.. Valid values are `pass|fail|exception`',
    `compliance_status` STRING COMMENT 'Result of the latest PCI PTS compliance check for the terminal.. Valid values are `compliant|non_compliant|pending`',
    `cost_adjustment` DECIMAL(18,2) COMMENT 'Adjustments (discounts, fees) applied to the gross deployment cost.',
    `cost_gross` DECIMAL(18,2) COMMENT 'Total gross cost incurred for the deployment before any adjustments.',
    `cost_net` DECIMAL(18,2) COMMENT 'Net cost after adjustments for the deployment.',
    `decommission_date` DATE COMMENT 'Date when the terminal was removed from service, if applicable.',
    `decommission_reason` STRING COMMENT 'Reason for terminal decommissioning (e.g., hardware failure, upgrade, merchant closure).',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the deployment.. Valid values are `scheduled|in_transit|installed|activated|decommissioned`',
    `deployment_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment event occurred (e.g., when the terminal was installed).',
    `firmware_version` STRING COMMENT 'Version identifier of the terminal firmware installed at deployment.',
    `installation_contact_email` STRING COMMENT 'Email address of the technician or point of contact for installation.',
    `installation_contact_phone` STRING COMMENT 'Phone number of the technician or point of contact for installation.',
    `installation_date` DATE COMMENT 'Actual date when the terminal was installed at the merchant site.',
    `installation_technician_name` STRING COMMENT 'Full name of the installation technician.',
    `is_contactless_enabled` BOOLEAN COMMENT 'Indicates whether contactless payment (e.g., NFC) is enabled on the terminal.',
    `is_emv_enabled` BOOLEAN COMMENT 'Indicates whether EMV chip processing is enabled on the terminal.',
    `is_nfc_enabled` BOOLEAN COMMENT 'Indicates whether Near Field Communication is enabled for tap‑to‑pay.',
    `notes` STRING COMMENT 'Free‑form notes captured during deployment (e.g., observations, special instructions).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the deployment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the deployment record.',
    `reference` STRING COMMENT 'External reference number assigned to the deployment event for tracking and reporting.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk rating assigned to the deployment based on fraud and security assessments.',
    `schedule_date` DATE COMMENT 'Planned date for the terminal deployment.',
    `shipping_carrier` STRING COMMENT 'Logistics provider responsible for transporting the terminal to the merchant site.',
    `site_address_line1` STRING COMMENT 'First line of the merchant site address where the terminal is installed.',
    `site_address_line2` STRING COMMENT 'Second line of the merchant site address (optional).',
    `site_city` STRING COMMENT 'City of the merchant site address.',
    `site_postal_code` STRING COMMENT 'Postal/ZIP code of the merchant site address.',
    `site_state` STRING COMMENT 'State or province of the merchant site address.',
    `software_version` STRING COMMENT 'Version identifier of the terminal application software.',
    `terminal_model` STRING COMMENT 'Model designation of the terminal hardware.',
    `terminal_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the terminal device.',
    `terminal_type` STRING COMMENT 'Category of terminal based on form factor and usage.. Valid values are `POS|mPOS|ATM|Kiosk`',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for the terminal shipment.',
    CONSTRAINT pk_deployment PRIMARY KEY(`deployment_id`)
) COMMENT 'Transactional record capturing the physical deployment or redeployment of a terminal to a merchant location. Tracks deployment date, installation technician reference, merchant MID, physical site address, deployment status (scheduled, in-transit, installed, activated, decommissioned), shipping carrier, tracking number, and acceptance sign-off. Represents the operational event of placing a terminal into service at a specific merchant site.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` (
    `terminal_config_id` BIGINT COMMENT 'Unique identifier for the terminal configuration profile.',
    `contactless_profile_id` BIGINT COMMENT 'Foreign key linking to terminal.contactless_profile. Business justification: Config uses contactless profile; redundant flags removed.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Needed for Partner‑Specific Configuration Management: configs are provisioned per acquiring partner to enforce network routing and regulatory settings.',
    `emv_parameter_set_id` BIGINT COMMENT 'Foreign key linking to terminal.emv_parameter_set. Business justification: Config references EMV parameters.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant to which this configuration is assigned.',
    `receipt_template_id` BIGINT COMMENT 'Foreign key linking to terminal.terminal_receipt_template. Business justification: Terminal configuration should reference a receipt template to centralize receipt layout attributes; the new FK consolidates receipt formatting and removes duplicated columns.',
    `software_id` BIGINT COMMENT 'Foreign key linking to terminal.terminal_software. Business justification: Config specifies software version; move to software catalog.',
    `terminal_group_id` BIGINT COMMENT 'Identifier of the terminal group (fleet) that uses this configuration.',
    `accepted_card_schemes` STRING COMMENT 'List of payment card schemes the terminal is permitted to process.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `audit_status` STRING COMMENT 'Result of the latest audit: passed, failed, or not applicable.. Valid values are `passed|failed|not_applicable`',
    `compliance_status` STRING COMMENT 'Current PCI/EMV compliance state of the configuration.. Valid values are `compliant|non_compliant|pending_review`',
    `config_description` STRING COMMENT 'Detailed description of the configuration purpose and scope.',
    `config_name` STRING COMMENT 'Human‑readable name of the configuration profile.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for limits and amounts.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `dcc_enabled` BOOLEAN COMMENT 'Indicates whether DCC is offered on the terminal.',
    `effective_from` DATE COMMENT 'Date when the configuration becomes active for assigned terminals.',
    `effective_until` DATE COMMENT 'Date when the configuration expires or is superseded (null if open‑ended).',
    `encryption_key_version` STRING COMMENT 'Version of the encryption key used for PIN and data protection.',
    `hardware_model` STRING COMMENT 'Manufacturer model identifier for the terminal device.',
    `idle_screen_timeout_seconds` STRING COMMENT 'Number of seconds of inactivity before the terminal returns to idle screen.',
    `is_default_config` BOOLEAN COMMENT 'Indicates whether this profile is the default for new terminals.',
    `language_locale` STRING COMMENT 'Locale code (e.g., en-US) for UI language and formatting.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit for this configuration.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of authorization retries before decline.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit for any single transaction processed under this configuration.',
    `offline_floor_limit` DECIMAL(18,2) COMMENT 'Maximum amount that can be authorized offline before requiring online verification.',
    `pin_entry_mode` STRING COMMENT 'Mode in which PIN entry is accepted: online, offline, or both.. Valid values are `online|offline|both`',
    `requires_pin_entry` BOOLEAN COMMENT 'Specifies if PIN entry is mandatory for all transactions.',
    `retry_interval_seconds` STRING COMMENT 'Delay in seconds between successive authorization retries.',
    `supports_emv` BOOLEAN COMMENT 'Indicates whether the terminal is EMV‑chip capable.',
    `supports_nfc` BOOLEAN COMMENT 'Indicates whether the terminal hardware supports NFC contactless.',
    `terminal_config_status` STRING COMMENT 'Current lifecycle status of the configuration profile.. Valid values are `active|inactive|deprecated|pending`',
    `terminal_type` STRING COMMENT 'Physical form factor or deployment category of the terminal.. Valid values are `countertop|mobile|mpos|self_service|kiosk`',
    `tip_prompt_enabled` BOOLEAN COMMENT 'Indicates whether the terminal prompts the cardholder for a tip.',
    `tip_prompt_options` STRING COMMENT 'Configuration of tip prompting method offered to the cardholder.. Valid values are `none|percentage|fixed|percentage_and_fixed`',
    `token_service_provider` STRING COMMENT 'Name of the token service provider (TSP) used for tokenization.',
    `tokenization_enabled` BOOLEAN COMMENT 'Indicates whether card data is tokenized on the terminal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration.',
    `version` STRING COMMENT 'Version identifier for change management of the configuration.',
    CONSTRAINT pk_terminal_config PRIMARY KEY(`terminal_config_id`)
) COMMENT 'Master configuration profile applied to a terminal, defining operational parameters such as accepted card schemes, contactless transaction limits, offline floor limits, PIN entry mode, tip prompting rules, DCC enablement, receipt printing preferences, idle screen settings, and language locale. A single config profile may be applied to many terminals, enabling fleet-wide configuration management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` (
    `emv_parameter_set_id` BIGINT COMMENT 'Unique surrogate key for each EMV parameter set record.',
    `additional_terminal_capabilities` STRING COMMENT 'Hexadecimal byte providing extended capability information.',
    `aid` STRING COMMENT 'Application Identifier for the EMV application on the card.',
    `application_interchange_profile` STRING COMMENT 'Hexadecimal value indicating the cards capabilities and restrictions.',
    `application_transaction_counter` STRING COMMENT 'Initial value of the transaction counter for the application.',
    `application_version_number` STRING COMMENT 'Version number of the EMV application on the card.',
    `compliance_status` STRING COMMENT 'Current compliance status of the parameter set with applicable regulations.. Valid values are `compliant|non_compliant|under_review`',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether contactless (NFC) functionality is enabled on the terminal.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the jurisdiction of the parameter set.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for which the parameters apply.',
    `cvm_list` STRING COMMENT 'Comma‑separated list of supported CVMs for the terminal.. Valid values are `signature|online_pin|offline_pin|no_cvm|mobile_cvm`',
    `effective_from` DATE COMMENT 'Date when the parameter set becomes effective.',
    `effective_until` DATE COMMENT 'Date when the parameter set expires; null if indefinite.',
    `emv_parameter_set_description` STRING COMMENT 'Human‑readable description or notes about the parameter set.',
    `emv_parameter_set_status` STRING COMMENT 'Current lifecycle status of the EMV parameter set.. Valid values are `active|inactive|deprecated|pending`',
    `floor_limit` DECIMAL(18,2) COMMENT 'Maximum transaction amount that can be approved offline without online authorization.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this is the default EMV parameter set for the scheme.',
    `kernel_version` STRING COMMENT 'Version of the EMV kernel software loaded on the terminal.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent regulatory compliance audit.',
    `offline_data_authentication` STRING COMMENT 'Supported method for offline data authentication.. Valid values are `static|dynamic|combined`',
    `offline_pin_supported` BOOLEAN COMMENT 'Indicates if the terminal can perform offline PIN verification.',
    `online_pin_supported` BOOLEAN COMMENT 'Indicates if the terminal can perform online PIN verification.',
    `random_selection_percentage` STRING COMMENT 'Percentage of transactions randomly selected for online processing to mitigate risk.',
    `risk_score` STRING COMMENT 'Risk score assigned based on fraud monitoring of this parameter set.',
    `scheme` STRING COMMENT 'Card scheme to which this EMV parameter set applies.. Valid values are `Visa|Mastercard|Amex|Discover|UnionPay`',
    `tac_default` STRING COMMENT 'Default Terminal Action Code applied when no other TAC matches.',
    `tac_denial` STRING COMMENT 'Terminal Action Code used when a transaction is denied offline.',
    `tac_online` STRING COMMENT 'Terminal Action Code used when a transaction requires online authorization.',
    `terminal_capabilities` STRING COMMENT 'Hexadecimal byte indicating the terminals functional capabilities.',
    `transaction_type_support` STRING COMMENT 'Comma‑separated list of transaction types the terminal can process.. Valid values are `purchase|cash|refund|preauth|completion`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `velocity_check_limit` STRING COMMENT 'Maximum number of offline transactions allowed before a mandatory online check.',
    `velocity_check_time_window` STRING COMMENT 'Time window in minutes for the velocity check limit.',
    `version_number` STRING COMMENT 'Sequential version number for change management of the parameter set.',
    CONSTRAINT pk_emv_parameter_set PRIMARY KEY(`emv_parameter_set_id`)
) COMMENT 'Defines the full set of EMV chip parameters loaded onto a terminal for each supported card scheme (Visa, Mastercard, Amex, Discover, UnionPay). Includes AID (Application Identifier), TAC (Terminal Action Codes) for denial/online/default, terminal capabilities byte, additional terminal capabilities, floor limit, random transaction selection percentage, velocity check parameters, and EMV kernel version. Critical for correct chip transaction processing and scheme compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` (
    `contactless_profile_id` BIGINT COMMENT 'Unique identifier for the contactless profile configuration.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the profile.. Valid values are `compliant|non_compliant|pending_audit`',
    `contactless_fallback_enabled` BOOLEAN COMMENT 'Indicates whether automatic fallback to chip is enabled after contactless failures.',
    `contactless_fallback_timeout_ms` STRING COMMENT 'Timeout in milliseconds before fallback to chip after a contactless attempt.',
    `contactless_profile_description` STRING COMMENT 'Free-form description of the contactless profile.',
    `contactless_profile_status` STRING COMMENT 'Current lifecycle status of the profile.. Valid values are `active|inactive|deprecated|pending`',
    `contactless_transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount allowed for a single contactless transaction under this profile.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profile record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction limit.. Valid values are `^[A-Z]{3}$`',
    `cvm_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount for which a specific Cardholder Verification Method (CVM) is required.',
    `cvm_type` STRING COMMENT 'Type of CVM applied for transactions under this profile.. Valid values are `signature|pin|none|online`',
    `dual_interface_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports both contactless and chip interfaces.',
    `dual_interface_routing_rule` STRING COMMENT 'Routing rule applied when both contactless and chip interfaces are available.. Valid values are `fallback|prefer_contactless|prefer_chip`',
    `effective_end_date` DATE COMMENT 'Date when the profile ceases to be effective (null if open-ended).',
    `effective_start_date` DATE COMMENT 'Date when the profile becomes effective for terminals.',
    `firmware_version` STRING COMMENT 'Version identifier of the terminal firmware associated with this profile.',
    `kernel_version` STRING COMMENT 'Version identifier of the contactless kernel software.',
    `max_transaction_attempts` STRING COMMENT 'Maximum number of contactless attempts before fallback to chip.',
    `nfc_antenna_gain_db` DECIMAL(18,2) COMMENT 'Antenna gain in decibels for NFC communication.',
    `nfc_enabled` BOOLEAN COMMENT 'Indicates if NFC (Near Field Communication) is enabled on the terminal.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the profile.',
    `profile_code` STRING COMMENT 'Unique code identifying the contactless profile within the system.',
    `profile_name` STRING COMMENT 'Human readable name for the contactless configuration profile.',
    `profile_type` STRING COMMENT 'Classification of the profile (e.g., default, custom, partner specific).. Valid values are `default|custom|partner`',
    `qr_payment_enabled` BOOLEAN COMMENT 'Flag indicating if QR code payments are enabled for the terminal.',
    `qr_payment_type` STRING COMMENT 'Specifies whether static or dynamic QR codes are used.. Valid values are `static|dynamic`',
    `security_certification_level` STRING COMMENT 'Security certification level of the terminal (e.g., PCI PTS, PCI PTS A, PCI PTS B).. Valid values are `PCI_PTS|PCI_PTS_A|PCI_PTS_B`',
    `supported_kernels` STRING COMMENT 'Comma-separated list of contactless kernel identifiers supported (e.g., Visa payWave, Mastercard PayPass, Amex ExpressPay, Discover D-PAS). [ENUM-REF-CANDIDATE: Visa payWave|Mastercard PayPass|Amex ExpressPay|Discover D-PAS|UnionPay QuickPass|JCB J/Speedy — promote to reference product]',
    `terminal_software_version` STRING COMMENT 'Version of the terminal software that implements this profile.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the profile.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the profile record was last updated.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the profile.',
    CONSTRAINT pk_contactless_profile PRIMARY KEY(`contactless_profile_id`)
) COMMENT 'Configuration entity defining NFC and contactless payment parameters for a terminal, including supported contactless kernels (Visa payWave, Mastercard PayPass/Tap & Go, Amex ExpressPay, Discover D-PAS), CVM (Cardholder Verification Method) limits, contactless transaction ceiling limits, dual-interface routing rules, and QR code payment enablement flags. Governs how the terminal handles tap-to-pay and QR-based transactions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`software` (
    `software_id` BIGINT COMMENT 'Unique surrogate identifier for each terminal software record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Software Licensing Audit: linking software releases to the supplying partner enables license tracking, version compliance, and audit trails.',
    `certification_date` DATE COMMENT 'Date on which the software received its most recent certification.',
    `certification_status` STRING COMMENT 'Current certification state of the software with respect to PCI/EMV standards.. Valid values are `certified|pending|revoked|expired`',
    `checksum_sha256` STRING COMMENT 'SHA‑256 hash of the software package for integrity verification.',
    `compliance_body` STRING COMMENT 'Regulatory or standards body that issued the certification (e.g., PCI SSC, EMVCo).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first inserted into the catalog.',
    `deployment_status` STRING COMMENT 'Current operational status of the software in the terminal fleet.. Valid values are `available|deprecated|retired|inactive`',
    `deprecation_date` DATE COMMENT 'Date after which the software should no longer be deployed.',
    `digital_signature` STRING COMMENT 'Cryptographic signature used to verify authenticity of the package.',
    `end_of_support_date` DATE COMMENT 'Date after which the vendor will no longer provide support or patches.',
    `file_location_path` STRING COMMENT 'Filesystem or object‑store path where the binary is stored.',
    `file_size_bytes` BIGINT COMMENT 'Binary size of the software package.',
    `hardware_model_compatibility` STRING COMMENT 'Comma‑separated list of terminal hardware models that can run this software.',
    `is_contactless_enabled` BOOLEAN COMMENT 'Indicates whether the software enables contactless transaction processing.',
    `is_firmware` BOOLEAN COMMENT 'True if the software package is firmware rather than an application layer.',
    `is_mandatory_update` BOOLEAN COMMENT 'Indicates whether deployment of this version is required for compliance or security.',
    `is_test_version` BOOLEAN COMMENT 'True if the version is intended for testing environments only.',
    `pci_validation_date` DATE COMMENT 'Date of the most recent PCI validation.',
    `pci_validation_status` STRING COMMENT 'PCI validation outcome for the software package.. Valid values are `PA-DSS|P2PE|none`',
    `regulatory_compliance_codes` STRING COMMENT 'Pipe‑separated list of regulatory codes applicable to this software (e.g., PCI|EMV|PSD2).',
    `release_date` DATE COMMENT 'Calendar date when the software version was made publicly available.',
    `release_notes` STRING COMMENT 'Free‑form text describing changes, bug fixes, and enhancements for this version.',
    `release_type` STRING COMMENT 'Classification of the release according to versioning semantics.. Valid values are `major|minor|patch|hotfix`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical risk rating assigned by the security team (0.00‑99.99).',
    `scheme_approval_reference` STRING COMMENT 'Reference identifier from payment schemes (e.g., Visa, Mastercard) confirming approval.',
    `software_description` STRING COMMENT 'Free‑form description of the softwares purpose and functionality.',
    `software_name` STRING COMMENT 'Human‑readable name of the software package.',
    `software_type` STRING COMMENT 'Category of the software component.. Valid values are `payment_kernel|pin_firmware|os|application`',
    `source_repository` STRING COMMENT 'URL of the source code repository or binary storage location.',
    `supported_payment_schemes` STRING COMMENT 'Payment schemes that the software version supports.. Valid values are `visa|mastercard|amex|discover|unionpay`',
    `supported_terminal_features` STRING COMMENT 'Comma‑separated list of terminal capabilities enabled by this software (e.g., NFC, EMV, QR).',
    `update_priority` STRING COMMENT 'Business priority for rolling out this software version.. Valid values are `low|medium|high`',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `vendor_name` STRING COMMENT 'Name of the organization that supplied the software.',
    `version_number` STRING COMMENT 'Version identifier following the vendors versioning scheme (e.g., 1.2.3).',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_software PRIMARY KEY(`software_id`)
) COMMENT 'Master catalog of terminal application software versions available for deployment across the terminal fleet. Tracks software package name, version number, target hardware model compatibility, payment application type (payment kernel, PIN pad firmware, OS), PCI PA-DSS or PCI P2PE validation status, certification date, scheme approval references (Visa, Mastercard), and release notes. Serves as the authoritative software version registry.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`software_update` (
    `software_update_id` BIGINT COMMENT 'Unique system-generated identifier for each software update event.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or automated process that approved the software update.',
    `operator_employee_id` BIGINT COMMENT 'Identifier of the person or automated process that approved the software update.',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier of the POS terminal or device being updated.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The real date and time when the update process finished.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The real date and time when the update process began on the terminal.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time the operator gave approval for the update.',
    `error_code` STRING COMMENT 'Standardized error identifier when the update fails.',
    `error_message` STRING COMMENT 'Detailed description of the failure condition.',
    `notes` STRING COMMENT 'Additional comments or observations captured by the operator or system.',
    `outcome` STRING COMMENT 'Final outcome of the update after execution.. Valid values are `SUCCESS|FAILURE|ROLLED_BACK`',
    `record_audit_created` TIMESTAMP COMMENT 'When the software update record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'When the software update record was last modified.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'The date and time by which the update was expected to complete.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The date and time when the update was scheduled to begin.',
    `software_version_after` STRING COMMENT 'The firmware or software version installed on the terminal after the update completes.',
    `software_version_before` STRING COMMENT 'The firmware or software version installed on the terminal prior to the update.',
    `update_method` STRING COMMENT 'Mechanism by which the software package was delivered to the terminal.. Valid values are `OTA|USB|NETWORK_DOWNLOAD|MANUAL`',
    `update_reference` STRING COMMENT 'Business-visible reference code or batch number for the software update.',
    `update_status` STRING COMMENT 'State of the update process from scheduling through completion or failure.. Valid values are `SCHEDULED|IN_PROGRESS|COMPLETED|FAILED|ROLLED_BACK`',
    CONSTRAINT pk_software_update PRIMARY KEY(`software_update_id`)
) COMMENT 'Transactional record of a software update or firmware push event executed on a terminal. Captures the target terminal, source and target software versions, update method (OTA, USB, network download), scheduled update window, actual start and completion timestamps, update outcome (success, failed, rolled back), error codes on failure, and operator who authorized the update. Enables full audit trail of software change management across the terminal fleet.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`key_injection` (
    `key_injection_id` BIGINT COMMENT 'Unique identifier for the key injection event record.',
    `employee_id` BIGINT COMMENT 'Identifier of the technician or automated system that performed the key injection.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal on which the key injection was performed.',
    `technician_employee_id` BIGINT COMMENT 'Identifier of the technician or automated system that performed the key injection.',
    `comments` STRING COMMENT 'Free‑form notes captured during the key injection event.',
    `compliance_status` STRING COMMENT 'Indicates whether the injection meets PCI PTS compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `hsm_reference` BIGINT COMMENT 'Identifier of the HSM that generated or protected the injected key.',
    `injection_location` STRING COMMENT 'Code representing the physical or logical location where the key injection took place.',
    `injection_method` STRING COMMENT 'Method used to load the key onto the terminal, either via a physical Key Injection Facility (KIF) or remote loading.. Valid values are `KIF|remote`',
    `injection_outcome` STRING COMMENT 'Result of the key injection attempt, indicating whether it succeeded or failed.. Valid values are `success|failure`',
    `injection_timestamp` TIMESTAMP COMMENT 'Date and time when the cryptographic key was injected into the terminal.',
    `key_check_value` DECIMAL(18,2) COMMENT 'Six‑character hexadecimal check value used to verify the integrity of the injected key.',
    `key_expiration_date` DATE COMMENT 'Date after which the injected key must no longer be used.',
    `key_type` STRING COMMENT 'Classification of the injected key: Terminal Master Key (TMK), Terminal Encryption Key (TEK), or PIN Encryption Key.. Valid values are `TMK|TEK|PIN`',
    `key_version` STRING COMMENT 'Version identifier of the injected cryptographic key.. Valid values are `^[A-Z0-9]{1,10}$`',
    `load_sequence_number` STRING COMMENT 'Sequential number indicating the order of key loads for the terminal.',
    `outcome_reason_code` STRING COMMENT 'Code describing the reason for a failure outcome, if applicable.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this key injection record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this key injection record.',
    `source_system` STRING COMMENT 'Originating system that logged the key injection event.. Valid values are `gateway|terminal_mgmt|fraud_platform`',
    CONSTRAINT pk_key_injection PRIMARY KEY(`key_injection_id`)
) COMMENT 'Transactional record of a cryptographic key injection event performed on a terminal, including the key type (TMK — Terminal Master Key, TEK — Terminal Encryption Key, PIN encryption key), injection method (KIF — Key Injection Facility, remote key loading), HSM reference, key check value (KCV), injection timestamp, technician or automated system identifier, and injection outcome. Critical for PCI PTS compliance and secure PIN transaction processing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` (
    `tid_provisioning_id` BIGINT COMMENT 'System-generated unique identifier for each terminal provisioning record.',
    `merchant_location_id` BIGINT COMMENT 'Identifier of the physical location where the terminal is installed.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Associate TID provisioning with terminal; duplicate hardware info removed.',
    `acquiring_bin` STRING COMMENT 'Bank Identification Number of the acquiring bank that processes the terminals transactions.',
    `activation_date` TIMESTAMP COMMENT 'Date and time when the terminal became active for processing transactions.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the terminal with PCI DSS and other regulations.. Valid values are `compliant|non_compliant|under_review`',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether contactless payment is enabled on the terminal.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the terminal is registered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the provisioning record was first created in the data lake.',
    `deactivation_date` TIMESTAMP COMMENT 'Date and time when the terminal was deactivated or deregistered.',
    `deployment_date` TIMESTAMP COMMENT 'Date and time when the terminal was physically installed at the location.',
    `emv_capability` STRING COMMENT 'EMV support level of the terminal (contact, contactless, or both).. Valid values are `contact|contactless|both`',
    `hardware_model` STRING COMMENT 'Manufacturer model number of the terminal hardware.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the terminal (if applicable).',
    `last_software_update` TIMESTAMP COMMENT 'Timestamp of the most recent software/firmware update applied to the terminal.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the terminals network interface.',
    `mid` STRING COMMENT 'Identifier of the merchant to which the terminal is assigned.',
    `provisioning_date` TIMESTAMP COMMENT 'Date and time when the terminal was provisioned in the system.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk rating assigned by the fraud detection platform based on terminal behavior.',
    `scheme` STRING COMMENT 'Payment network scheme for which the terminal is registered (e.g., Visa, Mastercard).. Valid values are `visa|mastercard|amex|discover|other`',
    `scheme_registration_status` STRING COMMENT 'Current registration status of the terminal with the payment scheme.. Valid values are `registered|pending|rejected|suspended`',
    `security_certification` STRING COMMENT 'Security certification level of the terminal per PCI PTS standards.. Valid values are `PCI_PTS_Level1|PCI_PTS_Level2|PCI_PTS_Level3`',
    `terminal_type` STRING COMMENT 'Category of terminal based on form factor and usage.. Valid values are `pos|mpos|atm|kiosk|online`',
    `tid` STRING COMMENT 'Unique terminal identifier assigned by the acquiring network.',
    `tid_provisioning_status` STRING COMMENT 'Current operational status of the terminal.. Valid values are `active|suspended|deregistered|pending`',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether the terminal supports tokenization of card data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the provisioning record.',
    CONSTRAINT pk_tid_provisioning PRIMARY KEY(`tid_provisioning_id`)
) COMMENT 'Master record governing the provisioning and registration of a TID (Terminal Identification Number) within the payment network. Tracks TID value, associated MID, acquiring BIN, card scheme registration status per network (Visa, Mastercard, Amex), provisioning date, TID status (active, suspended, deregistered), and the network registration reference numbers returned by each scheme. Bridges terminal identity to network-level routing and settlement.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` (
    `terminal_certification_id` BIGINT COMMENT 'Unique surrogate key for each terminal certification record.',
    `approval_date` DATE COMMENT 'Date the certification became effective.',
    `body` STRING COMMENT 'Organization that issued the certification (e.g., PCI SSC, EMVCo, Visa, Mastercard, national scheme).',
    `certificate_number` STRING COMMENT 'Unique identifier assigned by the certification body to this certification.',
    `certification_scope` STRING COMMENT 'Scope of the certification (e.g., hardware only, software only, combined, contactless, tokenization).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|revoked|pending|suspended`',
    `certification_type` STRING COMMENT 'Type of certification such as PCI PTS, PA‑DSS, P2PE, EMV Level 1, EMV Level 2, Contactless Kernel.',
    `compliance_notes` STRING COMMENT 'Free‑form notes from compliance reviewers about the certification.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numerical score (0‑100) reflecting overall compliance posture.',
    `conditions_or_restrictions` STRING COMMENT 'Any conditions, limitations, or restrictions imposed by the certifying body.',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports contactless transactions.',
    `cvv_capture_supported` BOOLEAN COMMENT 'True if the terminal can capture CVV for card‑not‑present transactions.',
    `decommission_date` DATE COMMENT 'Date the terminal was retired or taken out of service.',
    `deployment_date` DATE COMMENT 'Date the terminal was first deployed in the field.',
    `document_url` STRING COMMENT 'Link to the stored certification document.',
    `emv_level` STRING COMMENT 'EMV certification level achieved by the terminal.. Valid values are `level1|level2`',
    `expiry_date` DATE COMMENT 'Date the certification expires or must be renewed.',
    `firmware_version` STRING COMMENT 'Version identifier for the terminal firmware.',
    `hardware_version` STRING COMMENT 'Version identifier for the terminal hardware.',
    `ip_address` STRING COMMENT 'IP address assigned to the terminal.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether certification is mandatory for the terminals operating region.',
    `jurisdiction` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code of the jurisdiction governing the certification.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit for this terminal.',
    `mac_address` STRING COMMENT 'Media Access Control address of the terminals network interface.',
    `magnetic_stripe_supported` BOOLEAN COMMENT 'True if the terminal can read magnetic stripe cards.',
    `manufacturer` STRING COMMENT 'Company that manufactured the terminal.',
    `manufacturer_part_number` STRING COMMENT 'Part number assigned by the manufacturer.',
    `pci_compliance_status` STRING COMMENT 'Current PCI compliance status of the terminal.. Valid values are `compliant|non_compliant|revoked`',
    `pin_entry_supported` BOOLEAN COMMENT 'True if the terminal supports PIN entry for cardholder verification.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `regulatory_framework` STRING COMMENT 'Regulatory framework under which the certification was obtained.. Valid values are `pci_ssc|emvco|visa|mastercard|national`',
    `renewal_notice_date` DATE COMMENT 'Date on which a renewal notice should be sent to the responsible team.',
    `renewal_required` BOOLEAN COMMENT 'True if the certification is approaching expiry and requires renewal.',
    `risk_level` STRING COMMENT 'Risk rating associated with the terminal based on certification and security posture.. Valid values are `low|medium|high`',
    `secure_element_type` STRING COMMENT 'Type of secure element used (e.g., HCE, TPM, dedicated SE).',
    `serial_number` STRING COMMENT 'Unique serial number of the terminal device.',
    `software_version` STRING COMMENT 'Version identifier for the terminal operating software.',
    `terminal_model` STRING COMMENT 'Human‑readable model name or identifier for the terminal hardware.',
    `terminal_type` STRING COMMENT 'Category of terminal based on deployment context.. Valid values are `pos|mpos|atm|kiosk`',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether the terminal is capable of tokenizing card data.',
    `version` STRING COMMENT 'Version identifier for the certification record (used for change tracking).',
    CONSTRAINT pk_terminal_certification PRIMARY KEY(`terminal_certification_id`)
) COMMENT 'Master record of terminal type approvals and certifications obtained for a hardware/software combination. Tracks certification body (PCI SSC, EMVCo, Visa, Mastercard, national scheme), certification type (PCI PTS, PA-DSS, P2PE, EMV Level 1/Level 2, contactless kernel), certificate number, approval date, expiry date, certification scope, and any conditions or restrictions. Enables compliance tracking and renewal management across the terminal estate.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`inventory` (
    `inventory_id` BIGINT COMMENT 'Unique surrogate key for each terminal inventory record.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant currently using or assigned to the terminal.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Inventory records map to physical terminal; redundant hardware attributes removed.',
    `acquisition_date` DATE COMMENT 'Date the terminal was purchased or received into inventory.',
    `asset_tag` STRING COMMENT 'Internal tag used for tracking the terminal within the organization.',
    `batch_number` STRING COMMENT 'Identifier of the procurement or production batch the terminal belongs to.',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports contactless card/NFC transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory record was first created.',
    `current_location_code` STRING COMMENT 'Identifier (e.g., warehouse code) of the terminals present location.',
    `current_location_type` STRING COMMENT 'Physical location category where the terminal resides.. Valid values are `warehouse|in_transit|merchant_site|repair_depot|store`',
    `decommission_date` DATE COMMENT 'Date the terminal was removed from service, if applicable.',
    `deployment_date` DATE COMMENT 'Date the terminal was installed at a merchant site.',
    `device_status_reason` STRING COMMENT 'Free‑text explanation for the current status or any recent change.',
    `emv_capability` STRING COMMENT 'Supported EMV capabilities of the terminal.. Valid values are `magstripe|chip|contactless|chip_and_contactless`',
    `encryption_key_reference` STRING COMMENT 'Identifier of the encryption key used for data-at-rest encryption on the terminal.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the terminal (if applicable).',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which preventive maintenance was performed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the terminal asset.. Valid values are `in_service|retired|decommissioned|maintenance`',
    `mac_address` STRING COMMENT 'Media Access Control address of the terminals network interface.',
    `maintenance_cycle_days` STRING COMMENT 'Scheduled interval in days between routine maintenance activities.',
    `network_connectivity_type` STRING COMMENT 'Supported network connection method for the terminal.. Valid values are `wired|wifi|cellular|ethernet`',
    `nfc_enabled` BOOLEAN COMMENT 'True if the terminal can read NFC-enabled devices.',
    `pci_pts_compliance_status` STRING COMMENT 'Current compliance status with PCI Point‑to‑Point Encryption standards.. Valid values are `compliant|non_compliant|pending`',
    `physical_condition` STRING COMMENT 'Observed condition of the terminal hardware.. Valid values are `new|good|fair|poor|damaged`',
    `power_requirement_w` STRING COMMENT 'Electrical power consumption in watts.',
    `security_certification_date` DATE COMMENT 'Date when the terminal received its latest security certification.',
    `shipment_reference` STRING COMMENT 'Reference code for the shipment that delivered the terminal to inventory.',
    `temperature_rating_c` STRING COMMENT 'Maximum operating temperature in degrees Celsius.',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether the terminal can generate payment tokens.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Purchase cost of a single terminal unit in the functional currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inventory record.',
    `vendor_name` STRING COMMENT 'Name of the supplier that provided the terminal.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty ends.',
    CONSTRAINT pk_inventory PRIMARY KEY(`inventory_id`)
) COMMENT 'Tracks the physical inventory of terminal hardware units held in warehouses, staging facilities, and field stock. Records device serial number, hardware model, current inventory location (warehouse, in-transit, merchant site, repair depot), inventory status (available, reserved, deployed, faulty, decommissioned), acquisition date, unit cost, and assigned batch or shipment reference. Supports device lifecycle management from procurement through decommission.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique system-generated identifier for each terminal assignment record.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant to which the terminal is assigned.',
    `merchant_location_id` BIGINT COMMENT 'Unique identifier of the physical site or store location where the terminal is deployed.',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier of the POS terminal being assigned.',
    `actual_end_date` DATE COMMENT 'Date when the assignment actually ended (null if still active).',
    `address_line1` STRING COMMENT 'First line of the physical address where the terminal is installed.',
    `address_line2` STRING COMMENT 'Second line of the address (optional).',
    `assigned_mid` STRING COMMENT 'The merchants identification number as used in payment networks.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment.. Valid values are `active|inactive|pending|suspended|terminated`',
    `assignment_type` STRING COMMENT 'Nature of the terminal assignment: permanent, temporary, seasonal, or test.. Valid values are `permanent|temporary|seasonal|test`',
    `city` STRING COMMENT 'City component of the terminal installation address.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the terminal at the location.. Valid values are `compliant|non_compliant|pending_review`',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether contactless payment functionality is enabled on the terminal.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the terminal location.. Valid values are `[A-Z]{3}`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was created.',
    `decommission_date` DATE COMMENT 'Planned date for terminal removal or retirement.',
    `decommission_flag` BOOLEAN COMMENT 'Indicates whether the terminal is scheduled for decommission.',
    `emv_capability` STRING COMMENT 'EMV support level of the terminal: contact, contactless, or both.. Valid values are `contact|contactless|both`',
    `expected_end_date` DATE COMMENT 'Planned date when the assignment is expected to end.',
    `firmware_version` STRING COMMENT 'Current firmware/software version installed on the terminal.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|pending`',
    `lane_number` STRING COMMENT 'Identifier of the checkout lane or POS position within the location (e.g., Lane A, Lane 1).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance or security inspection of the terminal.',
    `last_software_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent firmware or software update applied to the terminal.',
    `network_provider` STRING COMMENT 'Payment network provider associated with the terminal (e.g., Visa, Mastercard).. Valid values are `visa|mastercard|discover|amex|other`',
    `notes` STRING COMMENT 'Additional free‑form notes about the terminal assignment.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the installation site.',
    `reason` STRING COMMENT 'Business reason for the terminal assignment (e.g., new store opening, seasonal promotion).',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score (0‑99.99) for the terminal assignment based on fraud and security factors.',
    `start_date` DATE COMMENT 'Date when the terminal assignment becomes effective.',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `terminal_model_code` STRING COMMENT 'Code representing the terminal model/type (e.g., TPOS-1000).',
    `terminal_owner` STRING COMMENT 'Internal department or business unit responsible for the terminal.',
    `terminal_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the terminal hardware.',
    `tokenization_enabled` BOOLEAN COMMENT 'Indicates whether the terminal is configured to generate payment tokens.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `created_by` STRING COMMENT 'User or system that created the assignment record.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Association entity recording the active assignment of a terminal to a specific merchant, merchant location, and POS lane or checkout position. Captures assignment start date, expected end date, assignment type (permanent, temporary, seasonal), assigned MID, site address, lane identifier, and assignment status. Enables fleet management queries such as which terminals are assigned to which merchants and supports redeployment planning.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Unique identifier for the terminal status change event.',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier of the point‑of‑sale terminal whose status changed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Status Change Audit logs the employee who performed the status change, needed for operational accountability.',
    `actor_type` STRING COMMENT 'Category of entity that triggered the status change.. Valid values are `system|operator|merchant|automated_process`',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this status event record was first created in the data lake.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this status event record.',
    `change_request_reference` STRING COMMENT 'Reference to the change‑request record that authorized the status transition.',
    `comments` STRING COMMENT 'Free‑form notes captured by the actor about the status change.',
    `compliance_status` STRING COMMENT 'Current PCI PTS compliance state of the terminal.. Valid values are `compliant|non_compliant|pending`',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the status change event was generated.',
    `firmware_version` STRING COMMENT 'Version identifier of the terminal firmware after the event.',
    `hardware_model` STRING COMMENT 'Manufacturer model number of the terminal device.',
    `incident_reference` STRING COMMENT 'Reference number of any incident or ticket linked to the status change.',
    `new_status` STRING COMMENT 'Operational state of the terminal after the change.. Valid values are `provisioned|active|suspended|decommissioned|maintenance|offline`',
    `previous_status` STRING COMMENT 'Operational state of the terminal before the change.. Valid values are `provisioned|active|suspended|decommissioned|maintenance|offline`',
    `software_version` STRING COMMENT 'Version identifier of the POS application software after the event.',
    `status_change_reason_code` STRING COMMENT 'Standardized code describing why the status transition occurred (e.g., fraud_suspicion, hardware_failure, compliance, upgrade, merchant_request).',
    `terminal_location` STRING COMMENT 'Physical location identifier (e.g., store code or address) where the terminal is installed.',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'Transactional log of terminal lifecycle status change events, capturing each transition in terminal operational state (e.g., provisioned → active → suspended → decommissioned). Records the previous status, new status, event timestamp, triggering actor (system, operator, merchant), reason code, and any associated incident or change request reference. Provides a complete audit trail of terminal state changes for compliance and operational troubleshooting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` (
    `tamper_event_id` BIGINT COMMENT 'Unique identifier for the tamper event record.',
    `analyst_employee_id` BIGINT COMMENT 'Identifier of the analyst handling the investigation.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst handling the investigation.',
    `merchant_location_id` BIGINT COMMENT 'Identifier of the physical location (store/branch) of the terminal.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the terminal where tamper was detected.',
    `alert_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert was sent.',
    `compliance_report_reference` STRING COMMENT 'Reference identifier for the compliance report generated for this event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tamper event record was created in the data lake.',
    `detection_source` STRING COMMENT 'Source mechanism that generated the tamper detection.. Valid values are `hardware_sensor|software_check|firmware_monitor|network_monitor`',
    `event_details` STRING COMMENT 'Free-text description providing additional context about the tamper event.',
    `event_sequence_number` STRING COMMENT 'Sequential number of the event for the terminal on a given day.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time when the tamper event was detected.',
    `firmware_version` STRING COMMENT 'Version of terminal firmware at time of event.',
    `investigation_end_timestamp` TIMESTAMP COMMENT 'Timestamp when investigation of the tamper event was concluded.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Timestamp when investigation of the tamper event began.',
    `investigation_status` STRING COMMENT 'Current status of the investigation into the tamper event.. Valid values are `open|in_progress|resolved|false_positive|escalated`',
    `is_alert_sent` BOOLEAN COMMENT 'Flag indicating whether an alert notification was sent to operations.',
    `is_compliance_reported` BOOLEAN COMMENT 'Indicates whether the tamper event was reported to regulatory compliance.',
    `is_test_event` BOOLEAN COMMENT 'Indicates if the event was generated from a test or simulation environment.',
    `resolution_action` STRING COMMENT 'Final resolution outcome of the tamper event.. Valid values are `confirmed_tamper|false_positive|mitigated|escalated_to_security`',
    `response_action` STRING COMMENT 'Action taken by the terminal in response to the tamper event.. Valid values are `key_zeroization|self_destruct|alert|shutdown|log_only`',
    `sensor_reference` STRING COMMENT 'Identifier of the specific sensor that triggered the tamper detection.',
    `severity_level` STRING COMMENT 'Severity rating assigned to the tamper event.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating system that supplied the event record.. Valid values are `gateway|terminal_management|fraud_platform|wallet_platform`',
    `tamper_type` STRING COMMENT 'Category of tamper detected.. Valid values are `case_open|voltage_attack|temperature_anomaly|logical_intrusion|sensor_failure|physical_damage`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tamper event record.',
    CONSTRAINT pk_tamper_event PRIMARY KEY(`tamper_event_id`)
) COMMENT 'Transactional record of a physical or logical tamper detection event triggered by a terminals PCI PTS security mechanisms. Captures event timestamp, tamper type (case open, voltage attack, temperature anomaly, logical intrusion), terminal response action (key zeroization, self-destruct, alert), detection source (hardware sensor, software check), and subsequent investigation status. Critical for PCI PTS compliance and fraud prevention.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`maintenance` (
    `maintenance_id` BIGINT COMMENT 'Unique identifier for the terminal maintenance record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Maintenance cost amounts are stored in a currency; FK to currency master supports consolidated expense reporting and audit of cross‑border maintenance fees.',
    `employee_id` BIGINT COMMENT 'Identifier of the technician who performed the maintenance.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that owns the terminal.',
    `partner_profile_id` BIGINT COMMENT 'Identifier of the entity (in‑house team or third‑party) that performed the maintenance.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the terminal device that received maintenance.',
    `technician_employee_id` BIGINT COMMENT 'Identifier of the technician who performed the maintenance.',
    `merchant_location_id` BIGINT COMMENT 'Identifier of the physical location where the terminal resides.',
    `compliance_status` STRING COMMENT 'Indicates whether the maintenance activity met internal compliance requirements.. Valid values are `compliant|non_compliant|exception`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Base cost charged for the maintenance service before taxes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance record was first created in the system.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the terminal was brought back online.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the terminal went offline for maintenance.',
    `fault_description` STRING COMMENT 'Narrative description of the fault or issue that triggered the maintenance.',
    `firmware_version` STRING COMMENT 'Version of the terminal firmware at the time of maintenance.',
    `maintenance_status` STRING COMMENT 'Current lifecycle status of the maintenance record.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `maintenance_type` STRING COMMENT 'Category of maintenance performed on the terminal.. Valid values are `preventive|corrective|emergency|unscheduled`',
    `mean_time_to_repair_minutes` STRING COMMENT 'Average time in minutes required to repair similar faults, captured for performance analysis.',
    `notes` STRING COMMENT 'Free‑form notes captured by the technician or service manager.',
    `part_replaced_details` STRING COMMENT 'Details of the part(s) replaced, including part numbers and serials.',
    `part_replaced_flag` BOOLEAN COMMENT 'Indicates whether any hardware part was replaced during the service.',
    `provider_type` STRING COMMENT 'Indicates whether maintenance was performed by internal staff or an external third‑party.. Valid values are `in_house|third_party`',
    `reference` STRING COMMENT 'Business identifier or reference number for the maintenance activity.',
    `repair_actions` STRING COMMENT 'Detailed actions taken to resolve the fault.',
    `replacement_parts` STRING COMMENT 'List of parts replaced during the maintenance activity.',
    `resolution_status` STRING COMMENT 'Current resolution state of the maintenance request.. Valid values are `resolved|unresolved|pending|failed`',
    `return_to_service_timestamp` TIMESTAMP COMMENT 'Timestamp when the terminal was returned to operational service after maintenance.',
    `scheduled_date` DATE COMMENT 'Planned date for the maintenance activity.',
    `service_date` DATE COMMENT 'Date on which the maintenance service was performed.',
    `sla_actual_time_minutes` STRING COMMENT 'Actual time in minutes taken to complete the maintenance.',
    `sla_target_time_minutes` STRING COMMENT 'Target time in minutes defined by SLA for completing the maintenance.',
    `software_version` STRING COMMENT 'Version of the terminal software/OS at the time of maintenance.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the maintenance cost.',
    `terminal_serial_number` STRING COMMENT 'Manufacturer serial number of the terminal device.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount billed for the maintenance (cost plus tax).',
    `total_downtime_minutes` STRING COMMENT 'Total minutes the terminal was unavailable due to maintenance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the maintenance record.',
    `warranty_claim_number` STRING COMMENT 'Reference number for the warranty claim associated with this maintenance, if applicable.',
    `warranty_covered_flag` BOOLEAN COMMENT 'Indicates whether the maintenance activity is covered under the terminals warranty.',
    CONSTRAINT pk_maintenance PRIMARY KEY(`maintenance_id`)
) COMMENT 'Transactional record of a maintenance or repair activity performed on a terminal device. Tracks maintenance type (preventive, corrective, emergency), fault description, repair actions taken, replacement parts used, maintenance provider (in-house, third-party), service date, resolution status, and return-to-service timestamp. Supports device health management and SLA tracking for terminal uptime commitments.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` (
    `terminal_batch_id` BIGINT COMMENT 'Unique system-generated identifier for the terminal batch record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Batch settlement totals are expressed in a currency; linking to currency master ensures correct conversion, reporting, and compliance with settlement regulations.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant owning the terminal.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal that generated the batch.',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Required for Batch Reconciliation Report that matches each terminal batch to the settlement batch that settles it.',
    `acquiring_host_batch_reference` STRING COMMENT 'Identifier assigned by the acquiring host for the corresponding settlement batch.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total of fees, discounts, or other adjustments applied to the batch.',
    `batch_type` STRING COMMENT 'Indicates how the batch was created: automatic day‑end, shift‑based, or manual entry.. Valid values are `day_end|shift|manual`',
    `close_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch was closed on the terminal.',
    `failure_reason` STRING COMMENT 'Textual description of why a batch failed settlement, if applicable.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Sum of approved transaction amounts before fees or adjustments.',
    `is_batch_reconciled` BOOLEAN COMMENT 'True if the batch has been successfully reconciled with downstream accounting.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after applying adjustments to the gross amount.',
    `open_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch was opened on the terminal.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch reconciliation was completed.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the batch record was first created in the data warehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch record.',
    `reference_code` STRING COMMENT 'External business identifier assigned to the batch by the acquiring host or settlement system.',
    `sequence_number` STRING COMMENT 'Alphanumeric sequence that orders batches chronologically for a given terminal.. Valid values are `^[A-Z0-9]+$`',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the batch within the settlement process.. Valid values are `open|closed|submitted|settled|failed`',
    `total_declined_count` STRING COMMENT 'Number of transactions within the batch that were declined.',
    `total_transaction_count` STRING COMMENT 'Number of individual transactions captured in the batch.',
    CONSTRAINT pk_terminal_batch PRIMARY KEY(`terminal_batch_id`)
) COMMENT 'Transactional record representing a settlement batch opened and closed at a terminal. Captures batch open timestamp, batch close timestamp, total transaction count, total approved amount, total declined count, batch sequence number, settlement status (open, closed, submitted, settled, failed), and the acquiring host batch reference. Links terminal-level batch activity to the settlement domain for end-of-day reconciliation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` (
    `terminal_reconciliation_id` BIGINT COMMENT 'Unique surrogate key for each terminal reconciliation record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Reconciliation amounts are in a currency; FK enables consistent financial statements and audit trails across currencies.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or service that created the record.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that owns the terminal.',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier of the POS terminal whose totals are being reconciled.',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement run against which the terminal totals are compared.',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement run against which the terminal totals are compared.',
    `merchant_location_id` BIGINT COMMENT 'Identifier of the physical location where the terminal is installed.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch that contains the transactions for this reconciliation.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user or service that performed the last update.',
    `batch_number` STRING COMMENT 'Human‑readable batch identifier used by back‑office operations.',
    `compliance_status` STRING COMMENT 'Result of compliance checks (e.g., PCI DSS) for the reconciliation batch.. Valid values are `compliant|non_compliant|exception`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first inserted.',
    `host_reported_amount` DECIMAL(18,2) COMMENT 'Total monetary value of transactions recorded by the host system.',
    `host_reported_count` STRING COMMENT 'Number of transactions recorded by the host/settlement system for the period.',
    `is_manual_adjustment` BOOLEAN COMMENT 'True if a manual adjustment was applied to resolve the variance.',
    `manual_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of any manual correction applied.',
    `manual_adjustment_reason` STRING COMMENT 'Explanation for why a manual adjustment was made.',
    `period_end_date` DATE COMMENT 'Last calendar date covered by the reconciliation period.',
    `period_start_date` DATE COMMENT 'First calendar date covered by the reconciliation period.',
    `processing_center_code` BIGINT COMMENT 'Identifier of the processing center or hub that executed the host settlement.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process.. Valid values are `balanced|out_of_balance|pending_investigation|resolved`',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Date and time when the reconciliation was performed.',
    `reference` STRING COMMENT 'External reference number assigned to the reconciliation batch for audit and tracking.',
    `resolution_notes` STRING COMMENT 'Free‑form notes documenting investigation findings and actions taken.',
    `resolution_status` STRING COMMENT 'Current status of any investigation or remediation activity.. Valid values are `unresolved|investigating|resolved|escalated`',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk rating assigned by the fraud/risk engine for this reconciliation.',
    `source_system` STRING COMMENT 'Originating system that supplied the reconciliation data. [ENUM-REF-CANDIDATE: PaymentGateway|TransactionProcessing|MerchantManagement|FraudPlatform|DigitalWallet|RiskCompliance|DisputeManagement|DataWarehouse — 8 candidates stripped; promote to reference product]',
    `terminal_firmware_version` STRING COMMENT 'Version of the firmware running on the terminal at reconciliation time.',
    `terminal_reported_amount` DECIMAL(18,2) COMMENT 'Total monetary value of transactions reported by the terminal (in transaction currency).',
    `terminal_reported_count` STRING COMMENT 'Number of transactions reported by the terminal for the period.',
    `terminal_software_version` STRING COMMENT 'Version of the application software on the terminal at reconciliation time.',
    `terminal_status_at_reconciliation` STRING COMMENT 'Operational status of the terminal when the reconciliation was performed.. Valid values are `active|inactive|decommissioned|maintenance`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between terminal and host totals (terminal - host).',
    `variance_count` STRING COMMENT 'Difference between terminal and host transaction counts (terminal - host).',
    `variance_reason_code` STRING COMMENT 'Code indicating the primary cause of the variance.. Valid values are `amount_mismatch|count_mismatch|network_error|manual_adjustment|unknown`',
    CONSTRAINT pk_terminal_reconciliation PRIMARY KEY(`terminal_reconciliation_id`)
) COMMENT 'Transactional record capturing the reconciliation outcome between terminal-reported totals and host-processed totals for a given batch or settlement period. Records terminal-reported count and amount, host-reported count and amount, variance amount, reconciliation status (balanced, out-of-balance, pending investigation), and resolution notes. Supports acquirer back-office reconciliation and dispute prevention.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` (
    `terminal_model_id` BIGINT COMMENT 'Unique identifier for the terminal hardware model.',
    `capability_id` BIGINT COMMENT 'Foreign key linking to terminal.terminal_capability. Business justification: Model references capability profile; duplicate capability fields removed.',
    `terminal_certification_id` BIGINT COMMENT 'Foreign key linking to terminal.terminal_certification. Business justification: Model linked to its certification; redundant certification fields removed.',
    `certification_date` DATE COMMENT 'Date the terminal model received its certification.',
    `compliance_status` STRING COMMENT 'Current compliance state with PCI and regulatory standards.. Valid values are `compliant|non_compliant|revoked`',
    `connectivity_options` STRING COMMENT 'Network connectivity methods available on the terminal.. Valid values are `ethernet|wifi|4g|bluetooth|cellular|satellite`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the terminal model record was first created.',
    `dimensions_mm` STRING COMMENT 'Width x Height x Depth in millimetres (e.g., 150x80x30).',
    `display_type` STRING COMMENT 'Screen technology and size (e.g., LCD 4", OLED 5").',
    `end_of_life_date` DATE COMMENT 'Date after which the terminal model is no longer supported.',
    `firmware_version` STRING COMMENT 'Version identifier of the terminal firmware.',
    `form_factor` STRING COMMENT 'Physical deployment style of the terminal.. Valid values are `countertop|portable|mpos|unattended|softpos`',
    `hardware_specifications` STRING COMMENT 'Free‑form description of key hardware components.',
    `manufacturer` STRING COMMENT 'Company that manufactures the terminal hardware.',
    `manufacturer_part_number` STRING COMMENT 'Vendor‑assigned part number for the terminal model.',
    `memory_capacity_mb` STRING COMMENT 'RAM size in megabytes.',
    `model_name` STRING COMMENT 'Human‑readable name of the terminal model.',
    `operating_temperature_celsius` STRING COMMENT 'Supported ambient temperature range, e.g., -10 to 45°C.',
    `pci_pts_version` STRING COMMENT 'PCI PIN Transaction Security version the terminal is certified to.. Valid values are `3.0|3.1|4.0`',
    `pin_pad_type` STRING COMMENT 'Type of PIN entry device (e.g., integrated, external, keypad).',
    `power_requirements_watts` DECIMAL(18,2) COMMENT 'Maximum power consumption in watts.',
    `processor_type` STRING COMMENT 'CPU or microcontroller model used in the terminal.',
    `release_date` DATE COMMENT 'Date the terminal model was first made available to customers.',
    `security_features` STRING COMMENT 'Key security capabilities (e.g., tamper‑detect, encryption, secure boot).',
    `software_version` STRING COMMENT 'Version identifier of the terminal operating software.',
    `storage_capacity_mb` STRING COMMENT 'Non‑volatile storage size in megabytes.',
    `supported_currencies` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes the terminal can handle.',
    `supported_interfaces` STRING COMMENT 'List of payment interfaces the terminal supports (e.g., EMV contact, EMV contactless, NFC, MSR, QR).',
    `supported_schemes` STRING COMMENT 'Payment card networks supported by the terminal.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `terminal_model_description` STRING COMMENT 'Narrative description of the terminal models capabilities and intended use cases.',
    `terminal_model_status` STRING COMMENT 'Lifecycle status of the terminal model record.. Valid values are `active|inactive|retired|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the terminal model record.',
    `weight_grams` STRING COMMENT 'Weight of the terminal unit in grams.',
    CONSTRAINT pk_terminal_model PRIMARY KEY(`terminal_model_id`)
) COMMENT 'Reference catalog of terminal hardware models supported by the platform. Defines manufacturer, model name, form factor (countertop, portable, mPOS, unattended, SoftPOS), supported interfaces (EMV contact, EMV contactless, NFC, MSR, QR), PIN pad type, display type, connectivity options (Ethernet, Wi-Fi, 4G, Bluetooth), PCI PTS version certified, and end-of-life date. Used to standardize device procurement and configuration management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`capability` (
    `capability_id` BIGINT COMMENT 'Unique identifier for the terminal capability profile.',
    `accessibility_features` STRING COMMENT 'Comma‑separated list of accessibility options (e.g., audio prompts, high‑contrast UI). [ENUM-REF-CANDIDATE: audio_prompt|high_contrast|large_font|braille|visual_alert] — promote to reference product',
    `capability_code` STRING COMMENT 'Business identifier code for the capability profile used in configuration and reporting.',
    `capability_description` STRING COMMENT 'Detailed description of the functional and technical characteristics of the capability.',
    `capability_name` STRING COMMENT 'Human‑readable name of the terminal capability profile.',
    `capability_status` STRING COMMENT 'Current lifecycle status of the capability profile.. Valid values are `active|inactive|deprecated|pending|retired`',
    `capability_type` STRING COMMENT 'Category of terminal that the capability applies to (e.g., point‑of‑sale, ATM, mobile POS).. Valid values are `pos|atm|mpos|kiosk|online|mobile`',
    `compliance_status` STRING COMMENT 'Current PCI/DSS compliance status of the capability profile.. Valid values are `compliant|non_compliant|pending_review`',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether contactless (tap‑to‑pay) functionality is supported.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capability record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for the maximum transaction amount.',
    `dcc_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Currency Conversion is available on the terminal.',
    `effective_from` DATE COMMENT 'Date when the capability profile becomes effective for assignment.',
    `effective_until` DATE COMMENT 'Date when the capability profile expires or is retired (null if indefinite).',
    `emv_enabled` BOOLEAN COMMENT 'Indicates whether EMV chip transaction processing is supported.',
    `encryption_key_version` STRING COMMENT 'Identifier of the encryption key version used for PIN and data encryption.',
    `firmware_version` STRING COMMENT 'Version identifier of the terminal firmware associated with this capability.',
    `hardware_model` STRING COMMENT 'Manufacturer model identifier for the terminal hardware.',
    `hce_supported` BOOLEAN COMMENT 'Indicates whether the terminal supports Host Card Emulation for mobile wallets.',
    `idle_screen_timeout_seconds` STRING COMMENT 'Number of seconds of inactivity before the terminal screen returns to idle mode.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this capability profile is the default for newly provisioned terminals of its type.',
    `language_locale` STRING COMMENT 'Locale code (e.g., en_US, fr_FR) for the terminal user interface language.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit for this capability.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of authorization retries allowed before transaction is declined.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount that can be authorized on a single transaction using this capability.',
    `multi_application_support` BOOLEAN COMMENT 'Indicates whether the terminal can host multiple payment applications simultaneously.',
    `nfc_enabled` BOOLEAN COMMENT 'Indicates whether Near Field Communication (NFC) for mobile wallets is supported.',
    `qr_payment_enabled` BOOLEAN COMMENT 'Indicates whether QR code payment method is supported.',
    `receipt_printing_mode` STRING COMMENT 'Mode of receipt output supported by the terminal.. Valid values are `paper|digital|none`',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score assigned to the capability based on fraud and security considerations.',
    `software_version` STRING COMMENT 'Version identifier of the terminal application software associated with this capability.',
    `supported_card_schemes` STRING COMMENT 'Card network schemes supported by the terminal (e.g., Visa, Mastercard, Amex, Discover). [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|unionpay] — promote to reference product',
    `supported_payment_methods` STRING COMMENT 'List of payment methods supported (e.g., chip, swipe, contactless, QR, NFC wallet). [ENUM-REF-CANDIDATE: chip|swipe|contactless|qr|nfc_wallet|magstripe|tokenized] — promote to reference product',
    `terminal_type` STRING COMMENT 'Physical form factor of the terminal (e.g., fixed, mobile, handheld, integrated).',
    `tip_prompt_enabled` BOOLEAN COMMENT 'Indicates whether the terminal can prompt for tip entry during a transaction.',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether the terminal can perform tokenization of PAN data.',
    `transaction_limit_per_day` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for transactions per day for terminals with this capability.',
    `transaction_limit_per_month` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for transactions per month for terminals with this capability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the capability record.',
    `version_number` STRING COMMENT 'Incremental version number for change management of the capability profile.',
    CONSTRAINT pk_capability PRIMARY KEY(`capability_id`)
) COMMENT 'Reference entity defining the functional capability profile of a terminal model or individual terminal, specifying supported payment methods (chip, contactless, MSR swipe, PIN, signature, QR, NFC wallet), supported card schemes, maximum transaction amount, supported currencies, multi-application support flag, and accessibility features. Used during merchant onboarding and terminal assignment to match terminal capabilities to merchant acceptance requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` (
    `terminal_alert_id` BIGINT COMMENT 'Unique identifier for each terminal alert event.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Alert Management Process requires recording which employee acknowledged the alert for traceability.',
    `merchant_location_id` BIGINT COMMENT 'Identifier of the site or store where the terminal is installed.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal or device that originated the alert.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time the alert was acknowledged by an operator or automated process.',
    `alert_category` STRING COMMENT 'Broad category used for reporting and routing (operational, security, hardware, or software).. Valid values are `operational|security|hardware|software`',
    `alert_description` STRING COMMENT 'Narrative text providing additional context or diagnostic information about the alert.',
    `alert_source` STRING COMMENT 'Specifies whether the alert was raised by an external monitoring system or reported by the terminal itself.. Valid values are `monitoring_system|terminal_self_report`',
    `alert_timestamp` TIMESTAMP COMMENT 'Date and time the alert event occurred on the terminal.',
    `alert_type` STRING COMMENT 'Categorizes the alert (e.g., connectivity loss, battery low, paper out, key expiry, certification expiry, abnormal decline rate spike).. Valid values are `connectivity_loss|battery_low|paper_out|key_expiry|cert_expiry|decline_spike`',
    `battery_level_percent` STRING COMMENT 'Remaining battery charge expressed as a percentage.',
    `cert_expiry_date` DATE COMMENT 'Date when the terminals security certification (e.g., PCI PTS) expires.',
    `compliance_status` STRING COMMENT 'Indicates whether the terminal met regulatory and security compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'When the alert record was first inserted into the data lake.',
    `decline_spike_percent` STRING COMMENT 'Percentage increase in decline rate compared to baseline, triggering a decline_spike alert.',
    `device_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the terminal hardware.',
    `escalation_reason` STRING COMMENT 'Free‑form text explaining why the alert was escalated.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time the alert was escalated to a higher tier.',
    `firmware_version` STRING COMMENT 'Version identifier of the terminal firmware when the alert was generated.',
    `is_escalated` BOOLEAN COMMENT 'True when the alert required escalation beyond first‑line support.',
    `key_expiry_date` DATE COMMENT 'Date on which the terminals encryption key is scheduled to expire.',
    `last_communication_timestamp` TIMESTAMP COMMENT 'When the terminal last successfully communicated with the gateway.',
    `last_maintenance_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent scheduled or unscheduled maintenance.',
    `network_status` STRING COMMENT 'Current network state of the terminal when the alert occurred.. Valid values are `online|offline|intermittent`',
    `paper_status` STRING COMMENT 'Indicates whether receipt paper is available or depleted.. Valid values are `ok|out`',
    `payload` STRING COMMENT 'Structured or unstructured data captured from the terminal or monitoring system.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time the underlying issue was fixed and the alert closed.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑99.99) generated by the risk management system.',
    `severity_level` STRING COMMENT 'Indicates the seriousness of the alert for prioritization.. Valid values are `info|warning|critical`',
    `software_version` STRING COMMENT 'Version identifier of the terminal application software at alert time.',
    `terminal_alert_status` STRING COMMENT 'Tracks the processing state of the alert from creation to closure.. Valid values are `open|acknowledged|resolved|closed`',
    `transaction_volume_last_hour` STRING COMMENT 'Number of transactions processed by the terminal in the hour before the alert.',
    `updated_timestamp` TIMESTAMP COMMENT 'When the alert record was last modified.',
    CONSTRAINT pk_terminal_alert PRIMARY KEY(`terminal_alert_id`)
) COMMENT 'Transactional record of an operational alert generated for a terminal, such as connectivity loss, battery low, paper out, key expiry approaching, certification expiry warning, or abnormal decline rate spike. Captures alert type, severity level, alert timestamp, terminal identifier, alert source (monitoring system, terminal self-report), acknowledgement status, acknowledged by, and resolution timestamp. Supports proactive terminal fleet health management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`connectivity` (
    `connectivity_id` BIGINT COMMENT 'Unique surrogate key for each terminal connectivity record.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: Operational monitoring maps each terminals connectivity profile to the specific network endpoint it uses for latency and SLA compliance.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the terminal to which this connectivity record belongs.',
    `apn_name` STRING COMMENT 'Access Point Name used for cellular data connections.',
    `average_latency_ms` DECIMAL(18,2) COMMENT 'Average network latency in milliseconds observed over the reporting window.',
    `backup_channel_type` STRING COMMENT 'Backup communication channel used by the terminal.. Valid values are `ethernet|wifi|cellular|dialup`',
    `backup_gateway_ip` STRING COMMENT 'Gateway IP for the backup network.',
    `backup_ip_address` STRING COMMENT 'IP address assigned to the backup channel.',
    `backup_ip_assignment_type` STRING COMMENT 'Method used to assign the backup IP address.. Valid values are `static|dhcp`',
    `backup_subnet_mask` STRING COMMENT 'Subnet mask for the backup network.',
    `cellular_signal_strength_dbm` DECIMAL(18,2) COMMENT 'Measured cellular signal strength in decibel‑millwatts.',
    `configuration_version` STRING COMMENT 'Version identifier of the connectivity configuration applied to the terminal.',
    `connectivity_category` STRING COMMENT 'Classification of the connectivity setup (single, dual, or redundant channels).. Valid values are `single|dual|redundant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the connectivity record was first created.',
    `firmware_version` STRING COMMENT 'Version of the terminal firmware governing network interfaces.',
    `last_config_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the connectivity configuration.',
    `last_heartbeat_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent heartbeat received from the terminal.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the online_status last changed.',
    `network_provider` STRING COMMENT 'Name of the telecom or ISP providing the connectivity service.',
    `notes` STRING COMMENT 'Free‑form text for operational comments or troubleshooting details.',
    `online_status` STRING COMMENT 'Current connectivity status of the terminal.. Valid values are `online|offline|degraded`',
    `primary_channel_type` STRING COMMENT 'Primary communication channel used by the terminal.. Valid values are `ethernet|wifi|cellular|dialup`',
    `primary_gateway_ip` STRING COMMENT 'Gateway IP for the primary network.',
    `primary_ip_address` STRING COMMENT 'IP address assigned to the primary channel.',
    `primary_ip_assignment_type` STRING COMMENT 'Method used to assign the primary IP address.. Valid values are `static|dhcp`',
    `primary_subnet_mask` STRING COMMENT 'Subnet mask for the primary network.',
    `profile_code` STRING COMMENT 'Business code used to reference the connectivity profile in external systems.',
    `profile_name` STRING COMMENT 'Human‑readable name for the connectivity configuration profile.',
    `sla_status` STRING COMMENT 'Service Level Agreement compliance status for connectivity.. Valid values are `met|breached|warning`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the connectivity record.',
    `uptime_pct` DECIMAL(18,2) COMMENT 'Percentage of time the terminal remained connected during the monitoring period.',
    `vpn_tunnel_code` STRING COMMENT 'Identifier of the VPN tunnel used for secure connectivity.',
    `wifi_signal_strength_dbm` DECIMAL(18,2) COMMENT 'Measured Wi‑Fi signal strength in decibel‑milliwatts.',
    `wifi_ssid` STRING COMMENT 'Service Set Identifier of the Wi‑Fi network used as primary or backup.',
    CONSTRAINT pk_connectivity PRIMARY KEY(`connectivity_id`)
) COMMENT 'Master record tracking the network connectivity configuration and real-time connectivity status of a terminal. Captures primary and backup communication channels (Ethernet, Wi-Fi SSID, 4G APN, dial-up), IP address assignment type (static/DHCP), VPN tunnel reference, last heartbeat timestamp, average latency, connectivity uptime percentage, and current online/offline status. Supports SLA monitoring and network troubleshooting for the terminal estate.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` (
    `terminal_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the terminal fee schedule record.',
    `terminal_group_id` BIGINT COMMENT 'Reference to a logical group of terminals sharing this fee schedule.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee schedule amounts are defined per currency; linking to currency master supports pricing consistency and regulatory fee disclosures.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: REQUIRED: Fee schedules assign specific GL accounts for each fee type; linking enables automated journal entry generation.',
    `pos_terminal_id` BIGINT COMMENT 'Reference to the terminal for which the fee schedule is directly applicable.',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to the detailed audit log for changes to this fee schedule.',
    `billing_cycle` STRING COMMENT 'Frequency at which the merchant is invoiced for the fee schedule.. Valid values are `monthly|quarterly|annually`',
    `billing_day_of_month` STRING COMMENT 'Numeric day of the month (1‑31) on which the invoice is generated.',
    `chargeback_handling_fee` DECIMAL(18,2) COMMENT 'Fee assessed for processing and managing chargeback events.',
    `compliance_review_date` DATE COMMENT 'Date on which the most recent regulatory compliance assessment was performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fee schedule record was first created in the system.',
    `discount_end_date` DATE COMMENT 'Date when the discount expires.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the total fee amount during the discount period.',
    `discount_start_date` DATE COMMENT 'Date when the discount becomes effective.',
    `effective_from` DATE COMMENT 'The calendar date on which the fee schedule starts to apply.',
    `effective_until` DATE COMMENT 'The calendar date on which the fee schedule ceases to apply (null for open‑ended).',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Upper limit on total fees that may be billed within the defined fee cap period.',
    `fee_cap_period` STRING COMMENT 'Timeframe over which the fee cap amount applies.. Valid values are `monthly|annual|none`',
    `fee_name` STRING COMMENT 'Descriptive name of the fee schedule for reporting and UI display.',
    `fee_schedule_code` STRING COMMENT 'External code or number used to reference the fee schedule in contracts and pricing catalogs.',
    `fee_type` STRING COMMENT 'Category of fees contained in the schedule (e.g., rental, transaction, PCI compliance, chargeback handling, surcharge, discount).. Valid values are `rental|transaction|pci|chargeback|surcharge|discount`',
    `is_tax_included` BOOLEAN COMMENT 'True if fees are tax‑inclusive; false if tax is applied on top of fees.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date and time when the fee schedule was last reviewed for compliance or pricing accuracy.',
    `monthly_rental_fee` DECIMAL(18,2) COMMENT 'Recurring flat fee charged to the merchant for terminal rental each month.',
    `notes` STRING COMMENT 'Supplementary information or comments about the fee schedule.',
    `pci_compliance_fee` DECIMAL(18,2) COMMENT 'Fee charged to cover PCI DSS compliance costs associated with the terminal.',
    `pricing_tier` STRING COMMENT 'Tier of pricing plan associated with the fee schedule.. Valid values are `standard|premium|enterprise`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the fee schedule has passed all applicable regulatory checks.',
    `review_status` STRING COMMENT 'State of the most recent review process for the fee schedule.. Valid values are `not_reviewed|in_review|approved|rejected`',
    `surcharge_fixed_amount` DECIMAL(18,2) COMMENT 'Flat surcharge applied to the terminal fee schedule, independent of transaction volume.',
    `surcharge_percentage` DECIMAL(18,2) COMMENT 'Percentage‑based surcharge applied to transaction fees.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount derived from tax_rate and taxable fees.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Percentage tax rate applied to taxable fee components.',
    `terminal_fee_schedule_description` STRING COMMENT 'Narrative description providing context or special conditions for the fee schedule.',
    `terminal_fee_schedule_status` STRING COMMENT 'Operational status indicating whether the fee schedule is currently in effect.. Valid values are `active|inactive|pending|suspended|terminated`',
    `transaction_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for each processed transaction under this schedule.',
    `transaction_fee_type` STRING COMMENT 'Indicates whether the transaction fee is a fixed amount per transaction or a percentage of the transaction value.. Valid values are `per_transaction|percentage`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the fee schedule record.',
    CONSTRAINT pk_terminal_fee_schedule PRIMARY KEY(`terminal_fee_schedule_id`)
) COMMENT 'Master record defining the fee structure applicable to a terminal or terminal group, including monthly terminal rental fee, transaction-based fees, PCI compliance fee, chargeback handling fee, and any terminal-specific surcharge configurations. Links to the merchant agreement and product pricing catalog. Enables billing of terminal-related charges to merchants as part of the acquiring relationship.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` (
    `acceptance_type_id` BIGINT COMMENT 'Unique surrogate key for each terminal acceptance type. _canonical_skip_reason: Entity is a reference lookup classification table, no minimum categories required.',
    `acceptance_type_code` STRING COMMENT 'Compact code used to identify the acceptance type in system integrations and reporting.',
    `acceptance_type_description` STRING COMMENT 'Detailed free‑text description of the acceptance type and its typical use cases.',
    `acceptance_type_name` STRING COMMENT 'Human‑readable name of the acceptance type (e.g., "Card‑Present Attended").',
    `acceptance_type_status` STRING COMMENT 'Current lifecycle status of the acceptance type.. Valid values are `active|inactive|deprecated`',
    `associated_fee_rate` DECIMAL(18,2) COMMENT 'Base interchange or service fee rate (as a decimal) associated with this acceptance type.',
    `attended_indicator` STRING COMMENT 'Specifies if the terminal is operated by a merchant employee (attended) or used by the consumer alone (unattended).. Valid values are `attended|unattended`',
    `card_presence` STRING COMMENT 'Indicates whether the card was physically present during the transaction.. Valid values are `card_present|card_not_present`',
    `compliance_requirements` STRING COMMENT 'Comma‑separated list of compliance standards applicable to this acceptance type. [ENUM-REF-CANDIDATE: PCI_DSS|EMV|SCA|3DS|PSD2|FIPS] — promote to reference product',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the acceptance type record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary limits.. Valid values are `^[A-Z]{3}$`',
    `default_flag` BOOLEAN COMMENT 'Indicates whether this acceptance type is the default for newly provisioned terminals.',
    `effective_from` DATE COMMENT 'Date from which the acceptance type becomes active.',
    `effective_until` DATE COMMENT 'Date after which the acceptance type is no longer valid (null if indefinite).',
    `entry_mode` STRING COMMENT 'Method by which card data is entered at the terminal.. Valid values are `chip|contactless|swipe|manual|fallback`',
    `firmware_version_required` STRING COMMENT 'Minimum firmware version required for the terminal to support this acceptance type.',
    `hce_supported` BOOLEAN COMMENT 'True if HCE‑based mobile payments are permitted.',
    `interchange_qualification` STRING COMMENT 'Interchange eligibility status for the acceptance type.. Valid values are `qualified|non_qualified|restricted`',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the last compliance audit performed on this acceptance type.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum allowed transaction amount for this acceptance type.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the acceptance type.',
    `regulatory_code` STRING COMMENT 'Code linking the acceptance type to specific regulatory rules (e.g., PCI, PSD2).',
    `requires_pin` BOOLEAN COMMENT 'Indicates whether a PIN entry is mandatory for this acceptance type.',
    `risk_profile` STRING COMMENT 'Risk classification used for fraud scoring and interchange qualification.. Valid values are `low|medium|high`',
    `security_cert_level` STRING COMMENT 'PCI PTS certification level required for terminals using this acceptance type.. Valid values are `level1|level2|level3|level4`',
    `software_version_required` STRING COMMENT 'Minimum software version required for the terminal to support this acceptance type.',
    `supports_contactless` BOOLEAN COMMENT 'True if contactless transactions are permitted under this acceptance type.',
    `supports_emv` BOOLEAN COMMENT 'True if EMV chip transactions are allowed.',
    `supports_nfc` BOOLEAN COMMENT 'True if NFC (near‑field communication) is enabled for this acceptance type.',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether tokenization of card data is allowed.',
    `transaction_environment` STRING COMMENT 'Broad environment where the transaction originates, aligning with interchange rules.. Valid values are `in_store|online|mobile|mpos`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the acceptance type record.',
    `version_number` STRING COMMENT 'Incremental version number for change management of the acceptance type definition.',
    CONSTRAINT pk_acceptance_type PRIMARY KEY(`acceptance_type_id`)
) COMMENT 'Reference entity classifying the payment acceptance environment and entry mode for a terminal, including card-present vs card-not-present, attended vs unattended, POS entry mode codes (chip, contactless, swipe, manual key entry, fallback), and the associated risk and interchange qualification implications. Used to correctly classify transactions for interchange optimization and fraud risk assessment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` (
    `p2pe_scope_id` BIGINT COMMENT 'Unique surrogate key for each P2PE scope record.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that owns or operates the terminal.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal to which this P2PE scope applies.',
    `certificate_expiry_date` DATE COMMENT 'Expiration date of the P2PE certificate.',
    `compliance_reduction_flag` BOOLEAN COMMENT 'Indicates whether the terminals validated P2PE scope reduces the merchants PCI DSS scope (true = reduction).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the P2PE scope record was initially created.',
    `decryption_environment` STRING COMMENT 'Environment where encrypted transaction data is decrypted (HSM, secure module, or cloud service).. Valid values are `hsm|secure_module|cloud`',
    `encryption_domain` STRING COMMENT 'Scope of encryption implementation for the terminal (hardware, software, or cloud based).. Valid values are `hardware|software|cloud`',
    `encryption_key_version` STRING COMMENT 'Version identifier of the encryption key used by the terminal.',
    `hsm_location` STRING COMMENT 'Physical or logical location of the Hardware Security Module that stores decryption keys.',
    `key_management_approach` STRING COMMENT 'Method used to manage encryption keys for the P2PE solution.. Valid values are `symmetric|asymmetric|hybrid`',
    `notes` STRING COMMENT 'Free‑form notes regarding the P2PE scope, exceptions, or special handling.',
    `p2pe_certificate_reference` STRING COMMENT 'Unique identifier of the P2PE compliance certificate assigned to the terminal.',
    `p2pe_solution_name` STRING COMMENT 'Descriptive name of the specific P2PE solution offering.',
    `p2pe_solution_provider` STRING COMMENT 'Name of the vendor that supplies the validated Point‑to‑Point Encryption solution.',
    `p2pe_solution_version` STRING COMMENT 'Version identifier of the P2PE solution used for the terminal.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score assigned to the terminal based on P2PE compliance and security posture.',
    `scope_expiration_date` DATE COMMENT 'Date when the current P2PE scope validation expires, if applicable.',
    `scope_last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the terminals P2PE scope.',
    `scope_status` STRING COMMENT 'Current lifecycle status of the P2PE scope for the terminal.. Valid values are `validated|pending|revoked|expired`',
    `scope_validation_date` DATE COMMENT 'Date on which the terminals P2PE scope was validated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the P2PE scope record.',
    `validation_audit_reference` STRING COMMENT 'Reference number linking to the audit report that validated the P2PE scope.',
    `validation_audit_timestamp` TIMESTAMP COMMENT 'Timestamp when the validation audit was performed.',
    CONSTRAINT pk_p2pe_scope PRIMARY KEY(`p2pe_scope_id`)
) COMMENT 'Master record documenting the PCI P2PE (Point-to-Point Encryption) scope and configuration for a terminal, including the P2PE solution provider, solution listing reference, encryption domain, decryption environment, key management approach, and scope validation date. Tracks whether a terminal is within a validated P2PE solution, which directly impacts the merchants PCI DSS scope reduction. Critical for compliance and merchant PCI program management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` (
    `surcharge_config_id` BIGINT COMMENT 'Unique identifier for the terminal surcharge configuration record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Surcharge rates are set per currency; FK to currency master allows correct calculation and compliance with jurisdictional surcharge rules.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Surcharge configuration includes jurisdiction country code; FK to country master enables jurisdiction‑specific surcharge compliance and reporting.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal to which this surcharge configuration applies.',
    `applicable_card_scheme` STRING COMMENT 'Card network(s) to which the surcharge configuration applies.. Valid values are `visa|mastercard|amex|discover|unionpay|other`',
    `applicable_product_type` STRING COMMENT 'Card product category (e.g., consumer, commercial) for which the surcharge is valid.. Valid values are `consumer|commercial|corporate|government|private|other`',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the configuration against PCI DSS, Visa, Mastercard, and regional regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `config_code` STRING COMMENT 'External business code used to reference the surcharge configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the surcharge configuration record was first created.',
    `effective_from` DATE COMMENT 'Date on which the surcharge configuration becomes active.',
    `effective_until` DATE COMMENT 'Date on which the surcharge configuration expires or is superseded (null if open‑ended).',
    `is_default` BOOLEAN COMMENT 'Indicates whether this configuration is the default for the terminal when multiple configs exist.',
    `jurisdiction_state_code` STRING COMMENT 'Two‑letter state code defining the jurisdictional scope of the surcharge (U.S. only).. Valid values are `^[A-Z]{2}$`',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper transaction amount threshold beyond which the surcharge is not applied.',
    `merchant_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the merchant has satisfied disclosure compliance for this surcharge configuration.',
    `notes` STRING COMMENT 'Free‑form notes for operational or compliance comments.',
    `regulatory_disclosure_required` BOOLEAN COMMENT 'Indicates whether regulatory rules require the merchant to disclose the surcharge to the cardholder.',
    `risk_score` STRING COMMENT 'Numeric risk rating (0‑100) reflecting regulatory or fraud risk associated with the surcharge configuration.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount applied when surcharge_mode is fixed_amount.',
    `surcharge_application_rule` STRING COMMENT 'Rule defining how the surcharge is aggregated across transactions.. Valid values are `per_transaction|per_batch|per_day`',
    `surcharge_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total surcharge amount that can be applied to a single transaction.',
    `surcharge_cap_percentage` DECIMAL(18,2) COMMENT 'Maximum surcharge expressed as a percentage of the transaction amount.',
    `surcharge_config_description` STRING COMMENT 'Human‑readable description of the surcharge rules and purpose.',
    `surcharge_config_status` STRING COMMENT 'Current lifecycle status of the surcharge configuration.. Valid values are `active|inactive|pending|retired`',
    `surcharge_mode` STRING COMMENT 'Indicates whether the surcharge is calculated as a percentage of the transaction amount or as a fixed monetary amount.. Valid values are `percentage|fixed_amount`',
    `surcharge_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to the transaction amount when surcharge_mode is percentage.',
    `surcharge_type` STRING COMMENT 'Category of payment instrument for which the surcharge is defined.. Valid values are `credit_card|debit_card|prepaid|digital_wallet|other`',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the surcharge configuration.',
    `version_number` STRING COMMENT 'Incremental version number for change management and audit.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_surcharge_config PRIMARY KEY(`surcharge_config_id`)
) COMMENT 'Master configuration record defining surcharging rules applied at a terminal, including surcharge type (credit card surcharge, convenience fee), surcharge rate or fixed amount, applicable card schemes and product types, regulatory jurisdiction constraints (e.g., state-level surcharge restrictions in the US), merchant disclosure compliance flag, and effective date range. Governs how surcharges are applied and disclosed at the point of sale.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` (
    `receipt_template_id` BIGINT COMMENT 'Unique system-generated identifier for the receipt template.',
    `compliance_requirements` STRING COMMENT 'Textual description of regulatory receipt requirements (e.g., PCI DSS, local tax law).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the template record was first created.',
    `digital_delivery_options` STRING COMMENT 'Channels through which a digital copy of the receipt may be sent.. Valid values are `email|sms|none`',
    `effective_from` DATE COMMENT 'Date on which the template becomes active for use.',
    `effective_until` DATE COMMENT 'Date after which the template is no longer valid (null if indefinite).',
    `email_template_reference` BIGINT COMMENT 'Reference to the email template used for digital receipt delivery.',
    `footer_text` STRING COMMENT 'Custom text displayed in the receipt footer when include_footer is true.',
    `header_text` STRING COMMENT 'Custom text displayed in the receipt header when include_header is true.',
    `include_aid` BOOLEAN COMMENT 'Whether the EMV Application Identifier (AID) is displayed.',
    `include_approval_code` BOOLEAN COMMENT 'Whether the authorization approval code is printed.',
    `include_card_scheme_logo` BOOLEAN COMMENT 'Whether the logo of the card scheme (Visa, Mastercard, etc.) is printed.',
    `include_currency_code` BOOLEAN COMMENT 'Whether the ISO 4217 currency code is displayed.',
    `include_footer` BOOLEAN COMMENT 'Indicates whether a footer section is printed on the receipt.',
    `include_header` BOOLEAN COMMENT 'Indicates whether a header section is printed on the receipt.',
    `include_masked_pan` BOOLEAN COMMENT 'Whether a masked Primary Account Number (e.g., ****1234) is displayed.',
    `include_merchant_address` BOOLEAN COMMENT 'Whether the merchants address is displayed on the receipt.',
    `include_merchant_name` BOOLEAN COMMENT 'Whether the merchants legal name is shown on the receipt.',
    `include_tip` BOOLEAN COMMENT 'Whether a tip line is included on the receipt.',
    `include_total` BOOLEAN COMMENT 'Whether the final total (including tip) is displayed.',
    `include_transaction_amount` BOOLEAN COMMENT 'Whether the transaction amount is printed on the receipt.',
    `include_tvr` BOOLEAN COMMENT 'Whether the Terminal Verification Results (TVR) are printed.',
    `language_locale` STRING COMMENT 'Locale identifier (e.g., en-US) that determines language and formatting of the receipt.',
    `line_item_separator` STRING COMMENT 'Character or string used to separate individual line items.. Valid values are `dash|asterisk|none`',
    `max_line_items` STRING COMMENT 'Maximum number of item lines that the template can render.',
    `paper_length_mm` STRING COMMENT 'Maximum printable length per receipt in millimetres.',
    `paper_width_mm` STRING COMMENT 'Physical width of the paper roll in millimetres.',
    `qr_code_data_type` STRING COMMENT 'Type of data encoded in the QR code when enabled.. Valid values are `url|text|payment`',
    `qr_code_enabled` BOOLEAN COMMENT 'Indicates whether a QR code is printed on the receipt.',
    `receipt_format` STRING COMMENT 'Delivery format of the receipt – printed paper, digital only, or both.. Valid values are `paper|digital|both`',
    `receipt_template_status` STRING COMMENT 'Current lifecycle status of the template.. Valid values are `active|inactive|deprecated|pending`',
    `sms_template_reference` BIGINT COMMENT 'Reference to the SMS template used for digital receipt delivery.',
    `template_code` STRING COMMENT 'Business code used to reference the template in configuration and reporting.',
    `template_name` STRING COMMENT 'Human‑readable name of the receipt layout template.',
    `template_type` STRING COMMENT 'Classification of the template – standard provided by the platform, custom built for a merchant, or partner‑specific.. Valid values are `standard|custom|partner`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the template.',
    `version_number` STRING COMMENT 'Incremental version of the receipt template for change management.',
    CONSTRAINT pk_receipt_template PRIMARY KEY(`receipt_template_id`)
) COMMENT 'Master record defining the receipt layout and content template configured for a terminal, including header/footer text, merchant name and address display, itemized field inclusion (transaction amount, tip, total, card scheme logo, masked PAN, approval code, AID, TVR), language locale, paper width, and digital receipt delivery options (email, SMS). Supports regulatory receipt requirements and merchant branding.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`downtime` (
    `downtime_id` BIGINT COMMENT 'Unique identifier for each terminal downtime record.',
    `merchant_location_id` BIGINT COMMENT 'Identifier of the physical location where the terminal resides.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal experiencing downtime.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Downtime Incident Report captures the employee who reported the outage, supporting root‑cause analysis and SLA reporting.',
    `actual_affected_transactions` BIGINT COMMENT 'Measured number of transactions missed or failed due to the downtime.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime record was first created.',
    `downtime_category` STRING COMMENT 'Classification of the downtime cause.. Valid values are `hardware_fault|software_failure|connectivity_loss|planned_maintenance|key_expiry`',
    `downtime_source` STRING COMMENT 'Origin of the downtime detection (automated system, manual report, or partner).. Valid values are `system|manual|partner`',
    `downtime_status` STRING COMMENT 'Current lifecycle status of the downtime record.. Valid values are `open|closed|in_progress`',
    `end_timestamp` TIMESTAMP COMMENT 'Exact time when the terminal downtime ended or was resolved.',
    `escalation_level` STRING COMMENT 'Level of escalation triggered for the downtime incident.. Valid values are `none|low|medium|high|critical`',
    `estimated_affected_transactions` BIGINT COMMENT 'Projected number of transactions that could not be processed during the downtime.',
    `external_incident_reference` STRING COMMENT 'Identifier of the incident in an external ticketing or monitoring system.',
    `firmware_version` STRING COMMENT 'Firmware version installed on the terminal at the time of downtime.',
    `is_critical_terminal` BOOLEAN COMMENT 'Indicates whether the terminal is classified as critical for business operations.',
    `network_connectivity_type` STRING COMMENT 'Primary network connection type used by the terminal.. Valid values are `wired|wifi|cellular|satellite`',
    `notes` STRING COMMENT 'Free‑form notes captured by the support team.',
    `reason_code` STRING COMMENT 'Standardized code representing the reason for downtime.',
    `report_timestamp` TIMESTAMP COMMENT 'Time when the downtime was reported into the system.',
    `reported_via` STRING COMMENT 'Channel through which the downtime was reported.. Valid values are `api|portal|phone|email`',
    `resolution_action` STRING COMMENT 'Action taken to resolve the downtime incident.',
    `resolution_status` STRING COMMENT 'Current resolution state of the downtime incident.. Valid values are `resolved|unresolved|pending`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Time when the downtime was marked as resolved.',
    `risk_score` STRING COMMENT 'Risk score assigned to the downtime event based on impact and frequency.',
    `root_cause` STRING COMMENT 'Narrative description of the underlying cause of the downtime.',
    `root_cause_category` STRING COMMENT 'High‑level category of the root cause.. Valid values are `hardware|software|network|configuration|environment|other`',
    `severity_level` STRING COMMENT 'Impact severity of the downtime on operations.. Valid values are `low|medium|high|critical`',
    `sla_actual_minutes` STRING COMMENT 'Actual downtime duration in minutes measured against SLA target.',
    `sla_compliance` STRING COMMENT 'Whether the downtime met or breached the SLA target.. Valid values are `met|breached`',
    `sla_target_minutes` STRING COMMENT 'Maximum allowed downtime duration in minutes as per SLA.',
    `software_version` STRING COMMENT 'Software version (including OS) running on the terminal during the incident.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact time when the terminal downtime began.',
    `ticket_number` STRING COMMENT 'Internal support ticket number associated with the downtime.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the downtime record.',
    CONSTRAINT pk_downtime PRIMARY KEY(`downtime_id`)
) COMMENT 'Transactional record capturing planned or unplanned terminal downtime periods, including downtime start and end timestamps, downtime category (hardware fault, software failure, connectivity loss, planned maintenance, key expiry), impact severity, affected transaction count estimate, resolution action taken, and root cause classification. Supports SLA reporting, uptime calculation, and operational incident management for the terminal fleet.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` (
    `digital_wallet_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each digital wallet record.',
    `account_holder_id` BIGINT COMMENT 'Reference to the person or entity that owns the wallet.',
    `cardholder_profile_id` BIGINT COMMENT 'Reference to the person or entity that owns the wallet.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Required for regulatory reporting and settlement; mapping wallet currency to reference.currency enables currency conversion rates and compliance.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Needed to attribute each digital wallet to its issuing partner for regulatory compliance, KYC/AML oversight, and partner‑level usage analytics.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Payroll Disbursement: Salary is credited to an employees digital wallet, requiring a direct link from wallet.digital_wallet.employee_id to workforce.employee.employee_id for reconciliation reports.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory reporting mandates mapping each digital wallet to its owning legal entity for AML/KYC and financial statements.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Required for linking each merchant to its own digital wallet for payout processing, settlement reporting, and KYC compliance; merchants own a wallet that holds funds.',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.interchange_program. Business justification: Digital wallets enroll in specific interchange programs that define fee structures; enrollment must be tracked for compliance and revenue recognition.',
    `balance_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the wallet is eligible to hold a stored‑value balance.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the wallet record was first created in the system.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for transactions within a 24‑hour period.',
    `device_provisioning_status` STRING COMMENT 'Status of the device provisioning process for the wallet.. Valid values are `provisioned|failed|pending`',
    `effective_end_date` DATE COMMENT 'Date when the wallet ceased to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the wallet became effective for use.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the wallet has been flagged for suspected fraud.',
    `fraud_reason_code` STRING COMMENT 'Code describing the reason for a fraud flag (e.g., suspicious_activity, stolen_device).',
    `is_3ds_enrolled` BOOLEAN COMMENT 'Indicates whether the wallet is enrolled in 3‑Domain Secure authentication.',
    `is_contactless_enabled` BOOLEAN COMMENT 'Indicates whether the wallet supports contactless payments.',
    `is_hce_enabled` BOOLEAN COMMENT 'Indicates whether the wallet uses Host Card Emulation for tokenized payments.',
    `is_nfc_enabled` BOOLEAN COMMENT 'Indicates whether Near‑Field Communication is enabled for the wallet.',
    `is_sca_compliant` BOOLEAN COMMENT 'Indicates compliance with SCA requirements for the wallet.',
    `issuer_bin` STRING COMMENT 'First six digits of the issuing banks number range that issued the underlying payment instrument.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent successful transaction or interaction with the wallet.',
    `last_tokenization_timestamp` TIMESTAMP COMMENT 'Date‑time when the wallet was most recently tokenized or re‑tokenized.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time when any attribute of the wallet record was last modified.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum single transaction amount allowed for this wallet.',
    `monthly_transaction_limit` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for transactions within a calendar month.',
    `pci_dss_compliant` BOOLEAN COMMENT 'Indicates whether the wallet meets PCI DSS security standards.',
    `provisioning_channel` STRING COMMENT 'Channel through which the wallet was provisioned (e.g., mobile app, web portal, partner integration, API).. Valid values are `app|web|partner|api`',
    `psd2_compliant` BOOLEAN COMMENT 'Indicates whether the wallet complies with EU PSD2 regulatory requirements.',
    `regulatory_jurisdiction` STRING COMMENT 'Three‑letter country code indicating the primary regulatory jurisdiction for the wallet.. Valid values are `^[A-Z]{3}$`',
    `risk_score` STRING COMMENT 'Numerical risk rating assigned to the wallet based on fraud and compliance models.',
    `stored_value_balance` DECIMAL(18,2) COMMENT 'Current monetary balance held in the wallet for stored‑value transactions.',
    `token_service_provider` STRING COMMENT 'Name of the third‑party provider that issues tokens for the wallet.',
    `tokenization_status` STRING COMMENT 'Current status of tokenization for the wallet.. Valid values are `active|inactive|revoked`',
    `wallet_description` STRING COMMENT 'Free‑form description or notes about the wallet instance.',
    `wallet_name` STRING COMMENT 'Human‑readable name or label for the wallet, often shown to the cardholder in UI.',
    `wallet_number` STRING COMMENT 'External business identifier assigned to the wallet instance, used in communications with partners and regulators.',
    `wallet_scheme` STRING COMMENT 'Payment network scheme associated with the wallet (e.g., Visa, Mastercard).. Valid values are `visa|mastercard|discover|amex|unionpay`',
    `wallet_status` STRING COMMENT 'Current lifecycle state of the wallet instance.. Valid values are `active|suspended|closed|pending`',
    `wallet_tier` STRING COMMENT 'Business tier of the wallet, reflecting service level and fee structure.. Valid values are `standard|premium|enterprise`',
    `wallet_type` STRING COMMENT 'Category of wallet based on the provider or technology (e.g., Apple Pay, Google Pay, proprietary).. Valid values are `apple_pay|google_pay|proprietary`',
    `wallet_version` STRING COMMENT 'Version identifier of the wallet software/firmware configuration.',
    CONSTRAINT pk_digital_wallet PRIMARY KEY(`digital_wallet_id`)
) COMMENT 'Master record for a consumer or business digital wallet instance — the primary entity in the wallet domain. Captures wallet type (Apple Pay, Google Pay, proprietary), wallet status (active, suspended, closed), wallet scheme, issuer BIN, cardholder reference, provisioning channel, wallet tier, currency, balance eligibility flag, creation timestamp, last activity timestamp, and regulatory jurisdiction. SSOT for wallet identity and lifecycle.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` (
    `wallet_token_id` BIGINT COMMENT 'System-generated unique identifier for the wallet token record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the issuing bank or entity for the underlying FPAN.',
    `partner_profile_id` BIGINT COMMENT 'Unique identifier of the issuing bank or entity for the underlying FPAN.',
    `token_requestor_id` BIGINT COMMENT 'Identifier of the entity (e.g., Apple Pay, Google Pay) that requested the token.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the device to which the token is bound (if applicable).',
    `assurance_level` STRING COMMENT 'Risk‑based confidence level assigned to the token (e.g., low, medium, high).. Valid values are `low|medium|high`',
    `compliance_check_code` STRING COMMENT 'Code representing the outcome or reason of the latest compliance check.',
    `compliance_check_passed` BOOLEAN COMMENT 'Result of the most recent compliance validation (e.g., PCI, PSD2) for the token.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the token record was first created in the system.',
    `fpan_bin` STRING COMMENT 'First six digits of the underlying Financial PAN identifying the issuing bank and card scheme.',
    `fpan_last4` STRING COMMENT 'Last four digits of the underlying Financial PAN for reference and reconciliation.',
    `is_restricted_token` BOOLEAN COMMENT 'Flag indicating whether the token is subject to additional regulatory or contractual restrictions.',
    `is_test_token` BOOLEAN COMMENT 'Flag indicating whether the token is used for testing purposes only.',
    `last_used_location_country` STRING COMMENT 'Three‑letter ISO country code where the token was last used.',
    `provisioning_timestamp` TIMESTAMP COMMENT 'Date‑time when the token was provisioned onto the device or cloud environment.',
    `token` STRING COMMENT 'Masked Device Primary Account Number (DPAN) representing the tokenized payment credential stored in the digital wallet.',
    `token_expiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the token is scheduled to expire and become invalid.',
    `token_issue_timestamp` TIMESTAMP COMMENT 'Date‑time when the token was initially provisioned.',
    `token_last_used_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent transaction that utilized this token.',
    `token_scheme` STRING COMMENT 'Payment network scheme associated with the token.. Valid values are `visa|mastercard|amex|discover|other`',
    `token_service_provider` STRING COMMENT 'Organization that issued and manages the token.',
    `token_status` STRING COMMENT 'Current lifecycle state of the token.. Valid values are `active|suspended|deleted`',
    `token_type` STRING COMMENT 'Classification of the token based on its provisioning model: device‑bound, cloud‑hosted, or ecommerce.. Valid values are `device|cloud|ecommerce`',
    `token_usage_count` STRING COMMENT 'Cumulative number of successful transactions performed with this token.',
    `token_version` STRING COMMENT 'Version number of the token record, incremented on each re‑issuance or update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the token record.',
    CONSTRAINT pk_wallet_token PRIMARY KEY(`wallet_token_id`)
) COMMENT 'TSP-issued payment token (DPAN) record representing a tokenized payment credential stored in a digital wallet. Captures DPAN value (masked), FPAN reference (masked), token requestor ID, token requestor name (Apple Pay, Google Pay, Samsung Pay), token type (device, cloud HCE, ecommerce), token status (active, suspended, deleted), token expiry, assurance level, last four of FPAN, BIN, issuer ID, device ID reference, provisioning timestamp, and last used timestamp. Core to the tokenization platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` (
    `token_requestor_id` BIGINT COMMENT 'Unique system-generated identifier for the token requestor.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the token service provider that issues DPANs for this requestor.',
    `partner_profile_id` BIGINT COMMENT 'Identifier of the token service provider that issues DPANs for this requestor.',
    `address_line1` STRING COMMENT 'First line of the token requestors physical address.',
    `address_line2` STRING COMMENT 'Second line of the token requestors physical address, if applicable.',
    `allowed_token_types` STRING COMMENT 'Comma‑separated list of token types (e.g., DPAN, TPAN) the requestor is authorized to request.',
    `api_endpoint` STRING COMMENT 'Base URL of the requestors API used for token request calls.',
    `certificate_fingerprint` STRING COMMENT 'SHA‑256 fingerprint of the TLS certificate presented by the requestor.. Valid values are `[A-Fa-f0-9]{64}`',
    `city` STRING COMMENT 'City component of the token requestors address.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the requestor with applicable regulations and standards.. Valid values are `compliant|non_compliant|pending_review`',
    `contact_email` STRING COMMENT 'Primary email address for communications with the token requestor.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for the token requestor.',
    `contractual_agreement_reference` STRING COMMENT 'Reference identifier for the legal agreement governing token requestor activities.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the token requestors primary location.. Valid values are `[A-Z]{3}`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the token requestor record was first created in the system.',
    `daily_token_request_count` STRING COMMENT 'Running count of token requests submitted by the requestor for the current day.',
    `data_retention_period_days` STRING COMMENT 'Number of days the requestors token request data must be retained per regulatory policy.',
    `is_test_requestor` BOOLEAN COMMENT 'Indicates whether the requestor is a test/sandbox entity used for development.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the requestors operational status.',
    `max_token_requests_per_day` STRING COMMENT 'Upper limit on the number of token requests the requestor may submit in a single day.',
    `onboarding_date` DATE COMMENT 'Date the requestor was approved and added to the token requestor registry.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the token requestors address.',
    `privacy_consent_given` BOOLEAN COMMENT 'Indicates whether the requestor has provided required privacy consent for data processing.',
    `requestor_type` STRING COMMENT 'Classification of the requestor based on its business role.. Valid values are `wallet_provider|merchant|issuer|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating assigned to the requestor based on historical behavior and risk models.',
    `scheme_affiliation` STRING COMMENT 'Payment scheme with which the requestor is affiliated for token issuance.. Valid values are `visa_vts|mastercard_mdes|other`',
    `state` STRING COMMENT 'State or province component of the token requestors address.',
    `token_requestor_name` STRING COMMENT 'Human‑readable name of the token requestor organization or entity.',
    `token_requestor_status` STRING COMMENT 'Operational status of the token requestor within the tokenization ecosystem.. Valid values are `active|inactive|suspended|pending|revoked`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the token requestor record.',
    CONSTRAINT pk_token_requestor PRIMARY KEY(`token_requestor_id`)
) COMMENT 'Master registry of authorized token requestors (TRs) permitted to request DPANs from the TSP token vault. Captures token requestor ID (EMVCo-assigned), requestor name, requestor type (wallet provider, merchant, issuer), scheme affiliation (Visa VTS, Mastercard MDES), API endpoint, certificate fingerprint, onboarding date, status, and contractual agreement reference. Governs which entities can initiate tokenization requests.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` (
    `wallet_device_id` BIGINT COMMENT 'System-generated unique identifier for the wallet device record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet to which this device is bound.',
    `binding_timestamp` TIMESTAMP COMMENT 'When the device was first linked to the wallet.',
    `compliance_flags` STRING COMMENT 'Pipe‑separated list of compliance checks passed/failed (e.g., pci_dss|psd2).',
    `created_timestamp` TIMESTAMP COMMENT 'When the device record was first created in the system.',
    `decommission_timestamp` TIMESTAMP COMMENT 'Timestamp when the device was retired or removed from service.',
    `device_fingerprint_hash` STRING COMMENT 'Hash of the device fingerprint used for fraud risk analytics.',
    `device_identifier` STRING COMMENT 'Unique device identifier linked to the DPAN; used for tokenization and device‑level risk scoring.',
    `device_owner_type` STRING COMMENT 'Indicates whether the device is owned by an individual consumer or a business entity.. Valid values are `individual|business`',
    `device_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number for the device.',
    `device_type` STRING COMMENT 'Category of the consumer device (e.g., mobile phone, wearable, tablet, IoT).. Valid values are `mobile|wearable|tablet|iot`',
    `firmware_version` STRING COMMENT 'Version identifier of the device firmware at the time of last update.',
    `geolocation_city` STRING COMMENT 'City name associated with the devices last known location.',
    `geolocation_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the device was last observed.',
    `hce_enabled` BOOLEAN COMMENT 'True if the device can perform Host Card Emulation for tokenized payments.',
    `imei` STRING COMMENT 'Unique hardware identifier for mobile devices.',
    `is_test_device` BOOLEAN COMMENT 'True if the device is used in testing environments and not for production transactions.',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent activity or heartbeat received from the device.',
    `mac_address` STRING COMMENT 'Network interface MAC address of the device.',
    `model_name` STRING COMMENT 'Manufacturer model designation of the device (e.g., iPhone 13, Galaxy S22).',
    `nfc_capable` BOOLEAN COMMENT 'Indicates whether the device supports Near Field Communication for tap‑to‑pay.',
    `os_name` STRING COMMENT 'Name of the operating system running on the device (e.g., Android, iOS).',
    `os_version` STRING COMMENT 'Version string of the operating system (e.g., 14.4, 12).',
    `provisioning_status` STRING COMMENT 'Current status of secure element provisioning for the device.. Valid values are `pending|completed|failed`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) derived from device behavior and fraud models.',
    `secure_element_type` STRING COMMENT 'Type of secure element used for cryptographic operations (embedded SE, Host Card Emulation, SIM‑based).. Valid values are `embedded|hce|sim`',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., reason for suspension).',
    `updated_timestamp` TIMESTAMP COMMENT 'When the device record was last modified.',
    `wallet_device_status` STRING COMMENT 'Current lifecycle state of the device within the wallet ecosystem.. Valid values are `active|suspended|lost|stolen|decommissioned`',
    CONSTRAINT pk_wallet_device PRIMARY KEY(`wallet_device_id`)
) COMMENT 'Consumer payment device registered to a digital wallet — mobile phone, wearable, tablet, or IoT device. Captures device ID (DPAN-linked), device type, device OS and version, device model, NFC capability flag, secure element type (embedded SE, HCE, SIM-based), device fingerprint hash, device status (active, suspended, lost, stolen), last seen timestamp, geolocation country, and device binding timestamp. Supports device lifecycle management and fraud risk signals.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` (
    `provisioning_request_id` BIGINT COMMENT 'System-generated unique identifier for the provisioning request event.',
    `digital_wallet_id` BIGINT COMMENT 'Unique identifier of the digital wallet receiving the tokenized credential.',
    `token_requestor_id` BIGINT COMMENT 'Identifier of the Token Service Provider (TSP) that initiated the tokenization request.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the device (e.g., mobile, POS) from which the provisioning request originated.',
    `compliance_check_code` STRING COMMENT 'Code representing the specific compliance rule or policy evaluated for the request.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the request satisfied all applicable AML/KYC/PCI compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the provisioning request record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for any monetary amounts associated with the request.',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp when the issuer rendered its decision for the provisioning request.',
    `decline_reason_code` STRING COMMENT 'Standardized code explaining why the issuer declined the provisioning request.',
    `device_fingerprint` STRING COMMENT 'Hash or token representing the unique characteristics of the device used for provisioning.',
    `external_request_reference` STRING COMMENT 'Identifier supplied by the originating system or partner for cross‑system traceability.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the token service provider for processing the provisioning request.',
    `fpan_masked` STRING COMMENT 'Masked representation of the Primary Account Number (e.g., 1234******5678) used for audit and display while complying with PCI DSS.',
    `ip_address` STRING COMMENT 'IP address from which the provisioning request was initiated.',
    `is_test_request` BOOLEAN COMMENT 'True if the provisioning request was generated in a test or sandbox environment.',
    `issuer_decision` STRING COMMENT 'Final decision returned by the issuing bank: approved, declined, or step‑up required.. Valid values are `approved|declined|step_up_required`',
    `location_country` STRING COMMENT 'Three‑letter ISO country code of the requesters location.',
    `provisioning_channel` STRING COMMENT 'Channel through which the provisioning request was submitted: over‑the‑air (OTA), in‑app, or manual entry.. Valid values are `OTA|in_app|manual`',
    `provisioning_method` STRING COMMENT 'Operational path used for provisioning: green (standard), yellow (conditional), or red (exception) flow.. Valid values are `green_path|yellow_path|red_path`',
    `provisioning_request_status` STRING COMMENT 'Current lifecycle status of the provisioning request.. Valid values are `pending|completed|failed|cancelled`',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the provisioning request was initially submitted.',
    `risk_score` STRING COMMENT 'Numeric risk rating assigned to the request by the fraud detection engine.',
    `sca_outcome` STRING COMMENT 'Result of the SCA check required for the provisioning request.. Valid values are `success|failure|not_applicable`',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the provisioning request record.',
    `step_up_method` STRING COMMENT 'Method used to satisfy a step‑up requirement: one‑time password, biometric, or call‑center verification.. Valid values are `OTP|biometric|call_center`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the provisioning request record.',
    CONSTRAINT pk_provisioning_request PRIMARY KEY(`provisioning_request_id`)
) COMMENT 'Transactional record of each tokenization provisioning request submitted to the TSP — the event of adding a payment credential to a digital wallet. Captures request ID, wallet ID, device ID, FPAN reference (masked), token requestor ID, provisioning channel (OTA, in-app, manual), provisioning method (green path, yellow path, red path), issuer decision (approved, declined, step-up required), step-up method (OTP, biometric, call center), decision timestamp, decline reason code, and SCA outcome. Critical audit trail for PCI DSS and EMVCo compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` (
    `wallet_transaction_id` BIGINT COMMENT 'Unique identifier for the wallet transaction record.',
    `authorization_response_code_id` BIGINT COMMENT 'Foreign key linking to reference.authorization_response_code. Business justification: Authorization response codes map to reference.authorization_response_code for dispute handling and reporting.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Card scheme identification links to reference.reference_card_scheme for scheme-specific processing and compliance.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Dispute handling and compliance reporting need the cardholder profile associated with each wallet transaction.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Transaction currency reporting and FX calculations rely on reference.currency to fetch exchange rates and compliance data.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet used for the transaction.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Corporate Transaction Audit: Internal audit needs to know which employee authorized or performed a wallet transaction, linking wallet.wallet_transaction.employee_id to workforce.employee.employee_id.',
    `irf_table_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_table. Business justification: Required for interchange fee reporting: each wallet transaction must reference the IRF rate record used to calculate fees for settlement and audit.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Audit and reconciliation require each wallet transaction to be linked to the corresponding GL journal entry that records the financial impact.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: Transaction MCC classification uses reference.mcc for risk scoring and reporting.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant where the transaction occurred.',
    `network_routing_rule_id` BIGINT COMMENT 'Foreign key linking to network.network_routing_rule. Business justification: REQUIRED: Compliance checks need the specific network routing rule that governed the transaction for traceability.',
    `original_transaction_wallet_transaction_id` BIGINT COMMENT 'Reference to the original transaction for reversals or adjustments.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Transaction routing and fee logic depend on the payment corridor definition; linking each transaction to its corridor enables accurate fee schedules and regulatory checks.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Transaction processing uses a payment product; needed for product‑level revenue, risk and regulatory reporting.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Required for settlement audit: each transaction must reference the exact FX rate record used for currency conversion, enabling regulatory reporting and dispute resolution.',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: REQUIRED: Transaction routing audit report must capture which routing table rule was applied to each transaction.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Required for regulatory reconciliation reports that map each wallet transaction to the settlement record that cleared it, enabling audit of funds flow.',
    `token_id` BIGINT COMMENT 'Identifier of the token representing the payment instrument used.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Transaction type mapping to reference.transaction_type enables processing rules and analytics.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the device (e.g., mobile, POS terminal) that initiated the transaction.',
    `amount` DECIMAL(18,2) COMMENT 'Gross amount of the transaction in the transaction currency.',
    `authorization_code` STRING COMMENT 'Code assigned by the issuer for the authorized transaction.',
    `channel` STRING COMMENT 'Channel through which the transaction was processed.. Valid values are `online|offline|mobile|pos`',
    `compliance_check_code` STRING COMMENT 'Code representing the result of compliance checks.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates if the transaction passed compliance screening (AML, sanctions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the system.',
    `cryptogram` STRING COMMENT 'Masked cryptographic value used for transaction authentication.',
    `dispute_status` STRING COMMENT 'Current status of any dispute related to the transaction.. Valid values are `open|closed|pending|resolved`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if currency conversion occurred.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the platform for processing the transaction.',
    `fraud_reason_code` STRING COMMENT 'Code describing the reason for fraud flag.',
    `ip_address` STRING COMMENT 'IP address of the device initiating the transaction.',
    `is_fraud_flagged` BOOLEAN COMMENT 'Indicates whether the transaction was flagged for potential fraud.',
    `is_successful` BOOLEAN COMMENT 'Indicates whether the transaction was successful.',
    `location_city` STRING COMMENT 'City of the transaction origin.',
    `location_country` STRING COMMENT 'Three-letter ISO country code of the transaction origin.. Valid values are `^[A-Z]{3}$`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after fees, in the transaction currency.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating if the transaction is a reversal.',
    `risk_score` STRING COMMENT 'Fraud risk score assigned to the transaction.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was settled.',
    `transaction_reference` STRING COMMENT 'External reference number for the transaction as provided by the payment network.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was initiated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    `wallet_transaction_status` STRING COMMENT 'Current processing status of the transaction.. Valid values are `pending|authorized|captured|declined|reversed|failed`',
    CONSTRAINT pk_wallet_transaction PRIMARY KEY(`wallet_transaction_id`)
) COMMENT 'Wallet-layer transaction record capturing each payment event initiated from a digital wallet — NFC tap-to-pay, QR code payment, in-app purchase, or P2P transfer. Captures wallet transaction ID, wallet ID, token ID, device ID, transaction amount, currency, merchant reference, MCC, transaction type (NFC, QR, in-app, P2P), cryptogram value (masked), transaction timestamp, authorization response code, and wallet scheme. Complements the transaction domains authorization record with wallet-specific context.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` (
    `hce_credential_id` BIGINT COMMENT 'Unique identifier for the HCE credential record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet to which this credential belongs.',
    `token_id` BIGINT COMMENT 'Identifier of the token associated with this HCE credential.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit trail record for this credential.',
    `compliance_pci_dss_version` STRING COMMENT 'Version of the PCI DSS standard applicable to this credential.',
    `compliance_psd2_version` STRING COMMENT 'Version of the PSD2 regulatory framework applicable.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the credential.. Valid values are `compliant|non_compliant|pending`',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates if contactless payments are permitted with this credential.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the credential record was created.',
    `credential_type` STRING COMMENT 'Type of HCE credential, indicating its usage model.. Valid values are `limited_use_key|session_key|persistent_key`',
    `credential_version` STRING COMMENT 'Version number of the credential, incremented on each rotation.',
    `cross_border_supported` BOOLEAN COMMENT 'Indicates if the credential can be used for cross‑border payments.',
    `device_binding_reference` STRING COMMENT 'Identifier of the device bound to this credential.',
    `dynamic_currency_conversion_supported` BOOLEAN COMMENT 'Indicates support for Dynamic Currency Conversion during transactions.',
    `fraud_reason_code` STRING COMMENT 'Code describing the reason for fraud flagging.',
    `hce_credential_status` STRING COMMENT 'Current lifecycle status of the HCE credential.. Valid values are `active|inactive|suspended|revoked|expired|pending`',
    `hce_enabled` BOOLEAN COMMENT 'Indicates if Host Card Emulation is enabled for this credential.',
    `is_fraud_flagged` BOOLEAN COMMENT 'Indicates whether the credential has been flagged for fraud.',
    `is_test_credential` BOOLEAN COMMENT 'Indicates whether the credential is used for testing purposes only.',
    `issuer_script_reference` STRING COMMENT 'Reference to the issuer script used during credential provisioning.',
    `key_algorithm` STRING COMMENT 'Cryptographic algorithm of the HCE key.. Valid values are `RSA|ECC|AES`',
    `key_expiry_date` DATE COMMENT 'Calendar date on which the key becomes invalid.',
    `key_expiry_timestamp` TIMESTAMP COMMENT 'Timestamp when the cryptographic key expires.',
    `key_index` STRING COMMENT 'Index of the cryptographic key within the HCE key set.',
    `key_length` STRING COMMENT 'Length of the cryptographic key in bits.',
    `key_rotation_interval_days` STRING COMMENT 'Configured interval in days after which the key must be rotated.',
    `key_rotation_timestamp` TIMESTAMP COMMENT 'Timestamp when the key was last rotated.',
    `key_usage_counter` STRING COMMENT 'Number of times the key has been used for a transaction.',
    `key_usage_limit` STRING COMMENT 'Maximum allowed uses for the key before it must be replenished or rotated.',
    `last_replenishment_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent key replenishment event.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction that used this credential.',
    `nfc_enabled` BOOLEAN COMMENT 'Indicates if NFC communication is supported for this credential.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the credential.',
    `provisioning_channel` STRING COMMENT 'Channel through which the credential was provisioned.. Valid values are `app|web|api|partner|batch`',
    `region_code` STRING COMMENT 'Three‑letter ISO country code representing the region where the credential is issued.. Valid values are `^[A-Z]{3}$`',
    `replenishment_count` STRING COMMENT 'Total number of times the key has been replenished.',
    `replenishment_threshold` STRING COMMENT 'Number of remaining uses that triggers automatic key replenishment.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score assigned to the credential by the fraud detection engine.',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether tokenization is supported for this credential.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credential record.',
    `usage_reset_timestamp` TIMESTAMP COMMENT 'Timestamp when the usage counters were last reset.',
    CONSTRAINT pk_hce_credential PRIMARY KEY(`hce_credential_id`)
) COMMENT 'Host Card Emulation credential record for software-based NFC payments without a physical secure element. Captures HCE credential ID, wallet ID, token ID, credential type (limited-use key, session key), key index, key expiry, replenishment threshold, replenishment count, last replenishment timestamp, credential status, and issuer script reference. Manages the limited-use cryptographic key lifecycle for HCE-based contactless payments.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` (
    `upi_registration_id` BIGINT COMMENT 'Unique identifier for the UPI registration record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the wallet to which the UPI registration belongs.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the PSP that processes the UPI transactions.',
    `partner_profile_id` BIGINT COMMENT 'Identifier of the PSP that processes the UPI transactions.',
    `aml_check_status` STRING COMMENT 'Result of AML screening for the registration.. Valid values are `passed|failed|pending`',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance verification for the registration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration record was first captured.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the VPAs settlement currency.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount allowed per day for this VPA.',
    `default_flag` BOOLEAN COMMENT 'Indicates whether this VPA is the default address for the wallet.',
    `deregistration_timestamp` TIMESTAMP COMMENT 'Timestamp when the VPA was deregistered or deactivated.',
    `device_binding_reference` BIGINT COMMENT 'Identifier of the device bound to the VPA for authentication.',
    `effective_from` DATE COMMENT 'Date from which the VPA registration becomes effective.',
    `effective_until` DATE COMMENT 'Date until which the VPA registration remains effective (null for open-ended).',
    `failed_auth_attempts` STRING COMMENT 'Number of consecutive failed authentication attempts.',
    `kyc_status` STRING COMMENT 'Result of the KYC verification for the linked account holder.. Valid values are `passed|failed|pending`',
    `last_successful_auth_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful authentication for the VPA.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this registration record.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful verification of the VPA.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the VPA registration.. Valid values are `active|suspended|closed|pending`',
    `linked_bank_account_masked` STRING COMMENT 'Masked representation of the bank account linked to the VPA.',
    `max_failed_attempts` STRING COMMENT 'Configured limit for failed authentication attempts before lockout.',
    `monthly_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount allowed per month for this VPA.',
    `nfc_enabled` BOOLEAN COMMENT 'Indicates whether NFC-based payments are enabled for this VPA.',
    `privacy_consent_given` BOOLEAN COMMENT 'Indicates whether the user has consented to privacy terms for UPI usage.',
    `registration_number` STRING COMMENT 'External reference number assigned by the NPCI for this registration.',
    `registration_source` STRING COMMENT 'Origin of the registration request, such as self-service or customer support.. Valid values are `self_service|customer_support`',
    `registration_status` STRING COMMENT 'Current status of the UPI registration lifecycle.. Valid values are `registered|pending|rejected|deregistered`',
    `registration_timestamp` TIMESTAMP COMMENT 'Timestamp when the VPA registration was created.',
    `registration_type` STRING COMMENT 'Specifies if the VPA is the primary or a secondary address for the user.. Valid values are `primary|secondary`',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score assigned to the VPA registration based on fraud and compliance signals.',
    `sanction_check_status` STRING COMMENT 'Result of sanctions list screening for the registration.. Valid values are `passed|failed|pending`',
    `source_channel` STRING COMMENT 'Channel through which the VPA registration was initiated.. Valid values are `mobile_app|web|api|pos`',
    `status_reason` STRING COMMENT 'Free-text explanation for the current registration status.',
    `tokenization_status` STRING COMMENT 'Whether the VPA is associated with a tokenized payment instrument.. Valid values are `tokenized|not_tokenized`',
    `upi_handle` STRING COMMENT 'PSP-specific suffix appended to the VPA (e.g., @bank).',
    `upi_pin_set` BOOLEAN COMMENT 'Indicates whether a PIN has been configured for the VPA.',
    `verification_status` STRING COMMENT 'Result of the verification process for the VPA.. Valid values are `verified|unverified|failed`',
    `vpa` STRING COMMENT 'The UPI ID assigned to the user for receiving payments.',
    `vpa_type` STRING COMMENT 'Indicates whether the VPA is for a personal or business account.. Valid values are `personal|business`',
    CONSTRAINT pk_upi_registration PRIMARY KEY(`upi_registration_id`)
) COMMENT 'UPI (Unified Payments Interface) Virtual Payment Address (VPA) registration record linking a cardholders bank account to a UPI ID within the wallet platform. Captures UPI registration ID, wallet ID, VPA (UPI ID), linked bank account reference (masked IBAN/account), NPCI registration status, UPI handle (PSP suffix), registration timestamp, last verified timestamp, default flag, and deregistration timestamp. SSOT for UPI identity within the wallet domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` (
    `wallet_funding_source_id` BIGINT COMMENT 'Unique system-generated identifier for the wallet funding source record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Funding Source Management: Compliance requires tracking which employee added or verified a funding source, so wallet.wallet_funding_source.added_by_employee_id references workforce.employee.employee_i',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Funding source management reports need to associate each funding source with the cardholder profile that owns it for risk scoring and compliance.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Funding source currency mapping to reference.currency supports compliance and limit enforcement per currency.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet to which this funding source is linked.',
    `linked_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.linked_account. Business justification: Transaction routing and reconciliation require mapping a wallet funding source to the specific linked bank account of the cardholder.',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the underlying payment instrument (card, bank account, BNPL line) that backs the wallet.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: Top‑up (funding) transactions must reference the funding source record for audit and reconciliation.',
    `wallet_transaction_id` BIGINT COMMENT 'Identifier of the most recent transaction that used this funding source.',
    `available_balance` DECIMAL(18,2) COMMENT 'Current available balance on the funding source, if applicable.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the funding source (PCI, PSD2, AML).. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'When the wallet funding source record was first created.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total value of transactions allowed per day for this funding source.',
    `effective_from` TIMESTAMP COMMENT 'When the funding source became effective for the wallet.',
    `effective_until` TIMESTAMP COMMENT 'When the funding source is scheduled to cease being effective (nullable for open‑ended).',
    `expiry_date` DATE COMMENT 'Date when the funding source expires or becomes invalid.',
    `fraud_reason_code` STRING COMMENT 'Code describing the reason for a fraud flag.',
    `funding_source_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., reason for removal).',
    `instrument_type` STRING COMMENT 'Category of the funding instrument (e.g., debit card, credit card, ACH account, BNPL line).. Valid values are `debit_card|credit_card|ach|bnpl|prepaid|gift_card`',
    `is_3ds_enrolled` BOOLEAN COMMENT 'Indicates whether the funding source is enrolled in 3‑Domain Secure authentication.',
    `is_contactless_supported` BOOLEAN COMMENT 'Indicates if the funding source supports contactless transactions.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this funding source is the default for the wallet.',
    `is_fraud_flagged` BOOLEAN COMMENT 'Indicates whether the funding source has been flagged for fraud.',
    `is_hce_enabled` BOOLEAN COMMENT 'Indicates if Host Card Emulation is enabled for the funding source.',
    `is_nfc_enabled` BOOLEAN COMMENT 'Indicates if NFC (Near Field Communication) is enabled for the funding source.',
    `is_sca_compliant` BOOLEAN COMMENT 'Indicates compliance with PSD2 Strong Customer Authentication requirements.',
    `issuer_bin` STRING COMMENT 'Bank Identification Number of the issuing bank for the funding instrument.. Valid values are `^[0-9]{6}$`',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date‑time when the funding source was last used in a wallet transaction.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount that can be drawn from the funding source per defined period.',
    `link_timestamp` TIMESTAMP COMMENT 'Date‑time when the funding source was linked to the wallet.',
    `masked_reference` STRING COMMENT 'Masked representation (last four characters) of the instrument number (PAN or IBAN).. Valid values are `^[0-9A-Z]{4}$`',
    `monthly_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total value of transactions allowed per month for this funding source.',
    `nickname` STRING COMMENT 'User‑defined friendly name for the funding source.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score assigned to the funding source by fraud/risk models.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the funding source record.',
    `token_service_provider` STRING COMMENT 'Name of the token service provider that issued the token for this funding source.',
    `tokenization_status` STRING COMMENT 'Whether the funding source has been tokenized for secure storage.. Valid values are `tokenized|not_tokenized`',
    `updated_timestamp` TIMESTAMP COMMENT 'When the wallet funding source record was last modified.',
    `verification_method` STRING COMMENT 'Method used to verify the funding source (e.g., micro‑deposit, instant verification).. Valid values are `micro_deposit|instant|none`',
    `verification_status` STRING COMMENT 'Result of the funding source verification process.. Valid values are `pending|verified|failed`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date‑time when the verification status was last updated.',
    `wallet_funding_source_status` STRING COMMENT 'Current lifecycle status of the funding source within the wallet.. Valid values are `active|expired|removed|suspended`',
    CONSTRAINT pk_wallet_funding_source PRIMARY KEY(`wallet_funding_source_id`)
) COMMENT 'Funding source linked to a digital wallet — the payment instrument (card, bank account, BNPL line) that backs wallet transactions. Captures funding source ID, wallet ID, instrument type (debit card, credit card, ACH account, BNPL), masked instrument reference (last four / masked IBAN), issuer BIN, funding source status (active, expired, removed), default flag, verification status, verification method (micro-deposit, instant verification), and link timestamp. Manages the wallet-to-instrument binding.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` (
    `wallet_balance_id` BIGINT COMMENT 'System-generated unique identifier for each wallet balance record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Balance currency must reference reference.currency for accurate reporting and multi-currency balance management.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the wallet to which this balance belongs.',
    `available_balance` DECIMAL(18,2) COMMENT 'Portion of the total balance that is free for spend or transfer.',
    `balance_category` STRING COMMENT 'Business segment to which the balance applies.. Valid values are `consumer|merchant|partner`',
    `balance_ceiling_limit` DECIMAL(18,2) COMMENT 'Maximum allowable balance for the wallet as defined by product rules or regulatory caps.',
    `balance_status` STRING COMMENT 'Current operational status of the balance record.. Valid values are `active|inactive|blocked|closed|pending`',
    `balance_type` STRING COMMENT 'Classification of the stored‑value product (e.g., prepaid, e‑money, gift, loyalty).. Valid values are `prepaid|e_money|gift|loyalty`',
    `compliance_status` STRING COMMENT 'Current compliance posture of the balance with regulatory rules.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'When the balance record was first created in the system.',
    `e_money_classification` STRING COMMENT 'Regulatory classification of the e‑money balance.. Valid values are `regulated|unregulated|exempt`',
    `effective_from` DATE COMMENT 'Date when the balance became effective for the wallet.',
    `effective_until` DATE COMMENT 'Date when the balance ceases to be effective (null if open‑ended).',
    `external_balance_reference` STRING COMMENT 'External reference number used by partner systems for this balance.',
    `is_frozen` BOOLEAN COMMENT 'True when the balance is temporarily frozen due to compliance or risk actions.',
    `is_overdraft_allowed` BOOLEAN COMMENT 'Indicates whether the wallet permits overdraft usage.',
    `last_credit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent credit transaction applied to the balance.',
    `last_debit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent debit transaction applied to the balance.',
    `notes` STRING COMMENT 'Free‑form text for operational comments or audit remarks.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Authorized amount that can be drawn beyond the available balance, if overdraft is permitted.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this balance must be included in statutory reporting (e.g., AML, PSD2).',
    `reserved_balance` DECIMAL(18,2) COMMENT 'Amount held for pending authorizations or holds.',
    `source_system` STRING COMMENT 'Name of the operational system that originated the balance record (e.g., Digital Wallet Platform).',
    `total_balance` DECIMAL(18,2) COMMENT 'Sum of available and reserved balances representing the full stored value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Most recent time the balance record was modified.',
    CONSTRAINT pk_wallet_balance PRIMARY KEY(`wallet_balance_id`)
) COMMENT 'Stored-value balance record for wallets that hold a prepaid or e-money balance (proprietary wallet schemes, prepaid wallets). Captures balance ID, wallet ID, currency, available balance, reserved balance, total balance, last credit timestamp, last debit timestamp, balance ceiling limit, regulatory e-money classification, and balance status. Distinct from funding sources — represents actual stored value held within the wallet platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` (
    `balance_movement_id` BIGINT COMMENT 'System-generated unique identifier for each balance movement record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet that owns the balance.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this movement.',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this movement.',
    `wallet_balance_id` BIGINT COMMENT 'Identifier of the stored-value balance to which this movement applies.',
    `wallet_transaction_id` BIGINT COMMENT 'External identifier of the originating transaction (e.g., authorization or settlement ID).',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the movement in the transaction currency.',
    `balance_movement_status` STRING COMMENT 'Current processing state of the movement record.. Valid values are `pending|completed|failed|reversed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the movement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the movement amount.',
    `expiry_date` DATE COMMENT 'Date on which the balance or movement expires, if applicable.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee deducted as part of the movement, if applicable.',
    `fee_currency_code` STRING COMMENT 'Currency of the fee amount, using ISO 4217 three‑letter code.',
    `initiating_channel` STRING COMMENT 'Channel through which the movement was initiated (mobile app, web, point‑of‑sale, API).. Valid values are `mobile_app|web|pos|api`',
    `is_test_movement` BOOLEAN COMMENT 'Indicates whether the record was generated for testing purposes.',
    `movement_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the movement occurred in the real world.',
    `movement_type` STRING COMMENT 'Nature of the balance change: credit, debit, reversal, or expiry.. Valid values are `credit|debit|reversal|expiry`',
    `post_movement_balance` DECIMAL(18,2) COMMENT 'Balance amount after the movement was applied.',
    `pre_movement_balance` DECIMAL(18,2) COMMENT 'Balance amount before the movement was applied.',
    `reason_code` STRING COMMENT 'Code describing why a reversal, expiry, or fee was applied.',
    `source_system` STRING COMMENT 'Name of the upstream system that produced the movement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the movement record.',
    CONSTRAINT pk_balance_movement PRIMARY KEY(`balance_movement_id`)
) COMMENT 'Transactional ledger record for every credit or debit movement against a wallet stored-value balance — top-ups, payments, refunds, fee deductions, and expiry write-offs. Captures movement ID, balance ID, wallet ID, movement type (credit, debit, reversal, expiry), amount, currency, reference transaction ID, initiating channel, pre-movement balance, post-movement balance, and movement timestamp. Provides the full audit trail for e-money regulatory reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` (
    `nfc_tap_event_id` BIGINT COMMENT 'Unique identifier for each NFC tap interaction record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet instance linked to the tap.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant (MID) associated with the transaction.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal (TID) where the tap occurred.',
    `token_id` BIGINT COMMENT 'Token representing the payment credential used in the tap.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the physical device that performed the NFC tap.',
    `application_transaction_counter` STRING COMMENT 'Monotonically increasing counter from the card/emulated token used to detect replay attacks.',
    `cryptogram_type` STRING COMMENT 'Type of cryptographic value generated during the tap (e.g., Authorization Request Cryptogram).. Valid values are `ARQC|TC|AAC`',
    `cryptogram_value` DECIMAL(18,2) COMMENT 'Masked representation of the cryptogram generated for the transaction, stored for audit and fraud analysis.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction amount.. Valid values are `[A-Z]{3}`',
    `fraud_reason_code` STRING COMMENT 'Code describing the reason for fraud flagging (e.g., high velocity, mismatched CVM).',
    `ip_address` STRING COMMENT 'IP address of the terminal or gateway that recorded the tap.',
    `is_fraud_flagged` BOOLEAN COMMENT 'Indicates whether the tap event was flagged as potentially fraudulent.',
    `kernel_version` STRING COMMENT 'Version of the EMV contactless kernel used for processing the tap.',
    `location_city` STRING COMMENT 'City name of the terminal location for the tap event.',
    `location_country_code` STRING COMMENT 'Three‑letter ISO country code where the tap was performed.. Valid values are `[A-Z]{3}`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tap event record was first inserted into the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tap event record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk assessment assigned to the tap event by fraud detection models.',
    `tap_result` STRING COMMENT 'Outcome of the tap attempt as reported by the terminal.. Valid values are `authorized|declined|fallback|error`',
    `tap_timestamp` TIMESTAMP COMMENT 'Exact date and time when the NFC tap was captured.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount authorized for the tap transaction.',
    `transaction_type` STRING COMMENT 'Business classification of the transaction (e.g., purchase, refund).. Valid values are `purchase|refund|preauth|void`',
    CONSTRAINT pk_nfc_tap_event PRIMARY KEY(`nfc_tap_event_id`)
) COMMENT 'Granular NFC contactless tap interaction record capturing each physical tap-to-pay event at a POS terminal. Captures tap event ID, device ID, token ID, wallet ID, terminal TID, merchant MID, tap timestamp, cryptogram type (ARQC, TC), cryptogram value (masked), ATC (Application Transaction Counter), tap result (authorized, declined, fallback), contactless kernel version, and transaction amount. Provides device-level NFC telemetry for fraud detection and EMV compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` (
    `wallet_sca_challenge_id` BIGINT COMMENT 'System-generated unique identifier for the Strong Customer Authentication (SCA) challenge event.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet to which the SCA challenge is associated.',
    `wallet_device_id` BIGINT COMMENT 'Unique identifier of the device used to receive or respond to the challenge.',
    `challenge_status` STRING COMMENT 'Current lifecycle status of the SCA challenge.. Valid values are `sent|completed|failed|expired`',
    `challenge_timestamp` TIMESTAMP COMMENT 'Date‑time when the SCA challenge was issued to the wallet holder.',
    `challenge_type` STRING COMMENT 'Method used to deliver the SCA challenge (e.g., one‑time password via SMS, email, biometric verification, push notification, or call‑center).. Valid values are `otp_sms|otp_email|biometric|push_notification|call_center`',
    `channel` STRING COMMENT 'Channel through which the wallet holder received the challenge.. Valid values are `mobile_app|web|api|pos|atm`',
    `completion_timestamp` TIMESTAMP COMMENT 'Date‑time when the challenge reached a terminal state (completed, failed, or expired).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the SCA challenge record was first created in the data lake.',
    `failure_reason` STRING COMMENT 'Textual code or description explaining why the challenge failed or expired, if applicable.',
    `ip_address` STRING COMMENT 'IP address of the client device at the time of challenge issuance.',
    `is_test_challenge` BOOLEAN COMMENT 'Indicates whether the challenge was generated in a test or sandbox environment.',
    `location_country` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 country code representing the geographic location of the device.',
    `request_reference` STRING COMMENT 'External identifier linking the challenge to the originating provisioning request or transaction (e.g., transaction ID, provisioning request ID).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk assessment (0‑100) generated by the fraud detection engine for this SCA challenge.',
    `sca_exemption_applied` STRING COMMENT 'Regulatory exemption that justified bypassing or simplifying the SCA requirement for this transaction.. Valid values are `none|low_value|trusted_contact|transaction_risk|secure_corporate|delegated_authentication`',
    `updated_by` STRING COMMENT 'System or process name that performed the latest update to the challenge record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the SCA challenge record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string reported by the client device.',
    `created_by` STRING COMMENT 'System or process name that created the challenge record.',
    CONSTRAINT pk_wallet_sca_challenge PRIMARY KEY(`wallet_sca_challenge_id`)
) COMMENT 'Strong Customer Authentication (SCA) challenge event record for wallet provisioning and high-value wallet transactions under PSD2. Captures challenge ID, wallet ID, provisioning request or transaction reference, challenge type (OTP SMS, OTP email, biometric, push notification, call center), challenge status (sent, completed, failed, expired), challenge timestamp, completion timestamp, failure reason, and SCA exemption applied (if any). Supports PSD2 SCA compliance audit trail.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` (
    `wallet_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the wallet enrollment record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who is enrolling in the wallet.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who is enrolling in the wallet.',
    `device_id` BIGINT COMMENT 'Unique identifier of the device used to perform the enrollment.',
    `digital_wallet_id` BIGINT COMMENT 'Reference to the digital wallet instance being enrolled.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the wallet was successfully activated after enrollment.',
    `compliance_check_code` STRING COMMENT 'Code representing the specific compliance rule or check that was evaluated.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the enrollment passed all mandatory compliance checks (e.g., AML, sanctions).',
    `consent_data_sharing` BOOLEAN COMMENT 'Indicates whether the cardholder consented to share data with third parties.',
    `consent_marketing` BOOLEAN COMMENT 'Indicates whether the cardholder opted in to receive marketing communications.',
    `device_fingerprint` STRING COMMENT 'Hash or token representing the devices unique characteristics for fraud detection.',
    `enrollment_channel` STRING COMMENT 'Channel through which the cardholder performed the enrollment (e.g., mobile app, web, IVR, branch).. Valid values are `mobile_app|web|ivr|branch`',
    `enrollment_source_campaign_code` BIGINT COMMENT 'Identifier of the marketing campaign that drove the enrollment, if any.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment record.. Valid values are `pending|active|suspended|closed|rejected`',
    `enrollment_status_reason` STRING COMMENT 'Free‑text explanation for the current enrollment status, if applicable.',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment request was received.',
    `ip_address` STRING COMMENT 'IP address from which the enrollment request originated.',
    `kyc_verification_status` STRING COMMENT 'Result of the Know Your Customer verification at enrollment.. Valid values are `passed|failed|pending`',
    `kyc_verification_timestamp` TIMESTAMP COMMENT 'Date and time when the KYC verification outcome was recorded.',
    `location_city` STRING COMMENT 'City name associated with the enrollment request origin.',
    `location_country` STRING COMMENT 'Three‑letter ISO 3166‑1 country code of the enrollment request origin.. Valid values are `[A-Z]{3}`',
    `notes` STRING COMMENT 'Free‑form notes captured by support or operations staff regarding the enrollment.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the enrollment record.',
    `terms_and_conditions_version` STRING COMMENT 'Version identifier of the terms and conditions accepted during enrollment.',
    CONSTRAINT pk_wallet_enrollment PRIMARY KEY(`wallet_enrollment_id`)
) COMMENT 'Cardholder wallet enrollment event — the business record of a cardholder registering and activating a digital wallet on the platform. Captures enrollment ID, wallet ID, cardholder reference, enrollment channel (mobile app, web, IVR, branch), enrollment timestamp, KYC verification status at enrollment, terms and conditions version accepted, consent flags (data sharing, marketing), activation timestamp, and enrollment source campaign reference. SSOT for wallet onboarding lifecycle.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` (
    `p2p_transfer_id` BIGINT COMMENT 'System-generated unique identifier for the P2P transfer record.',
    `digital_wallet_id` BIGINT COMMENT 'Unique identifier of the wallet from which funds are debited.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: P2P transfers may involve currency conversion; storing the applied FX rate record is needed for fee calculation, compliance, and audit trails.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction. Business justification: Regulatory reporting of peer‑to‑peer transfers requires linking each P2P record to its underlying transaction.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the device used to initiate the transfer.',
    `channel` STRING COMMENT 'Originating channel through which the transfer was initiated.. Valid values are `mobile_app|web|api|pos`',
    `completion_timestamp` TIMESTAMP COMMENT 'Date‑time when the transfer reached a terminal state (completed, failed, or reversed).',
    `compliance_check_code` STRING COMMENT 'Code representing the specific compliance rule evaluated.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the transfer satisfied AML/KYC and other regulatory checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer record was first persisted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the transfer amount.',
    `external_transfer_reference` STRING COMMENT 'External or partner-provided reference number for the transfer, if any.',
    `failure_reason_code` STRING COMMENT 'Standardized code describing why a transfer failed or was reversed.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for processing the transfer.',
    `fee_currency` STRING COMMENT 'Currency of the fee amount; typically matches transfer currency.',
    `fraud_flag` BOOLEAN COMMENT 'True if the transfer was flagged as potentially fraudulent.',
    `initiation_timestamp` TIMESTAMP COMMENT 'Date‑time when the transfer request was created.',
    `ip_address` STRING COMMENT 'IP address of the client at the time of transfer initiation.',
    `is_recurring` BOOLEAN COMMENT 'True if the transfer is part of a recurring series.',
    `location_country` STRING COMMENT 'Three‑letter country code where the transfer was initiated.',
    `recipient_identifier` STRING COMMENT 'Value of the recipient identifier (e.g., phone number, email address, UPI VPA, or wallet ID).',
    `recipient_identifier_type` STRING COMMENT 'Method used to identify the recipient (phone number, email address, UPI VPA, or internal wallet ID).. Valid values are `phone|email|upi_vpa|wallet_id`',
    `recurrence_pattern` STRING COMMENT 'Pattern defining how a recurring transfer repeats.. Valid values are `daily|weekly|monthly|yearly|custom`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk assessment (0‑100) generated by fraud detection engine.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned execution time for a scheduled transfer; null for instant transfers.',
    `transfer_amount` DECIMAL(18,2) COMMENT 'Principal amount transferred between wallets, before fees.',
    `transfer_status` STRING COMMENT 'Current lifecycle state of the transfer.. Valid values are `initiated|pending|completed|failed|reversed`',
    `transfer_type` STRING COMMENT 'Indicates whether the transfer is immediate, scheduled for a future date, or part of a recurring series.. Valid values are `instant|scheduled|recurring`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the transfer record.',
    CONSTRAINT pk_p2p_transfer PRIMARY KEY(`p2p_transfer_id`)
) COMMENT 'Peer-to-peer (P2P) money transfer record between two wallet holders on the platform. Captures transfer ID, sender wallet ID, recipient wallet ID, transfer amount, currency, transfer type (instant, scheduled, recurring), transfer status (initiated, pending, completed, failed, reversed), initiation timestamp, completion timestamp, fee amount, fee currency, recipient identifier type (phone, email, UPI VPA, wallet ID), and failure reason code. Core transactional entity for P2P payment flows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` (
    `wallet_limit_id` BIGINT COMMENT 'Unique identifier for the wallet limit configuration.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Limit amounts are defined per currency; linking to reference.currency ensures correct currency semantics.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet to which this limit applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit record was first created.',
    `effective_date` DATE COMMENT 'Date when the limit becomes active.',
    `enforcement_mode` STRING COMMENT 'Defines how strictly the limit is enforced.. Valid values are `hard|soft|monitoring`',
    `expiry_date` DATE COMMENT 'Date when the limit ceases to be effective (null for indefinite).',
    `limit_amount` DECIMAL(18,2) COMMENT 'Monetary value of the limit expressed in the specified currency.',
    `limit_code` STRING COMMENT 'System-generated code uniquely identifying the limit configuration.',
    `limit_name` STRING COMMENT 'Human‑readable name for the limit (e.g., "Daily Spend Cap").',
    `limit_scope` STRING COMMENT 'Specifies which transaction channels the limit applies to.. Valid values are `all_channels|nfc_only|online_only|pos_only|mobile_only`',
    `limit_type` STRING COMMENT 'Category of the limit governing spending or transaction behavior.. Valid values are `daily_spend|per_transaction|contactless|p2p|top_up`',
    `limit_version` STRING COMMENT 'Version number of the limit configuration for change tracking.',
    `notes` STRING COMMENT 'Free‑form text for additional information or business comments.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this limit can be overridden by higher‑level controls.',
    `regulatory_basis` STRING COMMENT 'Regulatory or scheme rule that mandates or influences this limit.. Valid values are `psd2_contactless|scheme_rule|internal_policy`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating (0‑100) associated with the limit configuration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the limit record.',
    `wallet_limit_status` STRING COMMENT 'Current lifecycle status of the limit configuration.. Valid values are `active|inactive|pending|suspended|retired`',
    CONSTRAINT pk_wallet_limit PRIMARY KEY(`wallet_limit_id`)
) COMMENT 'Operational spending and velocity limit configuration applied to a digital wallet — daily spend caps, per-transaction limits, NFC contactless limits, P2P transfer limits, and top-up limits. Captures limit ID, wallet ID, limit type (daily spend, per-transaction, contactless, P2P, top-up), limit amount, currency, limit scope (all channels, NFC only, online only), effective date, expiry date, override flag, and regulatory basis (PSD2 contactless limit, scheme rule). Governs wallet risk controls.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` (
    `token_pan_mapping_id` BIGINT COMMENT 'Unique surrogate key for each DPAN to FPAN mapping record.',
    `partner_profile_id` BIGINT COMMENT 'Unique identifier of the card‑issuing institution (e.g., IIN or internal issuer code).',
    `token_requestor_id` BIGINT COMMENT 'Identifier of the entity (merchant, PSP, or partner) that requested the tokenization.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the immutable audit‑log entry that captures the full change history for this mapping.',
    `bin` STRING COMMENT 'First six digits of the card number identifying the issuing bank and card brand.',
    `compliance_flags` STRING COMMENT 'Comma‑separated list of compliance indicators applicable to the mapping (e.g., pci_dss, psd2).',
    `dpan_masked` STRING COMMENT 'Masked tokenized primary account number used in digital wallet transactions; only the first six and last four digits are visible.',
    `effective_from` DATE COMMENT 'Date on which the mapping becomes active.',
    `effective_until` DATE COMMENT 'Date on which the mapping expires; null if indefinite.',
    `fpan_reference` STRING COMMENT 'Secure reference (e.g., vault pointer) to the underlying real PAN stored in the token vault.',
    `is_restricted_mapping` BOOLEAN COMMENT 'True if the mapping is subject to additional security controls (e.g., high‑value cards).',
    `is_test_mapping` BOOLEAN COMMENT 'True if the mapping is created for testing or sandbox environments.',
    `last_detokenization_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent detokenization (FPAN retrieval) event.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the mapping record.',
    `mapping_created_timestamp` TIMESTAMP COMMENT 'Date‑time when the mapping record was initially created.',
    `mapping_status` STRING COMMENT 'Current lifecycle state of the DPAN‑FPAN mapping.. Valid values are `active|suspended|deleted`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating (0‑99.99) associated with this token mapping.',
    `tokenization_algorithm` STRING COMMENT 'Name of the cryptographic algorithm applied during token generation.',
    `tokenization_compliance` STRING COMMENT 'Regulatory compliance standards satisfied by the tokenization process.. Valid values are `pci_dss|psd2|none`',
    `tokenization_key_reference` STRING COMMENT 'Identifier of the cryptographic key used for token creation.',
    `tokenization_key_version` STRING COMMENT 'Version label of the tokenization key.',
    `tokenization_method` STRING COMMENT 'Technique used to generate the token value.. Valid values are `algorithmic|hardware|software`',
    `update_reason` STRING COMMENT 'Code describing why the mapping record was last updated (e.g., status_change, compliance_review).',
    CONSTRAINT pk_token_pan_mapping PRIMARY KEY(`token_pan_mapping_id`)
) COMMENT 'Secure DPAN-to-FPAN mapping record maintained in the TSP token vault — the authoritative link between a tokenized DPAN and the underlying FPAN. Captures mapping ID, DPAN (masked), FPAN (masked/vaulted reference), BIN, issuer ID, token requestor ID, mapping status (active, suspended, deleted), mapping creation timestamp, and last detokenization timestamp. Critical for transaction authorization, dispute resolution, and fraud investigation requiring FPAN recovery.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` (
    `detokenization_request_id` BIGINT COMMENT 'Unique system-generated identifier for each detokenization request.',
    `token_id` BIGINT COMMENT 'Identifier of the token (DPAN) that is being detokenized.',
    `token_requestor_id` BIGINT COMMENT 'System identifier of the party (issuer, fraud platform, or dispute system) that initiated the detokenization request.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the device that initiated the detokenization request.',
    `authorization_outcome` STRING COMMENT 'Result of the authorization check for the detokenization request.. Valid values are `approved|denied|error`',
    `compliance_check_code` STRING COMMENT 'Code representing the specific compliance rule or policy evaluated for the request.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the request passed all regulatory compliance checks (e.g., AML, PCI).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the detokenization request record was first created in the system.',
    `detokenization_request_status` STRING COMMENT 'Current lifecycle status of the detokenization request.. Valid values are `pending|completed|failed|cancelled`',
    `dpan_masked` STRING COMMENT 'Masked representation of the DPAN (e.g., first 6 and last 4 digits visible).',
    `fpan_masked` STRING COMMENT 'Masked representation of the FPAN when it is not fully returned, complying with PCI DSS masking rules.',
    `fpan_returned_flag` BOOLEAN COMMENT 'Indicates whether the full Primary Account Number (FPAN) was returned (true) or not (false).',
    `ip_address` STRING COMMENT 'IP address from which the detokenization request originated.',
    `location_country` STRING COMMENT 'Three‑letter country code of the request origin.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information related to the request.',
    `request_reason` STRING COMMENT 'Business reason for the detokenization request.. Valid values are `authorization|fraud_investigation|dispute`',
    `request_reference` STRING COMMENT 'External reference number used by business processes to track the request.',
    `request_timestamp` TIMESTAMP COMMENT 'Exact time when the detokenization request was received.',
    `requestor_type` STRING COMMENT 'Classification of the requesting party.. Valid values are `issuer|fraud_platform|dispute_system`',
    `response_timestamp` TIMESTAMP COMMENT 'Exact time when the detokenization response (FPAN) was returned.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk assessment score assigned to the request by the fraud detection platform.',
    `source_system` STRING COMMENT 'Name of the originating system (e.g., Payment Gateway, Fraud Platform) that generated the request.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the detokenization request record.',
    CONSTRAINT pk_detokenization_request PRIMARY KEY(`detokenization_request_id`)
) COMMENT 'Transactional record of each DPAN-to-FPAN detokenization request made by authorized parties (issuers, fraud teams, dispute investigators). Captures request ID, token ID, DPAN reference (masked), requesting party ID, requesting party type (issuer, fraud platform, dispute system), request reason (authorization, fraud investigation, dispute), authorization outcome, FPAN returned flag, request timestamp, and response timestamp. Provides PCI DSS-compliant audit trail for all detokenization events.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` (
    `wallet_notification_id` BIGINT COMMENT 'System-generated unique identifier for each wallet notification record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet that receives the notification.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the device (mobile, wearables, etc.) through which the notification is delivered.',
    `correlation_reference` STRING COMMENT 'Identifier used to correlate this notification with related processing events or transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification record was first persisted in the lakehouse.',
    `delivery_channel` STRING COMMENT 'Medium used to deliver the notification to the wallet holder.. Valid values are `push|sms|email|in_app`',
    `delivery_status` STRING COMMENT 'Current status of the notification delivery lifecycle.. Valid values are `sent|delivered|failed|read`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Time when the notification was successfully delivered to the end‑device.',
    `is_test_notification` BOOLEAN COMMENT 'Indicates whether the notification was generated in a test or sandbox environment.',
    `language_code` STRING COMMENT 'ISO 639‑2 three‑letter code representing the language of the notification.. Valid values are `^[A-Z]{3}$`',
    `message_content` STRING COMMENT 'Rendered notification message sent to the user (may contain placeholders resolved at send time).',
    `message_template_reference` BIGINT COMMENT 'Reference to the template used to render the notification content.',
    `notification_timestamp` TIMESTAMP COMMENT 'Exact time the notification event was generated by the system.',
    `notification_type` STRING COMMENT 'Category of the notification indicating its business purpose.. Valid values are `transaction_alert|provisioning_confirmation|security_alert|balance_low|limit_breach`',
    `priority` STRING COMMENT 'Business‑defined priority indicating urgency of the notification.. Valid values are `high|medium|low`',
    `read_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipient opened or read the notification (if applicable).',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the notification (e.g., payment_gateway, fraud_engine).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the notification record (e.g., status change).',
    CONSTRAINT pk_wallet_notification PRIMARY KEY(`wallet_notification_id`)
) COMMENT 'Push notification and alert record sent to wallet holders for transaction confirmations, provisioning events, security alerts, and balance updates. Captures notification ID, wallet ID, device ID, notification type (transaction alert, provisioning confirmation, security alert, balance low, limit breach), delivery channel (push, SMS, email, in-app), delivery status (sent, delivered, failed, read), notification timestamp, delivery timestamp, and message template reference. Supports cardholder communication audit trail.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` (
    `wallet_consent_id` BIGINT COMMENT 'Unique system-generated identifier for the consent record.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet to which this consent applies.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Consent must be tracked against reference.regulatory_jurisdiction for GDPR/PSD2 compliance reporting.',
    `biometric_consent` BOOLEAN COMMENT 'Indicates whether the cardholder consented to use biometric authentication.',
    `consent_channel` STRING COMMENT 'Channel through which the consent was obtained.. Valid values are `web|mobile_app|api|in_person|call_center`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent.. Valid values are `granted|withdrawn|expired|pending`',
    `consent_type` STRING COMMENT 'Category of consent granted by the cardholder (e.g., data processing, marketing, third‑party sharing, open banking, biometric).. Valid values are `data_processing|marketing|third_party_sharing|open_banking|biometric`',
    `consent_version` STRING COMMENT 'Version identifier of the consent text or policy that was accepted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_processing_consent` BOOLEAN COMMENT 'Indicates whether the cardholder consented to processing personal data.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date‑time when the consent automatically expires, if a time‑bound consent.',
    `grant_timestamp` TIMESTAMP COMMENT 'Date‑time when the consent was granted by the cardholder.',
    `marketing_consent` BOOLEAN COMMENT 'Indicates whether the cardholder consented to receive marketing communications.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the consent record.',
    `open_banking_consent` BOOLEAN COMMENT 'Indicates whether the cardholder consented to open‑banking data sharing under PSD2.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the consent data.',
    `third_party_sharing_consent` BOOLEAN COMMENT 'Indicates whether the cardholder consented to share data with third‑party service providers.',
    `updated_by` STRING COMMENT 'System user or process that last updated the consent record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Date‑time when the consent was withdrawn, if applicable.',
    `created_by` STRING COMMENT 'System user or process that created the consent record.',
    CONSTRAINT pk_wallet_consent PRIMARY KEY(`wallet_consent_id`)
) COMMENT 'Cardholder consent and data-sharing preference record for a digital wallet — GDPR, CCPA, and PSD2 open banking consent management. Captures consent ID, wallet ID, consent type (data processing, marketing, third-party data sharing, open banking, biometric), consent status (granted, withdrawn, expired), consent version, consent channel, grant timestamp, withdrawal timestamp, and regulatory jurisdiction. SSOT for wallet-level privacy and consent compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` (
    `loyalty_account_id` BIGINT COMMENT 'System‑generated unique identifier for each loyalty account.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet to which this loyalty account is attached.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the account with AML/KYC and loyalty program rules.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty account record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code representing the currency used for point valuation, if applicable.. Valid values are `^[A-Z]{3}$`',
    `is_test_account` BOOLEAN COMMENT 'True if the account is a test or sandbox record used for development or QA.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent activity (earn, redeem, tier change) on the loyalty account.',
    `loyalty_account_status` STRING COMMENT 'Current lifecycle status of the loyalty account.. Valid values are `active|inactive|suspended|closed`',
    `points_balance` BIGINT COMMENT 'Current net balance of loyalty points available for redemption.',
    `points_balance_last_update` TIMESTAMP COMMENT 'Timestamp of the most recent update to the points balance.',
    `points_earned_last_12_months` BIGINT COMMENT 'Cumulative points earned over the past 12 calendar months.',
    `points_earned_last_30_days` BIGINT COMMENT 'Total points earned in the most recent 30‑day window.',
    `points_earned_total` BIGINT COMMENT 'Cumulative total of points ever earned by the account (including redeemed and expired).',
    `points_expiration_date` DATE COMMENT 'Specific calendar date when the current points balance will expire (if fixed policy).',
    `points_expiry_policy` STRING COMMENT 'Policy governing how points expire – rolling (based on activity), fixed date, or none.. Valid values are `rolling|fixed|none`',
    `points_pending` BIGINT COMMENT 'Points that have been earned but are not yet available for redemption (e.g., pending settlement).',
    `points_redeemed_last_12_months` BIGINT COMMENT 'Cumulative points redeemed over the past 12 calendar months.',
    `points_redeemed_last_30_days` BIGINT COMMENT 'Total points redeemed in the most recent 30‑day window.',
    `points_redeemed_total` BIGINT COMMENT 'Cumulative total of points that have been redeemed from the account.',
    `program_name` STRING COMMENT 'Human‑readable name of the loyalty or rewards program.',
    `program_sponsor` STRING COMMENT 'Entity (e.g., bank, merchant, brand) that sponsors the loyalty program.',
    `program_type` STRING COMMENT 'Category of the loyalty program – points, airline miles, cash‑back, or voucher based.. Valid values are `points|miles|cashback|voucher`',
    `reward_redemption_eligibility` BOOLEAN COMMENT 'Indicates whether the account currently meets all criteria to redeem rewards.',
    `reward_redemption_eligibility_reason` STRING COMMENT 'Human‑readable explanation why the account is or is not eligible for redemption.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk rating (0‑100) derived from fraud and compliance models for this account.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the loyalty account record.',
    `tier_expiry_date` DATE COMMENT 'Date when the current tier status expires if not renewed.',
    `tier_level` STRING COMMENT 'Current tier of the account holder (e.g., Standard, Silver, Gold, Platinum).. Valid values are `standard|silver|gold|platinum`',
    `tier_name` STRING COMMENT 'Descriptive name of the tier, may include marketing label.',
    `tier_points_threshold` BIGINT COMMENT 'Number of points required to attain or maintain the current tier.',
    `tier_qualification_date` DATE COMMENT 'Date on which the account qualified for its current tier.',
    `tier_qualification_method` STRING COMMENT 'Mechanism by which the account qualified for its current tier.. Valid values are `spend_based|points_based|manual`',
    `tier_status` STRING COMMENT 'Current qualification status of the tier (e.g., qualified, pending renewal, unqualified).. Valid values are `qualified|unqualified|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the loyalty account record.',
    CONSTRAINT pk_loyalty_account PRIMARY KEY(`loyalty_account_id`)
) COMMENT 'Loyalty and rewards account linked to a digital wallet — points balances, tier status, and reward redemption eligibility for wallet-integrated loyalty programs. Captures loyalty account ID, wallet ID, program name, program sponsor, points balance, tier level (standard, silver, gold, platinum), tier qualification date, tier expiry date, lifetime points earned, points expiry policy, and last activity timestamp. Supports wallet-embedded loyalty and rewards schemes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` (
    `loyalty_transaction_id` BIGINT COMMENT 'Unique identifier for the loyalty transaction record.',
    `device_id` BIGINT COMMENT 'Identifier of the device used to initiate the loyalty transaction.',
    `digital_wallet_id` BIGINT COMMENT 'Identifier of the digital wallet that holds the loyalty account.',
    `loyalty_account_id` BIGINT COMMENT 'Identifier of the loyalty account associated with this transaction.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant where the loyalty activity originated.',
    `risk_rule_id` BIGINT COMMENT 'Identifier of the loyalty program rule applied to calculate points.',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement record linked to this loyalty transaction.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch in which this transaction was settled.',
    `wallet_transaction_id` BIGINT COMMENT 'Identifier of the underlying payment or activity that triggered the loyalty transaction.',
    `channel` STRING COMMENT 'Channel through which the loyalty activity was captured.. Valid values are `online|in_store|mobile_app|api`',
    `compliance_status` STRING COMMENT 'Regulatory compliance outcome for the transaction.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty transaction record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary equivalent.',
    `expiry_date` DATE COMMENT 'Date on which earned points are scheduled to expire, if applicable.',
    `fraud_reason_code` STRING COMMENT 'Code describing the reason for fraud flagging, if applicable.',
    `ip_address` STRING COMMENT 'IP address from which the transaction was initiated.',
    `is_fraud_flagged` BOOLEAN COMMENT 'Indicates whether the transaction was flagged for potential fraud.',
    `is_test_transaction` BOOLEAN COMMENT 'Flag indicating whether the transaction was generated for testing purposes.',
    `location_city` STRING COMMENT 'City name of the transactions geographic origin.',
    `location_country_code` STRING COMMENT 'Three‑letter country code where the transaction originated.',
    `monetary_equivalent` DECIMAL(18,2) COMMENT 'Monetary value of the points transacted, expressed in the transaction currency.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the transaction.',
    `points_amount` STRING COMMENT 'Number of loyalty points earned (positive) or redeemed/adjusted (negative) in this transaction.',
    `points_balance_after` STRING COMMENT 'Loyalty points balance of the account after this transaction is applied.',
    `points_balance_before` STRING COMMENT 'Loyalty points balance of the account prior to this transaction.',
    `program_rule_name` STRING COMMENT 'Descriptive name of the rule that governed point accrual or redemption.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score assigned to the transaction by fraud detection models.',
    `source_system` STRING COMMENT 'Originating system that generated the loyalty transaction (e.g., wallet, gateway).',
    `transaction_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for processing the loyalty transaction, if any.',
    `transaction_fee_currency` STRING COMMENT 'Currency of the transaction fee, expressed as ISO 4217 code.',
    `transaction_reference` STRING COMMENT 'Reference identifier from the source system for this loyalty transaction.',
    `transaction_status` STRING COMMENT 'Current processing status of the loyalty transaction.. Valid values are `pending|completed|reversed|cancelled|failed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty transaction event occurred.',
    `transaction_type` STRING COMMENT 'Nature of the loyalty transaction.. Valid values are `earn|redeem|adjust|expire|transfer`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the loyalty transaction record.',
    CONSTRAINT pk_loyalty_transaction PRIMARY KEY(`loyalty_transaction_id`)
) COMMENT 'Transactional record of loyalty points earned, redeemed, adjusted, or expired within a wallet-linked loyalty account. Captures loyalty transaction ID, loyalty account ID, wallet transaction reference, transaction type (earn, redeem, adjust, expire, transfer), points amount, monetary equivalent, merchant reference, program rule applied, transaction timestamp, and expiry date of earned points. Provides the full points ledger for wallet loyalty programs.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` (
    `terminal_group_id` BIGINT COMMENT 'Primary key for terminal_group',
    `parent_terminal_group_id` BIGINT COMMENT 'Self-referencing FK on terminal_group (parent_terminal_group_id)',
    `address_line1` STRING COMMENT 'First line of the physical address for the group’s primary site.',
    `average_transaction_volume` DECIMAL(18,2) COMMENT 'Average monetary volume processed per terminal in the group (currency‑agnostic).',
    `average_uptime_percent` DECIMAL(18,2) COMMENT 'Average operational uptime of terminals in the group expressed as a percent.',
    `city` STRING COMMENT 'City of the primary site for the terminal group.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the terminal group with industry regulations.',
    `contact_email` STRING COMMENT 'Primary email address for the group’s operational contact.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the group’s operational contact.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the terminal group is primarily deployed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the terminal group record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level governing access to the group’s data.',
    `deployment_mode` STRING COMMENT 'Infrastructure deployment model for the terminals in this group.',
    `terminal_group_description` STRING COMMENT 'Free‑form description of the terminal group’s purpose and characteristics.',
    `effective_from` DATE COMMENT 'Date when the terminal group becomes active for business use.',
    `effective_until` DATE COMMENT 'Date when the terminal group is scheduled to be retired or become inactive; null if open‑ended.',
    `firmware_version` STRING COMMENT 'Standard firmware version deployed across terminals in the group.',
    `group_code` STRING COMMENT 'Business‑assigned alphanumeric code that uniquely identifies the group within the organization.',
    `group_name` STRING COMMENT 'Human‑readable name of the terminal group used in reporting and UI.',
    `group_type` STRING COMMENT 'Category of merchants or environments the group serves.',
    `is_contactless_enabled` BOOLEAN COMMENT 'Indicates whether contactless payment capability is enabled for the group.',
    `is_emv_enabled` BOOLEAN COMMENT 'Indicates whether EMV chip functionality is enabled for the group.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit performed on the group.',
    `max_terminals` STRING COMMENT 'Maximum number of individual terminals that can be assigned to this group.',
    `notes` STRING COMMENT 'Additional internal remarks or operational notes.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the primary site.',
    `risk_score` STRING COMMENT 'Internal risk rating (0‑100) assigned to the terminal group based on fraud and compliance metrics.',
    `security_cert_level` STRING COMMENT 'PCI PTS certification level applicable to the terminals in this group.',
    `terminal_group_status` STRING COMMENT 'Current operational status of the terminal group.',
    `supported_payment_methods` STRING COMMENT 'Comma‑separated list of payment method types the group supports.',
    `terminal_group_category` STRING COMMENT 'Logical categorisation used for reporting (e.g., group, cluster, fleet).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the terminal group record.',
    CONSTRAINT pk_terminal_group PRIMARY KEY(`terminal_group_id`)
) COMMENT 'Master reference table for terminal_group. Referenced by terminal_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ADD CONSTRAINT `fk_terminal_payment_instrument_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ADD CONSTRAINT `fk_terminal_wallet_bin_range_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ADD CONSTRAINT `fk_terminal_wallet_card_scheme_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ADD CONSTRAINT `fk_terminal_emv_config_card_id` FOREIGN KEY (`card_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`card`(`card_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ADD CONSTRAINT `fk_terminal_token_token_requestor_id` FOREIGN KEY (`token_requestor_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token_requestor`(`token_requestor_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ADD CONSTRAINT `fk_terminal_token_lifecycle_event_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ADD CONSTRAINT `fk_terminal_token_lifecycle_event_token_id` FOREIGN KEY (`token_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token`(`token_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ADD CONSTRAINT `fk_terminal_ach_account_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ADD CONSTRAINT `fk_terminal_upi_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ADD CONSTRAINT `fk_terminal_alt_payment_method_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ADD CONSTRAINT `fk_terminal_instrument_status_history_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ADD CONSTRAINT `fk_terminal_card_personalization_card_id` FOREIGN KEY (`card_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`card`(`card_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ADD CONSTRAINT `fk_terminal_pin_management_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ADD CONSTRAINT `fk_terminal_credential_vault_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ADD CONSTRAINT `fk_terminal_credential_vault_token_pan_mapping_id` FOREIGN KEY (`token_pan_mapping_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token_pan_mapping`(`token_pan_mapping_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ADD CONSTRAINT `fk_terminal_instrument_limit_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ADD CONSTRAINT `fk_terminal_instrument_feature_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ADD CONSTRAINT `fk_terminal_card_replacement_card_id` FOREIGN KEY (`card_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`card`(`card_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ADD CONSTRAINT `fk_terminal_instrument_verification_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ADD CONSTRAINT `fk_terminal_instrument_verification_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ADD CONSTRAINT `fk_terminal_instrument_block_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ADD CONSTRAINT `fk_terminal_secure_element_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ADD CONSTRAINT `fk_terminal_instrument_expiry_schedule_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ADD CONSTRAINT `fk_terminal_pan_alias_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_acceptance_type_id` FOREIGN KEY (`acceptance_type_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`acceptance_type`(`acceptance_type_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_software_id` FOREIGN KEY (`software_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`software`(`software_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ADD CONSTRAINT `fk_terminal_deployment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ADD CONSTRAINT `fk_terminal_terminal_config_contactless_profile_id` FOREIGN KEY (`contactless_profile_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`contactless_profile`(`contactless_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ADD CONSTRAINT `fk_terminal_terminal_config_emv_parameter_set_id` FOREIGN KEY (`emv_parameter_set_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`emv_parameter_set`(`emv_parameter_set_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ADD CONSTRAINT `fk_terminal_terminal_config_receipt_template_id` FOREIGN KEY (`receipt_template_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`receipt_template`(`receipt_template_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ADD CONSTRAINT `fk_terminal_terminal_config_software_id` FOREIGN KEY (`software_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`software`(`software_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ADD CONSTRAINT `fk_terminal_terminal_config_terminal_group_id` FOREIGN KEY (`terminal_group_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`terminal_group`(`terminal_group_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ADD CONSTRAINT `fk_terminal_software_update_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ADD CONSTRAINT `fk_terminal_key_injection_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ADD CONSTRAINT `fk_terminal_tid_provisioning_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ADD CONSTRAINT `fk_terminal_inventory_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ADD CONSTRAINT `fk_terminal_assignment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ADD CONSTRAINT `fk_terminal_status_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ADD CONSTRAINT `fk_terminal_tamper_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ADD CONSTRAINT `fk_terminal_maintenance_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ADD CONSTRAINT `fk_terminal_terminal_batch_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ADD CONSTRAINT `fk_terminal_terminal_model_capability_id` FOREIGN KEY (`capability_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`capability`(`capability_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ADD CONSTRAINT `fk_terminal_terminal_model_terminal_certification_id` FOREIGN KEY (`terminal_certification_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`terminal_certification`(`terminal_certification_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ADD CONSTRAINT `fk_terminal_terminal_alert_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ADD CONSTRAINT `fk_terminal_connectivity_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ADD CONSTRAINT `fk_terminal_terminal_fee_schedule_terminal_group_id` FOREIGN KEY (`terminal_group_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`terminal_group`(`terminal_group_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ADD CONSTRAINT `fk_terminal_terminal_fee_schedule_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ADD CONSTRAINT `fk_terminal_p2pe_scope_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ADD CONSTRAINT `fk_terminal_surcharge_config_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ADD CONSTRAINT `fk_terminal_downtime_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ADD CONSTRAINT `fk_terminal_wallet_token_token_requestor_id` FOREIGN KEY (`token_requestor_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token_requestor`(`token_requestor_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ADD CONSTRAINT `fk_terminal_wallet_token_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ADD CONSTRAINT `fk_terminal_wallet_device_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ADD CONSTRAINT `fk_terminal_provisioning_request_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ADD CONSTRAINT `fk_terminal_provisioning_request_token_requestor_id` FOREIGN KEY (`token_requestor_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token_requestor`(`token_requestor_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ADD CONSTRAINT `fk_terminal_provisioning_request_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_original_transaction_wallet_transaction_id` FOREIGN KEY (`original_transaction_wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_token_id` FOREIGN KEY (`token_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token`(`token_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ADD CONSTRAINT `fk_terminal_hce_credential_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ADD CONSTRAINT `fk_terminal_hce_credential_token_id` FOREIGN KEY (`token_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token`(`token_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ADD CONSTRAINT `fk_terminal_upi_registration_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ADD CONSTRAINT `fk_terminal_wallet_balance_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ADD CONSTRAINT `fk_terminal_balance_movement_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ADD CONSTRAINT `fk_terminal_balance_movement_wallet_balance_id` FOREIGN KEY (`wallet_balance_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_balance`(`wallet_balance_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ADD CONSTRAINT `fk_terminal_balance_movement_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ADD CONSTRAINT `fk_terminal_nfc_tap_event_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ADD CONSTRAINT `fk_terminal_nfc_tap_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ADD CONSTRAINT `fk_terminal_nfc_tap_event_token_id` FOREIGN KEY (`token_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token`(`token_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ADD CONSTRAINT `fk_terminal_nfc_tap_event_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ADD CONSTRAINT `fk_terminal_wallet_sca_challenge_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ADD CONSTRAINT `fk_terminal_wallet_sca_challenge_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ADD CONSTRAINT `fk_terminal_wallet_enrollment_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ADD CONSTRAINT `fk_terminal_p2p_transfer_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ADD CONSTRAINT `fk_terminal_p2p_transfer_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ADD CONSTRAINT `fk_terminal_wallet_limit_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ADD CONSTRAINT `fk_terminal_token_pan_mapping_token_requestor_id` FOREIGN KEY (`token_requestor_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token_requestor`(`token_requestor_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ADD CONSTRAINT `fk_terminal_detokenization_request_token_id` FOREIGN KEY (`token_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token`(`token_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ADD CONSTRAINT `fk_terminal_detokenization_request_token_requestor_id` FOREIGN KEY (`token_requestor_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token_requestor`(`token_requestor_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ADD CONSTRAINT `fk_terminal_detokenization_request_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ADD CONSTRAINT `fk_terminal_wallet_notification_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ADD CONSTRAINT `fk_terminal_wallet_notification_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ADD CONSTRAINT `fk_terminal_wallet_consent_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ADD CONSTRAINT `fk_terminal_loyalty_account_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` ADD CONSTRAINT `fk_terminal_terminal_group_parent_terminal_group_id` FOREIGN KEY (`parent_terminal_group_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`terminal_group`(`terminal_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`terminal` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`terminal` SET TAGS ('dbx_domain' = 'terminal');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Full Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `iin` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identification Number (IIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'card|virtual_card|ach|upi|digital_wallet|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `is_3ds_enrolled` SET TAGS ('dbx_business_glossary_term' = '3‑DS Enrollment Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `is_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `is_hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation (HCE) Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `is_nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `is_sca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Virtual Instrument Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `network_brand` SET TAGS ('dbx_business_glossary_term' = 'Network Brand');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `network_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|interac|rupay|others');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `pan_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Primary Account Number (PAN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `pan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `pan_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `pan_token` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Primary Account Number (PAN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `pan_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `pan_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `payment_instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Instrument Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `payment_instrument_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|suspended|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Instrument Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider (TSP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|session|device');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `card_id` SET TAGS ('dbx_business_glossary_term' = 'Card Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Card Activation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Card Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `available_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `card_art_code` SET TAGS ('dbx_business_glossary_term' = 'Card Art Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `card_status` SET TAGS ('dbx_business_glossary_term' = 'Card Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `card_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|lost|stolen|cancelled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|virtual');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless (NFC) Capability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cvv_indicator` SET TAGS ('dbx_business_glossary_term' = 'CVV Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cvv_indicator` SET TAGS ('dbx_value_regex' = 'present|absent|unknown');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cvv_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `cvv_indicator` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Card Deactivation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `embossed_name` SET TAGS ('dbx_business_glossary_term' = 'Embossed Cardholder Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `emv_capable` SET TAGS ('dbx_business_glossary_term' = 'EMV Chip Capability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `expiry_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `expiry_month` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `expiry_year` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `expiry_year` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Card Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Virtual Card Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `issuance_channel` SET TAGS ('dbx_business_glossary_term' = 'Card Issuance Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `issuance_channel` SET TAGS ('dbx_value_regex' = 'online|branch|partner|api');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Card Issue Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Card Use Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Card Credit Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `magnetic_stripe` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Stripe Presence');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `number_last4` SET TAGS ('dbx_business_glossary_term' = 'Card Number Last Four Digits');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `number_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `number_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `pan_token` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Number Token (PAN Token)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `pan_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `pan_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `pin_change_date` SET TAGS ('dbx_business_glossary_term' = 'PIN Change Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `pin_set` SET TAGS ('dbx_business_glossary_term' = 'PIN Set Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Card Token');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `tokenization_service` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Service Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `wallet_bin_range_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet BIN Range ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `bin_length` SET TAGS ('dbx_business_glossary_term' = 'BIN Length');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `bin_prefix` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Prefix');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `bin_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,11}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,19}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,19}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|JCB|UnionPay');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|corporate|government');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_value_regex' = 'pci|psd2|sox|gdpr|ccpa|ofac');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `dpan_supported` SET TAGS ('dbx_business_glossary_term' = 'DPAN Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `funding_type` SET TAGS ('dbx_value_regex' = 'funded|non_funded|prepaid|debit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `interchange_eligible` SET TAGS ('dbx_business_glossary_term' = 'Interchange Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `interchange_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Rate (%)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `issuing_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `network` SET TAGS ('dbx_business_glossary_term' = 'Payment Network');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'consumer|business|government|travel|rewards|corporate');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `transaction_routing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Transaction Routing Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `transaction_routing_indicator` SET TAGS ('dbx_value_regex' = 'online|pos|mpos|ecom|atm|mobile');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `wallet_bin_range_status` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `wallet_bin_range_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `wallet_card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Card Scheme Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Scheme Operator Contact Email');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Scheme Operator Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^[+]?d{1,15}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `cross_border_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `dispute_resolution_policy` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Policy');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `dynamic_currency_conversion_supported` SET TAGS ('dbx_business_glossary_term' = 'DCC Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `interchange_fee_model` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Model');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `interchange_fee_model` SET TAGS ('dbx_value_regex' = 'percentage|flat|tiered|mixed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Scheme Operator Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `pci_dss_compliant` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `psd2_compliant` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Scheme Rule Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `scheme_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `scheme_name` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `supported_card_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Types');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `supported_card_types` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|corporate');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `supported_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `supported_transaction_types` SET TAGS ('dbx_value_regex' = 'purchase|refund|cash_advance|preauth|auth_capture|reversal');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `wallet_card_scheme_description` SET TAGS ('dbx_business_glossary_term' = 'Scheme Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `wallet_card_scheme_status` SET TAGS ('dbx_business_glossary_term' = 'Scheme Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `wallet_card_scheme_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Scheme Website URL');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_card_scheme` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `emv_config_id` SET TAGS ('dbx_business_glossary_term' = 'EMV Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `card_id` SET TAGS ('dbx_business_glossary_term' = 'Card Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `aid` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (AID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `compliance_pci_dss_version` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'EMV Configuration Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'EMV Configuration Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `config_type` SET TAGS ('dbx_business_glossary_term' = 'EMV Configuration Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `config_type` SET TAGS ('dbx_value_regex' = 'contactless|magstripe|chip|dual_interface');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `contactless_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `cryptogram_type` SET TAGS ('dbx_business_glossary_term' = 'Cryptogram Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `cryptogram_type` SET TAGS ('dbx_value_regex' = 'ARQC|TC|AAC');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `cumulative_limit` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `cvm_required_flag` SET TAGS ('dbx_business_glossary_term' = 'CVM Required Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `cvm_requirements` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Verification Method Requirements');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `daily_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `dynamic_currency_conversion_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Supported Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `dynamic_data_authentication_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Data Authentication Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `emv_config_description` SET TAGS ('dbx_business_glossary_term' = 'EMV Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `emv_config_status` SET TAGS ('dbx_business_glossary_term' = 'EMV Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `emv_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `emvco_spec_version` SET TAGS ('dbx_business_glossary_term' = 'EMVCo Specification Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `floor_limit` SET TAGS ('dbx_business_glossary_term' = 'Floor Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `issuer_action_codes` SET TAGS ('dbx_business_glossary_term' = 'Issuer Action Codes (IAC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `offline_data_auth_method` SET TAGS ('dbx_business_glossary_term' = 'Offline Data Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `offline_data_auth_method` SET TAGS ('dbx_value_regex' = 'SDA|DDA|CDA');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `offline_pin_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Offline PIN Verification Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `online_pin_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Online PIN Verification Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `personalization_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Personalization Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `static_data_authentication_flag` SET TAGS ('dbx_business_glossary_term' = 'Static Data Authentication Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `supported_card_schemes` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Schemes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `supported_card_schemes` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|JCB|UnionPay');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `terminal_action_codes` SET TAGS ('dbx_business_glossary_term' = 'Terminal Action Codes (TAC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `terminal_capability` SET TAGS ('dbx_business_glossary_term' = 'Terminal Capability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `tokenization_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Per‑Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `transaction_type_supported` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `transaction_type_supported` SET TAGS ('dbx_value_regex' = 'purchase|cash|refund|preauth');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_holder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Holder Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_holder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_holder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `token_requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor Identifier (REQ_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_account_type` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Account Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_account_type` SET TAGS ('dbx_value_regex' = 'CHECKING|SAVINGS|CREDIT|DEBIT|PREPAID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_currency` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_expiry` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_hash` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Hash (FPAN_HASH)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_hash` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Holder Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_issuer` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Issuer');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_last4` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Last 4 Digits (FPAN_LAST4)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_network` SET TAGS ('dbx_business_glossary_term' = 'Funding PAN Network');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Algorithm');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_compliance` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Compliance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Key Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_key_version` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Key Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_notes` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_status` SET TAGS ('dbx_value_regex' = 'SUCCESS|FAILED|PENDING');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `fpan_tokenization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Token Issue Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `last_used_location` SET TAGS ('dbx_business_glossary_term' = 'Token Last Used Location');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Token Last Used Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_value_regex' = 'NFC|IN_APP|E_COMMERCE|API');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `scheme` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|OTHER');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider (TSP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `token_status` SET TAGS ('dbx_business_glossary_term' = 'Token Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `token_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|SUSPENDED|REVOKED|EXPIRED');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'DPAN|HCE|CLOUD');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `token_value` SET TAGS ('dbx_business_glossary_term' = 'Token Value (TOKEN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Token Usage Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ALTER COLUMN `wallet_provider` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Token Lifecycle Event ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Identifier (WALLET_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Token Identifier (TOKEN_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Event Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile_app|pos|nfc|qr');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `device_reference` SET TAGS ('dbx_business_glossary_term' = 'Device Reference (DEVICE_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `device_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `device_reference` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Token Lifecycle Event Type (EVENT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'provisioning|activation|suspension|resumption|deletion|expiry');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `initiating_actor` SET TAGS ('dbx_business_glossary_term' = 'Initiating Actor');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `initiating_actor` SET TAGS ('dbx_value_regex' = 'cardholder|wallet_provider|issuer|tsp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `is_restricted_token` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Token');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `is_test_token` SET TAGS ('dbx_business_glossary_term' = 'Is Test Token');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Token Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'inactive|active|suspended|expired|deleted|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Token Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'inactive|active|suspended|expired|deleted|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'digital_wallet_platform|gateway|fraud_system');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Token Activation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_deletion_reason` SET TAGS ('dbx_business_glossary_term' = 'Token Deletion Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_scheme` SET TAGS ('dbx_value_regex' = 'EMV|PCI|Visa|Mastercard');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Token Suspension Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'DPAN|virtual_card|mobile_token|contactless');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_lifecycle_event` ALTER COLUMN `token_version` SET TAGS ('dbx_business_glossary_term' = 'Token Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `ach_account_id` SET TAGS ('dbx_business_glossary_term' = 'ACH Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked ACH Account Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_value_regex' = '^*{6}d{4}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'ACH Account Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|corporate|government|loan');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `ach_account_status` SET TAGS ('dbx_business_glossary_term' = 'ACH Account Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `ach_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `authorization_type` SET TAGS ('dbx_business_glossary_term' = 'ACH Authorization Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `authorization_type` SET TAGS ('dbx_value_regex' = 'PPD|CCD|WEB|TEL');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Account Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Bank City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_id_number` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Full Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_type` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `holder_type` SET TAGS ('dbx_value_regex' = 'individual|business');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `is_ach_enabled` SET TAGS ('dbx_business_glossary_term' = 'ACH Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `micro_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Micro‑Deposit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `micro_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Postal Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `prenote_status` SET TAGS ('dbx_business_glossary_term' = 'Prenote Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `prenote_status` SET TAGS ('dbx_value_regex' = 'not_prenoted|prenoted|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'ABA Routing Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^d{9}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Bank State/Province');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'micro_deposit|instant|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`ach_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `upi_id` SET TAGS ('dbx_business_glossary_term' = 'Unified Payments Interface (UPI) Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Service Provider Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `linked_account_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Bank Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `linked_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `linked_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `linked_linked_account_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Bank Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `linked_linked_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `linked_linked_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Service Provider Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'Anti‑Money Laundering (AML) Check Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'not_started|passed|failed|exempt');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|INR|GBP|JPY|AUD');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `failed_auth_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Authentication Attempts');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `last_successful_auth_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Authentication Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `max_failed_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Failed Authentication Attempts');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `pin_set` SET TAGS ('dbx_business_glossary_term' = 'UPI PIN Set Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `privacy_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Given Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'UPI Registration Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'pending|registered|rejected|suspended');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'not_started|passed|failed|exempt');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|api|pos');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_value_regex' = 'not_tokenized|tokenized|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'UPI Verification Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `vpa` SET TAGS ('dbx_business_glossary_term' = 'Virtual Payment Address (VPA)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `vpa` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `vpa` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `vpa_type` SET TAGS ('dbx_business_glossary_term' = 'Virtual Payment Address Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ALTER COLUMN `vpa_type` SET TAGS ('dbx_value_regex' = 'personal|business');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `alt_payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Alternative Payment Method Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `alt_payment_method_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `alt_payment_method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `alt_payment_method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `contactless_type` SET TAGS ('dbx_business_glossary_term' = 'Contactless Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `contactless_type` SET TAGS ('dbx_value_regex' = 'nfc|qr|bluetooth|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `country_of_issuance` SET TAGS ('dbx_business_glossary_term' = 'Country of Issuance (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `country_of_issuance` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `daily_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `external_account_reference` SET TAGS ('dbx_business_glossary_term' = 'External Account Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `external_account_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `external_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `fee_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `is_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Virtual Payment Method Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `last_aml_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last AML Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `last_sanction_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sanctions Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Alternative Payment Method Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `method_name` SET TAGS ('dbx_business_glossary_term' = 'Alternative Payment Method Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Payment Method Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'bnpl|qr|voucher|crypto|open_banking|stored_value');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `monthly_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `requires_kyc` SET TAGS ('dbx_business_glossary_term' = 'KYC Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `supporting_documents` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `tokenization_scheme` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `tokenization_scheme` SET TAGS ('dbx_value_regex' = 'DPAN|HCE|PCI_P2PE');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Per‑Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`alt_payment_method` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `instrument_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Status History ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Status Change Event Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|suspension|reactivation|cancellation|expiry|lost_theft');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `initiating_actor` SET TAGS ('dbx_business_glossary_term' = 'Initiating Actor');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `initiating_actor` SET TAGS ('dbx_value_regex' = 'cardholder|issuer|fraud_system|compliance|system_admin');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `is_manual_change` SET TAGS ('dbx_business_glossary_term' = 'Manual Change Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Instrument Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|expired|cancelled|lost_theft');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Status Change Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Instrument Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|expired|cancelled|lost_theft');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'digital_wallet|payment_gateway|fraud_platform|risk_compliance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_status_history` ALTER COLUMN `supporting_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Reference ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `card_personalization_id` SET TAGS ('dbx_business_glossary_term' = 'Card Personalization ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `card_id` SET TAGS ('dbx_business_glossary_term' = 'Card Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `card_art_template_code` SET TAGS ('dbx_business_glossary_term' = 'Card Art Template ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `cvv_cvc_generation_method` SET TAGS ('dbx_business_glossary_term' = 'CVV/CVC Generation Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `cvv_cvc_generation_method` SET TAGS ('dbx_value_regex' = 'algorithmic|random|issuer_defined');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `cvv_cvc_generation_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `cvv_cvc_generation_method` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `cvv_cvc_key` SET TAGS ('dbx_business_glossary_term' = 'CVV/CVC Key');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `cvv_cvc_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `cvv_cvc_key` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `personalization_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Personalization Batch Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `personalization_bureau_reference` SET TAGS ('dbx_business_glossary_term' = 'Personalization Bureau Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `personalization_name` SET TAGS ('dbx_business_glossary_term' = 'Personalization Specification Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `personalization_status` SET TAGS ('dbx_business_glossary_term' = 'Personalization Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `personalization_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `personalization_type` SET TAGS ('dbx_business_glossary_term' = 'Personalization Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `personalization_type` SET TAGS ('dbx_value_regex' = 'standard|instant|virtual|tokenized');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `pin_offset` SET TAGS ('dbx_business_glossary_term' = 'PIN Offset');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `pin_offset` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `pin_offset` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Card Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_management_id` SET TAGS ('dbx_business_glossary_term' = 'PIN Management Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `hsm_key_reference` SET TAGS ('dbx_business_glossary_term' = 'HSM Key Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `hsm_key_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_block_format` SET TAGS ('dbx_business_glossary_term' = 'PIN Block Format');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_block_format` SET TAGS ('dbx_value_regex' = 'iso_9564_1|iso_9564_2|custom');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'PIN Blocked Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_blocked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PIN Blocked Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_change_count` SET TAGS ('dbx_business_glossary_term' = 'PIN Change Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PIN Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exception');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'PIN Encryption Algorithm');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_encryption_algorithm` SET TAGS ('dbx_value_regex' = 'tdes|aes|rsa');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_failed_attempts` SET TAGS ('dbx_business_glossary_term' = 'Consecutive PIN Failed Attempts');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_label` SET TAGS ('dbx_business_glossary_term' = 'PIN Label');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PIN Last Changed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_last_failed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PIN Last Failed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_last_successful_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PIN Last Successful Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_reset_method` SET TAGS ('dbx_business_glossary_term' = 'PIN Reset Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_reset_method` SET TAGS ('dbx_value_regex' = 'ivr|online|branch|atm');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_reset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PIN Reset Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_set_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PIN Set Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_status` SET TAGS ('dbx_business_glossary_term' = 'PIN Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_status` SET TAGS ('dbx_value_regex' = 'active|blocked|reset_pending|expired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_tries_remaining` SET TAGS ('dbx_business_glossary_term' = 'PIN Tries Remaining');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_type` SET TAGS ('dbx_business_glossary_term' = 'PIN Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|virtual');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `pin_version` SET TAGS ('dbx_business_glossary_term' = 'PIN Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pin_management` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `credential_vault_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Vault Identifier (CVID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `token_pan_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Mapping Identifier (TMI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `access_control_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Access Control Policy Identifier (ACPI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference (ALR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier (ATI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `business_identifier` SET TAGS ('dbx_business_glossary_term' = 'Business Identifier (BI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Credential Classification (CC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'PCI|PCI_DSS|PCI_P2PE|PCI_PIN');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp (CT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status (CS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `credential_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|compromised|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type (CT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'pan|cvv|cvc|token|pin|account_number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `credential_vault_description` SET TAGS ('dbx_business_glossary_term' = 'Credential Description (CD)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `cvv_vault_reference` SET TAGS ('dbx_business_glossary_term' = 'CVV Vault Reference (CVVR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `cvv_vault_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `cvv_vault_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Level (DSL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm (EA)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_value_regex' = 'AES-256|RSA-2048|SM4');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Identifier (EKID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp (ET)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `hsm_module_reference` SET TAGS ('dbx_business_glossary_term' = 'HSM Module Identifier (HSMI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `is_hsm_protected` SET TAGS ('dbx_business_glossary_term' = 'HSM Protection Flag (HPF)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Flag (TF)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `key_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Key Expiry Timestamp (KET)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `key_management_service` SET TAGS ('dbx_business_glossary_term' = 'Key Management Service (KMS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `key_management_service` SET TAGS ('dbx_value_regex' = 'AWS_KMS|Azure_KeyVault|Google_KMS|OnPrem');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `key_rotation_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Key Rotation Interval (Days) (KRI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `key_rotation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Key Rotation Timestamp (KRT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version (EKV)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `last_accessed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed By (LAB)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp (LAT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `owner_party_reference` SET TAGS ('dbx_business_glossary_term' = 'Owner Party Identifier (OPI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `pan_token_reference` SET TAGS ('dbx_business_glossary_term' = 'PAN Token Reference (PTR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `pan_token_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `pan_token_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days) (RP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `tokenization_scheme` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Scheme (TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `tokenization_scheme` SET TAGS ('dbx_value_regex' = 'PCI_DSS|EMV|3DS|DCC');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By (LUB)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp (LUT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `vault_location` SET TAGS ('dbx_business_glossary_term' = 'Vault Location Identifier (VLI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`credential_vault` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CB)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `instrument_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Limit ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `atm_withdrawal_limit` SET TAGS ('dbx_business_glossary_term' = 'ATM Withdrawal Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `contactless_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Contactless Transaction Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `daily_spend_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `daily_spend_used_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Used Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `ecommerce_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'E‑Commerce Transaction Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mode');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_value_regex' = 'hard|soft|dynamic');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `instrument_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Limit Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `instrument_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `international_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'International Transaction Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flagged Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `is_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `last_enforced_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Enforced Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `limit_group_code` SET TAGS ('dbx_business_glossary_term' = 'Limit Group Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_value_regex' = 'instrument|card_program|cardholder|merchant');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'spending|withdrawal|international|contactless|ecommerce|atm');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `limit_version` SET TAGS ('dbx_business_glossary_term' = 'Limit Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `monthly_spend_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Spend Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `monthly_spend_used_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Spend Used Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `per_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Per-Transaction Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|wallet|fraud_engine|settlement|compliance|admin');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `transaction_count_month` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Month');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `transaction_count_today` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Today');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_limit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `instrument_feature_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Feature ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `feature_category` SET TAGS ('dbx_business_glossary_term' = 'Feature Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `feature_code` SET TAGS ('dbx_business_glossary_term' = 'Feature Code (FC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `instrument_feature_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `instrument_feature_status` SET TAGS ('dbx_value_regex' = 'enabled|disabled|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Feature Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Limit Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Feature Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Feature Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `usage_counter` SET TAGS ('dbx_business_glossary_term' = 'Usage Counter');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `usage_reset_period` SET TAGS ('dbx_business_glossary_term' = 'Usage Reset Period');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_feature` ALTER COLUMN `usage_reset_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|yearly');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `card_replacement_id` SET TAGS ('dbx_business_glossary_term' = 'Card Replacement ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `card_id` SET TAGS ('dbx_business_glossary_term' = 'Original Card ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `card_replacement_status` SET TAGS ('dbx_business_glossary_term' = 'Replacement Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `card_replacement_status` SET TAGS ('dbx_value_regex' = 'requested|approved|delivered|activated|cancelled|rejected');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `delivery_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tracking Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `fee_waiver_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'mail|courier|in_branch|digital');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `is_replacement_card_contactless` SET TAGS ('dbx_business_glossary_term' = 'Replacement Card Contactless Capability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `is_replacement_card_hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Replacement Card HCE Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `is_replacement_card_nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Replacement Card NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `is_replacement_card_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Replacement Card Tokenized Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `replacement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Replacement Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `replacement_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Replacement Fee Currency');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `replacement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Replacement Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `replacement_reason_code` SET TAGS ('dbx_value_regex' = 'lost|stolen|damaged|expired|upgrade|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `replacement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Reference Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `request_channel` SET TAGS ('dbx_value_regex' = 'online|mobile_app|phone|branch|mail');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `rush_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Rush Delivery Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_value_regex' = 'visa|mastercard|tsp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `instrument_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Verification ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_business_glossary_term' = 'AVS Response Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_business_glossary_term' = 'Biometric Match Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `compliance_pci_dss` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `compliance_psd2_sca` SET TAGS ('dbx_business_glossary_term' = 'PSD2 SCA Compliance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_business_glossary_term' = 'CVV Response Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Expiration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `micro_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Micro‑Deposit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `micro_deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Micro‑Deposit Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `micro_deposit_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'pending|completed|error|rejected');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `risk_score_at_verification` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Verification');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_business_glossary_term' = '3‑DS Authentication Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_value_regex' = 'authenticated|challenge_required|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_value_regex' = 'tokenized|not_tokenized|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_channel` SET TAGS ('dbx_business_glossary_term' = 'Verification Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_channel` SET TAGS ('dbx_value_regex' = 'online|pos|mobile_app|api|call_center');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_method_detail` SET TAGS ('dbx_business_glossary_term' = 'Verification Method Detail');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ALTER COLUMN `verification_type` SET TAGS ('dbx_value_regex' = 'avs|cvv|3ds|biometric|micro_deposit|tokenization');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `instrument_block_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Block ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `affected_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Affected Transaction Types');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `affected_transaction_types` SET TAGS ('dbx_value_regex' = 'purchase|cash_advance|refund|transfer|settlement|authorization');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `block_amount_limit` SET TAGS ('dbx_business_glossary_term' = 'Block Amount Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `block_category` SET TAGS ('dbx_business_glossary_term' = 'Block Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `block_category` SET TAGS ('dbx_value_regex' = 'spending|withdrawal|online|offline|cross_border|contactless');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Block Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `block_reference` SET TAGS ('dbx_business_glossary_term' = 'Block Reference Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'fraud|compliance|cardholder|issuer|regulatory|system');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `blocking_authority` SET TAGS ('dbx_business_glossary_term' = 'Blocking Authority');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `blocking_authority` SET TAGS ('dbx_value_regex' = 'fraud_system|compliance|cardholder|issuer|regulatory|system');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Block End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `instrument_block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `instrument_block_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|revoked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `is_cardholder_requested` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Request Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `is_compliance_triggered` SET TAGS ('dbx_business_glossary_term' = 'Compliance Trigger Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `is_fraud_triggered` SET TAGS ('dbx_business_glossary_term' = 'Fraud Trigger Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `is_issuer_requested` SET TAGS ('dbx_business_glossary_term' = 'Issuer Request Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `is_temporary` SET TAGS ('dbx_business_glossary_term' = 'Temporary Block Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `mcc_restriction_list` SET TAGS ('dbx_business_glossary_term' = 'MCC Restriction List');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Block Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `regulatory_hold` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Block Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_block` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `secure_element_id` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Identifier (SE_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Device Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `compliance_emvco` SET TAGS ('dbx_business_glossary_term' = 'EMVCo Compliance Flag (EMVCO_COMPLIANT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `compliance_pci_dss` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Flag (PCI_COMPLIANT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `cross_border_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Support Flag (CROSS_BORDER_SUPPORT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `cryptographic_key_set_reference` SET TAGS ('dbx_business_glossary_term' = 'Cryptographic Key Set Reference (KEY_SET_REF)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `cryptographic_key_set_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `decommission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decommission Timestamp (DECOMMISSION_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DEVICE_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `device_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `dynamic_currency_conversion_supported` SET TAGS ('dbx_business_glossary_term' = 'DCC Support Flag (DCC_SUPPORT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FW_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Enabled (HCE_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `is_test_se` SET TAGS ('dbx_business_glossary_term' = 'Test Secure Element Flag (IS_TEST_SE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `key_set_expiry` SET TAGS ('dbx_business_glossary_term' = 'Key Set Expiry Date (KEY_SET_EXP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `key_set_version` SET TAGS ('dbx_business_glossary_term' = 'Key Set Version (KEY_SET_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `last_provisioned_by` SET TAGS ('dbx_business_glossary_term' = 'Last Provisioned By (PROV_BY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `last_provisioned_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `last_provisioned_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `last_provisioned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Provisioned Timestamp (LAST_PROV_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'created|provisioned|active|decommissioned|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount (MAX_TXN_AMT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `nfc_capable` SET TAGS ('dbx_business_glossary_term' = 'NFC Capability Flag (NFC_CAPABLE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System Version (OS_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status (PROV_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_value_regex' = 'pending|provisioned|failed|deprovisioned');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `provisioning_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Timestamp (PROV_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `se_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Manufacturer (SE_MANUFACTURER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `se_model` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Model (SE_MODEL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `se_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Serial Number (SE_SN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `se_serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `se_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `se_type` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Type (SE_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `se_type` SET TAGS ('dbx_value_regex' = 'embedded|sim|cloud_hce');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `secure_element_status` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Status (SE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `secure_element_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level (SEC_LEVEL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Support Flag (TOKEN_SUPPORT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`secure_element` ALTER COLUMN `wallet_provider` SET TAGS ('dbx_business_glossary_term' = 'Wallet Provider (WALLET_PROVIDER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `instrument_expiry_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Expiry Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `block_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Block Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `instrument_expiry_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `instrument_expiry_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'card|digital_wallet|token|virtual_card');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Instrument Blocked Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `last_renewal_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Attempt Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `reissuance_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reissuance Lead Time (Days)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Attempt Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Renewal Batch ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Renewal Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Suppression Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Window End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `renewal_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Window Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_expiry_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` SET TAGS ('dbx_subdomain' = 'instrument_management');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `pan_alias_id` SET TAGS ('dbx_business_glossary_term' = 'PAN Alias Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_description` SET TAGS ('dbx_business_glossary_term' = 'Alias Description (ALIAS_DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_purpose` SET TAGS ('dbx_business_glossary_term' = 'Alias Purpose (ALIAS_PURPOSE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_purpose` SET TAGS ('dbx_value_regex' = 'customer_display|statement|receipt|internal_use');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_type` SET TAGS ('dbx_business_glossary_term' = 'Alias Type (ALIAS_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_type` SET TAGS ('dbx_value_regex' = 'masked_pan|last_four|display_token|reference_number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_value` SET TAGS ('dbx_business_glossary_term' = 'Alias Value (ALIAS_VALUE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `alias_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Created Timestamp (AUDIT_CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated Timestamp (AUDIT_UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code (COMPLIANCE_CHECK_CODE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed (COMPLIANCE_CHECK_PASSED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp (CREATION_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp (EXPIRY_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `is_pci_compliant` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Flag (IS_PCI_COMPLIANT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `is_restricted_alias` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Alias (IS_RESTRICTED_ALIAS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `is_test_alias` SET TAGS ('dbx_business_glossary_term' = 'Is Test Alias (IS_TEST_ALIAS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Is Tokenized (IS_TOKENIZED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `pan_alias_status` SET TAGS ('dbx_business_glossary_term' = 'Alias Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `pan_alias_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|revoked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider (TOKEN_SERVICE_PROVIDER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type (TOKEN_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|session|device');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pan_alias` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'POS Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `acceptance_type_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Acceptance Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `dcc_config_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `ledger_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `software_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Software Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_audit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `connectivity_type` SET TAGS ('dbx_value_regex' = 'wired|wifi|cellular|ethernet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `device_certification_body` SET TAGS ('dbx_business_glossary_term' = 'Device Certification Body');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `emv_capable` SET TAGS ('dbx_business_glossary_term' = 'EMV Chip Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `form_factor` SET TAGS ('dbx_business_glossary_term' = 'Form Factor');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `form_factor` SET TAGS ('dbx_value_regex' = 'countertop|mpos|kiosk|softpos');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `last_software_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Software Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|overdue|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `nfc_capable` SET TAGS ('dbx_business_glossary_term' = 'NFC Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `pci_pts_cert_level` SET TAGS ('dbx_business_glossary_term' = 'PCI PTS Certification Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `pci_pts_cert_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|level4');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `pos_terminal_status` SET TAGS ('dbx_business_glossary_term' = 'Terminal Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `pos_terminal_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number (SN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `tamper_seal_status` SET TAGS ('dbx_business_glossary_term' = 'Tamper‑Evident Seal Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `tamper_seal_status` SET TAGS ('dbx_value_regex' = 'intact|broken|unknown');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Terminal Capabilities');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_capabilities` SET TAGS ('dbx_value_regex' = 'contactless|chip|magstripe|contact|nfc|tokenization');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_city` SET TAGS ('dbx_business_glossary_term' = 'Terminal City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification Number (TID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_latitude` SET TAGS ('dbx_business_glossary_term' = 'Terminal Latitude');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_longitude` SET TAGS ('dbx_business_glossary_term' = 'Terminal Longitude');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Owner Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_owner_type` SET TAGS ('dbx_value_regex' = 'internal|partner|third_party');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_region` SET TAGS ('dbx_business_glossary_term' = 'Terminal Region');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_security_cert_expiry` SET TAGS ('dbx_business_glossary_term' = 'Security Certificate Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `terminal_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Deployment ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID (MID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Result');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|exception');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `cost_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Cost Adjustment (USD)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `cost_gross` SET TAGS ('dbx_business_glossary_term' = 'Deployment Gross Cost (USD)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `cost_net` SET TAGS ('dbx_business_glossary_term' = 'Deployment Net Cost (USD)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_transit|installed|activated|decommissioned');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Installation Contact Email');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Installation Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_technician_name` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `installation_technician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `is_contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `is_emv_enabled` SET TAGS ('dbx_business_glossary_term' = 'EMV Capability Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `is_nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Capability Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Deployment Reference Number (DRN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Deployment Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Deployment Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Shipping Carrier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_city` SET TAGS ('dbx_business_glossary_term' = 'Site City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Site Postal Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `site_state` SET TAGS ('dbx_business_glossary_term' = 'Site State/Province');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `terminal_model` SET TAGS ('dbx_business_glossary_term' = 'Terminal Model');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `terminal_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Terminal Serial Number (SN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'POS|mPOS|ATM|Kiosk');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `terminal_config_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `contactless_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Contactless Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `emv_parameter_set_id` SET TAGS ('dbx_business_glossary_term' = 'Emv Parameter Set Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `receipt_template_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt Template Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `software_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Software Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `terminal_group_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Group ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `accepted_card_schemes` SET TAGS ('dbx_business_glossary_term' = 'Accepted Card Schemes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `accepted_card_schemes` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `dcc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `idle_screen_timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Idle Screen Timeout (seconds)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `is_default_config` SET TAGS ('dbx_business_glossary_term' = 'Default Configuration Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Interface Locale');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `offline_floor_limit` SET TAGS ('dbx_business_glossary_term' = 'Offline Floor Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `pin_entry_mode` SET TAGS ('dbx_business_glossary_term' = 'PIN Entry Mode');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `pin_entry_mode` SET TAGS ('dbx_value_regex' = 'online|offline|both');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `requires_pin_entry` SET TAGS ('dbx_business_glossary_term' = 'Requires PIN Entry Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `retry_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Retry Interval (seconds)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `supports_emv` SET TAGS ('dbx_business_glossary_term' = 'EMV Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `supports_nfc` SET TAGS ('dbx_business_glossary_term' = 'NFC Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `terminal_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `terminal_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'countertop|mobile|mpos|self_service|kiosk');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `tip_prompt_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tip Prompt Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `tip_prompt_options` SET TAGS ('dbx_business_glossary_term' = 'Tip Prompt Options');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `tip_prompt_options` SET TAGS ('dbx_value_regex' = 'none|percentage|fixed|percentage_and_fixed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `emv_parameter_set_id` SET TAGS ('dbx_business_glossary_term' = 'EMV Parameter Set Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `additional_terminal_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Additional Terminal Capabilities (ATCAP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `aid` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (AID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `application_interchange_profile` SET TAGS ('dbx_business_glossary_term' = 'Application Interchange Profile (AIP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `application_transaction_counter` SET TAGS ('dbx_business_glossary_term' = 'Application Transaction Counter (ATC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `application_version_number` SET TAGS ('dbx_business_glossary_term' = 'Application Version Number (AVN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled Flag (CONTACTLESS_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `cvm_list` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Verification Method List (CVM_LIST)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `cvm_list` SET TAGS ('dbx_value_regex' = 'signature|online_pin|offline_pin|no_cvm|mobile_cvm');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `emv_parameter_set_description` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set Description (DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `emv_parameter_set_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set Lifecycle Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `emv_parameter_set_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `floor_limit` SET TAGS ('dbx_business_glossary_term' = 'Floor Limit (FLOOR_LIMIT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Parameter Set Flag (IS_DEFAULT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `kernel_version` SET TAGS ('dbx_business_glossary_term' = 'EMV Kernel Version (KERNEL_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Timestamp (LAST_AUDIT_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `offline_data_authentication` SET TAGS ('dbx_business_glossary_term' = 'Offline Data Authentication Method (ODA_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `offline_data_authentication` SET TAGS ('dbx_value_regex' = 'static|dynamic|combined');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `offline_pin_supported` SET TAGS ('dbx_business_glossary_term' = 'Offline PIN Supported Flag (OFFLINE_PIN_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `online_pin_supported` SET TAGS ('dbx_business_glossary_term' = 'Online PIN Supported Flag (ONLINE_PIN_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `random_selection_percentage` SET TAGS ('dbx_business_glossary_term' = 'Random Transaction Selection Percentage (RANDOM_SELECTION_PCT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Scheme (SCHEME)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `scheme` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|UnionPay');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `tac_default` SET TAGS ('dbx_business_glossary_term' = 'Terminal Action Code – Default (TAC_DEFAULT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `tac_denial` SET TAGS ('dbx_business_glossary_term' = 'Terminal Action Code – Denial (TAC_DENIAL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `tac_online` SET TAGS ('dbx_business_glossary_term' = 'Terminal Action Code – Online (TAC_ONLINE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `terminal_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Terminal Capabilities (TCAP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `transaction_type_support` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types (TXN_TYPE_SUPPORT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `transaction_type_support` SET TAGS ('dbx_value_regex' = 'purchase|cash|refund|preauth|completion');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `velocity_check_limit` SET TAGS ('dbx_business_glossary_term' = 'Velocity Check Transaction Limit (VELOCITY_LIMIT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `velocity_check_time_window` SET TAGS ('dbx_business_glossary_term' = 'Velocity Check Time Window (VELOCITY_WINDOW_MIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`emv_parameter_set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `contactless_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Contactless Profile ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_audit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `contactless_fallback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Fallback Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `contactless_fallback_timeout_ms` SET TAGS ('dbx_business_glossary_term' = 'Contactless Fallback Timeout (ms)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `contactless_profile_description` SET TAGS ('dbx_business_glossary_term' = 'Profile Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `contactless_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Contactless Profile Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `contactless_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `contactless_transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Contactless Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `cvm_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'CVM Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `cvm_type` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Verification Method Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `cvm_type` SET TAGS ('dbx_value_regex' = 'signature|pin|none|online');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `dual_interface_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dual Interface Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `dual_interface_routing_rule` SET TAGS ('dbx_business_glossary_term' = 'Dual Interface Routing Rule');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `dual_interface_routing_rule` SET TAGS ('dbx_value_regex' = 'fallback|prefer_contactless|prefer_chip');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `kernel_version` SET TAGS ('dbx_business_glossary_term' = 'Contactless Kernel Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `max_transaction_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Attempts');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `nfc_antenna_gain_db` SET TAGS ('dbx_business_glossary_term' = 'NFC Antenna Gain (dB)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profile Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Contactless Profile Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Contactless Profile Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'Contactless Profile Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'default|custom|partner');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `qr_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'QR Payment Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `qr_payment_type` SET TAGS ('dbx_business_glossary_term' = 'QR Payment Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `qr_payment_type` SET TAGS ('dbx_value_regex' = 'static|dynamic');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `security_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Security Certification Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `security_certification_level` SET TAGS ('dbx_value_regex' = 'PCI_PTS|PCI_PTS_A|PCI_PTS_B');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `supported_kernels` SET TAGS ('dbx_business_glossary_term' = 'Supported Contactless Kernels');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `terminal_software_version` SET TAGS ('dbx_business_glossary_term' = 'Terminal Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`contactless_profile` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `software_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Software ID (TSW_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date (CERT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (CERT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|revoked|expired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA‑256 Checksum (SHA256_CHECKSUM)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `compliance_body` SET TAGS ('dbx_business_glossary_term' = 'Compliance Body (COMPLIANCE_BODY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status (DEPLOY_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'available|deprecated|retired|inactive');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date (DEPRECATION_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature (DIGITAL_SIG)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support Date (EOS_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `file_location_path` SET TAGS ('dbx_business_glossary_term' = 'File Location Path (FILE_PATH)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes (FILE_SIZE_BYTES)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `hardware_model_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model Compatibility (HW_MODEL_COMP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `is_contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Flag (CONTACTLESS_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `is_firmware` SET TAGS ('dbx_business_glossary_term' = 'Firmware Indicator Flag (FIRMWARE_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `is_mandatory_update` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Update Flag (MANDATORY_UPDATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `is_test_version` SET TAGS ('dbx_business_glossary_term' = 'Test Version Flag (TEST_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `pci_validation_date` SET TAGS ('dbx_business_glossary_term' = 'PCI Validation Date (PCI_VAL_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `pci_validation_status` SET TAGS ('dbx_business_glossary_term' = 'PCI Validation Status (PCI_VAL_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `pci_validation_status` SET TAGS ('dbx_value_regex' = 'PA-DSS|P2PE|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `regulatory_compliance_codes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Codes (REG_COMP_CODES)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (REL_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes (REL_NOTES)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type (REL_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'major|minor|patch|hotfix');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `scheme_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Approval Reference (SCHEME_APPROVAL_REF)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `software_description` SET TAGS ('dbx_business_glossary_term' = 'Software Description (SW_DESC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `software_name` SET TAGS ('dbx_business_glossary_term' = 'Terminal Software Name (SW_NAME)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `software_type` SET TAGS ('dbx_business_glossary_term' = 'Software Type (SW_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `software_type` SET TAGS ('dbx_value_regex' = 'payment_kernel|pin_firmware|os|application');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `source_repository` SET TAGS ('dbx_business_glossary_term' = 'Source Repository URL (SRC_REPO_URL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `supported_payment_schemes` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Schemes (PAYMENT_SCHEMES)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `supported_payment_schemes` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `supported_terminal_features` SET TAGS ('dbx_business_glossary_term' = 'Supported Terminal Features (TERMINAL_FEATURES)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `update_priority` SET TAGS ('dbx_business_glossary_term' = 'Update Priority (UPDATE_PRIORITY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `update_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Software Vendor Name (VENDOR_NAME)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Software Version Number (SW_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `software_update_id` SET TAGS ('dbx_business_glossary_term' = 'Software Update Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Update End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Update Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Update Authorization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Software Update Error Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Software Update Error Message');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Software Update Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Software Update Outcome');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'SUCCESS|FAILURE|ROLLED_BACK');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Update End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Update Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `software_version_after` SET TAGS ('dbx_business_glossary_term' = 'Software Version (After Update)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `software_version_before` SET TAGS ('dbx_business_glossary_term' = 'Software Version (Before Update)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `update_method` SET TAGS ('dbx_business_glossary_term' = 'Software Update Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `update_method` SET TAGS ('dbx_value_regex' = 'OTA|USB|NETWORK_DOWNLOAD|MANUAL');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `update_reference` SET TAGS ('dbx_business_glossary_term' = 'Software Update Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `update_status` SET TAGS ('dbx_business_glossary_term' = 'Software Update Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ALTER COLUMN `update_status` SET TAGS ('dbx_value_regex' = 'SCHEDULED|IN_PROGRESS|COMPLETED|FAILED|ROLLED_BACK');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `key_injection_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Key Injection ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier (TID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments or Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `hsm_reference` SET TAGS ('dbx_business_glossary_term' = 'Hardware Security Module Identifier (HSM ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `injection_location` SET TAGS ('dbx_business_glossary_term' = 'Injection Location Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `injection_method` SET TAGS ('dbx_business_glossary_term' = 'Injection Method (Key Injection Facility or Remote Loading)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `injection_method` SET TAGS ('dbx_value_regex' = 'KIF|remote');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `injection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Injection Outcome');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `injection_outcome` SET TAGS ('dbx_value_regex' = 'success|failure');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `injection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Key Injection Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `key_check_value` SET TAGS ('dbx_business_glossary_term' = 'Key Check Value (KCV)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `key_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Key Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `key_type` SET TAGS ('dbx_business_glossary_term' = 'Key Type (TMK/TEK/PIN Encryption Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `key_type` SET TAGS ('dbx_value_regex' = 'TMK|TEK|PIN');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `key_version` SET TAGS ('dbx_business_glossary_term' = 'Key Version Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `key_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `load_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Key Load Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `outcome_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Outcome Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|terminal_mgmt|fraud_platform');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `tid_provisioning_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Provisioning Record ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `acquiring_bin` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `emv_capability` SET TAGS ('dbx_business_glossary_term' = 'EMV Capability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `emv_capability` SET TAGS ('dbx_value_regex' = 'contact|contactless|both');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `last_software_update` SET TAGS ('dbx_business_glossary_term' = 'Last Software Update');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Terminal Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Payment Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `scheme_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Scheme Registration Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `scheme_registration_status` SET TAGS ('dbx_value_regex' = 'registered|pending|rejected|suspended');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `security_certification` SET TAGS ('dbx_business_glossary_term' = 'Security Certification');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `security_certification` SET TAGS ('dbx_value_regex' = 'PCI_PTS_Level1|PCI_PTS_Level2|PCI_PTS_Level3');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'pos|mpos|atm|kiosk|online');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `tid` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification Number (TID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `tid_provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Terminal Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `tid_provisioning_status` SET TAGS ('dbx_value_regex' = 'active|suspended|deregistered|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `terminal_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Certification ID (CERT_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date (APPROVAL_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body (CERT_BODY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number (CERT_NO)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope (SCOPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (CERT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|suspended');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (CERT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (COMPLIANCE_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `conditions_or_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Certification Conditions and Restrictions (CONDITIONS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Enabled (CONTACTLESS_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `cvv_capture_supported` SET TAGS ('dbx_business_glossary_term' = 'CVV Capture Supported (CVV_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `cvv_capture_supported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `cvv_capture_supported` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOMMISSION_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date (DEPLOYMENT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL (CERT_DOC_URL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `emv_level` SET TAGS ('dbx_business_glossary_term' = 'EMV Level (EMV_LEVEL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `emv_level` SET TAGS ('dbx_value_regex' = 'level1|level2');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date (EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FW_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version (HW_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP_ADDR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag (IS_MANDATORY)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code) (JURISDICTION)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp (LAST_AUDIT_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address (MAC_ADDR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `mac_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `magnetic_stripe_supported` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Stripe Supported (MAG_STRIPE_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer (MANUFACTURER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Status (PCI_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|revoked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `pin_entry_supported` SET TAGS ('dbx_business_glossary_term' = 'PIN Entry Supported (PIN_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework (REG_FRAMEWORK)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'pci_ssc|emvco|visa|mastercard|national');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date (RENEWAL_NOTICE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag (RENEWAL_REQUIRED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LEVEL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `secure_element_type` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Type (SECURE_ELEMENT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SERIAL_NO)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version (SW_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `terminal_model` SET TAGS ('dbx_business_glossary_term' = 'Terminal Model (TM)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type (TERMINAL_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'pos|mpos|atm|kiosk');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported (TOKENIZATION_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_certification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version (VERSION)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Inventory ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `current_location_code` SET TAGS ('dbx_business_glossary_term' = 'Current Location Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `current_location_type` SET TAGS ('dbx_business_glossary_term' = 'Current Location Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `current_location_type` SET TAGS ('dbx_value_regex' = 'warehouse|in_transit|merchant_site|repair_depot|store');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `device_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Device Status Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `emv_capability` SET TAGS ('dbx_business_glossary_term' = 'EMV Capability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `emv_capability` SET TAGS ('dbx_value_regex' = 'magstripe|chip|contactless|chip_and_contactless');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|decommissioned|maintenance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Days)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Network Connectivity Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_value_regex' = 'wired|wifi|cellular|ethernet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `pci_pts_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI PTS Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `pci_pts_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `physical_condition` SET TAGS ('dbx_business_glossary_term' = 'Physical Condition');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `physical_condition` SET TAGS ('dbx_value_regex' = 'new|good|fair|poor|damaged');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `power_requirement_w` SET TAGS ('dbx_business_glossary_term' = 'Power Requirement (W)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `security_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Security Certification Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `temperature_rating_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Rating (°C)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Assignment Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Assignment End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assigned_mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assigned_mid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assigned_mid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|seasonal|test');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Decommission Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `decommission_flag` SET TAGS ('dbx_business_glossary_term' = 'Decommission Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `emv_capability` SET TAGS ('dbx_business_glossary_term' = 'EMV Capability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `emv_capability` SET TAGS ('dbx_value_regex' = 'contact|contactless|both');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Assignment End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Terminal Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `lane_number` SET TAGS ('dbx_business_glossary_term' = 'Lane Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `last_software_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Software Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `network_provider` SET TAGS ('dbx_business_glossary_term' = 'Network Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `network_provider` SET TAGS ('dbx_value_regex' = 'visa|mastercard|discover|amex|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Terminal Assignment Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `terminal_model_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal Model Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `terminal_owner` SET TAGS ('dbx_business_glossary_term' = 'Terminal Owner Department');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `terminal_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Terminal Serial Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `terminal_serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `terminal_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Status Event ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Status Actor Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'system|operator|merchant|automated_process');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Request Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `incident_reference` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Terminal Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'provisioned|active|suspended|decommissioned|maintenance|offline');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Terminal Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'provisioned|active|suspended|decommissioned|maintenance|offline');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `status_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `terminal_location` SET TAGS ('dbx_business_glossary_term' = 'Terminal Location');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `terminal_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ALTER COLUMN `terminal_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `tamper_event_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Tamper Event ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `analyst_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `alert_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `compliance_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Report ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'hardware_sensor|software_check|firmware_monitor|network_monitor');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `event_details` SET TAGS ('dbx_business_glossary_term' = 'Event Details');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `investigation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|false_positive|escalated');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `is_alert_sent` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `is_compliance_reported` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reported Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `is_test_event` SET TAGS ('dbx_business_glossary_term' = 'Test Event Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'confirmed_tamper|false_positive|mitigated|escalated_to_security');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `response_action` SET TAGS ('dbx_business_glossary_term' = 'Response Action');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `response_action` SET TAGS ('dbx_value_regex' = 'key_zeroization|self_destruct|alert|shutdown|log_only');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `sensor_reference` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|terminal_management|fraud_platform|wallet_platform');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `tamper_type` SET TAGS ('dbx_business_glossary_term' = 'Tamper Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `tamper_type` SET TAGS ('dbx_value_regex' = 'case_open|voltage_attack|temperature_anomaly|logical_intrusion|sensor_failure|physical_damage');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `maintenance_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Maintenance ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Provider ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Location ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exception');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cost Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `fault_description` SET TAGS ('dbx_business_glossary_term' = 'Fault Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|unscheduled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `mean_time_to_repair_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `part_replaced_details` SET TAGS ('dbx_business_glossary_term' = 'Part Replaced Details');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `part_replaced_flag` SET TAGS ('dbx_business_glossary_term' = 'Part Replaced Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Provider Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'in_house|third_party');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Reference Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `repair_actions` SET TAGS ('dbx_business_glossary_term' = 'Repair Actions');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `replacement_parts` SET TAGS ('dbx_business_glossary_term' = 'Replacement Parts Used');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `return_to_service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return‑to‑Service Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `sla_actual_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Time (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `sla_target_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Time (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `terminal_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Terminal Serial Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `total_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ALTER COLUMN `warranty_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Covered Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `terminal_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Batch ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `acquiring_host_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Host Batch Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (Fees, Discounts)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type (e.g., Day End, Shift, Manual)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'day_end|shift|manual');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Close Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Batch Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `is_batch_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Batch Reconciliation Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Open Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Reconciliation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'Batch Reference Code (BRC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `sequence_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]+$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'open|closed|submitted|settled|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `total_declined_count` SET TAGS ('dbx_business_glossary_term' = 'Total Declined Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ALTER COLUMN `total_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `terminal_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Reconciliation ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Location ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Batch Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exception');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `host_reported_amount` SET TAGS ('dbx_business_glossary_term' = 'Host Reported Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `host_reported_count` SET TAGS ('dbx_business_glossary_term' = 'Host Reported Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `manual_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `manual_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `processing_center_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Center ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'balanced|out_of_balance|pending_investigation|resolved');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'unresolved|investigating|resolved|escalated');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `terminal_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Terminal Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `terminal_reported_amount` SET TAGS ('dbx_business_glossary_term' = 'Terminal Reported Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `terminal_reported_count` SET TAGS ('dbx_business_glossary_term' = 'Terminal Reported Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `terminal_software_version` SET TAGS ('dbx_business_glossary_term' = 'Terminal Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `terminal_status_at_reconciliation` SET TAGS ('dbx_business_glossary_term' = 'Terminal Status at Reconciliation');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `terminal_status_at_reconciliation` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|maintenance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount Variance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `variance_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Variance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'amount_mismatch|count_mismatch|network_error|manual_adjustment|unknown');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `terminal_model_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Model ID (TM_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `capability_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Capability Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `terminal_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Certification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date (CERT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|revoked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `connectivity_options` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Options (CO)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `connectivity_options` SET TAGS ('dbx_value_regex' = 'ethernet|wifi|4g|bluetooth|cellular|satellite');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `dimensions_mm` SET TAGS ('dbx_business_glossary_term' = 'Physical Dimensions (mm) (DIM_MM)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `display_type` SET TAGS ('dbx_business_glossary_term' = 'Display Type (DT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Date (EOL_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FW_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `form_factor` SET TAGS ('dbx_business_glossary_term' = 'Form Factor (FF)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `form_factor` SET TAGS ('dbx_value_regex' = 'countertop|portable|mpos|unattended|softpos');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `hardware_specifications` SET TAGS ('dbx_business_glossary_term' = 'Hardware Specifications (HW_SPECS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Terminal Manufacturer (TMF)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `memory_capacity_mb` SET TAGS ('dbx_business_glossary_term' = 'Memory Capacity (MB) (MEM_MB)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Terminal Model Name (TMN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `operating_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Range (°C) (TEMP_C)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `pci_pts_version` SET TAGS ('dbx_business_glossary_term' = 'PCI PTS Version (PCI_PTS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `pci_pts_version` SET TAGS ('dbx_value_regex' = '3.0|3.1|4.0');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `pin_pad_type` SET TAGS ('dbx_business_glossary_term' = 'PIN Pad Type (PPT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `power_requirements_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Requirements (Watts) (POWER_W)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `processor_type` SET TAGS ('dbx_business_glossary_term' = 'Processor Type (CPU_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (REL_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features (SEC_FEAT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version (SW_VER)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `storage_capacity_mb` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (MB) (STOR_MB)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies (ISO 4217) (CURR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `supported_interfaces` SET TAGS ('dbx_business_glossary_term' = 'Supported Interfaces (SI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `supported_schemes` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Schemes (SCHEME)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `supported_schemes` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `terminal_model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description (DESC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `terminal_model_status` SET TAGS ('dbx_business_glossary_term' = 'Terminal Model Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `terminal_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_model` ALTER COLUMN `weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Weight (grams) (WT_G)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Capability ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_code` SET TAGS ('dbx_business_glossary_term' = 'Capability Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_description` SET TAGS ('dbx_business_glossary_term' = 'Capability Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_name` SET TAGS ('dbx_business_glossary_term' = 'Capability Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_business_glossary_term' = 'Capability Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_type` SET TAGS ('dbx_business_glossary_term' = 'Capability Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `capability_type` SET TAGS ('dbx_value_regex' = 'pos|atm|mpos|kiosk|online|mobile');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `dcc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `emv_enabled` SET TAGS ('dbx_business_glossary_term' = 'EMV Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `hce_supported` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Supported Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `idle_screen_timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Idle Screen Timeout (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `multi_application_support` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Application Support Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `qr_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'QR Payment Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `receipt_printing_mode` SET TAGS ('dbx_business_glossary_term' = 'Receipt Printing Mode');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `receipt_printing_mode` SET TAGS ('dbx_value_regex' = 'paper|digital|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `supported_card_schemes` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Schemes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `supported_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Methods');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `tip_prompt_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tip Prompt Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `transaction_limit_per_day` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `transaction_limit_per_month` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`capability` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `terminal_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Alert ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Acknowledger Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_business_glossary_term' = 'Alert Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_value_regex' = 'operational|security|hardware|software');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_description` SET TAGS ('dbx_business_glossary_term' = 'Alert Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_source` SET TAGS ('dbx_business_glossary_term' = 'Alert Source');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_source` SET TAGS ('dbx_value_regex' = 'monitoring_system|terminal_self_report');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'connectivity_loss|battery_low|paper_out|key_expiry|cert_expiry|decline_spike');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percent');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `decline_spike_percent` SET TAGS ('dbx_business_glossary_term' = 'Decline Spike Percent');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `key_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Key Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `last_maintenance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'online|offline|intermittent');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `paper_status` SET TAGS ('dbx_business_glossary_term' = 'Paper Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `paper_status` SET TAGS ('dbx_value_regex' = 'ok|out');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `payload` SET TAGS ('dbx_business_glossary_term' = 'Alert Payload');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'info|warning|critical');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `terminal_alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `terminal_alert_status` SET TAGS ('dbx_value_regex' = 'open|acknowledged|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `transaction_volume_last_hour` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Last Hour');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `connectivity_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Connectivity ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `apn_name` SET TAGS ('dbx_business_glossary_term' = 'APN Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `average_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Backup Channel Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_channel_type` SET TAGS ('dbx_value_regex' = 'ethernet|wifi|cellular|dialup');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_gateway_ip` SET TAGS ('dbx_business_glossary_term' = 'Backup Gateway IP');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_gateway_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_gateway_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Backup IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_ip_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Backup IP Assignment Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_ip_assignment_type` SET TAGS ('dbx_value_regex' = 'static|dhcp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `backup_subnet_mask` SET TAGS ('dbx_business_glossary_term' = 'Backup Subnet Mask');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `cellular_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Cellular Signal Strength (dBm)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `configuration_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `connectivity_category` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `connectivity_category` SET TAGS ('dbx_value_regex' = 'single|dual|redundant');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `last_config_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `last_heartbeat_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Heartbeat Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `network_provider` SET TAGS ('dbx_business_glossary_term' = 'Network Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `online_status` SET TAGS ('dbx_business_glossary_term' = 'Online Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `online_status` SET TAGS ('dbx_value_regex' = 'online|offline|degraded');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_channel_type` SET TAGS ('dbx_value_regex' = 'ethernet|wifi|cellular|dialup');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_gateway_ip` SET TAGS ('dbx_business_glossary_term' = 'Primary Gateway IP');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_gateway_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_gateway_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Primary IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_ip_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Primary IP Assignment Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_ip_assignment_type` SET TAGS ('dbx_value_regex' = 'static|dhcp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `primary_subnet_mask` SET TAGS ('dbx_business_glossary_term' = 'Primary Subnet Mask');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Profile Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Profile Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'met|breached|warning');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `uptime_pct` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Uptime Percentage');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `vpn_tunnel_code` SET TAGS ('dbx_business_glossary_term' = 'VPN Tunnel ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `wifi_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Wi‑Fi Signal Strength (dBm)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ALTER COLUMN `wifi_ssid` SET TAGS ('dbx_business_glossary_term' = 'Wi‑Fi SSID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `terminal_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Fee Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `terminal_group_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Terminal Group ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `billing_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Billing Day of Month');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `chargeback_handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Handling Fee');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `discount_end_date` SET TAGS ('dbx_business_glossary_term' = 'Discount End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `discount_start_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `fee_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Period');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `fee_cap_period` SET TAGS ('dbx_value_regex' = 'monthly|annual|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `fee_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'rental|transaction|pci|chargeback|surcharge|discount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `monthly_rental_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Rental Fee');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `pci_compliance_fee` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Fee');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|in_review|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `surcharge_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Fixed Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `surcharge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Percentage');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `terminal_fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `terminal_fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `terminal_fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `transaction_fee_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `transaction_fee_type` SET TAGS ('dbx_value_regex' = 'per_transaction|percentage');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `acceptance_type_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Acceptance Type ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `acceptance_type_code` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Type Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `acceptance_type_description` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Type Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `acceptance_type_name` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Type Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `acceptance_type_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Type Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `acceptance_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `associated_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Associated Fee Rate');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `attended_indicator` SET TAGS ('dbx_business_glossary_term' = 'Attended Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `attended_indicator` SET TAGS ('dbx_value_regex' = 'attended|unattended');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `card_presence` SET TAGS ('dbx_business_glossary_term' = 'Card Presence Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `card_presence` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `default_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Acceptance Type Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Entry Mode');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `entry_mode` SET TAGS ('dbx_value_regex' = 'chip|contactless|swipe|manual|fallback');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `firmware_version_required` SET TAGS ('dbx_business_glossary_term' = 'Required Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `hce_supported` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Supported');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `interchange_qualification` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `interchange_qualification` SET TAGS ('dbx_value_regex' = 'qualified|non_qualified|restricted');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `regulatory_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `requires_pin` SET TAGS ('dbx_business_glossary_term' = 'Requires PIN');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `security_cert_level` SET TAGS ('dbx_business_glossary_term' = 'Security Certification Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `security_cert_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|level4');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `software_version_required` SET TAGS ('dbx_business_glossary_term' = 'Required Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `supports_contactless` SET TAGS ('dbx_business_glossary_term' = 'Supports Contactless');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `supports_emv` SET TAGS ('dbx_business_glossary_term' = 'Supports EMV');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `supports_nfc` SET TAGS ('dbx_business_glossary_term' = 'Supports NFC');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `transaction_environment` SET TAGS ('dbx_business_glossary_term' = 'Transaction Environment');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `transaction_environment` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile|mpos');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`acceptance_type` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `p2pe_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal P2PE Scope ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `compliance_reduction_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reduction Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `decryption_environment` SET TAGS ('dbx_business_glossary_term' = 'Decryption Environment');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `decryption_environment` SET TAGS ('dbx_value_regex' = 'hsm|secure_module|cloud');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `encryption_domain` SET TAGS ('dbx_business_glossary_term' = 'Encryption Domain');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `encryption_domain` SET TAGS ('dbx_value_regex' = 'hardware|software|cloud');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `hsm_location` SET TAGS ('dbx_business_glossary_term' = 'HSM Location');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `key_management_approach` SET TAGS ('dbx_business_glossary_term' = 'Key Management Approach');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `key_management_approach` SET TAGS ('dbx_value_regex' = 'symmetric|asymmetric|hybrid');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `p2pe_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'P2PE Certificate ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `p2pe_solution_name` SET TAGS ('dbx_business_glossary_term' = 'P2PE Solution Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `p2pe_solution_provider` SET TAGS ('dbx_business_glossary_term' = 'P2PE Solution Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `p2pe_solution_version` SET TAGS ('dbx_business_glossary_term' = 'P2PE Solution Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `scope_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `scope_last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_value_regex' = 'validated|pending|revoked|expired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `scope_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Validation Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `validation_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Validation Audit Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ALTER COLUMN `validation_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_config_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Surcharge Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `applicable_card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Applicable Card Scheme (Visa, Mastercard, etc.)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `applicable_card_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `applicable_product_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Card Product Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `applicable_product_type` SET TAGS ('dbx_value_regex' = 'consumer|commercial|corporate|government|private|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Configuration Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `jurisdiction_state_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State Code (US State abbreviation)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `jurisdiction_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount for Surcharge Applicability');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `merchant_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Merchant Disclosure Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `regulatory_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Required Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Fixed Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_application_rule` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Application Rule (Per Transaction, Per Batch, Per Day)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_application_rule` SET TAGS ('dbx_value_regex' = 'per_transaction|per_batch|per_day');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Cap Amount (Maximum total surcharge per transaction)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_cap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Cap Percentage (Maximum surcharge as percentage of transaction amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_mode` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Mode (Percentage or Fixed Amount)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_mode` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate (Percentage expressed as decimal)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type (e.g., Credit Card, Debit Card, Digital Wallet, etc.)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|prepaid|digital_wallet|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `receipt_template_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Receipt Template Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Template Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `digital_delivery_options` SET TAGS ('dbx_business_glossary_term' = 'Digital Receipt Delivery Options');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `digital_delivery_options` SET TAGS ('dbx_value_regex' = 'email|sms|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Template Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Template Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `email_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Email Template Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `email_template_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `email_template_reference` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `footer_text` SET TAGS ('dbx_business_glossary_term' = 'Footer Text');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Header Text');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_aid` SET TAGS ('dbx_business_glossary_term' = 'Show Application Identifier Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_approval_code` SET TAGS ('dbx_business_glossary_term' = 'Show Approval Code Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_card_scheme_logo` SET TAGS ('dbx_business_glossary_term' = 'Show Card Scheme Logo Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Show Currency Code Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_footer` SET TAGS ('dbx_business_glossary_term' = 'Include Footer Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_header` SET TAGS ('dbx_business_glossary_term' = 'Include Header Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_masked_pan` SET TAGS ('dbx_business_glossary_term' = 'Show Masked PAN Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_merchant_address` SET TAGS ('dbx_business_glossary_term' = 'Show Merchant Address Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_merchant_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_merchant_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Show Merchant Name Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_tip` SET TAGS ('dbx_business_glossary_term' = 'Show Tip Amount Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_total` SET TAGS ('dbx_business_glossary_term' = 'Show Total Amount Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Show Transaction Amount Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `include_tvr` SET TAGS ('dbx_business_glossary_term' = 'Show Terminal Verification Results Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Receipt Language Locale');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `line_item_separator` SET TAGS ('dbx_business_glossary_term' = 'Line Item Separator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `line_item_separator` SET TAGS ('dbx_value_regex' = 'dash|asterisk|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `max_line_items` SET TAGS ('dbx_business_glossary_term' = 'Maximum Line Items');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `paper_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Paper Length (mm)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `paper_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Paper Width (mm)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `qr_code_data_type` SET TAGS ('dbx_business_glossary_term' = 'QR Code Data Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `qr_code_data_type` SET TAGS ('dbx_value_regex' = 'url|text|payment');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `qr_code_enabled` SET TAGS ('dbx_business_glossary_term' = 'QR Code Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `receipt_format` SET TAGS ('dbx_business_glossary_term' = 'Receipt Output Format');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `receipt_format` SET TAGS ('dbx_value_regex' = 'paper|digital|both');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `receipt_template_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Template Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `receipt_template_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `sms_template_reference` SET TAGS ('dbx_business_glossary_term' = 'SMS Template Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Receipt Template Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Receipt Template Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Template Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'standard|custom|partner');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Template Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`receipt_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Template Version Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Downtime ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reporter Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `actual_affected_transactions` SET TAGS ('dbx_business_glossary_term' = 'Actual Affected Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'hardware_fault|software_failure|connectivity_loss|planned_maintenance|key_expiry');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `downtime_source` SET TAGS ('dbx_business_glossary_term' = 'Downtime Source');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `downtime_source` SET TAGS ('dbx_value_regex' = 'system|manual|partner');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `downtime_status` SET TAGS ('dbx_business_glossary_term' = 'Downtime Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `downtime_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `estimated_affected_transactions` SET TAGS ('dbx_business_glossary_term' = 'Estimated Affected Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `external_incident_reference` SET TAGS ('dbx_business_glossary_term' = 'External Incident ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `is_critical_terminal` SET TAGS ('dbx_business_glossary_term' = 'Critical Terminal Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Network Connectivity Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_value_regex' = 'wired|wifi|cellular|satellite');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `reported_via` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reported Via');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `reported_via` SET TAGS ('dbx_value_regex' = 'api|portal|phone|email');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Downtime Resolution Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'hardware|software|network|configuration|environment|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Minutes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_value_regex' = 'met|breached');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `balance_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Balance Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `device_provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Device Provisioning Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `device_provisioning_status` SET TAGS ('dbx_value_regex' = 'provisioned|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `is_3ds_enrolled` SET TAGS ('dbx_business_glossary_term' = '3‑DS Enrolled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `is_contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `is_hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation (HCE) Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `is_nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `is_sca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Compliant Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_business_glossary_term' = 'Issuer Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `last_tokenization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tokenization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `pci_dss_compliant` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliant Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_value_regex' = 'app|web|partner|api');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `psd2_compliant` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Compliant Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `stored_value_balance` SET TAGS ('dbx_business_glossary_term' = 'Stored‑Value Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `stored_value_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `stored_value_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_description` SET TAGS ('dbx_business_glossary_term' = 'Wallet Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_name` SET TAGS ('dbx_business_glossary_term' = 'Wallet Name (Human Readable)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_number` SET TAGS ('dbx_business_glossary_term' = 'Wallet Number (Unique Identifier)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_scheme` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|discover|amex|unionpay');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_status` SET TAGS ('dbx_business_glossary_term' = 'Wallet Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_tier` SET TAGS ('dbx_business_glossary_term' = 'Wallet Tier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_type` SET TAGS ('dbx_business_glossary_term' = 'Wallet Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_type` SET TAGS ('dbx_value_regex' = 'apple_pay|google_pay|proprietary');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ALTER COLUMN `wallet_version` SET TAGS ('dbx_business_glossary_term' = 'Wallet Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `wallet_token_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Token ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `fpan_bin` SET TAGS ('dbx_business_glossary_term' = 'FPAN Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `fpan_bin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `fpan_bin` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `fpan_last4` SET TAGS ('dbx_business_glossary_term' = 'FPAN Last 4 Digits');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `fpan_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `fpan_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `is_restricted_token` SET TAGS ('dbx_business_glossary_term' = 'Restricted Token Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `is_test_token` SET TAGS ('dbx_business_glossary_term' = 'Test Token Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `last_used_location_country` SET TAGS ('dbx_business_glossary_term' = 'Last Used Location Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `provisioning_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Payment Token (DPAN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Token Issue Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Token Last Used Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Scheme');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider (TSP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_status` SET TAGS ('dbx_business_glossary_term' = 'Token Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_status` SET TAGS ('dbx_value_regex' = 'active|suspended|deleted');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'device|cloud|ecommerce');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Token Usage Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `token_version` SET TAGS ('dbx_business_glossary_term' = 'Token Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `token_requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor Identifier (TRID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider Identifier (TSP ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider Identifier (TSP ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Addr Line1)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Addr Line2)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `allowed_token_types` SET TAGS ('dbx_business_glossary_term' = 'Allowed Token Types (Allowed Types)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `api_endpoint` SET TAGS ('dbx_business_glossary_term' = 'API Endpoint URL (API Endpoint)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `certificate_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Certificate Fingerprint (Cert FP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `certificate_fingerprint` SET TAGS ('dbx_value_regex' = '[A-Fa-f0-9]{64}');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `certificate_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `certificate_fingerprint` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (City)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (Contact Email)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (Contact Phone)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `contractual_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Contractual Agreement Reference (Contract Ref)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3) (Country Code)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `daily_token_request_count` SET TAGS ('dbx_business_glossary_term' = 'Daily Token Request Count (Daily Count)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days) (Retention Days)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `is_test_requestor` SET TAGS ('dbx_business_glossary_term' = 'Test Requestor Flag (Is Test)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp (Status Change TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `max_token_requests_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Token Requests Per Day (Max Daily Requests)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date (Onboard Date)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (Postal Code)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `privacy_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Given Flag (Privacy Consent)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor Type (TR Type)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'wallet_provider|merchant|issuer|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Risk Score)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `scheme_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Scheme Affiliation (Scheme Affil.)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `scheme_affiliation` SET TAGS ('dbx_value_regex' = 'visa_vts|mastercard_mdes|other');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (State)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `token_requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor Name (TR Name)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `token_requestor_status` SET TAGS ('dbx_business_glossary_term' = 'Current Status (Status)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `token_requestor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Device ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `binding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `decommission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Device Decommission Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_fingerprint_hash` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Hash');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_fingerprint_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_fingerprint_hash` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DPAN-linked)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Device Owner Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_owner_type` SET TAGS ('dbx_value_regex' = 'individual|business');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|wearable|tablet|iot');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Device Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Device Geolocation City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `geolocation_country` SET TAGS ('dbx_business_glossary_term' = 'Device Geolocation Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `geolocation_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `geolocation_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Enabled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `is_test_device` SET TAGS ('dbx_business_glossary_term' = 'Test Device Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `mac_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Device Model Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `nfc_capable` SET TAGS ('dbx_business_glossary_term' = 'NFC Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `os_name` SET TAGS ('dbx_business_glossary_term' = 'Operating System Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Device Provisioning Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Device Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `secure_element_type` SET TAGS ('dbx_business_glossary_term' = 'Secure Element Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `secure_element_type` SET TAGS ('dbx_value_regex' = 'embedded|hce|sim');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Device Status Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `wallet_device_status` SET TAGS ('dbx_business_glossary_term' = 'Device Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_device` ALTER COLUMN `wallet_device_status` SET TAGS ('dbx_value_regex' = 'active|suspended|lost|stolen|decommissioned');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `provisioning_request_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Request ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `token_requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issuer Decision Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `external_request_reference` SET TAGS ('dbx_business_glossary_term' = 'External Request Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Primary Account Number (PAN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Requester IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `is_test_request` SET TAGS ('dbx_business_glossary_term' = 'Test Request Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `issuer_decision` SET TAGS ('dbx_business_glossary_term' = 'Issuer Decision');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `issuer_decision` SET TAGS ('dbx_value_regex' = 'approved|declined|step_up_required');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Requester Country (ISO 3166‑3)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_value_regex' = 'OTA|in_app|manual');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `provisioning_method` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `provisioning_method` SET TAGS ('dbx_value_regex' = 'green_path|yellow_path|red_path');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `provisioning_request_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Request Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `provisioning_request_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Request Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `sca_outcome` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Outcome');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `sca_outcome` SET TAGS ('dbx_value_regex' = 'success|failure|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `step_up_method` SET TAGS ('dbx_business_glossary_term' = 'Step‑Up Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `step_up_method` SET TAGS ('dbx_value_regex' = 'OTP|biometric|call_center');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`provisioning_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `authorization_response_code_id` SET TAGS ('dbx_business_glossary_term' = 'Auth Response Code Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `network_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Network Routing Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `original_transaction_wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Token ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|offline|mobile|pos');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `cryptogram` SET TAGS ('dbx_business_glossary_term' = 'Masked Cryptogram');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `cryptogram` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `cryptogram` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|resolved');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `is_successful` SET TAGS ('dbx_business_glossary_term' = 'Success Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `wallet_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ALTER COLUMN `wallet_transaction_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|captured|declined|reversed|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `hce_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Credential ID (HCE Credential ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet ID (Wallet ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token ID (Token ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID (Audit Trail ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `compliance_pci_dss_version` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Version (PCI DSS Version)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `compliance_psd2_version` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Version (PSD2 Version)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled Flag (Contactless Enabled Flag)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp (Creation Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type (CT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'limited_use_key|session_key|persistent_key');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `credential_version` SET TAGS ('dbx_business_glossary_term' = 'Credential Version (CV)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `cross_border_supported` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Supported Flag (Cross-Border Supported Flag)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Reference (DBR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `dynamic_currency_conversion_supported` SET TAGS ('dbx_business_glossary_term' = 'DCC Supported Flag (DCC Supported Flag)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code (Fraud Reason Code)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `hce_credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status (CS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `hce_credential_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'HCE Enabled Flag (HCE Enabled Flag)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flagged Indicator (Fraud Flagged Indicator)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `is_test_credential` SET TAGS ('dbx_business_glossary_term' = 'Test Credential Flag (Test Credential Flag)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `issuer_script_reference` SET TAGS ('dbx_business_glossary_term' = 'Issuer Script Reference (ISR)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Key Algorithm (KA)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_algorithm` SET TAGS ('dbx_value_regex' = 'RSA|ECC|AES');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Key Expiry Date (Key Expiry Date)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Key Expiry Timestamp (Key Expiry Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_index` SET TAGS ('dbx_business_glossary_term' = 'Key Index (KI)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_length` SET TAGS ('dbx_business_glossary_term' = 'Key Length (KL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_rotation_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Key Rotation Interval Days (Key Rotation Interval Days)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_rotation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Key Rotation Timestamp (Key Rotation Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_usage_counter` SET TAGS ('dbx_business_glossary_term' = 'Key Usage Counter (KUC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `key_usage_limit` SET TAGS ('dbx_business_glossary_term' = 'Key Usage Limit (KUL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `last_replenishment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Timestamp (Last Replenishment Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (Last Used Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag (NFC Enabled Flag)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Notes)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Channel (PC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `provisioning_channel` SET TAGS ('dbx_value_regex' = 'app|web|api|partner|batch');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (Region Code)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `replenishment_count` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Count (RC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `replenishment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Threshold (RT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Risk Score)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported Flag (Tokenization Supported Flag)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (Updated Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`hce_credential` ALTER COLUMN `usage_reset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Reset Timestamp (Usage Reset Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `upi_registration_id` SET TAGS ('dbx_business_glossary_term' = 'UPI Registration ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Service Provider ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Service Provider ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Check Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `default_flag` SET TAGS ('dbx_business_glossary_term' = 'Default VPA Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `deregistration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deregistration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_business_glossary_term' = 'Device Binding ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `failed_auth_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Authentication Attempts Count');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `last_successful_auth_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Authentication Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `linked_bank_account_masked` SET TAGS ('dbx_business_glossary_term' = 'Linked Bank Account (Masked) (IBAN/Account Number)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `linked_bank_account_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `linked_bank_account_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `max_failed_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowed Failed Authentication Attempts');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `privacy_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Given Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'External Registration Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_value_regex' = 'self_service|customer_support');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'UPI Registration Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|pending|rejected|deregistered');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'UPI Registration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type (Primary or Secondary)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'primary|secondary');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel of Registration');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|api|pos');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Description');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_value_regex' = 'tokenized|not_tokenized');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `upi_handle` SET TAGS ('dbx_business_glossary_term' = 'UPI Handle (PSP Suffix)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `upi_handle` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `upi_handle` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `upi_pin_set` SET TAGS ('dbx_business_glossary_term' = 'UPI PIN Set Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'UPI Verification Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `vpa` SET TAGS ('dbx_business_glossary_term' = 'Virtual Payment Address (VPA)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `vpa` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `vpa` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `vpa_type` SET TAGS ('dbx_business_glossary_term' = 'VPA Type (Personal or Business)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ALTER COLUMN `vpa_type` SET TAGS ('dbx_value_regex' = 'personal|business');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `wallet_funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Funding Source Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Added By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `linked_account_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Identifier (LAST_TXN_ID)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance (AVAIL_BAL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit (DAILY_LIMIT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp (EFF_FROM)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp (EFF_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Expiry Date (EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code (FRAUD_REASON)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `funding_source_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Status Reason (STATUS_REASON)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'debit_card|credit_card|ach|bnpl|prepaid|gift_card');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `is_3ds_enrolled` SET TAGS ('dbx_business_glossary_term' = '3‑DS Enrollment Flag (3DS_ENROLLED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `is_contactless_supported` SET TAGS ('dbx_business_glossary_term' = 'Contactless Support Flag (CONTACTLESS_SUPPORT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Funding Source Flag (DEFAULT_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag (FRAUD_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `is_hce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Enabled Flag (HCE_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `is_nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'NFC Enabled Flag (NFC_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `is_sca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication Compliance Flag (SCA_COMPLIANT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_business_glossary_term' = 'Issuer Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (LAST_USED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Limit Amount (LIMIT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `link_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Link Timestamp (LINK_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `masked_reference` SET TAGS ('dbx_business_glossary_term' = 'Masked Instrument Reference (MASKED_REF)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `masked_reference` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{4}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `masked_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `masked_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit (MONTHLY_LIMIT)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Nickname (NICKNAME)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider (TSP)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status (TOKEN_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_value_regex' = 'tokenized|not_tokenized');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method (VERIF_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'micro_deposit|instant|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VERIF_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp (VERIF_TS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `wallet_funding_source_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ALTER COLUMN `wallet_funding_source_status` SET TAGS ('dbx_value_regex' = 'active|expired|removed|suspended');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `wallet_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Balance ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `available_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `available_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_category` SET TAGS ('dbx_business_glossary_term' = 'Balance Category');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_category` SET TAGS ('dbx_value_regex' = 'consumer|merchant|partner');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_ceiling_limit` SET TAGS ('dbx_business_glossary_term' = 'Balance Ceiling Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_ceiling_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_ceiling_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'prepaid|e_money|gift|loyalty');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `e_money_classification` SET TAGS ('dbx_business_glossary_term' = 'E‑Money Classification');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `e_money_classification` SET TAGS ('dbx_value_regex' = 'regulated|unregulated|exempt');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `external_balance_reference` SET TAGS ('dbx_business_glossary_term' = 'External Balance Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `is_frozen` SET TAGS ('dbx_business_glossary_term' = 'Balance Frozen Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `is_overdraft_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `last_credit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `last_debit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Debit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `reserved_balance` SET TAGS ('dbx_business_glossary_term' = 'Reserved Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `reserved_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `reserved_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `total_balance` SET TAGS ('dbx_business_glossary_term' = 'Total Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `total_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `total_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `balance_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Balance Movement ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `wallet_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Balance ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Movement Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `balance_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `balance_movement_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `initiating_channel` SET TAGS ('dbx_business_glossary_term' = 'Initiating Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `initiating_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|pos|api');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `is_test_movement` SET TAGS ('dbx_business_glossary_term' = 'Test Movement Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'credit|debit|reversal|expiry');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `post_movement_balance` SET TAGS ('dbx_business_glossary_term' = 'Post‑Movement Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `pre_movement_balance` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Movement Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `nfc_tap_event_id` SET TAGS ('dbx_business_glossary_term' = 'NFC Tap Event Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Token Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `token_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `token_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `application_transaction_counter` SET TAGS ('dbx_business_glossary_term' = 'Application Transaction Counter (ATC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `cryptogram_type` SET TAGS ('dbx_business_glossary_term' = 'Cryptogram Type (ARQC/TC/AAC)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `cryptogram_type` SET TAGS ('dbx_value_regex' = 'ARQC|TC|AAC');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `cryptogram_value` SET TAGS ('dbx_business_glossary_term' = 'Masked Cryptogram Value');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `cryptogram_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `cryptogram_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address of Terminal');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `kernel_version` SET TAGS ('dbx_business_glossary_term' = 'Contactless Kernel Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'City of Tap Location');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code of Tap Location');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `tap_result` SET TAGS ('dbx_business_glossary_term' = 'Tap Result Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `tap_result` SET TAGS ('dbx_value_regex' = 'authorized|declined|fallback|error');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `tap_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tap Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|preauth|void');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `wallet_sca_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet SCA Challenge ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = 'Challenge Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_value_regex' = 'sent|completed|failed|expired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `challenge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Challenge Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_business_glossary_term' = 'Challenge Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_value_regex' = 'otp_sms|otp_email|biometric|push_notification|call_center');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|api|pos|atm');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Challenge Completion Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Challenge Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `is_test_challenge` SET TAGS ('dbx_business_glossary_term' = 'Test Challenge Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `request_reference` SET TAGS ('dbx_business_glossary_term' = 'Request Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `sca_exemption_applied` SET TAGS ('dbx_business_glossary_term' = 'SCA Exemption Applied');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `sca_exemption_applied` SET TAGS ('dbx_value_regex' = 'none|low_value|trusted_contact|transaction_risk|secure_corporate|delegated_authentication');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_sca_challenge` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `wallet_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Enrollment Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `consent_data_sharing` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|ivr|branch');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `enrollment_source_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Source Campaign Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|closed|rejected');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `enrollment_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `kyc_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ALTER COLUMN `terms_and_conditions_version` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `p2p_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer Transfer ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|api|pos');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `external_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'External Transfer Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Initiation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `recipient_identifier` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `recipient_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `recipient_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `recipient_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identifier Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `recipient_identifier_type` SET TAGS ('dbx_value_regex' = 'phone|email|upi_vpa|wallet_id');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|yearly|custom');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'initiated|pending|completed|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'instant|scheduled|recurring');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `wallet_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Limit ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mode (Hard, Soft, Monitoring)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_value_regex' = 'hard|soft|monitoring');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Limit Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_name` SET TAGS ('dbx_business_glossary_term' = 'Limit Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope (Applicable Channels)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_value_regex' = 'all_channels|nfc_only|online_only|pos_only|mobile_only');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type (e.g., Daily Spend, Per Transaction, Contactless, P2P, Top‑Up)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'daily_spend|per_transaction|contactless|p2p|top_up');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `limit_version` SET TAGS ('dbx_business_glossary_term' = 'Limit Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis (e.g., PSD2 Contactless Limit, Scheme Rule, Internal Policy)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'psd2_contactless|scheme_rule|internal_policy');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `wallet_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ALTER COLUMN `wallet_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `token_pan_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Token PAN Mapping ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `token_requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `bin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `bin` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `dpan_masked` SET TAGS ('dbx_business_glossary_term' = 'Device Primary Account Number (DPAN) Masked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `dpan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `dpan_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `fpan_reference` SET TAGS ('dbx_business_glossary_term' = 'Financial Primary Account Number (FPAN) Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `fpan_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `fpan_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `is_restricted_mapping` SET TAGS ('dbx_business_glossary_term' = 'Restricted Mapping Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `is_test_mapping` SET TAGS ('dbx_business_glossary_term' = 'Test Mapping Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `last_detokenization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Detokenization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `mapping_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mapping Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_value_regex' = 'active|suspended|deleted');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `tokenization_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Algorithm');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `tokenization_compliance` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Compliance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `tokenization_compliance` SET TAGS ('dbx_value_regex' = 'pci_dss|psd2|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `tokenization_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Key Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `tokenization_key_version` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Key Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'algorithmic|hardware|software');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ALTER COLUMN `update_reason` SET TAGS ('dbx_business_glossary_term' = 'Update Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `detokenization_request_id` SET TAGS ('dbx_business_glossary_term' = 'Detokenization Request ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `token_requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Request Origin Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `authorization_outcome` SET TAGS ('dbx_business_glossary_term' = 'Authorization Outcome (Approved, Denied, Error)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `authorization_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|error');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `compliance_check_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `detokenization_request_status` SET TAGS ('dbx_business_glossary_term' = 'Detokenization Request Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `detokenization_request_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `dpan_masked` SET TAGS ('dbx_business_glossary_term' = 'Device Primary Account Number (DPAN) Masked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `dpan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `dpan_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_business_glossary_term' = 'Financial Primary Account Number (FPAN) Masked');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `fpan_returned_flag` SET TAGS ('dbx_business_glossary_term' = 'FPAN Returned Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Request Origin IP Address');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Request Origin Country (ISO 3166-1 Alpha-3 Code)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Comments');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `request_reason` SET TAGS ('dbx_business_glossary_term' = 'Detokenization Request Reason (Authorization, Fraud Investigation, Dispute)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `request_reason` SET TAGS ('dbx_value_regex' = 'authorization|fraud_investigation|dispute');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `request_reference` SET TAGS ('dbx_business_glossary_term' = 'Detokenization Request Reference Number');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detokenization Request Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Type (Issuer, Fraud Platform, Dispute System)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'issuer|fraud_platform|dispute_system');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detokenization Response Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Numeric Risk Assessment)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`detokenization_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `wallet_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Notification ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Device ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `correlation_reference` SET TAGS ('dbx_business_glossary_term' = 'Correlation ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'push|sms|email|in_app');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|read');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `is_test_notification` SET TAGS ('dbx_business_glossary_term' = 'Test Notification Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `message_content` SET TAGS ('dbx_business_glossary_term' = 'Message Content');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `message_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Message Template ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'transaction_alert|provisioning_confirmation|security_alert|balance_low|limit_breach');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Notification Priority');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `wallet_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Consent ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `biometric_consent` SET TAGS ('dbx_business_glossary_term' = 'Biometric Consent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `biometric_consent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `biometric_consent` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `consent_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|api|in_person|call_center');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'data_processing|marketing|third_party_sharing|open_banking|biometric');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `data_processing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Grant Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `marketing_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `open_banking_consent` SET TAGS ('dbx_business_glossary_term' = 'Open Banking Consent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `third_party_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Sharing Consent Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `is_test_account` SET TAGS ('dbx_business_glossary_term' = 'Test Account Flag');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `loyalty_account_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `loyalty_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_balance_last_update` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Last Update');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_earned_last_12_months` SET TAGS ('dbx_business_glossary_term' = 'Points Earned (Last 12 Months)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_earned_last_30_days` SET TAGS ('dbx_business_glossary_term' = 'Points Earned (Last 30 Days)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_earned_total` SET TAGS ('dbx_business_glossary_term' = 'Total Points Earned');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Policy');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_value_regex' = 'rolling|fixed|none');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_pending` SET TAGS ('dbx_business_glossary_term' = 'Pending Points');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_redeemed_last_12_months` SET TAGS ('dbx_business_glossary_term' = 'Points Redeemed (Last 12 Months)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_redeemed_last_30_days` SET TAGS ('dbx_business_glossary_term' = 'Points Redeemed (Last 30 Days)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `points_redeemed_total` SET TAGS ('dbx_business_glossary_term' = 'Total Points Redeemed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `program_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Sponsor');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Type');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'points|miles|cashback|voucher');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `reward_redemption_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Reward Redemption Eligibility');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `reward_redemption_eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Redemption Eligibility Reason');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Risk Score');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Level');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'standard|silver|gold|platinum');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_points_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier Points Threshold');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_qualification_method` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Method');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_qualification_method` SET TAGS ('dbx_value_regex' = 'spend_based|points_based|manual');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'qualified|unqualified|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` SET TAGS ('dbx_subdomain' = 'digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Rule ID');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier for Settlement Processing');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile_app|api');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status of Transaction');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `fraud_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address of Transaction Origin');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `is_fraud_flagged` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'City of Transaction Location');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code of Transaction Location (ISO 3166-1 Alpha-3)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `monetary_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Monetary Equivalent of Points');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Comments');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `points_amount` SET TAGS ('dbx_business_glossary_term' = 'Points Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Points Balance After Transaction');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `points_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Before Transaction');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `program_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Rule Name');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score for Transaction');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Transaction');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'External Transaction Reference');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Status');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reversed|cancelled|failed');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Type (Earn, Redeem, Adjust, Expire, Transfer)');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earn|redeem|adjust|expire|transfer');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` ALTER COLUMN `terminal_group_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Group Identifier');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` ALTER COLUMN `parent_terminal_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
