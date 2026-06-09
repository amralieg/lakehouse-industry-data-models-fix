-- Schema for Domain: fx | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`fx` COMMENT 'Owns cross-border payment and foreign exchange operations — FX rate feeds, DCC transaction records, currency conversion audit trails, SWIFT/IBAN routing configurations, correspondent banking relationships, and multi-currency settlement instructions across 200+ countries.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`rate` (
    `rate_id` BIGINT COMMENT 'System-generated unique identifier for each FX rate record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Each fx_rate belongs to a currency pair; linking eliminates the free‑text pair field and enforces referential integrity.',
    `rate_feed_id` BIGINT COMMENT 'Foreign key linking to fx.rate_feed. Business justification: fx_rate records are produced by a specific rate feed and belong to a currency pair; linking removes duplicated source fields and enables traceability to the feed and pair.',
    `ask_price` DECIMAL(18,2) COMMENT 'Price at which the market maker is willing to sell the base currency.',
    `base_currency` STRING COMMENT 'Currency being quoted (the numerator in the pair).. Valid values are `^[A-Z]{3}$`',
    `bid_price` DECIMAL(18,2) COMMENT 'Price at which the market maker is willing to buy the base currency.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Provider‑assigned confidence level (0‑100) indicating reliability of the rate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the FX rate record was first inserted into the lakehouse.',
    `cross_border_indicator` BOOLEAN COMMENT 'True if the rate is used for a cross‑border transaction.',
    `effective_timestamp` TIMESTAMP COMMENT 'Date‑time when the rate becomes effective for transaction conversion.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the rate ceases to be valid; null for open‑ended rates.',
    `external_rate_code` STRING COMMENT 'Reference code used by the external provider to identify this specific rate.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the rate is currently active for use in transaction processing.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the rate record.. Valid values are `active|inactive|deprecated|pending`',
    `market_region` STRING COMMENT 'Geographic region of the market where the rate is sourced or applied.. Valid values are `EMEA|APAC|Americas`',
    `mid_price` DECIMAL(18,2) COMMENT 'Average of bid and ask prices; often used as the reference rate.',
    `notes` STRING COMMENT 'Free‑form field for any additional remarks or manual adjustments.',
    `precision` STRING COMMENT 'Number of decimal places provided for the rate value.',
    `quote_currency` STRING COMMENT 'Currency used to express the rate (the denominator in the pair).. Valid values are `^[A-Z]{3}$`',
    `rate_type` STRING COMMENT 'Classification of the FX rate indicating its purpose and calculation method.. Valid values are `spot|forward|indicative|guaranteed|historical|mid_market`',
    `rate_value` DECIMAL(18,2) COMMENT 'Primary exchange rate value expressed as the amount of quote currency per one unit of base currency.',
    `spread` DECIMAL(18,2) COMMENT 'Difference between ask and bid prices, expressed in quote currency units.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the FX rate record.',
    CONSTRAINT pk_rate PRIMARY KEY(`rate_id`)
) COMMENT 'Master record for foreign exchange rates published and consumed by the payments platform. Captures spot rates, mid-market rates, bid/ask spreads, and indicative rates for every currency pair supported across 200+ countries. Sourced from primary rate feed providers (Reuters, Bloomberg, ECB) and internal treasury desks. Serves as the authoritative rate reference for DCC pricing, cross-border transaction conversion, and settlement FX calculations. Includes rate type classification (spot, forward, indicative, guaranteed), effective timestamp, expiry timestamp, rate source, and confidence band.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`rate_feed` (
    `rate_feed_id` BIGINT COMMENT 'System‑generated unique identifier for each FX rate feed configuration.',
    `authentication_method` STRING COMMENT 'Mechanism used to authenticate the connection to the external feed source.. Valid values are `API_KEY|OAUTH|CERTIFICATE|NONE`',
    `compliance_regulation` STRING COMMENT 'Comma‑separated list of regulations governing the feed (e.g., PCI DSS, GDPR, PSD2).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rate feed record was first inserted into the lakehouse.',
    `credential_type` STRING COMMENT 'Category of credential used (e.g., API key, client certificate). Actual secret values are stored in a vault, not in this table.',
    `data_format` STRING COMMENT 'File or message format in which rates are delivered.. Valid values are `JSON|XML|CSV|FIX`',
    `effective_from` DATE COMMENT 'Date on which the feed configuration starts being used for rate ingestion.',
    `effective_until` DATE COMMENT 'Date after which the feed configuration is no longer active; null indicates indefinite validity.',
    `encryption_protocol` STRING COMMENT 'Specific encryption protocol negotiated for the feed connection.. Valid values are `TLS1.2|TLS1.3|SSH`',
    `failover_priority` STRING COMMENT 'Rank used to select an alternate feed when the primary feed is unavailable (lower = higher priority).',
    `feed_endpoint` STRING COMMENT 'Network address (URL, host:port, or file path) where the rate feed is accessed.',
    `feed_protocol` STRING COMMENT 'Technical protocol through which the FX rates are delivered to the platform.. Valid values are `REST|FIX|SFTP|FTP|API`',
    `is_encrypted` BOOLEAN COMMENT 'True if the feed connection uses encryption (TLS/SSH).',
    `last_error_code` STRING COMMENT 'Standardized code identifying the reason for the most recent feed failure.',
    `last_error_message` STRING COMMENT 'Detailed message describing the most recent feed retrieval error.',
    `last_failure_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent poll that resulted in an error.',
    `last_success_timestamp` TIMESTAMP COMMENT 'Date‑time of the last successful poll of the external rate feed.',
    `polling_frequency_seconds` STRING COMMENT 'How often the platform requests new rates from the provider.',
    `provider_code` STRING COMMENT 'Unique business code assigned to the provider for contract and reporting purposes.',
    `provider_name` STRING COMMENT 'Human‑readable name of the external FX rate feed provider (e.g., Reuters Refinitiv, Bloomberg FX).',
    `rate_feed_description` STRING COMMENT 'Narrative description providing context, notes, or special handling instructions for the feed.',
    `rate_feed_status` STRING COMMENT 'Lifecycle state of the rate feed configuration.. Valid values are `active|inactive|degraded|maintenance|retired`',
    `rate_type` STRING COMMENT 'Classification of the FX rate (spot, forward, mid‑market, inter‑bank).. Valid values are `SPOT|FORWARD|MID|INTERBANK`',
    `sla_response_time_ms` STRING COMMENT 'Target maximum latency for a successful feed retrieval as defined in the provider SLA.',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Minimum acceptable availability of the feed over a month, expressed as a percent.',
    `timezone` STRING COMMENT 'IANA timezone identifier (e.g., UTC, Europe/London) used for timestamps supplied by the provider.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the rate feed record.',
    CONSTRAINT pk_rate_feed PRIMARY KEY(`rate_feed_id`)
) COMMENT 'Master configuration record for each external FX rate feed provider integrated into the platform. Defines the provider identity (Reuters Refinitiv, Bloomberg FX, ECB reference rates, internal treasury), feed protocol (REST, FIX, SFTP), polling frequency, supported currency pairs, rate type delivered, SLA thresholds, failover priority, and connectivity credentials metadata. Governs how the platform ingests, validates, and routes rate data from each upstream source. Critical for rate feed health monitoring and provider SLA management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`currency_pair` (
    `currency_pair_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying a currency pair record.',
    `classification` STRING COMMENT 'Business classification of the pair (major, minor, or exotic).. Valid values are `major|minor|exotic`',
    `cross_border_eligible` BOOLEAN COMMENT 'True if the pair may be used for cross‑border payment routing.',
    `currency_pair_description` STRING COMMENT 'Free‑form description or notes about the currency pair.',
    `currency_pair_status` STRING COMMENT 'Current lifecycle status of the currency pair.. Valid values are `active|inactive|deprecated`',
    `dcc_eligible` BOOLEAN COMMENT 'True if the pair is eligible for DCC transactions.',
    `decimal_precision` STRING COMMENT 'Number of decimal places supported for pricing the pair.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this pair is the default for a given corridor or product.',
    `last_rate_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent rate update for the pair.',
    `market_convention` STRING COMMENT 'Indicates whether the pair is quoted directly (base/quote) or indirectly.. Valid values are `direct|indirect`',
    `min_tradeable_unit` DECIMAL(18,2) COMMENT 'Smallest amount of the base currency that can be traded or converted.',
    `pair_name` STRING COMMENT 'Human‑readable concatenation of base and quote currency codes.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the currency pair record was created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `settlement_currency_code` STRING COMMENT 'Currency in which settlement amounts are settled.. Valid values are `^[A-Z]{3}$`',
    `settlement_type` STRING COMMENT 'Settlement speed category for the pair.. Valid values are `instant|same_day|t+1|t+2`',
    `source_feed` STRING COMMENT 'Origin of the FX rate feed for the pair.. Valid values are `internal|external|third_party`',
    `source_feed_version` STRING COMMENT 'Version identifier of the rate feed source.',
    `standard_pip_size` DECIMAL(18,2) COMMENT 'Standard pip size used for price quoting of the pair.',
    `trading_end_time` TIMESTAMP COMMENT 'UTC time when the pair stops being tradable each business day.',
    `trading_start_time` TIMESTAMP COMMENT 'UTC time when the pair becomes tradable each business day.',
    CONSTRAINT pk_currency_pair PRIMARY KEY(`currency_pair_id`)
) COMMENT 'Reference master for all supported currency pairs traded or converted on the platform. Defines the base currency, quote currency, ISO 4217 currency codes, standard pip size, minimum tradeable unit, decimal precision, market convention (direct/indirect quote), trading hours, and active status. Serves as the canonical reference for FX rate lookups, DCC eligibility checks, and cross-border routing decisions. Includes classification of major, minor, and exotic pairs relevant to the payments corridor.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` (
    `dcc_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the DCC transaction record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: A DCC transaction converts between the cardholders home currency and the transaction currency, defining a specific currency pair. Linking dcc_transaction.currency_pair_id → currency_pair.currency_pai',
    `dcc_config_id` BIGINT COMMENT 'Foreign key linking to fx.dcc_config. Business justification: A DCC transaction is governed by a DCC configuration; the FK captures the config used for the transaction.',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: DCC fraud often involves device spoofing to manipulate currency selection or geo-location. Device fingerprinting enables detection of DCC offer manipulation, VPN-based currency arbitrage, and unauthor',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant where the DCC transaction occurred.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: DCC fee and margin calculations depend on the underlying payment product (card) used, so the product must be recorded.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: A DCC transaction is a specific payment; linking allows settlement, chargeback, and compliance reporting.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who performed the transaction.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: A DCC transaction applies a specific FX rate at the moment of conversion. Linking dcc_transaction.rate_id → rate.rate_id identifies the exact rate record used, enabling full audit traceability of the ',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: DCC processing requires the card scheme to apply correct margin and compliance rules.',
    `acquirer_reference_number` STRING COMMENT 'Identifier assigned by the acquiring bank for reconciliation.',
    `authorization_code` STRING COMMENT 'Code returned by the issuer confirming authorization.. Valid values are `^[A-Z0-9]{6}$`',
    `card_scheme` STRING COMMENT 'Payment network brand of the card used in the transaction.. Valid values are `Visa|Mastercard|Amex|Discover|JCB|UnionPay`',
    `cardholder_home_currency` STRING COMMENT 'ISO 4217 currency code of the cardholders billing/home currency.. Valid values are `^[A-Z]{3}$`',
    `channel` STRING COMMENT 'Channel through which the transaction was initiated.. Valid values are `in_store|online|mobile_app|mpos`',
    `compliance_check_details` STRING COMMENT 'Free‑text details of any compliance issues identified.',
    `compliance_check_passed` BOOLEAN COMMENT 'Result of regulatory compliance checks (e.g., AML, sanctions) for the transaction.',
    `converted_amount` DECIMAL(18,2) COMMENT 'Amount after applying the DCC exchange rate, expressed in the cardholders home currency.',
    `created_by_system` STRING COMMENT 'Name of the operational system that originated the record (e.g., gateway, processing).',
    `dcc_event_timestamp` TIMESTAMP COMMENT 'Exact time when the DCC offer was presented to the cardholder.',
    `dcc_fee_amount` DECIMAL(18,2) COMMENT 'Flat fee charged for the DCC service, if any, expressed in the cardholders currency.',
    `dcc_margin_currency` STRING COMMENT 'Currency of the fixed DCC margin amount, if applicable.. Valid values are `^[A-Z]{3}$`',
    `dcc_margin_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed margin amount applied when margin type is fixed.',
    `dcc_margin_percentage` DECIMAL(18,2) COMMENT 'Percentage margin applied by the issuer/acquirer on top of the base exchange rate.',
    `dcc_margin_type` STRING COMMENT 'Indicates whether the DCC margin is a percentage or a fixed amount.. Valid values are `percentage|fixed`',
    `dcc_offer_accepted` BOOLEAN COMMENT 'Indicates whether the cardholder accepted the DCC offer (true) or declined (false).',
    `dcc_offer_decline_reason` STRING COMMENT 'Reason why a DCC offer was declined, if applicable.. Valid values are `customer_declined|merchant_declined|system_error|not_eligible`',
    `dcc_transaction_status` STRING COMMENT 'Current lifecycle state of the DCC transaction.. Valid values are `pending|authorized|settled|declined|reversed|failed`',
    `device_type` STRING COMMENT 'Technology used to capture the transaction.. Valid values are `POS|NFC|HCE|Web`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the original amount to the cardholders currency.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the transaction was flagged for potential fraud.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score generated by the fraud detection platform for this transaction.',
    `fx_rate_timestamp` TIMESTAMP COMMENT 'Timestamp when the exchange rate was retrieved.',
    `ip_address` STRING COMMENT 'Source IP address of the transaction request.. Valid values are `^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$`',
    `merchant_category_code` STRING COMMENT 'Four‑digit code classifying the merchants business type.',
    `notes` STRING COMMENT 'Optional free‑text field for additional remarks or manual adjustments.',
    `original_amount` DECIMAL(18,2) COMMENT 'Transaction amount in the original currency before DCC conversion.',
    `original_transaction_currency` STRING COMMENT 'ISO 4217 currency code of the transaction before conversion.. Valid values are `^[A-Z]{3}$`',
    `processing_latency_ms` BIGINT COMMENT 'Time in milliseconds from transaction receipt to DCC offer decision.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DCC transaction record was first persisted in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this DCC transaction record.',
    `scheme_compliance_flag` STRING COMMENT 'Indicates compliance of the DCC transaction with Visa/Mastercard DCC rules.. Valid values are `compliant|non_compliant|partial`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final settled amount after conversion and fees.',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled in the cardholders currency.',
    `transaction_reference` STRING COMMENT 'External reference such as Acquirer Reference Number (ARN) that uniquely identifies the transaction across systems.',
    `transaction_type` STRING COMMENT 'Nature of the transaction (e.g., purchase, refund).. Valid values are `purchase|refund|reversal|preauth`',
    CONSTRAINT pk_dcc_transaction PRIMARY KEY(`dcc_transaction_id`)
) COMMENT 'Transactional record capturing every Dynamic Currency Conversion event executed at the point of sale or online checkout. Records the original transaction currency, cardholder home currency, exchange rate applied, DCC margin percentage, converted amount, cardholder acceptance or decline of DCC offer, merchant MID, terminal TID, acquirer reference number (ARN), and scheme DCC compliance flags. Supports DCC revenue reporting, scheme compliance audits (Visa/Mastercard DCC rules), and cardholder dispute resolution for currency conversion disagreements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` (
    `correspondent_bank_id` BIGINT COMMENT 'Unique system-generated identifier for the correspondent bank record.',
    `aml_kyc_status` STRING COMMENT 'Current anti‑money‑laundering and know‑your‑customer compliance status of the bank.. Valid values are `approved|pending|rejected`',
    `compliance_documentation` STRING COMMENT 'Reference identifier or URL to the stored compliance documents (e.g., AML policies, contracts).',
    `contact_address` STRING COMMENT 'Mailing address of the banks primary office for correspondence.',
    `contact_email` STRING COMMENT 'Primary email address for the banks relationship manager.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for the banks relationship manager.. Valid values are `^+?[0-9]{7,15}$`',
    `correspondent_bank_name` STRING COMMENT 'Legal name of the correspondent bank.',
    `correspondent_fee_fixed` DECIMAL(18,2) COMMENT 'Flat fee charged per transaction, in the banks settlement currency.',
    `correspondent_fee_percentage` DECIMAL(18,2) COMMENT 'Variable fee expressed as a percentage of the transaction amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the correspondent bank record was first created in the system.',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'Maximum credit exposure the fintech is permitted to have with the correspondent bank, expressed in US dollars.',
    `effective_end_date` DATE COMMENT 'Date when the relationship ended or is scheduled to end (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the correspondent relationship became effective.',
    `iban_format_supported` STRING COMMENT 'Pattern or description of IBAN structures the bank can process (e.g., country-specific length).',
    `is_iban_supported` BOOLEAN COMMENT 'Indicates whether the bank can receive or send payments using IBAN format.',
    `is_swift_enabled` BOOLEAN COMMENT 'Indicates whether SWIFT messaging is supported for this bank.',
    `is_tokenization_supported` BOOLEAN COMMENT 'Indicates whether the bank participates in tokenization services for digital wallets.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or risk review of the relationship.',
    `nostro_account_currency` STRING COMMENT 'Currency code of the nostro account (e.g., USD, EUR).',
    `nostro_account_number` STRING COMMENT 'Bank account number held by the fintech in the correspondent bank for settlement purposes.',
    `regulatory_jurisdiction` STRING COMMENT 'Country or region whose financial regulations govern the correspondent relationship.',
    `relationship_status` STRING COMMENT 'Operational status of the correspondent banking relationship.. Valid values are `active|inactive|suspended|terminated`',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the correspondent bank based on AML, credit, and operational risk assessments.. Valid values are `low|medium|high|critical`',
    `settlement_cutoff_time` TIMESTAMP COMMENT 'Daily cut‑off time (local bank time) after which transactions are processed in the next business day.',
    `settlement_method` STRING COMMENT 'Primary mechanism used for settling transactions with the correspondent bank.. Valid values are `SWIFT|ACH|SEPA|RTGS`',
    `supported_currencies` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes the bank can settle for.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `website_url` STRING COMMENT 'Public website URL of the correspondent bank.',
    CONSTRAINT pk_correspondent_bank PRIMARY KEY(`correspondent_bank_id`)
) COMMENT 'Master record for correspondent banking relationships maintained by the platform to facilitate cross-border payment routing. Captures the correspondent bank name, BIC/SWIFT code, IBAN format supported, nostro account details, supported currencies, supported payment corridors, settlement cut-off times, correspondent bank fees, regulatory jurisdiction, AML/KYC status, and relationship status. Serves as the SSOT for correspondent banking counterparty data used in SWIFT routing, cross-border settlement instructions, and treasury liquidity management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`nostro_account` (
    `nostro_account_id` BIGINT COMMENT 'Unique system-generated identifier for the nostro account record.',
    `correspondent_bank_id` BIGINT COMMENT 'FK to fx.correspondent_bank',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Each nostro account operates under a specific fee schedule governing transaction fees, maintenance charges, and service costs. The fee_schedule column is a STRING that denormalizes what should be a FK',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Nostro accounts are balance sheet assets requiring GL account mapping for financial statement preparation, reconciliation, and regulatory capital reporting. Every nostro must map to a specific GL acco',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Nostro accounts are designated for settlement of specific scheme transactions — a Visa settlement nostro differs from a Mastercard one. Scheme-based settlement reconciliation, liquidity management per',
    `account_label` STRING COMMENT 'Human‑friendly label or nickname for the account used in treasury dashboards.',
    `account_number` STRING COMMENT 'Unique account number assigned by the correspondent bank for the nostro account.',
    `account_purpose` STRING COMMENT 'Primary business purpose of the nostro account.. Valid values are `fx|dcc|crossborder|settlement|reserve`',
    `account_type` STRING COMMENT 'Classification of the nostro account based on its operational purpose.. Valid values are `settlement|funding|operational|reserve`',
    `aml_watchlist_status` STRING COMMENT 'Result of AML watchlist screening for the account.. Valid values are `clear|matched|review`',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to the detailed audit record for the account.',
    `available_balance` DECIMAL(18,2) COMMENT 'Balance available for new transactions after holds and overdraft considerations.',
    `bic` STRING COMMENT 'SWIFT BIC of the correspondent bank holding the nostro account.',
    `closed_date` DATE COMMENT 'Date on which the nostro account was closed, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account record was first created in the system.',
    `cumulative_daily_amount` DECIMAL(18,2) COMMENT 'Total value of transactions processed on the current day.',
    `current_balance` DECIMAL(18,2) COMMENT 'Current total balance of the nostro account.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount permitted per calendar day.',
    `daily_usage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the daily transaction limit that has been used.',
    `iban` STRING COMMENT 'International Bank Account Number used for cross‑border transactions.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the account balance.',
    `is_pre_funded` BOOLEAN COMMENT 'Indicates whether the account is pre‑funded for anticipated transactions.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction governing the account.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent audit performed on the account.',
    `last_reconciliation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent reconciliation with the correspondent bank statement.',
    `last_statement_date` DATE COMMENT 'Date of the most recent bank statement received for the account.',
    `liquidity_limit` DECIMAL(18,2) COMMENT 'Maximum liquidity allocation permitted for the account.',
    `minimum_balance_threshold` DECIMAL(18,2) COMMENT 'Minimum balance that must be maintained to avoid fees or penalties.',
    `nostro_account_status` STRING COMMENT 'Operational status of the nostro account.. Valid values are `active|inactive|closed|suspended|pending`',
    `opened_date` DATE COMMENT 'Date on which the nostro account was opened with the correspondent bank.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the moment it was opened.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Authorized overdraft amount for the account.',
    `regulatory_reporting_flag` STRING COMMENT 'Indicates whether the account is subject to specific regulatory reporting obligations.. Valid values are `required|exempt|pending`',
    `settlement_instructions` STRING COMMENT 'Instructions for processing settlements using this account.',
    `treasury_desk` STRING COMMENT 'Internal treasury desk responsible for managing the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the account record.',
    CONSTRAINT pk_nostro_account PRIMARY KEY(`nostro_account_id`)
) COMMENT 'Master record for each nostro account held by the platform at correspondent banks in foreign currencies. Captures the account number, correspondent bank reference, currency denomination, account type, opening balance, current balance, minimum balance threshold, overdraft limit, account status, and the treasury desk responsible for management. Nostro accounts are the operational funding pools for cross-border payment execution. Supports real-time liquidity monitoring, pre-funding adequacy checks, and reconciliation against correspondent bank statements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` (
    `nostro_balance_id` BIGINT COMMENT 'Unique identifier for each nostro balance snapshot record.',
    `nostro_account_id` BIGINT COMMENT 'Identifier of the nostro account to which this balance belongs.',
    `available_balance` DECIMAL(18,2) COMMENT 'Portion of the closing balance that is not on hold and can be used for payments.',
    `balance_status` STRING COMMENT 'Indicates whether the snapshot has been reconciled against correspondent bank statements.. Valid values are `reconciled|unreconciled|pending`',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance amount at the end of the value date, after all posted movements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the balance record was first inserted into the lakehouse.',
    `credit_movements` DECIMAL(18,2) COMMENT 'Aggregate amount of all credit transactions posted to the account on the value date.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the accounts currency.',
    `debit_movements` DECIMAL(18,2) COMMENT 'Aggregate amount of all debit transactions posted to the account on the value date.',
    `event_type` STRING COMMENT 'Fixed value indicating this row represents a balance snapshot event.. Valid values are `balance_snapshot`',
    `hold_balance` DECIMAL(18,2) COMMENT 'Funds that are reserved or blocked and cannot be used for outgoing payments.',
    `notes` STRING COMMENT 'Additional comments or remarks about the balance snapshot.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance amount at the beginning of the value date, expressed in the account currency.',
    `pending_credits` DECIMAL(18,2) COMMENT 'Sum of credit amounts that are authorized but not yet finalised.',
    `pending_debits` DECIMAL(18,2) COMMENT 'Sum of debit amounts that are authorized but not yet finalised.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the balance snapshot was recorded.',
    `source_system` STRING COMMENT 'Name of the operational system that produced the balance snapshot.. Valid values are `TransactionProcessingPlatform|SettlementSystem|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the balance record.',
    `value_date` DATE COMMENT 'The business date for which the balance snapshot is taken.',
    CONSTRAINT pk_nostro_balance PRIMARY KEY(`nostro_balance_id`)
) COMMENT 'Transactional record capturing point-in-time balance snapshots and movements on each nostro account. Records the nostro account reference, value date, opening balance, closing balance, credit movements, debit movements, pending credits, pending debits, and reconciliation status against correspondent bank statements. Enables intraday liquidity monitoring, end-of-day reconciliation, and pre-funding adequacy validation before cross-border payment execution. Distinct from nostro_account (the master) as it captures the time-series balance history.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` (
    `payment_corridor_id` BIGINT COMMENT 'Unique system-generated identifier for the payment corridor record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Payment corridors are operational channels tracked by cost center for P&L attribution, transfer pricing between entities, and profitability analysis by geography/product. Enables management reporting ',
    `fx_fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule applicable to this corridor.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each payment corridor must comply with particular regulatory obligations; the FK ties corridor definitions to the governing obligation for audit and risk checks.',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: Payment corridors are operationalized through network routing tables that define which rails process corridor transactions. Corridor-to-routing-table mapping is essential for cross-border payment proc',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Payment corridors operate over specific scheme rails (Visa, Mastercard, SWIFT). Corridor compliance validation, interchange fee application, and scheme-mandated transaction limits require knowing whic',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the corridor record was first created.',
    `currency_conversion_allowed` BOOLEAN COMMENT 'Flag indicating whether automatic currency conversion is permitted for this corridor.',
    `dcc_supported` BOOLEAN COMMENT 'Indicates if DCC (Dynamic Currency Conversion) is offered for transactions in this corridor.',
    `destination_bank_codes` STRING COMMENT 'Comma‑separated list of BIC codes of banks in the destination country that can receive payments.',
    `destination_country_iso` STRING COMMENT 'Three‑letter ISO code of the destination country for the corridor.',
    `destination_currency_codes` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes that can be received in this corridor.',
    `effective_from` DATE COMMENT 'Date when the corridor becomes active and usable.',
    `effective_until` DATE COMMENT 'Date when the corridor is retired or no longer available (null if indefinite).',
    `estimated_settlement_time_minutes` STRING COMMENT 'Typical time in minutes from transaction initiation to settlement for this corridor.',
    `exchange_rate_source` STRING COMMENT 'Source of FX rates used for conversion in this corridor.. Valid values are `internal|external|third_party`',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount allowed per transaction in the corridor, expressed in the transaction currency.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum monetary amount required per transaction in the corridor.',
    `ofac_screening_required` BOOLEAN COMMENT 'Indicates whether OFAC or other sanctions screening must be performed for transactions in this corridor.',
    `payment_corridor_description` STRING COMMENT 'Human‑readable description of the corridor, including any special handling notes.',
    `payment_corridor_status` STRING COMMENT 'Current lifecycle status of the corridor.. Valid values are `active|inactive|deprecated|pending`',
    `payment_corridor_type` STRING COMMENT 'Business classification of the corridor based on usage or risk profile.. Valid values are `standard|high_value|low_value|test`',
    `regulatory_restrictions` STRING COMMENT 'Textual description of any regulatory or compliance constraints that apply to the corridor (e.g., AML limits, country sanctions).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) assigned to the corridor based on AML, sanctions, and fraud exposure.',
    `settlement_instructions` STRING COMMENT 'Detailed instructions for settlement processing (e.g., netting, gross, timing).',
    `source_bank_codes` STRING COMMENT 'Comma‑separated list of BIC codes of banks in the source country that can originate payments.',
    `source_currency_codes` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes that can be originated in this corridor.',
    `supported_payment_rails` STRING COMMENT 'Payment rail(s) available for routing transactions through this corridor.. Valid values are `SWIFT|ACH|RTP|SEPA|LOCAL|OTHER`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the corridor record.',
    CONSTRAINT pk_payment_corridor PRIMARY KEY(`payment_corridor_id`)
) COMMENT 'Master configuration record defining a supported cross-border payment corridor between a source country and destination country. Captures the source country ISO code, destination country ISO code, supported currencies, available payment rails (SWIFT, local ACH, RTP, SEPA), regulatory restrictions, OFAC/sanctions screening requirements, estimated settlement time, corridor status, and applicable fee schedule reference. Serves as the routing decision table for cross-border payment execution and corridor availability checks.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`exposure` (
    `exposure_id` BIGINT COMMENT 'Unique surrogate key for each FX exposure snapshot record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: FX exposure is measured per currency pair; linking normalizes the currency reference.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: FX exposures are hedged positions requiring GL classification for balance sheet presentation (derivative assets/liabilities) and hedge accounting documentation under IAS 39/IFRS 9. Links exposure to i',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: FX exposure is tracked per payment scheme to manage concentration risk — Visa-originated cross-border exposure vs Mastercard exposure requires separate risk limits. Scheme-level FX exposure reporting ',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exposure record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the exposure.. Valid values are `^[A-Z]{3}$`',
    `direction` STRING COMMENT 'Indicates whether the exposure is a long (positive) or short (negative) position.. Valid values are `long|short`',
    `exposure_source` STRING COMMENT 'Origin of the exposure amount, such as pending settlements, nostro balances, forward contracts, etc.. Valid values are `pending_settlements|nostro_balances|forward_contracts|spot_trades|swap_positions|options`',
    `exposure_status` STRING COMMENT 'Current lifecycle status of the exposure record.. Valid values are `open|closed|reconciled|error`',
    `gross_notional_exposure` DECIMAL(18,2) COMMENT 'Total notional amount of the FX position before any hedging offsets.',
    `hedging_status` STRING COMMENT 'Indicates whether the exposure is fully hedged, partially hedged, or unhedged.. Valid values are `hedged|partial|unhedged`',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum allowable exposure amount defined by the risk limit.',
    `limit_name` STRING COMMENT 'Human‑readable name of the risk limit governing this exposure.',
    `limit_utilization_amount` DECIMAL(18,2) COMMENT 'Absolute amount of the risk limit currently utilized by this exposure.',
    `net_exposure` DECIMAL(18,2) COMMENT 'Exposure amount after applying hedging instruments, expressed in the reporting currency.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the exposure snapshot.',
    `risk_limit_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the assigned risk limit that is currently utilized by this exposure.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp when the exposure snapshot was captured.',
    `unhedged_exposure` DECIMAL(18,2) COMMENT 'Portion of the exposure that remains without hedge coverage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exposure record.',
    `value_date` DATE COMMENT 'Date on which the exposure is expected to settle or be realized.',
    CONSTRAINT pk_exposure PRIMARY KEY(`exposure_id`)
) COMMENT 'Transactional record capturing the platforms open FX exposure position by currency at a point in time. Records the currency, exposure direction (long/short), gross notional exposure, net exposure after hedges, unhedged exposure, value date, exposure source (pending settlements, nostro balances, forward contracts), and risk limit utilization percentage. Enables treasury to monitor real-time FX risk positions, trigger hedging actions when exposure breaches thresholds, and report FX risk to the board and regulators.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` (
    `cross_border_payment_id` BIGINT COMMENT 'System-generated unique identifier for the cross-border payment record.',
    `beneficiary_id` BIGINT COMMENT 'Identifier of the party receiving the funds.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Every cross-border payment involves a specific currency pair (source currency → destination currency). Linking cross_border_payment.currency_pair_id → currency_pair.currency_pair_id connects the payme',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: Cross-border payments are high-risk for device-based fraud (VPN spoofing, geo-location mismatch, device takeover). Device fingerprinting enables detection of suspicious cross-border payment originatio',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Each cross-border payment applies a specific fee schedule that determines the fee structure for the transaction. Linking cross_border_payment.fx_fee_schedule_id → fx_fee_schedule.fx_fee_schedule_id co',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: A cross-border payment is routed through a specific payment corridor that defines the source/destination country pair, supported rails, regulatory restrictions, and settlement parameters. Linking cros',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Regulatory reporting requires linking each cross‑border payment to its payment product to aggregate volumes by product type.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Every cross-border payment applies a specific FX rate for currency conversion. Linking cross_border_payment.rate_id → rate.rate_id provides a precise audit trail to the rate record used, including its',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Enables reconciliation of cross‑border payments with the original gateway request for audit and settlement reporting.',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: Cross-border payments are routed via network routing tables that determine the processing rail. Payment routing audit trails, dispute resolution, and regulatory reporting require tracing which routing',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Regulatory reporting of cross‑border payments must capture the card scheme used for compliance (e.g., PSD2, SWIFT reporting).',
    `instruction_id` BIGINT COMMENT 'Reference to the settlement instruction record governing fund transfer.',
    `aml_screening_status` STRING COMMENT 'Result of Anti‑Money‑Laundering screening for the transaction.. Valid values are `passed|flagged|pending`',
    `beneficiary_bank_bic` STRING COMMENT 'Bank Identifier Code of the beneficiarys financial institution.',
    `beneficiary_iban` STRING COMMENT 'International Bank Account Number of the beneficiarys account.',
    `chargeback_indicator` BOOLEAN COMMENT 'True if the payment resulted in a chargeback.',
    `compliance_notes` STRING COMMENT 'Free‑form notes related to compliance checks or regulatory observations.',
    `converted_amount` DECIMAL(18,2) COMMENT 'Monetary amount in the destination currency after applying the FX rate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `cross_border_payment_status` STRING COMMENT 'Current lifecycle status of the cross-border payment.. Valid values are `pending|authorized|declined|settled|reversed|failed`',
    `destination_country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 code of the beneficiarys country.',
    `destination_currency_code` STRING COMMENT 'ISO 4217 currency code of the amount received by the beneficiary.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment instruction was initiated by the sender.',
    `exchange_rate_type` STRING COMMENT 'Classification of the FX rate (e.g., spot, forward).. Valid values are `spot|forward|mid_market`',
    `exchange_rate_validity_end` TIMESTAMP COMMENT 'End of the time window during which the FX rate is valid.',
    `exchange_rate_validity_start` TIMESTAMP COMMENT 'Start of the time window during which the FX rate is valid.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged for processing the cross‑border payment.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 currency code of the fee amount.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the original amount to the destination currency.',
    `fx_rate_timestamp` TIMESTAMP COMMENT 'Timestamp when the FX rate was sourced or locked for the transaction.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the payment status.',
    `ofac_screening_status` STRING COMMENT 'Result of Office of Foreign Assets Control sanctions screening.. Valid values are `passed|blocked|pending`',
    `original_amount` DECIMAL(18,2) COMMENT 'Monetary amount in the origin currency before conversion.',
    `payment_purpose_code` STRING COMMENT 'ISO 20022 purpose code describing the reason for the payment.',
    `payment_rail` STRING COMMENT 'Network or scheme used to route the cross‑border payment.. Valid values are `SWIFT|SEPA|ACH|LOCAL|OTHER`',
    `payment_reference` STRING COMMENT 'External reference number assigned by the originating institution or platform for tracking the payment.',
    `regulatory_reporting_flag` STRING COMMENT 'Indicates whether the transaction must be reported to regulators.. Valid values are `required|exempt|not_applicable`',
    `reversal_indicator` BOOLEAN COMMENT 'True if the payment record represents a reversal of a prior transaction.',
    `settlement_date` DATE COMMENT 'Date on which the payment is settled between banks.',
    `swift_uetr` STRING COMMENT 'Globally unique identifier assigned by SWIFT for tracking the payment.',
    `total_amount` DECIMAL(18,2) COMMENT 'Sum of original amount and any applicable fees, expressed in the origin currency.',
    `total_currency_code` STRING COMMENT 'ISO 4217 currency code for the total amount field.',
    `transaction_type` STRING COMMENT 'Indicates whether funds are being sent (debit) or received (credit).. Valid values are `credit|debit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    `value_date` DATE COMMENT 'Date on which the converted amount becomes effective for accounting.',
    CONSTRAINT pk_cross_border_payment PRIMARY KEY(`cross_border_payment_id`)
) COMMENT 'Core transactional record for every cross-border payment instruction initiated through the platform. Captures the payment reference, originating country, destination country, sender identity, beneficiary identity, beneficiary bank BIC, beneficiary IBAN/account number, payment amount, origination currency, destination currency, FX rate applied, converted amount, payment rail selected (SWIFT, SEPA, local ACH), SWIFT UETR, payment purpose code, regulatory reporting flags, OFAC screening status, and payment lifecycle status. The SSOT for cross-border payment execution within the FX domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`dcc_config` (
    `dcc_config_id` BIGINT COMMENT 'Surrogate primary key for the DCC configuration record.',
    `rate_margin_config_id` BIGINT COMMENT 'Foreign key linking to fx.rate_margin_config. Business justification: A DCC configuration program applies a specific FX margin on top of the interbank rate. Linking dcc_config.rate_margin_config_id → rate_margin_config.rate_margin_config_id connects the DCC program to i',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: DCC configurations are scheme-specific — Visa DCC rules differ from Mastercards. The plain attribute scheme_compliance is a denormalized reference to the governing scheme. Scheme-specific DCC setup, ',
    `cardholder_disclosure_text_ref` STRING COMMENT 'Reference identifier to the legal disclosure text shown to cardholders for DCC offers.',
    `compliance_notes` STRING COMMENT 'Notes related to regulatory or scheme compliance requirements for this configuration.',
    `config_code` STRING COMMENT 'Human‑readable business identifier for the DCC configuration, used in reporting and operational dashboards.',
    `config_description` STRING COMMENT 'Free‑form description of the DCC configuration purpose and any special notes.',
    `config_type` STRING COMMENT 'Classification of the DCC configuration (e.g., standard, premium, custom).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DCC configuration record was first created.',
    `dcc_config_status` STRING COMMENT 'Current lifecycle status of the DCC configuration.. Valid values are `active|inactive|pending|suspended`',
    `dcc_margin_percentage` DECIMAL(18,2) COMMENT 'Percentage margin applied by the merchant or acquirer over the base FX rate for DCC transactions.',
    `effective_end_date` DATE COMMENT 'Date on which the DCC configuration expires or is superseded; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the DCC configuration becomes active.',
    `enrolled_currency_pairs` STRING COMMENT 'Pipe‑separated list of currency pairs (e.g., USD/EUR|USD/GBP) that the merchant participates in for DCC offers.',
    `merchant_category_code` STRING COMMENT 'Standard industry code that classifies the merchants business type.',
    `merchant_mid` BIGINT COMMENT 'Unique identifier of the merchant to which this DCC configuration applies.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount (in merchants settlement currency) required for a DCC offer to be presented.',
    `offer_presentation_method` STRING COMMENT 'Channel through which the DCC offer is presented to the cardholder.. Valid values are `terminal|online|ivr`',
    `opt_in_default` BOOLEAN COMMENT 'Default opt‑in (true) or opt‑out (false) setting applied when a merchant enrolls in DCC.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DCC configuration record.',
    `version_number` STRING COMMENT 'Monotonically increasing version used for optimistic concurrency control.',
    CONSTRAINT pk_dcc_config PRIMARY KEY(`dcc_config_id`)
) COMMENT 'Master configuration record governing DCC program parameters for each merchant or merchant category enrolled in the DCC service. Captures the merchant MID, enrolled currency pairs, DCC margin percentage, minimum transaction amount for DCC offer, DCC offer presentation method (terminal, online, IVR), scheme compliance settings (Visa DCC, Mastercard Currency Conversion), cardholder disclosure text reference, opt-in/opt-out default, and configuration effective dates. Drives the DCC eligibility and rate calculation logic at transaction time.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` (
    `fx_fee_schedule_id` BIGINT COMMENT 'System-generated unique identifier for each FX fee schedule record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: An FX fee schedule is defined for a specific currency pair. The applicable_currency_pair column is a STRING that denormalizes what should be a FK reference to the currency_pair master. Replacing it wi',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Fee schedules are subject to regulatory frameworks; linking to the obligation ensures fee calculations respect compliance rules.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: FX fee schedules for cross-border transactions are scheme-specific — Visa and Mastercard have distinct cross-border fee structures. Scheme-level FX fee reconciliation, interchange reporting, and compl',
    `calculation_method` STRING COMMENT 'Method used to calculate the fee – flat amount, percentage of transaction amount, or tiered structure.. Valid values are `flat|percentage|tiered`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) that govern the fee schedule, e.g., PSD2, FCA, or local AML rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee schedule record was first created in the system.',
    `customer_segment` STRING COMMENT 'Segment of customers for which the fee schedule is valid.. Valid values are `retail|corporate|enterprise`',
    `effective_date` DATE COMMENT 'Date on which the fee schedule becomes active.',
    `expiry_date` DATE COMMENT 'Date on which the fee schedule ceases to be active; null for open‑ended schedules.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Core fee value used when calculation_method is flat; for percentage or tiered methods this stores the base rate or tier reference.',
    `fee_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the fee is expressed.. Valid values are `^[A-Z]{3}$`',
    `fee_type` STRING COMMENT 'Category of FX service the fee applies to, such as Dynamic Currency Conversion (DCC) or SWIFT wire.. Valid values are `dcc|cross_border|currency_conversion|swift_wire`',
    `fee_version` STRING COMMENT 'Incremental version number used for change management and audit.',
    `fx_fee_schedule_description` STRING COMMENT 'Free‑form description providing context, business rules, or notes about the fee schedule.',
    `fx_fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule.. Valid values are `active|inactive|pending|retired`',
    `is_default` BOOLEAN COMMENT 'Indicates whether this schedule is the default for its fee_type and segment.',
    `maximum_fee` DECIMAL(18,2) COMMENT 'Highest fee that can be charged under this schedule, expressed in fee_currency.',
    `minimum_fee` DECIMAL(18,2) COMMENT 'Lowest fee that can be charged under this schedule, expressed in fee_currency.',
    `schedule_code` STRING COMMENT 'Business code that uniquely identifies the fee schedule across systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the fee schedule used for reporting and UI display.',
    `tier_details` STRING COMMENT 'JSON‑encoded or delimited representation of tier thresholds and rates when calculation_method is tiered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fee schedule record.',
    CONSTRAINT pk_fx_fee_schedule PRIMARY KEY(`fx_fee_schedule_id`)
) COMMENT 'Reference master defining the fee structures applied to FX and cross-border payment services offered by the platform. Captures the fee schedule name, applicable service type (DCC, cross-border transfer, currency conversion, SWIFT wire), fee calculation method (flat, percentage, tiered), fee currency, minimum fee, maximum fee, applicable currency pairs or corridors, customer segment applicability, effective date, and expiry date. Serves as the pricing reference for FX revenue calculation and merchant/cardholder fee disclosure.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` (
    `rate_margin_config_id` BIGINT COMMENT 'Unique surrogate identifier for the FX margin configuration record.',
    `currency_pair_id` BIGINT COMMENT 'Reference to the currency pair to which this margin applies.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: FX margin configurations are often scoped to specific payment corridors — different corridors carry different risk profiles and competitive dynamics that drive margin decisions. Linking rate_margin_co',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: DCC margin configurations are scheme-specific — Visa and Mastercard impose different DCC margin caps and disclosure requirements. Scheme-specific margin compliance audits and regulatory reporting requ',
    `applicable_region_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 code of the region where the margin applies. [ENUM-REF-CANDIDATE: USA|GBR|FRA|DEU|JPN|CHN|IND|BRA|CAN|AUS|... — promote to reference product]',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration was approved.',
    `audit_comment` STRING COMMENT 'Free‑text field for audit notes or change justification.',
    `base_rate_source_code` STRING COMMENT 'Identifier of the source providing the underlying interbank rate.. Valid values are `interbank|provider_x|provider_y`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created.',
    `customer_tier_code` STRING COMMENT 'Segment of customers (e.g., platinum, gold) for which the margin is defined.. Valid values are `platinum|gold|silver|standard`',
    `effective_from` DATE COMMENT 'Date on which the margin configuration becomes active.',
    `effective_until` DATE COMMENT 'Date on which the margin configuration expires or is superseded (null if open‑ended).',
    `is_default` BOOLEAN COMMENT 'Indicates whether this configuration is the default for its scope.',
    `margin_basis` STRING COMMENT 'Unit used to express the margin (basis points or percent).. Valid values are `bps|percent`',
    `margin_percentage` DECIMAL(18,2) COMMENT 'Margin expressed as a percentage when margin_type is percentage_markup.',
    `margin_type` STRING COMMENT 'Method used to calculate the markup on the interbank rate.. Valid values are `fixed_spread|percentage_markup|tiered_volume`',
    `margin_value_bps` DECIMAL(18,2) COMMENT 'Margin expressed in basis points when margin_type is fixed_spread.',
    `product_type_code` STRING COMMENT 'Type of payment product or service the margin applies to.. Valid values are `remittance|card_payment|e_commerce|p2p|b2b`',
    `rate_margin_config_description` STRING COMMENT 'Free‑text description providing context and business rationale.',
    `rate_margin_config_name` STRING COMMENT 'Human‑readable name identifying the margin configuration.',
    `rate_margin_config_status` STRING COMMENT 'Current lifecycle status of the margin configuration.. Valid values are `active|inactive|pending|retired`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the configuration satisfies PSD2 transparency requirements.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk rating associated with this margin configuration (higher scores may justify higher margins).',
    `settlement_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the margin is settled. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CHF|CAD|... — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    `version_number` STRING COMMENT 'Sequential version number for change management.',
    CONSTRAINT pk_rate_margin_config PRIMARY KEY(`rate_margin_config_id`)
) COMMENT 'Master configuration record defining the FX margin (spread) applied on top of the interbank mid-market rate for each customer segment, product type, or payment corridor. Captures the margin type (fixed spread, percentage markup, tiered by volume), base rate source, margin basis points, applicable currency pair or corridor, customer tier, product type, effective date, and approval authority. Governs how the platform marks up interbank rates to generate FX revenue while remaining competitive and compliant with PSD2 transparency requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`beneficiary` (
    `beneficiary_id` BIGINT COMMENT 'Unique surrogate key for each beneficiary record.',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to fx.correspondent_bank. Business justification: A beneficiarys receiving bank may be one of the platforms known correspondent banks. Linking beneficiary.correspondent_bank_id → correspondent_bank.correspondent_bank_id (nullable) enables routing o',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Beneficiaries receiving cross-border payments may be group legal entities requiring intercompany elimination, transfer pricing documentation, and consolidation tracking. Links beneficiary to legal ent',
    `account_number` STRING COMMENT 'Domestic bank account number of the beneficiary.',
    `address_line1` STRING COMMENT 'First line of the beneficiarys street address.',
    `address_line2` STRING COMMENT 'Second line of the beneficiarys street address, if applicable.',
    `bank_bic_swift` STRING COMMENT 'SWIFT/BIC identifier of the beneficiarys bank.. Valid values are `^[A-Z]{8}([A-Z]{3})?$`',
    `bank_name` STRING COMMENT 'Legal name of the bank holding the beneficiarys account.',
    `beneficiary_name` STRING COMMENT 'Legal name of the beneficiary (individual or corporate).',
    `beneficiary_status` STRING COMMENT 'Overall status indicating whether the beneficiary is active, inactive, suspended, or closed.. Valid values are `active|inactive|suspended|closed`',
    `beneficiary_type` STRING COMMENT 'Indicates whether the beneficiary is an individual, corporate, government, or nonprofit entity.. Valid values are `individual|corporate|government|nonprofit`',
    `city` STRING COMMENT 'City component of the beneficiarys address.',
    `contact_email` STRING COMMENT 'Primary email address for communications with the beneficiary.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for the beneficiary.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the beneficiary record was first created.',
    `external_beneficiary_code` STRING COMMENT 'Identifier assigned to the beneficiary by external correspondent banks or partners.',
    `iban` STRING COMMENT 'International Bank Account Number of the beneficiary.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `is_preferred` BOOLEAN COMMENT 'True if the beneficiary is marked as preferred for recurring cross‑border payments.',
    `last_payment_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent successful payment to this beneficiary.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the beneficiarys address.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score (0‑99.99) assigned based on AML and fraud analytics.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions list screening for the beneficiary.. Valid values are `clear|matched|pending|failed`',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the beneficiary data.',
    `tax_identification_number` STRING COMMENT 'Tax ID number for corporate beneficiaries, used for reporting and compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the beneficiary record.',
    `verification_status` STRING COMMENT 'Current status of identity verification for the beneficiary.. Valid values are `unverified|pending|verified|failed`',
    CONSTRAINT pk_beneficiary PRIMARY KEY(`beneficiary_id`)
) COMMENT 'Master record for beneficiary entities registered on the platform for recurring cross-border payment execution. Captures the beneficiary name, beneficiary type (individual, corporate), country of residence, bank name, bank BIC/SWIFT code, account number or IBAN, account currency, beneficiary address, identity verification status, sanctions screening status, and last payment date. Serves as the trusted beneficiary registry enabling faster cross-border payment processing by pre-validating and pre-screening recurring payment recipients.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` (
    `corridor_bank_assignment_id` BIGINT COMMENT 'Unique system-generated identifier for this corridor-bank assignment record',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to the correspondent bank authorized for this corridor',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to the payment corridor being configured with correspondent bank options',
    `assigned_by_user_code` BIGINT COMMENT 'Reference to the treasury or operations user who created or last approved this corridor-bank assignment',
    `assignment_status` STRING COMMENT 'Current operational status of this corridor-bank assignment, managed by treasury operations team',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corridor-bank assignment was first created in the system',
    `effective_from` DATE COMMENT 'Date when this correspondent bank became authorized and active for routing payments through this corridor',
    `effective_until` DATE COMMENT 'Date when this correspondent bank authorization expires or was terminated for this corridor (null if currently active)',
    `fee_override` DECIMAL(18,2) COMMENT 'Negotiated fee amount specific to this corridor-bank combination, overriding the correspondent banks standard fee schedule when populated',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this correspondent bank is designated as the primary/preferred routing option for this corridor (typically only one primary per corridor)',
    `max_daily_volume_usd` DECIMAL(18,2) COMMENT 'Maximum daily transaction volume in USD that can be routed through this correspondent bank for this specific corridor, used for liquidity and risk management',
    `payment_corridors` STRING COMMENT 'Geographic or network corridors (e.g., US‑EU, APAC‑LATAM) the bank supports for cross‑border payments. [Moved from correspondent_bank: This STRING attribute in correspondent_bank lists corridors the bank supports, but the actual operational assignment with priority, dates, and fees belongs in the association. The attribute should be removed as it creates denormalization and will be replaced by querying the corridor_bank_assignment association.]',
    `priority_rank` STRING COMMENT 'Numeric priority ranking for routing decisions when multiple correspondent banks serve the same corridor (1 = highest priority). Used by payment routing engine to select optimal correspondent bank.',
    `settlement_method` STRING COMMENT 'Settlement mechanism used for this specific corridor-bank pairing, which may differ from the correspondent banks default settlement method based on corridor requirements',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this assignment record',
    CONSTRAINT pk_corridor_bank_assignment PRIMARY KEY(`corridor_bank_assignment_id`)
) COMMENT 'This association product represents the operational assignment of correspondent banks to payment corridors for cross-border payment routing. It captures the treasury and operations teams active management of which correspondent banks are authorized and prioritized for each corridor. Each record links one payment corridor to one correspondent bank with routing priority, settlement terms, fee overrides, and relationship lifecycle dates that exist only in the context of this specific corridor-bank pairing.. Existence Justification: In cross-border payments operations, payment corridors (e.g., US-to-EU, APAC-to-LATAM) require multiple correspondent banks for redundancy, cost optimization, and regulatory compliance, while each correspondent bank serves multiple corridors based on their geographic reach and currency capabilities. Treasury and operations teams actively manage these assignments with routing priorities, corridor-specific settlement terms, fee negotiations, and lifecycle management (effective dates, suspension, termination). This is not a derived correlation but an operational business process where relationship managers configure and maintain corridor-bank pairings as a core routing decision table.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` (
    `feed_coverage_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each feed-pair coverage configuration record',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to the currency pair reference',
    `rate_feed_id` BIGINT COMMENT 'Foreign key linking to the rate feed provider configuration',
    `confidence_weight` DECIMAL(18,2) COMMENT 'Weighting factor (0.0000 to 1.0000) representing the confidence/quality of rates from this feed for this specific pair. Used in weighted rate aggregation algorithms when multiple feeds provide rates for the same pair.',
    `coverage_status` STRING COMMENT 'Lifecycle status of this feed-pair coverage configuration (active, suspended, deprecated, testing)',
    `created_timestamp` TIMESTAMP COMMENT 'Date-time when this feed coverage configuration record was first created',
    `effective_from` DATE COMMENT 'Date from which this feed-pair coverage configuration becomes active for rate ingestion and routing decisions',
    `effective_until` DATE COMMENT 'Date after which this feed-pair coverage is no longer active; null indicates indefinite coverage',
    `is_primary_source` BOOLEAN COMMENT 'True if this feed is designated as the primary/preferred source for this currency pair. Used in rate aggregation and failover logic when multiple feeds cover the same pair.',
    `last_rate_received_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful rate retrieval for this specific feed-pair combination. Used for monitoring feed health at the pair level.',
    `polling_frequency_seconds` STRING COMMENT 'Polling frequency in seconds for this specific feed-pair combination, allowing different refresh rates for different pairs from the same feed (e.g., major pairs polled more frequently than exotics)',
    `precision_override` STRING COMMENT 'Decimal precision override specific to this feed-pair combination, overriding the currency_pair default when this feed is the source. Allows feed-specific precision handling.',
    `supported_currency_pairs` STRING COMMENT 'List of currency pairs (e.g., EUR/USD, GBP/JPY) that the feed supplies. [Moved from rate_feed: This STRING field in rate_feed is a denormalized list representation of the M:N relationship. The proper normalized model captures each feed-pair coverage as a separate record in the association, eliminating the need for this comma-separated list. The association provides granular control over which pairs each feed covers with pair-specific configuration.]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date-time of the most recent modification to this feed coverage configuration',
    CONSTRAINT pk_feed_coverage PRIMARY KEY(`feed_coverage_id`)
) COMMENT 'This association product represents the operational coverage configuration between rate_feed and currency_pair. It captures which external FX rate feed providers supply rates for which currency pairs, along with feed-specific precision overrides, polling frequency adjustments, effective date ranges, primary source designation, and confidence weighting used for rate aggregation and failover logic. Each record links one rate_feed to one currency_pair with attributes that exist only in the context of this specific feed-pair subscription.. Existence Justification: In FX payment platforms, rate feed providers each cover different subsets of currency pairs with varying quality and latency characteristics. A single feed (e.g., Reuters) supplies rates for multiple pairs (EUR/USD, GBP/USD, USD/JPY), and a single currency pair (e.g., EUR/USD) is sourced from multiple feeds for redundancy, rate aggregation, and failover. The platform actively manages this feed-pair coverage configuration with pair-specific polling frequencies, precision overrides, primary source designation, and confidence weights used in rate aggregation algorithms.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ADD CONSTRAINT `fk_fx_rate_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ADD CONSTRAINT `fk_fx_rate_rate_feed_id` FOREIGN KEY (`rate_feed_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_feed`(`rate_feed_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_dcc_config_id` FOREIGN KEY (`dcc_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`dcc_config`(`dcc_config_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ADD CONSTRAINT `fk_fx_nostro_account_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ADD CONSTRAINT `fk_fx_nostro_account_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ADD CONSTRAINT `fk_fx_nostro_balance_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ADD CONSTRAINT `fk_fx_exposure_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `payments_fintech_ecm`.`fx`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ADD CONSTRAINT `fk_fx_dcc_config_rate_margin_config_id` FOREIGN KEY (`rate_margin_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_margin_config`(`rate_margin_config_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ADD CONSTRAINT `fk_fx_fx_fee_schedule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ADD CONSTRAINT `fk_fx_rate_margin_config_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ADD CONSTRAINT `fk_fx_rate_margin_config_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ADD CONSTRAINT `fk_fx_beneficiary_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ADD CONSTRAINT `fk_fx_corridor_bank_assignment_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ADD CONSTRAINT `fk_fx_corridor_bank_assignment_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ADD CONSTRAINT `fk_fx_feed_coverage_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ADD CONSTRAINT `fk_fx_feed_coverage_rate_feed_id` FOREIGN KEY (`rate_feed_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_feed`(`rate_feed_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`fx` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`fx` SET TAGS ('dbx_domain' = 'fx');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate Identifier (FX Rate ID)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `rate_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Feed Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `ask_price` SET TAGS ('dbx_business_glossary_term' = 'Ask Price (FX Ask)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `bid_price` SET TAGS ('dbx_business_glossary_term' = 'Bid Price (FX Bid)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score (FX Rate Confidence)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (FX Rate Created)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `cross_border_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator (FX Cross‑Border Flag)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp (FX Rate Effective Time)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp (FX Rate Expiry Time)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `external_rate_code` SET TAGS ('dbx_business_glossary_term' = 'External Rate Code (FX External Code)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag (FX Rate Active Indicator)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (FX Rate Status)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region (FX Market Region)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `market_region` SET TAGS ('dbx_value_regex' = 'EMEA|APAC|Americas');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `mid_price` SET TAGS ('dbx_business_glossary_term' = 'Mid Market Price (FX Mid)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (FX Rate Free‑Form Comments)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `precision` SET TAGS ('dbx_business_glossary_term' = 'Rate Precision (FX Decimal Precision)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `quote_currency` SET TAGS ('dbx_business_glossary_term' = 'Quote Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `quote_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type (FX Rate Classification)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'spot|forward|indicative|guaranteed|historical|mid_market');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Value (FX Rate)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `spread` SET TAGS ('dbx_business_glossary_term' = 'Spread (FX Spread)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (FX Rate Updated)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `rate_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Feed Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'API_KEY|OAUTH|CERTIFICATE|NONE');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'JSON|XML|CSV|FIX');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `encryption_protocol` SET TAGS ('dbx_business_glossary_term' = 'Encryption Protocol');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `encryption_protocol` SET TAGS ('dbx_value_regex' = 'TLS1.2|TLS1.3|SSH');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `failover_priority` SET TAGS ('dbx_business_glossary_term' = 'Failover Priority');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `feed_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Feed Endpoint');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `feed_protocol` SET TAGS ('dbx_business_glossary_term' = 'Feed Retrieval Protocol');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `feed_protocol` SET TAGS ('dbx_value_regex' = 'REST|FIX|SFTP|FTP|API');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `is_encrypted` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `last_error_code` SET TAGS ('dbx_business_glossary_term' = 'Last Error Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `last_error_message` SET TAGS ('dbx_business_glossary_term' = 'Last Error Message');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `last_failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failure Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `last_success_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Success Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `polling_frequency_seconds` SET TAGS ('dbx_business_glossary_term' = 'Polling Frequency (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Feed Provider Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Feed Provider Name');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `rate_feed_description` SET TAGS ('dbx_business_glossary_term' = 'Feed Description');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `rate_feed_status` SET TAGS ('dbx_business_glossary_term' = 'Feed Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `rate_feed_status` SET TAGS ('dbx_value_regex' = 'active|inactive|degraded|maintenance|retired');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'SPOT|FORWARD|MID|INTERBANK');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Percentage');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Feed Timezone');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Classification');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'major|minor|exotic');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `cross_border_eligible` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `currency_pair_description` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Description');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `currency_pair_status` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `currency_pair_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `dcc_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Eligibility');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `decimal_precision` SET TAGS ('dbx_business_glossary_term' = 'Decimal Precision');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Pair Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `last_rate_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Rate Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `market_convention` SET TAGS ('dbx_business_glossary_term' = 'Market Convention (Direct or Indirect Quote)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `market_convention` SET TAGS ('dbx_value_regex' = 'direct|indirect');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `min_tradeable_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tradeable Unit');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `pair_name` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Name (e.g., EUR/USD)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency ISO 4217 Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'instant|same_day|t+1|t+2');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `source_feed` SET TAGS ('dbx_business_glossary_term' = 'Rate Source Feed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `source_feed` SET TAGS ('dbx_value_regex' = 'internal|external|third_party');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `source_feed_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Source Feed Version');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `standard_pip_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Pip Size');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `trading_end_time` SET TAGS ('dbx_business_glossary_term' = 'Trading Session End Time (UTC)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ALTER COLUMN `trading_start_time` SET TAGS ('dbx_business_glossary_term' = 'Trading Session Start Time (UTC)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_config_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|JCB|UnionPay');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `cardholder_home_currency` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Home Currency');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `cardholder_home_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|mpos');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `compliance_check_details` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Details');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `converted_amount` SET TAGS ('dbx_business_glossary_term' = 'Converted Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'DCC Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'DCC Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_margin_currency` SET TAGS ('dbx_business_glossary_term' = 'DCC Margin Currency');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_margin_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_margin_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'DCC Fixed Margin Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'DCC Margin Percentage');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_margin_type` SET TAGS ('dbx_business_glossary_term' = 'DCC Margin Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_margin_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_offer_accepted` SET TAGS ('dbx_business_glossary_term' = 'DCC Offer Accepted Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_offer_decline_reason` SET TAGS ('dbx_business_glossary_term' = 'DCC Offer Decline Reason');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_offer_decline_reason` SET TAGS ('dbx_value_regex' = 'customer_declined|merchant_declined|system_error|not_eligible');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `dcc_transaction_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|settled|declined|reversed|failed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'POS|NFC|HCE|Web');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Applied');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `fx_rate_timestamp` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `original_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Currency');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `original_transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `scheme_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheme Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `scheme_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|reversal|preauth');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` SET TAGS ('dbx_subdomain' = 'banking_relationships');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_business_glossary_term' = 'AML/KYC Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `compliance_documentation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation Reference');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Physical Address');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `correspondent_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Name');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `correspondent_fee_fixed` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Fixed Fee');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `correspondent_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (USD)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `iban_format_supported` SET TAGS ('dbx_business_glossary_term' = 'Supported IBAN Format');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `iban_format_supported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `iban_format_supported` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `is_iban_supported` SET TAGS ('dbx_business_glossary_term' = 'IBAN Supported');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `is_iban_supported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `is_iban_supported` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `is_swift_enabled` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Enabled');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `is_swift_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `is_swift_enabled` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `is_tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `nostro_account_currency` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Currency');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Number');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `settlement_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cut‑Off Time');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'SWIFT|ACH|SEPA|RTGS');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Bank Website URL');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` SET TAGS ('dbx_subdomain' = 'banking_relationships');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_label` SET TAGS ('dbx_business_glossary_term' = 'Account Label (ACC_LABEL)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose (ACC_PURPOSE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_value_regex' = 'fx|dcc|crossborder|settlement|reserve');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (ACC_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'settlement|funding|operational|reserve');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `aml_watchlist_status` SET TAGS ('dbx_business_glossary_term' = 'AML Watchlist Status (AML_WL_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `aml_watchlist_status` SET TAGS ('dbx_value_regex' = 'clear|matched|review');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference (AUDIT_REF)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance (AVAIL_BAL)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date (CLOSED_DT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `cumulative_daily_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Daily Amount (DAILY_TXN_TOTAL)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance (CURR_BAL)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit (DAILY_TXN_LIM)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `daily_usage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Daily Usage Percentage (DAILY_USAGE_PCT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate (INT_RATE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `is_pre_funded` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Funded Indicator (PRE_FUNDED)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction (JURISDICTION)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp (LAST_AUDIT_TS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `last_reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Timestamp (LAST_RECON_TS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date (LAST_STMT_DT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `liquidity_limit` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Limit (LIQ_LIMIT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `minimum_balance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Threshold (MIN_BAL_THR)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `nostro_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (ACC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `nostro_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date (OPENED_DT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance (OPEN_BAL)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit (OD_LIMIT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_value_regex' = 'required|exempt|pending');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `settlement_instructions` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instructions (SETTLE_INSTR)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `treasury_desk` SET TAGS ('dbx_business_glossary_term' = 'Treasury Desk (TREAS_DESK)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` SET TAGS ('dbx_subdomain' = 'banking_relationships');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `nostro_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Balance ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|pending');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `credit_movements` SET TAGS ('dbx_business_glossary_term' = 'Credit Movements');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `debit_movements` SET TAGS ('dbx_business_glossary_term' = 'Debit Movements');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'balance_snapshot');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `hold_balance` SET TAGS ('dbx_business_glossary_term' = 'Hold Balance');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `pending_credits` SET TAGS ('dbx_business_glossary_term' = 'Pending Credits');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `pending_debits` SET TAGS ('dbx_business_glossary_term' = 'Pending Debits');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'TransactionProcessingPlatform|SettlementSystem|Other');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_balance` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date (DATE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `currency_conversion_allowed` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Allowed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `dcc_supported` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Supported');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `destination_bank_codes` SET TAGS ('dbx_business_glossary_term' = 'Destination Bank BIC Codes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `destination_country_iso` SET TAGS ('dbx_business_glossary_term' = 'Destination Country ISO Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `destination_currency_codes` SET TAGS ('dbx_business_glossary_term' = 'Destination Currency Codes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `estimated_settlement_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Settlement Time (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `exchange_rate_source` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Source');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `exchange_rate_source` SET TAGS ('dbx_value_regex' = 'internal|external|third_party');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `ofac_screening_required` SET TAGS ('dbx_business_glossary_term' = 'OFAC Screening Required');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `payment_corridor_description` SET TAGS ('dbx_business_glossary_term' = 'Corridor Description');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `payment_corridor_status` SET TAGS ('dbx_business_glossary_term' = 'Corridor Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `payment_corridor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `payment_corridor_type` SET TAGS ('dbx_business_glossary_term' = 'Corridor Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `payment_corridor_type` SET TAGS ('dbx_value_regex' = 'standard|high_value|low_value|test');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `regulatory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Restrictions');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Corridor Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `settlement_instructions` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instructions');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `source_bank_codes` SET TAGS ('dbx_business_glossary_term' = 'Source Bank BIC Codes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `source_currency_codes` SET TAGS ('dbx_business_glossary_term' = 'Source Currency Codes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `supported_payment_rails` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Rails');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `supported_payment_rails` SET TAGS ('dbx_value_regex' = 'SWIFT|ACH|RTP|SEPA|LOCAL|OTHER');
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `exposure_id` SET TAGS ('dbx_business_glossary_term' = 'FX Exposure Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Exposure Direction (Long/Short)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'long|short');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `exposure_source` SET TAGS ('dbx_business_glossary_term' = 'Exposure Source (Origin of Exposure)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `exposure_source` SET TAGS ('dbx_value_regex' = 'pending_settlements|nostro_balances|forward_contracts|spot_trades|swap_positions|options');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Record Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_value_regex' = 'open|closed|reconciled|error');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `gross_notional_exposure` SET TAGS ('dbx_business_glossary_term' = 'Gross Notional Exposure (Currency Amount)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `hedging_status` SET TAGS ('dbx_business_glossary_term' = 'Hedging Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `hedging_status` SET TAGS ('dbx_value_regex' = 'hedged|partial|unhedged');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Amount (Currency)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `limit_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Name');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `limit_utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Utilization Amount (Currency)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `net_exposure` SET TAGS ('dbx_business_glossary_term' = 'Net Exposure After Hedges (Currency Amount)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `risk_limit_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Utilization Percentage');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp (UTC)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `unhedged_exposure` SET TAGS ('dbx_business_glossary_term' = 'Unhedged Exposure (Currency Amount)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date (Settlement Date)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `cross_border_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Payment ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'passed|flagged|pending');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `beneficiary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank BIC');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `beneficiary_iban` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary IBAN');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `beneficiary_iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `beneficiary_iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `chargeback_indicator` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Indicator');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `converted_amount` SET TAGS ('dbx_business_glossary_term' = 'Converted Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `cross_border_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `cross_border_payment_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|declined|settled|reversed|failed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `destination_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Currency Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Initiation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|forward|mid_market');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `exchange_rate_validity_end` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Validity End');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `exchange_rate_validity_start` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Validity Start');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `fx_rate_timestamp` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `ofac_screening_status` SET TAGS ('dbx_business_glossary_term' = 'OFAC Screening Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `ofac_screening_status` SET TAGS ('dbx_value_regex' = 'passed|blocked|pending');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `payment_purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `payment_rail` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `payment_rail` SET TAGS ('dbx_value_regex' = 'SWIFT|SEPA|ACH|LOCAL|OTHER');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_value_regex' = 'required|exempt|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Unique End‑to‑End Transaction Reference (UETR)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `total_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Currency Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `dcc_config_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `rate_margin_config_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Margin Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `cardholder_disclosure_text_ref` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Disclosure Text Reference (DISCLOSURE_REF)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (COMPLIANCE_NOTES)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code (CFG)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description (DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `config_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `dcc_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `dcc_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `dcc_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'DCC Margin Percentage (MARGIN_PCT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `enrolled_currency_pairs` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Currency Pairs');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `merchant_mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount (MIN_AMT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `offer_presentation_method` SET TAGS ('dbx_business_glossary_term' = 'Offer Presentation Method (METHOD)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `offer_presentation_method` SET TAGS ('dbx_value_regex' = 'terminal|online|ivr');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `opt_in_default` SET TAGS ('dbx_business_glossary_term' = 'Opt‑In Default Flag (OPT_IN_DEFAULT)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` SET TAGS ('dbx_subdomain' = 'banking_relationships');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'FX Fee Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Method');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Regulation');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'retail|corporate|enterprise');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type (FX Service Category)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'dcc|cross_border|currency_conversion|swift_wire');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fee_version` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Version');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fx_fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fx_fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `fx_fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Fee Schedule Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `maximum_fee` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `minimum_fee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'FX Fee Schedule Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'FX Fee Schedule Name');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `tier_details` SET TAGS ('dbx_business_glossary_term' = 'Tiered Fee Details');
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `rate_margin_config_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Margin Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `applicable_region_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `audit_comment` SET TAGS ('dbx_business_glossary_term' = 'Audit Comment');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `base_rate_source_code` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Source Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `base_rate_source_code` SET TAGS ('dbx_value_regex' = 'interbank|provider_x|provider_y');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `customer_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `customer_tier_code` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|standard');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `margin_basis` SET TAGS ('dbx_business_glossary_term' = 'Margin Basis');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `margin_basis` SET TAGS ('dbx_value_regex' = 'bps|percent');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `margin_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Type');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `margin_type` SET TAGS ('dbx_value_regex' = 'fixed_spread|percentage_markup|tiered_volume');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `margin_value_bps` SET TAGS ('dbx_business_glossary_term' = 'Margin Value (Basis Points)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `product_type_code` SET TAGS ('dbx_business_glossary_term' = 'Product Type Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `product_type_code` SET TAGS ('dbx_value_regex' = 'remittance|card_payment|e_commerce|p2p|b2b');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `rate_margin_config_description` SET TAGS ('dbx_business_glossary_term' = 'Margin Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `rate_margin_config_name` SET TAGS ('dbx_business_glossary_term' = 'Margin Configuration Name');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `rate_margin_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `rate_margin_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number (ACCOUNT_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `bank_bic_swift` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank BIC/SWIFT Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `bank_bic_swift` SET TAGS ('dbx_value_regex' = '^[A-Z]{8}([A-Z]{3})?$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `bank_bic_swift` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `bank_bic_swift` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Name (BANK_NAME)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Full Name (BENEFICIARY_NAME)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Record Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type (BENEFICIARY_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|government|nonprofit');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary City (CITY)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Contact Email (CONTACT_EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Contact Phone (CONTACT_PHONE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `external_beneficiary_code` SET TAGS ('dbx_business_glossary_term' = 'External Beneficiary ID (EXTERNAL_BENEFICIARY_ID)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary IBAN (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `is_preferred` SET TAGS ('dbx_business_glossary_term' = 'Preferred Beneficiary Flag (IS_PREFERRED)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `last_payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Timestamp (LAST_PAYMENT_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Postal Code (POSTAL_CODE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Sanctions Screening Status (SANCTIONS_SCREENING_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|matched|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Tax Identification Number (TAX_ID)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Verification Status (VERIFICATION_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|failed');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` SET TAGS ('dbx_subdomain' = 'banking_relationships');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` SET TAGS ('dbx_association_edges' = 'fx.payment_corridor,fx.correspondent_bank');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `corridor_bank_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Corridor Bank Assignment Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Corridor Bank Assignment - Correspondent Bank Id');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Corridor Bank Assignment - Payment Corridor Id');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `assigned_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Creator User');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `assigned_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `assigned_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Operational Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `fee_override` SET TAGS ('dbx_business_glossary_term' = 'Corridor-Specific Fee Override');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Correspondent Flag');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `max_daily_volume_usd` SET TAGS ('dbx_business_glossary_term' = 'Daily Volume Limit');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `payment_corridors` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridors');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority Rank');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Corridor-Specific Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`fx`.`corridor_bank_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` SET TAGS ('dbx_association_edges' = 'fx.rate_feed,fx.currency_pair');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `feed_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Feed Coverage Identifier');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Feed Coverage - Currency Pair Id');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `rate_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Feed Coverage - Rate Feed Id');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `confidence_weight` SET TAGS ('dbx_business_glossary_term' = 'Rate Confidence Weight');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `is_primary_source` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Designation');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `last_rate_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Rate Receipt Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `polling_frequency_seconds` SET TAGS ('dbx_business_glossary_term' = 'Pair-Specific Polling Frequency');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `precision_override` SET TAGS ('dbx_business_glossary_term' = 'Feed-Specific Precision Override');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `supported_currency_pairs` SET TAGS ('dbx_business_glossary_term' = 'Supported Currency Pairs');
ALTER TABLE `payments_fintech_ecm`.`fx`.`feed_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
