-- Schema for Domain: interchange | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`interchange` COMMENT 'SSOT for network and interchange economics — IRF tables, MDR configurations, MSF schedules, scheme fee structures, BIN-level interchange qualification rules, and Durbin Amendment compliance tiers. Supports revenue recognition and cost-of-acceptance calculations for acquiring and issuing portfolios.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`irf_table` (
    `irf_table_id` BIGINT COMMENT 'Unique identifier for the interchange reimbursement fee table record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Card scheme lookup drives scheme‑specific interchange rates and compliance checks.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: irf_table references its category; adds irf_rate_category_id FK to irf_rate_category',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Regulatory reporting requires mapping issuer ISO country codes to country reference for compliance audits.',
    `acquirer_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the acquiring bank. Used for domestic vs. cross-border interchange rate determination. Null indicates rate applies regardless of acquirer country.. Valid values are `^[A-Z]{3}$`',
    `authorization_method` STRING COMMENT 'Card authorization method required for this interchange rate (chip, contactless, magnetic stripe, manual entry, ecommerce, token). Null indicates no specific method requirement.. Valid values are `chip|contactless|magnetic_stripe|manual_entry|ecommerce|token`',
    `bin_range_high` STRING COMMENT 'Upper bound of the BIN/IIN range to which this interchange rate applies. Used for BIN-level interchange qualification rules. Null indicates no BIN restriction.. Valid values are `^[0-9]{6,8}$`',
    `bin_range_low` STRING COMMENT 'Lower bound of the BIN/IIN range to which this interchange rate applies. Used for BIN-level interchange qualification rules. Null indicates no BIN restriction.. Valid values are `^[0-9]{6,8}$`',
    `card_product_tier` STRING COMMENT 'Card product tier or brand level (e.g., Standard, Rewards, Premium, Signature, World, World Elite, Platinum, Infinite). Higher tiers typically carry higher interchange rates. [ENUM-REF-CANDIDATE: standard|rewards|premium|signature|world|world_elite|platinum|infinite — 8 candidates stripped; promote to reference product]',
    `card_type` STRING COMMENT 'Type of payment card to which this interchange rate applies (credit, debit, prepaid, commercial, purchasing). Critical qualifier for rate selection.. Valid values are `credit|debit|prepaid|commercial|purchasing`',
    `cost_of_acceptance_category` STRING COMMENT 'Internal classification category used for cost-of-acceptance reporting and analysis (e.g., low-cost, standard, premium, high-cost). Supports merchant pricing strategy and portfolio profitability analysis.',
    `durbin_cap_amount` DECIMAL(18,2) COMMENT 'Maximum interchange fee amount allowed under Regulation II Durbin Amendment for regulated debit transactions. Null if not subject to Durbin caps.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether this interchange rate is subject to Regulation II Durbin Amendment caps (True for regulated debit, False otherwise). Critical for US debit interchange compliance.',
    `effective_end_date` DATE COMMENT 'Date when this interchange rate schedule expires and is no longer applicable. Null indicates an open-ended schedule currently in effect.',
    `effective_start_date` DATE COMMENT 'Date when this interchange rate schedule becomes effective and applicable to transactions. Part of the temporal validity window for this rate.',
    `interchange_category_code` STRING COMMENT 'Scheme-specific code identifying the interchange rate category (e.g., CPS Retail, Merit III, Core Value, Standard). This is the authoritative classification used by the card scheme.',
    `interchange_category_name` STRING COMMENT 'Human-readable name of the interchange rate category (e.g., Card Present Signature Preferred Retail, Electronic Commerce Basic).',
    `interchange_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the interchange fee amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `interchange_fixed_fee_amount` DECIMAL(18,2) COMMENT 'Fixed per-transaction fee component of the interchange in the currency specified by interchange_currency_code (e.g., $0.10). Combined with percentage rate to calculate total IRF.',
    `interchange_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate component of the interchange fee applied to the transaction amount (e.g., 1.65% stored as 0.0165). Used in cost-of-acceptance calculations.',
    `internal_rate_code` STRING COMMENT 'Internal company-specific code or identifier for this interchange rate, used for mapping to internal pricing and cost-of-acceptance systems. May differ from scheme category code.',
    `maximum_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount for which this interchange rate applies, in the currency specified by interchange_currency_code. Null indicates no maximum.',
    `merchant_category_code` STRING COMMENT 'Four-digit ISO 18245 merchant category code to which this interchange rate applies. Null indicates rate applies across all MCCs. Used for industry-specific interchange qualification.. Valid values are `^[0-9]{4}$`',
    `minimum_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required for this interchange rate to apply, in the currency specified by interchange_currency_code. Null indicates no minimum.',
    `program_identifier` STRING COMMENT 'Scheme-specific program or initiative identifier associated with this interchange rate (e.g., Visa CPS, Mastercard Merit, Amex OptBlue). Used for program-level reporting and qualification.',
    `qualification_criteria` STRING COMMENT 'Detailed business rules and conditions that must be met for a transaction to qualify for this interchange rate (e.g., EMV chip, AVS match, settlement within 24 hours). Free-text field capturing scheme-specific requirements.',
    `rate_status` STRING COMMENT 'Current lifecycle status of this interchange rate schedule (active, pending, expired, superseded, withdrawn). Used for rate version management and historical analysis.. Valid values are `active|pending|expired|superseded|withdrawn`',
    `rate_version` STRING COMMENT 'Version identifier for this interchange rate schedule, assigned by the card scheme. Used to track rate changes over time and ensure correct rate application.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange rate record was first created in the system. Used for audit trail and data lineage.',
    `record_source_system` STRING COMMENT 'Name or identifier of the source system from which this interchange rate data originated (e.g., Visa Rate Feed, Mastercard Portal, Manual Entry). Used for data lineage and reconciliation.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange rate record was last modified. Used for audit trail and change tracking.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text notes documenting regulatory compliance considerations for this interchange rate (e.g., PSD2 caps, Durbin Amendment applicability, regional regulations). Used for compliance audit and legal review.',
    `scheme_bulletin_reference` STRING COMMENT 'Reference number or identifier of the card scheme bulletin or notice that announced this interchange rate change. Used for traceability and compliance documentation.',
    `scheme_publication_date` DATE COMMENT 'Date when the card scheme officially published this interchange rate schedule. Used for audit trail and regulatory reporting.',
    `settlement_timeframe_hours` STRING COMMENT 'Maximum number of hours between authorization and settlement for this interchange rate to apply (e.g., 24, 48, 72). Null indicates no settlement timeframe requirement.',
    `transaction_region` STRING COMMENT 'Geographic scope of the transaction (domestic, intra-regional, inter-regional, cross-border). Determines applicable interchange rate tier.. Valid values are `domestic|intra_regional|inter_regional|cross_border`',
    `transaction_type` STRING COMMENT 'Type of transaction to which this interchange rate applies (card present, card not present, ecommerce, mail/telephone order, recurring, contactless). Key qualifier for interchange eligibility.. Valid values are `card_present|card_not_present|ecommerce|moto|recurring|contactless`',
    CONSTRAINT pk_irf_table PRIMARY KEY(`irf_table_id`)
) COMMENT 'Master reference table for Interchange Reimbursement Fee (IRF) schedules published by card schemes (Visa, Mastercard, Amex, Discover). Stores interchange rate categories, rate percentages, per-transaction fees, effective dates, card type applicability, transaction type qualifiers, and scheme-specific program identifiers. This is the authoritative SSOT for all interchange rate definitions used in cost-of-acceptance calculations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` (
    `irf_rate_category_id` BIGINT COMMENT 'Unique identifier for the interchange rate category. Primary key.',
    `scheme_id` BIGINT COMMENT 'Reference to the card scheme (Visa, Mastercard, Amex, Discover) that defines this interchange rate category.',
    `authorization_timeframe_hours` STRING COMMENT 'The maximum number of hours between authorization and capture for transactions to qualify for this interchange rate category.',
    `avs_required` BOOLEAN COMMENT 'Indicates whether Address Verification System (AVS) validation is required to qualify for this interchange rate category.',
    `bin_range_end` STRING COMMENT 'The ending Bank Identification Number (BIN) or Issuer Identification Number (IIN) in the range of card products that qualify for this interchange rate category.. Valid values are `^[0-9]{6,8}$`',
    `bin_range_start` STRING COMMENT 'The starting Bank Identification Number (BIN) or Issuer Identification Number (IIN) in the range of card products that qualify for this interchange rate category.. Valid values are `^[0-9]{6,8}$`',
    `card_not_present_indicator` BOOLEAN COMMENT 'Indicates whether this interchange rate category applies to card-not-present (CNP) transactions such as e-commerce, mail order, or telephone order.',
    `card_present_indicator` BOOLEAN COMMENT 'Indicates whether this interchange rate category applies to card-present (CP) transactions where the physical card is presented at the Point of Sale (POS).',
    `category_code` STRING COMMENT 'The unique code assigned by the card scheme to identify this interchange rate category (e.g., CPS_RETAIL, MERIT_III, OPTBLUE_TIER1).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `category_name` STRING COMMENT 'The full business name of the interchange rate category as published by the card scheme (e.g., Visa CPS/Retail, Mastercard Merit III, Amex OptBlue Standard).',
    `category_type` STRING COMMENT 'The classification of the interchange rate category based on card product type and transaction characteristics. [ENUM-REF-CANDIDATE: standard|premium|commercial|debit|credit|prepaid|rewards|government|healthcare — 9 candidates stripped; promote to reference product]',
    `contactless_eligible` BOOLEAN COMMENT 'Indicates whether contactless NFC transactions are eligible for this interchange rate category.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this interchange rate category record was first created in the system.',
    `cross_border_transaction_indicator` BOOLEAN COMMENT 'Indicates whether this interchange rate category applies to cross-border transactions where the acquiring and issuing banks are in different countries.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction amount thresholds and interchange rates associated with this category.. Valid values are `^[A-Z]{3}$`',
    `cvv_required` BOOLEAN COMMENT 'Indicates whether Card Verification Value (CVV) validation is required to qualify for this interchange rate category.',
    `domestic_transaction_indicator` BOOLEAN COMMENT 'Indicates whether this interchange rate category applies to domestic transactions where the acquiring and issuing banks are in the same country.',
    `downgrade_category_code` STRING COMMENT 'The interchange rate category code to which a transaction will be downgraded if it fails to meet the qualification criteria for this category.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `downgrade_rules_description` STRING COMMENT 'A detailed textual description of the conditions under which a transaction will be downgraded from this interchange rate category to a lower-tier category.',
    `durbin_regulated_indicator` BOOLEAN COMMENT 'Indicates whether this interchange rate category is subject to Durbin Amendment (Regulation II) caps for debit card transactions issued by regulated financial institutions.',
    `effective_date` DATE COMMENT 'The date on which this interchange rate category becomes active and applicable to transactions.',
    `emv_chip_required` BOOLEAN COMMENT 'Indicates whether EMV chip authentication is required for transactions to qualify for this interchange rate category.',
    `expiration_date` DATE COMMENT 'The date on which this interchange rate category ceases to be active and is no longer applicable to new transactions.',
    `irf_rate_category_status` STRING COMMENT 'The current lifecycle status of this interchange rate category within the card schemes published rate structure.. Valid values are `active|inactive|pending|deprecated|superseded`',
    `mcc_range_end` STRING COMMENT 'The ending Merchant Category Code (MCC) in the range of merchant types that qualify for this interchange rate category.. Valid values are `^[0-9]{4}$`',
    `mcc_range_start` STRING COMMENT 'The starting Merchant Category Code (MCC) in the range of merchant types that qualify for this interchange rate category.. Valid values are `^[0-9]{4}$`',
    `notes` STRING COMMENT 'Free-form internal notes and comments about this interchange rate category for operational reference and business context.',
    `parent_category_code` STRING COMMENT 'The code of the parent or umbrella interchange rate category under which this category is nested in the schemes taxonomy.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `priority_rank` STRING COMMENT 'The priority ranking used to determine which interchange rate category applies when a transaction qualifies for multiple categories. Lower numbers indicate higher priority.',
    `qualification_criteria_description` STRING COMMENT 'A detailed textual description of all the business and technical criteria that a transaction must meet to qualify for this interchange rate category.',
    `region_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country or region code indicating the geographic scope where this interchange rate category applies.. Valid values are `^[A-Z]{3}$`',
    `scheme_publication_reference` STRING COMMENT 'The reference identifier or document name from the card schemes official publication where this interchange rate category is defined (e.g., Visa USA Interchange Reimbursement Fees April 2024).',
    `settlement_timeframe_days` STRING COMMENT 'The number of days within which transactions in this interchange rate category must be settled to qualify for the published interchange rate.',
    `three_d_secure_required` BOOLEAN COMMENT 'Indicates whether 3-D Secure authentication is required for card-not-present transactions to qualify for this interchange rate category.',
    `transaction_amount_max` DECIMAL(18,2) COMMENT 'The maximum transaction amount allowed to qualify for this interchange rate category, in the base currency of the scheme.',
    `transaction_amount_min` DECIMAL(18,2) COMMENT 'The minimum transaction amount required to qualify for this interchange rate category, in the base currency of the scheme.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this interchange rate category record was last modified in the system.',
    CONSTRAINT pk_irf_rate_category PRIMARY KEY(`irf_rate_category_id`)
) COMMENT 'Defines the interchange rate category taxonomy used by each card scheme — e.g., Visa CPS/Retail, Mastercard Merit III, Amex OptBlue tiers. Captures category code, category name, qualifying criteria (card-present/card-not-present, EMV, AVS, MCC range), downgrade rules, and the parent scheme. Enables BIN-level and MCC-level interchange qualification logic.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` (
    `mdr_config_id` BIGINT COMMENT 'Unique identifier for the MDR configuration record. Primary key.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: MDR configuration must associate the acquiring bank legal entity for compliance and fee allocation reporting.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who created this MDR configuration record.. Valid values are `^[A-Z0-9_]{5,20}$`',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Currency reference needed for multi‑currency MDR calculations and GL posting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier for the acquiring bank or payment facilitator providing merchant services under this MDR configuration.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this MDR configuration for activation.. Valid values are `^[A-Z0-9_]{5,20}$`',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this MDR configuration record.. Valid values are `^[A-Z0-9_]{5,20}$`',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC classification drives tiered MDR pricing and risk scoring.',
    `primary_mdr_employee_id` BIGINT COMMENT 'Identifier of the user who approved this MDR configuration for activation.',
    `tertiary_mdr_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this MDR configuration record.',
    `approval_status` STRING COMMENT 'Approval workflow status for this MDR configuration before it becomes active.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this MDR configuration was approved.',
    `blended_rate_percent` DECIMAL(18,2) COMMENT 'The blended MDR percentage applied to all transactions for this merchant, expressed as a decimal (e.g., 0.0275 for 2.75%).',
    `card_brand` STRING COMMENT 'Card scheme or network brand this MDR configuration applies to. all indicates configuration applies to all card brands. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|unionpay|all — 7 candidates stripped; promote to reference product]',
    `card_type` STRING COMMENT 'Type of payment card this MDR configuration applies to. all indicates configuration applies to all card types.. Valid values are `credit|debit|prepaid|commercial|all`',
    `configuration_status` STRING COMMENT 'Current lifecycle status of this MDR configuration record.. Valid values are `active|inactive|pending|expired|superseded`',
    `contract_reference_number` STRING COMMENT 'Reference number of the merchant service agreement or contract that governs this MDR configuration.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this MDR configuration record was first created in the system.',
    `durbin_cap_amount` DECIMAL(18,2) COMMENT 'Maximum interchange fee amount allowed for Durbin-regulated debit transactions under this configuration.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether this MDR configuration applies to Durbin-regulated debit transactions (subject to interchange fee caps under Regulation II).',
    `effective_end_date` DATE COMMENT 'Date when this MDR configuration expires or is superseded. Null indicates open-ended configuration.',
    `effective_start_date` DATE COMMENT 'Date when this MDR configuration becomes active and applicable to merchant transactions.',
    `fixed_transaction_fee_amount` DECIMAL(18,2) COMMENT 'Fixed per-transaction fee charged to the merchant in addition to percentage-based MDR.',
    `interchange_plus_margin_percent` DECIMAL(18,2) COMMENT 'The margin percentage added on top of interchange fees for interchange-plus pricing model, expressed as a decimal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this MDR configuration record was last updated.',
    `maximum_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount for which this MDR configuration applies. Transactions above this threshold may use a different rate.',
    `merchant_segment_code` STRING COMMENT 'Classification code representing the merchant segment or tier (e.g., enterprise, SMB, micro-merchant) for tiered pricing strategies.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `mid` STRING COMMENT 'Unique identifier assigned to the merchant by the acquiring bank. Links this MDR configuration to a specific merchant.. Valid values are `^[A-Z0-9]{8,15}$`',
    `minimum_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required for this MDR configuration to apply. Transactions below this threshold may use a different rate.',
    `monthly_subscription_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monthly subscription fee for subscription-based pricing models.',
    `monthly_volume_threshold_amount` DECIMAL(18,2) COMMENT 'Monthly transaction volume threshold that triggers rate adjustments or tier changes for volume-based pricing.',
    `notes` STRING COMMENT 'Free-text notes or comments about this MDR configuration, including special terms, exceptions, or business context.',
    `pricing_model_type` STRING COMMENT 'The pricing model applied to this merchant: flat rate, tiered pricing, interchange-plus, subscription-based, or blended rate.. Valid values are `flat|tiered|interchange_plus|subscription|blended`',
    `revenue_share_percent` DECIMAL(18,2) COMMENT 'Percentage of MDR revenue shared with partners or sub-acquirers in payment facilitator or ISO arrangements, expressed as a decimal.',
    `tier_1_rate_percent` DECIMAL(18,2) COMMENT 'MDR percentage applied to transactions in tier 1 pricing band, expressed as a decimal.',
    `tier_1_threshold_amount` DECIMAL(18,2) COMMENT 'Transaction amount threshold for tier 1 pricing band in tiered pricing models. Transactions below this amount use tier 1 rate.',
    `tier_2_rate_percent` DECIMAL(18,2) COMMENT 'MDR percentage applied to transactions in tier 2 pricing band, expressed as a decimal.',
    `tier_2_threshold_amount` DECIMAL(18,2) COMMENT 'Transaction amount threshold for tier 2 pricing band in tiered pricing models. Transactions between tier 1 and tier 2 thresholds use tier 2 rate.',
    `tier_3_rate_percent` DECIMAL(18,2) COMMENT 'MDR percentage applied to transactions above tier 2 threshold in tiered pricing models, expressed as a decimal.',
    `transaction_channel` STRING COMMENT 'Transaction channel or entry mode this MDR configuration applies to (e.g., card-present POS, ecommerce, mail/telephone order).. Valid values are `card_present|card_not_present|ecommerce|moto|recurring|all`',
    CONSTRAINT pk_mdr_config PRIMARY KEY(`mdr_config_id`)
) COMMENT 'Merchant Discount Rate (MDR) configuration master — stores the contractual MDR applied to each merchant or merchant segment. Captures blended rate, interchange-plus margin, tiered pricing bands, effective date range, currency, acquiring bank identifier, and pricing model type (flat, tiered, IC-plus, subscription). SSOT for merchant-facing pricing in the acquiring portfolio.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` (
    `msf_schedule_id` BIGINT COMMENT 'Unique identifier for the merchant service fee schedule record.',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved this fee schedule for activation.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this fee schedule for activation.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: Schedule fees are MCC‑specific; linking enables accurate fee schedule generation.',
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant to whom this fee schedule applies.',
    `pricing_tier_id` BIGINT COMMENT 'Identifier for the pricing tier or program that defines the fee structure for this merchant.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Transaction type drives schedule applicability and compliance with scheme rules.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual membership or service fee charged to the merchant.',
    `approval_status` STRING COMMENT 'Approval workflow status for this fee schedule configuration.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule was approved.',
    `avs_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per Address Verification System check performed during transaction authorization.',
    `batch_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per batch settlement submission by the merchant.',
    `card_brand` STRING COMMENT 'Payment card network or scheme to which this fee schedule applies (Visa, Mastercard, Amex, Discover, JCB, UnionPay, or all). [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|unionpay|all — 7 candidates stripped; promote to reference product]',
    `chargeback_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the merchant for each chargeback dispute processed.',
    `contract_term_months` STRING COMMENT 'Duration in months for which this fee schedule is contractually binding.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all fee amounts in this schedule are denominated.. Valid values are `^[A-Z]{3}$`',
    `durbin_exempt_flag` BOOLEAN COMMENT 'Indicates whether this fee schedule applies to Durbin Amendment exempt transactions (small issuer or government/reloadable prepaid cards).',
    `early_termination_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged if the merchant terminates the agreement before the contract term expires.',
    `effective_end_date` DATE COMMENT 'Date when this fee schedule expires or is no longer applicable. Null indicates open-ended schedule.',
    `effective_start_date` DATE COMMENT 'Date when this fee schedule becomes active and applicable to merchant transactions.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which revenue from this fee schedule is posted.',
    `interchange_pass_through_flag` BOOLEAN COMMENT 'Indicates whether interchange fees are passed through to the merchant at cost (true) or bundled into the service fee (false).',
    `international_transaction_fee_amount` DECIMAL(18,2) COMMENT 'Additional fee charged for cross-border or international payment transactions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule record was last modified.',
    `monthly_account_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monthly account maintenance or service fee charged to the merchant.',
    `monthly_minimum_fee_amount` DECIMAL(18,2) COMMENT 'Minimum monthly fee that the merchant must pay regardless of transaction volume.',
    `msf_schedule_status` STRING COMMENT 'Current lifecycle status of the merchant service fee schedule.. Valid values are `active|inactive|pending|suspended|expired|terminated`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this fee schedule, including special terms or exceptions.',
    `pci_compliance_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for PCI DSS compliance validation, scanning, or non-compliance penalties.',
    `per_transaction_fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee amount charged per transaction processed under this schedule.',
    `percentage_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to transaction amount as part of the merchant service fee (e.g., 2.5% represented as 0.02500).',
    `retrieval_request_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for processing a retrieval request (pre-chargeback inquiry) from the issuing bank.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method used to recognize revenue from this fee schedule (accrual, cash, deferred, straight-line).. Valid values are `accrual|cash|deferred|straight_line`',
    `schedule_name` STRING COMMENT 'Business-friendly name or label for this merchant service fee schedule.',
    `schedule_type` STRING COMMENT 'Classification of the fee schedule structure (standard, custom, promotional, tiered, interchange-plus, flat-rate).. Valid values are `standard|custom|promotional|tiered|interchange_plus|flat_rate`',
    `statement_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for generating and delivering monthly or periodic account statements to the merchant.',
    `voice_authorization_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged when a merchant obtains authorization via phone rather than electronic terminal.',
    `volume_tier_threshold_amount` DECIMAL(18,2) COMMENT 'Monthly transaction volume threshold amount that qualifies the merchant for this fee schedule tier.',
    `volume_tier_threshold_count` STRING COMMENT 'Monthly transaction count threshold that qualifies the merchant for this fee schedule tier.',
    CONSTRAINT pk_msf_schedule PRIMARY KEY(`msf_schedule_id`)
) COMMENT 'Merchant Service Fee (MSF) schedule defining the fee structures billed to merchants for payment acceptance services. Stores monthly/annual fee amounts, per-transaction service fees, minimum monthly fees, statement fees, PCI compliance fees, chargeback fees, and the applicable merchant tier or program. Supports revenue recognition for the acquiring portfolio.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` (
    `scheme_fee_table_id` BIGINT COMMENT 'Unique identifier for the scheme fee table record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Fee tables are keyed by card scheme; linking to scheme reference enables unified fee reporting.',
    `assessment_basis` STRING COMMENT 'Basis on which assessment fees are calculated: gross volume (total transaction value including refunds), net volume (purchases minus refunds), or transaction count.. Valid values are `gross_volume|net_volume|transaction_count`',
    `bin_range_high` STRING COMMENT 'Upper bound of BIN/IIN range to which this fee applies. Used for BIN-level interchange qualification rules. Null if fee applies to all BINs.. Valid values are `^[0-9]{6,8}$`',
    `bin_range_low` STRING COMMENT 'Lower bound of BIN/IIN range to which this fee applies. Used for BIN-level interchange qualification rules. Null if fee applies to all BINs.. Valid values are `^[0-9]{6,8}$`',
    `card_present_indicator` STRING COMMENT 'Indicates whether the fee applies to card-present (POS/mPOS), card-not-present (e-commerce/MOTO), or both transaction environments.. Valid values are `card_present|card_not_present|both`',
    `card_product_type` STRING COMMENT 'Type of card product to which this fee applies: credit, debit, prepaid, commercial (business/corporate), or all card types.. Valid values are `credit|debit|prepaid|commercial|all`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scheme fee table record was first created in the system.',
    `digital_wallet_indicator` BOOLEAN COMMENT 'Indicates whether this fee applies specifically to digital wallet or tokenized transactions (e.g., Apple Pay, Google Pay, Samsung Pay). True if digital-wallet-specific, false otherwise.',
    `domestic_international_indicator` STRING COMMENT 'Specifies whether the fee applies to domestic transactions (same country acquirer/issuer), international (cross-border), or both.. Valid values are `domestic|international|both`',
    `durbin_regulated_indicator` BOOLEAN COMMENT 'Indicates whether this fee applies to Durbin Amendment regulated debit transactions (US Regulation II compliance). True if fee is for regulated debit, false otherwise.',
    `effective_end_date` DATE COMMENT 'Date on which this fee schedule expires or is superseded. Null for currently active fee schedules with no defined end date.',
    `effective_start_date` DATE COMMENT 'Date from which this fee schedule becomes effective. Used for accurate cost modeling across time periods.',
    `fee_code` STRING COMMENT 'Scheme-assigned alphanumeric code uniquely identifying this fee within the schemes fee schedule.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the fee is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fee_description` STRING COMMENT 'Detailed description of the fee purpose, calculation methodology, and any special conditions or exemptions as published by the card scheme.',
    `fee_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed fee amount per transaction in the fee currency. Null if fee is not fixed-amount-based.',
    `fee_name` STRING COMMENT 'Descriptive name of the specific fee as published by the card scheme (e.g., Visa Assessment Fee, Mastercard Cross-Border Volume Fee, Amex Digital Enablement Fee).',
    `fee_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to transaction value, expressed as decimal (e.g., 0.00125 for 12.5 basis points). Null if fee is not percentage-based.',
    `fee_rate_type` STRING COMMENT 'Structure of the fee calculation: percentage (basis points of transaction value), fixed (flat amount per transaction), tiered (volume-based brackets), or hybrid (combination).. Valid values are `percentage|fixed|tiered|hybrid`',
    `fee_status` STRING COMMENT 'Current lifecycle status of the fee schedule: active (currently in effect), pending (announced but not yet effective), superseded (replaced by newer schedule), or retired (no longer applicable).. Valid values are `active|pending|superseded|retired`',
    `fee_type` STRING COMMENT 'Category of scheme fee: assessment (volume-based), network access (fixed connectivity), cross-border (international transaction), digital enablement (tokenization/digital wallet), misuse-of-authorization (declined auth reuse), or scheme-specific surcharge.. Valid values are `assessment|network_access|cross_border|digital_enablement|misuse_of_authorization|scheme_surcharge`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scheme fee table record was last updated, reflecting any changes to fee rates, effective dates, or other attributes.',
    `maximum_fee_amount` DECIMAL(18,2) COMMENT 'Maximum fee amount charged per transaction, capping percentage-based fees for high-value transactions.',
    `mcc_range_high` STRING COMMENT 'Upper bound of MCC range to which this fee applies. Used for merchant-category-specific fees. Null if fee applies to all MCCs.. Valid values are `^[0-9]{4}$`',
    `mcc_range_low` STRING COMMENT 'Lower bound of MCC range to which this fee applies. Used for merchant-category-specific fees. Null if fee applies to all MCCs.. Valid values are `^[0-9]{4}$`',
    `minimum_fee_amount` DECIMAL(18,2) COMMENT 'Minimum fee amount charged per transaction, regardless of percentage calculation. Ensures floor for low-value transactions.',
    `party_type` STRING COMMENT 'Indicates which party in the payment chain is charged this fee: acquirer (merchants bank), issuer (cardholders bank), or both.. Valid values are `acquirer|issuer|both`',
    `region_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or region code where this fee applies (e.g., USA, GBR, EUR for Eurozone). Null if fee is global.. Valid values are `^[A-Z]{3}$`',
    `scheme_publication_reference` STRING COMMENT 'Reference to the official scheme publication, bulletin, or rules document where this fee is defined (e.g., Visa USA Interchange Reimbursement Fees April 2024).',
    `three_d_secure_indicator` BOOLEAN COMMENT 'Indicates whether this fee applies to transactions authenticated via 3-D Secure protocol (3DS 1.0 or 3DS 2.0). True if 3DS-specific, false otherwise.',
    `transaction_type` STRING COMMENT 'Type of transaction to which this fee applies: purchase, cash advance, refund, chargeback, or all transaction types.. Valid values are `purchase|cash_advance|refund|chargeback|all`',
    `volume_tier_lower_bound` DECIMAL(18,2) COMMENT 'Lower threshold of transaction volume or count for tiered fee structures. Null if fee is not volume-tiered.',
    `volume_tier_unit` STRING COMMENT 'Unit of measurement for volume tiers: transaction count (number of transactions) or transaction value (monetary volume).. Valid values are `transaction_count|transaction_value`',
    `volume_tier_upper_bound` DECIMAL(18,2) COMMENT 'Upper threshold of transaction volume or count for tiered fee structures. Null for open-ended top tier.',
    CONSTRAINT pk_scheme_fee_table PRIMARY KEY(`scheme_fee_table_id`)
) COMMENT 'Card scheme assessment and network fee table capturing all fees levied by Visa, Mastercard, Amex, Discover, and other schemes on acquirers and issuers. Includes assessment rates, network access fees, cross-border fees, digital enablement fees, misuse-of-authorization fees, and scheme-specific surcharges. Effective date ranges and volume tier thresholds are tracked for accurate cost modeling.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` (
    `bin_interchange_rule_id` BIGINT COMMENT 'Unique surrogate primary key identifying a BIN-level interchange qualification rule record in the silver layer lakehouse. Entity role: MASTER_RESOURCE — represents a configuration/rule resource governing interchange qualification for a BIN range.',
    `ecosystem_partner_id` BIGINT COMMENT 'Reference to the issuing bank or financial institution that issued the card associated with this BIN range. The issuing bank is the cardholders bank in the payment chain.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: bin_interchange_rule references IRF category; adds irf_rate_category_id FK',
    `scheme_id` BIGINT COMMENT 'Reference to the card scheme (payment network brand) governing this interchange rule, such as Visa, Mastercard, American Express, or Discover. Links to the scheme reference product.',
    `superseded_by_rule_bin_interchange_rule_id` BIGINT COMMENT 'Reference to the bin_interchange_rule_id of the newer rule that supersedes this record when rule_status is superseded. Enables rule lineage tracking and historical interchange qualification reconstruction.',
    `authorization_indicator` STRING COMMENT 'Specifies the type of authorization associated with this interchange rule: pre-authorization (hotel/car rental), final authorization, or incremental authorization. Different authorization types may qualify for distinct interchange rates.. Valid values are `pre_auth|final_auth|incremental|undefined`',
    `avs_required` BOOLEAN COMMENT 'Indicates whether Address Verification System (AVS) check is required for a transaction to qualify for this interchange rate category. AVS validation is a fraud prevention measure commonly required for card-not-present interchange qualification.',
    `bin_range_end` STRING COMMENT 'The ending BIN (Bank Identification Number) of the BIN range to which this interchange qualification rule applies. Together with bin_range_start, defines the full BIN range covered by this rule.. Valid values are `^[0-9]{6,11}$`',
    `bin_range_start` STRING COMMENT 'The starting BIN (Bank Identification Number), also known as IIN (Issuer Identification Number), of the BIN range to which this interchange qualification rule applies. Supports 6-digit legacy BINs and 8-digit extended BINs per ISO/IEC 7812.. Valid values are `^[0-9]{6,11}$`',
    `card_brand` STRING COMMENT 'The payment network brand associated with this BIN range (e.g., VISA, MASTERCARD). Used in conjunction with scheme_id for interchange qualification and reporting.. Valid values are `VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|JCB`',
    `card_not_present_eligible` BOOLEAN COMMENT 'Indicates whether this interchange rule applies to card-not-present (CNP) transactions, such as e-commerce, mail order, or telephone order (MOTO) transactions. CNP transactions typically carry higher interchange rates due to elevated fraud risk.',
    `card_present_eligible` BOOLEAN COMMENT 'Indicates whether this interchange rule applies to card-present (CP) transactions, where the physical card or device is used at a POS or mPOS terminal. Card-present transactions typically qualify for lower interchange rates than card-not-present.',
    `card_product_type` STRING COMMENT 'Classification of the card product associated with this BIN range, determining the applicable interchange rate tier. Debit and prepaid cards may be subject to Durbin Amendment regulated caps; commercial and government cards follow separate interchange schedules. Serves as the primary CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity. [ENUM-REF-CANDIDATE: debit|credit|prepaid|commercial|government|healthcare — promote to reference product]. Valid values are `debit|credit|prepaid|commercial|government|healthcare`',
    `contactless_eligible` BOOLEAN COMMENT 'Indicates whether this interchange rule applies to contactless NFC (Near Field Communication) transactions, including tap-to-pay and mobile wallet payments. Contactless qualification may carry distinct interchange rates from contact chip transactions.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the issuing country associated with this BIN range (e.g., USA, GBR, DEU). Determines domestic vs. cross-border interchange rate applicability and regulatory jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BIN interchange rule record was first created in the data platform. Serves as the RECORD_AUDIT_CREATED field for audit trail and data lineage purposes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether this interchange rule applies specifically to cross-border transactions where the issuing country differs from the acquiring country. Cross-border transactions typically attract higher interchange rates and additional scheme fees.',
    `data_quality_indicator` STRING COMMENT 'Indicates the level of transaction data (Level 1, Level 2, Level 3) required for interchange qualification under this rule. Level 2/3 data (enhanced transaction detail for B2B/commercial cards) may qualify for lower interchange rates.. Valid values are `full_data|partial_data|no_data`',
    `durbin_exempt_reason` STRING COMMENT 'Reason code explaining why a BIN range is exempt from Durbin Amendment regulated interchange caps. Applicable only when durbin_regulated_flag is False. Small issuers (assets < $10B), government-administered programs, and certain prepaid products qualify for exemption.. Valid values are `small_issuer|government|prepaid|reloadable_prepaid|not_applicable`',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether this BIN range is subject to the Durbin Amendment interchange fee caps under Federal Reserve Regulation II. True = regulated (issuer assets ≥ $10B threshold, capped at 21 cents + 0.05% + 1 cent fraud adjustment); False = unregulated (exempt issuers, higher interchange applies).',
    `effective_end_date` DATE COMMENT 'The date on which this BIN interchange qualification rule ceases to be effective. Null indicates an open-ended rule with no defined expiry. Used to manage rule versioning and historical interchange cost analysis. Serves as EFFECTIVE_UNTIL for this MASTER_RESOURCE entity.',
    `effective_start_date` DATE COMMENT 'The date from which this BIN interchange qualification rule becomes effective and is applied during transaction processing and interchange qualification. Aligns with scheme fee schedule publication cycles (typically semi-annual for Visa/Mastercard). Serves as EFFECTIVE_FROM for this MASTER_RESOURCE entity.',
    `emv_chip_required` BOOLEAN COMMENT 'Indicates whether EMV (Europay Mastercard Visa) chip processing is required for a transaction to qualify for this interchange rate category. EMV chip transactions reduce fraud liability and may qualify for preferential interchange rates.',
    `installment_eligible` BOOLEAN COMMENT 'Indicates whether this interchange rule applies to installment payment transactions, including BNPL (Buy Now Pay Later) arrangements. Installment transactions may carry distinct interchange qualification criteria.',
    `interchange_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the interchange fixed fee is denominated (e.g., USD, EUR, GBP). Required for cross-border interchange cost calculations and multi-currency acquiring portfolios.. Valid values are `^[A-Z]{3}$`',
    `interchange_fixed_fee` DECIMAL(18,2) COMMENT 'The fixed per-transaction fee component of the interchange, expressed in the applicable currency (e.g., 0.1000 = $0.10 per transaction). Combined with interchange_rate_percent to compute total interchange cost per transaction.',
    `interchange_rate_percent` DECIMAL(18,2) COMMENT 'The percentage-based component of the interchange fee applied to the transaction amount for qualifying transactions under this BIN rule (e.g., 1.6500 represents 1.65%). Used in cost-of-acceptance calculations for acquiring portfolios. Serves as the MEASUREMENT_OR_VALUE for this MASTER_RESOURCE entity.',
    `mcc_list` STRING COMMENT 'Comma-separated list of MCC (Merchant Category Code) values that are included or excluded from this interchange rule, as determined by mcc_restriction_type. For example, 5411,5412,5499 for grocery MCCs. Null when mcc_restriction_type is all.',
    `mcc_restriction_type` STRING COMMENT 'Defines how MCC (Merchant Category Code) restrictions apply to this interchange rule: all means no MCC restriction (applies to all MCCs), include means only specified MCCs qualify, exclude means specified MCCs are excluded, none means no transactions qualify regardless of MCC.. Valid values are `all|include|exclude|none`',
    `recurring_eligible` BOOLEAN COMMENT 'Indicates whether this interchange rule applies to recurring or subscription-based transactions. Recurring transactions may qualify for specific interchange programs with distinct rate structures.',
    `region_code` STRING COMMENT 'Card scheme-defined geographic region code associated with this BIN range (e.g., AP for Asia Pacific, CEMEA for Central Europe Middle East Africa, LAC for Latin America and Caribbean, NA for North America). Used for cross-border interchange rate determination.. Valid values are `^[A-Z]{2,6}$`',
    `rule_code` STRING COMMENT 'Externally-known unique business code identifying this BIN interchange qualification rule, used in downstream transaction processing and interchange qualification engines. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `rule_description` STRING COMMENT 'Free-text description providing additional context about this BIN interchange qualification rule, including any special conditions, exceptions, or notes from the card scheme or compliance team.',
    `rule_name` STRING COMMENT 'Human-readable descriptive name for the BIN interchange qualification rule (e.g., Visa Debit Regulated CPS Retail). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE entity.',
    `rule_status` STRING COMMENT 'Current lifecycle status of this BIN interchange qualification rule. Active rules are applied in real-time interchange qualification; superseded rules have been replaced by newer versions; expired rules are past their effective end date. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity.. Valid values are `active|inactive|pending|superseded|expired`',
    `scheme_program_code` STRING COMMENT 'Card scheme-assigned program code identifying the specific interchange program under which this rule is classified (e.g., CPS/RETAIL, EIRF, MERIT III, WORLD, SIGNATURE). Used for interchange qualification matching in the transaction processing platform.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `source_system_rule_ref` STRING COMMENT 'The native rule identifier or reference code from the originating operational system (Transaction Processing Platform or Payment Gateway) from which this BIN interchange rule was sourced. Supports data lineage and reconciliation back to the system of record.. Valid values are `^[A-Za-z0-9_-]{1,50}$`',
    `three_ds_required` BOOLEAN COMMENT 'Indicates whether 3-D Secure (3DS) authentication is required for card-not-present transactions to qualify for this interchange rate. 3DS-authenticated transactions may qualify for lower interchange rates and shift fraud liability to the issuer. Relevant under PSD2 SCA requirements.',
    `tokenization_eligible` BOOLEAN COMMENT 'Indicates whether transactions using a DPAN (Device Primary Account Number) or network token issued by a TSP (Token Service Provider) for this BIN range are eligible for this interchange rate. Tokenized transactions may qualify for distinct interchange rates.',
    `transaction_max_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount (in the fee currency) eligible for this interchange rate category. Transactions exceeding this threshold may be subject to different interchange rates or require additional qualification criteria.',
    `transaction_min_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount (in the fee currency) required for a transaction to qualify for this interchange rate category. Transactions below this threshold may downgrade to a less favorable interchange tier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this BIN interchange rule record was last modified in the data platform. Supports change tracking, rule versioning audit, and regulatory compliance reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `version_number` STRING COMMENT 'Sequential version number of this BIN interchange rule record, incremented each time the rule is updated. Supports rule versioning and historical interchange qualification audit trails required for regulatory compliance and dispute resolution.',
    CONSTRAINT pk_bin_interchange_rule PRIMARY KEY(`bin_interchange_rule_id`)
) COMMENT 'BIN (Bank Identification Number) level interchange qualification rules mapping BIN ranges to applicable interchange rate categories. Captures BIN range start/end, issuing bank identifier, card product type (debit, credit, prepaid, commercial), regulated/unregulated flag under Durbin Amendment, applicable IRF category codes, and scheme identifier. Core to real-time interchange qualification during transaction processing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` (
    `durbin_compliance_tier_id` BIGINT COMMENT 'Unique surrogate identifier for each Durbin Amendment (Regulation II) compliance tier record in the registry. Primary key for the durbin_compliance_tier data product.',
    `annual_review_required` BOOLEAN COMMENT 'Indicates whether issuers in this compliance tier are subject to annual Federal Reserve data collection and review (e.g., the Federal Reserves annual debit card survey under Regulation II). Regulated issuers above the $10 billion threshold are subject to annual reporting.',
    `applicable_geography` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the geographic jurisdiction in which this compliance tier applies. Regulation II is a US domestic regulation; this field is USA for all standard Durbin tiers but supports future multi-jurisdiction extensions.. Valid values are `^[A-Z]{3}$`',
    `asset_threshold_usd` DECIMAL(18,2) COMMENT 'Consolidated asset threshold in US dollars used to determine whether an issuer is subject to Regulation II interchange caps. The Federal Reserve sets this at $10 billion; issuers at or above this threshold are regulated. Stored as the threshold value applicable to this tier.',
    `bin_range_end` STRING COMMENT 'Ending Bank Identification Number (BIN) / Issuer Identification Number (IIN) of the BIN range to which this compliance tier applies. Used in conjunction with bin_range_start to define the full BIN range scope for interchange qualification.. Valid values are `^[0-9]{6,8}$`',
    `bin_range_start` STRING COMMENT 'Starting Bank Identification Number (BIN) / Issuer Identification Number (IIN) of the BIN range to which this compliance tier applies. Enables BIN-level interchange qualification routing. Stored as a 6–8 digit string per ISO 7812.. Valid values are `^[0-9]{6,8}$`',
    `card_scheme` STRING COMMENT 'Payment network brand (card scheme) to which this compliance tier applies. Regulation II applies to all debit card networks; however, interchange cap and routing rules may differ by scheme. [ENUM-REF-CANDIDATE: visa|mastercard|discover|amex|interlink|star|pulse|nyce|maestro|unionpay — promote to reference product]',
    `compliance_owner` STRING COMMENT 'Name or identifier of the internal compliance team or officer responsible for maintaining and certifying this compliance tier record. Supports accountability and audit trail requirements under SOX and internal governance frameworks.',
    `cost_of_acceptance_impact` STRING COMMENT 'Indicates the directional impact of this compliance tier on merchant cost of acceptance (MDR/MSF). Regulated tiers with capped interchange typically reduce cost of acceptance for merchants; exempt tiers may result in higher interchange and increased merchant cost.. Valid values are `reduces_cost|increases_cost|no_impact`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance tier record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit creation trail required for SOX compliance and data lineage in the Databricks Lakehouse Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which interchange caps and fee amounts in this compliance tier are denominated. Typically USD for Regulation II tiers.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'Name of the operational system of record from which this compliance tier record originates or is maintained (e.g., Risk and Compliance Management System, Transaction Processing Platform). Supports data lineage tracking in the Databricks Lakehouse Silver Layer.',
    `debit_card_type` STRING COMMENT 'Type of debit card program covered by this compliance tier. Regulation II exemptions differ by card type — government-administered and certain reloadable prepaid programs are exempt from interchange caps. [ENUM-REF-CANDIDATE: consumer_debit|prepaid|government_benefit|payroll|healthcare_fsa|commercial_debit — promote to reference product]. Valid values are `consumer_debit|prepaid|government_benefit|payroll|healthcare_fsa`',
    `effective_date` DATE COMMENT 'Calendar date on which this Durbin compliance tier configuration becomes effective and applicable to interchange cap enforcement and routing compliance checks. Aligns with Federal Reserve regulatory reporting periods.',
    `emv_chip_required` BOOLEAN COMMENT 'Indicates whether EMV (Europay Mastercard Visa) chip card technology is required for transactions qualifying under this compliance tier. Relevant for fraud-adjustment eligibility under Regulation II, which requires issuers to implement chip technology as part of fraud-prevention standards.',
    `enabled_network_count` STRING COMMENT 'Number of unaffiliated payment networks on which debit cards in this compliance tier are enabled for routing. Regulation II requires a minimum of two unaffiliated networks. Used to validate network exclusivity compliance.',
    `expiry_date` DATE COMMENT 'Calendar date on which this Durbin compliance tier configuration ceases to be effective. Null for open-ended tiers that remain in force until superseded. Used in date-range queries for point-in-time compliance reporting.',
    `fed_regulation_citation` STRING COMMENT 'Specific Federal Register or Code of Federal Regulations citation underpinning this compliance tier (e.g., 12 CFR Part 235, Federal Register Vol. 76 No. 130). Provides a direct regulatory audit trail for compliance and legal review.',
    `fed_reporting_period` STRING COMMENT 'Federal Reserve reporting period to which this compliance tier applies, formatted as YYYY-H1, YYYY-H2, YYYY-Q1, etc. The Federal Reserve collects debit card interchange data annually; this field links the tier to the applicable regulatory data collection cycle.. Valid values are `^[0-9]{4}-(H1|H2|Q1|Q2|Q3|Q4|ANNUAL)$`',
    `fraud_adjustment_cap_cents` DECIMAL(18,2) COMMENT 'Maximum additional interchange allowance in US cents per transaction for fraud-prevention activities, available to eligible regulated issuers under Regulation II. Currently set at 1 cent per transaction by the Federal Reserve. Null if fraud_adjustment_eligible is false.',
    `fraud_adjustment_eligible` BOOLEAN COMMENT 'Indicates whether issuers in this compliance tier are eligible to receive the 1-cent fraud-prevention adjustment allowance on top of the base interchange cap under Regulation II. Eligibility requires the issuer to meet the Federal Reserves fraud-prevention standards annually.',
    `interchange_cap_ad_valorem_bps` DECIMAL(18,2) COMMENT 'Ad valorem (percentage-based) component of the Regulation II interchange cap expressed in basis points of the transaction value. Under the Federal Reserve rule, regulated issuers may charge up to 0.05% (5 basis points) of the transaction amount in addition to the fixed cent cap.',
    `interchange_cap_cents` DECIMAL(18,2) COMMENT 'Maximum allowable interchange fee in US cents per debit card transaction under Regulation II for this compliance tier. For regulated issuers, the Federal Reserve base cap is 21 cents plus 0.05% of the transaction value, with an optional 1-cent fraud-adjustment allowance. This field stores the fixed per-transaction cent component of the cap.',
    `issuer_asset_band` STRING COMMENT 'Categorical asset size band of the issuer population covered by this tier, used for segmentation and analytics. above_10b corresponds to regulated issuers under Regulation II; bands below $10 billion are exempt. Supports revenue and cost-of-acceptance analysis by issuer size.. Valid values are `below_1b|1b_to_5b|5b_to_10b|above_10b`',
    `issuer_classification` STRING COMMENT 'Classification of the issuer under Regulation II based on asset threshold and card program type. regulated applies to issuers with consolidated assets ≥ $10 billion; exempt covers small issuers below the threshold; government_administered and reloadable_prepaid reflect statutory exemptions under Regulation II Section 235.5.. Valid values are `regulated|exempt|small_issuer_exempt|government_administered|reloadable_prepaid`',
    `last_review_date` DATE COMMENT 'Date on which this compliance tier was last reviewed against current Federal Reserve Regulation II rules and issuer asset threshold data. Used to track compliance review cadence and identify tiers due for reassessment.',
    `merchant_routing_choice_enabled` BOOLEAN COMMENT 'Indicates whether merchants are permitted to exercise least-cost routing (LCR) or preferred network routing for transactions under this compliance tier, as required by Regulation II. True = merchant routing choice is enabled and enforced; False = routing is issuer-controlled.',
    `network_exclusivity_compliant` BOOLEAN COMMENT 'Indicates whether issuers in this tier comply with the Regulation II network exclusivity prohibition, which requires that each debit card be enabled on at least two unaffiliated payment networks (e.g., Visa and a PIN debit network). True = compliant; False = non-compliant or under review.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this tier against Federal Reserve Regulation II requirements and updated issuer asset threshold data. Supports proactive compliance management and audit scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional regulatory context, internal compliance annotations, or exception documentation related to this compliance tier. Used by compliance officers to record interpretive guidance or Federal Reserve correspondence.',
    `pin_debit_routing_required` BOOLEAN COMMENT 'Indicates whether PIN-authenticated debit routing must be offered as one of the two unaffiliated network options under Regulation II network exclusivity requirements for this compliance tier. Supports routing compliance validation.',
    `revenue_impact_classification` STRING COMMENT 'Classifies the financial impact of this compliance tier on the acquiring or issuing portfolio. revenue_generating = tier enables interchange income above cost; cost_center = tier results in net interchange cost; neutral = break-even. Supports revenue recognition and cost-of-acceptance analysis in ERP – Oracle Financials.. Valid values are `revenue_generating|cost_center|neutral`',
    `routing_type` STRING COMMENT 'Indicates whether this compliance tier applies to dual-message (signature debit, e.g., Visa/Mastercard), single-message (PIN debit, e.g., Interlink/STAR), or both routing architectures. Dual-message transactions are authorized and cleared separately; single-message transactions are authorized and cleared in one message per ISO 8583.. Valid values are `dual_message|single_message|both`',
    `superseded_by_tier_code` STRING COMMENT 'Tier code of the compliance tier record that replaced this record when it was superseded. Null if this tier is currently active or was retired without a direct successor. Enables forward-chaining of tier version history for regulatory audit trails.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `tier_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this compliance tier configuration (e.g., REG_TIER_1, EXEMPT_TIER_A). Used as the business-facing identifier in regulatory filings and interchange routing tables.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `tier_description` STRING COMMENT 'Detailed narrative description of the compliance tier, including the regulatory basis, applicable issuer population, and interchange cap rationale. Supports audit and regulatory review.',
    `tier_name` STRING COMMENT 'Human-readable name describing the compliance tier (e.g., Regulated Issuer – Standard Cap, Small Issuer Exempt – Fraud Adjustment Eligible). Used in reporting dashboards and regulatory documentation.',
    `tier_status` STRING COMMENT 'Current lifecycle status of this compliance tier record. active = currently in force; inactive = no longer applicable; pending = approved but not yet effective; superseded = replaced by a newer tier version; under_review = subject to Federal Reserve or internal compliance review.. Valid values are `active|inactive|pending|superseded|under_review`',
    `transaction_channel` STRING COMMENT 'Payment transaction channel to which this compliance tiers interchange cap and routing rules apply. Regulation II routing requirements may differ between card-present (POS/NFC) and card-not-present (e-commerce) environments.. Valid values are `card_present|card_not_present|atm|recurring|ecommerce`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this compliance tier record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used to detect stale configurations and support incremental ETL processing in the Data Warehouse and Analytics Platform.',
    `version_number` STRING COMMENT 'Monotonically incrementing version number for this compliance tier record, incremented each time the tier configuration is updated (e.g., cap amount change, routing rule update). Supports point-in-time compliance auditing and change history tracking.',
    CONSTRAINT pk_durbin_compliance_tier PRIMARY KEY(`durbin_compliance_tier_id`)
) COMMENT 'Durbin Amendment (Regulation II) compliance tier registry tracking issuer debit card interchange caps and routing requirements. Stores issuer asset threshold classification (regulated vs. exempt), applicable interchange cap (cents per transaction), network exclusivity compliance status, dual-message vs. single-message routing flags, effective date, and Federal Reserve reporting period. SSOT for Durbin regulatory compliance in debit interchange.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the interchange qualification record. Primary key for this transactional record of interchange rate qualification outcome.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Qualification logic depends on card‑scheme specific rules stored in reference.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: interchange_qualification references qualified IRF category; adds irf_rate_category_id FK',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC determines eligibility and rate tiers for interchange qualification.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant who accepted the transaction. Links to merchant management system for merchant-level interchange analysis and cost-of-acceptance reporting.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Regulatory interchange fee reporting requires the FX rate used to convert foreign‑currency transaction amounts to settlement currency.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Pricing reports need merchant risk tier; linking qualification to risk_profile enables tier‑based fee calculations.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: Enables qualification data to be associated with the settlement cycle used in interchange fee calculations and audit trails.',
    `transaction_id` BIGINT COMMENT 'Reference to the cleared transaction for which interchange qualification was performed. Links to the transaction processing platform record.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Transaction type is required for rule‑based qualification and reporting.',
    `arn` STRING COMMENT 'Unique 23-digit acquirer reference number assigned to the transaction by the acquiring bank. Used for transaction tracing across the payment network.. Valid values are `^[0-9]{23}$`',
    `authorization_date` DATE COMMENT 'Date on which the transaction was authorized. Time between authorization and settlement is a factor in interchange qualification.',
    `avs_result_code` STRING COMMENT 'Result code from address verification system check performed during authorization. AVS match is a qualifying criterion for many card-not-present interchange categories.',
    `bin` STRING COMMENT 'First 6-8 digits of the card number identifying the issuing bank and card program. BIN-level interchange qualification rules determine which IRF category applies based on issuer and card product.. Valid values are `^[0-9]{6,8}$`',
    `card_present_flag` BOOLEAN COMMENT 'Indicates whether the transaction was card-present (face-to-face) or card-not-present (e-commerce, mail order, phone order). Card-present transactions typically qualify for lower interchange rates.',
    `card_type` STRING COMMENT 'Type of payment card used in the transaction. Card type is a primary factor in interchange qualification as different card types have different IRF schedules.. Valid values are `credit|debit|prepaid|commercial|purchasing`',
    `contactless_flag` BOOLEAN COMMENT 'Indicates whether the transaction was processed using contactless NFC technology (tap-to-pay). Contactless transactions may qualify for specific interchange categories.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange qualification record was first created in the data platform. Audit field for data lineage and compliance.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether the transaction crossed international borders (acquiring country differs from issuing country). Cross-border transactions typically incur higher interchange rates and additional scheme fees.',
    `cvv_result_code` STRING COMMENT 'Result code from CVV verification performed during authorization. CVV match is a qualifying criterion for card-not-present transactions to achieve optimal interchange rates.',
    `downgrade_reason_code` STRING COMMENT 'Code indicating why the transaction was downgraded to a higher interchange rate category. Null if transaction qualified for optimal rate. Common reasons include missing AVS, non-EMV, delayed settlement, or missing Level 2/3 data.',
    `downgrade_reason_description` STRING COMMENT 'Human-readable description of why the transaction was downgraded, providing detail on the specific qualification criteria that were not met.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether the transaction is subject to Durbin Amendment interchange rate caps (applies to debit cards issued by banks with $10B+ in assets in the United States). Durbin-regulated transactions have capped interchange rates.',
    `emv_chip_flag` BOOLEAN COMMENT 'Indicates whether the transaction was processed using EMV chip technology. EMV transactions typically qualify for preferential interchange rates due to enhanced security.',
    `interchange_amount` DECIMAL(18,2) COMMENT 'The total calculated interchange fee amount for this transaction based on the qualified IRF rate and transaction amount. This is the fee paid from the acquiring bank to the issuing bank.',
    `irf_fixed_amount` DECIMAL(18,2) COMMENT 'The fixed fee component of the qualified interchange fee applied to the transaction. Expressed in the settlement currency.',
    `irf_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage rate component of the qualified interchange fee applied to the transaction amount. Expressed as a decimal (e.g., 0.0175 for 1.75%).',
    `level_2_data_present_flag` BOOLEAN COMMENT 'Indicates whether Level 2 enhanced data (tax amount, customer code, etc.) was provided with the transaction. Level 2 data is required for commercial card interchange optimization.',
    `level_3_data_present_flag` BOOLEAN COMMENT 'Indicates whether Level 3 line-item data (item descriptions, quantities, unit costs) was provided with the transaction. Level 3 data is required for optimal commercial and purchasing card interchange rates.',
    `qualification_status` STRING COMMENT 'Status indicating whether the transaction qualified for the optimal interchange rate, was downgraded to a higher-cost tier, is exempt from interchange, or encountered an error during qualification.. Valid values are `qualified|downgraded|exempt|error`',
    `qualification_timestamp` TIMESTAMP COMMENT 'Timestamp when the interchange qualification process was executed and the IRF category was determined. Represents the business event time of qualification.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the interchange amount is settled between acquiring and issuing banks.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled and interchange fees were calculated and transferred between acquiring and issuing banks. Delayed settlement can result in interchange downgrades.',
    `three_ds_authentication_flag` BOOLEAN COMMENT 'Indicates whether the transaction was authenticated using 3-D Secure protocol (Verified by Visa, Mastercard SecureCode). 3DS authentication is a qualifying criterion for e-commerce interchange optimization.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross transaction amount on which the interchange fee was calculated. Expressed in the transaction currency before any currency conversion.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the original transaction amount. May differ from settlement currency if cross-border transaction.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange qualification record was last modified. Audit field for data lineage and compliance tracking.',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Transactional record of the interchange rate qualification outcome for each cleared transaction. Captures the transaction reference, qualified IRF category, rate applied, interchange amount calculated, downgrade reason (if applicable), qualifying criteria met (EMV, AVS, MCC, card-present flag), scheme identifier, and settlement currency. Feeds cost-of-acceptance reporting and revenue recognition.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`billing` (
    `billing_id` BIGINT COMMENT 'Unique identifier for the interchange billing record. Primary key for this entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Billing statements require linking the acquiring bank to its legal entity for settlement and regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Billing entries require employee approval for audit and reconciliation; linking to employee enables traceability in financial controls.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Billing aggregation uses scheme identifier to pull scheme‑specific fee rules.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank (merchants bank) in the interchange billing transaction.',
    `financial_institution_id` BIGINT COMMENT 'Identifier of the issuing bank (cardholders bank) in the interchange billing transaction.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC classification is essential for billing adjustments and cross‑border fee calculations.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Billing statements must reference the FX rate applied to net settlement amounts for cross‑border billing reconciliation.',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Interchange billing records are associated with a scheme invoice; adds scheme_invoice_id FK',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Transaction type drives billing logic for fee assessment and compliance.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments applied to the interchange billing, including chargebacks, representments, or billing corrections from prior periods.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this interchange billing record was approved for settlement.',
    `billing_status` STRING COMMENT 'Current lifecycle status of the interchange billing record indicating its processing state. [ENUM-REF-CANDIDATE: DRAFT|PENDING|BILLED|SETTLED|DISPUTED|ADJUSTED|CANCELLED — 7 candidates stripped; promote to reference product]',
    `bin` STRING COMMENT 'The Bank Identification Number or Issuer Identification Number (IIN) that identifies the issuing institution for the card transactions in this billing period.. Valid values are `^[0-9]{6,8}$`',
    `card_present_flag` BOOLEAN COMMENT 'Indicates whether the transactions in this billing were predominantly card-present (POS) or card-not-present (CNP) transactions, affecting interchange rates.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this interchange billing record was first created in the system.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether this billing includes cross-border transactions where the acquiring and issuing banks are in different countries, typically subject to higher interchange rates.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the interchange billing amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `cycle_identifier` STRING COMMENT 'A code or identifier representing the billing cycle frequency and sequence (e.g., monthly, weekly) for this interchange billing.',
    `discrepancy_amount` DECIMAL(18,2) COMMENT 'The monetary difference identified during reconciliation between the billed amount and expected amount, if any.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether this interchange billing is subject to Durbin Amendment interchange fee caps for regulated debit card transactions.',
    `gl_posting_date` DATE COMMENT 'The date on which this interchange billing transaction was posted to the General Ledger in the ERP system.',
    `gross_interchange_amount` DECIMAL(18,2) COMMENT 'The total gross Interchange Reimbursement Fee (IRF) amount before any deductions or adjustments for the billing period.',
    `interchange_qualification_tier` STRING COMMENT 'The interchange rate qualification tier applied to the transactions in this billing, determining the applicable IRF rate structure.. Valid values are `QUALIFIED|MID_QUALIFIED|NON_QUALIFIED|ENHANCED|STANDARD|PREMIUM`',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'The final net amount to be settled between acquirer and issuer after all fees, adjustments, and deductions. This is the amount billed or credited.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this interchange billing record, including explanations for adjustments or discrepancies.',
    `period_end_date` DATE COMMENT 'The end date of the billing period for which interchange fees are calculated and billed.',
    `period_start_date` DATE COMMENT 'The start date of the billing period for which interchange fees are calculated and billed.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process comparing this billing record against the card schemes invoice and internal transaction records.. Valid values are `NOT_STARTED|IN_PROGRESS|RECONCILED|DISCREPANCY|ESCALATED`',
    `reference_number` STRING COMMENT 'External reference number or invoice number assigned by the card scheme or billing system for reconciliation purposes.',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which the interchange revenue or expense is recognized in the financial statements.',
    `scheme_fee_amount` DECIMAL(18,2) COMMENT 'The total card scheme fees (network fees, assessment fees) deducted from the gross interchange amount.',
    `settlement_date` DATE COMMENT 'The date on which the net settlement amount is scheduled to be transferred between the acquiring and issuing banks.',
    `total_transaction_count` BIGINT COMMENT 'The total number of transactions included in this interchange billing record for the specified period and parties.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this interchange billing record was last modified or updated.',
    CONSTRAINT pk_billing PRIMARY KEY(`billing_id`)
) COMMENT 'Periodic interchange billing record representing the net interchange amount billed or credited between acquirer and issuer for a settlement period. Captures billing period, scheme identifier, acquiring bank, issuing bank, total transaction count, gross interchange amount, scheme fee deductions, net settlement amount, currency, and billing status. Supports reconciliation against scheme invoices.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` (
    `cost_of_acceptance_id` BIGINT COMMENT 'Unique identifier for the cost of acceptance record.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant for whom this cost of acceptance is calculated.',
    `msf_schedule_id` BIGINT COMMENT 'Foreign key linking to interchange.msf_schedule. Business justification: cost_of_acceptance aggregates fees for a merchant schedule; adds msf_schedule_id FK',
    `accounting_period_id` BIGINT COMMENT 'Reference to the settlement period during which these costs were incurred.',
    `approved_by` STRING COMMENT 'Identifier of the user or system that approved the cost of acceptance calculation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost of acceptance record was approved for finalization.',
    `average_ticket_size` DECIMAL(18,2) COMMENT 'Average transaction amount calculated as gross transaction volume divided by transaction count.',
    `bin_range_count` STRING COMMENT 'Number of distinct Bank Identification Number (BIN) or Issuer Identification Number (IIN) ranges represented in the transactions for this settlement period.',
    `calculation_date` DATE COMMENT 'The date on which the cost of acceptance calculation was performed.',
    `calculation_method` STRING COMMENT 'The pricing model or calculation method used to determine the cost of acceptance for this merchant.. Valid values are `standard|blended|interchange_plus|tiered|custom`',
    `card_not_present_volume` DECIMAL(18,2) COMMENT 'Total transaction volume for card-not-present (CNP) transactions processed via e-commerce, mail order, or telephone order channels.',
    `card_present_volume` DECIMAL(18,2) COMMENT 'Total transaction volume for card-present (CP) transactions processed via Point of Sale (POS) or mobile Point of Sale (mPOS) terminals.',
    `chargeback_volume` DECIMAL(18,2) COMMENT 'Total transaction volume associated with chargebacks initiated during the settlement period, impacting net margin calculations.',
    `cost_of_acceptance_status` STRING COMMENT 'Current lifecycle status of the cost of acceptance record indicating its processing state.. Valid values are `draft|calculated|approved|finalized|disputed|adjusted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost of acceptance record was first created in the system.',
    `credit_card_volume` DECIMAL(18,2) COMMENT 'Total transaction volume processed using credit cards during the settlement period.',
    `cross_border_volume` DECIMAL(18,2) COMMENT 'Total transaction volume for cross-border transactions where the issuing bank country differs from the acquiring bank country.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the cost of acceptance is denominated.. Valid values are `^[A-Z]{3}$`',
    `debit_card_volume` DECIMAL(18,2) COMMENT 'Total transaction volume processed using debit cards during the settlement period.',
    `domestic_volume` DECIMAL(18,2) COMMENT 'Total transaction volume for domestic transactions where the issuing bank and acquiring bank are in the same country.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the merchant transactions are subject to Durbin Amendment interchange rate caps (True) or exempt (False).',
    `effective_rate_bps` DECIMAL(18,2) COMMENT 'Effective cost of acceptance rate expressed in basis points (bps), calculated as (total cost / gross transaction volume) * 10000.',
    `gross_transaction_volume` DECIMAL(18,2) COMMENT 'Total Payment Volume (TPV) representing the gross value of all transactions processed during the settlement period before any fees or deductions.',
    `interchange_qualification_tier` STRING COMMENT 'The interchange qualification tier applied to the majority of transactions in this settlement period, determining the IRF rate structure.. Valid values are `qualified|mid_qualified|non_qualified|durbin_exempt|durbin_regulated`',
    `mcc` STRING COMMENT 'Four-digit Merchant Category Code (MCC) classifying the merchants business type, which influences interchange qualification and rates.. Valid values are `^[0-9]{4}$`',
    `mdr_percentage` DECIMAL(18,2) COMMENT 'Merchant Discount Rate (MDR) percentage applied to the merchant for this settlement period, representing the total fee as a percentage of transaction volume.',
    `net_margin` DECIMAL(18,2) COMMENT 'Net margin calculated as total MSF revenue minus total interchange cost and total scheme fees, representing the acquiring portfolio profitability.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the cost of acceptance calculation, adjustments, or special circumstances.',
    `refund_volume` DECIMAL(18,2) COMMENT 'Total transaction volume associated with refunds processed during the settlement period.',
    `settlement_end_date` DATE COMMENT 'The end date of the settlement period covered by this cost of acceptance record.',
    `settlement_start_date` DATE COMMENT 'The start date of the settlement period covered by this cost of acceptance record.',
    `total_interchange_cost` DECIMAL(18,2) COMMENT 'Total Interchange Reimbursement Fee (IRF) paid to issuing banks for all transactions during the settlement period.',
    `total_msf_revenue` DECIMAL(18,2) COMMENT 'Total Merchant Service Fee (MSF) revenue collected from the merchant for payment processing services during the settlement period.',
    `total_scheme_fees` DECIMAL(18,2) COMMENT 'Total assessment fees charged by card schemes (Visa, Mastercard, etc.) for network usage during the settlement period.',
    `transaction_count` BIGINT COMMENT 'Total number of transactions processed for the merchant during the settlement period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost of acceptance record was last modified.',
    CONSTRAINT pk_cost_of_acceptance PRIMARY KEY(`cost_of_acceptance_id`)
) COMMENT 'Calculated cost-of-acceptance record per merchant per settlement period, aggregating interchange fees, scheme assessment fees, and MSF components to derive the total payment acceptance cost. Stores gross transaction volume (TPV), total interchange cost, total scheme fees, total MSF revenue, net margin, effective rate (basis points), and period identifiers. Supports acquiring portfolio profitability analysis.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`downgrade` (
    `downgrade_id` BIGINT COMMENT 'Unique identifier for the interchange downgrade event.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: During dispute resolution, downgrade details are needed to assess cost impact; linking downgrade to dispute case enables that process.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: interchange_downgrade references both original and downgraded IRF categories; adds irf_rate_category_id FK',
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant whose transaction was downgraded.',
    `risk_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_case. Business justification: Each downgrade may trigger a risk investigation; linking allows auditors to trace downgrade to its risk case.',
    `transaction_id` BIGINT COMMENT 'Reference to the transaction that experienced the interchange downgrade.',
    `acquirer_reference_data` STRING COMMENT 'Additional reference data provided by the acquiring bank for tracking and reconciliation purposes.',
    `arn` STRING COMMENT 'Unique 23-digit reference number assigned by the acquiring bank to track the transaction across the payment network.. Valid values are `^[0-9]{23}$`',
    `authorization_timestamp` TIMESTAMP COMMENT 'The precise date and time when the transaction was authorized by the issuing bank.',
    `avs_response_code` STRING COMMENT 'Code returned by the issuer indicating the result of address verification, which is often required for optimal interchange qualification.. Valid values are `^[A-Z0-9]{1,2}$`',
    `bin` STRING COMMENT 'First 6-8 digits of the card number identifying the issuing bank and card product type.. Valid values are `^[0-9]{6,8}$`',
    `capture_timestamp` TIMESTAMP COMMENT 'The precise date and time when the authorized transaction was captured for settlement.',
    `card_present_indicator` BOOLEAN COMMENT 'Flag indicating whether the transaction was card-present (true) or card-not-present (false), which affects interchange qualification.',
    `card_scheme` STRING COMMENT 'Payment network brand that processed the transaction and applied the downgrade.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_tier` STRING COMMENT 'The card product tier or level (e.g., standard, rewards, premium, corporate) which influences interchange rates.',
    `card_type` STRING COMMENT 'Classification of the payment card used in the transaction, which determines applicable interchange rate tables.. Valid values are `credit|debit|prepaid|commercial|purchasing`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this downgrade record was first created in the data platform.',
    `cvv_response_code` STRING COMMENT 'Code returned by the issuer indicating the result of CVV verification, which is often required for optimal interchange qualification in card-not-present transactions.. Valid values are `^[A-Z]{1}$`',
    `detected_timestamp` TIMESTAMP COMMENT 'The date and time when the interchange downgrade was identified and recorded in the system.',
    `downgraded_irf_rate_bps` DECIMAL(18,2) COMMENT 'The actual interchange rate in basis points applied after the downgrade, representing a higher cost to the merchant.',
    `durbin_regulated_indicator` BOOLEAN COMMENT 'Flag indicating whether the transaction is subject to Durbin Amendment interchange rate caps for regulated debit cards.',
    `emv_chip_transaction` BOOLEAN COMMENT 'Flag indicating whether the transaction used EMV chip technology, which typically qualifies for lower interchange rates.',
    `incremental_cost_amount` DECIMAL(18,2) COMMENT 'The additional interchange fee cost incurred by the merchant due to the downgrade, calculated as the rate differential applied to the transaction amount.',
    `incremental_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the incremental cost amount.. Valid values are `^[A-Z]{3}$`',
    `mcc` STRING COMMENT 'Four-digit code classifying the merchants type of business, which influences interchange qualification rules.. Valid values are `^[0-9]{4}$`',
    `merchant_processing_channel` STRING COMMENT 'The channel through which the transaction was processed, affecting interchange qualification criteria.. Valid values are `pos|ecommerce|moto|recurring|mobile`',
    `original_irf_rate_bps` DECIMAL(18,2) COMMENT 'The optimal interchange rate in basis points that would have applied if the transaction had not been downgraded.',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the downgrade could have been prevented through merchant action or system configuration changes.',
    `rate_differential_bps` DECIMAL(18,2) COMMENT 'The difference in basis points between the downgraded rate and the original qualified rate, representing the incremental cost penalty.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the interchange downgrade, such as missing AVS data, late settlement, or incomplete transaction data.. Valid values are `^[A-Z0-9]{2,10}$`',
    `reason_description` STRING COMMENT 'Human-readable explanation of why the transaction was downgraded, providing context for merchant coaching and remediation.',
    `remediation_action_recommended` STRING COMMENT 'Suggested corrective action for the merchant to prevent future downgrades of this type, used for merchant coaching and optimization.',
    `settlement_date` DATE COMMENT 'The date on which the transaction was settled and the downgrade was applied during clearing.',
    `settlement_delay_days` STRING COMMENT 'Number of days between authorization and settlement, where excessive delay can trigger interchange downgrades.',
    `three_ds_authentication_status` STRING COMMENT 'Status of 3-D Secure authentication for the transaction, which can affect interchange qualification for e-commerce transactions.. Valid values are `authenticated|attempted|not_authenticated|not_applicable`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross transaction amount in the transaction currency on which the interchange fees are calculated.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The date on which the original transaction was authorized or processed.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this downgrade record was last modified in the data platform.',
    CONSTRAINT pk_downgrade PRIMARY KEY(`downgrade_id`)
) COMMENT 'Records instances where a transaction failed to qualify for the optimal interchange rate category and was downgraded to a higher-cost tier. Captures original qualified category, downgraded-to category, downgrade reason code, rate differential (basis points), incremental cost, merchant identifier, transaction reference, and scheme. Enables downgrade root-cause analysis and merchant coaching.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` (
    `scheme_invoice_id` BIGINT COMMENT 'Unique identifier for the card scheme invoice record. Primary key for the scheme invoice entity.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Invoice generation requires linking to the card scheme for correct fee line items.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for audit trail linking each invoice creation to the responsible employee, needed for PCI DSS and internal compliance reporting.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Regulatory reporting and reconciliation require associating a scheme invoice with the dispute case that challenges its amounts.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Required for GL posting of scheme invoices; financial reporting mandates linking each invoice to its GL account.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Scheme invoices may be issued in various currencies; linking to the FX rate enables accurate accounting and audit of converted totals.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory reporting requires each scheme invoice to reference the governing regulatory obligation for audit and compliance verification.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: Links scheme invoices to the settlement cycle they belong to, supporting regulatory reporting of scheme fees per cycle.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The net amount of credits, refunds, or additional charges applied to this invoice as adjustments from prior billing periods or corrections. Positive values represent additional charges; negative values represent credits.',
    `assessment_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice representing assessment fees charged by the card scheme based on transaction volume or value. Typically calculated as a percentage of Total Payment Volume (TPV) or Gross Merchandise Value (GMV).',
    `billing_period_end_date` DATE COMMENT 'The last date of the billing period covered by this scheme invoice. Defines the end of the time window for which fees and assessments are being charged.',
    `billing_period_start_date` DATE COMMENT 'The first date of the billing period covered by this scheme invoice. Defines the beginning of the time window for which fees and assessments are being charged.',
    `chargeback_processing_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice representing fees charged by the card scheme for processing chargebacks and disputes during the billing period. Includes fees for dispute lifecycle management and arbitration services.',
    `compliance_penalty_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice representing penalties or fines assessed by the card scheme for non-compliance with network rules, PCI DSS requirements, or other regulatory standards. Zero if no penalties were assessed.',
    `cost_center_code` STRING COMMENT 'The cost center or business unit code responsible for this scheme invoice expense. Used for internal cost allocation and management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this scheme invoice record was first created in the system. Used for audit trail and data lineage tracking.',
    `cross_border_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice representing fees charged for cross-border or international transactions where the issuing bank and acquiring bank are in different countries or regions.',
    `dispute_date` DATE COMMENT 'The date on which this invoice was formally disputed with the card scheme. Null if invoice has not been disputed.',
    `dispute_reason_code` STRING COMMENT 'The reason code provided if this invoice is disputed. Indicates the nature of the dispute (e.g., incorrect fee calculation, unrecognized charges, billing error). Null if invoice is not disputed.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the dispute for this invoice was resolved. Null if dispute is still open or if invoice was never disputed.',
    `due_date` DATE COMMENT 'The date by which payment must be received by the card scheme to avoid late fees or penalties. Defines the payment deadline for this invoice.',
    `interchange_reimbursement_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice representing Interchange Reimbursement Fees (IRF) paid between acquiring and issuing banks through the card scheme. This is the fee paid by the acquiring bank to the issuing bank for each transaction.',
    `invoice_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this scheme invoice is denominated. All monetary amounts on this invoice are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'The date on which the card scheme issued this invoice. This is the principal business event timestamp representing when the billing statement was generated and sent.',
    `invoice_document_url` STRING COMMENT 'The URL or file path to the original invoice document (PDF or other format) provided by the card scheme. Used for audit trail and detailed line-item review.',
    `invoice_number` STRING COMMENT 'The externally-known unique invoice number assigned by the card scheme (Visa, Mastercard, Amex, Discover) for this billing statement. This is the business identifier used for reconciliation and payment reference.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the scheme invoice indicating its payment and processing state. Tracks the invoice from issuance through payment completion or dispute resolution.. Valid values are `DRAFT|ISSUED|DISPUTED|PAID|OVERDUE|CANCELLED`',
    `network_participation_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice representing fees charged for participation in the card scheme network. This is a recurring membership or access fee for being part of the payment network.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this scheme invoice, including special instructions, dispute details, or reconciliation observations. Used for operational communication and audit trail.',
    `payment_date` DATE COMMENT 'The actual date on which payment was made to the card scheme for this invoice. Null if invoice remains unpaid.',
    `payment_method` STRING COMMENT 'The payment instrument or method used to settle this scheme invoice. Indicates how the payment was made to the card scheme.. Valid values are `ACH|WIRE|CHECK|DIRECT_DEBIT|CARD`',
    `payment_reference_number` STRING COMMENT 'The unique reference number or transaction identifier for the payment made to settle this invoice. Used for payment reconciliation and audit trail. Null if invoice is unpaid.',
    `reconciliation_reference` STRING COMMENT 'The reference identifier linking this scheme invoice to the internal reconciliation record or general ledger entry. Used to track the invoice through the accounts payable and financial close process.',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation process for this scheme invoice, indicating whether the invoice has been matched to internal transaction records and general ledger entries.. Valid values are `PENDING|MATCHED|UNMATCHED|DISPUTED|RESOLVED`',
    `scheme_service_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice representing fees for specific card scheme services such as tokenization, fraud prevention, dispute resolution, or other value-added services provided by the network.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total amount of taxes (VAT, GST, sales tax, or other applicable taxes) applied to this scheme invoice. Zero if no taxes are applicable.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'The total amount payable to the card scheme for this invoice, representing the sum of all line-item fees, assessments, and charges. This is the net total amount due before any adjustments or credits.',
    `transaction_value` DECIMAL(18,2) COMMENT 'The total monetary value of all transactions processed through the card scheme network during the billing period, expressed in the invoice currency. Represents the Total Payment Volume (TPV) or Gross Merchandise Value (GMV) for fee calculation purposes.',
    `transaction_volume` BIGINT COMMENT 'The total number of transactions processed through the card scheme network during the billing period covered by this invoice. Used to validate volume-based fee calculations.',
    `updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this scheme invoice record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this scheme invoice record was last modified in the system. Used for audit trail and change tracking.',
    CONSTRAINT pk_scheme_invoice PRIMARY KEY(`scheme_invoice_id`)
) COMMENT 'Card scheme invoice record representing the periodic billing statement received from Visa, Mastercard, Amex, or Discover for network participation fees, assessment fees, and scheme services. Captures invoice number, scheme identifier, billing period, invoice date, due date, line-item fee categories, total amount due, currency, payment status, and reconciliation reference. SSOT for scheme payables.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` (
    `scheme_invoice_line_id` BIGINT COMMENT 'Unique identifier for the scheme invoice line item. Primary key for this entity.',
    `approved_by_user_employee_id` BIGINT COMMENT 'User ID of the finance team member who approved this fee line for payment. Null until approval is granted. Used for segregation of duties controls and audit trail.',
    `dispute_case_id` BIGINT COMMENT 'Reference to the dispute case if this fee line is under dispute with the card scheme. Links to the dispute management system for tracking dispute lifecycle, evidence submission, and resolution. Null when no dispute exists.',
    `employee_id` BIGINT COMMENT 'User ID of the finance team member who approved this fee line for payment. Null until approval is granted. Used for segregation of duties controls and audit trail.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Each fee line must be posted to a specific GL account for accurate financial statements and audit trails.',
    `original_invoice_line_scheme_invoice_line_id` BIGINT COMMENT 'Reference to the original scheme_invoice_line_id that this adjustment line is correcting. Null for original fee charges. Used to trace adjustment history and maintain audit trail for billing corrections.',
    `scheme_fee_table_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_fee_table. Business justification: scheme_invoice_line details a fee defined in scheme_fee_table; adds scheme_fee_table_id FK',
    `scheme_invoice_id` BIGINT COMMENT 'Reference to the parent scheme invoice that this line item belongs to. Links line-level detail to the invoice header for reconciliation and aggregation.',
    `adjustment_indicator` BOOLEAN COMMENT 'Indicates whether this line item represents an adjustment or correction to a previously billed fee. True for adjustments, credits, or corrections; false for original fee charges. Used to track billing accuracy and dispute resolution.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for an adjustment when adjustment_indicator is true. Examples include billing error correction, rate change retroactive application, volume correction, or dispute resolution credit. Null for non-adjustment lines.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this fee line was approved for payment by the finance team. Null until approval is granted. Used for payment processing workflow and SOX audit trail.',
    `authorization_method` STRING COMMENT 'Method by which transactions were authorized. EMV chip, contactless NFC, magnetic stripe, manual key entry, ecommerce, recurring billing, or mail-order/telephone-order (MOTO). Interchange rates and fraud liability vary by authorization method. [ENUM-REF-CANDIDATE: chip|contactless|magnetic_stripe|manual|ecommerce|recurring|moto — 7 candidates stripped; promote to reference product]',
    `billing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which this fee is billed. All monetary amounts on this line (transaction_value_basis, fee_amount) are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `bin_range_high` STRING COMMENT 'Upper bound of the BIN or IIN range that this fee line applies to. Used in conjunction with bin_range_low to define the card portfolio segment for this fee calculation.. Valid values are `^[0-9]{6,8}$`',
    `bin_range_low` STRING COMMENT 'Lower bound of the BIN or IIN (Issuer Identification Number) range that this fee line applies to. Used for BIN-level interchange qualification and fee segmentation. First 6-8 digits of the card number identifying the issuing bank.. Valid values are `^[0-9]{6,8}$`',
    `card_product_type` STRING COMMENT 'Classification of the card product that this fee applies to. Interchange rates and scheme fees vary significantly by card product type. Examples include consumer credit, consumer debit, commercial cards, and premium card tiers. [ENUM-REF-CANDIDATE: credit|debit|prepaid|commercial|rewards|signature|platinum|world|world_elite — 9 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Internal cost center or business unit code for allocating this fee expense. Used for management accounting, profitability analysis, and internal chargeback to business lines or product portfolios.. Valid values are `^[A-Z0-9]{3,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this scheme invoice line record was first created in the system. Used for audit trail and data lineage tracking.',
    `cross_border_indicator` BOOLEAN COMMENT 'Indicates whether this fee line applies to cross-border transactions (issuer and acquirer in different countries). Cross-border transactions typically incur additional scheme fees and higher interchange rates.',
    `durbin_regulated_indicator` BOOLEAN COMMENT 'Indicates whether this fee line applies to transactions subject to Durbin Amendment interchange caps (US Regulation II). Durbin-regulated debit transactions from large issuers have capped interchange rates. Critical for US market compliance and revenue recognition.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert settlement_currency_code amounts to billing_currency_code amounts. Null when billing and settlement currencies are the same. Used for cross-border fee reconciliation and dynamic currency conversion (DCC) scenarios.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Calculated fee amount for this line item in the billing currency. Represents the actual charge from the card scheme for this specific fee component. This is the primary financial value used for reconciliation and accounts payable processing.',
    `fee_category` STRING COMMENT 'High-level classification of the fee for reporting and cost allocation. Groups related fee types into business-meaningful categories for financial analysis and revenue recognition. [ENUM-REF-CANDIDATE: interchange|assessment|network|authorization|cross_border|chargeback|dispute|service|other — 9 candidates stripped; promote to reference product]',
    `fee_description` STRING COMMENT 'Human-readable description of the fee type and its business purpose. Provides context for the fee_type_code, explaining what service or transaction activity triggered this charge.',
    `fee_rate` DECIMAL(18,2) COMMENT 'The rate applied to calculate this fee. May represent a percentage (e.g., 0.015 for 1.5%), a per-transaction amount, or a tiered rate depending on fee_rate_type. Used in conjunction with transaction_volume_basis or transaction_value_basis to compute fee_amount.',
    `fee_rate_type` STRING COMMENT 'Indicates how the fee_rate should be interpreted and applied. Percentage rates are applied to transaction_value_basis, per-transaction rates are multiplied by transaction_volume_basis, tiered rates vary by volume thresholds, flat rates are fixed amounts, and basis points represent hundredths of a percent.. Valid values are `percentage|per_transaction|tiered|flat|basis_points`',
    `fee_type_code` STRING COMMENT 'Card scheme-specific code identifying the type of fee being charged. Examples include interchange reimbursement fees (IRF), assessment fees, network fees, authorization fees, cross-border fees, and scheme service fees. Aligns with Visa and Mastercard fee code taxonomies.. Valid values are `^[A-Z0-9]{2,10}$`',
    `interchange_qualification_tier` STRING COMMENT 'Specific interchange qualification tier or program that this fee line is associated with. Examples include CPS/Retail, CPS/Card Not Present, EIRF, Standard, or scheme-specific tier names. Determines the applicable interchange reimbursement fee (IRF) rate.',
    `line_number` STRING COMMENT 'Sequential line number within the parent scheme invoice. Used for ordering and referencing specific line items in reconciliation and dispute processes.',
    `merchant_category_code` STRING COMMENT 'Four-digit ISO 18245 code classifying the type of merchant or business where transactions occurred. Interchange qualification and fee structures often vary by MCC. Used for industry-specific fee segmentation.. Valid values are `^[0-9]{4}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or context about this fee line. Used by finance and operations teams to document unusual circumstances, reconciliation findings, or dispute rationale.',
    `payment_reference_number` STRING COMMENT 'Reference number of the payment transaction used to settle this fee line with the card scheme. Links to accounts payable payment records and bank statements. Null until payment is executed.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process for this fee line. Tracks whether the scheme-billed fee has been matched against internal transaction records, whether variances exist, and whether the line has been approved for payment.. Valid values are `pending|matched|variance|disputed|approved|rejected`',
    `service_period_end_date` DATE COMMENT 'End date of the service period that this fee line covers. Defines the end of the transaction activity window used to calculate this fee. Used for period-based reconciliation and revenue recognition cutoff.',
    `service_period_start_date` DATE COMMENT 'Start date of the service period that this fee line covers. Defines the beginning of the transaction activity window used to calculate this fee. Used for period-based reconciliation and accrual accounting.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the underlying transactions were settled. May differ from billing_currency_code when cross-border or multi-currency processing is involved.. Valid values are `^[A-Z]{3}$`',
    `transaction_type` STRING COMMENT 'Type of transaction activity that generated this fee. Different transaction types may incur different fee structures and rates. Critical for accurate fee reconciliation and revenue recognition. [ENUM-REF-CANDIDATE: purchase|cash_advance|refund|reversal|chargeback|fee|adjustment — 7 candidates stripped; promote to reference product]',
    `transaction_value_basis` DECIMAL(18,2) COMMENT 'Total monetary value of transactions that this fee line is calculated against. Represents the dollar volume basis used for percentage-based fee calculations. Expressed in the billing currency.',
    `transaction_volume_basis` BIGINT COMMENT 'Number of transactions or events that this fee line is calculated against. Represents the volume basis (transaction count, authorization count, or other countable unit) used to compute the fee amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this scheme invoice line record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between the scheme-billed fee_amount and the internally calculated expected fee amount. Positive values indicate overbilling, negative values indicate underbilling. Null when reconciliation_status is matched. Used for dispute initiation and billing accuracy monitoring.',
    CONSTRAINT pk_scheme_invoice_line PRIMARY KEY(`scheme_invoice_line_id`)
) COMMENT 'Line-item detail of a card scheme invoice, breaking down each fee component billed by the scheme. Captures fee type code, fee description, transaction volume basis, rate applied, calculated amount, currency, and the parent scheme invoice reference. Enables granular reconciliation of scheme fees against internal transaction volumes and interchange qualification records.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` (
    `revenue_recognition_entry_id` BIGINT COMMENT 'Unique identifier for the revenue recognition entry. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Cost‑center allocation is required for internal reporting and profitability analysis of recognized revenue.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner entity with whom revenue is shared for this entry (null if no revenue sharing applies).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Revenue recognition entries need a GL account reference for journal posting and revenue reporting.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant for whom revenue is being recognized. Links to the merchant master entity.',
    `original_entry_revenue_recognition_entry_id` BIGINT COMMENT 'Identifier of the original revenue recognition entry if this entry is an adjustment or reversal (null for original entries).',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Revenue recognition entries need the FX rate used to translate fees into the reporting currency for GAAP/IFRS compliance.',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Revenue recognition entries are tied to a specific scheme invoice; adds scheme_invoice_id FK',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch that generated this revenue recognition entry.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Connects revenue recognition entries to the master settlement record for consolidated financial reporting and GL posting.',
    `accounting_period` STRING COMMENT 'The accounting period (YYYY-MM format) to which this revenue recognition entry is posted.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `adjustment_description` STRING COMMENT 'Free-text description providing additional context for any adjustment or reversal applied to this entry.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for any adjustment or reversal applied to this revenue recognition entry (null if no adjustment).. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition entry record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the revenue amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'The portion of gross revenue that is deferred to future periods under revenue recognition rules.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this revenue entry is subject to Durbin Amendment interchange rate caps (applies to regulated debit card transactions).',
    `erp_batch_reference` STRING COMMENT 'The batch identifier in the ERP system (Oracle Financials) to which this revenue recognition entry was posted.. Valid values are `^[A-Z0-9]{6,20}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross revenue amount before any deferrals or adjustments.',
    `interchange_rate_applied` DECIMAL(18,2) COMMENT 'The effective interchange rate (as a decimal) applied to calculate the interchange income component of this entry.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition entry record was last modified or updated.',
    `mdr_rate_applied` DECIMAL(18,2) COMMENT 'The effective Merchant Discount Rate (as a decimal) applied to calculate the MSF income component of this entry.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'The net revenue amount after deducting scheme fees and other pass-through costs from recognized revenue.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context or audit trail information for this revenue recognition entry.',
    `posted_to_gl_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition entry was posted to the General Ledger system.',
    `product_line_code` STRING COMMENT 'Code representing the product line or service category for which revenue is recognized (e.g., acquiring, issuing, gateway services).. Valid values are `^[A-Z0-9]{2,10}$`',
    `recognition_date` DATE COMMENT 'The date on which the revenue is recognized in accordance with ASC 606 revenue recognition principles.',
    `recognition_status` STRING COMMENT 'Current status of the revenue recognition entry in the accounting workflow: pending, recognized, adjusted, reversed, or finalized.. Valid values are `pending|recognized|adjusted|reversed|finalized`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The net revenue amount recognized in the current period (gross_amount minus deferred_amount).',
    `revenue_share_amount` DECIMAL(18,2) COMMENT 'The absolute revenue amount shared with the partner, calculated from recognized_amount and revenue_share_percentage.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of recognized revenue shared with the partner (as a decimal, e.g., 0.1500 for 15%).',
    `revenue_type` STRING COMMENT 'Classification of the revenue type being recognized: interchange income, Merchant Service Fee (MSF) income, scheme fee pass-through, gateway fee, processing fee, or other.. Valid values are `interchange_income|msf_income|scheme_fee_passthrough|gateway_fee|processing_fee|other`',
    `scheme_fee_amount` DECIMAL(18,2) COMMENT 'The card scheme fee amount (Visa, Mastercard, etc.) passed through or absorbed in this revenue recognition entry.',
    `settlement_period_end_date` DATE COMMENT 'The end date of the settlement period for which revenue is being recognized.',
    `settlement_period_start_date` DATE COMMENT 'The start date of the settlement period for which revenue is being recognized.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this entry has passed SOX compliance controls and internal audit checks.',
    `transaction_count` BIGINT COMMENT 'The number of transactions that contributed to this revenue recognition entry within the settlement period.',
    CONSTRAINT pk_revenue_recognition_entry PRIMARY KEY(`revenue_recognition_entry_id`)
) COMMENT 'Revenue recognition entry capturing the recognized interchange and MSF revenue for each settlement period per merchant and product line. Stores recognition date, revenue type (interchange income, MSF income, scheme fee pass-through), gross amount, deferred amount, recognized amount, accounting period, GL account code, and cost center. Supports SOX-compliant revenue recognition under ASC 606.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`rate_history` (
    `rate_history_id` BIGINT COMMENT 'Unique identifier for each interchange rate history record. Primary key for the interchange rate history audit trail.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Interchange rate history is tracked per currency pair to support multi‑currency pricing analysis and audit.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: interchange_rate_history records changes to an IRF category; adds irf_rate_category_id FK',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Rate changes are subject to regulatory approval; the FK ties each rate history record to the applicable regulatory obligation.',
    `scheme_id` BIGINT COMMENT 'Identifier of the card scheme (Visa, Mastercard, etc.) that published this rate change.',
    `superseded_by_history_rate_history_id` BIGINT COMMENT 'Reference to the interchange_rate_history_id that superseded this rate record. Null if this is the current active rate.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this rate change to internal audit logs, compliance documentation, or regulatory filing records.',
    `card_brand` STRING COMMENT 'The specific card brand or sub-brand this rate applies to (e.g., Visa Signature, Mastercard World Elite).',
    `card_present_flag` BOOLEAN COMMENT 'Indicates whether this rate applies to card-present transactions (True) or card-not-present transactions (False).',
    `card_product_type` STRING COMMENT 'The type of card product this rate applies to (credit, debit, prepaid, commercial, purchasing).. Valid values are `CREDIT|DEBIT|PREPAID|COMMERCIAL|PURCHASING`',
    `change_reason_code` STRING COMMENT 'Coded reason for the interchange rate change (e.g., annual review, regulatory mandate, market adjustment).. Valid values are `ANNUAL_REVIEW|REGULATORY|MARKET_ADJUSTMENT|PRODUCT_LAUNCH|PROGRAM_UPDATE|CORRECTION`',
    `change_reason_description` STRING COMMENT 'Detailed explanation of why the interchange rate was changed, as provided by the card scheme.',
    `contactless_eligible_flag` BOOLEAN COMMENT 'Indicates whether contactless (NFC) transactions are eligible for this interchange rate (True) or not (False).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this interchange rate applies (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange rate history record was first created in the system. Used for audit trail and data lineage.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether this rate applies to cross-border transactions (True) or domestic transactions (False).',
    `durbin_cap_amount` DECIMAL(18,2) COMMENT 'The maximum interchange fee allowed under Durbin Amendment regulations for this rate category. Null if not Durbin-regulated.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether this rate is subject to Durbin Amendment debit interchange caps (True) or exempt (False).',
    `effective_date` DATE COMMENT 'The date on which the new interchange rate became effective. Used for point-in-time rate lookups and transaction repricing.',
    `emv_chip_required_flag` BOOLEAN COMMENT 'Indicates whether EMV chip authentication is required to qualify for this interchange rate (True) or not (False).',
    `expiry_date` DATE COMMENT 'The date on which this interchange rate expires or is superseded by a new rate. Null if the rate is currently active with no known end date.',
    `installment_eligible_flag` BOOLEAN COMMENT 'Indicates whether installment payment transactions are eligible for this interchange rate (True) or not (False).',
    `irf_category_name` STRING COMMENT 'Human-readable name of the interchange category (e.g., Card Present Retail, Card Not Present E-commerce).',
    `mcc_list` STRING COMMENT 'Comma-separated list of four-digit MCC codes that this rate applies to or excludes, depending on the restriction type.',
    `mcc_restriction_type` STRING COMMENT 'Indicates whether the MCC list is inclusive (rate applies only to listed MCCs), exclusive (rate applies to all except listed MCCs), or none (no MCC restrictions).. Valid values are `INCLUSIVE|EXCLUSIVE|NONE`',
    `new_fixed_fee` DECIMAL(18,2) COMMENT 'The new fixed interchange fee amount that became effective with this change. Expressed in the rate currency.',
    `new_rate_percent` DECIMAL(18,2) COMMENT 'The new interchange rate percentage that became effective with this change. Used for forward-looking rate calculations.',
    `prior_fixed_fee` DECIMAL(18,2) COMMENT 'The fixed interchange fee amount that was in effect before this change. Expressed in the rate currency.',
    `prior_rate_percent` DECIMAL(18,2) COMMENT 'The interchange rate percentage that was in effect before this change. Used for historical comparison and back-billing corrections.',
    `publication_date` DATE COMMENT 'The date on which the card scheme published or announced this rate change.',
    `publication_reference` STRING COMMENT 'Reference to the source publication or bulletin where this rate change was announced (e.g., Visa April 2024 Bulletin, Mastercard Q2 2024 Rate Update).',
    `rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the interchange rate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `rate_status` STRING COMMENT 'Current lifecycle status of this interchange rate record (active, expired, superseded by newer rate, pending future effective date).. Valid values are `ACTIVE|EXPIRED|SUPERSEDED|PENDING`',
    `recurring_eligible_flag` BOOLEAN COMMENT 'Indicates whether recurring payment transactions are eligible for this interchange rate (True) or not (False).',
    `region_code` STRING COMMENT 'Geographic region code where this interchange rate applies (e.g., EMEA, APAC, LATAM). Used for multi-country rate structures.',
    `three_ds_required_flag` BOOLEAN COMMENT 'Indicates whether 3-D Secure authentication is required to qualify for this interchange rate (True) or not (False).',
    `tokenization_eligible_flag` BOOLEAN COMMENT 'Indicates whether tokenized transactions are eligible for this interchange rate (True) or not (False).',
    `transaction_max_amount` DECIMAL(18,2) COMMENT 'The maximum transaction amount allowed to qualify for this interchange rate. Null if no maximum applies.',
    `transaction_min_amount` DECIMAL(18,2) COMMENT 'The minimum transaction amount required to qualify for this interchange rate. Null if no minimum applies.',
    `transaction_type` STRING COMMENT 'The type of transaction this interchange rate applies to (purchase, cash advance, balance transfer, refund).. Valid values are `PURCHASE|CASH_ADVANCE|BALANCE_TRANSFER|REFUND`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange rate history record was last modified. Used for audit trail and change tracking.',
    `version_number` STRING COMMENT 'Sequential version number for this rate category, incremented with each rate change. Used for audit trail and version control.',
    CONSTRAINT pk_rate_history PRIMARY KEY(`rate_history_id`)
) COMMENT 'Historical audit trail of interchange rate changes published by card schemes, capturing prior rate, new rate, effective date, expiry date, scheme identifier, rate category code, change reason, and the source publication reference (e.g., Visa April bulletin). Enables point-in-time rate lookups for dispute resolution, back-billing corrections, and regulatory audit.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` (
    `mcc_interchange_map_id` BIGINT COMMENT 'Unique identifier for the MCC interchange mapping record. Primary key for the table.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: mcc_interchange_map references IRF category; adds irf_rate_category_id FK',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: Mapping table must reference canonical MCC records for accurate rate look‑ups.',
    `scheme_id` BIGINT COMMENT 'Identifier for the card scheme (network brand) to which this MCC interchange mapping applies. Links to the card scheme reference data.',
    `superseded_by_map_mcc_interchange_map_id` BIGINT COMMENT 'Reference to the mcc_interchange_map_id of the newer mapping record that replaces this one. Null if this is the current active version.',
    `card_not_present_eligible` BOOLEAN COMMENT 'Indicates whether this MCC interchange mapping applies to card-not-present (CNP) transactions such as e-commerce, mail order, or telephone order. True if eligible, False otherwise.',
    `card_present_eligible` BOOLEAN COMMENT 'Indicates whether this MCC interchange mapping applies to card-present (CP) transactions at physical point-of-sale terminals. True if eligible, False otherwise.',
    `contactless_eligible` BOOLEAN COMMENT 'Indicates whether contactless (NFC/tap-to-pay) transactions with this MCC are eligible for the mapped interchange rate. True if eligible, False otherwise.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the geographic market or jurisdiction for which this MCC interchange mapping applies (e.g., USA, GBR, DEU). Null if globally applicable.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MCC interchange mapping record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `cross_border_eligible` BOOLEAN COMMENT 'Indicates whether cross-border transactions (where issuer and acquirer are in different countries) with this MCC are eligible for the mapped interchange rate. True if eligible, False otherwise.',
    `data_quality_indicator` STRING COMMENT 'Indicator of the data quality and verification status of this MCC interchange mapping record. Verified records have been validated against official scheme documentation.. Valid values are `Verified|Unverified|Pending Review|Deprecated`',
    `durbin_compliance_tier` STRING COMMENT 'Classification tier for Durbin Amendment compliance indicating whether the MCC qualifies for exemptions, small issuer treatment, or full regulation.. Valid values are `Exempt|Small Issuer|Regulated|Not Applicable`',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether transactions with this MCC are subject to Durbin Amendment interchange rate caps for regulated debit cards (US market). True if regulated, False otherwise.',
    `effective_end_date` DATE COMMENT 'Date on which this MCC interchange mapping ceases to be active. Null if the mapping is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'Date from which this MCC interchange mapping becomes active and applicable to transactions. Part of the temporal validity range.',
    `emv_chip_required` BOOLEAN COMMENT 'Indicates whether EMV chip authentication is required for transactions with this MCC to qualify for the mapped interchange rate. True if required, False otherwise.',
    `installment_eligible` BOOLEAN COMMENT 'Indicates whether installment payment transactions with this MCC are eligible for the mapped interchange rate. True if eligible, False otherwise.',
    `interchange_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the interchange fixed fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `interchange_fixed_fee` DECIMAL(18,2) COMMENT 'Fixed per-transaction fee component of the interchange fee applicable to this MCC and scheme combination, in the base currency.',
    `interchange_rate_percent` DECIMAL(18,2) COMMENT 'Base percentage rate component of the interchange fee applicable to this MCC and scheme combination. Expressed as a decimal (e.g., 0.0175 for 1.75%).',
    `mapping_status` STRING COMMENT 'Current lifecycle status of the MCC interchange mapping record. Active mappings are used for transaction qualification; Superseded mappings have been replaced by newer versions.. Valid values are `Active|Inactive|Pending|Superseded|Deprecated`',
    `merchant_pricing_impact` STRING COMMENT 'Classification of the pricing impact this MCC interchange mapping has on merchant discount rate (MDR) configuration. Indicates whether the MCC qualifies for standard, reduced, premium, or penalty pricing.. Valid values are `Standard|Reduced|Premium|Penalty`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this MCC interchange mapping. May include scheme rule references, pricing rationale, or implementation guidance.',
    `recurring_eligible` BOOLEAN COMMENT 'Indicates whether recurring or subscription-based transactions with this MCC are eligible for the mapped interchange rate. True if eligible, False otherwise.',
    `region_code` STRING COMMENT 'Code representing the geographic region or regulatory zone for which this MCC interchange mapping applies (e.g., SEPA, APAC, LATAM). Null if country-specific or globally applicable.',
    `revenue_recognition_category` STRING COMMENT 'Accounting category code used for revenue recognition and general ledger posting of interchange income associated with this MCC. Supports financial reporting and cost-of-acceptance calculations.',
    `scheme_fee_tier` STRING COMMENT 'Tier or category code for scheme assessment fees applicable to this MCC. Used to determine network fees charged by the card scheme.',
    `scheme_program_code` STRING COMMENT 'Code identifying the specific card scheme program or initiative associated with this MCC interchange mapping (e.g., Visa Traditional Rewards, Mastercard World Elite, Small Ticket Interchange).',
    `source_system_reference` STRING COMMENT 'Reference identifier or code from the source system (e.g., Transaction Processing Platform, Merchant Management System) from which this MCC interchange mapping was originally loaded or synchronized.',
    `special_program_eligibility` STRING COMMENT 'Comma-separated list of special interchange programs or rate qualifications this MCC is eligible for (e.g., Supermarket Program, Fuel Program, Utility Program, Government/Education, Emerging Markets).',
    `three_ds_required` BOOLEAN COMMENT 'Indicates whether 3-D Secure authentication is required for card-not-present transactions with this MCC to qualify for the mapped interchange rate. True if required, False otherwise.',
    `tokenization_eligible` BOOLEAN COMMENT 'Indicates whether tokenized payment credentials (DPAN) are eligible for this MCC interchange mapping. True if eligible, False otherwise.',
    `transaction_max_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount threshold for this MCC interchange mapping to apply. Transactions above this amount may qualify for different interchange rates. Null if no maximum applies.',
    `transaction_min_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount threshold for this MCC interchange mapping to apply. Transactions below this amount may qualify for different interchange rates. Null if no minimum applies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this MCC interchange mapping record was last modified. Part of the audit trail for data lineage and compliance.',
    `version_number` STRING COMMENT 'Version number of this MCC interchange mapping record. Incremented when the mapping is updated to reflect scheme rule changes or pricing adjustments.',
    CONSTRAINT pk_mcc_interchange_map PRIMARY KEY(`mcc_interchange_map_id`)
) COMMENT 'Mapping table associating Merchant Category Codes (MCC) to applicable interchange rate programs and scheme fee tiers. Captures MCC code, MCC description, card scheme, applicable IRF category codes, special program eligibility (e.g., supermarket, fuel, utilities), and effective date range. Drives MCC-based interchange qualification logic and merchant pricing configuration.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` (
    `acquiring_portfolio_pricing_id` BIGINT COMMENT 'System‑generated unique identifier for each acquiring portfolio pricing record.',
    `appetite_framework_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite_framework. Business justification: Portfolio pricing rules are governed by the firm’s risk appetite framework; FK provides direct reference for compliance reporting.',
    `durbin_compliance_tier_id` BIGINT COMMENT 'Foreign key linking to interchange.durbin_compliance_tier. Business justification: acquiring_portfolio_pricing may be governed by a Durbin compliance tier; adds durbin_compliance_tier_id FK',
    `portfolio_id` BIGINT COMMENT 'Identifier of the acquiring portfolio to which this pricing configuration applies.',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.interchange_program. Business justification: Acquiring portfolio pricing can be associated with a specific interchange program; adds interchange_program_id FK',
    `scheme_id` BIGINT COMMENT 'Identifier of the card scheme (network) to which the pricing rules apply.',
    `acquiring_portfolio_pricing_description` STRING COMMENT 'Free‑form description of the pricing contract purpose and scope.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this pricing contract require formal approval.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing contract was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the pricing contract.',
    `base_interchange_pass_through_flag` BOOLEAN COMMENT 'Indicates whether the base interchange fee is passed through to the merchant without markup.',
    `compliance_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the latest compliance review for this pricing contract.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the pricing contract.. Valid values are `draft|active|suspended|terminated|pending`',
    `contract_version` STRING COMMENT 'Version number of the pricing contract for change tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for all monetary values in the contract.. Valid values are `^[A-Z]{3}$`',
    `durbin_regulated_flag` BOOLEAN COMMENT 'True if the pricing is subject to the Durbin Amendment regulations.',
    `effective_from` DATE COMMENT 'Date on which the pricing contract becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the pricing contract expires or is superseded (null if open‑ended).',
    `is_default_pricing` BOOLEAN COMMENT 'True if this pricing configuration is the default for the portfolio.',
    `is_portfolio_level` BOOLEAN COMMENT 'Indicates whether the pricing applies at the portfolio level (vs. individual merchant level).',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or performance review of the pricing contract.',
    `markup_basis_points` STRING COMMENT 'Number of basis points added as markup on top of the base interchange rate.',
    `monthly_minimum_amount` DECIMAL(18,2) COMMENT 'Minimum monthly revenue that must be generated under the pricing contract.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the pricing contract.',
    `per_transaction_markup_amount` DECIMAL(18,2) COMMENT 'Flat amount added to each transaction as a markup.',
    `pricing_application_scope` STRING COMMENT 'Scope of transactions to which this pricing configuration applies.. Valid values are `all_transactions|card_present|card_not_present|ecommerce|moto`',
    `pricing_change_reason` STRING COMMENT 'Business reason for the most recent change to the pricing configuration.',
    `pricing_contract_code` STRING COMMENT 'Business‑visible code or reference number for the pricing contract.',
    `pricing_currency_conversion_rate` DECIMAL(18,2) COMMENT 'Conversion rate used when pricing is expressed in a currency different from the settlement currency.',
    `pricing_margin_type` STRING COMMENT 'Indicates whether the margin is expressed as a percentage or a fixed amount.. Valid values are `percentage|fixed_amount`',
    `pricing_margin_value` DECIMAL(18,2) COMMENT 'Numeric value of the margin, interpreted according to pricing_margin_type.',
    `pricing_model_type` STRING COMMENT 'Type of pricing model applied to the portfolio (e.g., interchange‑plus, flat‑rate, tiered, volume‑based).. Valid values are `interchange_plus|flat_rate|tiered|volume_based`',
    `pricing_source_system` STRING COMMENT 'Source system that supplied the pricing configuration.. Valid values are `merchant_mgmt|risk_system|custom|erp`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the pricing configuration complies with applicable regulations (e.g., PCI DSS, PSD2).',
    `review_status` STRING COMMENT 'Current status of the contracts compliance or performance review.. Valid values are `not_reviewed|in_review|approved|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pricing record.',
    `volume_tier_1_markup_basis_points` STRING COMMENT 'Markup in basis points applied when transaction volume reaches tier 1.',
    `volume_tier_1_threshold` STRING COMMENT 'Transaction count threshold for the first volume‑based pricing tier.',
    `volume_tier_2_markup_basis_points` STRING COMMENT 'Markup in basis points applied when transaction volume reaches tier 2.',
    `volume_tier_2_threshold` STRING COMMENT 'Transaction count threshold for the second volume‑based pricing tier.',
    CONSTRAINT pk_acquiring_portfolio_pricing PRIMARY KEY(`acquiring_portfolio_pricing_id`)
) COMMENT 'Acquiring portfolio-level pricing configuration defining the interchange-plus margin, flat-rate, or tiered pricing model applied to a portfolio of merchants managed by an acquirer, ISO, or PayFac. Captures portfolio identifier, pricing model type, base interchange pass-through flag, markup basis points, per-transaction markup, monthly minimum, volume tier thresholds, and contract effective dates.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` (
    `issuer_interchange_income_id` BIGINT COMMENT 'Unique identifier for the issuer interchange income record.',
    `issuer_id` BIGINT COMMENT 'Identifier of the issuing bank or financial institution earning the interchange income.',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Issuer interchange income is reported on a scheme invoice; adds scheme_invoice_id FK',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to interchange income (chargebacks, disputes, corrections, credits).',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the interchange income settlement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the interchange income settlement was approved.',
    `card_brand` STRING COMMENT 'Card scheme or network brand (e.g., Visa, Mastercard, Amex).. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_product_type` STRING COMMENT 'Type of card product for which interchange income is earned (e.g., credit, debit, prepaid, commercial). [ENUM-REF-CANDIDATE: credit|debit|prepaid|commercial|rewards|platinum|signature — 7 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the issuers primary operating jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange income record was first created in the system.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether the interchange income includes cross-border transactions (True if transactions crossed international borders).',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_amount` DECIMAL(18,2) COMMENT 'Amount of discrepancy identified during reconciliation between expected and actual interchange income.',
    `discrepancy_reason_code` STRING COMMENT 'Code indicating the reason for any reconciliation discrepancy (e.g., timing difference, fee mismatch, transaction dispute).',
    `durbin_exempt_reason` STRING COMMENT 'Reason for exemption from Durbin Amendment caps (e.g., small issuer exemption, prepaid exemption).',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether the interchange income is subject to Durbin Amendment interchange rate caps (True for regulated debit cards).',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the interchange income is posted.',
    `gl_posting_date` DATE COMMENT 'Date on which the interchange income was posted to the general ledger.',
    `gross_interchange_earned` DECIMAL(18,2) COMMENT 'Total gross interchange revenue earned by the issuer before any deductions or fees.',
    `interchange_qualification_tier` STRING COMMENT 'Interchange rate tier or category that the transactions qualified for (e.g., standard, enhanced, premium).',
    `issuer_bin` STRING COMMENT 'Bank Identification Number or Issuer Identification Number (IIN) representing the issuers card range.. Valid values are `^[0-9]{6,8}$`',
    `issuer_name` STRING COMMENT 'Legal name of the issuing bank or financial institution.',
    `net_interchange_income` DECIMAL(18,2) COMMENT 'Net interchange income after all scheme fees, processing fees, and adjustments have been deducted from gross interchange.',
    `network_assessment_fee` DECIMAL(18,2) COMMENT 'Assessment fee charged by the card network for transaction processing.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this interchange income record, including any special circumstances or exceptions.',
    `portfolio_segment` STRING COMMENT 'Issuer portfolio segment or business line (e.g., consumer, commercial, small business, premium).',
    `processing_fee_amount` DECIMAL(18,2) COMMENT 'Processing fees deducted from interchange income for transaction handling and settlement services.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between issuer records and scheme settlement reports.. Valid values are `matched|unmatched|partially_matched|under_review|exception`',
    `region_code` STRING COMMENT 'Geographic region code for the issuer (e.g., EMEA, APAC, LATAM, North America).',
    `revenue_recognition_date` DATE COMMENT 'Date on which the interchange income is recognized as revenue for accounting purposes.',
    `scheme_fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged by the card scheme (network fees, assessment fees) deducted from gross interchange.',
    `scheme_settlement_reference` STRING COMMENT 'Reference number provided by the card scheme for this settlement period.',
    `settlement_cycle_identifier` STRING COMMENT 'Unique identifier for the settlement cycle or batch (e.g., monthly, weekly cycle code).',
    `settlement_date` DATE COMMENT 'Date on which the interchange income was settled to the issuers account.',
    `settlement_period_end_date` DATE COMMENT 'End date of the settlement period for which interchange income is calculated.',
    `settlement_period_start_date` DATE COMMENT 'Start date of the settlement period for which interchange income is calculated.',
    `settlement_status` STRING COMMENT 'Current status of the interchange income settlement (e.g., pending, settled, reconciled, disputed).. Valid values are `pending|settled|reconciled|disputed|adjusted|finalized`',
    `transaction_count` BIGINT COMMENT 'Total number of transactions contributing to the interchange income for this settlement period.',
    `transaction_volume` DECIMAL(18,2) COMMENT 'Total monetary volume of transactions processed during the settlement period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interchange income record was last updated.',
    CONSTRAINT pk_issuer_interchange_income PRIMARY KEY(`issuer_interchange_income_id`)
) COMMENT 'Issuer-side interchange income record capturing the interchange revenue earned by the issuing bank for each settlement period. Stores issuer identifier, card product type, settlement period, transaction count, gross interchange earned, scheme fee deductions, net interchange income, currency, and reconciliation status. Supports issuer portfolio revenue recognition and profitability reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` (
    `interchange_reconciliation_id` BIGINT COMMENT 'Unique identifier for the interchange reconciliation record. Primary key.',
    `acquirer_id` BIGINT COMMENT 'Reference to the acquiring bank (merchants bank) involved in the interchange transactions.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Reconciliation reports must reference the acquiring banks legal entity to resolve variance and audit discrepancies.',
    `approved_by_user_employee_id` BIGINT COMMENT 'Reference to the supervisor or manager who approved the reconciliation results and any adjustments.',
    `dispute_case_id` BIGINT COMMENT 'Reference to the dispute case opened with the card scheme if the variance could not be internally resolved.',
    `employee_id` BIGINT COMMENT 'Reference to the user or analyst who performed the reconciliation and investigation.',
    `issuing_bank_id` BIGINT COMMENT 'Reference to the issuing bank (cardholders bank) involved in the interchange transactions.',
    `ecosystem_partner_id` BIGINT COMMENT 'Reference to the acquiring bank (merchants bank) involved in the interchange transactions.',
    `primary_interchange_employee_id` BIGINT COMMENT 'Reference to the user or analyst who performed the reconciliation and investigation.',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Interchange reconciliation aligns with a scheme invoice; adds scheme_invoice_id FK',
    `accounting_period_id` BIGINT COMMENT 'Reference to the settlement period during which the interchange transactions occurred.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustment amount applied to reconcile the variance, either credited or debited based on dispute resolution.',
    `adjustment_reason_code` STRING COMMENT 'Standardized code indicating the reason for any adjustment applied to this reconciliation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the reconciliation was approved by the authorized supervisor.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this reconciliation record.. Valid values are `^[A-Z]{3}$`',
    `cycle_identifier` STRING COMMENT 'Identifier for the reconciliation cycle or batch run during which this record was processed.',
    `dispute_filed_date` DATE COMMENT 'The date on which a formal dispute was filed with the card scheme regarding this reconciliation variance.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the scheme dispute was resolved and final settlement amounts were agreed.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which interchange reconciliation amounts are posted.',
    `gl_posting_date` DATE COMMENT 'The date on which the reconciliation results and any adjustments were posted to the general ledger.',
    `internal_calculated_interchange_amount` DECIMAL(18,2) COMMENT 'The total interchange amount calculated internally based on qualification rules and transaction data for the settlement period.',
    `internal_settlement_date` DATE COMMENT 'The date on which internal settlement processing was completed for this period.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'The date and time when the reconciliation was completed and status was finalized.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation record indicating whether internal and scheme amounts are aligned.. Valid values are `matched|unmatched|disputed|under_review|resolved|escalated`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this reconciliation record for tracking and audit purposes.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation, resolution actions taken, and final outcome for this reconciliation record.',
    `revenue_recognition_date` DATE COMMENT 'The date on which revenue or cost associated with this interchange reconciliation is recognized for financial reporting.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause identified for any variance in this reconciliation.. Valid values are `timing_difference|qualification_mismatch|data_quality|scheme_error|system_error|other`',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause identified for the variance, including specific transaction or rule issues.',
    `scheme_identifier` STRING COMMENT 'The payment card scheme (network brand) for which this reconciliation is performed.. Valid values are `VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|JCB`',
    `scheme_reported_interchange_amount` DECIMAL(18,2) COMMENT 'The total interchange amount reported by the card scheme for the same settlement period.',
    `scheme_settlement_date` DATE COMMENT 'The date on which the card scheme settled the interchange amounts.',
    `settlement_period_end_date` DATE COMMENT 'The end date of the settlement period covered by this reconciliation.',
    `settlement_period_start_date` DATE COMMENT 'The start date of the settlement period covered by this reconciliation.',
    `transaction_count_internal` BIGINT COMMENT 'The total number of transactions included in the internal interchange calculation for this period.',
    `transaction_count_scheme` BIGINT COMMENT 'The total number of transactions reported by the card scheme for this period.',
    `transaction_count_variance` BIGINT COMMENT 'The difference in transaction counts between internal records and scheme reports.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was last modified.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The absolute difference between internal calculated interchange and scheme reported interchange (internal minus scheme).',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the scheme reported interchange amount.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'The absolute monetary threshold above which variances must be investigated and resolved.',
    `variance_threshold_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the variance amount or percentage exceeds the acceptable tolerance threshold requiring investigation.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'The percentage threshold above which variances must be investigated and resolved.',
    CONSTRAINT pk_interchange_reconciliation PRIMARY KEY(`interchange_reconciliation_id`)
) COMMENT 'Reconciliation record matching internal interchange qualification records against scheme-reported interchange amounts for a given settlement period. Captures settlement period, scheme identifier, internal calculated interchange, scheme-reported interchange, variance amount, variance percentage, reconciliation status (matched, unmatched, disputed), and resolution notes. Critical for financial close and scheme dispute management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` (
    `payfac_sub_merchant_pricing_id` BIGINT COMMENT 'Unique identifier for the PayFac sub-merchant pricing configuration record.',
    `acquiring_portfolio_pricing_id` BIGINT COMMENT 'Foreign key linking to interchange.acquiring_portfolio_pricing. Business justification: PayFac sub‑merchant pricing belongs to a portfolio pricing configuration; adds acquiring_portfolio_pricing_id FK',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that approved this pricing configuration for activation.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that approved this pricing configuration for activation.',
    `payment_facilitator_id` BIGINT COMMENT 'Identifier of the Payment Facilitator managing this sub-merchant pricing configuration.',
    `sub_merchant_id` BIGINT COMMENT 'Identifier of the sub-merchant onboarded under the PayFac master Merchant Identification Number (MID). This sub-merchant operates under the PayFac umbrella for payment processing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing configuration was approved and authorized for use.',
    `base_rate_percentage` DECIMAL(18,2) COMMENT 'The base percentage rate applied to transaction volume under this pricing configuration. For interchange-plus models, this represents the markup over interchange; for flat-rate models, this is the total rate charged.',
    `batch_fee` DECIMAL(18,2) COMMENT 'Fee charged per batch settlement submission. Applicable when sub-merchant submits transaction batches for clearing and settlement.',
    `card_type_tier` STRING COMMENT 'Specifies which card types this pricing configuration applies to. Enables differential pricing based on card product type (debit, credit, premium, commercial).. Valid values are `all|debit_only|credit_only|premium_cards|commercial_cards`',
    `chargeback_fee` DECIMAL(18,2) COMMENT 'Fee charged to the sub-merchant for each chargeback dispute processed, covering administrative and operational costs of dispute management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing configuration record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all fees and rates are denominated for this pricing configuration.. Valid values are `^[A-Z]{3}$`',
    `durbin_regulated_pricing_flag` BOOLEAN COMMENT 'Indicates whether this pricing configuration applies Durbin Amendment regulated debit interchange rates (True) or standard rates (False). Applicable to US debit card transactions from regulated issuers.',
    `effective_end_date` DATE COMMENT 'Date on which this pricing configuration expires or is superseded. Null indicates an open-ended configuration.',
    `effective_start_date` DATE COMMENT 'Date from which this pricing configuration becomes active and applicable to the sub-merchant transactions.',
    `interchange_pass_through_flag` BOOLEAN COMMENT 'Indicates whether actual interchange costs are passed through to the sub-merchant (True) or absorbed into blended pricing (False). Critical for interchange-plus pricing models.',
    `mcc_restriction_list` STRING COMMENT 'Comma-separated list of Merchant Category Codes (MCC) to which this pricing applies or is restricted. Used to enforce industry-specific pricing or risk controls.',
    `monthly_fee` DECIMAL(18,2) COMMENT 'Fixed monthly service fee charged to the sub-merchant for account maintenance, platform access, and support services.',
    `monthly_minimum_fee` DECIMAL(18,2) COMMENT 'Minimum monthly fee threshold. If calculated fees fall below this amount, the sub-merchant is charged the minimum to ensure baseline revenue.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, exceptions, or operational notes related to this pricing configuration.',
    `per_transaction_fee` DECIMAL(18,2) COMMENT 'Fixed fee charged per transaction processed for this sub-merchant, regardless of transaction amount. Typically expressed in the settlement currency.',
    `pricing_agreement_reference` STRING COMMENT 'Reference number or identifier of the legal or commercial agreement governing this pricing configuration. Links pricing to contractual terms.',
    `pricing_configuration_code` STRING COMMENT 'Business-assigned code or identifier for this specific pricing configuration, used for internal reference and reporting.',
    `pricing_model` STRING COMMENT 'The pricing model applied to the sub-merchant. Flat rate applies a single percentage to all transactions; tiered applies different rates based on card type or volume; interchange-plus (IC-plus) passes through interchange costs plus a markup; blended combines multiple fee components into a single rate; subscription charges a fixed periodic fee; custom represents bespoke pricing arrangements.. Valid values are `flat_rate|tiered|interchange_plus|blended|subscription|custom`',
    `pricing_status` STRING COMMENT 'Current lifecycle status of the pricing configuration. Draft indicates pending approval; active indicates in use; suspended indicates temporarily inactive; expired indicates past effective end date; terminated indicates permanently closed.. Valid values are `draft|active|suspended|expired|terminated`',
    `pricing_tier_level` STRING COMMENT 'Named tier or level within a tiered pricing structure (e.g., Bronze, Silver, Gold, Platinum). Used for volume-based or relationship-based pricing differentiation.',
    `refund_fee` DECIMAL(18,2) COMMENT 'Fee charged to the sub-merchant for processing refund transactions. May be waived or reduced depending on pricing tier.',
    `revenue_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of net revenue (after interchange and scheme fees) retained by the PayFac. The remainder is the sub-merchant net settlement. Used for internal revenue allocation and partner reporting.',
    `risk_reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction volume withheld as a rolling reserve to cover potential chargebacks, refunds, or fraud losses. Released to sub-merchant after a defined holding period.',
    `scheme_fee_pass_through_flag` BOOLEAN COMMENT 'Indicates whether card scheme fees (Visa, Mastercard network fees) are passed through to the sub-merchant (True) or included in the pricing (False).',
    `settlement_delay_days` STRING COMMENT 'Number of days between transaction authorization and funds settlement to the sub-merchant. Used for risk management and cash flow control.',
    `transaction_count_cap` STRING COMMENT 'Maximum number of transactions allowed per month under this pricing configuration. Used for volume-based pricing tier enforcement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing configuration record was last modified.',
    `volume_cap_amount` DECIMAL(18,2) COMMENT 'Maximum transaction volume allowed per month under this pricing configuration. Exceeding this cap may trigger pricing tier changes or require approval.',
    CONSTRAINT pk_payfac_sub_merchant_pricing PRIMARY KEY(`payfac_sub_merchant_pricing_id`)
) COMMENT 'Sub-merchant pricing configuration managed by a Payment Facilitator (PayFac) for each sub-merchant onboarded under its master MID. Captures sub-merchant identifier, PayFac identifier, pricing model (flat rate, tiered, IC-plus), applicable rate, per-transaction fee, monthly fee, volume cap, and effective date. Enables PayFac revenue split and interchange cost allocation to sub-merchants.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`program` (
    `program_id` BIGINT COMMENT 'Unique surrogate key for the interchange program.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Program approval must be signed off by a designated employee; this link supports compliance reporting and program governance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Program eligibility and rate structures must comply with specific regulatory obligations; linking enables compliance checks and reporting.',
    `approval_required_flag` BOOLEAN COMMENT 'True if enrollment into the program requires manual approval.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the program was approved for activation.',
    `card_not_present_eligible_flag` BOOLEAN COMMENT 'True if card‑not‑present (e‑commerce) transactions are eligible.',
    `card_present_eligible_flag` BOOLEAN COMMENT 'True if card‑present (in‑store) transactions are eligible.',
    `card_type_eligibility` STRING COMMENT 'Card types that qualify for the program.. Valid values are `Credit|Debit|Prepaid|Commercial|Corporate`',
    `category_code` STRING COMMENT 'Internal code categorizing the program (e.g., Utility, Merit, Purchasing).',
    `compliance_notes` STRING COMMENT 'Regulatory or compliance related observations for the program (e.g., PCI DSS, PSD2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `cross_border_eligible_flag` BOOLEAN COMMENT 'True if transactions crossing national borders qualify for the program.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the program.. Valid values are `^[A-Z]{3}$`',
    `data_quality_indicator` STRING COMMENT 'Indicates the confidence level of the program data.. Valid values are `High|Medium|Low`',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether the program is subject to the Durbin Amendment regulations.',
    `effective_end_date` DATE COMMENT 'Date when the program expires or is superseded. Null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the program becomes effective.',
    `eligibility_criteria_description` STRING COMMENT 'Detailed rules that determine transaction qualification for the program.',
    `enrollment_requirements` STRING COMMENT 'Textual description of the criteria a merchant or issuer must satisfy to enroll in the program.',
    `fixed_fee_amount` DECIMAL(18,2) COMMENT 'Flat fee amount charged per transaction under this program.',
    `installment_eligible_flag` BOOLEAN COMMENT 'True if installment‑based transactions qualify.',
    `mcc_eligibility` STRING COMMENT 'Merchant category codes (MCC) that are eligible for the program. Multiple codes may be stored as a delimited list.',
    `notes` STRING COMMENT 'Free‑form comments or internal remarks about the program.',
    `program_code` STRING COMMENT 'External code used to identify the interchange program in scheme documentation.',
    `program_name` STRING COMMENT 'Human‑readable name of the interchange program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the interchange program.. Valid values are `Active|Inactive|Pending|Retired`',
    `qualification_criteria_code` STRING COMMENT 'Code referencing a detailed rule set that defines qualification logic.',
    `rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction amount charged as interchange under this program.',
    `rate_structure_type` STRING COMMENT 'Indicates whether the program uses a percentage rate, a fixed fee, or a combination.. Valid values are `Percentage|Fixed|Hybrid`',
    `recurring_eligible_flag` BOOLEAN COMMENT 'True if recurring (subscription) transactions qualify.',
    `scheme` STRING COMMENT 'Payment network that defines the program.. Valid values are `Visa|Mastercard|Amex|Discover|JCB`',
    `scheme_bulletin_reference` STRING COMMENT 'Reference identifier for the scheme bulletin that announced the program.',
    `scheme_publication_date` DATE COMMENT 'Date when the scheme published the program details.',
    `source_system` STRING COMMENT 'Name of the operational system that originated the program record (e.g., Merchant Management System).',
    `tier_level` STRING COMMENT 'Tier classification that determines rate structure.. Valid values are `Tier1|Tier2|Tier3`',
    `tokenization_eligible_flag` BOOLEAN COMMENT 'True if tokenized card transactions are eligible under the program.',
    `transaction_amount_max` DECIMAL(18,2) COMMENT 'Upper bound of transaction amount for eligibility.',
    `transaction_amount_min` DECIMAL(18,2) COMMENT 'Lower bound of transaction amount (in program currency) for eligibility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    `version_number` STRING COMMENT 'Version of the program definition, incremented on each change.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Card scheme interchange program master defining special interchange programs (e.g., Visa Utility, Mastercard Merit, Amex OptBlue, Visa Purchasing) with their eligibility criteria, qualifying transaction attributes, rate structures, and enrollment requirements. Captures program code, program name, scheme, card type eligibility, MCC eligibility, transaction size thresholds, and program tier levels.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` (
    `cross_border_fee_rule_id` BIGINT COMMENT 'Unique identifier for the cross-border fee rule record. Primary key for this entity.',
    `acquiring_portfolio_pricing_id` BIGINT COMMENT 'Foreign key linking to interchange.acquiring_portfolio_pricing. Business justification: Cross‑border fee rules are defined within a portfolio pricing configuration; adds acquiring_portfolio_pricing_id FK',
    `scheme_id` BIGINT COMMENT 'Reference to the card scheme (Visa, Mastercard, etc.) to which this cross-border fee rule applies.',
    `superseded_by_rule_cross_border_fee_rule_id` BIGINT COMMENT 'Reference to the cross-border fee rule that replaces this rule when it is superseded. Supports rule lineage and historical analysis.',
    `card_brand` STRING COMMENT 'The payment card brand to which this cross-border fee rule applies. Determines which network rules govern the transaction.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_present_indicator` BOOLEAN COMMENT 'Indicates whether this cross-border fee rule applies to card-present transactions (physical POS) or card-not-present transactions (e-commerce, MOTO).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cross-border fee rule record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `cross_border_assessment_rate_percent` DECIMAL(18,2) COMMENT 'Percentage-based cross-border assessment fee applied to the transaction amount when the issuing country differs from the acquiring country. Expressed as a decimal percentage (e.g., 1.25000 for 1.25%).',
    `cross_border_fixed_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary fee applied per cross-border transaction, independent of transaction amount. Used in conjunction with or as an alternative to percentage-based fees.',
    `currency_conversion_fee_rate_percent` DECIMAL(18,2) COMMENT 'Percentage-based fee applied when currency conversion occurs in a cross-border transaction. Represents the FX markup over the wholesale exchange rate.',
    `dcc_fee_rate_percent` DECIMAL(18,2) COMMENT 'Fee rate applied when Dynamic Currency Conversion is offered at the point of sale, allowing the cardholder to see the transaction amount in their home currency.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the destination country (typically the issuing country or cardholder country of residence).. Valid values are `^[A-Z]{3}$`',
    `destination_region_code` STRING COMMENT 'Regional grouping code for the destination country used for regional cross-border fee structures and compliance segmentation.',
    `effective_end_date` DATE COMMENT 'Date after which this cross-border fee rule is no longer active. Null indicates an open-ended rule with no expiration.',
    `effective_start_date` DATE COMMENT 'Date from which this cross-border fee rule becomes active and applicable to qualifying transactions. Part of the temporal validity window.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the cross-border fees are denominated and assessed.. Valid values are `^[A-Z]{3}$`',
    `mcc_list` STRING COMMENT 'Comma-separated list of four-digit MCC codes to which this cross-border fee rule applies or excludes, based on the MCC restriction type.',
    `mcc_restriction_type` STRING COMMENT 'Defines how the MCC list is applied: all (applies to all MCCs), include (applies only to listed MCCs), exclude (applies to all except listed MCCs).. Valid values are `all|include|exclude`',
    `notes` STRING COMMENT 'Free-text field for additional business context, special conditions, or operational notes related to this cross-border fee rule configuration.',
    `originating_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the transaction originates (typically the acquiring country or merchant location country).. Valid values are `^[A-Z]{3}$`',
    `originating_region_code` STRING COMMENT 'Regional grouping code for the originating country (e.g., EEA, NAFTA, APAC) used for regional cross-border fee structures.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking used to resolve conflicts when multiple cross-border fee rules match a transaction. Lower numbers indicate higher priority.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this cross-border fee rule is subject to specific regulatory compliance requirements (e.g., PSD2 in EU, Durbin Amendment caps).',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework or jurisdiction-specific regulation governing this cross-border fee rule (e.g., PSD2, Regulation II, local central bank rules).',
    `rule_code` STRING COMMENT 'Business-readable unique code identifying this cross-border fee rule configuration. Used for operational reference and configuration management.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `rule_name` STRING COMMENT 'Descriptive name of the cross-border fee rule for business user identification and reporting purposes.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the cross-border fee rule. Controls whether the rule is applied in production fee calculation processes.. Valid values are `draft|active|suspended|expired|superseded`',
    `scheme_bulletin_reference` STRING COMMENT 'Reference number or identifier of the official card scheme bulletin or publication that announced or mandated this cross-border fee rule.',
    `scheme_program_code` STRING COMMENT 'Specific card scheme program or product identifier (e.g., Visa Signature, Mastercard World Elite) to which this cross-border fee rule applies.',
    `swift_correspondent_fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee component for SWIFT messaging and correspondent banking services used in cross-border settlement. Applies when international wire transfers are required for settlement.',
    `transaction_max_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount threshold for this cross-border fee rule to apply. Transactions above this amount may be subject to different fee structures or caps.',
    `transaction_min_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount threshold for this cross-border fee rule to apply. Transactions below this amount may be subject to different fee structures.',
    `transaction_type` STRING COMMENT 'Type of payment transaction to which this cross-border fee rule applies. Different transaction types may have different cross-border fee structures.. Valid values are `purchase|cash_advance|refund|reversal|chargeback`',
    `updated_by` STRING COMMENT 'User identifier or system account that last modified this cross-border fee rule record. Supports change management and audit requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cross-border fee rule record was last modified. Supports change tracking and audit requirements.',
    `version_number` STRING COMMENT 'Version number of this cross-border fee rule configuration. Incremented with each modification to support change tracking and audit trails.',
    `created_by` STRING COMMENT 'User identifier or system account that created this cross-border fee rule record. Supports audit trail and accountability requirements.',
    CONSTRAINT pk_cross_border_fee_rule PRIMARY KEY(`cross_border_fee_rule_id`)
) COMMENT 'Cross-border and international transaction fee rules defining the additional fees applied when the issuing country differs from the acquiring country. Captures originating country, destination country, card scheme, cross-border assessment rate, currency conversion fee rate, DCC (Dynamic Currency Conversion) fee, SWIFT/correspondent banking fee component, and effective date range. Supports FX cost modeling in cross-border payment flows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` (
    `pricing_exception_id` BIGINT COMMENT 'Unique identifier for the pricing exception record. Primary key for the pricing exception entity.',
    `acquiring_portfolio_pricing_id` BIGINT COMMENT 'Foreign key linking to interchange.acquiring_portfolio_pricing. Business justification: pricing_exception applies to a specific portfolio pricing configuration; adds acquiring_portfolio_pricing_id FK',
    `approved_by_user_employee_id` BIGINT COMMENT 'System identifier of the user who approved this pricing exception. Links to user or employee master record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier for the partner organization (ISO, PayFac, aggregator) to which this exception applies. Used when exceptions are negotiated at partner level.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who approved this pricing exception. Links to user or employee master record.',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: pricing_exception is tied to an MDR configuration; adds mdr_config_id FK',
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant receiving the pricing exception. Links to the merchant master record.',
    `portfolio_id` BIGINT COMMENT 'Identifier for the merchant portfolio or segment to which this exception applies. Used when exceptions are granted at portfolio level rather than individual merchant level.',
    `approval_authority` STRING COMMENT 'Name or title of the executive or committee that authorized this pricing exception (e.g., Chief Revenue Officer, Pricing Committee, Regional VP).',
    `approval_date` DATE COMMENT 'The date on which this pricing exception was formally approved by the designated authority.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this pricing exception automatically renews at the end of its term. True means exception continues unless terminated, false means it expires on effective_end_date.',
    `business_justification` STRING COMMENT 'Detailed explanation of the business rationale for granting this exception, including competitive factors, strategic value, volume commitments, or relationship considerations.',
    `card_scheme` STRING COMMENT 'The payment card network to which this exception applies. Value all indicates exception applies across all schemes. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|unionpay|all — 7 candidates stripped; promote to reference product]',
    `card_type` STRING COMMENT 'The card product type to which this exception applies. Value all indicates exception applies to all card types.. Valid values are `credit|debit|prepaid|commercial|all`',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review of this exception to ensure it meets regulatory requirements, internal policy, and audit standards.',
    `contract_reference_number` STRING COMMENT 'External reference number of the merchant processing agreement, partner contract, or amendment that documents this pricing exception.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this pricing exception record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date on which this pricing exception expires. Null for open-ended exceptions subject to contract termination only.',
    `effective_start_date` DATE COMMENT 'The date from which this pricing exception becomes active and applicable to qualifying transactions.',
    `exception_code` STRING COMMENT 'Unique business code identifying this pricing exception for reference in contracts, invoices, and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `exception_fixed_fee_amount` DECIMAL(18,2) COMMENT 'The negotiated per-transaction fixed fee granted under this exception. May be zero for full waiver.',
    `exception_name` STRING COMMENT 'Descriptive name for the pricing exception, typically referencing the merchant, partner, or program name.',
    `exception_rate_percent` DECIMAL(18,2) COMMENT 'The negotiated exception rate granted to the merchant, portfolio, or partner. Expressed as decimal (e.g., 0.0225 for 2.25%).',
    `exception_status` STRING COMMENT 'Current lifecycle status of the pricing exception. Draft is under construction, pending_approval awaits authorization, active is in force, suspended is temporarily inactive, expired has passed end date, terminated was cancelled before expiry.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `exception_type` STRING COMMENT 'Category of pricing exception granted. MDR discount reduces merchant discount rate, MSF waiver eliminates merchant service fees, IRF adjustment modifies interchange reimbursement fee pass-through, volume incentive provides tiered pricing based on transaction volume, promotional is temporary campaign pricing, custom is bespoke arrangement.. Valid values are `mdr_discount|msf_waiver|irf_adjustment|volume_incentive|promotional|custom`',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all fee amounts in this exception record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'The maximum transaction amount for which this exception applies. Null if no maximum threshold.',
    `mcc_list` STRING COMMENT 'Comma-separated list of four-digit MCC codes to which this exception applies. Null if mcc_scope is all.',
    `mcc_scope` STRING COMMENT 'Defines whether the exception applies to specific MCC codes, a range of MCCs, or all merchant categories.. Valid values are `specific|range|all`',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'The minimum transaction amount required for this exception to apply. Null if no minimum threshold.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special conditions, or operational notes related to this pricing exception.',
    `rate_discount_bps` STRING COMMENT 'The discount granted expressed in basis points (1 bps = 0.01%). Calculated as (standard_rate_percent - exception_rate_percent) * 10000. Used for revenue impact analysis.',
    `revenue_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue impact estimate.. Valid values are `^[A-Z]{3}$`',
    `revenue_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated annual revenue impact (reduction) of granting this exception, calculated at time of approval. Used for financial planning and exception portfolio management.',
    `standard_fixed_fee_amount` DECIMAL(18,2) COMMENT 'The standard per-transaction fixed fee (Merchant Service Fee component) that would normally apply before the exception.',
    `standard_rate_percent` DECIMAL(18,2) COMMENT 'The standard Merchant Discount Rate (MDR) or percentage-based fee that would normally apply before the exception. Expressed as decimal (e.g., 0.0275 for 2.75%).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate this pricing exception, as specified in the contract.',
    `transaction_type` STRING COMMENT 'The transaction channel or entry mode to which this exception applies. Value all indicates exception applies to all transaction types.. Valid values are `card_present|card_not_present|ecommerce|moto|recurring|all`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this pricing exception record was last modified.',
    `volume_tier_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the volume tier threshold.. Valid values are `^[A-Z]{3}$`',
    `volume_tier_threshold` DECIMAL(18,2) COMMENT 'Minimum monthly or annual transaction volume required to qualify for this exception. Used for volume-based incentive pricing.',
    CONSTRAINT pk_pricing_exception PRIMARY KEY(`pricing_exception_id`)
) COMMENT 'Records negotiated pricing exceptions and custom interchange arrangements granted to specific merchants, portfolios, or partners that deviate from standard MDR or MSF schedules. Captures exception type, merchant or portfolio identifier, standard rate, exception rate, basis point discount, approval authority, effective date, expiry date, and business justification. Supports audit and contract compliance tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` (
    `volume_tier_threshold_id` BIGINT COMMENT 'Unique identifier for the volume tier threshold configuration record.',
    `acquirer_id` BIGINT COMMENT 'Acquiring bank or payment service provider identifier for acquirer-specific tier configurations. Null indicates tier applies across all acquirers.',
    `acquiring_portfolio_pricing_id` BIGINT COMMENT 'Foreign key linking to interchange.acquiring_portfolio_pricing. Business justification: Volume tier thresholds are part of a portfolio pricing configuration; adds acquiring_portfolio_pricing_id FK',
    `issuer_id` BIGINT COMMENT 'Issuing bank identifier for issuer-specific tier configurations. Null indicates tier applies across all issuers.',
    `scheme_id` BIGINT COMMENT 'Card scheme or payment network identifier (e.g., VISA, MASTERCARD, AMEX, DISCOVER) to which this tier applies. Null indicates tier applies across all schemes.',
    `superseded_by_tier_volume_tier_threshold_id` BIGINT COMMENT 'Reference to the volume_tier_threshold_id that replaces this configuration when a new version is published. Null if this is the current active version.',
    `applicable_fixed_fee` DECIMAL(18,2) COMMENT 'Fixed fee amount per transaction that applies when this tier threshold is met.',
    `applicable_rate_percent` DECIMAL(18,2) COMMENT 'Interchange rate percentage or MDR percentage that applies when this tier threshold is met. Expressed as decimal (e.g., 0.0250 for 2.50%).',
    `approval_status` STRING COMMENT 'Approval workflow status for this tier configuration before it becomes effective.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'User identifier or name of the person who approved this tier configuration for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this tier configuration was approved.',
    `card_present_flag` BOOLEAN COMMENT 'Indicates whether this tier applies to card-present transactions (True), card-not-present transactions (False), or both (Null).',
    `card_product_tier` STRING COMMENT 'Card product tier or brand level (e.g., standard, gold, platinum, signature, infinite, world elite). Null indicates tier applies to all product tiers.. Valid values are `standard|gold|platinum|signature|infinite|world_elite`',
    `card_type` STRING COMMENT 'Type of payment card this tier applies to (debit, credit, prepaid, commercial). Null indicates tier applies to all card types.. Valid values are `debit|credit|prepaid|commercial`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the geographic market this tier applies to. Null indicates tier applies globally.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this volume tier threshold record was first created in the system.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether this tier applies to cross-border transactions (True), domestic transactions (False), or both (Null).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary thresholds (e.g., USD, EUR, GBP). Null for non-monetary thresholds.. Valid values are `^[A-Z]{3}$`',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied to standard rates when merchant qualifies for this volume tier. Expressed as decimal (e.g., 0.0050 for 0.50% discount).',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether this tier applies to Durbin Amendment regulated debit transactions (True), non-regulated transactions (False), or both (Null).',
    `effective_end_date` DATE COMMENT 'Date when this volume tier threshold configuration expires and is no longer applied. Null indicates no expiration.',
    `effective_start_date` DATE COMMENT 'Date when this volume tier threshold configuration becomes effective and begins applying to merchant or issuer volume calculations.',
    `fee_type` STRING COMMENT 'Type of fee structure this tier applies to: IRF (Interchange Reimbursement Fee), MDR (Merchant Discount Rate), MSF (Merchant Service Fee), scheme fee, or assessment fee.. Valid values are `irf|mdr|msf|scheme_fee|assessment_fee`',
    `lower_bound` DECIMAL(18,2) COMMENT 'Minimum volume threshold value required to qualify for this tier (inclusive). Null indicates no lower limit.',
    `measurement_period` STRING COMMENT 'Time period over which volume is measured to determine tier qualification (e.g., monthly, quarterly, annual, rolling 30 days). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annual|rolling_30_days|rolling_90_days — 7 candidates stripped; promote to reference product]',
    `measurement_unit` STRING COMMENT 'Unit of measure for the threshold bounds (count for transaction volume, currency_amount for TPV, percentage for rate-based thresholds).. Valid values are `count|currency_amount|percentage`',
    `merchant_category_code` STRING COMMENT 'Four-digit MCC that this tier applies to. Null indicates tier applies across all MCCs.. Valid values are `^[0-9]{4}$`',
    `notes` STRING COMMENT 'Free-text notes providing additional context, business rationale, or special instructions for this volume tier threshold configuration.',
    `priority_rank` STRING COMMENT 'Priority ranking used to resolve conflicts when multiple tier configurations could apply to the same transaction. Lower numbers indicate higher priority.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Fixed rebate amount provided to merchant or issuer when this volume tier is achieved during the measurement period.',
    `region_code` STRING COMMENT 'Regional market identifier for multi-country tier configurations (e.g., EMEA, APAC, LATAM). Null indicates no regional restriction.',
    `threshold_type` STRING COMMENT 'Type of volume measurement used to determine tier qualification (transaction count, TPV amount, monthly volume, annual volume, or quarterly volume).. Valid values are `transaction_count|tpv_amount|monthly_volume|annual_volume|quarterly_volume`',
    `tier_code` STRING COMMENT 'Business identifier code for the volume tier (e.g., TIER_1, TIER_GOLD, TIER_PLATINUM).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tier_level` STRING COMMENT 'Numeric ranking of the tier within the pricing structure, where lower numbers typically represent entry-level tiers and higher numbers represent premium tiers.',
    `tier_name` STRING COMMENT 'Human-readable name of the volume tier (e.g., Bronze, Silver, Gold, Platinum).',
    `tier_status` STRING COMMENT 'Current lifecycle status of the volume tier threshold configuration.. Valid values are `active|inactive|pending|expired|superseded`',
    `transaction_type` STRING COMMENT 'Type of transaction this tier applies to (purchase, refund, cash advance, balance inquiry). Null indicates tier applies to all transaction types.. Valid values are `purchase|refund|cash_advance|balance_inquiry`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this volume tier threshold record was last modified.',
    `upper_bound` DECIMAL(18,2) COMMENT 'Maximum volume threshold value for this tier (exclusive). Null indicates no upper limit.',
    `version_number` STRING COMMENT 'Version number of this tier configuration, incremented with each modification to support change tracking and audit requirements.',
    CONSTRAINT pk_volume_tier_threshold PRIMARY KEY(`volume_tier_threshold_id`)
) COMMENT 'Volume tier threshold configuration defining the transaction volume or TPV (Total Payment Volume) bands that trigger tiered interchange rates, MDR discounts, or scheme fee rebates. Captures tier level, lower volume bound, upper volume bound, applicable rate or discount, fee type, scheme or acquirer identifier, and effective date. Enables dynamic pricing adjustments based on merchant volume performance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` (
    `interchange_dispute_id` BIGINT COMMENT 'Unique identifier for the interchange dispute record. Primary key for the interchange dispute entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the interchange billing period that is the subject of the dispute, if the dispute pertains to aggregated billing rather than a single transaction.',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_compliance_case. Business justification: Interchange disputes are investigated as compliance cases; linking provides case tracking, resolution status, and auditability.',
    `transaction_id` BIGINT COMMENT 'Reference to the specific transaction that is the subject of the interchange dispute, if the dispute pertains to a single transaction.',
    `ecosystem_partner_id` BIGINT COMMENT 'Reference to the acquiring bank or merchant acquirer involved in the interchange dispute.',
    `issuing_bank_id` BIGINT COMMENT 'Reference to the issuing bank or card issuer involved in the interchange dispute.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant associated with the disputed transaction or billing period.',
    `scheme_id` BIGINT COMMENT 'Reference to the card scheme entity involved in the interchange dispute.',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Interchange disputes are linked to the underlying scheme invoice; adds scheme_invoice_id FK',
    `arn` STRING COMMENT 'Unique acquirer reference number for the disputed transaction, used for tracing and reconciliation across the payment network.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by the interchange dispute, applicable when the dispute relates to aggregated billing.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by the interchange dispute, applicable when the dispute relates to aggregated billing.',
    `bin` STRING COMMENT 'The first 6-8 digits of the card number (BIN or IIN) associated with the disputed transaction, used for interchange qualification.. Valid values are `^[0-9]{6,8}$`',
    `card_scheme` STRING COMMENT 'Payment network brand or card scheme involved in the interchange dispute.. Valid values are `Visa|Mastercard|American Express|Discover|UnionPay|JCB`',
    `claimed_interchange_amount` DECIMAL(18,2) COMMENT 'Interchange fee amount claimed by the disputing party as the correct amount that should have been applied.',
    `claimed_irf_category_code` STRING COMMENT 'The interchange rate category code that the disputing party claims should have been applied to the transaction or billing period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interchange dispute record was first created in the system.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether the disputed transaction involved cross-border processing, which affects interchange qualification.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the interchange dispute.. Valid values are `^[A-Z]{3}$`',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the interchange dispute in the resolution workflow.. Valid values are `open|under_review|pending_response|resolved|closed|withdrawn`',
    `dispute_type` STRING COMMENT 'Classification of the interchange dispute based on the nature of the disagreement.. Valid values are `rate_misapplication|downgrade_disagreement|fee_calculation_error|qualification_error|scheme_reporting_discrepancy`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The difference between the claimed and scheme-reported interchange amounts, representing the financial value in dispute.',
    `durbin_regulated_flag` BOOLEAN COMMENT 'Indicates whether the disputed transaction or billing period is subject to Durbin Amendment interchange fee caps for regulated debit cards.',
    `escalation_level` STRING COMMENT 'Current escalation level of the interchange dispute within the card scheme dispute resolution hierarchy.. Valid values are `initial|second_review|arbitration|final`',
    `filing_date` DATE COMMENT 'Date when the interchange dispute was formally filed with the card scheme or counterparty.',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the interchange dispute was submitted into the dispute management system.',
    `financial_adjustment_amount` DECIMAL(18,2) COMMENT 'The final financial adjustment amount resulting from the dispute resolution, which may be positive (credit) or negative (debit).',
    `initiator` STRING COMMENT 'Identifies which party initiated the interchange dispute (acquirer, issuer, payment platform, or card scheme).. Valid values are `acquirer|issuer|platform|scheme`',
    `mcc` STRING COMMENT 'Four-digit merchant category code associated with the disputed transaction, relevant for interchange qualification rules.. Valid values are `^[0-9]{4}$`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or internal observations related to the interchange dispute.',
    `reason_code` STRING COMMENT 'Standardized code identifying the specific reason for the interchange dispute, aligned with card scheme dispute reason taxonomies.',
    `reason_description` STRING COMMENT 'Detailed textual explanation of the reason for the interchange dispute, providing context beyond the reason code.',
    `reference_number` STRING COMMENT 'External business identifier for the interchange dispute, used for communication with card schemes, acquirers, and issuers.',
    `resolution_date` DATE COMMENT 'Date when the interchange dispute was resolved or closed, marking the end of the dispute lifecycle.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the interchange dispute resolution process, indicating whether the dispute was upheld, denied, or partially resolved.. Valid values are `accepted|rejected|partially_accepted|withdrawn|escalated`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the interchange dispute resolution was recorded in the system.',
    `respondent` STRING COMMENT 'Identifies which party is responding to or defending against the interchange dispute.. Valid values are `acquirer|issuer|platform|scheme`',
    `response_due_date` DATE COMMENT 'Deadline by which the respondent must provide a response to the interchange dispute, per card scheme rules.',
    `scheme_applied_irf_category_code` STRING COMMENT 'The interchange rate category code that was actually applied by the card scheme, which is being disputed.',
    `scheme_case_number` STRING COMMENT 'Case or dispute tracking number assigned by the card scheme for this interchange dispute.',
    `scheme_reported_interchange_amount` DECIMAL(18,2) COMMENT 'Interchange fee amount reported or calculated by the card scheme, which is being disputed.',
    `supporting_documentation_reference` STRING COMMENT 'Reference identifier or location of supporting documentation, evidence, or attachments related to the interchange dispute.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the interchange dispute record was last modified in the system.',
    CONSTRAINT pk_interchange_dispute PRIMARY KEY(`interchange_dispute_id`)
) COMMENT 'Interchange-specific dispute record tracking disagreements between acquirers and issuers (or between the platform and card schemes) over interchange fee amounts, rate category misapplication, or downgrade decisions. Captures dispute reference, disputed transaction or billing period, claimed interchange amount, scheme-reported amount, dispute reason code, filing date, resolution date, resolution outcome, and financial adjustment amount.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` (
    `program_fee_schedule_assignment_id` BIGINT COMMENT 'Primary key for the ProgramFeeScheduleAssignment association',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx_fee_schedule',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange_program',
    `effective_end_date` DATE COMMENT 'Date when this mapping expires (null if open‑ended)',
    `effective_start_date` DATE COMMENT 'Date when this program‑fee‑schedule mapping becomes active',
    `fee_type_override` STRING COMMENT 'Specific fee type override for this program‑schedule pair, if any',
    CONSTRAINT pk_program_fee_schedule_assignment PRIMARY KEY(`program_fee_schedule_assignment_id`)
) COMMENT 'This association captures the mapping between an interchange program and an FX fee schedule, including the period the mapping is effective and any fee‑type overrides specific to that combination.. Existence Justification: An interchange program can be linked to multiple FX fee schedules, and a single FX fee schedule can apply to multiple interchange programs. The business actively manages this mapping, capturing effective dates and optional fee‑type overrides for each program‑schedule pair.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`pricing_tier` (
    `pricing_tier_id` BIGINT COMMENT 'Primary key for pricing_tier',
    `fallback_pricing_tier_id` BIGINT COMMENT 'Self-referencing FK on pricing_tier (fallback_pricing_tier_id)',
    `applicable_region` STRING COMMENT 'Three‑letter ISO country code where the tier is applicable.',
    `card_scheme` STRING COMMENT 'Card network to which the tier rules are applicable.',
    `compliance_tier` STRING COMMENT 'Indicates Durbin Amendment compliance classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing tier record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `pricing_tier_description` STRING COMMENT 'Detailed free‑text description of the tiers purpose and rules.',
    `effective_from` DATE COMMENT 'Date when the pricing tier becomes active.',
    `effective_until` DATE COMMENT 'Date when the pricing tier expires or is superseded; null if open‑ended.',
    `fee_percentage` DECIMAL(18,2) COMMENT 'Percentage component of the interchange fee for this tier.',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary component of the fee for this tier.',
    `interchange_rate_type` STRING COMMENT 'Classification of the interchange rate for reporting and compliance.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this tier is the default for new merchants.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper bound of transaction amount for which the tier applies.',
    `merchant_category_code` STRING COMMENT 'Four‑digit code representing the merchants business type.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Lower bound of transaction amount for which the tier applies.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or operational notes.',
    `pricing_model` STRING COMMENT 'Model used to calculate fees (percentage, flat, or hybrid).',
    `pricing_tier_status` STRING COMMENT 'Current lifecycle status of the pricing tier.',
    `surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a surcharge is applied under this tier.',
    `surcharge_rate` DECIMAL(18,2) COMMENT 'Percentage surcharge applied when surcharge_applicable is true.',
    `tier_code` STRING COMMENT 'Business code used to reference the pricing tier in external systems.',
    `tier_level` STRING COMMENT 'Numeric level indicating the hierarchy of the tier (e.g., 1 = highest).',
    `tier_name` STRING COMMENT 'Human‑readable name of the pricing tier.',
    `tier_type` STRING COMMENT 'Classification of the tier such as volume‑based, flat‑fee, or hybrid.',
    `transaction_type` STRING COMMENT 'Category of transaction the tier applies to.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pricing tier record.',
    `volume_threshold` DECIMAL(18,2) COMMENT 'Transaction volume amount that triggers this tier.',
    `volume_threshold_unit` STRING COMMENT 'Unit of measurement for the volume threshold.',
    CONSTRAINT pk_pricing_tier PRIMARY KEY(`pricing_tier_id`)
) COMMENT 'Master reference table for pricing_tier. Referenced by pricing_tier_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_pricing_tier_id` FOREIGN KEY (`pricing_tier_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`pricing_tier`(`pricing_tier_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_superseded_by_rule_bin_interchange_rule_id` FOREIGN KEY (`superseded_by_rule_bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_msf_schedule_id` FOREIGN KEY (`msf_schedule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`msf_schedule`(`msf_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ADD CONSTRAINT `fk_interchange_scheme_invoice_line_original_invoice_line_scheme_invoice_line_id` FOREIGN KEY (`original_invoice_line_scheme_invoice_line_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice_line`(`scheme_invoice_line_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ADD CONSTRAINT `fk_interchange_scheme_invoice_line_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ADD CONSTRAINT `fk_interchange_scheme_invoice_line_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_original_entry_revenue_recognition_entry_id` FOREIGN KEY (`original_entry_revenue_recognition_entry_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry`(`revenue_recognition_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ADD CONSTRAINT `fk_interchange_rate_history_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ADD CONSTRAINT `fk_interchange_rate_history_superseded_by_history_rate_history_id` FOREIGN KEY (`superseded_by_history_rate_history_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`rate_history`(`rate_history_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ADD CONSTRAINT `fk_interchange_mcc_interchange_map_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ADD CONSTRAINT `fk_interchange_mcc_interchange_map_superseded_by_map_mcc_interchange_map_id` FOREIGN KEY (`superseded_by_map_mcc_interchange_map_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mcc_interchange_map`(`mcc_interchange_map_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ADD CONSTRAINT `fk_interchange_acquiring_portfolio_pricing_durbin_compliance_tier_id` FOREIGN KEY (`durbin_compliance_tier_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier`(`durbin_compliance_tier_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ADD CONSTRAINT `fk_interchange_acquiring_portfolio_pricing_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ADD CONSTRAINT `fk_interchange_issuer_interchange_income_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ADD CONSTRAINT `fk_interchange_payfac_sub_merchant_pricing_acquiring_portfolio_pricing_id` FOREIGN KEY (`acquiring_portfolio_pricing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing`(`acquiring_portfolio_pricing_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_acquiring_portfolio_pricing_id` FOREIGN KEY (`acquiring_portfolio_pricing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing`(`acquiring_portfolio_pricing_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_superseded_by_rule_cross_border_fee_rule_id` FOREIGN KEY (`superseded_by_rule_cross_border_fee_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule`(`cross_border_fee_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_acquiring_portfolio_pricing_id` FOREIGN KEY (`acquiring_portfolio_pricing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing`(`acquiring_portfolio_pricing_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_acquiring_portfolio_pricing_id` FOREIGN KEY (`acquiring_portfolio_pricing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing`(`acquiring_portfolio_pricing_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_superseded_by_tier_volume_tier_threshold_id` FOREIGN KEY (`superseded_by_tier_volume_tier_threshold_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`volume_tier_threshold`(`volume_tier_threshold_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ADD CONSTRAINT `fk_interchange_program_fee_schedule_assignment_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_tier` ADD CONSTRAINT `fk_interchange_pricing_tier_fallback_pricing_tier_id` FOREIGN KEY (`fallback_pricing_tier_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`pricing_tier`(`pricing_tier_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`interchange` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`interchange` SET TAGS ('dbx_domain' = 'interchange');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Table ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `acquirer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `acquirer_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `authorization_method` SET TAGS ('dbx_business_glossary_term' = 'Authorization Method');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `authorization_method` SET TAGS ('dbx_value_regex' = 'chip|contactless|magnetic_stripe|manual_entry|ecommerce|token');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `bin_range_high` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range High');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `bin_range_high` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `bin_range_low` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range Low');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `bin_range_low` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `card_product_tier` SET TAGS ('dbx_business_glossary_term' = 'Card Product Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|purchasing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `cost_of_acceptance_category` SET TAGS ('dbx_business_glossary_term' = 'Cost of Acceptance Category');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `durbin_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Durbin Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `interchange_category_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `interchange_category_name` SET TAGS ('dbx_business_glossary_term' = 'Interchange Category Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `interchange_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `interchange_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `interchange_fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `interchange_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `internal_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `maximum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `minimum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `program_identifier` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `qualification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|withdrawn');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `scheme_bulletin_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Bulletin Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `scheme_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Scheme Publication Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `settlement_timeframe_hours` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timeframe Hours');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `transaction_region` SET TAGS ('dbx_business_glossary_term' = 'Transaction Region');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `transaction_region` SET TAGS ('dbx_value_regex' = 'domestic|intra_regional|inter_regional|cross_border');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|ecommerce|moto|recurring|contactless');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Rate Category ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `authorization_timeframe_hours` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timeframe in Hours');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `avs_required` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Required');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range End');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range Start');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `card_not_present_indicator` SET TAGS ('dbx_business_glossary_term' = 'Card Not Present (CNP) Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `card_present_indicator` SET TAGS ('dbx_business_glossary_term' = 'Card Present Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Category Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Category Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `contactless_eligible` SET TAGS ('dbx_business_glossary_term' = 'Near Field Communication (NFC) Contactless Eligible');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `cross_border_transaction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 4217 Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `cvv_required` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Required');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `cvv_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `cvv_required` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `domestic_transaction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Domestic Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `downgrade_category_code` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Interchange Rate Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `downgrade_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `downgrade_rules_description` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Rules Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `durbin_regulated_indicator` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `emv_chip_required` SET TAGS ('dbx_business_glossary_term' = 'Europay Mastercard Visa (EMV) Chip Required');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `irf_rate_category_status` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Category Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `irf_rate_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|superseded');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `mcc_range_end` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Range End');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `mcc_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `mcc_range_start` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Range Start');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `mcc_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `parent_category_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Interchange Rate Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `parent_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `qualification_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `scheme_publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Publication Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `settlement_timeframe_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timeframe in Days');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `three_d_secure_required` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Authentication Required');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `transaction_amount_max` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount Maximum Threshold');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `transaction_amount_min` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount Minimum Threshold');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{5,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{5,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{5,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `primary_mdr_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `primary_mdr_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `primary_mdr_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tertiary_mdr_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tertiary_mdr_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tertiary_mdr_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `blended_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Blended Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|all');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `durbin_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Durbin Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `fixed_transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `interchange_plus_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Interchange-Plus Margin Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `maximum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `merchant_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Segment Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `merchant_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `mid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `minimum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `monthly_subscription_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Subscription Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `monthly_volume_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Volume Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_value_regex' = 'flat|tiered|interchange_plus|subscription|blended');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tier_1_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tier_1_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tier_2_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tier_2_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `tier_3_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|ecommerce|moto|recurring|all');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `msf_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Service Fee (MSF) Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification (MID) Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `pricing_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `avs_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `batch_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `chargeback_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `durbin_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `early_termination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `interchange_pass_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Interchange Pass-Through Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `international_transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'International Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `monthly_account_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Account Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `monthly_minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Minimum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `msf_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `msf_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired|terminated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `pci_compliance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Compliance Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `per_transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Per-Transaction Service Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rate');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `retrieval_request_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Request Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'accrual|cash|deferred|straight_line');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'standard|custom|promotional|tiered|interchange_plus|flat_rate');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `statement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Statement Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `voice_authorization_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Voice Authorization Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `volume_tier_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `volume_tier_threshold_count` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold Count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `scheme_fee_table_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Table ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `assessment_basis` SET TAGS ('dbx_business_glossary_term' = 'Assessment Basis');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `assessment_basis` SET TAGS ('dbx_value_regex' = 'gross_volume|net_volume|transaction_count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `bin_range_high` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range High');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `bin_range_high` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `bin_range_low` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range Low');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `bin_range_low` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `card_present_indicator` SET TAGS ('dbx_business_glossary_term' = 'Card Present Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `card_present_indicator` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|both');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `card_product_type` SET TAGS ('dbx_business_glossary_term' = 'Card Product Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `card_product_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|all');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `digital_wallet_indicator` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `domestic_international_indicator` SET TAGS ('dbx_business_glossary_term' = 'Domestic International Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `domestic_international_indicator` SET TAGS ('dbx_value_regex' = 'domestic|international|both');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `durbin_regulated_indicator` SET TAGS ('dbx_business_glossary_term' = 'Durbin Regulated Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Fixed Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_rate_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed|tiered|hybrid');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_status` SET TAGS ('dbx_value_regex' = 'active|pending|superseded|retired');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'assessment|network_access|cross_border|digital_enablement|misuse_of_authorization|scheme_surcharge');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `maximum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `mcc_range_high` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Range High');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `mcc_range_high` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `mcc_range_low` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Range Low');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `mcc_range_low` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'acquirer|issuer|both');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `scheme_publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Publication Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `three_d_secure_indicator` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|cash_advance|refund|chargeback|all');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `volume_tier_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Lower Bound');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `volume_tier_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Unit');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `volume_tier_unit` SET TAGS ('dbx_value_regex' = 'transaction_count|transaction_value');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `volume_tier_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Upper Bound');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Interchange Rule ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `superseded_by_rule_bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rule ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `authorization_indicator` SET TAGS ('dbx_business_glossary_term' = 'Authorization Indicator Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `authorization_indicator` SET TAGS ('dbx_value_regex' = 'pre_auth|final_auth|incremental|undefined');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `avs_required` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range End');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,11}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range Start');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,11}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|JCB');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_not_present_eligible` SET TAGS ('dbx_business_glossary_term' = 'Card Not Present Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_present_eligible` SET TAGS ('dbx_business_glossary_term' = 'Card Present Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_product_type` SET TAGS ('dbx_business_glossary_term' = 'Card Product Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_product_type` SET TAGS ('dbx_value_regex' = 'debit|credit|prepaid|commercial|government|healthcare');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `contactless_eligible` SET TAGS ('dbx_business_glossary_term' = 'Contactless (NFC) Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Interchange Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Transaction Data Quality Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'full_data|partial_data|no_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `durbin_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Exemption Reason');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `durbin_exempt_reason` SET TAGS ('dbx_value_regex' = 'small_issuer|government|prepaid|reloadable_prepaid|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `emv_chip_required` SET TAGS ('dbx_business_glossary_term' = 'EMV Chip Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `installment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Installment Transaction Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `interchange_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `interchange_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `interchange_fixed_fee` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `interchange_fixed_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `interchange_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `interchange_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `mcc_list` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) List');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `mcc_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Restriction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `mcc_restriction_type` SET TAGS ('dbx_value_regex' = 'all|include|exclude|none');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `recurring_eligible` SET TAGS ('dbx_business_glossary_term' = 'Recurring Transaction Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Scheme Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rule Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rule Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rule Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rule Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|expired');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `scheme_program_code` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Program Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `scheme_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `source_system_rule_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Rule Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `source_system_rule_ref` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,50}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `three_ds_required` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Authentication Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `tokenization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `transaction_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Maximum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `transaction_min_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `durbin_compliance_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Durbin Compliance Tier ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `annual_review_required` SET TAGS ('dbx_business_glossary_term' = 'Annual Regulatory Review Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `applicable_geography` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geography (ISO Country Code)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `applicable_geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `asset_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Issuer Asset Threshold (USD)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range End');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range Start');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `cost_of_acceptance_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost of Acceptance Impact');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `cost_of_acceptance_impact` SET TAGS ('dbx_value_regex' = 'reduces_cost|increases_cost|no_impact');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `debit_card_type` SET TAGS ('dbx_business_glossary_term' = 'Debit Card Program Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `debit_card_type` SET TAGS ('dbx_value_regex' = 'consumer_debit|prepaid|government_benefit|payroll|healthcare_fsa');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `debit_card_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `debit_card_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `emv_chip_required` SET TAGS ('dbx_business_glossary_term' = 'EMV Chip Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `enabled_network_count` SET TAGS ('dbx_business_glossary_term' = 'Enabled Payment Network Count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `fed_regulation_citation` SET TAGS ('dbx_business_glossary_term' = 'Federal Reserve Regulation Citation');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `fed_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Federal Reserve Reporting Period');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `fed_reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(H1|H2|Q1|Q2|Q3|Q4|ANNUAL)$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `fraud_adjustment_cap_cents` SET TAGS ('dbx_business_glossary_term' = 'Fraud Adjustment Cap (Cents per Transaction)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `fraud_adjustment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Fraud Adjustment Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `interchange_cap_ad_valorem_bps` SET TAGS ('dbx_business_glossary_term' = 'Interchange Cap Ad Valorem Rate (Basis Points)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `interchange_cap_cents` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Cap (Cents per Transaction)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `issuer_asset_band` SET TAGS ('dbx_business_glossary_term' = 'Issuer Asset Band');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `issuer_asset_band` SET TAGS ('dbx_value_regex' = 'below_1b|1b_to_5b|5b_to_10b|above_10b');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `issuer_classification` SET TAGS ('dbx_business_glossary_term' = 'Issuer Durbin Classification');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `issuer_classification` SET TAGS ('dbx_value_regex' = 'regulated|exempt|small_issuer_exempt|government_administered|reloadable_prepaid');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Review Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `merchant_routing_choice_enabled` SET TAGS ('dbx_business_glossary_term' = 'Merchant Routing Choice Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `network_exclusivity_compliant` SET TAGS ('dbx_business_glossary_term' = 'Network Exclusivity Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tier Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `pin_debit_routing_required` SET TAGS ('dbx_business_glossary_term' = 'PIN Debit Routing Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `revenue_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Classification');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `revenue_impact_classification` SET TAGS ('dbx_value_regex' = 'revenue_generating|cost_center|neutral');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Debit Routing Message Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'dual_message|single_message|both');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `superseded_by_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tier Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `superseded_by_tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Durbin Compliance Tier Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `tier_description` SET TAGS ('dbx_business_glossary_term' = 'Durbin Compliance Tier Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Durbin Compliance Tier Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Durbin Compliance Tier Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|under_review');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|atm|recurring|ecommerce');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`durbin_compliance_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `arn` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `arn` SET TAGS ('dbx_value_regex' = '^[0-9]{23}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Result Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) / Issuer Identification Number (IIN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `card_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Present Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|purchasing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `contactless_flag` SET TAGS ('dbx_business_glossary_term' = 'Contactless Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Result Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `downgrade_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `downgrade_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Reason Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `emv_chip_flag` SET TAGS ('dbx_business_glossary_term' = 'Europay Mastercard Visa (EMV) Chip Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `irf_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Fixed Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `irf_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `level_2_data_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Level 2 Data Present Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `level_3_data_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Level 3 Data Present Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|downgraded|exempt|error');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `qualification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `three_ds_authentication_flag` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Authentication Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Billing ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `financial_institution_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `card_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Present Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `cycle_identifier` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `gross_interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `interchange_qualification_tier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `interchange_qualification_tier` SET TAGS ('dbx_value_regex' = 'QUALIFIED|MID_QUALIFIED|NON_QUALIFIED|ENHANCED|STANDARD|PREMIUM');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'NOT_STARTED|IN_PROGRESS|RECONCILED|DISCREPANCY|ESCALATED');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `scheme_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `total_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `cost_of_acceptance_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Acceptance ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `msf_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Msf Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `average_ticket_size` SET TAGS ('dbx_business_glossary_term' = 'Average Ticket Size');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `bin_range_count` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range Count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'standard|blended|interchange_plus|tiered|custom');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `card_not_present_volume` SET TAGS ('dbx_business_glossary_term' = 'Card Not Present (CNP) Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `card_present_volume` SET TAGS ('dbx_business_glossary_term' = 'Card Present (CP) Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `chargeback_volume` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `cost_of_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Cost of Acceptance Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `cost_of_acceptance_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|finalized|disputed|adjusted');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `credit_card_volume` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `credit_card_volume` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `credit_card_volume` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `cross_border_volume` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `debit_card_volume` SET TAGS ('dbx_business_glossary_term' = 'Debit Card Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `debit_card_volume` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `debit_card_volume` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `domestic_volume` SET TAGS ('dbx_business_glossary_term' = 'Domestic Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `effective_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Effective Rate (Basis Points)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `gross_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Volume (TPV)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `interchange_qualification_tier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `interchange_qualification_tier` SET TAGS ('dbx_value_regex' = 'qualified|mid_qualified|non_qualified|durbin_exempt|durbin_regulated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `mcc` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `mcc` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `mdr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `net_margin` SET TAGS ('dbx_business_glossary_term' = 'Net Margin');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `refund_volume` SET TAGS ('dbx_business_glossary_term' = 'Refund Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `settlement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `settlement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `total_interchange_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Interchange Reimbursement Fee (IRF) Cost');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `total_msf_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Merchant Service Fee (MSF) Revenue');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `total_scheme_fees` SET TAGS ('dbx_business_glossary_term' = 'Total Scheme Assessment Fees');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `downgrade_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Downgrade ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `risk_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `acquirer_reference_data` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `arn` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `arn` SET TAGS ('dbx_value_regex' = '^[0-9]{23}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Response Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,2}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capture Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `card_present_indicator` SET TAGS ('dbx_business_glossary_term' = 'Card Present Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `card_tier` SET TAGS ('dbx_business_glossary_term' = 'Card Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|purchasing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Response Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `cvv_response_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Detected Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `downgraded_irf_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Downgraded Interchange Reimbursement Fee (IRF) Rate in Basis Points');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `durbin_regulated_indicator` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `emv_chip_transaction` SET TAGS ('dbx_business_glossary_term' = 'Europay Mastercard Visa (EMV) Chip Transaction');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `incremental_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `incremental_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `incremental_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `mcc` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `mcc` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `merchant_processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Merchant Processing Channel');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `merchant_processing_channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|moto|recurring|mobile');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `original_irf_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Original Interchange Reimbursement Fee (IRF) Rate in Basis Points');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Preventable Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `rate_differential_bps` SET TAGS ('dbx_business_glossary_term' = 'Rate Differential in Basis Points');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Reason Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `remediation_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Recommended');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `settlement_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Delay Days');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Authentication Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_value_regex' = 'authenticated|attempted|not_authenticated|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `assessment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Assessment Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `chargeback_processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Processing Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `compliance_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Compliance Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `cross_border_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `interchange_reimbursement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `invoice_document_url` SET TAGS ('dbx_business_glossary_term' = 'Invoice Document URL');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'DRAFT|ISSUED|DISPUTED|PAID|OVERDUE|CANCELLED');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `network_participation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|WIRE|CHECK|DIRECT_DEBIT|CARD');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'PENDING|MATCHED|UNMATCHED|DISPUTED|RESOLVED');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `scheme_service_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheme Service Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Transaction Value');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `scheme_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Line Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `original_invoice_line_scheme_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Line Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `scheme_fee_table_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `adjustment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `authorization_method` SET TAGS ('dbx_business_glossary_term' = 'Authorization Method');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `bin_range_high` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range High');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `bin_range_high` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `bin_range_low` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Range Low');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `bin_range_low` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `card_product_type` SET TAGS ('dbx_business_glossary_term' = 'Card Product Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `cross_border_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `durbin_regulated_indicator` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_rate_type` SET TAGS ('dbx_value_regex' = 'percentage|per_transaction|tiered|flat|basis_points');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_type_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Type Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `fee_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `interchange_qualification_tier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|disputed|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `transaction_value_basis` SET TAGS ('dbx_business_glossary_term' = 'Transaction Value Basis');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `transaction_volume_basis` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Basis');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `revenue_recognition_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Entry Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Partner Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `original_entry_revenue_recognition_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Entry Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `erp_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Batch Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `erp_batch_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `interchange_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Rate Applied');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `mdr_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Applied');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `posted_to_gl_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted to General Ledger (GL) Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `product_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|adjusted|reversed|finalized');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `revenue_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `revenue_type` SET TAGS ('dbx_value_regex' = 'interchange_income|msf_income|scheme_fee_passthrough|gateway_fee|processing_fee|other');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `scheme_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `rate_history_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate History ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `superseded_by_history_rate_history_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By History ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `card_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Present Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `card_product_type` SET TAGS ('dbx_business_glossary_term' = 'Card Product Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `card_product_type` SET TAGS ('dbx_value_regex' = 'CREDIT|DEBIT|PREPAID|COMMERCIAL|PURCHASING');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'ANNUAL_REVIEW|REGULATORY|MARKET_ADJUSTMENT|PRODUCT_LAUNCH|PROGRAM_UPDATE|CORRECTION');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Reason Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `contactless_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Contactless Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `durbin_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `emv_chip_required_flag` SET TAGS ('dbx_business_glossary_term' = 'EMV (Europay Mastercard Visa) Chip Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `installment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Installment Transaction Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `irf_category_name` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Category Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `mcc_list` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) List');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `mcc_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Restriction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `mcc_restriction_type` SET TAGS ('dbx_value_regex' = 'INCLUSIVE|EXCLUSIVE|NONE');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `new_fixed_fee` SET TAGS ('dbx_business_glossary_term' = 'New Interchange Fixed Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `new_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'New Interchange Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `prior_fixed_fee` SET TAGS ('dbx_business_glossary_term' = 'Prior Interchange Fixed Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `prior_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Prior Interchange Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Publication Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|EXPIRED|SUPERSEDED|PENDING');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `recurring_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurring Transaction Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `three_ds_required_flag` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `tokenization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `transaction_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Maximum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `transaction_min_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'PURCHASE|CASH_ADVANCE|BALANCE_TRANSFER|REFUND');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `mcc_interchange_map_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Interchange Map ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `superseded_by_map_mcc_interchange_map_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Map ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `card_not_present_eligible` SET TAGS ('dbx_business_glossary_term' = 'Card Not Present Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `card_present_eligible` SET TAGS ('dbx_business_glossary_term' = 'Card Present Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `contactless_eligible` SET TAGS ('dbx_business_glossary_term' = 'Contactless Payment Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `cross_border_eligible` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'Verified|Unverified|Pending Review|Deprecated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `durbin_compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Compliance Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `durbin_compliance_tier` SET TAGS ('dbx_value_regex' = 'Exempt|Small Issuer|Regulated|Not Applicable');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `emv_chip_required` SET TAGS ('dbx_business_glossary_term' = 'Europay Mastercard Visa (EMV) Chip Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `installment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `interchange_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Currency');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `interchange_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `interchange_fixed_fee` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fixed Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `interchange_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `mapping_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Superseded|Deprecated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `merchant_pricing_impact` SET TAGS ('dbx_business_glossary_term' = 'Merchant Pricing Impact');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `merchant_pricing_impact` SET TAGS ('dbx_value_regex' = 'Standard|Reduced|Premium|Penalty');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `recurring_eligible` SET TAGS ('dbx_business_glossary_term' = 'Recurring Payment Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `scheme_fee_tier` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `scheme_program_code` SET TAGS ('dbx_business_glossary_term' = 'Scheme Program Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `special_program_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Special Program Eligibility');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `three_ds_required` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Authentication Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `tokenization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `transaction_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Maximum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `transaction_min_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `acquiring_portfolio_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Portfolio Pricing Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `appetite_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `durbin_compliance_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Durbin Compliance Tier Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Portfolio Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `acquiring_portfolio_pricing_description` SET TAGS ('dbx_business_glossary_term' = 'Pricing Contract Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `base_interchange_pass_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Base Interchange Pass‑Through Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `compliance_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|pending');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `is_default_pricing` SET TAGS ('dbx_business_glossary_term' = 'Default Pricing Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `is_portfolio_level` SET TAGS ('dbx_business_glossary_term' = 'Portfolio‑Level Pricing Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `markup_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Markup Basis Points');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `monthly_minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Contract Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `per_transaction_markup_amount` SET TAGS ('dbx_business_glossary_term' = 'Per‑Transaction Markup Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_application_scope` SET TAGS ('dbx_business_glossary_term' = 'Pricing Application Scope');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_application_scope` SET TAGS ('dbx_value_regex' = 'all_transactions|card_present|card_not_present|ecommerce|moto');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Pricing Change Reason');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_contract_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Contract Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_currency_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Conversion Rate');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_margin_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Margin Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_margin_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_margin_value` SET TAGS ('dbx_business_glossary_term' = 'Pricing Margin Value');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_value_regex' = 'interchange_plus|flat_rate|tiered|volume_based');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_source_system` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source System');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `pricing_source_system` SET TAGS ('dbx_value_regex' = 'merchant_mgmt|risk_system|custom|erp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|in_review|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `volume_tier_1_markup_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Markup Basis Points');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `volume_tier_1_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Threshold');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `volume_tier_2_markup_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Markup Basis Points');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ALTER COLUMN `volume_tier_2_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Threshold');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `issuer_interchange_income_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Interchange Income ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `card_product_type` SET TAGS ('dbx_business_glossary_term' = 'Card Product Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `durbin_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Durbin Exempt Reason');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `gross_interchange_earned` SET TAGS ('dbx_business_glossary_term' = 'Gross Interchange Earned');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `interchange_qualification_tier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `issuer_name` SET TAGS ('dbx_business_glossary_term' = 'Issuer Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `net_interchange_income` SET TAGS ('dbx_business_glossary_term' = 'Net Interchange Income');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `network_assessment_fee` SET TAGS ('dbx_business_glossary_term' = 'Network Assessment Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `portfolio_segment` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Segment');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|under_review|exception');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `scheme_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `scheme_settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Settlement Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `settlement_cycle_identifier` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|reconciled|disputed|adjusted|finalized');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `interchange_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reconciliation ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `issuing_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `primary_interchange_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `primary_interchange_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `primary_interchange_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `cycle_identifier` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `dispute_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filed Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `internal_calculated_interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Internal Calculated Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `internal_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|disputed|under_review|resolved|escalated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'timing_difference|qualification_mismatch|data_quality|scheme_error|system_error|other');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `scheme_identifier` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `scheme_identifier` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|JCB');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `scheme_reported_interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheme Reported Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `scheme_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Scheme Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `transaction_count_internal` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Internal');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `transaction_count_scheme` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `transaction_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Variance');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `variance_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Exceeded Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `payfac_sub_merchant_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Facilitator (PayFac) Sub-Merchant Pricing ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `acquiring_portfolio_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Portfolio Pricing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `payment_facilitator_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Facilitator (PayFac) Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `sub_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `base_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `batch_fee` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `card_type_tier` SET TAGS ('dbx_business_glossary_term' = 'Card Type Pricing Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `card_type_tier` SET TAGS ('dbx_value_regex' = 'all|debit_only|credit_only|premium_cards|commercial_cards');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `chargeback_fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Processing Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `durbin_regulated_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Regulated Pricing Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `interchange_pass_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Interchange Pass-Through Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `mcc_restriction_list` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Restriction List');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `monthly_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Service Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `monthly_minimum_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Minimum Processing Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `per_transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Per-Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `pricing_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `pricing_configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|interchange_plus|blended|subscription|custom');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `pricing_tier_level` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Level');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `refund_fee` SET TAGS ('dbx_business_glossary_term' = 'Refund Processing Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `revenue_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'PayFac Revenue Split Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `revenue_split_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `risk_reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Reserve Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `scheme_fee_pass_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Pass-Through Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `settlement_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Delay Days');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `transaction_count_cap` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Count Cap');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ALTER COLUMN `volume_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Volume Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Program ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `card_not_present_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Card‑Not‑Present Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `card_present_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Card‑Present Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `card_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Eligible Card Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `card_type_eligibility` SET TAGS ('dbx_value_regex' = 'Credit|Debit|Prepaid|Commercial|Corporate');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Program Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `cross_border_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `eligibility_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `enrollment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Requirements');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Interchange Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `installment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Installment Transaction Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `mcc_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Eligible Merchant Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Retired');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `qualification_criteria_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'Percentage|Fixed|Hybrid');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `recurring_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurring Transaction Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `scheme` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|JCB');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `scheme_bulletin_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Bulletin Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `scheme_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Scheme Publication Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Program Tier Level');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'Tier1|Tier2|Tier3');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `tokenization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `transaction_amount_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `transaction_amount_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `cross_border_fee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fee Rule Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `acquiring_portfolio_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Portfolio Pricing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `superseded_by_rule_cross_border_fee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Cross-Border Fee Rule Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `card_present_indicator` SET TAGS ('dbx_business_glossary_term' = 'Card Present Indicator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `cross_border_assessment_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Assessment Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `cross_border_fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `currency_conversion_fee_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Fee Rate Percentage (Foreign Exchange - FX)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `dcc_fee_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion (DCC) Fee Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `destination_region_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `mcc_list` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) List');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `mcc_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Restriction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `mcc_restriction_type` SET TAGS ('dbx_value_regex' = 'all|include|exclude');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fee Rule Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `originating_country_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `originating_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `originating_region_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority Rank');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fee Rule Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fee Rule Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fee Rule Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|superseded');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `scheme_bulletin_reference` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Bulletin Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `scheme_program_code` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Program Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `swift_correspondent_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Correspondent Banking Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `swift_correspondent_fee_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `swift_correspondent_fee_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `transaction_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Maximum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `transaction_min_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|cash_advance|refund|reversal|chargeback');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `pricing_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Exception Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `acquiring_portfolio_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Portfolio Pricing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `business_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|all');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Exception Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_name` SET TAGS ('dbx_business_glossary_term' = 'Exception Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Exception Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'mdr_discount|msf_waiver|irf_adjustment|volume_incentive|promotional|custom');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `mcc_list` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) List');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `mcc_scope` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC) Scope');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `mcc_scope` SET TAGS ('dbx_value_regex' = 'specific|range|all');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `rate_discount_bps` SET TAGS ('dbx_business_glossary_term' = 'Rate Discount Basis Points (BPS)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `revenue_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Currency');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `revenue_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `revenue_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Estimate');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `revenue_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `standard_fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `standard_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|ecommerce|moto|recurring|all');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `volume_tier_currency` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Currency');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `volume_tier_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `volume_tier_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `volume_tier_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `acquiring_portfolio_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Portfolio Pricing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `superseded_by_tier_volume_tier_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tier ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `applicable_fixed_fee` SET TAGS ('dbx_business_glossary_term' = 'Applicable Fixed Fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `applicable_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Applicable Rate Percent');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `card_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Present Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `card_product_tier` SET TAGS ('dbx_business_glossary_term' = 'Card Product Tier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `card_product_tier` SET TAGS ('dbx_value_regex' = 'standard|gold|platinum|signature|infinite|world_elite');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'debit|credit|prepaid|commercial');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percent');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'irf|mdr|msf|scheme_fee|assessment_fee');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Lower Bound');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'count|currency_amount|percentage');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `threshold_type` SET TAGS ('dbx_value_regex' = 'transaction_count|tpv_amount|monthly_volume|annual_volume|quarterly_volume');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|cash_advance|balance_inquiry');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Upper Bound');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `interchange_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Dispute Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Transaction Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `issuing_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `arn` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|American Express|Discover|UnionPay|JCB');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `claimed_interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `claimed_irf_category_code` SET TAGS ('dbx_business_glossary_term' = 'Claimed Interchange Reimbursement Fee (IRF) Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|pending_response|resolved|closed|withdrawn');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'rate_misapplication|downgrade_disagreement|fee_calculation_error|qualification_error|scheme_reporting_discrepancy');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `durbin_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Regulated Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'initial|second_review|arbitration|final');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filing Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `financial_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `initiator` SET TAGS ('dbx_business_glossary_term' = 'Dispute Initiator');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `initiator` SET TAGS ('dbx_value_regex' = 'acquirer|issuer|platform|scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `mcc` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `mcc` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Outcome');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partially_accepted|withdrawn|escalated');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `respondent` SET TAGS ('dbx_business_glossary_term' = 'Dispute Respondent');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `respondent` SET TAGS ('dbx_value_regex' = 'acquirer|issuer|platform|scheme');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `scheme_applied_irf_category_code` SET TAGS ('dbx_business_glossary_term' = 'Scheme Applied Interchange Reimbursement Fee (IRF) Category Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `scheme_case_number` SET TAGS ('dbx_business_glossary_term' = 'Scheme Case Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `scheme_reported_interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheme Reported Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` SET TAGS ('dbx_subdomain' = 'fee_configuration');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` SET TAGS ('dbx_association_edges' = 'interchange.interchange_program,fx.fx_fee_schedule');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ALTER COLUMN `program_fee_schedule_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Programfeescheduleassignment - Program Fee Schedule Assignment Id');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Programfeescheduleassignment - Fx Fee Schedule Id');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Programfeescheduleassignment - Interchange Program Id');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ALTER COLUMN `fee_type_override` SET TAGS ('dbx_business_glossary_term' = 'Fee Type Override');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_tier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_tier` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_tier` ALTER COLUMN `pricing_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_tier` ALTER COLUMN `fallback_pricing_tier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
