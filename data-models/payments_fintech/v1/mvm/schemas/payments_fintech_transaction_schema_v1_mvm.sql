-- Schema for Domain: transaction | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`transaction` COMMENT 'Core payment transaction processing owning the full lifecycle from authorization, capture, clearing, settlement instruction, and reconciliation. SSOT for all payment events processed through ISO 8583 and ISO 20022 message flows, real-time authorization decisions, batch processing records, TPS metrics, STP rates, and multi-currency transaction data across card-present, card-not-present, and digital payment channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` (
    `payment_txn_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each payment transaction record.',
    `account_holder_id` BIGINT COMMENT 'Internal surrogate key of the cardholder (or payer) involved in the transaction.',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: payment_txn.acquirer_code is a denormalized acquirer reference. Acquirer-level settlement reporting, interchange analysis, and regulatory reporting require a proper FK to settlement.acquirer. Replacin',
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Regulatory AML screening per transaction stores result in compliance_aml_screening_result; linking enables audit trails and SAR generation.',
    `bin_interchange_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.bin_interchange_rule. Business justification: BIN-based interchange rules determine applicable interchange rates and eligibility criteria per payment transaction. Linking payment_txn to bin_interchange_rule supports interchange qualification, com',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Payment transactions must be validated against and posted to a specific cardholder account for balance updates, credit limit enforcement, and account status checks. This is a fundamental issuer-side p',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Real-time SCA compliance validation and risk-based payment processing require direct access to cardholder_profile during payment_txn execution. PSD2 SCA checks and preferred scheme routing depend on t',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Enables treasury to aggregate exposure and risk metrics by currency pair for each payment transaction.',
    `device_id` BIGINT COMMENT 'Identifier of the device used to present the payment credential; may be a DPAN or device serial number.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal surrogate key of the acquiring financial institution that processed the transaction.',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Required for location‑level transaction reporting, risk scoring and settlement attribution; merchants need to know which physical location processed each payment.',
    `merchant_id` BIGINT COMMENT 'Internal surrogate key of the merchant that originated the transaction.',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: Payment transactions are executed against a specific PAN or token. Linking payment_txn to pan_record enables PAN-level transaction history, tokenization validation, and card scheme compliance reportin',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: Each payment transaction is processed under a specific interchange program (e.g., rewards, commercial, debit). Linking payment_txn to interchange program supports interchange cost attribution by progr',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Required for audit and regulatory reporting to identify the exact FX rate applied to each cross‑border payment transaction.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Audit & compliance require linking each payment transaction to the originating API request for traceability and dispute investigation.',
    `response_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_response. Business justification: Reconciliation and settlement reports need the exact gateway response that settled the payment transaction.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Regulatory interchange reporting requires each payment transaction to be linked to its card scheme for fee calculation and compliance.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: STP processing, cycle-level volume/P&L reporting, and cut-off management require each payment_txn to be directly associated with its settlement cycle. transaction_batch links to cycle but payment_txn ',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: End-to-end payment lifecycle reporting, PSD2/Reg E regulatory tracing, and dispute resolution require direct linkage from the atomic payment transaction to the settlement record that financially final',
    `sub_merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.sub_merchant. Business justification: Needed for PayFac models to attribute each payment to the originating sub‑merchant for settlement, revenue share, and compliance reporting.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction. Business justification: payment_txn is the operational SSOT for payment events; transaction is the master reference table. Adding transaction_id FK links the operational payment record to the master transaction entity, enabl',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: payment_txn has a denormalized transaction_type STRING column. txn_type is the authoritative reference classification table for transaction types. Normalizing via txn_type_id FK eliminates the free-te',
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
    `settlement_status` STRING COMMENT 'Current status of the settlement process (pending, settled, failed).',
    `tokenization_flag` BOOLEAN COMMENT 'True if the transaction used a tokenized payment credential instead of a clear PAN.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the transaction before fees or adjustments, expressed in transaction currency.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the transaction was initiated or authorized in the payment network.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this transaction record (e.g., status change, settlement update).',
    CONSTRAINT pk_payment_txn PRIMARY KEY(`payment_txn_id`)
) COMMENT 'Core SSOT for every payment transaction processed through the platform — card-present, card-not-present, and digital payment channels. Captures the full ISO 8583 / ISO 20022 message lifecycle from authorization request through capture, including transaction amount, currency, MCC, channel type (POS, mPOS, eCommerce, QR, NFC, HCE), entry mode (EMV, swipe, contactless, manual), transaction timestamp, acquirer reference number (ARN), network transaction ID, processing code, response code, and STP flag. Single authoritative record per payment event.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`authorization` (
    `authorization_id` BIGINT COMMENT 'Unique identifier for the authorization record.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Acquirer-level authorization approval rate reporting, interchange optimization, and settlement currency determination require knowing which acquirer endpoint processed each authorization. Core operati',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: The acquirer is determined at authorization time and drives settlement routing and interchange. Acquirer-level authorization approval rate reporting and settlement reconciliation (required by Visa/MC ',
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Real-time authorization processing triggers AML screening as a hard compliance gate. Payments regulators (FATF, FinCEN) require traceability from each authorization event to its AML screening outcome.',
    `bin_interchange_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.bin_interchange_rule. Business justification: Authorization compliance checks (compliance_check_passed on authorization) include verifying BIN interchange rule eligibility criteria such as 3DS requirements, EMV requirements, and card-present indi',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Authorization must validate available credit, credit limit, account status, and delinquency against the specific cardholder account. This is a fundamental issuer authorization check — every card autho',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Issuer-side authorization decisioning requires the cardholders SCA compliance status, 3DS enrollment, and risk level from cardholder_profile. PSD2 SCA compliance checks and real-time fraud scoring du',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Cross-border authorization must reference the currency pair to enforce DCC eligibility, apply correct decimal precision, and validate the authorization amount in the cardholders home currency. A doma',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner SLA measurement (issuer_response_time_ms, network_latency_ms already on authorization) requires direct partner attribution per authorization. Partner SLA reporting and breach detection — track',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Authorizations are location-specific events (POS terminal, store). Location-level fraud monitoring, chargeback dispute resolution, and location performance reporting require direct authorization-to-lo',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the transaction.',
    `original_auth_authorization_id` BIGINT COMMENT 'Reference to the first authorization attempt when this record is a retry.',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: Authorization is executed against a specific PAN. Linking to pan_record enables PAN lifecycle validation, tokenization status checks, and card-level fraud history. pan_last4 is a denormalized snapshot',
    `partner_api_credential_id` BIGINT COMMENT 'Foreign key linking to partner.partner_api_credential. Business justification: PCI-DSS compliance requires audit trails of which partner API credential processed each authorization. Security incident response and credential rotation impact analysis depend on this link. gateway_a',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: authorization is the real-time decision record produced for a payment transaction. It must reference the payment_txn it belongs to, enabling the full authorization→capture→clearing lifecycle chain to ',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Cross-border authorizations apply an FX rate at auth time that may differ from the settlement rate. Linking authorization to fx.rate enables auth-vs-settlement rate variance reporting and dispute reso',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Each authorization originates from a gateway API request; linking enables end‑to‑end audit of auth decisions.',
    `risk_rule_id` BIGINT COMMENT 'Foreign key linking to risk.risk_rule. Business justification: Authorization decisions apply specific risk rules (velocity checks, BIN-level fraud rules, SCA triggers). The risk_rule_id identifies which rule drove the auth outcome (approve/decline/refer). Fraud i',
    `routing_decision_id` BIGINT COMMENT 'Foreign key linking to gateway.routing_decision. Business justification: Authorization approval-rate-by-acquirer reporting and SLA analysis require linking each authorization to the gateway routing decision that selected the acquirer. Payments domain experts expect this fo',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Sanctions screening is a mandatory real-time block at authorization in payments (OFAC, EU sanctions). authorization.compliance_check_passed is a boolean outcome; the FK to sanctions_check enables regu',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Authorizations are processed through a specific card scheme network. Scheme governs auth rules including 3DS requirements, SCA mandates, and response code interpretation. The plain network column is',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Acquirer reconciliation and chargeback investigation require tracing from the authorization record to the settlement that finalised it. Scheme compliance reporting (Visa/MC rules) mandates authorizati',
    `threeds_config_id` BIGINT COMMENT 'Foreign key linking to gateway.threeds_config. Business justification: PSD2 SCA compliance reporting and 3DS performance analysis (frictionless vs. challenge rates, abandonment by config) require linking each authorization to the threeds_config applied. authorization alr',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction. Business justification: authorization should also reference the master transaction record to enable reconciliation and reporting across the full transaction lifecycle. No bidirectional conflict — transaction has no FK pointi',
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
    `network_latency_ms` STRING COMMENT 'Measured network latency between gateway and issuer.',
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
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Capture settlement reconciliation and acquirer fee reporting require knowing which acquirer endpoint processed each capture. Incremental and partial captures may route to different endpoints; acquirer',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Capture triggers the settlement debit/credit against the cardholder account. Settlement amount posting, interchange fee allocation, and account balance updates at capture time require direct reference',
    `irf_table_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_table. Business justification: The interchange rate applied at capture is governed by the IRF table. Linking capture to irf_table supports interchange fee calculation traceability and cost-of-acceptance reporting — essential for ac',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: MDR is computed and applied at capture time. capture.interchange_fee (plain) is calculated from mdr_config rates. Linking capture to mdr_config supports MDR fee calculation audit trails and merchant b',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the captured transaction.',
    `authorization_id` BIGINT COMMENT 'Identifier of the original authorization transaction that this capture fulfills.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: capture finalizes an authorized transaction for downstream clearing and settlement. It must reference the payment_txn it belongs to, completing the authorization→capture chain at the payment_txn level',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: Interchange program determines the applicable rate structure at capture. Linking capture to interchange program supports program-level interchange cost attribution, rewards program cost tracking, and ',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Capture locks in the FX rate for settlement. Linking to fx.rate enables settlement dispute resolution, rate audit trails, and regulatory reporting. capture.exchange_rate is a denormalized rate value t',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Captures are settled through a specific schemes settlement rails. Scheme determines interchange fee applicability, settlement currency, and capture eligibility rules. The plain network column is a ',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Captures are grouped into settlement batches for acquirer processing; the settlement batch determines interchange category and fee calculations. Capture-level batch reconciliation and scheme reporting',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Each capture is settled via a settlement record; linking supports audit of captured amounts against settlement.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction. Business justification: capture should reference the master transaction record to enable full lifecycle traceability from master transaction through capture to settlement. No bidirectional conflict — transaction has no FK po',
    `acquirer_reference_number` STRING COMMENT 'Unique reference assigned by the acquiring bank for tracking the transaction.',
    `amount` DECIMAL(18,2) COMMENT 'Authorized amount captured before any adjustments, expressed in the transaction currency.',
    `auth_code` STRING COMMENT 'Code returned by the issuing bank confirming the original authorization.',
    `capture_method` STRING COMMENT 'Method by which the capture was performed (immediate, delayed, incremental, or partial).. Valid values are `immediate|delayed|incremental|partial`',
    `capture_number` STRING COMMENT 'Business-facing identifier for the capture event, often used in reporting and reconciliation.',
    `capture_status` STRING COMMENT 'Current lifecycle status of the capture (e.g., pending, completed, failed, reversed, partial).. Valid values are `pending|completed|failed|reversed|partial`',
    `capture_timestamp` TIMESTAMP COMMENT 'Exact date and time when the capture was performed, per ISO 8583/20022 event time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capture record was first persisted in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the capture amount.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the capture was flagged for potential fraud.',
    `interchange_fee` DECIMAL(18,2) COMMENT 'Fee paid between acquiring and issuing banks for this capture.',
    `is_incremental` BOOLEAN COMMENT 'True when the capture adds to a previously captured amount (multiple captures).',
    `is_partial_capture` BOOLEAN COMMENT 'Indicates whether the capture represents a partial amount of the original authorization.',
    `is_settled` BOOLEAN COMMENT 'True when the capture amount has been successfully settled.',
    `merchant_category_code` STRING COMMENT 'Four‑digit code classifying the merchants business type.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount after tip, surcharge, and tax adjustments.',
    `processing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the payment processor for handling the capture.',
    `reversal_amount` DECIMAL(18,2) COMMENT 'Amount reversed from the capture, if a reversal occurred.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Timestamp when the capture was reversed.',
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
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Clearing submissions are sent to a specific acquirer endpoint. Clearing reconciliation, acquirer-level clearing volume reporting, and settlement currency determination require knowing which endpoint r',
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: AML screening at clearing stage is required under FATF Recommendation 16 (wire transfer rules). clearing_submission.aml_screened_flag is a denormalized boolean; the FK to compliance_aml_screening_resu',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: clearing_submission represents a captured transaction submitted for clearing; it must reference the authorization that preceded it. Currently only stores authorization_code as a STRING — normalizing t',
    `bin_interchange_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.bin_interchange_rule. Business justification: Clearing submissions are matched against BIN interchange rules to determine applicable interchange rates. clearing_submission has bin_number (plain attr); linking to bin_interchange_rule supports inte',
    `capture_id` BIGINT COMMENT 'Foreign key linking to transaction.capture. Business justification: clearing_submission is generated from a captured transaction. It must reference the capture record to establish the capture→clearing lifecycle link. No bidirectional conflict — capture has no FK point',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Clearing submissions for cross-border transactions must reference the currency pair for scheme routing, settlement currency determination, and interchange fee category assignment. A domain expert expe',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Clearing submissions include FX and interchange fees governed by fee schedules. Linking to fx_fee_schedule enables fee reconciliation, regulatory fee audit, and validation that the correct fee schedul',
    `interchange_qualification_id` BIGINT COMMENT 'Foreign key linking to product.interchange_qualification. Business justification: Clearing submissions are qualified to interchange tiers at clearing time — this is the definitive interchange qualification event. clearing_submission has denormalized interchange_category and irf_rat',
    `irf_table_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_table. Business justification: Interchange rate reconciliation at clearing requires linking each clearing submission to the specific IRF table entry that governed the interchange rate applied. irf_rate_category and interchange_cate',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: MDR is applied at clearing submission time. Linking clearing_submission to mdr_config supports MDR fee calculation traceability, merchant billing verification, and clearing fee reconciliation in acqui',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Clearing submissions are generated per merchant account for scheme file submission. The acquiring processor needs merchant_account to determine supported card schemes, multi-currency settings, and set',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that originated the transaction.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Cross-border clearing submissions must reference the payment corridor for scheme routing validation, compliance checks (OFAC screening requirements), and settlement instruction determination. Corridor',
    `payment_txn_id` BIGINT COMMENT 'Business identifier of the original captured transaction.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Clearing submissions require sanctions screening before funds are cleared — a FATF and scheme-level requirement. clearing_submission.sanction_check_flag is a denormalized boolean; the FK to sanctions_',
    `scheme_fee_table_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_fee_table. Business justification: Scheme fees are assessed at clearing submission time based on scheme_fee_table. Linking clearing_submission to scheme_fee_table supports scheme fee calculation traceability and reconciliation against ',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Clearing submissions are processed under a specific card scheme (Visa, Mastercard, UnionPay). The scheme governs interchange category, clearing format, and fee rules. scheme_code is a denormalized rep',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Clearing submissions are grouped into settlement batches for acquirer net position calculation and scheme file submission. Batch-level clearing reconciliation and exception management require this dir',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: Clearing submissions are cycle-bound; scheme clearing windows and net position calculations aggregate clearing_submissions by settlement cycle. Operations teams run cycle-level clearing volume and exc',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Clearing submissions are the direct input to settlement; scheme reconciliation, exception management, and regulatory reporting (PSD2 Article 94) require tracing each clearing submission to the settlem',
    `transaction_id` BIGINT COMMENT 'Business identifier of the original captured transaction.',
    `acquiring_institution_code` BIGINT COMMENT 'Identifier of the acquiring financial institution.',
    `amount_fee` DECIMAL(18,2) COMMENT 'Sum of all fees applied to the transaction.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total transaction amount before fees and adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Transaction amount after fees are deducted.',
    `bin_number` STRING COMMENT 'First six digits of the card number identifying the issuing bank.. Valid values are `^d{6}$`',
    `channel` STRING COMMENT 'Interface through which the transaction was initiated.. Valid values are `online|pos|mobile|atm`',
    `clearing_date` DATE COMMENT 'Calendar date on which the transaction cleared.',
    `clearing_submission_status` STRING COMMENT 'Current processing state of the clearing submission.. Valid values are `captured|submitted|settled|rejected|reversed`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction.. Valid values are `^[A-Z]{3}$`',
    `decline_reason` STRING COMMENT 'Human‑readable description of why a transaction was declined.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used when converting to settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the fee specified by fee_type.',
    `fee_type` STRING COMMENT 'Category of fee applied to the transaction.. Valid values are `interchange|assessment|network|processor`',
    `iin_number` STRING COMMENT 'Six‑digit identifier of the card issuer.. Valid values are `^d{6}$`',
    `irf_amount` DECIMAL(18,2) COMMENT 'Fee amount calculated based on IRF rate category.',
    `issuing_institution_code` BIGINT COMMENT 'Identifier of the issuing financial institution.',
    `mcc_code` STRING COMMENT 'Four‑digit code classifying the merchants business.. Valid values are `^d{4}$`',
    `pci_compliant_flag` BOOLEAN COMMENT 'True if the transaction data meets PCI compliance requirements.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the clearing submission record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `response_code` STRING COMMENT 'Two‑digit response indicating approval or decline reason.. Valid values are `^d{2}$`',
    `reversal_flag` BOOLEAN COMMENT 'True if the transaction was reversed after initial capture.',
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
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: txn_lifecycle_event is an immutable audit log of every state transition including authorization events. It must reference the authorization record to enable event-level traceability back to the author',
    `capture_id` BIGINT COMMENT 'Foreign key linking to transaction.capture. Business justification: txn_lifecycle_event tracks capture state transitions. Adding capture_id FK enables direct linkage from lifecycle events to the capture record they describe. No bidirectional conflict — capture has no ',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder (customer) for the transaction.',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to dispute.chargeback. Business justification: When a chargeback event fires in the transaction lifecycle, the lifecycle record must reference the specific chargeback. txn_lifecycle_event has `chargeback_flag` (plain denormalized indicator) but no',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: Lifecycle events with compliance_flag, dispute_flag, or chargeback_flag directly trigger compliance case creation. Compliance officers need to trace which specific lifecycle event (e.g., a fraud flag ',
    `event_id` BIGINT COMMENT 'Foreign key linking to risk.risk_event. Business justification: Lifecycle events with dispute_flag, reversal_flag, or fraud_flag generate risk events. Linking txn_lifecycle_event to risk_event enables operational risk monitoring, regulatory audit trails, and real-',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant involved in the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the payment transaction to which this lifecycle event belongs.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to transaction.refund. Business justification: txn_lifecycle_event has a refund_flag BOOLEAN indicating refund events. Adding refund_id FK enables direct traceability from lifecycle events to the refund record. Nullable — only populated for refund',
    `reversal_id` BIGINT COMMENT 'Foreign key linking to transaction.reversal. Business justification: txn_lifecycle_event has a reversal_flag BOOLEAN indicating reversal events. Adding reversal_id FK enables direct traceability from lifecycle events to the reversal record. Nullable — only populated fo',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Lifecycle events include scheme-triggered state transitions (scheme-initiated reversals, scheme compliance flags, network timeouts). The plain network_code column is a denormalized scheme identifier',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch (if the event is part of a batch).',
    `transaction_id` BIGINT COMMENT 'Identifier of the payment transaction to which this lifecycle event belongs.',
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
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Acquirer-level reversal rate reporting and settlement impact analysis require knowing which endpoint processed each reversal. Reversals processed through a different acquirer than the original create ',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: A reversal voids or cancels an authorized transaction. It must reference the original authorization record to establish the authorization→reversal lifecycle link. No bidirectional conflict — authoriza',
    `capture_id` BIGINT COMMENT 'Foreign key linking to transaction.capture. Business justification: A reversal may reverse a previously captured transaction. Adding capture_id FK enables direct traceability from the reversal to the capture record being reversed. Nullable — only populated when revers',
    `ecosystem_partner_id` BIGINT COMMENT 'System identifier of the party that initiated the reversal.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Reversals directly affect merchant settlement balances and chargeback ratios. Acquiring systems must attribute reversals to the correct merchant for settlement adjustments, regulatory reporting, and m',
    `transaction_id` BIGINT COMMENT 'Identifier of the original payment transaction that is being reversed.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the original payment transaction that is being reversed.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Reversals are a primary fraud signal; the risk profile of the originating party governs whether a reversal triggers a risk event or requires manual review. Fraud investigation workflows and chargeback',
    `routing_decision_id` BIGINT COMMENT 'Foreign key linking to gateway.routing_decision. Business justification: Reversal routing analysis — whether reversals route to the same acquirer as the original transaction — is a key operational and reconciliation need. Gateway failover during reversal processing require',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Reversals are processed under scheme-specific rules governing reversal windows, reason codes, and fee recovery. Different schemes have distinct reversal processing rails. A direct scheme FK enables sc',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Reversals that affect already-settled amounts must reference the settlement record for accounting entries, GL adjustments, and regulatory reporting. reversal already links to settlement.instruction bu',
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
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Refund abuse is a known AML typology (layering via refunds). refund.compliance_flag_aml is a denormalized boolean; the FK to compliance_aml_screening_result enables compliance teams to trace each refu',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: Large or chargeback-related refunds trigger a risk assessment for AML re-screening and fraud re-evaluation. The assessment_id links the refund to the risk assessment that evaluated it. Refund fraud mo',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: refund has original_authorization_code as a STRING denormalization. Adding authorization_id FK enables proper referential integrity to the original authorization record. The original_authorization_cod',
    `capture_id` BIGINT COMMENT 'Foreign key linking to transaction.capture. Business justification: A refund credits back a previously captured transaction. It must reference the capture record to establish the capture→refund lifecycle link. No bidirectional conflict — capture has no FK pointing bac',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Refund credits must be posted to the specific cardholder account. Refund settlement, statement generation, and regulatory reporting require identifying the exact account receiving the credit — a core ',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who made the original purchase.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: Refund fraud is a major payments fraud vector — fraudulent refund schemes, refund abuse, and first-party fraud require linking refunds to fraud cases. Fraud investigation teams open fraud cases on sus',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that originated the original transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original sale transaction that is being refunded.',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: Refunds are returned to the original card/PAN. Linking to pan_record enables card-level refund tracking, scheme refund validation, and PAN lifecycle management. cardholder_pan_masked is a denormalized',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the original sale transaction that is being refunded.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Cross-border refunds apply an FX rate (original or current) for amount calculation. Linking to fx.rate enables rate audit for refund disputes, regulatory reporting, and validation of refund amounts. r',
    `routing_decision_id` BIGINT COMMENT 'Foreign key linking to gateway.routing_decision. Business justification: Refunds are independently routed through the gateway and may use a different acquirer than the original transaction. Refund routing performance analysis and acquirer-level refund reconciliation requir',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Refunds are processed under scheme-specific rules governing eligibility windows, reason codes, and fee treatment. scheme_refund_reference is a scheme-issued identifier confirming scheme affiliation. A',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this refund.',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this refund.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount credited back to the cardholder or alternative instrument.',
    `batch_number` STRING COMMENT 'Identifier of the batch file in which the refund was processed.',
    `cardholder_email` STRING COMMENT 'Primary email address of the cardholder for communication and receipt delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cardholder_name` STRING COMMENT 'Legal full name of the cardholder.',
    `channel` STRING COMMENT 'Channel through which the refund request was submitted.. Valid values are `online|mobile|pos|mpos`',
    `compliance_flag_fraud` BOOLEAN COMMENT 'True if the refund was flagged by the fraud detection engine.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the refund record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the refund amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee charged by the processor for processing the refund.',
    `fee_currency_code` STRING COMMENT 'Currency of the refund fee amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date‑time when the merchant initiated the refund request.',
    `is_chargeback_related` BOOLEAN COMMENT 'True if the refund is linked to an ongoing chargeback case.',
    `is_partial_refund` BOOLEAN COMMENT 'True if the refund amount is less than the original transaction amount.',
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
    `billing_id` BIGINT COMMENT 'Foreign key linking to interchange.billing. Business justification: Interchange billing aggregates costs per processing batch period. Linking transaction_batch to interchange billing supports interchange cost attribution per batch for financial reporting and acquirer ',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Batch settlement files are submitted per merchant account. The batch processor references merchant_account for settlement routing, batch_settlement_enabled flag, and settlement_delay_days configuratio',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant whose transactions are included in this batch.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: Transaction batches are submitted via a specific merchant integration channel. Merchant integration performance reporting (batch error rates, processing times by integration type) and onboarding compl',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Transaction batches are submitted to a specific schemes clearing network. Scheme governs batch format, settlement currency, and submission windows. scheme_batch_reference is a scheme-issued identifie',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: transaction_batch and settlement_batch are parallel constructs that must be reconciled; the transaction batch feeds the settlement batch. Batch reconciliation, checksum validation, and exception manag',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: Batch processing is grouped into settlement cycles; linking enables cycle‑level performance and compliance reporting.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to network.sla. Business justification: Batch settlement is governed by scheme SLAs defining batch_settlement_window_hours and uptime targets. Linking transaction_batch to the applicable SLA record enables automated SLA breach detection, pe',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: Batch processing is governed by SLA profiles defining processing time and error rate thresholds. SLA compliance reporting for batch operations — using transaction_batch.processing_time_seconds and err',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for each reconciliation record.',
    `billing_id` BIGINT COMMENT 'Foreign key linking to interchange.billing. Business justification: Interchange billing reconciliation requires matching internal transaction reconciliation records against scheme billing statements. Linking transaction_reconciliation to interchange billing supports t',
    `clearing_submission_id` BIGINT COMMENT 'Foreign key linking to transaction.clearing_submission. Business justification: transaction_reconciliation compares internal records against clearing submissions. It must reference the clearing_submission being reconciled to enable direct comparison. No bidirectional conflict — c',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: FX reconciliation reports require the currency pair to validate conversion rates, identify variance root causes, and produce regulatory cross-border reconciliation reports. transaction_reconciliation.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.dispute_case. Business justification: Reconciliation exceptions and variances are frequently caused by open dispute cases. Linking transaction_reconciliation to dispute_case enables dispute-driven exception reporting, allows reconciliatio',
    `downgrade_id` BIGINT COMMENT 'Foreign key linking to interchange.downgrade. Business justification: Downgraded transactions incur higher interchange costs that must be identified and reconciled. Linking transaction_reconciliation to downgrade supports interchange downgrade cost reconciliation and va',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner-level reconciliation reporting is a named operational and regulatory process — payment facilitators and aggregators require reconciliation statements scoped to their ecosystem. Direct FK enabl',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Reconciliation is performed at merchant account level — matching internal transaction records against scheme settlement files for a specific account. Reconciliation reports and exception management re',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant whose transactions are being reconciled.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: transaction_reconciliation compares internal transaction records against scheme/bank records. It must reference the payment_txn being reconciled to enable direct traceability. No bidirectional conflic',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to interchange.qualification. Business justification: Interchange reconciliation verifies that qualified interchange amounts match internal records. Linking transaction_reconciliation to qualification supports interchange qualification status verificatio',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Reconciliation processes validate the FX rate applied to matched transactions for variance analysis and regulatory reporting. transaction_reconciliation.currency_conversion_rate is a denormalized rate',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Reconciliation is performed per scheme — Visa and Mastercard reconciliation are separate processes with distinct source files and interchange categories. A direct scheme FK enables scheme-level reconc',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Batch-level reconciliation is a standard acquirer operations process; transaction_reconciliation must reference the settlement_batch it reconciles for batch exception management, checksum validation, ',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: Cycle-level reconciliation reporting (matched/unmatched counts, variance by cycle) is a standard treasury operations report. transaction_reconciliation must be directly associated with the settlement ',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: transaction_reconciliations core business process is matching internal transaction records against settlement records. Direct FK to settlement.settlement is required for variance reporting, exception',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction. Business justification: transaction_reconciliation should also reference the master transaction record to enable reconciliation reporting at the master transaction level. No bidirectional conflict — transaction has no FK poi',
    `acquiring_bank_code` BIGINT COMMENT 'Identifier of the acquiring bank involved in the transaction flow.',
    `compliance_check_status` STRING COMMENT 'Result of automated compliance checks performed on the reconciliation data.. Valid values are `passed|failed|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `cross_border_flag` BOOLEAN COMMENT 'True if the batch contains any cross‑border transactions, false otherwise.',
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
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Reconciliation record produced by the Transaction Processing Platform comparing internal transaction records against scheme-reported clearing and settlement files. Captures reconciliation date, reconciliation type (intraday, end-of-day, T+1 settlement), matched transaction count, unmatched transaction count, total matched amount, total variance amount, reconciliation status (balanced, exception, pending), and the source file references for both sides of the comparison. SSOT for transaction-level reconciliation outcomes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` (
    `txn_routing_decision_id` BIGINT COMMENT 'System-generated unique identifier for each routing decision record.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: txn_routing_decision.selected_network is a denormalized string; the proper FK to acquirer_endpoint enables least-cost routing (LCR) analysis, acquirer performance benchmarking, and routing rule effect',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: Routing decisions select the acquirer; the chosen acquirer determines settlement entity, interchange rates, and settlement currency. Least-cost routing analysis and acquirer settlement performance rep',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Least-cost routing and preferred network routing are contractually defined in partner agreements. Linking routing decisions to the governing agreement enables compliance auditing of contractual routin',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: txn_routing_decision records the real-time routing decision made before/during authorization. It should reference the resulting authorization record to close the routing→authorization loop. No bidirec',
    `bin_interchange_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.bin_interchange_rule. Business justification: Least-cost routing (LCR) — explicitly tracked via lcr_applied on txn_routing_decision — requires evaluating BIN interchange rules per candidate network. Linking routing decisions to bin_interchange_ru',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Least-cost routing (LCR) and network selection use the cardholders preferred_scheme_id and risk_level from cardholder_profile. txn_routing_decision.lcr_applied and selected_network decisions directly',
    `cross_border_fee_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.cross_border_fee_rule. Business justification: Cross-border routing decisions must account for cross-border fee rules. txn_routing_decision has is_cross_border and cross_border_fee (plain attrs); linking to cross_border_fee_rule supports cross-bor',
    `device_id` BIGINT COMMENT 'Identifier of the device (e.g., mobile device ID) used for the transaction.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank or processor selected.',
    `eligibility_rule_id` BIGINT COMMENT 'Foreign key linking to product.eligibility_rule. Business justification: Routing engines evaluate product eligibility rules before selecting a network/route. Linking txn_routing_decision to the eligibility_rule applied enables routing audit trails, compliance reporting on ',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: Routing decision records the specific network endpoint used for processing, needed for audit trails and latency monitoring.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: LCR routing decisions select networks based on interchange rate categories. Linking txn_routing_decision to irf_rate_category supports interchange cost optimization analysis, routing rule effectivenes',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Routing decisions depend on merchant_account capabilities: supported_card_schemes, cross_border_processing_enabled, multi_currency_enabled, tokenization_enabled. The routing engine queries these accou',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that originated the transaction.',
    `multi_network_routing_id` BIGINT COMMENT 'Foreign key linking to network.multi_network_routing. Business justification: txn_routing_decision has lcr_applied and durbin_compliance_applied flags driven by a multi_network_routing profile. Linking to the profile applied enables least-cost routing effectiveness reporting, D',
    `network_routing_rule_id` BIGINT COMMENT 'Foreign key linking to network.network_routing_rule. Business justification: The specific network_routing_rule matched and executed for each routing decision must be traceable for compliance audit, override tracking, and rule performance monitoring. This FK enables direct attr',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Routing decisions for cross-border transactions must reference the payment corridor to evaluate available rails, corridor-specific fees, and compliance requirements. LCR (Least Cost Routing) decisions',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the payment transaction for which the routing decision was made.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment network (e.g., Visa, Mastercard).',
    `product_pricing_plan_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_plan. Business justification: Least-cost routing (LCR) decisions are directly driven by product pricing plans. txn_routing_decision already has lcr_applied flag. Linking to product_pricing_plan enables LCR audit reports showing wh',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: Interchange program-aware routing selects networks based on program eligibility and rates. Linking txn_routing_decision to interchange program supports LCR program optimization analysis and routing ru',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: LCR (Least Cost Routing) decisions for cross-border transactions evaluate routing options using the current FX rate to minimize conversion costs. Linking txn_routing_decision to fx.rate enables routin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Routing decisions are directly governed by regulatory obligations — Durbin Amendment (US debit routing), PSD2 open banking routing, and scheme rules. txn_routing_decision.durbin_compliance_applied ind',
    `risk_rule_id` BIGINT COMMENT 'Foreign key linking to risk.risk_rule. Business justification: Routing decisions apply specific risk rules (block high-risk BINs, enforce 3DS on certain routes, apply Durbin compliance). The gateway_routing_rule_id covers gateway logic; risk_rule_id covers the ri',
    `routing_decision_id` BIGINT COMMENT 'Foreign key linking to gateway.routing_decision. Business justification: txn_routing_decision (transaction domain) and gateway.routing_decision represent the same event from two system perspectives. Reconciliation between transaction-layer routing records and gateway-layer',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: Each routing decision consults a specific routing_table entry (BIN range, MCC, currency rules). Linking the decision to the routing_table row applied enables routing rule effectiveness analysis, least',
    `transaction_id` BIGINT COMMENT 'Identifier of the payment transaction for which the routing decision was made.',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Routing decisions are made based on transaction type (e.g., purchase vs. cash advance vs. refund have different routing rules). Adding txn_type_id FK normalizes the transaction type reference on routi',
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
    `transaction_amount` DECIMAL(18,2) COMMENT 'Gross amount of the transaction before fees or discounts.',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Total fees applied to the transaction (e.g., interchange, network, processing).',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact time the transaction was initiated by the cardholder or payer.',
    `txn_routing_decision_status` STRING COMMENT 'Current processing status of the routing decision record.. Valid values are `pending|completed|failed|reversed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the routing decision record.',
    `created_by` STRING COMMENT 'System or user that initially created the routing decision record.',
    CONSTRAINT pk_txn_routing_decision PRIMARY KEY(`txn_routing_decision_id`)
) COMMENT 'Record of the real-time routing decision made by the Payment Gateway and Authorization Engine for each transaction, capturing which network rail, acquirer, and processing path was selected. Stores routing rule version applied, candidate networks evaluated, selected network, routing reason (least cost, preferred network, fallback, regulatory), routing latency in milliseconds, and whether least-cost routing (LCR) or Durbin Amendment routing rules were applied. Enables routing optimization analytics and regulatory compliance evidence.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` (
    `txn_fee_id` BIGINT COMMENT 'Unique identifier for the fee record associated with a payment transaction.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to transaction.capture. Business justification: Fees are assessed at the capture stage of the transaction lifecycle. Adding capture_id FK links the fee record to the capture event that triggered it. No bidirectional conflict — capture has no FK poi',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to dispute.chargeback. Business justification: Scheme chargeback fees (interchange reversals, scheme assessment fees) are recorded in txn_fee. Linking txn_fee to the chargeback that triggered the fee is required for chargeback cost analysis, merch',
    `clearing_submission_id` BIGINT COMMENT 'Foreign key linking to transaction.clearing_submission. Business justification: Fees are assessed during the clearing process. Adding clearing_submission_id FK links the fee record to the clearing submission that generated it, enabling fee reconciliation against clearing records.',
    `cross_border_fee_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.cross_border_fee_rule. Business justification: Cross-border fee line items in txn_fee are governed by cross_border_fee_rule. txn_fee has fee_jurisdiction_code (plain); linking to cross_border_fee_rule supports cross-border fee calculation audit tr',
    `downgrade_id` BIGINT COMMENT 'Foreign key linking to interchange.downgrade. Business justification: Interchange downgrades result in incremental fee charges recorded in txn_fee. Linking txn_fee to downgrade supports downgrade cost attribution, preventable downgrade analysis, and merchant remediation',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Revenue share accrual and partner billing require fee records to be directly attributed to the ecosystem partner. Without this FK, calculating real-time partner payouts requires joining through paymen',
    `interchange_qualification_id` BIGINT COMMENT 'Foreign key linking to product.interchange_qualification. Business justification: Interchange fees recorded in txn_fee must be traceable to the interchange qualification tier that determined the rate. Fee audit, interchange billing disputes, and scheme compliance reporting all requ',
    `irf_table_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_table. Business justification: Transaction fee records for interchange fee_type must reference the specific IRF table entry used to calculate the fee. This supports interchange fee audit trails, regulatory reporting, and fee disput',
    `merchant_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_fee_schedule. Business justification: txn_fee records are generated by applying a merchant_fee_schedule. Audit trails, fee dispute resolution, and billing reconciliation require knowing which fee schedule produced each fee record. Fee sch',
    `merchant_payout_id` BIGINT COMMENT 'Foreign key linking to settlement.merchant_payout. Business justification: MDR, interchange, and scheme fees are deducted in merchant payouts. Linking txn_fee to merchant_payout enables fee-level payout reconciliation, merchant dispute resolution, and transparent fee disclos',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the parent payment transaction to which this fee applies.',
    `pricing_exception_id` BIGINT COMMENT 'Foreign key linking to interchange.pricing_exception. Business justification: Fees computed under negotiated pricing exceptions must reference the governing pricing_exception record for audit trail, contract compliance verification, and revenue impact tracking — a mandatory con',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to interchange.qualification. Business justification: Interchange fee line items in txn_fee must reference the qualification record that determined the fee amount and tier. This supports interchange fee audit trails, qualification tier verification, and ',
    `revenue_share_schedule_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_schedule. Business justification: Each fee record must reference the governing revenue share schedule to apply correct MDR/IRF split rates. This enables fee dispute resolution, partner payout auditing, and traceability from individual',
    `scheme_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to network.scheme_fee_schedule. Business justification: Each fee applied to a transaction is assessed per a specific scheme fee schedule row. Linking txn_fee to the exact scheme_fee_schedule applied enables interchange fee reconciliation, scheme billing au',
    `scheme_fee_table_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_fee_table. Business justification: Scheme assessment fees are a distinct fee type on txn_fee records. Linking to scheme_fee_table provides the governing rate schedule for scheme fee calculation, supporting scheme fee reconciliation aga',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Fees (interchange, scheme, processing) must be traceable to the settlement record in which they were settled for merchant fee reconciliation, interchange reporting, and scheme fee audits. txn_fee has ',
    `transaction_id` BIGINT COMMENT 'Identifier of the parent payment transaction to which this fee applies.',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Fee structures are defined per transaction type (e.g., interchange fees differ by transaction type). Adding txn_type_id FK normalizes the transaction type reference on fee records and enables fee anal',
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
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: FX conversion occurs during authorization for cross-border transactions (DCC — Dynamic Currency Conversion). Adding authorization_id FK links the FX conversion record to the authorization event where ',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder/customer involved in the transaction.',
    `clearing_submission_id` BIGINT COMMENT 'Foreign key linking to transaction.clearing_submission. Business justification: FX conversion rates are applied during clearing for cross-border transactions. Adding clearing_submission_id FK links the FX conversion record to the clearing submission where the conversion was appli',
    `cross_border_fee_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.cross_border_fee_rule. Business justification: DCC and cross-border FX conversions are subject to cross-border fee rules including dcc_fee_rate_percent. fx_conversion has dcc_opt_in_flag and is_cross_border; linking to cross_border_fee_rule suppor',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: FX conversion must reference the currency pair to enforce DCC eligibility, decimal precision, and settlement currency rules. target_currency_code is a denormalized identifier; the currency_pair entity',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: PSD2 Article 45 requires disclosure of FX conversion fees. Linking fx_conversion to fx_fee_schedule enables fee audit, regulatory fee disclosure reporting, and reconciliation of conversion fees agains',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: DCC (Dynamic Currency Conversion) eligibility and FX markup rules are configured at merchant_account level (dynamic_currency_conversion_enabled). The FX conversion engine must verify merchant_account ',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the original transaction.',
    `payment_txn_id` BIGINT COMMENT 'Identifier of the original payment transaction that triggered the FX conversion.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: FX conversion records must reference the exact rate snapshot used for regulatory audit (PSD2, MiFID II), dispute resolution, and rate variance reporting. fx_conversion.fx_rate, rate_source, rate_type ',
    `rate_margin_config_id` BIGINT COMMENT 'Foreign key linking to fx.rate_margin_config. Business justification: FX conversion applies a margin/spread on top of the base rate per rate_margin_config. Linking enables margin audit, pricing transparency reporting, and regulatory compliance verification of the spread',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: FX conversions are subject to specific regulatory obligations — PSD2 DCC disclosure requirements, cross-border reporting under EMIR, and central bank FX reporting rules. fx_conversion.regulatory_repor',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: FX conversions that affect settlement amounts must be traceable to the settlement record for FX P&L reporting, regulatory FX disclosure (PSD2 Article 45), and cross-border settlement reconciliation. f',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement instruction linked to this conversion.',
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
    `is_cross_border` BOOLEAN COMMENT 'True if the underlying transaction is cross‑border; otherwise False.',
    `rate_validity_end` DATE COMMENT 'Date after which the quoted FX rate is no longer valid (nullable).',
    `rate_validity_start` DATE COMMENT 'Date from which the quoted FX rate is considered valid.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this conversion must be included in regulatory reports (e.g., AML, SAR).',
    `source_amount` DECIMAL(18,2) COMMENT 'Transaction amount expressed in the source currency before conversion.',
    `target_amount` DECIMAL(18,2) COMMENT 'Transaction amount expressed in the target currency after conversion.',
    `transaction_type` STRING COMMENT 'Category of the original payment transaction that triggered the conversion.. Valid values are `card_present|card_not_present|digital_wallet|bank_transfer|p2p|b2b`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the conversion record.',
    CONSTRAINT pk_fx_conversion PRIMARY KEY(`fx_conversion_id`)
) COMMENT 'Foreign exchange conversion record for cross-border and multi-currency transactions, capturing the source currency, target currency, FX rate applied, rate type (mid-market, DCC, scheme rate), conversion amount, conversion timestamp, rate source (scheme, internal FX engine, third-party provider), and DCC opt-in/opt-out flag. SSOT for currency conversion events at the transaction level, supporting cross-border payment reporting and DCC revenue tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_type` (
    `txn_type_id` BIGINT COMMENT 'Unique surrogate key for each transaction type record.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Transaction types map to interchange rate categories — txn_type.iso_processing_code (plain) corresponds to irf_rate_category qualification criteria. Linking txn_type to irf_rate_category supports inte',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Transaction type controls (requires_aml_check, requires_3ds, is_fraud_sensitive, risk_score_category) are governed by risk policies. The risk_policy determines which transaction types require enhanced',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Transaction types are defined and constrained by regulatory obligations — recurring payment rules (PSD2), cross-border transaction requirements (FATF), AML/KYC requirements per transaction category. t',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` (
    `txn_limit_rule_id` BIGINT COMMENT 'System-generated unique identifier for the transaction limit rule.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Transaction limits are jurisdiction-specific — contactless limits differ between EU (€50), UK (£100), and Australia (A$200). txn_limit_rule has no FK to jurisdiction_profile. Compliance and product te',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Transaction limit rules (contactless limits, cross-border limits, daily caps) are derived from and governed by risk policies. risk_basis on txn_limit_rule is a denormalized reference to risk_policy. L',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Transaction limit rules are directly derived from regulatory obligations — PSD2 SCA contactless exemption limits (€50), AML cash transaction thresholds, cross-border reporting limits. txn_limit_rule.r',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Transaction limit rules include scheme-mandated limits (contactless_limit, tap_limit governed by Visa/Mastercard scheme bulletins). Linking txn_limit_rule to the scheme that mandates it enables compli',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`transaction`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `a2a_product_id` BIGINT COMMENT 'Foreign key linking to product.a2a_product. Business justification: Account‑to‑account transfers are governed by a2a product settings; linking enables settlement and compliance checks.',
    `account_holder_id` BIGINT COMMENT 'Unique identifier of the cardholder (or payer) involved in the transaction.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Links transaction to its accounting period, required for period‑close, trial‑balance generation, and financial reporting.',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: BNPL purchases are tracked against a specific BNPL plan for installment schedules and regulatory reporting.',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: Card program analytics and spend‑control rules need the program identifier for every transaction.',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: The core transaction entity must reference the cardholder account for ledger posting, statement generation, balance updates, and regulatory reporting. Every posted transaction in a payments system is ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Enables cost allocation per transaction for internal reporting and budgeting, used in expense tracking and cost‑center performance reports.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: The master transaction record for cross-border transactions must reference the currency pair for FX reporting, regulatory cross-border transaction classification, and settlement currency determination',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank or payment processor.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Required for posting each transaction to the General Ledger revenue/expense account during journal entry creation, a core accounting process.',
    `interchange_qualification_id` BIGINT COMMENT 'Foreign key linking to product.interchange_qualification. Business justification: Every card transaction is qualified to an interchange tier that determines the interchange fee charged to the merchant/acquirer. Interchange qualification reporting, merchant billing reconciliation, a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Associates each transaction with the owning legal entity for regulatory filing, consolidation, and entity‑level financial statements.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant that originated the transaction.',
    `original_transaction_id` BIGINT COMMENT 'Self-referencing FK on transaction (original_transaction_id)',
    `p2p_product_id` BIGINT COMMENT 'Foreign key linking to product.p2p_product. Business justification: Peer‑to‑peer payments require linking each transaction to the P2P product definition for fee and risk rules.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Required for product‑level reporting, fee calculation and compliance; each transaction must be tied to the specific payment product used.',
    `product_pricing_plan_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_plan. Business justification: Revenue attribution and pricing plan performance reports require linking each transaction to the active pricing plan. This drives merchant billing, revenue forecasting, and pricing model analytics — a',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: The master transaction record drives GL posting, regulatory reporting (PSD2, Reg E), and end-to-end lifecycle reporting. Direct FK to settlement.settlement is required for period-close, compliance rep',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch that includes this transaction.',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Transaction type is currently a free‑text field; linking to txn_type enables standardized processing and rule enforcement.',
    `virtual_account_product_id` BIGINT COMMENT 'Foreign key linking to product.virtual_account_product. Business justification: Virtual account usage must be recorded per transaction for balance control and regulatory audit.',
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_original_auth_authorization_id` FOREIGN KEY (`original_auth_authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`refund`(`refund_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_reversal_id` FOREIGN KEY (`reversal_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`reversal`(`reversal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_clearing_submission_id` FOREIGN KEY (`clearing_submission_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`clearing_submission`(`clearing_submission_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_clearing_submission_id` FOREIGN KEY (`clearing_submission_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`clearing_submission`(`clearing_submission_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_clearing_submission_id` FOREIGN KEY (`clearing_submission_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`clearing_submission`(`clearing_submission_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ADD CONSTRAINT `fk_transaction_txn_limit_rule_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_original_transaction_id` FOREIGN KEY (`original_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`transaction` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`transaction` SET TAGS ('dbx_domain' = 'transaction');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Interchange Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DPAN / Device Serial)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `sub_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Sub Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `tokenization_flag` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Gross Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Interchange Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `original_auth_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `partner_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Api Credential Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `threeds_config_id` SET TAGS ('dbx_business_glossary_term' = 'Threeds Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (ms)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `interchange_fee` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `is_incremental` SET TAGS ('dbx_business_glossary_term' = 'Incremental Capture Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `is_partial_capture` SET TAGS ('dbx_business_glossary_term' = 'Partial Capture Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `is_settled` SET TAGS ('dbx_business_glossary_term' = 'Settled Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Capture Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `processing_fee` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `reversal_amount` SET TAGS ('dbx_business_glossary_term' = 'Reversal Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` SET TAGS ('dbx_subdomain' = 'settlement_reconciliation');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `clearing_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (Cardholder ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Interchange Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `interchange_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier (Txn ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `scheme_fee_table_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier (Txn ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `acquiring_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Institution Identifier (Acquirer ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `amount_fee` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Amount (Fee Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount (Gross Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount (Net Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel (Channel)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|pos|mobile|atm');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `irf_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee Amount (IRF Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `issuing_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Institution Identifier (Issuer ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `pci_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Indicator Flag (PCI Flag)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Response Code (Response Code)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `response_code` SET TAGS ('dbx_value_regex' = '^d{2}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator Flag (Reversal Flag)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount (Settlement Amount)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Assigned Clearing Reference (SAR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission Timestamp (Submission TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Timestamp (Txn Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type (Card, ACH, etc.)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'card|ach|wire|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `txn_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Lifecycle Event ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Event Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `reversal_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `reversal_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Email Address');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Full Name');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Refund Channel');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile|pos|mpos');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `compliance_flag_fraud` SET TAGS ('dbx_business_glossary_term' = 'Fraud Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Initiated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `is_chargeback_related` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Relation Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ALTER COLUMN `is_partial_refund` SET TAGS ('dbx_business_glossary_term' = 'Partial Refund Indicator');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` SET TAGS ('dbx_subdomain' = 'settlement_reconciliation');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Batch Identifier (TBI)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` SET TAGS ('dbx_subdomain' = 'settlement_reconciliation');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reconciliation ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `clearing_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `downgrade_id` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `acquiring_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier (ACQ_BANK_ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Transaction Flag (CROSS_BORDER_FLG)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag (EXCEPTION_FLG)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `issuing_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier (ISS_BANK_ID)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `matched_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Matched Transaction Count (MATCHED_TXN_CNT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `net_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Total Amount (NET_TOTAL_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes (REC_NOTES)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `processing_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Time in Seconds (PROC_TIME_SEC)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number (REC_NO)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status (REC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'balanced|exception|pending');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Event Timestamp (REC_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type (REC_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'intraday|end_of_day|t_plus_1');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Indicator (REG_REPORT_IND)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `regulatory_report_indicator` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `risk_score_average` SET TAGS ('dbx_business_glossary_term' = 'Average Risk Score (AVG_RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code (SETTLEMENT_CURR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date (SETTLEMENT_DT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `source_file_internal` SET TAGS ('dbx_business_glossary_term' = 'Internal Source File Reference (INT_SRC_FILE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `source_file_scheme` SET TAGS ('dbx_business_glossary_term' = 'Scheme Source File Reference (SCHEME_SRC_FILE)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `total_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Amount (TOTAL_FEE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `total_matched_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Matched Amount (TOTAL_MATCHED_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount (TOTAL_TAX_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `total_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Amount (TOTAL_TXN_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount (TOTAL_VARIANCE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code (TXN_CURR)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Count (TXN_VOLUME)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `unmatched_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Transaction Count (UNMATCHED_TXN_CNT)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code (VAR_REASON_CD)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'amount_mismatch|missing_transaction|duplicate|other');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `txn_routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Routing Decision ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Interchange Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `cross_border_fee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Fee Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `multi_network_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Multi Network Routing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `network_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Network Routing Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `product_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `txn_routing_decision_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Status');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `txn_routing_decision_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `txn_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `clearing_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `cross_border_fee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Fee Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `downgrade_id` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `interchange_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `merchant_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `merchant_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Payout Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `pricing_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Exception Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `revenue_share_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `scheme_fee_table_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` SET TAGS ('dbx_subdomain' = 'settlement_reconciliation');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `fx_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'FX Conversion Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `clearing_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `cross_border_fee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Fee Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_margin_config_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Margin Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_validity_end` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity End Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `rate_validity_start` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity Start Date');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `source_amount` SET TAGS ('dbx_business_glossary_term' = 'Source Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `target_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Amount');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|digital_wallet|bank_transfer|p2p|b2b');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` SET TAGS ('dbx_subdomain' = 'transaction_governance');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` SET TAGS ('dbx_subdomain' = 'transaction_governance');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `txn_limit_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Rule ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` SET TAGS ('dbx_subdomain' = 'transaction_governance');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `a2a_product_id` SET TAGS ('dbx_business_glossary_term' = 'A2A Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Institution ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `interchange_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `original_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `p2p_product_id` SET TAGS ('dbx_business_glossary_term' = 'P2P Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `product_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ALTER COLUMN `virtual_account_product_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product Id (Foreign Key)');
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
