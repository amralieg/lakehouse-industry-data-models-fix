-- Schema for Domain: interchange | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`interchange` COMMENT 'SSOT for network and interchange economics — IRF tables, MDR configurations, MSF schedules, scheme fee structures, BIN-level interchange qualification rules, and Durbin Amendment compliance tiers. Supports revenue recognition and cost-of-acceptance calculations for acquiring and issuing portfolios.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`irf_table` (
    `irf_table_id` BIGINT COMMENT 'Unique identifier for the interchange reimbursement fee table record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Interchange rate tables publish rates per currency pair (e.g., USD/EUR domestic vs cross-border rates). Essential for multi-currency interchange rate management and scheme compliance reporting across ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Interchange rate tables drive automated GL posting rules for revenue recognition. Each rate category maps to specific revenue accounts for financial statement preparation and regulatory reporting.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: irf_table references its category; adds irf_rate_category_id FK to irf_rate_category',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: irf_table.program_identifier (STRING) stores the scheme program code that governs this IRF rate entry (e.g., Visa Utility, Mastercard Merit). The program product is the authoritative master for card s',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Interchange rate tables are published by specific card schemes. Scheme bulletin reconciliation, rate audits, and interchange cost management all require linking each rate table to its governing scheme',
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
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Acquiring banks are legal entities requiring KYC/AML verification tracked as compliance parties. Regulatory reporting (SAR, CTR) and audit trails require party-level compliance data for all acquiring ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: MDR configurations are owned by specific cost centers for P&L attribution. Required for sales team performance tracking, revenue accountability, and merchant portfolio profitability analysis.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: MDR configurations specify pricing for specific currency pairs in cross-border merchant acquiring. Required for currency-specific merchant discount rate calculation and international merchant pricing ',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier for the acquiring bank or payment facilitator providing merchant services under this MDR configuration.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: mdr_config has mid as a plain denormalized attribute. MDR configuration is merchant-specific and must be linked to the merchant for pricing management, revenue reporting, and MDR rate change workflows',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: MDR configurations are established by acquiring participants for their merchant portfolios. Linking mdr_config to the acquiring participant enables participant-level MDR portfolio management and inter',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: MDR configurations define merchant discount rates for specific payment products (credit cards, debit cards, digital wallets). Acquirers price merchants based on payment product type. Essential for mer',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: MDR configurations are scheme-specific — Visa interchange-plus pricing differs from Mastercard. Scheme-level MDR reporting, pricing audits, and acquirer scheme compliance reviews all require this link',
    `approval_status` STRING COMMENT 'Approval workflow status for this MDR configuration before it becomes active.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this MDR configuration was approved.',
    `blended_rate_percent` DECIMAL(18,2) COMMENT 'The blended MDR percentage applied to all transactions for this merchant, expressed as a decimal (e.g., 0.0275 for 2.75%).',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: MSF schedules are managed by cost centers for revenue accountability. Links merchant service fee revenue to organizational units for performance measurement and budget tracking.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Merchant service fee schedules vary by currency pair for international merchants accepting multiple currencies. Enables currency-pair-specific fee structures and multi-currency merchant billing.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: MSF schedules define merchant service fee revenue streams that post to specific GL accounts. Required for revenue recognition, financial reporting, and merchant profitability analysis.',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: MSF schedules apply to specific merchant processing accounts (e.g., separate schedules for card-present vs. e-commerce accounts). Linking msf_schedule to merchant_account enables account-level fee sch',
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant to whom this fee schedule applies.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: MSF schedules are configured by acquiring participants for their merchant portfolios. Participant-level MSF portfolio management, revenue reporting, and compliance monitoring require linking MSF sched',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Merchant service fee schedules apply to specific payment products. Fee structures vary by product (contactless vs. chip, domestic vs. international). Required for merchant billing systems and contract',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Merchant service fee schedules are risk-adjusted. High-risk merchants pay premium fees, early termination fees, and higher chargeback fees. Risk profile drives fee schedule assignment and approval.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual membership or service fee charged to the merchant.',
    `approval_status` STRING COMMENT 'Approval workflow status for this fee schedule configuration.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule was approved.',
    `avs_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per Address Verification System check performed during transaction authorization.',
    `batch_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per batch settlement submission by the merchant.',
    `chargeback_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the merchant for each chargeback dispute processed.',
    `contract_term_months` STRING COMMENT 'Duration in months for which this fee schedule is contractually binding.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all fee amounts in this schedule are denominated.. Valid values are `^[A-Z]{3}$`',
    `durbin_exempt_flag` BOOLEAN COMMENT 'Indicates whether this fee schedule applies to Durbin Amendment exempt transactions (small issuer or government/reloadable prepaid cards).',
    `early_termination_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged if the merchant terminates the agreement before the contract term expires.',
    `effective_end_date` DATE COMMENT 'Date when this fee schedule expires or is no longer applicable. Null indicates open-ended schedule.',
    `effective_start_date` DATE COMMENT 'Date when this fee schedule becomes active and applicable to merchant transactions.',
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
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Scheme fees are published per currency pair with different rates for domestic vs cross-border transactions. Critical for accurate scheme fee calculation in multi-currency payment processing.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Scheme fees are posted to specific expense GL accounts. Fee tables require GL account mapping for automated posting during settlement reconciliation and scheme invoice processing.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Scheme fee tables are published by specific card schemes (Visa, Mastercard). Scheme fee reconciliation, billing audits, and regulatory reporting all require knowing which scheme published each fee tab',
    `volume_tier_threshold_id` BIGINT COMMENT 'Foreign key linking to interchange.volume_tier_threshold. Business justification: scheme_fee_table embeds volume tier bounds (volume_tier_lower_bound, volume_tier_upper_bound, volume_tier_unit) directly on the fee record. The volume_tier_threshold product is the authoritative SSOT ',
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
    CONSTRAINT pk_scheme_fee_table PRIMARY KEY(`scheme_fee_table_id`)
) COMMENT 'Card scheme assessment and network fee table capturing all fees levied by Visa, Mastercard, Amex, Discover, and other schemes on acquirers and issuers. Includes assessment rates, network access fees, cross-border fees, digital enablement fees, misuse-of-authorization fees, and scheme-specific surcharges. Effective date ranges and volume tier thresholds are tracked for accurate cost modeling.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` (
    `bin_interchange_rule_id` BIGINT COMMENT 'Unique surrogate primary key identifying a BIN-level interchange qualification rule record in the silver layer lakehouse. Entity role: MASTER_RESOURCE — represents a configuration/rule resource governing interchange qualification for a BIN range.',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: BIN-based interchange rules determine rates for specific card programs (rewards, corporate, prepaid). Issuers configure interchange eligibility by card program. Critical for interchange qualification ',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: BIN-level interchange rules define eligible currency pairs for cross-border routing and rate application. Required for BIN-based currency eligibility validation and cross-border transaction routing de',
    `ecosystem_partner_id` BIGINT COMMENT 'Reference to the issuing bank or financial institution that issued the card associated with this BIN range. The issuing bank is the cardholders bank in the payment chain.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: bin_interchange_rule references IRF category; adds irf_rate_category_id FK',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: bin_interchange_rule.scheme_program_code (STRING) stores the card scheme program code that governs the BIN-level interchange qualification rule (e.g., Visa CPS, Mastercard Merit). The program product ',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: BIN-level interchange rules are risk-segmented by issuer. Issuer risk profiles determine rule applicability, rate eligibility, and Durbin regulation status. Critical for issuer onboarding and rate tab',
    `scheme_id` BIGINT COMMENT 'Reference to the card scheme (payment network brand) governing this interchange rule, such as Visa, Mastercard, American Express, or Discover. Links to the scheme reference product.',
    `superseded_by_rule_bin_interchange_rule_id` BIGINT COMMENT 'Reference to the bin_interchange_rule_id of the newer rule that supersedes this record when rule_status is superseded. Enables rule lineage tracking and historical interchange qualification reconstruction.',
    `authorization_indicator` STRING COMMENT 'Specifies the type of authorization associated with this interchange rule: pre-authorization (hotel/car rental), final authorization, or incremental authorization. Different authorization types may qualify for distinct interchange rates.. Valid values are `pre_auth|final_auth|incremental|undefined`',
    `avs_required` BOOLEAN COMMENT 'Indicates whether Address Verification System (AVS) check is required for a transaction to qualify for this interchange rate category. AVS validation is a fraud prevention measure commonly required for card-not-present interchange qualification.',
    `bin_range_end` STRING COMMENT 'The ending BIN (Bank Identification Number) of the BIN range to which this interchange qualification rule applies. Together with bin_range_start, defines the full BIN range covered by this rule.. Valid values are `^[0-9]{6,11}$`',
    `bin_range_start` STRING COMMENT 'The starting BIN (Bank Identification Number), also known as IIN (Issuer Identification Number), of the BIN range to which this interchange qualification rule applies. Supports 6-digit legacy BINs and 8-digit extended BINs per ISO/IEC 7812.. Valid values are `^[0-9]{6,11}$`',
    `card_not_present_eligible` BOOLEAN COMMENT 'Indicates whether this interchange rule applies to card-not-present (CNP) transactions, such as e-commerce, mail order, or telephone order (MOTO) transactions. CNP transactions typically carry higher interchange rates due to elevated fraud risk.',
    `card_present_eligible` BOOLEAN COMMENT 'Indicates whether this interchange rule applies to card-present (CP) transactions, where the physical card or device is used at a POS or mPOS terminal. Card-present transactions typically qualify for lower interchange rates than card-not-present.',
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
    `source_system_rule_ref` STRING COMMENT 'The native rule identifier or reference code from the originating operational system (Transaction Processing Platform or Payment Gateway) from which this BIN interchange rule was sourced. Supports data lineage and reconciliation back to the system of record.. Valid values are `^[A-Za-z0-9_-]{1,50}$`',
    `three_ds_required` BOOLEAN COMMENT 'Indicates whether 3-D Secure (3DS) authentication is required for card-not-present transactions to qualify for this interchange rate. 3DS-authenticated transactions may qualify for lower interchange rates and shift fraud liability to the issuer. Relevant under PSD2 SCA requirements.',
    `tokenization_eligible` BOOLEAN COMMENT 'Indicates whether transactions using a DPAN (Device Primary Account Number) or network token issued by a TSP (Token Service Provider) for this BIN range are eligible for this interchange rate. Tokenized transactions may qualify for distinct interchange rates.',
    `transaction_max_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount (in the fee currency) eligible for this interchange rate category. Transactions exceeding this threshold may be subject to different interchange rates or require additional qualification criteria.',
    `transaction_min_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount (in the fee currency) required for a transaction to qualify for this interchange rate category. Transactions below this threshold may downgrade to a less favorable interchange tier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this BIN interchange rule record was last modified in the data platform. Supports change tracking, rule versioning audit, and regulatory compliance reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `version_number` STRING COMMENT 'Sequential version number of this BIN interchange rule record, incremented each time the rule is updated. Supports rule versioning and historical interchange qualification audit trails required for regulatory compliance and dispute resolution.',
    CONSTRAINT pk_bin_interchange_rule PRIMARY KEY(`bin_interchange_rule_id`)
) COMMENT 'BIN (Bank Identification Number) level interchange qualification rules mapping BIN ranges to applicable interchange rate categories. Captures BIN range start/end, issuing bank identifier, card product type (debit, credit, prepaid, commercial), regulated/unregulated flag under Durbin Amendment, applicable IRF category codes, and scheme identifier. Core to real-time interchange qualification during transaction processing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the interchange qualification record. Primary key for this transactional record of interchange rate qualification outcome.',
    `bin_interchange_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.bin_interchange_rule. Business justification: A qualification record captures the interchange rate qualification outcome for a cleared transaction. The BIN interchange rule is the governing rule that determined which rate category applied to that',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Interchange qualification for high-value or cross-border transactions requires cardholder compliance checks (sanctions screening, PEP status). Real business process: enhanced due diligence on transact',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: interchange_qualification references qualified IRF category; adds irf_rate_category_id FK',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Interchange qualification occurs at the transaction level, which maps to a specific merchant location. Linking qualification to merchant_location enables location-level interchange qualification analy',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant who accepted the transaction. Links to merchant management system for merchant-level interchange analysis and cost-of-acceptance reporting.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Transaction qualification determines which payment products interchange rules apply. Qualification engines route transactions to correct product configurations. Essential for real-time authorization ',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Interchange qualification rules are scheme-specific — Visa and Mastercard have different qualification criteria for the same transaction. Qualification reporting, downgrade root-cause analysis, and sc',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: Enables qualification data to be associated with the settlement cycle used in interchange fee calculations and audit trails.',
    `transaction_id` BIGINT COMMENT 'Reference to the cleared transaction for which interchange qualification was performed. Links to the transaction processing platform record.',
    `arn` STRING COMMENT 'Unique 23-digit acquirer reference number assigned to the transaction by the acquiring bank. Used for transaction tracing across the payment network.. Valid values are `^[0-9]{23}$`',
    `authorization_date` DATE COMMENT 'Date on which the transaction was authorized. Time between authorization and settlement is a factor in interchange qualification.',
    `avs_result_code` STRING COMMENT 'Result code from address verification system check performed during authorization. AVS match is a qualifying criterion for many card-not-present interchange categories.',
    `bin` STRING COMMENT 'First 6-8 digits of the card number identifying the issuing bank and card program. BIN-level interchange qualification rules determine which IRF category applies based on issuer and card product.. Valid values are `^[0-9]{6,8}$`',
    `card_present_flag` BOOLEAN COMMENT 'Indicates whether the transaction was card-present (face-to-face) or card-not-present (e-commerce, mail order, phone order). Card-present transactions typically qualify for lower interchange rates.',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Billing cycles reference specific partner agreements for contract terms, rate schedules, and revenue share calculations. Critical for reconciliation, compliance audits, and dispute resolution in payme',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Interchange billing is generated at the processing account level. Linking billing to merchant_account enables account-level billing reconciliation, multi-account merchant billing separation, and accou',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Interchange billing is issued to/from settlement participants (acquirers, issuers). Participant-level billing reconciliation and participant statement generation require linking billing to the settlem',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Interchange billing aggregates revenue by payment product for financial reporting. Acquirers track interchange income per product line. Required for revenue recognition, product P&L analysis, and regu',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Billing statements must reference the FX rate applied to net settlement amounts for cross‑border billing reconciliation.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Interchange billing cycles are scheme-specific — Visa and Mastercard bill separately on different schedules. Billing reconciliation reports, scheme fee audits, and interchange cost allocation are alwa',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Interchange billing records are associated with a scheme invoice; adds scheme_invoice_id FK',
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
    `accounting_period_id` BIGINT COMMENT 'Reference to the settlement period during which these costs were incurred.',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: Cost-of-acceptance analysis is often triggered by compliance cases investigating pricing exceptions, merchant complaints, or regulatory inquiries. Real business process: compliance investigations requ',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: cost_of_acceptance aggregates interchange fees and MSF revenue per merchant per settlement period. The MDR configuration (mdr_config) defines the contractual MDR applied to the merchant, which is a pr',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: cost_of_acceptance already links to merchant but cost calculations occur at the processing account level. Linking to merchant_account enables account-level effective rate analysis, multi-account cost ',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant for whom this cost of acceptance is calculated.',
    `msf_schedule_id` BIGINT COMMENT 'Foreign key linking to interchange.msf_schedule. Business justification: cost_of_acceptance aggregates fees for a merchant schedule; adds msf_schedule_id FK',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Cost of acceptance analysis calculates effective rates per payment product. Merchants compare acceptance costs across products (debit vs. credit, domestic vs. international). Essential for merchant pr',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Cost of acceptance calculations for cross-border transactions require FX rates to normalize costs to merchant reporting currency. Essential for accurate multi-currency cost analysis and merchant profi',
    `ratio_monitor_id` BIGINT COMMENT 'Foreign key linking to dispute.ratio_monitor. Business justification: Cost of acceptance analysis for merchant profitability incorporates chargeback ratio monitoring. Merchants breaching ratio thresholds face higher effective rates. Monthly COA reports reference current',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Cost of acceptance analysis includes risk-adjusted pricing. Merchant risk tier affects effective rate calculation, downgrade frequency, and net margin. Required for profitability analysis and merchant',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Cost of acceptance analysis covers a settlement period; linking to the settlement batch enables period-level reconciliation of total interchange costs against settlement batch totals — a standard merc',
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
    `clearing_record_id` BIGINT COMMENT 'Foreign key linking to settlement.clearing_record. Business justification: Interchange downgrades are identified against specific cleared transactions. Linking downgrade to clearing_record enables downgrade analysis, remediation tracking, and clearing-level interchange audit',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: interchange_downgrade references both original and downgraded IRF categories; adds irf_rate_category_id FK',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Downgrades are associated with transactions at specific merchant locations. Linking downgrade to merchant_location enables location-level downgrade analysis, targeted remediation (e.g., terminal upgra',
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant whose transaction was downgraded.',
    `acquirer_reference_data` STRING COMMENT 'Additional reference data provided by the acquiring bank for tracking and reconciliation purposes.',
    `arn` STRING COMMENT 'Unique 23-digit reference number assigned by the acquiring bank to track the transaction across the payment network.. Valid values are `^[0-9]{23}$`',
    `authorization_timestamp` TIMESTAMP COMMENT 'The precise date and time when the transaction was authorized by the issuing bank.',
    `avs_response_code` STRING COMMENT 'Code returned by the issuer indicating the result of address verification, which is often required for optimal interchange qualification.. Valid values are `^[A-Z0-9]{1,2}$`',
    `bin` STRING COMMENT 'First 6-8 digits of the card number identifying the issuing bank and card product type.. Valid values are `^[0-9]{6,8}$`',
    `capture_timestamp` TIMESTAMP COMMENT 'The precise date and time when the authorized transaction was captured for settlement.',
    `card_present_indicator` BOOLEAN COMMENT 'Flag indicating whether the transaction was card-present (true) or card-not-present (false), which affects interchange qualification.',
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
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Scheme invoices for network participation fees and assessments are issued to or allocated across ecosystem partners (acquirers, processors). Direct link required for AP/AR processing and cost center a',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Required for GL posting of scheme invoices; financial reporting mandates linking each invoice to its GL account.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Scheme invoices are issued to specific settlement participants (acquirers/issuers). Participant-level scheme invoice management and payment tracking are mandatory scheme compliance requirements in car',
    `payable_id` BIGINT COMMENT 'Foreign key linking to ledger.payable. Business justification: Scheme invoices become payables in the ledger - natural accounts payable workflow. Links scheme billing to AP processing, payment scheduling, and cash management.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Scheme invoices may be issued in various currencies; linking to the FX rate enables accurate accounting and audit of converted totals.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Scheme invoices are issued by specific card schemes for network participation, assessment, and service fees. Accounts payable reconciliation, scheme fee dispute management, and regulatory reporting al',
    `settlement_account_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_account. Business justification: Scheme invoices are paid from/to designated settlement accounts. The payment of scheme fees requires knowing which settlement account is debited/credited — a core treasury and scheme fee payment opera',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`program` (
    `program_id` BIGINT COMMENT 'Unique surrogate key for the interchange program.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Interchange programs (Visa SMI, Mastercard Merit) are often co-sponsored or managed by specific ecosystem partners. Direct link needed for program eligibility verification, enrollment management, and ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Interchange programs embed risk policies. Program eligibility requires risk policy compliance (e.g., Durbin regulation, installment eligibility, cross-border restrictions). Essential for program confi',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Program eligibility and rate structures must comply with specific regulatory obligations; linking enables compliance checks and reporting.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Interchange programs (e.g. Visa Signature, Mastercard World Elite) are defined and governed by a specific card scheme. Program enrollment, BIN rule matching, and interchange qualification all require ',
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
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Cross-border fee rules explicitly define fees per currency pair corridor (e.g., USD→EUR vs EUR→GBP). Core business requirement for currency-pair-specific cross-border fee calculation and routing.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Cross-border fee rules map to payment corridors defining country-currency-rail combinations. Essential for corridor-based fee routing, regulatory compliance, and settlement path determination in cross',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Cross-border fee rules apply differently to payment products (international cards, multi-currency wallets). Payment products have varying cross-border eligibility. Required for international transacti',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Cross-border fee rules enforce risk policies. High-risk corridors, sanctioned countries, and AML-flagged regions have elevated fees per risk policy. Required for regulatory compliance and fee rule con',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: cross_border_fee_rule.scheme_program_code (STRING) stores the card scheme program code associated with the cross-border fee rule (e.g., a specific Visa or Mastercard cross-border program). The program',
    `scheme_id` BIGINT COMMENT 'Reference to the card scheme (Visa, Mastercard, etc.) to which this cross-border fee rule applies.',
    `superseded_by_rule_cross_border_fee_rule_id` BIGINT COMMENT 'Reference to the cross-border fee rule that replaces this rule when it is superseded. Supports rule lineage and historical analysis.',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Pricing exceptions reference specific contractual agreements authorizing deviations from standard rates. Critical for audit trail, contract compliance verification, and regulatory reporting in payment',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Pricing exceptions for international merchants specify currency pair scope for negotiated rates. Required for currency-specific pricing overrides and multi-currency merchant contract management.',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: pricing_exception is tied to an MDR configuration; adds mdr_config_id FK',
    `merchant_pricing_plan_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_pricing_plan. Business justification: A pricing exception overrides or modifies a standard merchant pricing plan. Linking pricing_exception to merchant_pricing_plan is required for contract management, exception approval workflows, and re',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Pricing exceptions are negotiated with specific acquiring participants for their merchant portfolios. Participant-level exception management, contract compliance monitoring, and revenue impact reporti',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Pricing exceptions grant custom rates for specific payment products. Large merchants negotiate product-specific discounts. Essential for contract management systems and exception approval workflows.',
    `volume_tier_threshold_id` BIGINT COMMENT 'Foreign key linking to interchange.volume_tier_threshold. Business justification: pricing_exception.volume_tier_threshold (DECIMAL) stores the volume threshold amount at which the negotiated pricing exception activates. The volume_tier_threshold product is the authoritative SSOT fo',
    `approval_authority` STRING COMMENT 'Name or title of the executive or committee that authorized this pricing exception (e.g., Chief Revenue Officer, Pricing Committee, Regional VP).',
    `approval_date` DATE COMMENT 'The date on which this pricing exception was formally approved by the designated authority.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this pricing exception automatically renews at the end of its term. True means exception continues unless terminated, false means it expires on effective_end_date.',
    `business_justification` STRING COMMENT 'Detailed explanation of the business rationale for granting this exception, including competitive factors, strategic value, volume commitments, or relationship considerations.',
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
    CONSTRAINT pk_pricing_exception PRIMARY KEY(`pricing_exception_id`)
) COMMENT 'Records negotiated pricing exceptions and custom interchange arrangements granted to specific merchants, portfolios, or partners that deviate from standard MDR or MSF schedules. Captures exception type, merchant or portfolio identifier, standard rate, exception rate, basis point discount, approval authority, effective date, expiry date, and business justification. Supports audit and contract compliance tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` (
    `volume_tier_threshold_id` BIGINT COMMENT 'Unique identifier for the volume tier threshold configuration record.',
    `acquirer_id` BIGINT COMMENT 'Acquiring bank or payment service provider identifier for acquirer-specific tier configurations. Null indicates tier applies across all acquirers.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Volume-based pricing tiers are risk-gated. Threshold access requires risk policy compliance (e.g., fraud rate limits, chargeback ratios). Essential for tiered pricing eligibility and merchant portfoli',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ADD CONSTRAINT `fk_interchange_scheme_fee_table_volume_tier_threshold_id` FOREIGN KEY (`volume_tier_threshold_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`volume_tier_threshold`(`volume_tier_threshold_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_superseded_by_rule_bin_interchange_rule_id` FOREIGN KEY (`superseded_by_rule_bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_bin_interchange_rule_id` FOREIGN KEY (`bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_msf_schedule_id` FOREIGN KEY (`msf_schedule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`msf_schedule`(`msf_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_superseded_by_rule_cross_border_fee_rule_id` FOREIGN KEY (`superseded_by_rule_cross_border_fee_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule`(`cross_border_fee_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_volume_tier_threshold_id` FOREIGN KEY (`volume_tier_threshold_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`volume_tier_threshold`(`volume_tier_threshold_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_superseded_by_tier_volume_tier_threshold_id` FOREIGN KEY (`superseded_by_tier_volume_tier_threshold_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`volume_tier_threshold`(`volume_tier_threshold_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`interchange` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`interchange` SET TAGS ('dbx_domain' = 'interchange');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Table ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ALTER COLUMN `blended_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Blended Rate Percentage');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `msf_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Service Fee (MSF) Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification (MID) Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `avs_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `batch_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `chargeback_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `durbin_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `early_termination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `scheme_fee_table_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Table ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ALTER COLUMN `volume_tier_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) Interchange Rule ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_not_present_eligible` SET TAGS ('dbx_business_glossary_term' = 'Card Not Present Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `card_present_eligible` SET TAGS ('dbx_business_glossary_term' = 'Card Present Eligible Flag');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `source_system_rule_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Rule Reference');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `source_system_rule_ref` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,50}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `three_ds_required` SET TAGS ('dbx_business_glossary_term' = '3-D Secure (3DS) Authentication Required Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `tokenization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Eligible Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `transaction_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Maximum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `transaction_min_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Interchange Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `arn` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `arn` SET TAGS ('dbx_value_regex' = '^[0-9]{23}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Result Code');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN) / Issuer Identification Number (IIN)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ALTER COLUMN `card_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Present Flag');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Billing ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `cost_of_acceptance_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Acceptance ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `msf_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Msf Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `ratio_monitor_id` SET TAGS ('dbx_business_glossary_term' = 'Ratio Monitor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `downgrade_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Downgrade ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `clearing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `payable_id` SET TAGS ('dbx_business_glossary_term' = 'Payable Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ALTER COLUMN `settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Program ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `cross_border_fee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Fee Rule Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ALTER COLUMN `superseded_by_rule_cross_border_fee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Cross-Border Fee Rule Identifier (ID)');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `pricing_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Exception Identifier (ID)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `merchant_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Pricing Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `volume_tier_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ALTER COLUMN `business_justification` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `volume_tier_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
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
