-- Schema for Domain: transaction | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`transaction` COMMENT 'Core payment transaction processing owning the full lifecycle from authorization, capture, clearing, settlement instruction, and reconciliation. SSOT for all payment events processed through ISO 8583 and ISO 20022 message flows, real-time authorization decisions, batch processing records, TPS metrics, STP rates, and multi-currency transaction data across card-present, card-not-present, and digital payment channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` (
    `instrument_issuance_id` BIGINT COMMENT 'System‑generated unique identifier for the instrument issuance event.',
    `address_id` BIGINT COMMENT 'Reference to the address where a physical instrument (card, letter) is to be sent.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the party (bank, fintech, or partner) that issued the instrument.',
    `original_issuance_instrument_issuance_id` BIGINT COMMENT 'Identifier of the original issuance record when this is a re‑issue.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch run that processed this issuance (e.g., nightly settlement batch).',
    `activation_deadline` DATE COMMENT 'Date by which the instrument must be activated before it expires or is de‑provisioned.',
    `aml_check_status` STRING COMMENT 'Outcome of Anti‑Money‑Laundering screening for the issuance.. Valid values are `cleared|flagged|pending`',
    `channel` STRING COMMENT 'The delivery channel through which the issuance request originated.. Valid values are `branch|online|mobile|api|partner`',
    `compliance_review_status` STRING COMMENT 'Overall compliance review result for the issuance (PCI, regulatory).. Valid values are `passed|failed|pending`',
    `expiration_date` DATE COMMENT 'Date after which the instrument is no longer valid for transactions.',
    `fulfillment_method` STRING COMMENT 'Method used to deliver the physical or digital instrument to the holder.. Valid values are `instant|mail|digital|pickup`',
    `instrument_issuance_status` STRING COMMENT 'Current lifecycle state of the issuance record.. Valid values are `pending|approved|rejected|completed|cancelled`',
    `instrument_type` STRING COMMENT 'Categorises the kind of payment instrument being issued.. Valid values are `card|virtual_card|ach_account|token|digital_wallet|prepaid`',
    `is_reissued` BOOLEAN COMMENT 'True if this issuance replaces a previously issued instrument.',
    `is_tokenized` BOOLEAN COMMENT 'Indicates whether the instrument is stored as a token rather than a clear PAN.',
    `issuance_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged to the customer for issuing the instrument.',
    `issuance_fee_currency` STRING COMMENT 'Currency in which the issuance fee is expressed.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `issuance_number` STRING COMMENT 'Business‑visible sequential number assigned to each issuance for tracking and reconciliation.',
    `issuance_status_detail` STRING COMMENT 'Free‑form text providing additional context about the current status (e.g., reason for rejection).',
    `issuance_timestamp` TIMESTAMP COMMENT 'Exact moment the issuance event occurred in the real world.',
    `issuing_bank_code` BIGINT COMMENT 'Reference to the financial institution that issued the instrument.',
    `kyc_status` STRING COMMENT 'Result of the Know‑Your‑Customer verification for the instrument holder.. Valid values are `verified|pending|failed`',
    `net_amount` DECIMAL(18,2) COMMENT 'Total amount credited to the holder after deducting issuance fees.',
    `net_currency` STRING COMMENT 'Currency of the net amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `notes` STRING COMMENT 'Free‑form field for operational comments or exceptions.',
    `pan` STRING COMMENT 'The 16‑digit card number assigned to the issued card. Stored in encrypted form per PCI DSS.. Valid values are `^[0-9]{16}$`',
    `product_code` STRING COMMENT 'Internal code representing the specific product variant (e.g., Visa Platinum, Debit‑Lite).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the issuance record was first persisted in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the issuance record.',
    `token_service_provider_code` BIGINT COMMENT 'Reference to the TSP that generated the token.',
    `token_value` DECIMAL(18,2) COMMENT 'Non‑sensitive token that replaces the PAN for tokenized instruments.',
    CONSTRAINT pk_instrument_issuance PRIMARY KEY(`instrument_issuance_id`)
) COMMENT 'Transactional record capturing the issuance event of a payment instrument — card printing and dispatch, virtual card generation, ACH account enrollment, or token provisioning. Stores issuance date, issuance channel (branch, online, mobile, API), issuing entity, fulfillment method (instant issue, mail, digital), delivery address reference, activation deadline, and issuance status. Provides the authoritative issuance audit trail per PCI DSS and regulatory requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` (
    `payment_txn_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each payment transaction record.',
    `account_holder_id` BIGINT COMMENT 'Internal surrogate key of the cardholder (or payer) involved in the transaction.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.risk_assessment. Business justification: Compliance audit mandates storing the detailed risk assessment record generated for each transaction, linking to risk.risk_assessment.',
    `compliance_aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Regulatory AML screening per transaction stores result in compliance_aml_screening_result; linking enables audit trails and SAR generation.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Enables treasury to aggregate exposure and risk metrics by currency pair for each payment transaction.',
    `device_id` BIGINT COMMENT 'Identifier of the device used to present the payment credential; may be a DPAN or device serial number.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Wallet‑originated payments must reference the originating digital wallet for reconciliation and AML reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal surrogate key of the acquiring financial institution that processed the transaction.',
    `gateway_api_credential_id` BIGINT COMMENT 'Foreign key linking to gateway.api_credential. Business justification: Billing and security audits track which API credential (client) processed each payment transaction.',
    `merchant_id` BIGINT COMMENT 'Internal surrogate key of the merchant that originated the transaction.',
    `merchant_location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Required for location‑level transaction reporting, risk scoring and settlement attribution; merchants need to know which physical location processed each payment.',
    `payment_instrument_id` BIGINT COMMENT 'Foreign key linking to wallet.payment_instrument. Business justification: Required for settlement and instrument‑level reporting linking each payment transaction to the specific card or token used.',
    `pos_entry_mode_id` BIGINT COMMENT 'Foreign key linking to transaction.pos_entry_mode. Business justification: Standardize entry mode by linking payment_txn to the pos_entry_mode reference table; replace the free‑text entry_mode column with a foreign key.',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier of the point‑of‑sale terminal that captured the transaction.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Required for audit and regulatory reporting to identify the exact FX rate applied to each cross‑border payment transaction.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each transaction must be tagged with the applicable regulatory obligation (e.g., PSD2, AML) for reporting and compliance monitoring.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Audit & compliance require linking each payment transaction to the originating API request for traceability and dispute investigation.',
    `response_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_response. Business justification: Reconciliation and settlement reports need the exact gateway response that settled the payment transaction.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Regulatory AML/fraud monitoring requires each payment transaction to be linked to the associated risk profile used for scoring.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Regulatory interchange reporting requires each payment transaction to be linked to its card scheme for fee calculation and compliance.',
    `sub_merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.sub_merchant. Business justification: Needed for PayFac models to attribute each payment to the originating sub‑merchant for settlement, revenue share, and compliance reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Linking transaction currency to the currency master enables consistent currency handling and conversion logic. Add transaction_currency_id (FK to reference.currency.currency_id) and retire the free‑fo',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: Transaction records need a formal link to the MCC master data for reporting and fee calculation. Adding transaction_mcc_id (FK to reference.mcc.mcc_id) replaces the loosely‑typed mcc_code.',
    `acquirer_code` BIGINT COMMENT 'Internal surrogate key of the acquiring financial institution that processed the transaction.',
    `auth_code` STRING COMMENT 'Alphanumeric code generated by the issuer confirming approval of the transaction.',
    `avs_result` STRING COMMENT 'Result code from AVS indicating match level between billing address and card issuer records.',
    `batch_number` STRING COMMENT 'Identifier of the batch in which the transaction was processed for settlement.',
    `channel_type` STRING COMMENT 'Delivery channel through which the transaction was captured (POS, mPOS, eCommerce, QR, NFC, HCE, mobile_app, API).',
    `compliance_flag` BOOLEAN COMMENT 'True if the transaction passed all AML/KYC and regulatory screening checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was first persisted in the lakehouse.',
    `cvv_result` STRING COMMENT 'Result code indicating whether the CVV supplied matched the issuers record.',
    `decline_reason` STRING COMMENT 'Human‑readable reason provided when a transaction is declined (e.g., insufficient funds, suspected fraud).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Conversion rate applied when the transaction involves a foreign currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Sum of fees (interchange, network, processing) applied to the transaction.',
    `fraud_flag` BOOLEAN COMMENT 'True if the transaction was flagged for potential fraud and requires review.',
    `is_cross_border` BOOLEAN COMMENT 'True if the transaction involved currency conversion or parties in different countries.',
    `is_stp` BOOLEAN COMMENT 'True when the transaction was processed end‑to‑end without manual intervention.',
    `iso_message_type` STRING COMMENT 'Four‑digit code identifying the message class (e.g., 0100 for authorization request).. Valid values are `^d{4}$`',
    `iso_message_version` STRING COMMENT 'Year of the ISO 8583 version used for the message (e.g., 2003).. Valid values are `^d{4}$`',
    `mcc` STRING COMMENT 'Four‑digit code classifying the merchants primary business activity.. Valid values are `^d{4}$`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount settled to the merchant after fees, expressed in transaction currency.',
    `network` STRING COMMENT 'Card scheme or payment network that processed the transaction (Visa, Mastercard, Amex, Discover, UnionPay, Other).',
    `original_amount` DECIMAL(18,2) COMMENT 'Transaction amount in the original currency prior to conversion.',
    `original_currency_code` STRING COMMENT 'Currency code of the amount before conversion (if different from transaction_currency).. Valid values are `^[A-Z]{3}$`',
    `payment_txn_status` STRING COMMENT 'Current processing state of the transaction (e.g., authorized, captured, settled, declined, reversed, chargeback).',
    `processing_code` STRING COMMENT 'Four‑digit ISO 8583 processing code indicating transaction type and account handling.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating generated by the fraud engine; higher values indicate greater suspicion.',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled to the merchants account.',
    `settlement_instruction_id` BIGINT COMMENT 'Foreign key linking to settlement.instruction. Business justification: Audit trail requires linking each payment transaction to its settlement instruction for regulatory reporting and dispute reconciliation.',
    `settlement_status` STRING COMMENT 'Current status of the settlement process (pending, settled, failed).',
    `tokenization_flag` BOOLEAN COMMENT 'True if the transaction used a tokenized payment credential instead of a clear PAN.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the transaction before fees or adjustments, expressed in transaction currency.',
    `transaction_reference` STRING COMMENT 'External identifier assigned by the acquiring network (e.g., Acquirer Reference Number) that uniquely identifies the transaction across the payment ecosystem.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the transaction was initiated or authorized in the payment network.',
    `transaction_type` STRING COMMENT 'Business classification of the transaction (purchase, refund, reversal, cash_advance, preauth, capture).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this transaction record (e.g., status change, settlement update).',
    CONSTRAINT pk_payment_txn PRIMARY KEY(`payment_txn_id`)
) COMMENT 'Core SSOT for every payment transaction processed through the platform — card-present, card-not-present, and digital payment channels. Captures the full ISO 8583 / ISO 20022 message lifecycle from authorization request through capture, including transaction amount, currency, MCC, channel type (POS, mPOS, eCommerce, QR, NFC, HCE), entry mode (EMV, swipe, contactless, manual), transaction timestamp, acquirer reference number (ARN), network transaction ID, processing code, response code, and STP flag. Single authoritative record per payment event.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`authorization` (
    `authorization_id` BIGINT COMMENT 'Unique identifier for the authorization record.',
    `authorization_response_code_id` BIGINT COMMENT 'Foreign key linking to reference.authorization_response_code. Business justification: Compliance and fraud analysis need the exact authorization response code entity to interpret response meanings.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Card scheme lookup (Visa, MC, etc.) drives fee rules and risk scoring; linking to scheme master is required for accurate processing.',
    `decline_code_id` BIGINT COMMENT 'Foreign key linking to reference.decline_code. Business justification: Regulatory reporting requires linking each authorization decline to the official decline_code reference for audit and analytics.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the transaction.',
    `original_auth_authorization_id` BIGINT COMMENT 'Reference to the first authorization attempt when this record is a retry.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal or device used for the transaction.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Each authorization originates from a gateway API request; linking enables end‑to‑end audit of auth decisions.',
    `amount_authorized` DECIMAL(18,2) COMMENT 'The monetary amount that was approved by the issuer.',
    `amount_requested` DECIMAL(18,2) COMMENT 'The monetary amount requested for authorization.',
    `auth_reference_number` STRING COMMENT 'External reference number for the authorization attempt, used for reconciliation and reporting.',
    `auth_retry_count` STRING COMMENT 'Number of authorization attempts made for this transaction.',
    `auth_source` STRING COMMENT 'Origin of the authorization request – real‑time or batch processing.. Valid values are `real_time|batch`',
    `auth_status` STRING COMMENT 'Current lifecycle status of the authorization attempt.. Valid values are `approved|declined|referral|error`',
    `authorization_code` STRING COMMENT 'Code returned by the issuer indicating approval.',
    `avs_result` STRING COMMENT 'Result of the AVS check. [ENUM-REF-CANDIDATE: Y|N|X|U|R|S|D|M|P|I|C|B|E|G|A|N — promote to reference product]',
    `card_type` STRING COMMENT 'Classification of the card.. Valid values are `credit|debit|prepaid|commercial|corporate`',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the transaction passed mandatory compliance checks (e.g., AML, sanctions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this authorization record was first persisted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the transaction.. Valid values are `[A-Z]{3}`',
    `cvv_result` STRING COMMENT 'Result of the CVV check. [ENUM-REF-CANDIDATE: M|N|P|S|U|X — promote to reference product]',
    `device_fingerprint` STRING COMMENT 'Unique identifier derived from device characteristics for fraud detection.',
    `device_ip_address` STRING COMMENT 'IP address of the device that originated the authorization request.',
    `fraud_flag` STRING COMMENT 'Categorical risk level derived from the fraud score.. Valid values are `low|medium|high`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the fraud detection engine.',
    `is_card_present` BOOLEAN COMMENT 'True if the card was physically present at the point of sale.',
    `is_contactless` BOOLEAN COMMENT 'True if the transaction used contactless technology.',
    `is_test_transaction` BOOLEAN COMMENT 'True if the transaction is a test or sandbox transaction.',
    `issuer_response_time_ms` STRING COMMENT 'Time in milliseconds taken by the issuer to respond.',
    `merchant_category_code` STRING COMMENT 'Four‑digit code representing the merchants business type.. Valid values are `d{4}`',
    `merchant_country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the merchant location.. Valid values are `[A-Z]{3}`',
    `network_latency_ms` STRING COMMENT 'Measured network latency between gateway and issuer.',
    `pan_last4` STRING COMMENT 'Last four digits of the Primary Account Number (masked).. Valid values are `d{4}`',
    `payment_channel` STRING COMMENT 'Channel through which the payment was initiated.. Valid values are `online|mobile|pos|mpos|api`',
    `payment_method` STRING COMMENT 'Instrument used for the payment.. Valid values are `card|token|bank_transfer|digital_wallet|cash`',
    `processing_time_ms` STRING COMMENT 'Overall time taken to process the authorization request end‑to‑end.',
    `regulatory_reporting_flag` STRING COMMENT 'Indicates the reporting requirement status for the transaction.. Valid values are `required|exempt|not_applicable`',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization request was sent to the issuer.',
    `response_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization response was received from the issuer.',
    `sca_status` STRING COMMENT 'Result of the SCA evaluation for the transaction.. Valid values are `succeeded|failed|exempted|not_applicable`',
    `three_ds_result` STRING COMMENT 'Outcome of the 3‑D Secure authentication flow.',
    `token_used` BOOLEAN COMMENT 'True if a tokenized PAN was used for the transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this authorization record.',
    CONSTRAINT pk_authorization PRIMARY KEY(`authorization_id`)
) COMMENT 'Real-time authorization decision record produced by the Payment Gateway and Authorization Engine for each payment transaction. Stores the authorization request and response pair including authorization code, response code, decline reason, AVS result, CVV result, 3DS authentication result, SCA outcome, issuer response time, network latency, and the final approve/decline/referral decision. One authorization record per authorization attempt; a single payment may have multiple authorization attempts (retries).';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`capture` (
    `capture_id` BIGINT COMMENT 'System-generated unique identifier for the capture record.',
    `account_holder_id` BIGINT COMMENT 'Identifier of the cardholder (consumer) for the captured transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (consumer) for the captured transaction.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the captured transaction.',
    `authorization_id` BIGINT COMMENT 'Identifier of the original authorization transaction that this capture fulfills.',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier of the payment terminal used for the capture.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Each capture is settled via a settlement record; linking supports audit of captured amounts against settlement.',
    `transaction_batch_id` BIGINT COMMENT 'Reference to the settlement batch that includes this capture.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the device (e.g., token or POS terminal) that originated the capture.',
    `acquirer_reference_number` STRING COMMENT 'Unique reference assigned by the acquiring bank for tracking the transaction.',
    `amount` DECIMAL(18,2) COMMENT 'Authorized amount captured before any adjustments, expressed in the transaction currency.',
    `auth_code` STRING COMMENT 'Code returned by the issuing bank confirming the original authorization.',
    `capture_method` STRING COMMENT 'Method by which the capture was performed (immediate, delayed, incremental, or partial).. Valid values are `immediate|delayed|incremental|partial`',
    `capture_number` STRING COMMENT 'Business-facing identifier for the capture event, often used in reporting and reconciliation.',
    `capture_status` STRING COMMENT 'Current lifecycle status of the capture (e.g., pending, completed, failed, reversed, partial).. Valid values are `pending|completed|failed|reversed|partial`',
    `capture_timestamp` TIMESTAMP COMMENT 'Exact date and time when the capture was performed, per ISO 8583/20022 event time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capture record was first persisted in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the capture amount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate applied when converting capture currency to settlement currency.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the capture was flagged for potential fraud.',
    `interchange_fee` DECIMAL(18,2) COMMENT 'Fee paid between acquiring and issuing banks for this capture.',
    `is_incremental` BOOLEAN COMMENT 'True when the capture adds to a previously captured amount (multiple captures).',
    `is_partial_capture` BOOLEAN COMMENT 'Indicates whether the capture represents a partial amount of the original authorization.',
    `is_settled` BOOLEAN COMMENT 'True when the capture amount has been successfully settled.',
    `merchant_category_code` STRING COMMENT 'Four‑digit code classifying the merchants business type.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount after tip, surcharge, and tax adjustments.',
    `network` STRING COMMENT 'Payment network that processed the transaction (e.g., Visa, Mastercard).. Valid values are `Visa|Mastercard|Amex|Discover|UnionPay|Other`',
    `processing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the payment processor for handling the capture.',
    `reversal_amount` DECIMAL(18,2) COMMENT 'Amount reversed from the capture, if a reversal occurred.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Timestamp when the capture was reversed.',
    `risk_score_at_capture` DECIMAL(18,2) COMMENT 'Fraud risk score assigned at the moment of capture.',
    `sequence_number` STRING COMMENT 'Ordinal number of this capture within a series of incremental captures.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Amount settled to the merchant after fees and adjustments.',
    `settlement_currency` STRING COMMENT 'Currency in which the settlement amount is paid to the merchant.',
    `settlement_date` DATE COMMENT 'Date on which the captured amount was settled to the merchant.',
    `settlement_status` STRING COMMENT 'Current status of the settlement process for this capture.. Valid values are `pending|settled|failed`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Any surcharge (e.g., service fee) applied at capture time.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the captured amount, if applicable.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Additional tip amount added to the capture, if applicable.',
    `transaction_type` STRING COMMENT 'Nature of the transaction captured (e.g., purchase, refund).. Valid values are `purchase|refund|reversal|auth_capture|preauth_capture`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the capture record.',
    CONSTRAINT pk_capture PRIMARY KEY(`capture_id`)
) COMMENT 'Capture record finalizing an authorized transaction for downstream clearing and settlement. Tracks the capture amount (which may differ from authorized amount for tip-adjusted or partial captures), capture timestamp, capture method (immediate, delayed, incremental), batch ID reference, and capture status. Represents the business event that moves a transaction from authorized to billable state in the Transaction Processing Platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` (
    `clearing_submission_id` BIGINT COMMENT 'Unique identifier for the clearing submission record.',
    `account_holder_id` BIGINT COMMENT 'Identifier of the cardholder who performed the transaction.',
    `cardholder_account_id` BIGINT COMMENT 'Identifier of the cardholder who performed the transaction.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that originated the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Business identifier of the original captured transaction.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch file that contains this clearing record.',
    `transaction_id` BIGINT COMMENT 'Business identifier of the original captured transaction.',
    `acquiring_institution_code` BIGINT COMMENT 'Identifier of the acquiring financial institution.',
    `aml_screened_flag` BOOLEAN COMMENT 'True when the transaction passed AML screening.',
    `amount_fee` DECIMAL(18,2) COMMENT 'Sum of all fees applied to the transaction.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total transaction amount before fees and adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Transaction amount after fees are deducted.',
    `authorization_code` STRING COMMENT 'Code returned by the issuer approving the transaction.. Valid values are `^[A-Z0-9]{6,8}$`',
    `bin_number` STRING COMMENT 'First six digits of the card number identifying the issuing bank.. Valid values are `^d{6}$`',
    `channel` STRING COMMENT 'Interface through which the transaction was initiated.. Valid values are `online|pos|mobile|atm`',
    `chargeback_flag` BOOLEAN COMMENT 'True if the transaction resulted in a chargeback.',
    `clearing_date` DATE COMMENT 'Calendar date on which the transaction cleared.',
    `clearing_submission_status` STRING COMMENT 'Current processing state of the clearing submission.. Valid values are `captured|submitted|settled|rejected|reversed`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction.. Valid values are `^[A-Z]{3}$`',
    `decline_reason` STRING COMMENT 'Human‑readable description of why a transaction was declined.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used when converting to settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the fee specified by fee_type.',
    `fee_type` STRING COMMENT 'Category of fee applied to the transaction.. Valid values are `interchange|assessment|network|processor`',
    `iin_number` STRING COMMENT 'Six‑digit identifier of the card issuer.. Valid values are `^d{6}$`',
    `interchange_category` STRING COMMENT 'Classification used to determine interchange fees.. Valid values are `qualified|unqualified|exempt|special`',
    `irf_amount` DECIMAL(18,2) COMMENT 'Fee amount calculated based on IRF rate category.',
    `irf_rate_category` STRING COMMENT 'Rate tier applied for IRF calculation.. Valid values are `standard|high|low|exempt`',
    `issuing_institution_code` BIGINT COMMENT 'Identifier of the issuing financial institution.',
    `mcc_code` STRING COMMENT 'Four‑digit code classifying the merchants business.. Valid values are `^d{4}$`',
    `pci_compliant_flag` BOOLEAN COMMENT 'True if the transaction data meets PCI compliance requirements.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the clearing submission record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `response_code` STRING COMMENT 'Two‑digit response indicating approval or decline reason.. Valid values are `^d{2}$`',
    `reversal_flag` BOOLEAN COMMENT 'True if the transaction was reversed after initial capture.',
    `sanction_check_flag` BOOLEAN COMMENT 'True when the transaction passed sanctions screening.',
    `scheme_code` STRING COMMENT 'Payment network brand associated with the transaction.. Valid values are `visa|mastercard|amex|discover|unionpay`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final amount transferred to the acquiring institution after conversion.',
    `settlement_currency` STRING COMMENT 'Currency in which the transaction is settled.. Valid values are `^[A-Z]{3}$`',
    `submission_reference` STRING COMMENT 'Reference assigned by the card scheme or ACH network for this clearing submission.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was submitted to the scheme for settlement.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the original transaction was authorized.',
    `transaction_type` STRING COMMENT 'Category of payment instrument used for the transaction.. Valid values are `card|ach|wire|digital_wallet`',
    CONSTRAINT pk_clearing_submission PRIMARY KEY(`clearing_submission_id`)
) COMMENT 'Clearing file record generated by the Transaction Processing Platform representing a captured transaction submitted to the card scheme or ACH network for interbank settlement. Contains clearing amount, clearing currency, interchange qualification category, MCC, BIN, IIN, scheme-assigned clearing reference, clearing file batch ID, clearing date, and scheme-specific data elements required for IRF calculation. SSOT for the clearing lifecycle stage of each transaction.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` (
    `txn_lifecycle_event_id` BIGINT COMMENT 'Unique surrogate key for each immutable transaction lifecycle event record.',
    `account_holder_id` BIGINT COMMENT 'Unique identifier of the cardholder (customer) for the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder (customer) for the transaction.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant involved in the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the payment transaction to which this lifecycle event belongs.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS or terminal that captured the transaction.',
    `tokenization_request_id` BIGINT COMMENT 'Identifier of the token representing the payment credential used.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch (if the event is part of a batch).',
    `transaction_id` BIGINT COMMENT 'Identifier of the payment transaction to which this lifecycle event belongs.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Operational audit: manual overrides or adjustments in transaction lifecycle must capture the responsible employee.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the event, expressed in the transaction currency.',
    `auth_code` STRING COMMENT 'Issuer‑provided code confirming authorization.',
    `channel` STRING COMMENT 'Delivery channel through which the transaction was initiated.. Valid values are `card_present|ecommerce|mobile|atm|pos`',
    `chargeback_flag` BOOLEAN COMMENT 'True if a chargeback has been filed for the transaction.',
    `compliance_flag` STRING COMMENT 'Compliance regime applicable to the event.. Valid values are `pci_dss|aml|sarl|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first persisted in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the transaction amount.',
    `decline_reason` STRING COMMENT 'Textual reason for a declined transaction, if applicable.',
    `dispute_flag` BOOLEAN COMMENT 'True if the transaction is currently under dispute.',
    `event_description` STRING COMMENT 'Free‑form text providing additional context for the event.',
    `event_sequence_number` STRING COMMENT 'Sequential number of the event within the transaction lifecycle.',
    `event_source_system` STRING COMMENT 'Originating system that generated the event record.. Valid values are `gateway|processor|fraud_engine|wallet|settlement_system`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the lifecycle event occurred in the source system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee applied at the time of the event (e.g., interchange, service fee).',
    `iso_message_type_code` STRING COMMENT 'ISO 8583 or ISO 20022 message type identifier associated with the event (e.g., 0100, 0200, 0300).',
    `network_code` STRING COMMENT 'Payment network identifier (e.g., Visa, Mastercard, ACH).',
    `new_state` STRING COMMENT 'State of the transaction after this event was applied. [ENUM-REF-CANDIDATE: authorized|captured|cleared|settled|reversed|voided|refunded|chargeback|disputed|pending — promote to reference product]',
    `payment_method` STRING COMMENT 'Instrument used to fund the transaction.. Valid values are `credit_card|debit_card|bank_transfer|digital_wallet|cash`',
    `prior_state` STRING COMMENT 'State of the transaction before this event occurred. [ENUM-REF-CANDIDATE: authorized|captured|cleared|settled|reversed|voided|refunded|chargeback|disputed|pending — promote to reference product]',
    `processing_latency_ms` STRING COMMENT 'Time in milliseconds taken to process the event from receipt to completion.',
    `refund_flag` BOOLEAN COMMENT 'True if the event represents a refund.',
    `response_code` STRING COMMENT 'ISO response code indicating success, decline, or error.',
    `reversal_flag` BOOLEAN COMMENT 'True if the event represents a reversal of a prior transaction.',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score calculated at the moment of the event.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final settled amount after fees and adjustments.',
    `settlement_currency` STRING COMMENT 'Currency in which the transaction is settled.',
    `settlement_date` DATE COMMENT 'Calendar date on which the transaction was settled.',
    `settlement_status` STRING COMMENT 'Current status of the settlement process for the transaction.. Valid values are `pending|settled|failed|reconciled`',
    `source_ip_address` STRING COMMENT 'IP address of the system that originated the event.',
    `stp_indicator` BOOLEAN COMMENT 'True if the transaction was processed without manual intervention.',
    `tps` STRING COMMENT 'Observed TPS rate at the time of the event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this immutable record (normally equals created_timestamp).',
    `void_flag` BOOLEAN COMMENT 'True if the transaction was voided before capture.',
    CONSTRAINT pk_txn_lifecycle_event PRIMARY KEY(`txn_lifecycle_event_id`)
) COMMENT 'Immutable audit log of every state transition in a payment transactions lifecycle — authorization, capture, clearing submission, settlement, reversal, void, refund initiation, chargeback flag. Each row records the prior state, new state, event timestamp, triggering actor (system, user, network), and ISO message type code. Enables full end-to-end transaction traceability required for PCI DSS audit trails and regulatory reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`reversal` (
    `reversal_id` BIGINT COMMENT 'System-generated unique identifier for the reversal record.',
    `ecosystem_partner_id` BIGINT COMMENT 'System identifier of the party that initiated the reversal.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original payment transaction that is being reversed.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the original payment transaction that is being reversed.',
    `instruction_id` BIGINT COMMENT 'Reference to the settlement instruction generated for the reversal.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch processing run that includes this reversal.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount being reversed from the original transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reversal record was first persisted in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the reversal amount.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee associated with processing the reversal.',
    `initiating_party_role` STRING COMMENT 'Role of the entity that initiated the reversal.. Valid values are `merchant|acquirer|issuer|network|processor`',
    `is_successful` BOOLEAN COMMENT 'True when the reversal completed successfully.',
    `net_reversal_amount` DECIMAL(18,2) COMMENT 'Net amount after deducting reversal fees.',
    `partial_reversal_flag` BOOLEAN COMMENT 'True if the reversal is for a portion of the original amount.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the reversal was performed (e.g., ISO 8583 reason code).',
    `reason_description` STRING COMMENT 'Human‑readable description of the reversal reason.',
    `reference` STRING COMMENT 'External reference code assigned to the reversal (e.g., RR202300001).',
    `reversal_status` STRING COMMENT 'Current processing status of the reversal.. Valid values are `pending|processed|failed|rejected`',
    `reversal_timestamp` TIMESTAMP COMMENT 'Exact time the reversal was executed in the payment network.',
    `reversal_type` STRING COMMENT 'Category of reversal: void, partial, timeout, or duplicate.. Valid values are `void|partial|timeout|duplicate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reversal record.',
    CONSTRAINT pk_reversal PRIMARY KEY(`reversal_id`)
) COMMENT 'Transaction reversal record capturing full and partial reversals, voids, and cancellations processed against an original payment transaction. Stores reversal type (void, partial reversal, timeout reversal), reversal amount, original transaction reference, reversal reason code, initiating party (merchant, acquirer, issuer, network), and reversal processing timestamp. Distinct from refunds (which are new debit transactions) and chargebacks (which are dispute-driven).';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`refund` (
    `refund_id` BIGINT COMMENT 'System-generated unique identifier for the refund record.',
    `account_holder_id` BIGINT COMMENT 'Unique identifier of the cardholder who made the original purchase.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who made the original purchase.',
    `chargeback_id` BIGINT COMMENT 'Identifier of the chargeback case associated with this refund, if any.',
    `device_id` BIGINT COMMENT 'Identifier of the device used to initiate the refund (e.g., POS terminal ID).',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that originated the original transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original sale transaction that is being refunded.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the original sale transaction that is being refunded.',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this refund.',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this refund.',
    `tokenization_request_id` BIGINT COMMENT 'Token representing the original payment instrument used for the refund.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount credited back to the cardholder or alternative instrument.',
    `batch_number` STRING COMMENT 'Identifier of the batch file in which the refund was processed.',
    `cardholder_email` STRING COMMENT 'Primary email address of the cardholder for communication and receipt delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cardholder_name` STRING COMMENT 'Legal full name of the cardholder.',
    `cardholder_pan_masked` STRING COMMENT 'Masked representation of the cardholders PAN (first 6 and last 4 digits visible) to comply with PCI DSS.. Valid values are `^d{6}*{6}d{4}$`',
    `channel` STRING COMMENT 'Channel through which the refund request was submitted.. Valid values are `online|mobile|pos|mpos`',
    `compliance_flag_aml` BOOLEAN COMMENT 'True if the refund triggered an AML screening alert.',
    `compliance_flag_fraud` BOOLEAN COMMENT 'True if the refund was flagged by the fraud detection engine.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the refund record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the refund amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when the refund currency differs from the original transaction currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee charged by the processor for processing the refund.',
    `fee_currency_code` STRING COMMENT 'Currency of the refund fee amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date‑time when the merchant initiated the refund request.',
    `is_chargeback_related` BOOLEAN COMMENT 'True if the refund is linked to an ongoing chargeback case.',
    `is_partial_refund` BOOLEAN COMMENT 'True if the refund amount is less than the original transaction amount.',
    `original_authorization_code` STRING COMMENT 'Six‑character code returned by the issuer for the original authorization.. Valid values are `^[A-Z0-9]{6}$`',
    `original_currency_code` STRING COMMENT 'Currency of the original transaction before any conversion.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `partial_refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded when the refund is partial.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date‑time when the refund was successfully posted to the cardholders account.',
    `processor_reference` STRING COMMENT 'Reference identifier returned by the payment processor for the refund transaction.',
    `reason_code` STRING COMMENT 'Standardized code describing why the refund was issued.. Valid values are `duplicate|customer_request|product_defect|fraud|other`',
    `reason_description` STRING COMMENT 'Free‑text description providing additional context for the refund reason.',
    `reference` STRING COMMENT 'External reference number assigned by the payment scheme or processor for this refund.',
    `refund_method` STRING COMMENT 'Method used to return funds: original payment instrument, alternative instrument, or store credit.. Valid values are `original|alternative|store_credit`',
    `refund_status` STRING COMMENT 'Current processing status of the refund.. Valid values are `pending|processed|failed|reversed`',
    `risk_decision` STRING COMMENT 'Decision outcome based on the risk score.. Valid values are `approve|review|reject`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned to the refund by the fraud engine.',
    `scheme_refund_reference` STRING COMMENT 'Identifier assigned by the card scheme (e.g., Visa, Mastercard) for the refund.',
    `settlement_date` DATE COMMENT 'Date on which the settlement batch containing the refund was settled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the refund record.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Refund transaction record representing a merchant-initiated credit back to a cardholders payment instrument following a completed sale. Captures refund amount, refund reason, original transaction reference, refund method (original payment instrument, alternative instrument), refund status, merchant-initiated timestamp, and scheme refund reference. Operationally distinct from reversals (pre-settlement) and chargebacks (dispute-driven). SSOT for merchant-initiated credit events.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` (
    `transaction_batch_id` BIGINT COMMENT 'Unique system-generated identifier for the transaction batch record.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant whose transactions are included in this batch.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: Batch processing is grouped into settlement cycles; linking enables cycle‑level performance and compliance reporting.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch received approval from downstream settlement validation.',
    `batch_type` STRING COMMENT 'Categorization of the batch purpose.. Valid values are `settlement|reversal|adjustment`',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA‑256) of the settlement file for integrity verification.',
    `close_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was closed to further transaction inclusion.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the batch amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CHF|AUD|CAD|... — promote to reference product]',
    `error_count` STRING COMMENT 'Number of error records detected during batch validation.',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'FX rate used to convert batch amounts to USD for reporting.',
    `file_name` STRING COMMENT 'Name of the file generated for settlement transmission.',
    `is_stp` BOOLEAN COMMENT 'Indicates whether the batch met straight‑through processing criteria.',
    `open_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was opened for transaction capture.',
    `processing_rate_tps` DECIMAL(18,2) COMMENT 'Average number of transactions processed per second during batch execution.',
    `processing_time_seconds` STRING COMMENT 'Total elapsed time in seconds to process the batch from open to close.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this batch record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch record.',
    `reference` STRING COMMENT 'External business reference number assigned to the batch for reconciliation with scheme and settlement files.',
    `rejection_reason` STRING COMMENT 'Human‑readable reason for batch rejection, if applicable.',
    `scheme_batch_reference` STRING COMMENT 'Identifier assigned by the payment scheme (e.g., Visa, Mastercard) for this batch.',
    `settlement_date` DATE COMMENT 'Date on which the batch was settled with the acquiring bank.',
    `settlement_reference` STRING COMMENT 'Reference identifier returned by the settlement system.',
    `settlement_status` STRING COMMENT 'Current settlement outcome for the batch.. Valid values are `settled|pending|failed`',
    `source_system` STRING COMMENT 'Originating system that produced the batch record.. Valid values are `gateway|processing|merchant|fraud|dispute`',
    `stp_rate` DECIMAL(18,2) COMMENT 'Percentage of transactions in the batch processed without manual intervention.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was submitted to the clearing/settlement system.',
    `total_amount` DECIMAL(18,2) COMMENT 'Sum of the gross amounts of all transactions in the batch, before fees and adjustments.',
    `total_amount_local` DECIMAL(18,2) COMMENT 'Batch total amount expressed in the batchs native currency.',
    `total_amount_usd` DECIMAL(18,2) COMMENT 'Batch total amount expressed in US dollars.',
    `total_fee_amount` DECIMAL(18,2) COMMENT 'Aggregate of all fees (interchange, MDR, IRF, etc.) applied to the batch.',
    `total_fee_amount_usd` DECIMAL(18,2) COMMENT 'Aggregate fee amount converted to USD.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount after subtracting fees and adjustments from the total amount.',
    `total_net_amount_usd` DECIMAL(18,2) COMMENT 'Net batch amount after fees, expressed in USD.',
    `total_transaction_count` STRING COMMENT 'Number of individual transactions captured in the batch.',
    `transaction_batch_status` STRING COMMENT 'Current lifecycle state of the batch as defined by the processing workflow.. Valid values are `open|closed|submitted|accepted|rejected|pending`',
    `version` STRING COMMENT 'Version of the batch record for audit and re‑processing purposes.',
    `warning_count` STRING COMMENT 'Number of warning records detected during batch validation.',
    `created_by` STRING COMMENT 'System user or service account that initiated the batch creation.',
    CONSTRAINT pk_transaction_batch PRIMARY KEY(`transaction_batch_id`)
) COMMENT 'Batch processing record representing a grouped set of captured transactions submitted together for clearing and settlement by the Transaction Processing Platform. Stores batch open timestamp, batch close timestamp, batch total transaction count, batch total amount, batch currency, batch status (open, closed, submitted, accepted, rejected), scheme batch reference, and STP rate for the batch. Enables reconciliation between individual transaction records and settlement file totals.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`batch_item` (
    `batch_item_id` BIGINT COMMENT 'Unique surrogate key for each line item within a settlement batch.',
    `device_id` BIGINT COMMENT 'Identifier of the device used for tokenized or mobile payments.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant associated with the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the original payment transaction captured in this batch line.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal that captured the transaction.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch that this line belongs to.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original payment transaction captured in this batch line.',
    `authorization_code` STRING COMMENT 'Code returned by the issuing bank approving the transaction.',
    `batch_item_description` STRING COMMENT 'Free‑form description or notes associated with the line item.',
    `card_scheme` STRING COMMENT 'Payment network brand of the card used (e.g., Visa, Mastercard).. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `chargeback_indicator` BOOLEAN COMMENT 'True if the line item originated from a chargeback.',
    `chargeback_reason_code` STRING COMMENT 'Code describing the reason for a chargeback. [ENUM-REF-CANDIDATE: FRAUD|DISPUTE|AUTH_ERROR|OTHER] ',
    `city` STRING COMMENT 'City where the transaction originated (derived from terminal location).',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the transactions originating country.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch item record was first created in the data lake.',
    `exception_code` STRING COMMENT 'Code indicating any processing exception for the line item. [ENUM-REF-CANDIDATE: ERR01|ERR02|ERR03|ERR04|ERR05|ERR06|ERR07|ERR08] ',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the original amount to the settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee applied to the line item (e.g., interchange or service fee).',
    `fee_currency` STRING COMMENT 'Currency of the fee amount.. Valid values are `^[A-Z]{3}$`',
    `ip_address` STRING COMMENT 'Source IP address of the transaction request.',
    `is_test_transaction` BOOLEAN COMMENT 'True if the transaction was generated in a test or sandbox environment.',
    `item_amount` DECIMAL(18,2) COMMENT 'Monetary amount for the line item in the transaction currency.',
    `item_currency` STRING COMMENT 'ISO 4217 three‑letter currency code of the item amount.. Valid values are `^[A-Z]{3}$`',
    `item_status` STRING COMMENT 'Current processing status of the batch line item.. Valid values are `included|excluded|error|reversed`',
    `item_type` STRING COMMENT 'Business classification of the line item (e.g., purchase, refund).. Valid values are `purchase|refund|chargeback|fee|adjustment`',
    `line_sequence` STRING COMMENT 'Sequential position of the item within the batch.',
    `mcc_code` STRING COMMENT 'Four‑digit code classifying the merchants business type.. Valid values are `^d{4}$`',
    `network_code` STRING COMMENT 'Code identifying the payment network or interchange used for routing.',
    `original_amount` DECIMAL(18,2) COMMENT 'Transaction amount in the originating currency before conversion.',
    `original_currency` STRING COMMENT 'ISO 4217 code of the currency in which the transaction was originally authorized.. Valid values are `^[A-Z]{3}$`',
    `original_transaction_reference` STRING COMMENT 'Reference to the original transaction identifier when this line is a reversal or adjustment.',
    `processing_timestamp` TIMESTAMP COMMENT 'Date‑time when the line item was processed by the settlement engine.',
    `quantity` STRING COMMENT 'Number of units represented by the line item (typically 1 for payment transactions).',
    `response_code` STRING COMMENT 'ISO 8583 response code indicating the outcome of the authorization.',
    `reversal_indicator` BOOLEAN COMMENT 'True if the line item represents a reversal of a prior transaction.',
    `risk_decision` STRING COMMENT 'Result of the risk assessment for the transaction.. Valid values are `approve|review|decline`',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the risk engine (0‑100).',
    `settlement_status` STRING COMMENT 'Current settlement state of the line item.. Valid values are `pending|settled|failed`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date‑time when the line item was settled to the acquiring bank.',
    `transaction_category` STRING COMMENT 'High‑level channel category of the transaction.. Valid values are `retail|ecommerce|mpos|qr|online|atm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch item record.',
    CONSTRAINT pk_batch_item PRIMARY KEY(`batch_item_id`)
) COMMENT 'Individual transaction line item within a settlement batch, linking each captured transaction to its parent batch record. Stores the sequence number within the batch, item amount, item currency, item status (included, excluded, error), and any item-level exception codes. Enables granular reconciliation and exception handling at the individual transaction level within a batch submission.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` (
    `transaction_reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for each reconciliation record.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant whose transactions are being reconciled.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch run that produced this reconciliation record.',
    `acquiring_bank_code` BIGINT COMMENT 'Identifier of the acquiring bank involved in the transaction flow.',
    `compliance_check_status` STRING COMMENT 'Result of automated compliance checks performed on the reconciliation data.. Valid values are `passed|failed|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `cross_border_flag` BOOLEAN COMMENT 'True if the batch contains any cross‑border transactions, false otherwise.',
    `currency_conversion_rate` DECIMAL(18,2) COMMENT 'FX rate applied when converting foreign‑currency transaction amounts to the settlement currency.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation resulted in any exceptions (true) or not (false).',
    `issuing_bank_code` BIGINT COMMENT 'Identifier of the issuing bank that supplied the payment instrument.',
    `matched_transaction_count` BIGINT COMMENT 'Number of transactions that successfully matched between internal records and scheme files.',
    `net_total_amount` DECIMAL(18,2) COMMENT 'Net amount after applying variance adjustments (total_matched_amount minus total_variance_amount).',
    `notes` STRING COMMENT 'Free‑form text for manual comments, observations, or actions taken during reconciliation.',
    `processing_time_seconds` STRING COMMENT 'Duration of the reconciliation process measured in seconds.',
    `reconciliation_number` STRING COMMENT 'Business identifier assigned to the reconciliation run, used for external reporting and audit.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation outcome: balanced (no differences), exception (discrepancies found), or pending (still processing).. Valid values are `balanced|exception|pending`',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation process was executed.',
    `reconciliation_type` STRING COMMENT 'Indicates whether the reconciliation is performed intraday, at end of day, or as a T+1 settlement.. Valid values are `intraday|end_of_day|t_plus_1`',
    `regulatory_report_indicator` STRING COMMENT 'Flag indicating whether this reconciliation record is included in regulatory reporting submissions.. Valid values are `yes|no`',
    `risk_score_average` DECIMAL(18,2) COMMENT 'Average fraud risk score of the transactions included in this reconciliation batch.',
    `settlement_currency` STRING COMMENT 'ISO 4217 currency code of the settlement amount (e.g., USD, EUR).',
    `settlement_date` DATE COMMENT 'Date on which the settlement for the reconciled batch is scheduled or completed.',
    `source_file_internal` STRING COMMENT 'File name or path of the internal transaction file used in the reconciliation.',
    `source_file_scheme` STRING COMMENT 'File name or path of the scheme‑provided clearing/settlement file used for comparison.',
    `total_fee_amount` DECIMAL(18,2) COMMENT 'Sum of all fees (interchange, processing, network) associated with the batch.',
    `total_matched_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of all matched transactions, expressed in settlement currency.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax component captured in the transaction batch, if applicable.',
    `total_transaction_amount` DECIMAL(18,2) COMMENT 'Aggregate amount of all transactions (matched and unmatched) before any adjustments.',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'Sum of monetary differences between internal and scheme amounts for unmatched or partially matched transactions.',
    `transaction_currency` STRING COMMENT 'ISO 4217 currency code of the original transaction amounts before conversion.',
    `transaction_volume` BIGINT COMMENT 'Total count of individual transaction lines evaluated in this reconciliation.',
    `unmatched_transaction_count` BIGINT COMMENT 'Number of transactions that did not find a counterpart in the scheme file.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    `variance_reason_code` STRING COMMENT 'Code describing the primary cause of the variance (e.g., amount mismatch, missing transaction).. Valid values are `amount_mismatch|missing_transaction|duplicate|other`',
    CONSTRAINT pk_transaction_reconciliation PRIMARY KEY(`transaction_reconciliation_id`)
) COMMENT 'Reconciliation record produced by the Transaction Processing Platform comparing internal transaction records against scheme-reported clearing and settlement files. Captures reconciliation date, reconciliation type (intraday, end-of-day, T+1 settlement), matched transaction count, unmatched transaction count, total matched amount, total variance amount, reconciliation status (balanced, exception, pending), and the source file references for both sides of the comparison. SSOT for transaction-level reconciliation outcomes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` (
    `reconciliation_exception_id` BIGINT COMMENT 'System-generated unique identifier for each reconciliation exception.',
    `assigned_resolver_employee_id` BIGINT COMMENT 'Identifier of the employee or team responsible for resolving the exception.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or team responsible for resolving the exception.',
    `transaction_id` BIGINT COMMENT 'Identifier of the internal transaction record that participated in the reconciliation.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch settlement or clearing run associated with the exception.',
    `amount_difference` DECIMAL(18,2) COMMENT 'Numeric difference between internal and scheme transaction amounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was initially created in the system.',
    `currency_exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting amounts between currencies for the exception.',
    `exception_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the exception (e.g., mismatched amount).',
    `exception_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the exception amount.. Valid values are `^[A-Z]{3}$`',
    `exception_description` STRING COMMENT 'Detailed textual description of the discrepancy that caused the exception.',
    `exception_severity` STRING COMMENT 'Risk severity rating assigned to the exception.. Valid values are `low|medium|high|critical`',
    `exception_status` STRING COMMENT 'Current processing state of the reconciliation exception.. Valid values are `open|investigating|resolved|closed`',
    `exception_timestamp` TIMESTAMP COMMENT 'Date and time when the reconciliation exception was first identified.',
    `exception_type` STRING COMMENT 'Category describing why the reconciliation exception occurred.. Valid values are `missing_in_scheme|missing_in_internal|amount_mismatch|duplicate|status_mismatch`',
    `investigation_status` STRING COMMENT 'Status of the internal investigation into the exception.. Valid values are `pending|in_progress|escalated|completed`',
    `is_duplicate_flag` BOOLEAN COMMENT 'Indicates whether the exception represents a duplicate transaction record.',
    `regulatory_flag` BOOLEAN COMMENT 'True if the exception triggers mandatory regulatory reporting (e.g., AML, SAR).',
    `resolution_notes` STRING COMMENT 'Free‑text notes documenting the resolution actions and outcomes.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was resolved or closed.',
    `source_system` STRING COMMENT 'Name of the operational system that generated the exception (e.g., transaction_processing, gateway).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exception record.',
    CONSTRAINT pk_reconciliation_exception PRIMARY KEY(`reconciliation_exception_id`)
) COMMENT 'Individual exception item identified during the reconciliation process where an internal transaction record does not match the scheme or bank-reported record. Stores exception type (missing in scheme file, missing in internal records, amount mismatch, duplicate), exception amount, exception currency, investigation status, assigned resolver, resolution timestamp, and resolution notes. Drives the exception management workflow in the Transaction Processing Platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` (
    `txn_routing_decision_id` BIGINT COMMENT 'System-generated unique identifier for each routing decision record.',
    `device_id` BIGINT COMMENT 'Identifier of the device (e.g., mobile device ID) used for the transaction.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank or processor selected.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: Routing decision records the specific network endpoint used for processing, needed for audit trails and latency monitoring.',
    `gateway_routing_rule_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_routing_rule. Business justification: Regulatory and performance reporting require knowing which routing rule was applied to each transaction routing decision.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that originated the transaction.',
    `network_scheme_id` BIGINT COMMENT 'Identifier of the payment network (e.g., Visa, Mastercard).',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the payment transaction for which the routing decision was made.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal that captured the transaction.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment network (e.g., Visa, Mastercard).',
    `token_id` BIGINT COMMENT 'Identifier of the token used in place of the PAN.',
    `transaction_id` BIGINT COMMENT 'Identifier of the payment transaction for which the routing decision was made.',
    `candidate_networks` STRING COMMENT 'Comma‑separated list of networks evaluated during routing decision.',
    `card_present` BOOLEAN COMMENT 'True if the transaction was card‑present (vs. card‑not‑present).',
    `channel` STRING COMMENT 'Channel through which the transaction was initiated.. Valid values are `online|in_store|mobile|atm|pos`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing decision record was first created in the lakehouse.',
    `cross_border_fee` DECIMAL(18,2) COMMENT 'Additional fee applied for cross‑border processing, if any.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction amount.',
    `decision_reference` STRING COMMENT 'Human‑readable reference code for the routing decision (e.g., RD‑20231101‑0001).',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing decision was recorded.',
    `durbin_compliance_applied` BOOLEAN COMMENT 'Flag indicating whether Durbin Amendment routing rules were enforced.',
    `is_cross_border` BOOLEAN COMMENT 'Indicates whether the transaction involved different currency jurisdictions.',
    `is_tokenized` BOOLEAN COMMENT 'True if the payment instrument was tokenized for this transaction.',
    `issuer_code` BIGINT COMMENT 'Identifier of the issuing bank or card scheme.',
    `lcr_applied` BOOLEAN COMMENT 'Flag indicating whether least‑cost routing logic was applied.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after fees (transaction_amount – transaction_fee).',
    `notes` STRING COMMENT 'Free‑form comments or notes added by operators or auditors.',
    `routing_latency_ms` STRING COMMENT 'Time in milliseconds from receipt of the transaction to routing decision.',
    `routing_path` STRING COMMENT 'Serialized representation of the processing path taken (e.g., gateway → network → acquirer).',
    `routing_reason` STRING COMMENT 'Business reason why the selected network was chosen.. Valid values are `least_cost|preferred|fallback|regulatory|capacity|risk`',
    `routing_rule_version` STRING COMMENT 'Version identifier of the routing rule set applied to this transaction.',
    `selected_network` STRING COMMENT 'Payment network that was selected to process the transaction.. Valid values are `VISA|MASTERCARD|DISCOVER|AMEX|UNIONPAY|OTHER`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Gross amount of the transaction before fees or discounts.',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Total fees applied to the transaction (e.g., interchange, network, processing).',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact time the transaction was initiated by the cardholder or payer.',
    `txn_routing_decision_status` STRING COMMENT 'Current processing status of the routing decision record.. Valid values are `pending|completed|failed|reversed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the routing decision record.',
    `created_by` STRING COMMENT 'System or user that initially created the routing decision record.',
    CONSTRAINT pk_txn_routing_decision PRIMARY KEY(`txn_routing_decision_id`)
) COMMENT 'Record of the real-time routing decision made by the Payment Gateway and Authorization Engine for each transaction, capturing which network rail, acquirer, and processing path was selected. Stores routing rule version applied, candidate networks evaluated, selected network, routing reason (least cost, preferred network, fallback, regulatory), routing latency in milliseconds, and whether least-cost routing (LCR) or Durbin Amendment routing rules were applied. Enables routing optimization analytics and regulatory compliance evidence.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`iso_message` (
    `iso_message_id` BIGINT COMMENT 'Unique surrogate key for each raw ISO message record.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: ISO message audit must reference the exact network endpoint that handled the message for compliance and troubleshooting.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant associated with the transaction.',
    `network_scheme_id` BIGINT COMMENT 'Code representing the card scheme or payment network.. Valid values are `VISA|MASTERCARD|AMEX|DISCOVER|OTHER`',
    `original_message_iso_message_id` BIGINT COMMENT 'Reference to the prior ISO message (e.g., original authorization for a reversal).',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal that originated the message.',
    `scheme_id` BIGINT COMMENT 'Code representing the card scheme or payment network.',
    `authorization_status` STRING COMMENT 'Result of the authorization decision for the message.. Valid values are `approved|declined|error|pending`',
    `bitmap` STRING COMMENT 'Hexadecimal representation of the presence map for data elements in the ISO message.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ISO message record was first loaded into the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the transaction currency.. Valid values are `^[A-Z]{3}$`',
    `direction` STRING COMMENT 'Indicates whether the message was inbound to the gateway or outbound to the network.. Valid values are `inbound|outbound`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate applied when the transaction involves multiple currencies.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee charged as part of the transaction (e.g., interchange fee).',
    `is_test_message` BOOLEAN COMMENT 'Flag indicating whether the message was generated in a test environment.',
    `message_payload` STRING COMMENT 'Full raw message content as received (hex or base64).',
    `message_timestamp` TIMESTAMP COMMENT 'Date and time when the ISO message was sent or received (event time).',
    `message_type_indicator` STRING COMMENT 'Four‑digit code that identifies the high‑level function of the message (e.g., 0200 for authorization request).. Valid values are `^d{4}$`',
    `pan_masked` STRING COMMENT 'Card Primary Account Number with middle digits masked to protect cardholder data.. Valid values are `^d{6}*{6,}d{4}$`',
    `processing_code` STRING COMMENT 'Six‑digit code that defines the transaction type and processing rules.. Valid values are `^d{6}$`',
    `protocol_version` STRING COMMENT 'Version of the ISO protocol used (e.g., ISO8583_1987, ISO20022).',
    `response_code` STRING COMMENT 'Two‑digit code indicating the outcome of the transaction (e.g., 00 = approved).. Valid values are `^d{2}$`',
    `retrieval_reference_number` STRING COMMENT 'Identifier used to retrieve the transaction in later processing stages.',
    `session_reference` STRING COMMENT 'Identifier linking multiple messages that belong to the same processing session.',
    `settlement_date` DATE COMMENT 'Date on which the transaction is scheduled to settle.',
    `source_system` STRING COMMENT 'Originating system that generated or received the ISO message.. Valid values are `gateway|acquirer|issuer|processor`',
    `system_trace_audit_number` BIGINT COMMENT 'Unique numeric identifier assigned by the originating system for traceability.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction in the transaction currency.',
    `transmission_datetime` TIMESTAMP COMMENT 'Date‑time when the message was transmitted, as captured in DE7.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ISO message record.',
    CONSTRAINT pk_iso_message PRIMARY KEY(`iso_message_id`)
) COMMENT 'Raw ISO 8583 and ISO 20022 financial message record capturing the full message payload exchanged between the gateway, acquirer, and card scheme networks. Stores message type indicator (MTI), processing code, bitmap fields, message direction (inbound/outbound), protocol version, message timestamp, session ID, and parsed key data elements (DE2 PAN masked, DE4 amount, DE7 transmission datetime, DE11 STAN, DE37 retrieval reference number, DE39 response code). SSOT for network message traceability and ISO compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` (
    `txn_fee_id` BIGINT COMMENT 'Unique identifier for the fee record associated with a payment transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the parent payment transaction to which this fee applies.',
    `risk_rule_id` BIGINT COMMENT 'Identifier of the pricing rule or algorithm that generated the fee.',
    `transaction_id` BIGINT COMMENT 'Identifier of the parent payment transaction to which this fee applies.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the fee in the fee currency.',
    `fee_amount_usd` DECIMAL(18,2) COMMENT 'Fee amount converted to US Dollars for standardized reporting.',
    `fee_approval_status` STRING COMMENT 'Approval state of the fee after compliance review.. Valid values are `approved|rejected|pending`',
    `fee_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee was approved or rejected.',
    `fee_audit_trail` STRING COMMENT 'JSON‑encoded audit log capturing changes to the fee record.',
    `fee_calculation_basis` STRING COMMENT 'Method used to calculate the fee.. Valid values are `percentage|flat|tiered|volume|transaction_amount`',
    `fee_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee record was created.',
    `fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code of the fee amount.. Valid values are `^[A-Z]{3}$`',
    `fee_description` STRING COMMENT 'Free‑text description providing additional context for the fee.',
    `fee_effective_date` DATE COMMENT 'Date when the fee becomes effective.',
    `fee_exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert the fee amount to the reporting currency.',
    `fee_expiration_date` DATE COMMENT 'Date when the fee ceases to be applicable (null if indefinite).',
    `fee_flat_amount` DECIMAL(18,2) COMMENT 'Fixed amount applied when the calculation basis is flat.',
    `fee_jurisdiction_code` STRING COMMENT 'Three‑letter ISO country code indicating the jurisdiction governing the fee.. Valid values are `^[A-Z]{3}$`',
    `fee_quantity` STRING COMMENT 'Number of units used in tiered or volume‑based fee calculations.',
    `fee_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied when the calculation basis is percentage.',
    `fee_regulatory_reporting_code` STRING COMMENT 'Code used for regulatory reporting of the fee (e.g., PCI, PSD2).',
    `fee_responsible_party` STRING COMMENT 'Entity responsible for paying the fee.. Valid values are `merchant|acquirer|issuer|processor|network|partner`',
    `fee_reversal_flag` BOOLEAN COMMENT 'Indicates whether this fee record represents a reversal.',
    `fee_rule_version` STRING COMMENT 'Version of the fee calculation rule applied.',
    `fee_sequence` STRING COMMENT 'Sequential order of the fee line within the transaction fee set.',
    `fee_settlement_date` DATE COMMENT 'Date on which the fee was settled.',
    `fee_settlement_status` STRING COMMENT 'Settlement state of the fee with respect to the financial ledger.. Valid values are `pending|settled|failed`',
    `fee_source_system` STRING COMMENT 'System of record that originated the fee (e.g., gateway, settlement platform).',
    `fee_status` STRING COMMENT 'Current processing status of the fee.. Valid values are `pending|applied|reversed|rejected|adjusted`',
    `fee_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to the fee, if taxable.',
    `fee_taxable_flag` BOOLEAN COMMENT 'True if the fee is subject to tax.',
    `fee_tier_description` STRING COMMENT 'Textual description of the tier applied for tiered fee calculations.',
    `fee_type` STRING COMMENT 'Category of the fee assessed on the transaction.. Valid values are `interchange|scheme|processing|gateway|cross_border|surcharge`',
    `fee_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fee record.',
    CONSTRAINT pk_txn_fee PRIMARY KEY(`txn_fee_id`)
) COMMENT 'Fee record associated with a payment transaction, capturing all fee types assessed at the transaction level — interchange fees (IRF), scheme fees, processing fees, gateway fees, and cross-border surcharges. Stores fee type, fee amount, fee currency, fee calculation basis (percentage, flat, tiered), applicable rate, and the party responsible for the fee (merchant, acquirer, issuer). Enables MDR decomposition, fee revenue recognition, and interchange cost reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` (
    `fx_conversion_id` BIGINT COMMENT 'Unique surrogate key for each foreign exchange conversion record.',
    `cardholder_account_id` BIGINT COMMENT 'Identifier of the cardholder/customer involved in the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder/customer involved in the transaction.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the original transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the original payment transaction that triggered the FX conversion.',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement instruction linked to this conversion.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: FX conversion reports must reference the source currency entity to calculate rates and regulatory disclosures.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original payment transaction that triggered the FX conversion.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the conversion record.. Valid values are `compliant|non_compliant|pending_review`',
    `conversion_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for performing the foreign exchange conversion, expressed in the target currency.',
    `conversion_fee_currency_code` STRING COMMENT 'Currency in which the conversion fee is denominated.. Valid values are `^[A-Z]{3}$`',
    `conversion_method` STRING COMMENT 'How the conversion rate was applied: automatically, manually, or overridden by an operator.. Valid values are `automatic|manual|override`',
    `conversion_note` STRING COMMENT 'Free‑form text field for any additional remarks about the conversion.',
    `conversion_reference` STRING COMMENT 'Business reference code assigned to the conversion event for external tracking.',
    `conversion_status` STRING COMMENT 'Current lifecycle state of the conversion record.. Valid values are `pending|applied|reversed|failed|settled`',
    `conversion_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the foreign exchange conversion was executed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the conversion record was first created in the system.',
    `dcc_opt_in_flag` BOOLEAN COMMENT 'True if the cardholder opted in to Dynamic Currency Conversion; otherwise False.',
    `exchange_rate_timestamp` TIMESTAMP COMMENT 'Timestamp when the FX rate was sourced, which may differ from conversion_timestamp.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied (target currency per one unit of source currency).',
    `is_cross_border` BOOLEAN COMMENT 'True if the underlying transaction is cross‑border; otherwise False.',
    `rate_source` STRING COMMENT 'Origin of the FX rate (payment scheme, internal FX engine, or external provider).. Valid values are `scheme|internal_fx_engine|third_party_provider`',
    `rate_type` STRING COMMENT 'Classification of the rate used for conversion (e.g., mid‑market, DCC, scheme‑provided, internal, third‑party).. Valid values are `mid_market|dcc|scheme|internal|third_party`',
    `rate_validity_end` DATE COMMENT 'Date after which the quoted FX rate is no longer valid (nullable).',
    `rate_validity_start` DATE COMMENT 'Date from which the quoted FX rate is considered valid.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this conversion must be included in regulatory reports (e.g., AML, SAR).',
    `source_amount` DECIMAL(18,2) COMMENT 'Transaction amount expressed in the source currency before conversion.',
    `target_amount` DECIMAL(18,2) COMMENT 'Transaction amount expressed in the target currency after conversion.',
    `target_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency after conversion.. Valid values are `^[A-Z]{3}$`',
    `transaction_type` STRING COMMENT 'Category of the original payment transaction that triggered the conversion.. Valid values are `card_present|card_not_present|digital_wallet|bank_transfer|p2p|b2b`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the conversion record.',
    CONSTRAINT pk_fx_conversion PRIMARY KEY(`fx_conversion_id`)
) COMMENT 'Foreign exchange conversion record for cross-border and multi-currency transactions, capturing the source currency, target currency, FX rate applied, rate type (mid-market, DCC, scheme rate), conversion amount, conversion timestamp, rate source (scheme, internal FX engine, third-party provider), and DCC opt-in/opt-out flag. SSOT for currency conversion events at the transaction level, supporting cross-border payment reporting and DCC revenue tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` (
    `txn_channel_id` BIGINT COMMENT 'Unique surrogate identifier for each payment acceptance channel.',
    `authentication_3ds` BOOLEAN COMMENT 'True if the channel supports 3‑D Secure (3DS) for online card‑not‑present transactions.',
    `authentication_biometric` BOOLEAN COMMENT 'True if the channel supports biometric methods such as fingerprint or facial recognition.',
    `authentication_pin` BOOLEAN COMMENT 'True if the channel requires a Personal Identification Number (PIN) for authentication.',
    `authentication_signature` BOOLEAN COMMENT 'True if the channel requires a handwritten signature for transaction approval.',
    `card_present` BOOLEAN COMMENT 'True if the channel supports card‑present transactions (physical card read).',
    `channel_category` STRING COMMENT 'Broad classification of the channel based on its delivery mode.. Valid values are `physical|digital|hybrid`',
    `channel_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the channel (e.g., POS, EC, NFC).',
    `channel_name` STRING COMMENT 'Human‑readable name of the payment acceptance channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel record was first created.',
    `entry_mode_chip` BOOLEAN COMMENT 'True if the channel can accept chip‑based card data.',
    `entry_mode_contactless` BOOLEAN COMMENT 'True if the channel supports contactless NFC transactions.',
    `entry_mode_manual` BOOLEAN COMMENT 'True if the channel allows manual entry of card details (e.g., key‑in).',
    `entry_mode_swipe` BOOLEAN COMMENT 'True if the channel can accept magnetic‑stripe swipe data.',
    `is_default` BOOLEAN COMMENT 'True if this channel is the default selection for new merchant onboarding.',
    `sca_required` BOOLEAN COMMENT 'True if Strong Customer Authentication is mandatory for this channel under PSD2.',
    `supported_transaction_types` STRING COMMENT 'Comma‑separated list of transaction types the channel supports (e.g., card_present, card_not_present, digital_wallet, qr, nfc, moto, atm, kiosk). [ENUM-REF-CANDIDATE: card_present|card_not_present|digital_wallet|qr|nfc|moto|atm|kiosk — promote to reference product]',
    `txn_channel_description` STRING COMMENT 'Detailed description of the payment acceptance channel, its typical use cases and any special handling.',
    `txn_channel_status` STRING COMMENT 'Current lifecycle status of the channel.. Valid values are `active|inactive|deprecated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the channel record.',
    CONSTRAINT pk_txn_channel PRIMARY KEY(`txn_channel_id`)
) COMMENT 'Reference master defining the payment acceptance channels supported by the platform — POS, mPOS, eCommerce, in-app, QR code, NFC contactless, HCE, MOTO (mail order/telephone order), ATM, and unattended kiosk. Each channel record stores channel code, channel name, card-present indicator, authentication requirements (PIN, signature, biometric, 3DS), supported entry modes, and applicable regulatory rules (SCA requirements under PSD2). Used to classify transactions by acceptance environment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_type` (
    `txn_type_id` BIGINT COMMENT 'Unique surrogate key for each transaction type record.',
    `compliance_standard` STRING COMMENT 'Enumerated list of regulatory or industry standards applicable to the transaction type.. Valid values are `PCI_DSS|PSD2|SOX|GDPR|FATF`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the transaction type record was first inserted.',
    `currency_code` STRING COMMENT 'Default currency in which amounts for this transaction type are expressed.. Valid values are `^[A-Z]{3}$`',
    `debit_credit_indicator` STRING COMMENT 'Specifies if the transaction is a debit (funds out) or credit (funds in).. Valid values are `debit|credit`',
    `effective_from` DATE COMMENT 'Calendar date from which the transaction type is valid for processing.',
    `effective_until` DATE COMMENT 'Calendar date after which the transaction type is no longer valid; null indicates indefinite validity.',
    `is_cross_border_allowed` BOOLEAN COMMENT 'True when the transaction type may be processed for payments involving different currency jurisdictions.',
    `is_fraud_sensitive` BOOLEAN COMMENT 'True when transactions of this type trigger enhanced fraud monitoring.',
    `is_recurring_allowed` BOOLEAN COMMENT 'True when the transaction type can be used for scheduled or subscription payments.',
    `iso_processing_code` STRING COMMENT 'Standardized processing code defined by ISO 8583 / ISO 20022 that identifies the transaction function.',
    `max_amount` DECIMAL(18,2) COMMENT 'Upper limit on the monetary value that can be processed under this transaction type.',
    `min_amount` DECIMAL(18,2) COMMENT 'Lower bound on the monetary value for this transaction type.',
    `network_rule_set` STRING COMMENT 'Identifier of the rule set that governs routing, fees, and interchange for the transaction type.',
    `processing_fee_fixed` DECIMAL(18,2) COMMENT 'Flat fee amount applied to each transaction of this type.',
    `processing_fee_percent` DECIMAL(18,2) COMMENT 'Variable component of the fee expressed as a percent of the transaction amount.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if transactions of this type must be reported to regulators (e.g., SAR, CTR).',
    `requires_3ds` BOOLEAN COMMENT 'True when 3‑D Secure authentication is required for this transaction type.',
    `requires_aml_check` BOOLEAN COMMENT 'True when anti‑money‑laundering screening must be performed for this transaction type.',
    `requires_authentication` BOOLEAN COMMENT 'True if the transaction must pass an authentication step before authorization.',
    `requires_kyc` BOOLEAN COMMENT 'True when the transaction type mandates Know‑Your‑Customer checks.',
    `risk_score_category` STRING COMMENT 'Categorization used by risk models to apply appropriate scoring thresholds.. Valid values are `low|medium|high`',
    `settlement_eligibility_flag` BOOLEAN COMMENT 'True when transactions of this type can be settled to a financial institution.',
    `transaction_category` STRING COMMENT 'Broad category indicating the channel or medium of the transaction.. Valid values are `card_present|card_not_present|digital|bank_transfer|cash`',
    `txn_type_description` STRING COMMENT 'Detailed business description of the transaction type, including typical use‑cases.',
    `txn_type_status` STRING COMMENT 'Operational state indicating whether the type is in active use, retired, or awaiting approval.. Valid values are `active|inactive|deprecated|pending`',
    `type_code` STRING COMMENT 'Compact alphanumeric code representing the transaction type (e.g., PUR for Purchase).',
    `type_name` STRING COMMENT 'Descriptive name of the transaction type as used in UI and reports.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the transaction type record.',
    `version_number` STRING COMMENT 'Incremental version identifier used when the definition of the transaction type is updated.',
    CONSTRAINT pk_txn_type PRIMARY KEY(`txn_type_id`)
) COMMENT 'Reference classification of payment transaction types supported across the platform — purchase, cash advance, balance inquiry, refund, reversal, pre-authorization, incremental authorization, account verification, P2P transfer, A2A transfer, BNPL installment, ACH debit, ACH credit, RTGS, RTP. Each type record stores the ISO processing code, transaction type code, debit/credit indicator, settlement eligibility, and applicable network rules. Provides standardized classification for transaction reporting and routing logic.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` (
    `transaction_response_code_id` BIGINT COMMENT 'Unique surrogate identifier for each response code record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the response code record was first created in the system.',
    `decline_reason_classification` STRING COMMENT 'Specific reason why a transaction was declined, aligned with internal analytics taxonomy.. Valid values are `insufficient_funds|do_not_honor|invalid_card|expired_card|fraud_suspect|velocity_limit`',
    `effective_from` DATE COMMENT 'Date from which the response code is considered valid for processing.',
    `effective_until` DATE COMMENT 'Date after which the response code should no longer be used (null if indefinite).',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the response code has been deprecated and should be phased out.',
    `numeric` STRING COMMENT 'Integer version of the response code for systems that store numeric values.',
    `recommended_merchant_action` STRING COMMENT 'Suggested next step for the merchant (e.g., "Retry", "Contact Cardholder", "Check CVV").',
    `regulatory_reference` STRING COMMENT 'Reference to the governing standard or regulation that defines the response code (e.g., PCI DSS, Visa Core Rules).',
    `response_code` STRING COMMENT 'Alphanumeric code representing the outcome of an authorization request (e.g., "00", "05").',
    `response_source` STRING COMMENT 'Origin of the response code within the processing stack.. Valid values are `iso8583|iso20022|network|internal`',
    `risk_level` STRING COMMENT 'Risk rating assigned to the response code based on fraud propensity.. Valid values are `low|medium|high`',
    `scheme` STRING COMMENT 'Payment network or card scheme associated with the response code.. Valid values are `visa|mastercard|amex|discover|unionpay|other`',
    `transaction_response_code_category` STRING COMMENT 'High‑level grouping of the response outcome.. Valid values are `approved|declined|referral|error|timeout`',
    `transaction_response_code_description` STRING COMMENT 'Full textual description of what the response code means (e.g., "Approved", "Do Not Honor").',
    `transaction_response_code_status` STRING COMMENT 'Indicates whether the response code is currently in use.. Valid values are `active|inactive`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the response code record.',
    CONSTRAINT pk_transaction_response_code PRIMARY KEY(`transaction_response_code_id`)
) COMMENT 'Reference master of ISO 8583 and scheme-specific authorization response codes used across the platform. Each record stores the response code value, response code description, response category (approved, declined, referral, error, timeout), decline reason classification (insufficient funds, do not honor, invalid card, expired card, fraud suspect, velocity limit), and recommended merchant action. Enables standardized decline reason reporting and authorization rate analysis.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` (
    `tps_metric_id` BIGINT COMMENT 'Unique surrogate key for each TPS metric record.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction. Business justification: Metrics are captured per transaction; adding transaction_id links each TPS metric to its transaction.',
    `average_tps` DECIMAL(18,2) COMMENT 'Average transactions per second across the measurement window.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the TPS metric record was first inserted into the lakehouse.',
    `geographic_region` STRING COMMENT 'Three‑letter ISO country code representing the region where the measurement originated.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact time when the TPS measurement was recorded.',
    `measurement_unit` STRING COMMENT 'Unit of measurement for TPS values; always tps (transactions per second).',
    `measurement_window` STRING COMMENT 'Time interval over which the TPS metric is aggregated (e.g., 1 second, 5 seconds, 60 seconds).. Valid values are `1s|5s|60s`',
    `metric_status` STRING COMMENT 'Current status of the metric record indicating if the value is validated, estimated, or invalid.. Valid values are `valid|invalid|estimated`',
    `observed_tps` DECIMAL(18,2) COMMENT 'Number of transactions processed per second observed during the measurement window.',
    `payment_rail` STRING COMMENT 'Payment channel or rail on which the transaction flow was processed.. Valid values are `card_present|card_not_present|digital_wallet|bank_transfer|ach|swift`',
    `peak_tps` DECIMAL(18,2) COMMENT 'Maximum transactions per second recorded within the measurement window.',
    `processing_node_code` BIGINT COMMENT 'Identifier of the processing node or server that generated the measurement.',
    `sla_breach_flag` BOOLEAN COMMENT 'True if the observed TPS fell below the SLA target for the interval; otherwise False.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the TPS metric record.',
    CONSTRAINT pk_tps_metric PRIMARY KEY(`tps_metric_id`)
) COMMENT 'Operational throughput metric record capturing Transactions Per Second (TPS) measurements for the payment processing platform at defined intervals. Stores measurement timestamp, measurement window (1s, 5s, 60s), observed TPS, peak TPS, average TPS, processing node identifier, geographic region, payment rail, and SLA breach indicator. Enables capacity planning, SLA compliance monitoring, and peak load analysis for the Transaction Processing Platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`stp_record` (
    `stp_record_id` BIGINT COMMENT 'Unique surrogate key for each STP outcome record.',
    `account_holder_id` BIGINT COMMENT 'Identifier of the cardholder (consumer) involved in the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (consumer) involved in the transaction.',
    `device_id` BIGINT COMMENT 'Identifier of the device (e.g., token, POS terminal) that originated the transaction.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that originated the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the underlying payment transaction to which this STP record pertains.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the physical or virtual terminal used for the transaction.',
    `risk_rule_id` BIGINT COMMENT 'Identifier of the fraud/compliance rule that triggered manual intervention, if applicable.',
    `scheme_transaction_id` BIGINT COMMENT 'Acquirer Reference Number or other scheme‑assigned transaction identifier.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory compliance: STP exception handling requires tracking which compliance employee initiated the STP event.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier of the underlying payment transaction to which this STP record pertains.',
    `acquirer_reference_number` STRING COMMENT 'Unique reference assigned by the acquiring bank for reconciliation.',
    `compliance_flag` BOOLEAN COMMENT 'True if the transaction required compliance review (e.g., AML, sanctions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the STP record was first created in the lakehouse.',
    `error_code` STRING COMMENT 'System error code returned when STP failed.',
    `error_description` STRING COMMENT 'Human‑readable description of the error that caused STP failure.',
    `exception_flag` BOOLEAN COMMENT 'True if an exception (technical or business) prevented automatic processing.',
    `fraud_flag` BOOLEAN COMMENT 'True if the transaction was flagged for fraud during processing.',
    `intervention_description` STRING COMMENT 'Free‑text description of the manual intervention context.',
    `intervention_reason_code` STRING COMMENT 'Standardized code describing why manual intervention was required.',
    `intervention_timestamp` TIMESTAMP COMMENT 'Time when the manual intervention was initiated.',
    `intervention_type` STRING COMMENT 'Category of manual action required when STP was not achieved.. Valid values are `fraud_hold|compliance_review|reconciliation_break|technical_error|other`',
    `network` STRING COMMENT 'Payment scheme/network that processed the transaction.. Valid values are `visa|mastercard|discover|amex|unionpay|other`',
    `payment_channel` STRING COMMENT 'Delivery channel used for the transaction (e.g., web, mobile app, POS).. Valid values are `web|mobile|pos|mpos|api`',
    `payment_method` STRING COMMENT 'Instrument used to fund the transaction.. Valid values are `card|ach|wire|digital_wallet|other`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Time when the manual intervention was resolved.',
    `risk_score_at_stp` DECIMAL(18,2) COMMENT 'Fraud/risk score evaluated at the point of STP determination.',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled to the merchant.',
    `stp_comment` STRING COMMENT 'Free‑form notes added by operators regarding the STP outcome.',
    `stp_kpi_contribution_percentage` DECIMAL(18,2) COMMENT 'Proportion of the transaction amount that contributes to the overall STP KPI.',
    `stp_outcome_timestamp` TIMESTAMP COMMENT 'Exact time when the STP status was determined.',
    `stp_processing_latency_ms` BIGINT COMMENT 'Elapsed time in milliseconds from transaction receipt to STP determination.',
    `stp_rate_contribution_flag` BOOLEAN COMMENT 'Indicates whether this transaction counts toward the STP KPI rate.',
    `stp_resolution_status` STRING COMMENT 'Current status of the manual intervention resolution process.. Valid values are `resolved|pending|escalated`',
    `stp_source_system` STRING COMMENT 'Originating operational system that generated the STP record.. Valid values are `gateway|processing_platform|fraud_system|wallet_system|compliance_system`',
    `stp_status` STRING COMMENT 'Overall STP outcome for the transaction: achieved, required manual intervention, or exception.. Valid values are `achieved|manual_intervention|exception`',
    `stp_version` STRING COMMENT 'Version number for optimistic concurrency control.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Original transaction amount before any fees or adjustments.',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code of the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `transaction_fee_amount` DECIMAL(18,2) COMMENT 'Total fees (interchange, processing, etc.) applied to the transaction.',
    `transaction_net_amount` DECIMAL(18,2) COMMENT 'Net amount after fees, representing the amount settled to the merchant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the STP record.',
    CONSTRAINT pk_stp_record PRIMARY KEY(`stp_record_id`)
) COMMENT 'Straight-Through Processing (STP) outcome record for each transaction, capturing whether the transaction completed end-to-end without manual intervention. Stores STP status (STP achieved, manual intervention required, exception), intervention type if applicable (fraud hold, compliance review, reconciliation break, technical error), intervention timestamp, resolution timestamp, and STP rate contribution flag. Enables STP rate KPI tracking and operational efficiency reporting required by scheme SLAs.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` (
    `threeds_authentication_id` BIGINT COMMENT 'Unique identifier for the 3-D Secure authentication event.',
    `account_holder_id` BIGINT COMMENT 'Identifier of the cardholder involved in the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder involved in the transaction.',
    `device_id` BIGINT COMMENT 'Identifier of the device used for the authentication (e.g., token, device fingerprint).',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the underlying payment transaction.',
    `primary_threeds_ds_transaction_id` BIGINT COMMENT 'Identifier assigned by the Directory Server for the authentication transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier of the underlying payment transaction.',
    `acquirer_reference_number` STRING COMMENT 'Reference number assigned by the acquiring bank for reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction being authenticated.',
    `auth_code` STRING COMMENT 'Issuer‑provided authorization code for the transaction.',
    `authentication_flow` STRING COMMENT 'Indicates whether the authentication was frictionless or required a challenge.. Valid values are `frictionless|challenge`',
    `authentication_method` STRING COMMENT 'Method used to authenticate the cardholder during the 3-D Secure flow.. Valid values are `static_password|one_time_passcode|biometric|push_notification|unknown`',
    `authentication_result` STRING COMMENT 'Final result of the authentication process.. Valid values are `success|failure|error`',
    `cavv` STRING COMMENT 'Cryptographic authentication value generated by the ACS.',
    `challenge_indicator` STRING COMMENT 'Indicates whether a challenge was required, requested, or preferred during authentication.. Valid values are `no_challenge|challenge_requested|challenge_mandated|challenge_preferred`',
    `challenge_response` STRING COMMENT 'Raw data returned from the challenge step (e.g., one‑time password), stored for audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authentication record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the transaction amount.. Valid values are `[A-Z]{3}`',
    `eci` STRING COMMENT 'Indicator of the level of authentication risk for the transaction.. Valid values are `00|01|02|05|07`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time when the 3-D Secure authentication was performed.',
    `exemption_type` STRING COMMENT 'Type of SCA exemption applied, if any, for this authentication.. Valid values are `TRA|low_value|merchant_initiated|sca_exemption|none`',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the transaction was flagged for potential fraud at authentication time.',
    `ip_address` STRING COMMENT 'IP address from which the authentication request originated.',
    `is_test_transaction` BOOLEAN COMMENT 'True if the authentication pertains to a test or sandbox transaction.',
    `liability_shift` BOOLEAN COMMENT 'True when liability for fraud shifts to the issuer as a result of successful authentication.',
    `network` STRING COMMENT 'Card scheme or payment network used for the transaction.. Valid values are `Visa|Mastercard|Amex|Discover|JCB|UnionPay`',
    `risk_score` STRING COMMENT 'Risk score assigned by the fraud engine at the time of authentication.',
    `source_system` STRING COMMENT 'Name of the operational system that generated the authentication event (e.g., payment_gateway).',
    `threeds_authentication_status` STRING COMMENT 'Outcome status of the authentication attempt.. Valid values are `authenticated|attempted|failed|not_enrolled|decoupled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the authentication record.',
    `version` STRING COMMENT 'Version of the 3-D Secure protocol used for this authentication.. Valid values are `1.0|2.0|2.1|2.2`',
    CONSTRAINT pk_threeds_authentication PRIMARY KEY(`threeds_authentication_id`)
) COMMENT '3-D Secure authentication record for card-not-present transactions, capturing the full SCA challenge and authentication outcome. Stores 3DS version (1.0, 2.1, 2.2), authentication status (authenticated, attempted, failed, not enrolled, decoupled), ECI (Electronic Commerce Indicator), authentication value (CAVV/AAV), DS transaction ID, ACS transaction ID, challenge indicator, exemption type applied (TRA, low-value, merchant-initiated, SCA exemption), and liability shift indicator. SSOT for 3DS authentication events.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` (
    `tokenized_txn_id` BIGINT COMMENT 'Unique surrogate key for the tokenized transaction record.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant acquiring the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the underlying payment transaction as recorded in the core transaction system.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal used for the transaction.',
    `token_requestor_id` BIGINT COMMENT 'Identifier of the entity (e.g., merchant) that requested the token.',
    `transaction_id` BIGINT COMMENT 'Identifier of the underlying payment transaction as recorded in the core transaction system.',
    `acquirer_reference_number` STRING COMMENT 'Reference number assigned by the acquiring bank for reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'Original transaction amount before fees, discounts, or adjustments.',
    `auth_code` STRING COMMENT 'Code returned by the issuer approving the transaction.',
    `channel` STRING COMMENT 'Logical channel through which the payment was initiated.. Valid values are `card_present|card_not_present|mobile|web|api|batch`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tokenized transaction record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the transaction currency.',
    `device_binding_reference` STRING COMMENT 'Reference linking the token to the specific device used for tokenization.',
    `dpan` STRING COMMENT 'Device‑specific PAN used for the transaction, masked per PCI requirements.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate applied when converting transaction amount to settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged by the acquiring network and processor.',
    `fpan_masked` STRING COMMENT 'Masked version of the original PAN for audit and reporting.',
    `is_fraud_flag` BOOLEAN COMMENT 'Indicates whether the transaction was flagged as fraudulent.',
    `is_test_transaction` BOOLEAN COMMENT 'True if the transaction was generated in a test environment.',
    `is_tokenized` BOOLEAN COMMENT 'True indicates the transaction used a token rather than a clear PAN.',
    `mcc_code` STRING COMMENT 'Four‑digit code classifying the merchants business type.',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount after fees, taxes, and adjustments have been applied.',
    `network` STRING COMMENT 'Card scheme or network that processed the transaction.. Valid values are `Visa|Mastercard|Amex|Discover|UnionPay|Other`',
    `party_reference` BIGINT COMMENT 'Identifier of the cardholder or account holder involved in the transaction.',
    `payment_method` STRING COMMENT 'Instrument used to fund the transaction.. Valid values are `credit|debit|prepaid|digital_wallet|bank_transfer|cash`',
    `risk_score` STRING COMMENT 'Numeric risk assessment generated at authorization time.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final amount transferred to the merchant after fees and adjustments.',
    `settlement_currency` STRING COMMENT 'Currency in which the settlement amount is paid.',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled with the acquiring bank.',
    `token` STRING COMMENT 'Token representing the DPAN for the transaction, compliant with EMVCo tokenization.',
    `token_assurance_level` STRING COMMENT 'Assurance tier indicating the security strength of the token.. Valid values are `low|medium|high`',
    `token_cryptogram_validation_result` STRING COMMENT 'Result of cryptogram validation performed during token usage.. Valid values are `valid|invalid|not_checked`',
    `token_expiration_date` DATE COMMENT 'Date after which the token is no longer valid.',
    `token_service_provider_code` STRING COMMENT 'Identifier of the token service provider that issued the token.',
    `tokenization_timestamp` TIMESTAMP COMMENT 'Timestamp when the token was generated for the DPAN.',
    `tokenized_txn_status` STRING COMMENT 'Current processing state of the tokenized transaction.. Valid values are `authorized|captured|settled|reversed|failed|pending`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp of the real‑world payment event (authorization, capture, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tokenized transaction record.',
    CONSTRAINT pk_tokenized_txn PRIMARY KEY(`tokenized_txn_id`)
) COMMENT 'Record linking a payment transaction to its tokenization context when the transaction was initiated using a DPAN (Device Primary Account Number) or network token rather than the physical PAN. Stores the DPAN used, token requestor ID, token assurance level, FPAN reference (masked), TSP identifier, device binding reference, and token cryptogram validation result. Enables token-based transaction traceability and supports TSP reporting requirements under EMVCo tokenization standards.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` (
    `ach_entry_id` BIGINT COMMENT 'System-generated unique identifier for the ACH entry record.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch that contains this ACH entry.',
    `ach_entry_status` STRING COMMENT 'Current lifecycle status of the ACH entry.. Valid values are `pending|posted|returned|rejected|cancelled`',
    `addenda_record_count` STRING COMMENT 'Number of addenda records attached to this ACH entry.',
    `amount` DECIMAL(18,2) COMMENT 'Gross amount of the ACH entry in the transaction currency.',
    `channel` STRING COMMENT 'Channel through which the ACH entry was originated.. Valid values are `web|mobile|batch`',
    `compliance_flag_aml` BOOLEAN COMMENT 'Indicates whether the entry passed AML screening.',
    `compliance_flag_fraud` BOOLEAN COMMENT 'Indicates whether the entry passed fraud screening.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ACH entry record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the transaction amount.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `discretionary_data` STRING COMMENT 'Optional data field for originator‑specific information.',
    `effective_entry_date` DATE COMMENT 'Date on which the ACH entry is scheduled to be processed.',
    `entry_description` STRING COMMENT 'Free‑form description supplied by the originator for the ACH entry.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees assessed on the ACH entry.',
    `individual_account_number` STRING COMMENT 'Masked account number of the individual (PII, masked for security).',
    `individual_name` STRING COMMENT 'Full legal name of the account holder (PII).',
    `is_duplicate` BOOLEAN COMMENT 'Flag indicating whether this entry is a duplicate of another entry.',
    `is_returned` BOOLEAN COMMENT 'Indicates whether the ACH entry has been returned.',
    `is_test_transaction` BOOLEAN COMMENT 'Flag indicating whether the entry is a test (non‑production) transaction.',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount after fees are deducted (gross amount minus fee_amount).',
    `originating_company_code` BIGINT COMMENT 'Unique identifier of the originating merchant.',
    `originating_company_name` STRING COMMENT 'Legal name of the company that originated the ACH entry.',
    `originating_dfi_routing` STRING COMMENT 'Routing number of the financial institution that originated the ACH entry.',
    `payment_method` STRING COMMENT 'Payment method used for the entry; always ACH for this product.. Valid values are `ACH`',
    `processing_timestamp` TIMESTAMP COMMENT 'Timestamp when the ACH entry was processed by the system.',
    `receiving_company_code` BIGINT COMMENT 'Unique identifier of the receiving bank.',
    `receiving_company_name` STRING COMMENT 'Legal name of the receiving financial institution.',
    `receiving_dfi_routing` STRING COMMENT 'Routing number of the financial institution that receives the ACH entry.',
    `regulatory_report_indicator` BOOLEAN COMMENT 'Flag indicating whether this entry must be included in regulatory reports (e.g., SAR, CTR).',
    `return_reason_code` STRING COMMENT 'Standard code indicating why an ACH entry was returned, if applicable.',
    `return_reason_description` STRING COMMENT 'Human‑readable description of the return reason.',
    `return_timestamp` TIMESTAMP COMMENT 'Timestamp when the return was recorded.',
    `risk_score` STRING COMMENT 'Numeric risk score assigned by fraud detection models at entry creation.',
    `sec_code` STRING COMMENT 'SEC code indicating the type of ACH entry (e.g., PPD, CCD).. Valid values are `PPD|CCD|WEB|TEL|CIE`',
    `settlement_date` DATE COMMENT 'Date on which the ACH entry settles to the receiving account.',
    `trace_number` STRING COMMENT 'Unique NACHA-assigned trace number for the ACH transaction.',
    `transaction_type` STRING COMMENT 'Indicates whether the ACH entry is a credit or debit.. Valid values are `credit|debit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ACH entry record.',
    CONSTRAINT pk_ach_entry PRIMARY KEY(`ach_entry_id`)
) COMMENT 'ACH (Automated Clearing House) transaction entry record for account-to-account and direct payment transactions processed over the ACH network. Stores SEC code (PPD, CCD, WEB, TEL, CIE), NACHA trace number, originating DFI routing number, receiving DFI routing number, individual account number (masked), individual name, transaction amount, effective entry date, settlement date, return reason code if returned, and addenda record count. SSOT for ACH payment events distinct from card-based transactions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` (
    `rtp_payment_id` BIGINT COMMENT 'Primary key uniquely identifying the RTP payment record.',
    `device_id` BIGINT COMMENT 'Identifier of the device used to initiate the payment.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the payment, if any.',
    `payment_txn_id` BIGINT COMMENT 'Unique identifier assigned by the RTP network for this payment.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal (if applicable).',
    `cardholder_account_id` BIGINT COMMENT 'Tokenized identifier of the senders account used for the payment.',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement instruction linked to this payment.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch that includes this payment.',
    `transaction_id` BIGINT COMMENT 'Unique identifier assigned by the RTP network for this payment.',
    `aml_flag` BOOLEAN COMMENT 'Indicates whether the payment triggered AML screening alerts.',
    `amount` DECIMAL(18,2) COMMENT 'Gross amount of the payment in the transaction currency.',
    `channel` STRING COMMENT 'Channel through which the payment was initiated.. Valid values are `online|mobile|branch|atm|api`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RTP payment record was created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payment.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if currency conversion occurred.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged for processing the RTP payment.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the payment was flagged as potentially fraudulent.',
    `funds_availability_timestamp` TIMESTAMP COMMENT 'Timestamp when funds became available to the receiver.',
    `initiation_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was initiated by the sender.',
    `iso_message_reference` STRING COMMENT 'Reference to the ISO 20022 message (e.g., pacs.008) that carries this payment.',
    `mcc_code` STRING COMMENT 'Four‑digit code representing the merchants business category.. Valid values are `^[0-9]{4}$`',
    `network_identifier` STRING COMMENT 'Identifier of the RTP network (e.g., RTP, FedNow, UPI, Faster Payments).',
    `notes` STRING COMMENT 'Free‑text field for additional comments or remarks about the payment.',
    `payment_method` STRING COMMENT 'Instrument used to fund the payment.. Valid values are `account_transfer|card|wallet|token`',
    `payment_purpose_code` STRING COMMENT 'Code indicating the purpose of the payment as defined by ISO 20022.. Valid values are `salary|invoice|gift|tax|loan|other`',
    `regulatory_report_indicator` BOOLEAN COMMENT 'True if the payment must be reported to regulatory authorities (e.g., SAR, CTR).',
    `rejection_reason_code` STRING COMMENT 'Code indicating the reason for rejection when RTP status is rejected.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned by the fraud engine at initiation.',
    `rtp_status` STRING COMMENT 'Current processing status of the RTP payment.. Valid values are `accepted|rejected|returned|pending`',
    `settlement_date` DATE COMMENT 'Date on which the payment is scheduled to settle.',
    `stp_indicator` BOOLEAN COMMENT 'True if the payment was processed end‑to‑end without manual intervention.',
    `tps` STRING COMMENT 'Number of transactions processed per second at the time of this payment.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the payment transaction.. Valid values are `authorized|captured|settled|failed|reversed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this RTP payment record.',
    CONSTRAINT pk_rtp_payment PRIMARY KEY(`rtp_payment_id`)
) COMMENT 'Real-Time Payment (RTP) record for instant payment transactions processed over RTP rails (The Clearing House RTP, FedNow, UPI, Faster Payments). Stores RTP network identifier, end-to-end transaction ID, payment initiation timestamp, funds availability timestamp, sender account reference, receiver account reference, payment purpose code, ISO 20022 message reference (pacs.008), RTP status (accepted, rejected, returned), and rejection reason code. SSOT for real-time and instant payment events.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` (
    `swift_payment_id` BIGINT COMMENT 'Unique identifier for the SWIFT payment record.',
    `beneficiary_id` BIGINT COMMENT 'Identifier of the customer receiving the payment.',
    `instruction_id` BIGINT COMMENT 'Identifier for the settlement instruction generated for this payment.',
    `beneficiary_iban` STRING COMMENT 'IBAN of the beneficiary account receiving the funds.',
    `beneficiary_institution_bic` STRING COMMENT 'Bank Identifier Code of the beneficiary (receiving) financial institution.',
    `beneficiary_institution_country` STRING COMMENT 'Three-letter ISO country code of the beneficiary institution.',
    `beneficiary_institution_name` STRING COMMENT 'Legal name of the beneficiary financial institution.',
    `channel` STRING COMMENT 'Channel through which the payment instruction was submitted.. Valid values are `web|mobile|branch|api`',
    `charges_instruction` STRING COMMENT 'Indicates who bears the transaction charges: Ordering bank (OUR), shared (SHA), or beneficiary (BEN).. Valid values are `OUR|SHA|BEN`',
    `charges_instruction_details` STRING COMMENT 'Free-text details of charges instruction.',
    `compliance_screening_reference` STRING COMMENT 'Reference to AML/KYC screening result associated with the payment.',
    `correspondent_bank_chain` STRING COMMENT 'Semicolon-separated list of intermediate banks BICs used in the payment routing.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert payment amount to settlement currency if applicable.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees applied to the payment.',
    `gpi_tracker_status` STRING COMMENT 'Status of the payment in the SWIFT gpi tracking system.. Valid values are `sent|delivered|rejected|pending`',
    `is_cross_border` BOOLEAN COMMENT 'Flag indicating whether the payment is cross-border.',
    `is_fee_charged_to_beneficiary` BOOLEAN COMMENT 'Indicates if fees are charged to the beneficiary (true for BEN).',
    `is_test_payment` BOOLEAN COMMENT 'Indicates if the payment is a test/simulation.',
    `lifecycle_status` STRING COMMENT 'Current processing state of the SWIFT payment.. Valid values are `pending|sent|delivered|rejected|settled|failed`',
    `message_type` STRING COMMENT 'Type of SWIFT message (MT103, MT202, or ISO 20022 pacs.008).. Valid values are `MT103|MT202|pacs.008`',
    `ordering_institution_bic` STRING COMMENT 'Bank Identifier Code of the ordering (originating) financial institution.',
    `ordering_institution_country` STRING COMMENT 'Three-letter ISO country code of the ordering institution.',
    `ordering_institution_name` STRING COMMENT 'Legal name of the ordering financial institution.',
    `originating_customer_reference` STRING COMMENT 'Identifier of the customer who originated the payment.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Amount of the payment in the transaction currency.',
    `payment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code of the payment amount.',
    `payment_method` STRING COMMENT 'Method used for the payment (e.g., credit transfer, wire).. Valid values are `credit_transfer|wire|swift_gpi|other`',
    `payment_purpose` STRING COMMENT 'Narrative purpose of the payment as provided by the originator.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this record was first ingested into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `regulatory_report_indicator` BOOLEAN COMMENT 'Flag indicating if this payment must be reported to regulators.',
    `risk_score` STRING COMMENT 'Aggregated risk score from fraud detection systems.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Amount after conversion in settlement currency.',
    `settlement_currency` STRING COMMENT 'Currency in which the payment will be settled after conversion.',
    `transaction_reference` STRING COMMENT 'Reference provided by the originator for reconciliation.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment instruction was created in the originating system.',
    `uetr` STRING COMMENT 'Globally unique identifier for the payment transaction across the SWIFT network.',
    `value_date` DATE COMMENT 'Date on which the payment amount is to be settled.',
    CONSTRAINT pk_swift_payment PRIMARY KEY(`swift_payment_id`)
) COMMENT 'SWIFT cross-border payment record for international wire transfers processed through the SWIFT network. Stores SWIFT message type (MT103, MT202, pacs.008 ISO 20022), UETR (Unique End-to-End Transaction Reference), BIC of ordering institution, BIC of beneficiary institution, IBAN of beneficiary, correspondent bank chain, payment amount, payment currency, value date, charges instruction (OUR, SHA, BEN), gpi tracker status, and compliance screening reference. SSOT for SWIFT-routed cross-border payment events.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` (
    `txn_limit_rule_id` BIGINT COMMENT 'System-generated unique identifier for the transaction limit rule.',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Limit rules apply to specific transaction types; linking provides rule lookup based on type.',
    `channel` STRING COMMENT 'Channel or interface through which the transaction is initiated.. Valid values are `card_present|card_not_present|online|mobile|mpos|qr`',
    `contactless_limit` DECIMAL(18,2) COMMENT 'Maximum amount allowed for contactless (tap‑and‑go) transactions under this rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `cross_border_limit` DECIMAL(18,2) COMMENT 'Maximum amount permitted for cross‑border transactions governed by this rule.',
    `effective_from` DATE COMMENT 'Date on which the rule becomes active.',
    `effective_until` DATE COMMENT 'Date on which the rule expires or is de‑activated (null if indefinite).',
    `instrument_type` STRING COMMENT 'Type of payment instrument to which the rule applies.. Valid values are `card|bank_account|digital_wallet|token|crypto`',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this rule overrides other applicable rules when conditions overlap.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Numeric threshold value for the rule expressed in the limit currency.',
    `limit_category` STRING COMMENT 'Classification of the rule type indicating which limit dimension it governs.. Valid values are `single_amount|daily_cumulative|velocity|contactless|cross_border|tap`',
    `limit_currency` STRING COMMENT 'ISO 4217 three‑letter currency code for the limit amount.. Valid values are `^[A-Z]{3}$`',
    `max_amount_per_day` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for the total value of transactions in a single day.',
    `max_amount_per_transaction` DECIMAL(18,2) COMMENT 'Upper bound on the monetary value of an individual transaction.',
    `max_transactions_per_day` STRING COMMENT 'Velocity limit specifying the maximum number of transactions allowed in a calendar day.',
    `max_transactions_per_hour` STRING COMMENT 'Velocity limit specifying the maximum number of transactions allowed in any rolling hour.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts between multiple applicable rules (lower number = higher priority).',
    `regulatory_basis` STRING COMMENT 'Reference to the regulatory requirement (e.g., PSD2, PCI DSS) that drives the rule.',
    `risk_basis` STRING COMMENT 'Explanation of the risk model or fraud scenario that justifies the rule.',
    `rule_code` STRING COMMENT 'Business identifier or code assigned to the rule for lookup and configuration management.',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule used for display and reporting.',
    `tap_limit` DECIMAL(18,2) COMMENT 'Maximum amount for NFC tap transactions (often lower than standard contactless limit).',
    `txn_limit_rule_description` STRING COMMENT 'Free‑form description of the business purpose and logic of the rule.',
    `txn_limit_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|pending|retired`',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last modified the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule record.',
    `version` STRING COMMENT 'Version number of the rule definition for change management.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the rule.',
    CONSTRAINT pk_txn_limit_rule PRIMARY KEY(`txn_limit_rule_id`)
) COMMENT 'Business rule configuration defining transaction-level limits enforced during authorization — single transaction amount limits, daily cumulative limits, velocity limits (count per hour/day), card-present vs card-not-present limits, cross-border transaction limits, and contactless tap limits. Each rule stores the limit type, limit value, limit currency, applicable instrument type, applicable channel, effective date range, and the regulatory or risk basis for the limit (e.g., PSD2 contactless limit, scheme velocity rule). Owned by the transaction domain as these rules are enforced at authorization time.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` (
    `pos_entry_mode_id` BIGINT COMMENT 'Unique surrogate key for each POS entry mode record. _canonical_skip_reason: Inferred role REFERENCE_LOOKUP, no minimum categories required.',
    `authentication_method` STRING COMMENT 'Method used to authenticate the payment credential.. Valid values are `offline|online|3ds|sca|none`',
    `card_present_indicator` BOOLEAN COMMENT 'True when the card was physically present during the transaction.',
    `chargeback_liability_rule` STRING COMMENT 'Rule that defines which party bears chargeback liability for this entry mode.. Valid values are `merchant|issuer|acquirer|shared`',
    `contactless_flag` BOOLEAN COMMENT 'True if the entry mode supports contactless (NFC) capture.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the entry mode record was first created in the system.',
    `credential_on_file_flag` BOOLEAN COMMENT 'True when the payment credential is stored for future recurring or tokenized transactions.',
    `effective_from` DATE COMMENT 'Date when the entry mode definition becomes effective for processing.',
    `effective_until` DATE COMMENT 'Date when the entry mode definition is retired or superseded (null if still active).',
    `entry_mode_name` STRING COMMENT 'Human‑readable name of the entry mode (e.g., "EMV Chip Contact", "Magnetic Stripe").',
    `entry_mode_type` STRING COMMENT 'Categorized type of entry mode used at the point of interaction.. Valid values are `chip_contact|chip_contactless|magstripe|manual_key|qr_code|hce`',
    `fallback_eligible` BOOLEAN COMMENT 'Indicates whether the entry mode can fall back to a lower‑security method if the primary method fails.',
    `interchange_qualification_code` STRING COMMENT 'Code used by acquiring networks to qualify interchange rates for this entry mode.',
    `iso_8583_de22_code` STRING COMMENT 'ISO 8583 field code that identifies the point-of-service entry mode used for the transaction.',
    `moto_flag` BOOLEAN COMMENT 'True if the entry mode represents a MOTO transaction (card not present, entered manually).',
    `pos_entry_mode_description` STRING COMMENT 'Free‑form description of the entry mode, including any special handling notes.',
    `pos_entry_mode_status` STRING COMMENT 'Current lifecycle status of the entry mode definition.',
    `qr_code_flag` BOOLEAN COMMENT 'True if the entry mode is QR code scan.',
    `risk_score_average` DECIMAL(18,2) COMMENT 'Historical average fraud risk score associated with transactions using this entry mode.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the entry mode record.',
    CONSTRAINT pk_pos_entry_mode PRIMARY KEY(`pos_entry_mode_id`)
) COMMENT 'Reference master of POS entry modes defining how payment credential data was captured at the point of interaction — EMV chip contact, EMV chip contactless (NFC), magnetic stripe, manual key entry, QR code scan, HCE, credential-on-file, and MOTO. Each entry mode record stores the ISO 8583 DE22 code, entry mode name, card-present indicator, authentication method, fallback eligibility, and chargeback liability rules applicable to that entry mode. Used to classify transactions for interchange qualification and fraud risk assessment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `a2a_product_id` BIGINT COMMENT 'Foreign key linking to product.a2a_product. Business justification: Account‑to‑account transfers are governed by a2a product settings; linking enables settlement and compliance checks.',
    `account_holder_id` BIGINT COMMENT 'Unique identifier of the cardholder (or payer) involved in the transaction.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Links transaction to its accounting period, required for period‑close, trial‑balance generation, and financial reporting.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch that includes this transaction.',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: BNPL purchases are tracked against a specific BNPL plan for installment schedules and regulatory reporting.',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: Card program analytics and spend‑control rules need the program identifier for every transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Enables cost allocation per transaction for internal reporting and budgeting, used in expense tracking and cost‑center performance reports.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Currency master linkage is essential for settlement, FX conversion, and regulatory currency reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank or payment processor.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Required for posting each transaction to the General Ledger revenue/expense account during journal entry creation, a core accounting process.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Associates each transaction with the owning legal entity for regulatory filing, consolidation, and entity‑level financial statements.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: Linking transaction MCC to reference.mcc enables merchant category analytics and compliance with industry reporting.',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Enables linking each transaction to the merchant’s settlement account used for funds transfer, essential for account‑level reconciliation and audit.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that originated the transaction.',
    `p2p_product_id` BIGINT COMMENT 'Foreign key linking to product.p2p_product. Business justification: Peer‑to‑peer payments require linking each transaction to the P2P product definition for fee and risk rules.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Required for product‑level reporting, fee calculation and compliance; each transaction must be tied to the specific payment product used.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS or ATM terminal used for the transaction.',
    `transaction_response_code_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction_response_code. Business justification: Response code strings are normalized to transaction_response_code reference for consistency and reporting.',
    `txn_channel_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_channel. Business justification: Transaction records store channel as a string; linking to txn_channel provides a controlled list and eliminates redundancy.',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Transaction type is currently a free‑text field; linking to txn_type enables standardized processing and rule enforcement.',
    `virtual_account_product_id` BIGINT COMMENT 'Foreign key linking to product.virtual_account_product. Business justification: Virtual account usage must be recorded per transaction for balance control and regulatory audit.',
    `wallet_device_id` BIGINT COMMENT 'Identifier of the end‑user device that originated the transaction.',
    `original_transaction_id` BIGINT COMMENT 'Self-referencing FK on transaction (original_transaction_id)',
    `aml_flag` BOOLEAN COMMENT 'True if the transaction passed AML screening.',
    `amount_fee` DECIMAL(18,2) COMMENT 'Sum of all fees (interchange, network, service) applied to the transaction.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount authorized before fees, taxes, or discounts.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount settled to the merchant after fees.',
    `auth_code` STRING COMMENT 'Code returned by the issuer approving the transaction.',
    `auth_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization request was processed.',
    `capture_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorized amount was captured.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the transaction met all internal compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the data lake.',
    `cross_border_flag` BOOLEAN COMMENT 'True if the transaction involved parties in different countries.',
    `decline_reason` STRING COMMENT 'Human‑readable description of why the transaction was declined.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate applied when transaction involves multiple currencies.',
    `fraud_flag` BOOLEAN COMMENT 'True if the transaction was flagged as fraudulent.',
    `is_card_present` BOOLEAN COMMENT 'True if the card was physically present at the point of sale.',
    `is_contactless` BOOLEAN COMMENT 'True if the transaction used a contactless interface (NFC, tap).',
    `issuing_institution_code` BIGINT COMMENT 'Identifier of the issuing bank or card scheme.',
    `pan_last4` STRING COMMENT 'Last four digits of the Primary Account Number (masked for PCI compliance).',
    `payment_channel` STRING COMMENT 'Technical delivery channel for the payment request.. Valid values are `online|in_store|mobile_app|atm|pos|api`',
    `payment_method` STRING COMMENT 'Instrument used to fund the transaction.. Valid values are `credit_card|debit_card|bank_transfer|digital_wallet|cash|crypto`',
    `reference` STRING COMMENT 'External reference number (e.g., ARN, ISO 8583 Retrieval Reference Number) used to locate the transaction in downstream systems.',
    `regulatory_report_indicator` BOOLEAN COMMENT 'True if the transaction must be reported to regulators (e.g., SAR, AML).',
    `reversal_timestamp` TIMESTAMP COMMENT 'Timestamp when a reversal (void) was executed.',
    `risk_score` STRING COMMENT 'Numeric risk assessment from the fraud detection platform.',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled with the acquiring bank.',
    `settlement_status` STRING COMMENT 'Current status of the settlement process.. Valid values are `settled|pending|failed|reversed|partial|unknown`',
    `stp_indicator` BOOLEAN COMMENT 'True if the transaction was processed without manual intervention.',
    `token_used` BOOLEAN COMMENT 'True if a token (DPAN) was used instead of the PAN.',
    `tps` STRING COMMENT 'Observed TPS rate at the time of processing.',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the transaction.. Valid values are `authorized|captured|settled|reversed|failed|pending`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction event occurred (e.g., authorization request time).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Master reference table for transaction. ';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ADD CONSTRAINT `fk_transaction_instrument_issuance_original_issuance_instrument_issuance_id` FOREIGN KEY (`original_issuance_instrument_issuance_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`instrument_issuance`(`instrument_issuance_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ADD CONSTRAINT `fk_transaction_instrument_issuance_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_pos_entry_mode_id` FOREIGN KEY (`pos_entry_mode_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`pos_entry_mode`(`pos_entry_mode_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_original_auth_authorization_id` FOREIGN KEY (`original_auth_authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ADD CONSTRAINT `fk_transaction_batch_item_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ADD CONSTRAINT `fk_transaction_batch_item_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ADD CONSTRAINT `fk_transaction_batch_item_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ADD CONSTRAINT `fk_transaction_transaction_reconciliation_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ADD CONSTRAINT `fk_transaction_reconciliation_exception_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ADD CONSTRAINT `fk_transaction_reconciliation_exception_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ADD CONSTRAINT `fk_transaction_iso_message_original_message_iso_message_id` FOREIGN KEY (`original_message_iso_message_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`iso_message`(`iso_message_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ADD CONSTRAINT `fk_transaction_tps_metric_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_scheme_transaction_id` FOREIGN KEY (`scheme_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ADD CONSTRAINT `fk_transaction_threeds_authentication_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ADD CONSTRAINT `fk_transaction_threeds_authentication_primary_threeds_ds_transaction_id` FOREIGN KEY (`primary_threeds_ds_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ADD CONSTRAINT `fk_transaction_threeds_authentication_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ADD CONSTRAINT `fk_transaction_tokenized_txn_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ADD CONSTRAINT `fk_transaction_tokenized_txn_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ADD CONSTRAINT `fk_transaction_ach_entry_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ADD CONSTRAINT `fk_transaction_txn_limit_rule_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_transaction_response_code_id` FOREIGN KEY (`transaction_response_code_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_response_code`(`transaction_response_code_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_txn_channel_id` FOREIGN KEY (`txn_channel_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_channel`(`txn_channel_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_original_transaction_id` FOREIGN KEY (`original_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`transaction` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`transaction` SET TAGS ('dbx_domain' = 'transaction');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `instrument_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Issuance ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `original_issuance_instrument_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Original Issuance Identifier (for Reissues)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier for Processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `activation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Activation Deadline Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Issuance Channel (e.g., Branch, Online, Mobile, API, Partner)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'branch|online|mobile|api|partner');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Instrument Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method (e.g., Instant, Mail, Digital, Pickup)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'instant|mail|digital|pickup');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `instrument_issuance_status` SET TAGS ('dbx_business_glossary_term' = 'Issuance Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `instrument_issuance_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type (e.g., Card, Virtual Card, ACH Account, Token, Digital Wallet, Prepaid)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'card|virtual_card|ach_account|token|digital_wallet|prepaid');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `is_reissued` SET TAGS ('dbx_business_glossary_term' = 'Is Reissued Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Is Tokenized Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `issuance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Issuance Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `issuance_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Issuance Fee Currency (ISO 4217 Code)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `issuance_fee_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `issuance_number` SET TAGS ('dbx_business_glossary_term' = 'Issuance Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `issuance_status_detail` SET TAGS ('dbx_business_glossary_term' = 'Issuance Status Detail Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `issuance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issuance Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `issuing_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Fees');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `net_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Currency (ISO 4217 Code)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `net_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Comments');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `pan` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Number (PAN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `pan` SET TAGS ('dbx_value_regex' = '^[0-9]{16}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `pan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `pan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code (Instrument Product Code)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `token_service_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `token_value` SET TAGS ('dbx_business_glossary_term' = 'Token Value (PCI Token)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `token_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ALTER COLUMN `token_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `compliance_aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DPAN / Device Serial)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Api Credential Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `merchant_location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `pos_entry_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Pos Entry Mode Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification Number (TID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `sub_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Sub Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `acquirer_code` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `avs_result` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service Result');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Pass Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `cvv_result` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value Result');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `cvv_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `cvv_result` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `is_stp` SET TAGS ('dbx_business_glossary_term' = 'Straight‑Through Processing Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `iso_message_type` SET TAGS ('dbx_business_glossary_term' = 'ISO 8583 Message Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `iso_message_type` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `iso_message_version` SET TAGS ('dbx_business_glossary_term' = 'ISO 8583 Message Version');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `iso_message_version` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `mcc` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `mcc` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Net Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `network` SET TAGS ('dbx_business_glossary_term' = 'Payment Network');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `payment_txn_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `processing_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `tokenization_flag` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Gross Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number (ARN / Network Transaction ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `authorization_response_code_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Response Code Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `decline_code_id` SET TAGS ('dbx_business_glossary_term' = 'Decline Code Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `original_auth_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `amount_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `amount_requested` SET TAGS ('dbx_business_glossary_term' = 'Requested Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `auth_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `auth_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Authorization Retry Count');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `auth_source` SET TAGS ('dbx_business_glossary_term' = 'Authorization Source');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `auth_source` SET TAGS ('dbx_value_regex' = 'real_time|batch');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `auth_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `auth_status` SET TAGS ('dbx_value_regex' = 'approved|declined|referral|error');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `avs_result` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service Result');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|corporate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `cvv_result` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value Result');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `cvv_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `cvv_result` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `device_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Device IP Address');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `device_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `device_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `is_card_present` SET TAGS ('dbx_business_glossary_term' = 'Card Present Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `is_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `issuer_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Issuer Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = 'd{4}');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `merchant_country_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Country Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `merchant_country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `pan_last4` SET TAGS ('dbx_business_glossary_term' = 'PAN Last 4 Digits');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `pan_last4` SET TAGS ('dbx_value_regex' = 'd{4}');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|mobile|pos|mpos|api');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'card|token|bank_transfer|digital_wallet|cash');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `processing_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Total Processing Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_value_regex' = 'required|exempt|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Request Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Response Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `sca_status` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `sca_status` SET TAGS ('dbx_value_regex' = 'succeeded|failed|exempted|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `three_ds_result` SET TAGS ('dbx_business_glossary_term' = '3‑D Secure Authentication Result');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `token_used` SET TAGS ('dbx_business_glossary_term' = 'Token Usage Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification Number (TID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Capture Amount (Gross)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_method` SET TAGS ('dbx_business_glossary_term' = 'Capture Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_method` SET TAGS ('dbx_value_regex' = 'immediate|delayed|incremental|partial');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_number` SET TAGS ('dbx_business_glossary_term' = 'Capture Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_status` SET TAGS ('dbx_business_glossary_term' = 'Capture Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reversed|partial');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capture Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `interchange_fee` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `is_incremental` SET TAGS ('dbx_business_glossary_term' = 'Incremental Capture Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `is_partial_capture` SET TAGS ('dbx_business_glossary_term' = 'Partial Capture Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `is_settled` SET TAGS ('dbx_business_glossary_term' = 'Settled Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Capture Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `network` SET TAGS ('dbx_business_glossary_term' = 'Card Network');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `network` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|UnionPay|Other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `processing_fee` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `reversal_amount` SET TAGS ('dbx_business_glossary_term' = 'Reversal Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `risk_score_at_capture` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Capture');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Capture Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|reversal|auth_capture|preauth_capture');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `clearing_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (Cardholder ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (Cardholder ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier (Txn ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing File Batch Identifier (Batch ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier (Txn ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `acquiring_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Institution Identifier (Acquirer ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `aml_screened_flag` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Passed Flag (AML Flag)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `amount_fee` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Amount (Fee Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount (Gross Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount (Net Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code (Auth Code)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel (Channel)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|pos|mobile|atm');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Indicator Flag (Chargeback Flag)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date (Date of Settlement)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `clearing_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission Lifecycle Status (Status)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `clearing_submission_status` SET TAGS ('dbx_value_regex' = 'captured|submitted|settled|rejected|reversed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Description (Decline Reason)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate Applied (FX Rate)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount (Fee Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type (Fee Type)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'interchange|assessment|network|processor');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `iin_number` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identification Number (IIN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `iin_number` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `interchange_category` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Category (Interchange Category)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `interchange_category` SET TAGS ('dbx_value_regex' = 'qualified|unqualified|exempt|special');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `irf_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee Amount (IRF Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `irf_rate_category` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee Rate Category (IRF Category)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `irf_rate_category` SET TAGS ('dbx_value_regex' = 'standard|high|low|exempt');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `issuing_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Institution Identifier (Issuer ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `pci_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Indicator Flag (PCI Flag)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Response Code (Response Code)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `response_code` SET TAGS ('dbx_value_regex' = '^d{2}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator Flag (Reversal Flag)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `sanction_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Passed Flag (Sanctions Flag)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Code (Scheme)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `scheme_code` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount (Settlement Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Assigned Clearing Reference (SAR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission Timestamp (Submission TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Timestamp (Txn Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type (Card, ACH, etc.)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'card|ach|wire|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `txn_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Lifecycle Event ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `tokenization_request_id` SET TAGS ('dbx_business_glossary_term' = 'Tokenization ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'card_present|ecommerce|mobile|atm|pos');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'pci_dss|aml|sarl|none');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_value_regex' = 'gateway|processor|fraud_engine|wallet|settlement_system');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `iso_message_type_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Message Type Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_business_glossary_term' = 'New Transaction State');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|digital_wallet|cash');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `prior_state` SET TAGS ('dbx_business_glossary_term' = 'Prior Transaction State');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|reconciled');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `stp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Straight‑Through Processing Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `tps` SET TAGS ('dbx_business_glossary_term' = 'Transactions Per Second Metric');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `void_flag` SET TAGS ('dbx_business_glossary_term' = 'Void Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reversal_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Related Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Reversal Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Reversal Fee Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `initiating_party_role` SET TAGS ('dbx_business_glossary_term' = 'Initiating Party Role');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `initiating_party_role` SET TAGS ('dbx_value_regex' = 'merchant|acquirer|issuer|network|processor');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `is_successful` SET TAGS ('dbx_business_glossary_term' = 'Reversal Success Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `net_reversal_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Reversal Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `partial_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reference Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reversal_status` SET TAGS ('dbx_business_glossary_term' = 'Reversal Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reversal_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|rejected');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reversal_type` SET TAGS ('dbx_business_glossary_term' = 'Reversal Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reversal_type` SET TAGS ('dbx_value_regex' = 'void|partial|timeout|duplicate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `tokenization_request_id` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `tokenization_request_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `tokenization_request_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Email Address');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Full Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_pan_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Primary Account Number (PAN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_pan_masked` SET TAGS ('dbx_value_regex' = '^d{6}*{6}d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_pan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_pan_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Refund Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile|pos|mpos');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `compliance_flag_aml` SET TAGS ('dbx_business_glossary_term' = 'AML Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `compliance_flag_fraud` SET TAGS ('dbx_business_glossary_term' = 'Fraud Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Initiated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `is_chargeback_related` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Relation Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `is_partial_refund` SET TAGS ('dbx_business_glossary_term' = 'Partial Refund Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `original_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `original_authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `partial_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Partial Refund Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `processor_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'duplicate|customer_request|product_defect|fraud|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original|alternative|store_credit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `risk_decision` SET TAGS ('dbx_business_glossary_term' = 'Refund Risk Decision');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `risk_decision` SET TAGS ('dbx_value_regex' = 'approve|review|reject');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Refund Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `scheme_refund_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Refund Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Batch Identifier (TBI)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Approval Timestamp (BAT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type (BT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'settlement|reversal|adjustment');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Batch File Checksum (BFC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Close Timestamp (BCT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Batch Currency ISO Code (BCIC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Batch Error Count (BEC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to USD (ERUSD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Batch File Name (BFN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `is_stp` SET TAGS ('dbx_business_glossary_term' = 'Batch Straight‑Through Processing Flag (BSTP)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Open Timestamp (BOT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `processing_rate_tps` SET TAGS ('dbx_business_glossary_term' = 'Processing Rate Transactions Per Second (PRTPS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `processing_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Time Seconds (BPTS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Batch Reference (BR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Batch Rejection Reason (BRR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `scheme_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Batch Reference (SBR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Date (BSD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Reference (BSR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Status (BSETL_STS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'settled|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Batch Source System (BSS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|processing|merchant|fraud|dispute');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `stp_rate` SET TAGS ('dbx_business_glossary_term' = 'Straight‑Through Processing Rate (STPR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Submission Timestamp (BST)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Batch Amount (TBA)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Total Batch Amount in Local Currency (TBA_LOCAL)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Batch Amount in USD (TBA_USD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Batch Fee Amount (TBFA)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_fee_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Batch Fee Amount in USD (TBFA_USD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Batch Amount (TNBA)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_net_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Net Batch Amount in USD (TNBA_USD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `total_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count (TTC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `transaction_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status (BS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `transaction_batch_status` SET TAGS ('dbx_value_regex' = 'open|closed|submitted|accepted|rejected|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Batch Version Number (BVN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `warning_count` SET TAGS ('dbx_business_glossary_term' = 'Batch Warning Count (BWC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Batch Created By User Identifier (BCBU)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `batch_item_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Item Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `batch_item_description` SET TAGS ('dbx_business_glossary_term' = 'Batch Item Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `chargeback_indicator` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `chargeback_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `item_amount` SET TAGS ('dbx_business_glossary_term' = 'Item Amount (Monetary Value)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `item_currency` SET TAGS ('dbx_business_glossary_term' = 'Item Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `item_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Item Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'included|excluded|error|reversed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Item Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `item_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|chargeback|fee|adjustment');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `original_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `original_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `risk_decision` SET TAGS ('dbx_business_glossary_term' = 'Risk Decision');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `risk_decision` SET TAGS ('dbx_value_regex' = 'approve|review|decline');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `transaction_category` SET TAGS ('dbx_value_regex' = 'retail|ecommerce|mpos|qr|online|atm');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `transaction_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reconciliation ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Batch Identifier (BATCH_ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `acquiring_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier (ACQ_BANK_ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Transaction Flag (CROSS_BORDER_FLG)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `currency_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Rate (FX_RATE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag (EXCEPTION_FLG)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `issuing_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier (ISS_BANK_ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `matched_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Matched Transaction Count (MATCHED_TXN_CNT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `net_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Total Amount (NET_TOTAL_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes (REC_NOTES)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `processing_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Time in Seconds (PROC_TIME_SEC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number (REC_NO)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status (REC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'balanced|exception|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Event Timestamp (REC_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type (REC_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'intraday|end_of_day|t_plus_1');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Indicator (REG_REPORT_IND)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `risk_score_average` SET TAGS ('dbx_business_glossary_term' = 'Average Risk Score (AVG_RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code (SETTLEMENT_CURR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date (SETTLEMENT_DT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `source_file_internal` SET TAGS ('dbx_business_glossary_term' = 'Internal Source File Reference (INT_SRC_FILE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `source_file_scheme` SET TAGS ('dbx_business_glossary_term' = 'Scheme Source File Reference (SCHEME_SRC_FILE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `total_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Amount (TOTAL_FEE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `total_matched_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Matched Amount (TOTAL_MATCHED_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount (TOTAL_TAX_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `total_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Amount (TOTAL_TXN_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount (TOTAL_VARIANCE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code (TXN_CURR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Count (TXN_VOLUME)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `unmatched_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Transaction Count (UNMATCHED_TXN_CNT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code (VAR_REASON_CD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'amount_mismatch|missing_transaction|duplicate|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `reconciliation_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Exception ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `assigned_resolver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Resolver ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Resolver ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Related Batch ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `amount_difference` SET TAGS ('dbx_business_glossary_term' = 'Amount Difference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `currency_exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_amount` SET TAGS ('dbx_business_glossary_term' = 'Exception Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_currency` SET TAGS ('dbx_business_glossary_term' = 'Exception Currency');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Detection Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'missing_in_scheme|missing_in_internal|amount_mismatch|duplicate|status_mismatch');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|escalated|completed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `is_duplicate_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `txn_routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Routing Decision ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `gateway_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `network_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID (TID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `candidate_networks` SET TAGS ('dbx_business_glossary_term' = 'Candidate Networks');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `card_present` SET TAGS ('dbx_business_glossary_term' = 'Card‑Present Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile|atm|pos');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `cross_border_fee` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Fee');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `decision_reference` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `durbin_compliance_applied` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Compliance Applied');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `issuer_code` SET TAGS ('dbx_business_glossary_term' = 'Issuer ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `lcr_applied` SET TAGS ('dbx_business_glossary_term' = 'Least‑Cost Routing Applied');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Notes');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `routing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Routing Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `routing_path` SET TAGS ('dbx_business_glossary_term' = 'Routing Path');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `routing_reason` SET TAGS ('dbx_business_glossary_term' = 'Routing Reason');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `routing_reason` SET TAGS ('dbx_value_regex' = 'least_cost|preferred|fallback|regulatory|capacity|risk');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `routing_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Version');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `selected_network` SET TAGS ('dbx_business_glossary_term' = 'Selected Network');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `selected_network` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|DISCOVER|AMEX|UNIONPAY|OTHER');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `txn_routing_decision_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `txn_routing_decision_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `iso_message_id` SET TAGS ('dbx_business_glossary_term' = 'ISO Message Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `network_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `network_scheme_id` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|AMEX|DISCOVER|OTHER');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `original_message_iso_message_id` SET TAGS ('dbx_business_glossary_term' = 'Original Message Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification Number (TID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'approved|declined|error|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `bitmap` SET TAGS ('dbx_business_glossary_term' = 'Bitmap');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Message Direction');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `is_test_message` SET TAGS ('dbx_business_glossary_term' = 'Test Message Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `message_payload` SET TAGS ('dbx_business_glossary_term' = 'Raw Message Payload');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `message_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `message_type_indicator` SET TAGS ('dbx_business_glossary_term' = 'Message Type Indicator (MTI)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `message_type_indicator` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `pan_masked` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Number (Masked)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `pan_masked` SET TAGS ('dbx_value_regex' = '^d{6}*{6,}d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `pan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `pan_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `processing_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `processing_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code (DE39)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `response_code` SET TAGS ('dbx_value_regex' = '^d{2}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `retrieval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Reference Number (RRN, DE37)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `session_reference` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|acquirer|issuer|processor');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `system_trace_audit_number` SET TAGS ('dbx_business_glossary_term' = 'System Trace Audit Number (STAN, DE11)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `transmission_datetime` SET TAGS ('dbx_business_glossary_term' = 'Transmission Date‑Time (DE7)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `txn_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Approval Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fee Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Fee Audit Trail');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Basis');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_calculation_basis` SET TAGS ('dbx_value_regex' = 'percentage|flat|tiered|volume|transaction_amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fee Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Effective Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Flat Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fee Quantity');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate (Percentage)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Regulatory Reporting Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Fee Responsible Party');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_responsible_party` SET TAGS ('dbx_value_regex' = 'merchant|acquirer|issuer|processor|network|partner');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Reversal Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Fee Rule Version');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_sequence` SET TAGS ('dbx_business_glossary_term' = 'Fee Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_source_system` SET TAGS ('dbx_business_glossary_term' = 'Fee Source System');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_value_regex' = 'pending|applied|reversed|rejected|adjusted');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Taxable Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_tier_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Tier Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'interchange|scheme|processing|gateway|cross_border|surcharge');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `fee_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fee Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `fx_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'FX Conversion Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Source Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_method` SET TAGS ('dbx_business_glossary_term' = 'Conversion Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|override');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_note` SET TAGS ('dbx_business_glossary_term' = 'Conversion Note');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_reference` SET TAGS ('dbx_business_glossary_term' = 'Conversion Reference Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'pending|applied|reversed|failed|settled');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `dcc_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'DCC Opt‑In Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `exchange_rate_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'scheme|internal_fx_engine|third_party_provider');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'mid_market|dcc|scheme|internal|third_party');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_validity_end` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity End Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_validity_start` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity Start Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `source_amount` SET TAGS ('dbx_business_glossary_term' = 'Source Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `target_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `target_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Target Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `target_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|digital_wallet|bank_transfer|p2p|b2b');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` SET TAGS ('dbx_subdomain' = 'channel_configuration');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `txn_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `authentication_3ds` SET TAGS ('dbx_business_glossary_term' = '3‑D Secure Authentication Supported');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `authentication_biometric` SET TAGS ('dbx_business_glossary_term' = 'Biometric Authentication Supported');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `authentication_biometric` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `authentication_biometric` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `authentication_pin` SET TAGS ('dbx_business_glossary_term' = 'PIN Authentication Required');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `authentication_signature` SET TAGS ('dbx_business_glossary_term' = 'Signature Authentication Required');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `card_present` SET TAGS ('dbx_business_glossary_term' = 'Card‑Present Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Channel Category');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'physical|digital|hybrid');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Channel Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `entry_mode_chip` SET TAGS ('dbx_business_glossary_term' = 'Chip (EMV) Entry Mode Supported');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `entry_mode_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless (NFC) Entry Mode Supported');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `entry_mode_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Mode Supported');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `entry_mode_swipe` SET TAGS ('dbx_business_glossary_term' = 'Magnetic‑Stripe Swipe Entry Mode Supported');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Channel Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `sca_required` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Required');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `supported_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `txn_channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `txn_channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `txn_channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Channel Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` SET TAGS ('dbx_subdomain' = 'channel_configuration');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'PCI_DSS|PSD2|SOX|GDPR|FATF');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `is_cross_border_allowed` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `is_fraud_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Fraud Sensitivity Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `is_recurring_allowed` SET TAGS ('dbx_business_glossary_term' = 'Recurring Payment Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `iso_processing_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Processing Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `max_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `min_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `network_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Network Rule Set');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `processing_fee_fixed` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Fixed Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `processing_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `requires_3ds` SET TAGS ('dbx_business_glossary_term' = '3‑D Secure Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `requires_aml_check` SET TAGS ('dbx_business_glossary_term' = 'AML Check Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `requires_authentication` SET TAGS ('dbx_business_glossary_term' = 'Authentication Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `requires_kyc` SET TAGS ('dbx_business_glossary_term' = 'KYC Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Category');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `settlement_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `transaction_category` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|digital|bank_transfer|cash');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `txn_type_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `txn_type_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `txn_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` SET TAGS ('dbx_subdomain' = 'channel_configuration');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `transaction_response_code_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Response Code Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `decline_reason_classification` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Classification (DRC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `decline_reason_classification` SET TAGS ('dbx_value_regex' = 'insufficient_funds|do_not_honor|invalid_card|expired_card|fraud_suspect|velocity_limit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated Flag (IDF)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `numeric` SET TAGS ('dbx_business_glossary_term' = 'Response Code Numeric (RCN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `recommended_merchant_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Merchant Action (RMA)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (RR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code (RC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `response_source` SET TAGS ('dbx_business_glossary_term' = 'Response Source (RSRC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `response_source` SET TAGS ('dbx_value_regex' = 'iso8583|iso20022|network|internal');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Payment Scheme (PS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `scheme` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `transaction_response_code_category` SET TAGS ('dbx_business_glossary_term' = 'Response Category (RCAT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `transaction_response_code_category` SET TAGS ('dbx_value_regex' = 'approved|declined|referral|error|timeout');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `transaction_response_code_description` SET TAGS ('dbx_business_glossary_term' = 'Response Code Description (RCD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `transaction_response_code_status` SET TAGS ('dbx_business_glossary_term' = 'Response Code Status (RCS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `transaction_response_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_response_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `tps_metric_id` SET TAGS ('dbx_business_glossary_term' = 'TPS Metric Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `average_tps` SET TAGS ('dbx_business_glossary_term' = 'Average Transactions Per Second');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp (TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `measurement_window` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `measurement_window` SET TAGS ('dbx_value_regex' = '1s|5s|60s');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `metric_status` SET TAGS ('dbx_business_glossary_term' = 'Metric Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `metric_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|estimated');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `observed_tps` SET TAGS ('dbx_business_glossary_term' = 'Observed Transactions Per Second');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `payment_rail` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail (PR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `payment_rail` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|digital_wallet|bank_transfer|ach|swift');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `peak_tps` SET TAGS ('dbx_business_glossary_term' = 'Peak Transactions Per Second');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `processing_node_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Node Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tps_metric` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Straight-Through Processing Record ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'STP Rule ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `scheme_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Transaction Identifier (ARN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Stp Initiated By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `intervention_description` SET TAGS ('dbx_business_glossary_term' = 'Intervention Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `intervention_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Intervention Reason Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `intervention_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Intervention Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Manual Intervention Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `intervention_type` SET TAGS ('dbx_value_regex' = 'fraud_hold|compliance_review|reconciliation_break|technical_error|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `network` SET TAGS ('dbx_business_glossary_term' = 'Card Network');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `network` SET TAGS ('dbx_value_regex' = 'visa|mastercard|discover|amex|unionpay|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|mpos|api');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'card|ach|wire|digital_wallet|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Intervention Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `risk_score_at_stp` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at STP Decision');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_comment` SET TAGS ('dbx_business_glossary_term' = 'STP Comment');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_kpi_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'STP KPI Contribution Percentage');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_outcome_timestamp` SET TAGS ('dbx_business_glossary_term' = 'STP Outcome Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'STP Processing Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_rate_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'STP Rate Contribution Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'STP Resolution Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|pending|escalated');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_source_system` SET TAGS ('dbx_business_glossary_term' = 'STP Source System');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_source_system` SET TAGS ('dbx_value_regex' = 'gateway|processing_platform|fraud_system|wallet_system|compliance_system');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_status` SET TAGS ('dbx_business_glossary_term' = 'Straight-Through Processing Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_status` SET TAGS ('dbx_value_regex' = 'achieved|manual_intervention|exception');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `stp_version` SET TAGS ('dbx_business_glossary_term' = 'STP Record Version');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Gross Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `transaction_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Net Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `threeds_authentication_id` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Authentication ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `primary_threeds_ds_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Directory Server Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `authentication_flow` SET TAGS ('dbx_business_glossary_term' = 'Authentication Flow');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `authentication_flow` SET TAGS ('dbx_value_regex' = 'frictionless|challenge');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'static_password|one_time_passcode|biometric|push_notification|unknown');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `authentication_result` SET TAGS ('dbx_business_glossary_term' = 'Authentication Result');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `authentication_result` SET TAGS ('dbx_value_regex' = 'success|failure|error');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `cavv` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Authentication Verification Value (CAVV)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `challenge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Challenge Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `challenge_indicator` SET TAGS ('dbx_value_regex' = 'no_challenge|challenge_requested|challenge_mandated|challenge_preferred');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `challenge_response` SET TAGS ('dbx_business_glossary_term' = 'Challenge Response Data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `eci` SET TAGS ('dbx_business_glossary_term' = 'Electronic Commerce Indicator (ECI)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `eci` SET TAGS ('dbx_value_regex' = '00|01|02|05|07');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authentication Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Exemption Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'TRA|low_value|merchant_initiated|sca_exemption|none');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `liability_shift` SET TAGS ('dbx_business_glossary_term' = 'Liability Shift Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `network` SET TAGS ('dbx_business_glossary_term' = 'Payment Network');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `network` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|JCB|UnionPay');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Authentication Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `threeds_authentication_status` SET TAGS ('dbx_business_glossary_term' = 'Authentication Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `threeds_authentication_status` SET TAGS ('dbx_value_regex' = 'authenticated|attempted|failed|not_enrolled|decoupled');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Version');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '1.0|2.0|2.1|2.2');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `tokenized_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token_requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Token Requestor Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Gross Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|mobile|web|api|batch');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `device_binding_reference` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `dpan` SET TAGS ('dbx_business_glossary_term' = 'Device Primary Account Number (DPAN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `dpan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `dpan` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Primary Account Number (FPAN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `fpan_masked` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `is_fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Net Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `network` SET TAGS ('dbx_business_glossary_term' = 'Card Network');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `network` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|UnionPay|Other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `party_reference` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|digital_wallet|bank_transfer|cash');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Network Token');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token_assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Token Assurance Level');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token_assurance_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token_cryptogram_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Token Cryptogram Validation Result');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token_cryptogram_validation_result` SET TAGS ('dbx_value_regex' = 'valid|invalid|not_checked');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Token Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `token_service_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `tokenization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `tokenized_txn_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `tokenized_txn_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|reversed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `ach_entry_id` SET TAGS ('dbx_business_glossary_term' = 'ACH Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `ach_entry_status` SET TAGS ('dbx_business_glossary_term' = 'ACH Entry Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `ach_entry_status` SET TAGS ('dbx_value_regex' = 'pending|posted|returned|rejected|cancelled');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `addenda_record_count` SET TAGS ('dbx_business_glossary_term' = 'Addenda Record Count');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Originating Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|batch');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `compliance_flag_aml` SET TAGS ('dbx_business_glossary_term' = 'AML Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `compliance_flag_fraud` SET TAGS ('dbx_business_glossary_term' = 'Fraud Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `discretionary_data` SET TAGS ('dbx_business_glossary_term' = 'Discretionary Data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `effective_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Entry Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `entry_description` SET TAGS ('dbx_business_glossary_term' = 'Entry Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `individual_account_number` SET TAGS ('dbx_business_glossary_term' = 'Individual Account Number (Masked)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `individual_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `individual_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `individual_name` SET TAGS ('dbx_business_glossary_term' = 'Individual Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `individual_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `individual_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Is Returned Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `originating_company_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Company Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `originating_company_name` SET TAGS ('dbx_business_glossary_term' = 'Originating Company Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `originating_dfi_routing` SET TAGS ('dbx_business_glossary_term' = 'Originating DFI Routing Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `receiving_company_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `receiving_dfi_routing` SET TAGS ('dbx_business_glossary_term' = 'Receiving DFI Routing Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `sec_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Entry Class (SEC) Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `sec_code` SET TAGS ('dbx_value_regex' = 'PPD|CCD|WEB|TEL|CIE');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `trace_number` SET TAGS ('dbx_business_glossary_term' = 'NACHA Trace Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`ach_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `rtp_payment_id` SET TAGS ('dbx_business_glossary_term' = 'RTP Payment ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `device_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (Transaction ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (Transaction ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `aml_flag` SET TAGS ('dbx_business_glossary_term' = 'AML Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount (AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile|branch|atm|api');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `funds_availability_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Funds Availability Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Initiation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `iso_message_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO Message Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `network_identifier` SET TAGS ('dbx_business_glossary_term' = 'RTP Network Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'account_transfer|card|wallet|token');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `payment_purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `payment_purpose_code` SET TAGS ('dbx_value_regex' = 'salary|invoice|gift|tax|loan|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `rtp_status` SET TAGS ('dbx_business_glossary_term' = 'RTP Payment Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `rtp_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|returned|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `stp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Straight‑Through Processing Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `tps` SET TAGS ('dbx_business_glossary_term' = 'Transactions Per Second (TPS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `swift_payment_id` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Payment ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `swift_payment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `swift_payment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Customer ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_iban` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_institution_bic` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Institution BIC');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_institution_country` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Institution Country');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `beneficiary_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Institution Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|branch|api');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `charges_instruction` SET TAGS ('dbx_business_glossary_term' = 'Charges Instruction');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `charges_instruction` SET TAGS ('dbx_value_regex' = 'OUR|SHA|BEN');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `charges_instruction_details` SET TAGS ('dbx_business_glossary_term' = 'Charges Instruction Details');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `compliance_screening_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Screening Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `compliance_screening_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `compliance_screening_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `correspondent_bank_chain` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Chain');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `gpi_tracker_status` SET TAGS ('dbx_business_glossary_term' = 'GPI Tracker Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `gpi_tracker_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|rejected|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `is_fee_charged_to_beneficiary` SET TAGS ('dbx_business_glossary_term' = 'Fee Charged to Beneficiary Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `is_test_payment` SET TAGS ('dbx_business_glossary_term' = 'Test Payment Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'pending|sent|delivered|rejected|settled|failed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `message_type` SET TAGS ('dbx_value_regex' = 'MT103|MT202|pacs.008');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `ordering_institution_bic` SET TAGS ('dbx_business_glossary_term' = 'Ordering Institution BIC');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `ordering_institution_country` SET TAGS ('dbx_business_glossary_term' = 'Ordering Institution Country');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `ordering_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Ordering Institution Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `originating_customer_reference` SET TAGS ('dbx_business_glossary_term' = 'Originating Customer ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `originating_customer_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `originating_customer_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_transfer|wire|swift_gpi|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `payment_purpose` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `uetr` SET TAGS ('dbx_business_glossary_term' = 'Unique End-to-End Transaction Reference (UETR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `uetr` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `uetr` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `txn_limit_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Rule ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|online|mobile|mpos|qr');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `contactless_limit` SET TAGS ('dbx_business_glossary_term' = 'Contactless Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `cross_border_limit` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'card|bank_account|digital_wallet|token|crypto');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive Rule');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `limit_category` SET TAGS ('dbx_business_glossary_term' = 'Limit Category');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `limit_category` SET TAGS ('dbx_value_regex' = 'single_amount|daily_cumulative|velocity|contactless|cross_border|tap');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Limit Currency');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `max_amount_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Cumulative Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `max_amount_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Single Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `max_transactions_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transactions Per Day');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `max_transactions_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transactions Per Hour');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `risk_basis` SET TAGS ('dbx_business_glossary_term' = 'Risk Basis');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Rule Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Rule Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `tap_limit` SET TAGS ('dbx_business_glossary_term' = 'Tap Transaction Limit');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `txn_limit_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `txn_limit_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `txn_limit_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` SET TAGS ('dbx_subdomain' = 'channel_configuration');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `pos_entry_mode_id` SET TAGS ('dbx_business_glossary_term' = 'POS Entry Mode Identifier (POS_EM_ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method (AUTH_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'offline|online|3ds|sca|none');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `card_present_indicator` SET TAGS ('dbx_business_glossary_term' = 'Card Present Indicator (CPI)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `chargeback_liability_rule` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Liability Rule (CB_LIABILITY)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `chargeback_liability_rule` SET TAGS ('dbx_value_regex' = 'merchant|issuer|acquirer|shared');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `contactless_flag` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Flag (CONTACTLESS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `credential_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Credential on File Flag (COF_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `entry_mode_name` SET TAGS ('dbx_business_glossary_term' = 'Entry Mode Name (EM_NAME)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `entry_mode_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Mode Type (EM_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `entry_mode_type` SET TAGS ('dbx_value_regex' = 'chip_contact|chip_contactless|magstripe|manual_key|qr_code|hce');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `fallback_eligible` SET TAGS ('dbx_business_glossary_term' = 'Fallback Eligibility Flag (FALLBACK_ELIGIBLE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `interchange_qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Code (INTERCHANGE_Q_CODE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `iso_8583_de22_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 8583 Data Element 22 Code (DE22)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `moto_flag` SET TAGS ('dbx_business_glossary_term' = 'Mail Order / Telephone Order Flag (MOTO_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `pos_entry_mode_description` SET TAGS ('dbx_business_glossary_term' = 'Entry Mode Description (EM_DESC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `pos_entry_mode_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Mode Status (EM_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `pos_entry_mode_status` SET TAGS ('dbx_active' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `pos_entry_mode_status` SET TAGS ('dbx_inactive' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `pos_entry_mode_status` SET TAGS ('dbx_deprecated' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `qr_code_flag` SET TAGS ('dbx_business_glossary_term' = 'QR Code Entry Mode Flag (QR_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `risk_score_average` SET TAGS ('dbx_business_glossary_term' = 'Average Risk Score for Entry Mode (AVG_RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`pos_entry_mode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` SET TAGS ('dbx_subdomain' = 'channel_configuration');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `a2a_product_id` SET TAGS ('dbx_business_glossary_term' = 'A2A Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Institution ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `p2p_product_id` SET TAGS ('dbx_business_glossary_term' = 'P2P Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_response_code_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Response Code Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `txn_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Channel Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `virtual_account_product_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `original_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `aml_flag` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `amount_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `auth_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capture Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `is_card_present` SET TAGS ('dbx_business_glossary_term' = 'Card Present Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `is_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Transaction Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `issuing_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Institution ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `pan_last4` SET TAGS ('dbx_business_glossary_term' = 'PAN Last 4 Digits');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `pan_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `pan_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile_app|atm|pos|api');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|digital_wallet|cash|crypto');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'settled|pending|failed|reversed|partial|unknown');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `stp_indicator` SET TAGS ('dbx_business_glossary_term' = 'STP Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `token_used` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Usage Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `tps` SET TAGS ('dbx_business_glossary_term' = 'Transactions Per Second (TPS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|reversed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
