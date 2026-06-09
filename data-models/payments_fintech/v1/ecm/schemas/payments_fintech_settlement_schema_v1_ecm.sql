-- Schema for Domain: settlement | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`settlement` COMMENT 'Manages the end-to-end clearing and settlement lifecycle including batch file generation, net settlement positions, RTGS and RTP rail instructions, fund movements, reconciliation records, and funding confirmations between acquiring banks, issuing banks, and card schemes. SSOT for settlement obligations, funding schedules, reserve accounts, and settlement cycles.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Primary key for cycle',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Currency standardization is required for multi‑currency settlement accounting and compliance reporting.',
    `ledger_config_id` BIGINT COMMENT 'Foreign key linking to ledger.ledger_config. Business justification: Accounting teams need to know which ledger configuration a settlement cycle posts to for GL mapping; new column follows default naming.',
    `payment_rail_id` BIGINT COMMENT 'Foreign key linking to reference.payment_rail. Business justification: Settlement cycles must be tied to a payment rail for rail‑specific settlement rules and regulatory reporting.',
    `compliance_status` STRING COMMENT 'Current compliance verification status for the settlement cycle.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement cycle record was created in the system.',
    `cut_off_time` TIMESTAMP COMMENT 'Timestamp representing the cut-off deadline for transaction inclusion in this cycle.',
    `cycle_code` STRING COMMENT 'Business-visible code identifying the settlement cycle, used in operational reporting.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the settlement cycle.. Valid values are `pending|active|closed|suspended`',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement cycle ends; nullable for open-ended cycles.',
    `is_cross_border` BOOLEAN COMMENT 'Flag indicating whether the settlement cycle includes cross-border transactions.',
    `net_position` DECIMAL(18,2) COMMENT 'Net position of the settlement participant after this cycle.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Net amount after fees and adjustments to be settled for the cycle.',
    `processing_mode` STRING COMMENT 'Indicates whether the settlement cycle is processed automatically by the system or requires manual intervention.. Valid values are `automatic|manual`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates if the cycle must be reported to regulatory bodies (e.g., AML, SAR).',
    `settlement_cycle_description` STRING COMMENT 'Free-text description of the settlement cycle purpose or characteristics.',
    `settlement_cycle_type` STRING COMMENT 'Frequency classification of the settlement cycle.. Valid values are `daily|weekly|monthly|ad_hoc`',
    `settlement_window` STRING COMMENT 'Human-readable representation of the time window for the cycle (e.g., 09:00-17:00 UTC).',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement cycle becomes effective.',
    `total_fees_amount` DECIMAL(18,2) COMMENT 'Total fees deducted from the gross amount for the cycle.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Aggregate gross amount of all transactions before fees and adjustments.',
    `total_transactions` STRING COMMENT 'Number of individual transactions included in the settlement cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement cycle record.',
    `value_date` DATE COMMENT 'Date on which settled funds are considered available to the receiving party.',
    CONSTRAINT pk_cycle PRIMARY KEY(`cycle_id`)
) COMMENT 'Master definition of a settlement cycle — the scheduled window during which transactions are batched, cleared, and settled between acquiring banks, issuing banks, and card schemes. Owns cycle identifiers, cut-off times, settlement rail (RTGS, RTP, ACH, SWIFT), value date, cycle status, and participating network scheme. SSOT for settlement timing and cycle configuration.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` (
    `settlement_batch_id` BIGINT COMMENT 'Unique system-generated identifier for the settlement batch record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Batch‑level reporting of fees and risk must reference the exact card scheme entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Batch totals are reported per currency; linking to currency reference ensures consistent ISO codes.',
    `employee_id` BIGINT COMMENT 'System user or service that created the batch record.',
    `funding_schedule_id` BIGINT COMMENT 'Identifier of the funding schedule that drives fund movements for the batch.',
    `acquirer_id` BIGINT COMMENT 'Identifier of the acquiring bank that originated the batch.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this batch belongs.',
    `participant_id` BIGINT COMMENT 'Identifier of the acquiring bank that originated the batch.',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was accepted by the card scheme or clearing house (nullable).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was approved for submission.',
    `approval_user` STRING COMMENT 'User who approved the batch for submission.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the detailed audit trail record for this batch.',
    `batch_status` STRING COMMENT 'Current processing status of the settlement batch.. Valid values are `open|submitted|accepted|rejected|settled`',
    `batch_type` STRING COMMENT 'Classification of the batch (e.g., RTGS, RTP, ACH). [ENUM-REF-CANDIDATE: RTGS|RTP|ACH|BATCH|FILE|OTHER — promote to reference product]',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA‑256) of the batch file for integrity verification.',
    `compliance_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance review for the batch.',
    `compliance_status` STRING COMMENT 'Current compliance verification status of the batch.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch record was first created in the data lake.',
    `cross_border_currency_code` STRING COMMENT 'Currency code of the foreign currency involved in cross‑border settlement. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CHF|... — promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which the batch becomes effective for settlement processing.',
    `effective_until` DATE COMMENT 'Date after which the batch is no longer valid (nullable).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied to convert foreign currency to settlement currency for cross‑border batches.',
    `exchange_rate_timestamp` TIMESTAMP COMMENT 'Timestamp when the exchange rate was captured.',
    `file_name` STRING COMMENT 'File name of the batch file generated for clearing and settlement.',
    `gross_credit_amount` DECIMAL(18,2) COMMENT 'Total credit (incoming) amount of all transactions in the batch before netting.',
    `gross_debit_amount` DECIMAL(18,2) COMMENT 'Total debit (outgoing) amount of all transactions in the batch before netting.',
    `is_cross_border` BOOLEAN COMMENT 'Flag indicating whether the batch contains cross‑border transactions.',
    `net_position_amount` DECIMAL(18,2) COMMENT 'Net position (balance) of the settlement participant after this batch is applied.',
    `net_position_currency` STRING COMMENT 'Currency of the net position amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CHF|CAD|... — promote to reference product]',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Net amount to be settled after debits and credits are netted (gross_credit - gross_debit).',
    `processing_center_code` STRING COMMENT 'Internal code of the processing center handling the batch.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the batch is subject to regulatory reporting (e.g., AML, SAR).',
    `rejection_reason` STRING COMMENT 'Reason provided by the scheme or clearing house when the batch is rejected (nullable).',
    `reserve_account_number` STRING COMMENT 'Account number of the reserve account used for net settlement buffering.',
    `sequence_number` BIGINT COMMENT 'Sequential number assigned to the batch within a settlement cycle.',
    `settlement_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the scheme or clearing house for processing the batch.',
    `settlement_fee_currency` STRING COMMENT 'Currency of the settlement fee amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CHF|... — promote to reference product]',
    `settlement_instructions_reference` STRING COMMENT 'Reference identifier for the settlement instruction file associated with the batch.',
    `settlement_method` STRING COMMENT 'Method used to settle the batch (e.g., wire, ACH, internal transfer). [ENUM-REF-CANDIDATE: WIRE|ACH|INTERNAL|SWIFT|... — promote to reference product]',
    `settlement_timestamp` TIMESTAMP COMMENT 'Timestamp when the net settlement was executed (nullable).',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was submitted to the settlement engine.',
    `total_transaction_count` STRING COMMENT 'Number of individual transactions included in the batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch record.',
    CONSTRAINT pk_settlement_batch PRIMARY KEY(`settlement_batch_id`)
) COMMENT 'Represents a discrete batch of transactions submitted for clearing and settlement within a given settlement cycle. Captures batch sequence number, batch file reference, originating acquirer, card scheme, total transaction count, gross debit amount, gross credit amount, net settlement amount, currency, batch status (open, submitted, accepted, rejected, settled), and submission timestamp. Sourced from the Transaction Processing Platform batch processing module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`instruction` (
    `instruction_id` BIGINT COMMENT 'Primary key for instruction',
    `compliance_aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: AML screening is performed per instruction; linking the result enables SAR filing and regulatory reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Currency of the instruction drives conversion rates and regulatory reporting.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: REQUIRED: Each settlement instruction for a cross‑border payment uses a specific currency pair; needed for FX rate selection and audit.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal identifier of the party that receives the funds (e.g., issuing bank or settlement participant).',
    `participant_id` BIGINT COMMENT 'Internal identifier of the party that funds the instruction (e.g., acquiring bank or merchant).',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Instruction processing generates a journal entry; linking enables traceability from instruction to accounting entry.',
    `net_position_id` BIGINT COMMENT 'Link to the net settlement position that aggregates multiple instructions.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Settlement instruction processing requires the payment product to calculate fees and generate regulatory reports; linking to payment_product provides the product type (card, ACH, BNPL) used for the tr',
    `payment_rail_id` BIGINT COMMENT 'Foreign key linking to reference.payment_rail. Business justification: Each settlement instruction must identify the payment rail for routing and compliance checks.',
    `payment_txn_id` BIGINT COMMENT 'FK to transaction.payment_txn.payment_txn_id — MUST-HAVE: Enables tracing a settlement instruction to its originating transaction — essential for settlement reconciliation and merchant payout verification.',
    `receiving_party_settlement_participant_id` BIGINT COMMENT 'Internal identifier of the party that receives the funds (e.g., issuing bank or settlement participant).',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Audit trail linking each settlement instruction to its originating gateway request for compliance and dispute resolution.',
    `reversal_of_instruction_id` BIGINT COMMENT 'If this is a reversal, points to the original instruction being reversed.',
    `risk_profile_id` BIGINT COMMENT 'Internal identifier of the party that funds the instruction (e.g., acquiring bank or merchant).',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Regulatory requirement: each settlement instruction must be linked to its sanctions screening result for audit and transaction blocking.',
    `cycle_id` BIGINT COMMENT 'Reference to the settlement cycle (e.g., daily, hourly) that this instruction belongs to.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch file or group that contains this instruction.',
    `aml_check_status` STRING COMMENT 'Result of anti‑money‑laundering screening for the instruction.. Valid values are `passed|failed|pending`',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount to be transferred.',
    `bic` STRING COMMENT 'BIC/SWIFT code of the receiving bank.',
    `compliance_flag` STRING COMMENT 'Indicator of any compliance‑related condition attached to the instruction.. Valid values are `none|low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the instruction record was first created in the system.',
    `currency_conversion_indicator` BOOLEAN COMMENT 'True if the instruction required currency conversion.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when converting between original and settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee charged for processing the instruction.',
    `fee_currency` STRING COMMENT 'Currency of the fee amount.',
    `iban` STRING COMMENT 'IBAN of the receiving account when applicable.',
    `instruction_number` STRING COMMENT 'Business‑visible identifier assigned to the instruction, used for tracking and reconciliation.',
    `instruction_status` STRING COMMENT 'Current lifecycle state of the instruction.. Valid values are `pending|approved|rejected|processed|failed|cancelled`',
    `instruction_timestamp` TIMESTAMP COMMENT 'Timestamp of the real‑world event that triggered the instruction (e.g., value date time).',
    `instruction_type` STRING COMMENT 'Indicates whether the instruction adds (credit) or subtracts (debit) funds.. Valid values are `credit|debit`',
    `notes` STRING COMMENT 'Free‑form text for operational comments or special handling instructions.',
    `original_amount` DECIMAL(18,2) COMMENT 'Amount in the original transaction currency before conversion.',
    `original_currency` STRING COMMENT 'Currency of the original transaction amount.',
    `processing_status` STRING COMMENT 'Technical processing state of the instruction within the settlement engine.. Valid values are `pending|in_progress|completed|error`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this instruction is a reversal of a prior instruction.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating assigned by the fraud/risk engine.',
    `sanction_check_status` STRING COMMENT 'Result of sanctions screening for the instruction.. Valid values are `passed|failed|pending`',
    `settlement_date` DATE COMMENT 'Date the instruction was actually settled in the ledger.',
    `settlement_method` STRING COMMENT 'Method used to settle the instruction (netting vs. gross).. Valid values are `netting|gross`',
    `settlement_rail_details` STRING COMMENT 'Additional free‑form details about the rail (e.g., SWIFT message type, ACH batch number).',
    `settlement_status` STRING COMMENT 'Current settlement outcome of the instruction.. Valid values are `pending|settled|failed|reversed`',
    `source_system` STRING COMMENT 'Name of the upstream system that generated the instruction (e.g., Transaction Processing Platform).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the instruction record.',
    `value_date` DATE COMMENT 'Date on which the funds are considered to be settled.',
    `version` STRING COMMENT 'Version of the instruction record for audit‑trail purposes.',
    CONSTRAINT pk_instruction PRIMARY KEY(`instruction_id`)
) COMMENT 'Individual fund movement instruction generated for a settlement obligation — specifying the paying party, receiving party, amount, currency, value date, payment rail (RTGS, RTP, ACH, SWIFT), IBAN/BIC routing details, and instruction status. Each instruction maps to a net settlement position and drives the actual fund transfer. Sourced from the Transaction Processing Platform settlement module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`net_position` (
    `net_position_id` BIGINT COMMENT 'Unique identifier for the net settlement position record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Net positions are aggregated per currency for balance sheet and audit purposes.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the second participant (e.g., issuing bank or scheme) in the settlement pair.',
    `participant_id` BIGINT COMMENT 'Identifier of the first participant (e.g., acquiring bank) in the settlement pair.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this net position belongs.',
    `adjustment_reason` STRING COMMENT 'Reason for any adjustment applied to the net position.',
    `batch_number` STRING COMMENT 'Identifier of the settlement batch file associated with this net position.',
    `confirmation_flag` BOOLEAN COMMENT 'Indicates whether the net position has been confirmed for fund movement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the net position record was created.',
    `effective_date` DATE COMMENT 'Date when the net position becomes effective.',
    `expiry_date` DATE COMMENT 'Date when the net position expires or is superseded.',
    `gross_credit_total` DECIMAL(18,2) COMMENT 'Total gross credit amount for the participant pair before netting.',
    `gross_debit_total` DECIMAL(18,2) COMMENT 'Total gross debit amount for the participant pair before netting.',
    `is_adjusted` BOOLEAN COMMENT 'Indicates if the net position has been adjusted post initial calculation.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after debits and credits are netted (credit minus debit).',
    `net_position_number` STRING COMMENT 'Human‑readable reference number for the net position.. Valid values are `NP-d{8}`',
    `net_position_source` STRING COMMENT 'Source system or process that generated the net position (e.g., Transaction Processing Platform).',
    `net_position_status` STRING COMMENT 'Current lifecycle status of the net position.. Valid values are `pending|posted|confirmed|rejected|adjusted`',
    `netting_method` STRING COMMENT 'Method used to net the positions.. Valid values are `bilateral|multilateral`',
    `note` STRING COMMENT 'Free‑text note or comment regarding the net position.',
    `position_type` STRING COMMENT 'Category of the net position.. Valid values are `transaction_netting|interchange|scheme_fee`',
    `settlement_cycle_timestamp` TIMESTAMP COMMENT 'Timestamp representing the start of the settlement cycle.',
    `settlement_date` DATE COMMENT 'Date on which the settlement is scheduled to occur.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the net position record.',
    `version` STRING COMMENT 'Version number of the net position record for concurrency control.',
    CONSTRAINT pk_net_position PRIMARY KEY(`net_position_id`)
) COMMENT 'Computed net settlement position for each participant pair (acquirer–issuer, acquirer–scheme, or scheme–acquirer) within a settlement cycle. Stores gross debit total, gross credit total, net amount, currency, netting method (bilateral, multilateral), position type (transaction netting, interchange, scheme fee), position status, and confirmation flags. After merging interchange and scheme fee settlement records, this product is the unified SSOT for all settlement obligations before fund movement instructions are generated.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` (
    `funding_confirmation_id` BIGINT COMMENT 'Unique identifier for the funding confirmation record.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Funding confirmations for disputed settlements must reference the dispute case to satisfy compliance and reporting rules.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the bank that provided the funding confirmation.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle (e.g., daily, hourly) associated with this confirmation.',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement instruction that this confirmation relates to.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to audit trail entry for this confirmation.',
    `batch_number` STRING COMMENT 'Batch file identifier used for the settlement batch containing this confirmation.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the confirmation.',
    `confirmation_reference` STRING COMMENT 'Reference number assigned by the confirming bank for the fund transfer.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the confirmation was received from the confirming bank.',
    `confirming_bank_account` STRING COMMENT 'Bank account number of the confirming bank used for the fund transfer.',
    `confirming_bank_name` STRING COMMENT 'Legal name of the confirming bank.',
    `created_by_system` STRING COMMENT 'Name of the source system that created the record (e.g., Transaction Processing Platform).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the funding confirmation record was created in the system.',
    `fund_transfer_type` STRING COMMENT 'Method used to transfer funds.. Valid values are `RTGS|RTP|ACH|SWIFT`',
    `funding_amount` DECIMAL(18,2) COMMENT 'Amount of funds confirmed.',
    `funding_confirmation_status` STRING COMMENT 'Current processing status of the funding confirmation.. Valid values are `pending|confirmed|failed|reversed`',
    `funding_currency` STRING COMMENT 'ISO 4217 currency code of the confirmed funds.. Valid values are `^[A-Z]{3}$`',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the confirmation was processed automatically.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between the confirmation and settlement records.. Valid values are `matched|unmatched|pending|exception`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Flag indicating if this confirmation is required for regulatory reporting.',
    `rtgs_rtp_reference` STRING COMMENT 'Reference identifier for the RTGS or RTP transaction that moved the funds.',
    `settlement_date` DATE COMMENT 'Date on which the settlement is considered effective.',
    `updated_by_system` STRING COMMENT 'Name of the system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the funding confirmation record.',
    CONSTRAINT pk_funding_confirmation PRIMARY KEY(`funding_confirmation_id`)
) COMMENT 'Record of confirmed fund receipt or payment acknowledgment for a settlement instruction. Captures confirmation reference, confirming bank, confirmation timestamp, confirmed amount, currency, RTGS/RTP transaction reference, and reconciliation status. Provides the authoritative proof-of-payment for each settlement obligation. Sourced from the Transaction Processing Platform reconciliation module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` (
    `clearing_record_id` BIGINT COMMENT 'System-generated unique identifier for the clearing record.',
    `clearing_submission_id` BIGINT COMMENT 'Primary key for clearing_record',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: Clearing records must map each transaction to its card program to allocate scheme fees correctly and satisfy scheme‑specific reporting requirements.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Clearing records need the exact card scheme reference for fee calculation and scheme‑level reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank that processed the transaction.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: Clearing records flagged as fraud need a direct reference to the fraud case for audit trails and compliance reporting.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that originated the transaction.',
    `participant_id` BIGINT COMMENT 'Identifier of the acquiring bank that processed the transaction.',
    `response_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_response. Business justification: Reconciliation of cleared transaction with the exact gateway response to verify amounts and fraud flags.',
    `transaction_id` BIGINT COMMENT 'Reference to the original authorization transaction that is being cleared.',
    `authorization_reference_number` STRING COMMENT 'Unique identifier assigned by the acquiring network for the original authorization.',
    `batch_number` STRING COMMENT 'Identifier of the batch file that contains this clearing record.',
    `cleared_amount` DECIMAL(18,2) COMMENT 'Gross amount of the transaction cleared before fees.',
    `clearing_date` DATE COMMENT 'Calendar date on which the transaction was cleared.',
    `clearing_reference` STRING COMMENT 'External reference number assigned to the clearing record by the clearing system.',
    `clearing_status` STRING COMMENT 'Current processing status of the clearing record.. Valid values are `cleared|reversed|failed|pending`',
    `clearing_timestamp` TIMESTAMP COMMENT 'Exact time when the transaction was cleared in the processing platform.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the record required additional compliance review (e.g., AML, sanctions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearing record was first persisted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the transaction.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total interchange and processing fees applied to the cleared transaction.',
    `fraud_flag` BOOLEAN COMMENT 'True if the transaction was flagged as fraudulent during clearing.',
    `interchange_category` STRING COMMENT 'Category used to determine interchange fees for the transaction.. Valid values are `debit|credit|prepaid|commercial|private|government`',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether the clearing record represents a reversal transaction.',
    `issuing_bank_code` BIGINT COMMENT 'Identifier of the issuing bank that issued the payment instrument.',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount to be settled after deducting fees.',
    `original_authorization_code` STRING COMMENT 'Code returned by the issuer approving the original transaction.',
    `processing_country_code` STRING COMMENT 'Three‑letter country code where the clearing event was processed. [ENUM-REF-CANDIDATE: many values — promote to reference product]',
    `regulatory_reporting_indicator` STRING COMMENT 'Indicates the reporting requirement status for this clearing record.. Valid values are `required|optional|exempt`',
    `reversal_reason_code` STRING COMMENT 'Code describing why the transaction was reversed.. Valid values are `duplicate|customer_cancel|merchant_error|fraud|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the risk engine at clearing time.',
    `settlement_cycle` STRING COMMENT 'Frequency bucket used for net settlement processing.. Valid values are `daily|weekly|monthly|quarterly`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the clearing record.',
    CONSTRAINT pk_clearing_record PRIMARY KEY(`clearing_record_id`)
) COMMENT 'Individual cleared transaction record produced during the clearing phase — the post-authorization, pre-settlement representation of a payment transaction. Stores ARN (Acquirer Reference Number), original authorization code, MID, card scheme, interchange category, cleared amount, currency, clearing date, and clearing status. Bridges the transaction domain and the settlement domain. Sourced from the Transaction Processing Platform clearing module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` (
    `reconciliation_record_id` BIGINT COMMENT 'System-generated unique identifier for the reconciliation record.',
    `account_reconciliation_id` BIGINT COMMENT 'Foreign key linking to ledger.account_reconciliation. Business justification: Reconciliation records are tied to account reconciliation entries to close GL balances; essential for month‑end close.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Reconciliation must reconcile amounts in a standardized currency reference.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Reconciliation of settlement batches includes disputed transactions; a FK to the dispute case enables exception handling and audit.',
    `duplicate_of_record_reconciliation_record_id` BIGINT COMMENT 'Reference to the original reconciliation record when this record is a duplicate.',
    `event_log_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_event_log. Business justification: Regulatory audit requires linking each reconciliation record to the gateway event log that impacted it.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: Reconciliation records with fraud_flag must reference the associated fraud case to resolve exceptions and meet regulatory requirements.',
    `risk_profile_id` BIGINT COMMENT 'Identifier of the external party (e.g., acquiring bank, issuing bank, scheme) involved in the reconciliation.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle (e.g., daily, hourly) for this reconciliation.',
    `participant_id` BIGINT COMMENT 'Identifier of the external party (e.g., acquiring bank, issuing bank, scheme) involved in the reconciliation.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch associated with this reconciliation.',
    `aml_check_status` STRING COMMENT 'Anti‑Money‑Laundering screening result for the counterparty.. Valid values are `passed|failed|pending`',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Sum of fees, discounts, or other adjustments applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total gross amount before any adjustments or fees.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final net amount after adjustments, representing the amount to be settled.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Closing balance of the account or statement at the end of the reconciliation period.',
    `comment` STRING COMMENT 'Additional free‑form comment about the reconciliation.',
    `compliance_status` STRING COMMENT 'Compliance outcome of the reconciliation with respect to regulatory rules.. Valid values are `compliant|non_compliant|pending`',
    `counterpart_record_reference` STRING COMMENT 'Reference to the external record (e.g., bank statement, scheme file) matched against.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation event occurred.',
    `exception_code` STRING COMMENT 'Code categorising the type of exception, if any.. Valid values are `amount_mismatch|missing_record|duplicate|format_error`',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation was flagged for potential fraud.',
    `is_duplicate` BOOLEAN COMMENT 'True if this record is identified as a duplicate of another reconciliation record.',
    `is_exception` BOOLEAN COMMENT 'Indicates whether the reconciliation record required exception handling.',
    `kyc_status` STRING COMMENT 'Know‑Your‑Customer verification status of the counterparty.. Valid values are `verified|unverified|pending`',
    `last_reconciled_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful reconciliation for this record.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Opening balance of the account or statement at the start of the reconciliation period.',
    `processing_time_seconds` STRING COMMENT 'Total time taken to complete the reconciliation process, measured in seconds.',
    `reconciliation_method` STRING COMMENT 'Method used to perform the reconciliation.. Valid values are `automated|manual|semi_automated`',
    `reconciliation_record_status` STRING COMMENT 'Current processing status of the reconciliation record.. Valid values are `matched|unmatched|pending|error`',
    `reconciliation_reference` STRING COMMENT 'External or internal reference number for the reconciliation run (e.g., batch number, instruction ID).',
    `reconciliation_type` STRING COMMENT 'Category of reconciliation (batch, instruction, nostro statement, scheme file).. Valid values are `batch|instruction|nostro|scheme_file`',
    `record_version` STRING COMMENT 'Version number for optimistic concurrency control.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this reconciliation must be included in regulatory reporting.',
    `resolution_notes` STRING COMMENT 'Free‑form notes describing how variances were investigated and resolved.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score assigned to the reconciliation based on fraud or AML considerations.',
    `settlement_date` DATE COMMENT 'Date on which the settlement associated with this reconciliation was executed.',
    `source_file_name` STRING COMMENT 'Name of the external file (e.g., MT940, camt.053) used for reconciliation.',
    `source_record_reference` STRING COMMENT 'Reference to the internal settlement record used in the reconciliation.',
    `source_system` STRING COMMENT 'Originating operational system that produced the source record (e.g., Transaction Processing Platform).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between internal settlement amount and external counterpart amount.',
    `variance_reason` STRING COMMENT 'Explanation for any variance detected during reconciliation.',
    CONSTRAINT pk_reconciliation_record PRIMARY KEY(`reconciliation_record_id`)
) COMMENT 'Reconciliation entry matching internal settlement records against external counterparts — including bank statements, scheme clearing files, RTGS confirmations, and nostro/vostro account statements (SWIFT MT940/MT950, camt.053). Captures reconciliation run reference, reconciliation type (batch, instruction, nostro, scheme file), matched/unmatched status, variance amount, source record reference, counterpart record reference, opening and closing balances (for statement-level reconciliation), reconciliation method, and resolution notes. SSOT for all settlement reconciliation including nostro statement matching and break management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` (
    `settlement_account_id` BIGINT COMMENT 'Unique identifier for the settlement_account data product (auto-inserted pre-linking).',
    `merchant_settlement_account_id` BIGINT COMMENT 'System-generated unique identifier for the settlement account record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Account balances are maintained in a defined ISO currency for reporting and risk.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the party (acquirer, issuer, or scheme) that owns the settlement account.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Each settlement account must be linked to a GL account for journal entry creation; essential for financial statements.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: settlement_account currently has no in-domain relationship; adding settlement_id creates a many-to-one link to settlement, eliminating the silo and reflecting that each settlement account can be used ',
    `account_name` STRING COMMENT 'Descriptive name assigned to the settlement account for easy identification by business users.',
    `account_type` STRING COMMENT 'Indicates whether the account is a Nostro, Vostro, or internal settlement account.. Valid values are `nostro|vostro|settlement`',
    `available_balance` DECIMAL(18,2) COMMENT 'Portion of the balance that is free for settlement funding.',
    `bank_city` STRING COMMENT 'City in which the bank branch holding the settlement account is located.',
    `bank_country_code` STRING COMMENT 'Three‑letter ISO country code where the bank is located.',
    `bank_name` STRING COMMENT 'Legal name of the financial institution that holds the settlement account.',
    `bic` STRING COMMENT 'SWIFT code identifying the bank that holds the settlement account.',
    `close_date` DATE COMMENT 'Date the settlement account was closed or de‑commissioned; null if still active.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the settlement account.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement account record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum amount of credit that can be extended to the settlement account.',
    `current_balance` DECIMAL(18,2) COMMENT 'Current monetary balance of the settlement account.',
    `daily_funding_limit` DECIMAL(18,2) COMMENT 'Maximum total amount that can be funded from this account per day.',
    `daily_funding_reset_date` DATE COMMENT 'Date on which the daily funding usage counter resets to zero.',
    `daily_funding_used` DECIMAL(18,2) COMMENT 'Cumulative amount funded from the account on the current day.',
    `iban` STRING COMMENT 'Standardized international bank account number used for cross‑border settlements.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent settlement reconciliation for this account.',
    `nickname` STRING COMMENT 'User‑defined short name for the settlement account, used in UI displays.',
    `open_date` DATE COMMENT 'Date the settlement account was opened.',
    `owner_party_type` STRING COMMENT 'Indicates whether the account belongs to an acquiring bank, issuing bank, or payment scheme.. Valid values are `acquirer|issuer|scheme`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating calculated by the fraud and risk platform.',
    `rtgs_supported` BOOLEAN COMMENT 'Indicates whether the account can be used for Real‑Time Gross Settlement transfers.',
    `rtp_supported` BOOLEAN COMMENT 'Indicates whether the account can be used for Real‑Time Payments transfers.',
    `settlement_account_status` STRING COMMENT 'Current lifecycle status of the settlement account.. Valid values are `active|inactive|closed|suspended`',
    `settlement_cycle` STRING COMMENT 'Frequency at which the account participates in settlement runs.. Valid values are `daily|weekly|monthly|ad_hoc`',
    `settlement_method` STRING COMMENT 'Primary method used for moving funds to or from this settlement account.. Valid values are `RTGS|RTP|ACH|SWIFT|SEPA`',
    `status_effective_date` DATE COMMENT 'Date on which the current status became effective.',
    `status_reason` STRING COMMENT 'Free‑text explanation for why the account is in its current status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement account record.',
    CONSTRAINT pk_settlement_account PRIMARY KEY(`settlement_account_id`)
) COMMENT 'Master record of a settlement bank account used to fund or receive settlement obligations. Stores account holder (acquirer, issuer, or scheme), bank name, BIC, IBAN, account currency, account type (nostro, vostro, settlement), account status, credit limit, and current balance. SSOT for settlement account registry distinct from the general ledger account in the ledger domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` (
    `settlement_reserve_account_id` BIGINT COMMENT 'Unique system-generated identifier for the reserve account record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Reserve accounts hold funds in a specific currency; linking ensures correct valuation.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank or entity linked to the reserve.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant to which the reserve is attached.',
    `cycle_id` BIGINT COMMENT 'Reference to the settlement cycle governing this reserve account.',
    `participant_id` BIGINT COMMENT 'Identifier of the acquiring bank or entity linked to the reserve.',
    `aml_check_status` STRING COMMENT 'Result of the anti‑money‑laundering screening for the reserve account.. Valid values are `passed|failed|pending`',
    `available_balance` DECIMAL(18,2) COMMENT 'Portion of the reserve that has been released and is available for use.',
    `compliance_flag` STRING COMMENT 'Overall compliance status of the reserve account with internal policies.. Valid values are `compliant|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserve account record was first created in the system.',
    `current_balance` DECIMAL(18,2) COMMENT 'Current total amount held in the reserve account.',
    `effective_from` DATE COMMENT 'Date when the reserve agreement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the reserve agreement expires or is scheduled to terminate (nullable for open‑ended).',
    `held_amount` DECIMAL(18,2) COMMENT 'Principal amount currently held in the reserve account.',
    `last_release_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent reserve fund release.',
    `next_release_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the upcoming reserve fund release.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or operational comments.',
    `regulatory_reporting_flag` STRING COMMENT 'Indicates whether the reserve account is subject to mandatory regulatory reporting.. Valid values are `required|exempt`',
    `release_conditions` STRING COMMENT 'Business rules or triggers that allow reserve release (e.g., chargeback threshold met).',
    `release_interval` STRING COMMENT 'Scheduled frequency at which reserve funds may be released.. Valid values are `monthly|quarterly|annually|on_demand`',
    `reserve_account_number` STRING COMMENT 'External reference number assigned to the reserve account for reporting and reconciliation.',
    `reserve_cap_amount` DECIMAL(18,2) COMMENT 'Maximum monetary cap for a capped reserve type.',
    `reserve_name` STRING COMMENT 'Human‑readable name identifying the reserve account (e.g., "Merchant XYZ Rolling Reserve").',
    `reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction volume that must be retained as reserve.',
    `reserve_type` STRING COMMENT 'Classification of the reserve mechanism: rolling, capped, or fixed.. Valid values are `rolling|capped|fixed`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score indicating likelihood of reserve utilization.',
    `sanction_check_status` STRING COMMENT 'Result of sanctions screening for the reserve account.. Valid values are `passed|failed|pending`',
    `settlement_reserve_account_status` STRING COMMENT 'Current lifecycle status of the reserve account.. Valid values are `active|inactive|closed|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reserve account record.',
    CONSTRAINT pk_settlement_reserve_account PRIMARY KEY(`settlement_reserve_account_id`)
) COMMENT 'Rolling reserve or security deposit account held against a merchant or acquirer to cover potential chargebacks, fraud losses, or settlement shortfalls. Captures reserve type (rolling, capped, fixed), reserve percentage, held amount, currency, release schedule, release conditions, and current balance. SSOT for reserve obligations and release tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` (
    `reserve_movement_id` BIGINT COMMENT 'System-generated unique identifier for each reserve account movement record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Movement amounts must be expressed in a standardized currency for audit trails.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that owns the reserve account.',
    `merchant_reserve_account_id` BIGINT COMMENT 'Identifier of the reserve account impacted by the movement.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this reserve movement belongs.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch file that contains this movement, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount of the reserve movement in the transaction currency.',
    `authorization_reference` STRING COMMENT 'Reference identifier of the original authorization that led to this reserve movement.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the movement passed all applicable compliance checks (e.g., AML, sanctions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserve movement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the reserve movement becomes effective for balance calculations.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when converting the movement amount to a different currency.',
    `movement_type` STRING COMMENT 'Category of the reserve movement (e.g., hold, release, forfeit, adjustment).. Valid values are `hold|release|forfeit|adjustment`',
    `notes` STRING COMMENT 'Free‑form text for additional information or comments about the movement.',
    `original_amount` DECIMAL(18,2) COMMENT 'Original movement amount before currency conversion.',
    `original_currency` STRING COMMENT 'Currency code of the original amount prior to conversion.. Valid values are `^[A-Z]{3}$`',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the movement was posted to the reserve account.',
    `reserve_movement_description` STRING COMMENT 'Human‑readable description of the reserve movement purpose.',
    `reserve_movement_status` STRING COMMENT 'Current processing status of the reserve movement.. Valid values are `pending|posted|reversed|failed`',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score associated with the movement, used for fraud and compliance monitoring.',
    `source_system` STRING COMMENT 'Name of the operational system that originated the reserve movement (e.g., Transaction Processing Platform).',
    `triggering_event` STRING COMMENT 'Business event that caused the reserve movement.. Valid values are `chargeback|fraud_loss|scheduled_release|settlement|adjustment`',
    `updated_by` STRING COMMENT 'User or system that last updated the reserve movement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reserve movement record.',
    `created_by` STRING COMMENT 'User or system that created the reserve movement record.',
    CONSTRAINT pk_reserve_movement PRIMARY KEY(`reserve_movement_id`)
) COMMENT 'Transactional record of every debit or credit to a reserve account — including reserve holds, releases, forfeitures, and adjustments. Captures movement type, amount, currency, effective date, triggering event (chargeback, fraud loss, scheduled release), and authorization reference. Provides full audit trail for reserve account balances.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` (
    `funding_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the funding schedule record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Funding schedules are defined per currency to apply correct limits and fees.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Funding schedules debit/credit specific GL accounts; linking ensures correct posting of funding transactions.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant (or sub‑acquirer) that receives the funding.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this funding schedule is linked.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch that generated the funding instruction.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the schedule complies with all applicable regulatory checks (true = compliant).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `deduction_sequence` STRING COMMENT 'Ordered list of deductions applied to the gross amount (e.g., MDR, interchange, chargebacks, reserves).',
    `effective_end_date` DATE COMMENT 'Date on which the schedule expires or is retired (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the schedule becomes effective.',
    `funding_bank_account` STRING COMMENT 'Bank account number (masked) where funds are deposited.',
    `funding_bank_account_name` STRING COMMENT 'Name of the account holder for the funding destination.',
    `funding_bank_bic` STRING COMMENT 'SWIFT BIC of the destination bank.. Valid values are `^[A-Z0-9]{8,11}$`',
    `funding_bank_iban` STRING COMMENT 'IBAN used for cross‑border funding where applicable.. Valid values are `^[A-Z0-9]{15,34}$`',
    `funding_method` STRING COMMENT 'Method used to transfer funds to the payee (ACH, wire, RTP, SEPA).. Valid values are `ach|wire|rtp|sepa`',
    `funding_schedule_description` STRING COMMENT 'Optional narrative describing special rules or notes for the schedule.',
    `funding_schedule_status` STRING COMMENT 'Current operational status of the schedule.. Valid values are `active|inactive|pending|suspended|closed`',
    `hold_period_days` STRING COMMENT 'Number of days to hold settled proceeds before they become eligible for funding.',
    `is_cross_border` BOOLEAN COMMENT 'True if the funding involves cross‑border transfers that may incur additional fees or controls.',
    `last_run_status` STRING COMMENT 'Result of the most recent funding run.. Valid values are `success|failure|partial`',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule was last executed.',
    `minimum_funding_threshold` DECIMAL(18,2) COMMENT 'Minimum net proceeds required before a funding run is triggered.',
    `next_run_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next funding execution.',
    `priority` STRING COMMENT 'Numeric priority used when multiple schedules compete for the same funds (lower number = higher priority).',
    `region_code` STRING COMMENT 'Three‑letter code indicating the geographic region for regulatory or reporting purposes.. Valid values are `^[A-Z]{3}$`',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk rating (0‑100) for the schedule based on AML, fraud, and sanction checks.',
    `schedule_code` STRING COMMENT 'Business-visible code used to reference the funding schedule in external systems and reports.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the purpose or configuration of the schedule.',
    `schedule_type` STRING COMMENT 'Classification of the schedule frequency or timing rule (e.g., daily, weekly, T+1).. Valid values are `daily|weekly|monthly|t+1|t+2|t+n`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule record.',
    CONSTRAINT pk_funding_schedule PRIMARY KEY(`funding_schedule_id`)
) COMMENT 'Master schedule defining when and how merchants, sub-acquirers, or PayFacs are funded from settled proceeds. Stores funding frequency (daily, weekly, T+1, T+2, T+n), funding method (ACH, wire, RTP, SEPA), funding bank account reference, minimum funding threshold, hold period, deduction sequence (MDR, interchange, scheme fees, chargebacks, reserves), and schedule status. SSOT for merchant funding timing, payout configuration, and settlement-to-payout waterfall rules.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` (
    `merchant_payout_id` BIGINT COMMENT 'System-generated unique identifier for the merchant payout record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Payouts are issued in a specific currency; reference ensures correct conversion and reporting.',
    `funding_schedule_id` BIGINT COMMENT 'Identifier of the funding schedule applied to this payout.',
    `merchant_id` BIGINT COMMENT 'FK to merchant.merchant.merchant_id — MUST-HAVE: Enables tracing merchant payouts to the merchant entity — essential for merchant settlement reporting and funding reconciliation.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle associated with this payout.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch containing this payout.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Total chargeback adjustments deducted.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the payout passed all compliance checks.',
    `external_reference` STRING COMMENT 'Reference identifier from external payment network or partner.',
    `funding_account_number` STRING COMMENT 'Bank account number to which funds are transferred.',
    `funding_account_type` STRING COMMENT 'Type of the funding bank account.. Valid values are `checking|savings|corporate`',
    `interchange_fee_amount` DECIMAL(18,2) COMMENT 'Interchange fee deducted from the gross payout.',
    `mdr_amount` DECIMAL(18,2) COMMENT 'MDR fee deducted from the gross payout.',
    `merchant_mid` STRING COMMENT 'Merchant Identification Number of the receiving merchant.',
    `msf_amount` DECIMAL(18,2) COMMENT 'MSF fee deducted from the gross payout.',
    `net_payout_amount` DECIMAL(18,2) COMMENT 'Net amount transferred to the merchant after all deductions.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the payout.',
    `party_reference` BIGINT COMMENT 'Reference to the merchant party receiving the payout.',
    `payout_amount` DECIMAL(18,2) COMMENT 'Total gross amount before any deductions.',
    `payout_method` STRING COMMENT 'Method used to transfer the payout funds.. Valid values are `ach|wire|rtgs|rtp|internal`',
    `payout_reference` STRING COMMENT 'Unique reference code assigned to the payout transaction by the system.',
    `payout_status` STRING COMMENT 'Current processing status of the payout.. Valid values are `pending|released|on_hold|paid|failed`',
    `payout_timestamp` TIMESTAMP COMMENT 'Timestamp when the payout was initiated.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the payout record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp when the payout record was last updated.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total refunds deducted from the payout.',
    `reserve_hold_amount` DECIMAL(18,2) COMMENT 'Amount held in reserve and not released.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score assigned to the payout based on fraud detection models.',
    `scheme_fee_amount` DECIMAL(18,2) COMMENT 'Card scheme fee deducted from the gross payout.',
    `value_date` DATE COMMENT 'Date on which the payout amount is to be settled.',
    CONSTRAINT pk_merchant_payout PRIMARY KEY(`merchant_payout_id`)
) COMMENT 'Individual payout disbursement record representing the net funds transferred to a merchant or sub-merchant after applying the funding schedule waterfall — deducting MDR, MSF, interchange fees, scheme fees, chargebacks, refunds, and reserve holds from settled transaction proceeds. Captures payout reference, merchant MID, payout amount, currency, line-item deduction breakdown, funding account, payout status (pending, released, on-hold, paid, failed), value date, and remittance advice reference. SSOT for merchant settlement payouts and funding audit trail.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` (
    `interchange_settlement_id` BIGINT COMMENT 'System-generated unique identifier for the interchange settlement record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Interchange amounts are settled per currency; linking supports aggregation and compliance.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank involved in the interchange fee settlement.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Interchange settlements are accounted to GL accounts; direct FK supports automated posting and reporting.',
    `issuing_bank_id` BIGINT COMMENT 'Identifier of the issuing bank that receives the interchange fee.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Interchange settlement calculations depend on the payment product characteristics (e.g., card vs digital wallet) for interchange qualification and fee rates.',
    `reversal_of_settlement_interchange_settlement_id` BIGINT COMMENT 'Identifier of the original settlement that this record reverses.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this interchange settlement belongs.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch that groups this settlement record.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments (e.g., discounts, rebates) applied to the gross interchange fee.',
    `aml_check_status` STRING COMMENT 'Result of anti‑money‑laundering screening for the settlement.. Valid values are `passed|failed|not_applicable`',
    `bin_range` STRING COMMENT 'Bank Identification Number range (6‑8 digits) applicable to the interchange transaction.. Valid values are `^d{6,8}$`',
    `compliance_flag` STRING COMMENT 'Indicates whether the settlement meets regulatory compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system.',
    `cross_border_indicator` BOOLEAN COMMENT 'True if the settlement involves cross‑border transactions.',
    `effective_date` DATE COMMENT 'Date when the settlement becomes effective.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when settlement currency differs from transaction currency.',
    `expiry_date` DATE COMMENT 'Date when the settlement record expires or is superseded, if applicable.',
    `file_name` STRING COMMENT 'Name of the interchange file received from the card scheme.',
    `interchange_amount` DECIMAL(18,2) COMMENT 'Gross interchange fee amount before any adjustments.',
    `interchange_rate` DECIMAL(18,2) COMMENT 'Rate applied to calculate the interchange fee (percentage expressed as decimal).',
    `interchange_settlement_status` STRING COMMENT 'Current lifecycle status of the interchange settlement.. Valid values are `pending|posted|rejected|reversed|adjusted`',
    `is_reversal` BOOLEAN COMMENT 'True if this record represents a reversal of a prior settlement.',
    `mcc_code` STRING COMMENT 'Four‑digit code representing the merchant category for the settled transactions.. Valid values are `^d{4}$`',
    `net_interchange_amount` DECIMAL(18,2) COMMENT 'Net interchange fee after adjustments.',
    `net_position_amount` DECIMAL(18,2) COMMENT 'Net position amount for the settlement after all debits and credits.',
    `net_position_currency` STRING COMMENT 'Currency of the net position amount.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form notes or comments added by operations staff.',
    `processing_status` STRING COMMENT 'Current processing state of the settlement record.. Valid values are `processed|failed|queued`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the settlement has been included in regulatory reports.',
    `reserve_account_number` STRING COMMENT 'Account number used to hold reserve funds for the settlement.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score assigned to the settlement based on fraud and compliance models.',
    `sanction_check_status` STRING COMMENT 'Result of sanctions screening for the settlement.. Valid values are `passed|failed|not_applicable`',
    `scheme_code` STRING COMMENT 'Code of the card scheme (e.g., Visa, Mastercard) for which the interchange is settled.. Valid values are `visa|mastercard|discover|amex`',
    `settlement_method` STRING COMMENT 'Method used to transfer funds for the settlement.. Valid values are `rtgs|rtp|ach|wire`',
    `settlement_reference` STRING COMMENT 'External reference number assigned by the card scheme for this interchange settlement.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the interchange settlement was posted.',
    `source_system` STRING COMMENT 'Originating system that generated the settlement record.. Valid values are `transaction_processing|settlement_system|other`',
    `total_transaction_amount` DECIMAL(18,2) COMMENT 'Aggregate amount of all underlying transactions in the settlement.',
    `transaction_count` STRING COMMENT 'Number of individual transactions covered by this interchange settlement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    CONSTRAINT pk_interchange_settlement PRIMARY KEY(`interchange_settlement_id`)
) COMMENT 'Settlement record for interchange reimbursement fees (IRF) exchanged between acquiring and issuing banks via card schemes. Captures interchange file reference, scheme (Visa, Mastercard), BIN range, MCC, interchange rate applied, interchange amount, currency, settlement cycle reference, and scheme confirmation. Sourced from the Transaction Processing Platform and cross-references the interchange domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` (
    `scheme_fee_settlement_id` BIGINT COMMENT 'System-generated unique identifier for each scheme fee settlement record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Scheme fees are calculated in a defined currency; reference enables consistent reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal identifier of the acquiring bank receiving the settlement.',
    `funding_schedule_id` BIGINT COMMENT 'Reference to the funding schedule used for the settlement.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Scheme fee settlements need GL account mapping for fee revenue recognition and reporting.',
    `issuing_bank_id` BIGINT COMMENT 'FK to settlement.issuing_bank',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant whose acquiring bank is settling the fee.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Scheme fee settlements need the originating payment product to attribute fees accurately and meet scheme‑level regulatory reporting.',
    `participant_id` BIGINT COMMENT 'Internal identifier of the acquiring bank receiving the settlement.',
    `cycle_id` BIGINT COMMENT 'Reference to the settlement cycle governing this fee.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this fee.',
    `billing_period_end` DATE COMMENT 'Last day of the billing period for which the fee applies.',
    `billing_period_start` DATE COMMENT 'First day of the billing period for which the fee applies.',
    `compliance_status` STRING COMMENT 'Current compliance verification status of the settlement.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system.',
    `due_date` DATE COMMENT 'Date by which the fee must be paid to avoid penalties.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate applied when converting the fee to the settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Gross amount billed by the scheme before any adjustments or taxes.',
    `fee_category` STRING COMMENT 'Classification of the scheme fee (assessment, network access, cross‑border, etc.).. Valid values are `assessment|network_access|cross_border|other`',
    `fee_currency_conversion_indicator` BOOLEAN COMMENT 'True if the fee amount was converted from the original currency.',
    `fee_description` STRING COMMENT 'Human‑readable description of the fee purpose.',
    `fee_invoice_number` STRING COMMENT 'External invoice reference number issued by the card scheme for the fee.',
    `fee_type` STRING COMMENT 'Indicates whether the fee is a fixed amount or a percentage of transaction volume.. Valid values are `fixed|percentage`',
    `is_cross_border` BOOLEAN COMMENT 'True when the fee relates to cross‑border transaction processing.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the settlement record.. Valid values are `draft|open|closed|reversed|cancelled`',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount after tax and any discounts, expressed in settlement currency.',
    `net_position_amount` DECIMAL(18,2) COMMENT 'Net position amount after applying this fee.',
    `net_position_currency` STRING COMMENT 'Currency of the net position amount.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the settlement.',
    `original_currency_code` STRING COMMENT 'Currency of the original fee amount.',
    `original_fee_amount` DECIMAL(18,2) COMMENT 'Original fee amount before any adjustments or currency conversion.',
    `payment_status` STRING COMMENT 'Indicates whether the fee has been paid to the scheme.. Valid values are `unpaid|paid|partial`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this settlement must be reported to regulators.',
    `reserve_account_number` STRING COMMENT 'Account number of the reserve account used for net settlement.',
    `scheme_code` STRING COMMENT 'Identifier of the card scheme charging the fee (e.g., VISA, MASTERCARD).. Valid values are `VISA|MASTERCARD|OTHER`',
    `settlement_date` DATE COMMENT 'Date on which the fee settlement was executed.',
    `settlement_method` STRING COMMENT 'Mechanism used to transfer funds for the fee settlement.. Valid values are `RTGS|RTP|ACH|SWIFT|OTHER`',
    `settlement_status` STRING COMMENT 'Current processing status of the settlement record.. Valid values are `pending|settled|failed|reversed`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the settlement transaction was executed.',
    `source_system` STRING COMMENT 'Name of the operational system that originated the record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the fee, if applicable.',
    `transaction_reference_number` STRING COMMENT 'Reference (e.g., ARN) linking the fee to the underlying transaction batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    CONSTRAINT pk_scheme_fee_settlement PRIMARY KEY(`scheme_fee_settlement_id`)
) COMMENT 'Settlement record for card scheme fees (assessment fees, network access fees, cross-border fees) billed by Visa, Mastercard, or other schemes to the acquirer. Captures scheme fee invoice reference, fee category, fee amount, currency, billing period, scheme, and payment status. Distinct from interchange — these are scheme-to-acquirer fees, not issuer-to-acquirer fees.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` (
    `settlement_exception_id` BIGINT COMMENT 'Unique system-generated identifier for the settlement exception record.',
    `instruction_id` BIGINT COMMENT 'Identifier of the specific settlement instruction linked to the exception.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Exceptions must record the currency of the affected amount for audit and remediation.',
    `employee_id` BIGINT COMMENT 'Internal user identifier of the analyst or operator who resolved the exception.',
    `net_position_id` BIGINT COMMENT 'Reference to the net position record impacted by the exception.',
    `resolved_by_user_employee_id` BIGINT COMMENT 'Internal user identifier of the analyst or operator who resolved the exception.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch where the exception originated.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle during which the exception occurred.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the exception (e.g., shortfall amount).',
    `compliance_flag` BOOLEAN COMMENT 'True if the exception triggered compliance checks (e.g., AML, sanctions).',
    `corrective_action` STRING COMMENT 'Description of the action taken to remediate the exception.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was created in the data lake.',
    `error_code` STRING COMMENT 'Technical error code returned by the processing engine.',
    `error_message` STRING COMMENT 'Human‑readable error description associated with the exception.',
    `exception_code` STRING COMMENT 'Business identifier code assigned to the exception for tracking and reference.',
    `exception_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was first detected in the settlement process.',
    `exception_type` STRING COMMENT 'Category of the settlement exception indicating the nature of the break.. Valid values are `unmatched_record|funding_shortfall|rejected_instruction|reconciliation_variance`',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether a human manually intervened to resolve the exception.',
    `notes` STRING COMMENT 'Free‑form notes captured by the resolver for additional context.',
    `original_amount` DECIMAL(18,2) COMMENT 'The original transaction amount before the exception was identified.',
    `original_currency_code` STRING COMMENT 'Currency of the original transaction amount.. Valid values are `^[A-Z]{3}$`',
    `regulatory_flag` BOOLEAN COMMENT 'True if the exception has regulatory reporting or compliance implications.',
    `resolution_status` STRING COMMENT 'Outcome of the resolution attempt.. Valid values are `pending|completed|failed`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was marked as resolved.',
    `retry_attempts` STRING COMMENT 'Number of automated retry attempts performed before escalation.',
    `root_cause_code` STRING COMMENT 'Standardized code representing the underlying cause of the exception. [ENUM-REF-CANDIDATE: data_mismatch|validation_error|network_failure|partner_error|regulatory_hold — promote to reference product]',
    `settlement_exception_status` STRING COMMENT 'Current lifecycle status of the exception.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `severity` STRING COMMENT 'Business-assigned severity level reflecting impact on settlement operations.. Valid values are `low|medium|high|critical`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the exception breached its Service Level Agreement target.',
    `sla_target_hours` STRING COMMENT 'Maximum allowed hours to resolve the exception as defined by SLA.',
    `source_system` STRING COMMENT 'Originating operational system that generated the exception record.. Valid values are `transaction_processing|risk_compliance|dispute|digital_wallet|merchant_management`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the exception record.',
    CONSTRAINT pk_settlement_exception PRIMARY KEY(`settlement_exception_id`)
) COMMENT 'Operational record of any exception, break, or failure arising during the settlement lifecycle — including unmatched clearing records, funding shortfalls, rejected instructions, and reconciliation variances. Captures exception type, severity, affected batch or instruction reference, exception amount, assigned resolver, resolution status, and SLA breach flag. SSOT for settlement break management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`file` (
    `file_id` BIGINT COMMENT 'Primary key for file',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: File metadata includes total amount currency; reference ensures uniform currency handling.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this file belongs.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch processing run that produced the file.',
    `acknowledgment_reference` STRING COMMENT 'Reference returned by the receiving party confirming receipt or rejection of the file.',
    `checksum` STRING COMMENT 'Hash (e.g., SHA‑256) used to verify file integrity during transfer.',
    `compliance_status` STRING COMMENT 'Result of compliance checks (AML, sanctions, PCI) performed on the file.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement file record was first inserted into the lakehouse.',
    `encryption_method` STRING COMMENT 'Algorithm or protocol used for encryption (e.g., AES‑256).',
    `error_code` STRING COMMENT 'Standardized code identifying a processing or transmission error, if any.',
    `error_description` STRING COMMENT 'Human‑readable description of the error associated with error_code.',
    `external_file_reference` STRING COMMENT 'Business-visible reference number assigned by the originating network or partner (e.g., Visa BASE II file reference).',
    `file_category` STRING COMMENT 'Indicates whether the file is generated by the firm (outbound) or received from a partner/network (inbound).. Valid values are `outbound|inbound`',
    `file_description` STRING COMMENT 'Free‑form text providing additional context or notes about the file.',
    `file_name` STRING COMMENT 'The name of the settlement file as stored in the lakehouse, including extension.',
    `file_type` STRING COMMENT 'Standardized type of settlement file based on the messaging format or network.. Valid values are `visa_base2|mastercard_ipm|ach_nacha|swift_mt940|swift_mt950`',
    `format` STRING COMMENT 'Technical format used to encode the file contents.. Valid values are `fixed_width|csv|xml|json`',
    `generation_timestamp` TIMESTAMP COMMENT 'Date‑time when the file was created or assembled by the source system.',
    `is_encrypted` BOOLEAN COMMENT 'True if the file content is encrypted at rest or in transit.',
    `originating_system` STRING COMMENT 'Source system that produced or received the settlement file (e.g., Transaction Processing Platform).',
    `processing_status` STRING COMMENT 'Internal processing state of the file within the settlement pipeline.. Valid values are `queued|processing|completed|error`',
    `record_count` BIGINT COMMENT 'Total number of transaction records contained in the file.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the file is subject to regulatory reporting (e.g., SAR, AML).',
    `retention_expiry_date` DATE COMMENT 'Date after which the file may be archived or purged per data retention policy.',
    `size_bytes` BIGINT COMMENT 'Size of the file in bytes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of all transactions in the file.',
    `transmission_status` STRING COMMENT 'Current state of the files transmission to the downstream network or partner.. Valid values are `pending|sent|failed|acknowledged|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement file record.',
    `version` STRING COMMENT 'Version number of the file format or schema, incremented on changes.',
    CONSTRAINT pk_file PRIMARY KEY(`file_id`)
) COMMENT 'Master record of each settlement file generated or received — including Visa BASE II, Mastercard IPM, ACH NACHA files, and SWIFT MT940/MT950 statements. Captures file name, file type, originating system, file format standard, record count, total amount, generation timestamp, transmission status, and acknowledgment reference. Sourced from the Transaction Processing Platform batch processing module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`participant` (
    `participant_id` BIGINT COMMENT 'Primary key for participant',
    `appetite_framework_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite_framework. Business justification: Each settlement participant is governed by a risk appetite framework that defines exposure limits and tolerances.',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to fx.correspondent_bank. Business justification: REQUIRED: Participants (banks) maintain correspondent banking relationships for cross‑border routing; needed for compliance and settlement routing decisions.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Participants settle in a designated currency; linking supports settlement routing and reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Required for partner-level settlement reporting and revenue sharing; each settlement participant represents a partner entity.',
    `exposure_limit_id` BIGINT COMMENT 'Foreign key linking to risk.exposure_limit. Business justification: Exposure limits per participant are tracked to enforce credit and concentration caps during settlement.',
    `scheme_membership_id` BIGINT COMMENT 'Identifier assigned by card scheme (e.g., Visa, Mastercard).',
    `underwriting_policy_id` BIGINT COMMENT 'Foreign key linking to risk.underwriting_policy. Business justification: Underwriting policies are applied to participants (e.g., merchants) to set transaction limits and reserve rates.',
    `address_line1` STRING COMMENT 'Primary street address of participant.',
    `address_line2` STRING COMMENT 'Secondary address information.',
    `aml_check_status` STRING COMMENT 'Result of AML screening for participant.. Valid values are `passed|failed|pending`',
    `bic_code` STRING COMMENT 'SWIFT BIC code identifying the participants bank.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `city` STRING COMMENT 'City of participants address.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if participant is currently compliant with regulatory requirements.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where participant is based.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when participant record was created.',
    `cross_border_settlement_flag` BOOLEAN COMMENT 'Indicates ability to settle cross-border transactions.',
    `data_classification` STRING COMMENT 'Classification level of participant data.. Valid values are `restricted|confidential|internal|public`',
    `effective_end_date` DATE COMMENT 'Date when participant ceased participation (null if active).',
    `effective_start_date` DATE COMMENT 'Date when participant became effective in settlement network.',
    `fee_currency_code` STRING COMMENT 'Currency of settlement fee.. Valid values are `^[A-Z]{3}$`',
    `is_reserve_account_flag` BOOLEAN COMMENT 'Indicates if participant holds a reserve account for settlement.',
    `last_aml_review_timestamp` TIMESTAMP COMMENT 'Timestamp of most recent AML review.',
    `last_sanction_review_timestamp` TIMESTAMP COMMENT 'Timestamp of most recent sanctions review.',
    `netting_allowed_flag` BOOLEAN COMMENT 'Indicates if participant allows netting of settlement positions.',
    `notes` STRING COMMENT 'Free-text notes regarding participant.',
    `participant_name` STRING COMMENT 'Full legal name of the participant (e.g., acquiring bank, issuing bank, PSP).',
    `participant_status` STRING COMMENT 'Current operational status of the participant.. Valid values are `active|inactive|suspended|pending`',
    `participant_type` STRING COMMENT 'Category of participant in the settlement network.. Valid values are `acquirer|issuer|card_scheme|psp|payfac`',
    `postal_code` STRING COMMENT 'Postal/ZIP code of participants address.',
    `primary_contact_email` STRING COMMENT 'Email address for primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the participant.',
    `primary_contact_phone` STRING COMMENT 'Phone number for primary contact.',
    `reference_code` STRING COMMENT 'Identifier used by external systems (e.g., partner system).',
    `region_state` STRING COMMENT 'State or region of participants address.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if participant is subject to specific regulatory reporting.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score for participant (e.g., AML, fraud).',
    `routing_number` STRING COMMENT 'Domestic routing number (e.g., ABA) for settlement.',
    `sanction_check_status` STRING COMMENT 'Result of sanctions screening.. Valid values are `passed|failed|pending`',
    `settlement_account_iban` STRING COMMENT 'International Bank Account Number for settlement.',
    `settlement_account_number` STRING COMMENT 'Bank account number used for settlement transfers.',
    `settlement_cycle_preference` STRING COMMENT 'Preferred frequency of settlement cycles.. Valid values are `daily|weekly|monthly|ad_hoc`',
    `settlement_fee_rate` DECIMAL(18,2) COMMENT 'Fee rate applied to settlement transactions (percentage).',
    `settlement_rail_capability` STRING COMMENT 'Rail(s) the participant can use for settlement.. Valid values are `rtgs|rtp|ach|swift|sepa`',
    `settlement_window` STRING COMMENT 'Preferred time window for settlement processing.. Valid values are `morning|afternoon|evening|any`',
    `source_system` STRING COMMENT 'System of record where participant data originated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to participant record.',
    CONSTRAINT pk_participant PRIMARY KEY(`participant_id`)
) COMMENT 'Master registry of all entities participating in the settlement network for this platform — acquiring banks, issuing banks, card schemes, PSPs, and PayFacs. Captures participant type, BIC/routing number, settlement account references, participation status, scheme membership IDs, and settlement rail capabilities. Distinct from the partner domain master — this is the settlement-specific participation record.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` (
    `applied_rate_id` BIGINT COMMENT 'Primary key for applied_rate',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Applied rates are tied to a currency for correct FX application.',
    `settlement_id` BIGINT COMMENT 'Reference to the settlement record that consumed this rate.',
    `transaction_id` BIGINT COMMENT 'Reference to the original transaction for which the rate was applied.',
    `applied_rate_description` STRING COMMENT 'Optional free‑form text providing context or remarks about the rate.',
    `applied_rate_status` STRING COMMENT 'Operational status of the rate record within the system.. Valid values are `active|inactive|deprecated|pending|archived`',
    `applied_timestamp` TIMESTAMP COMMENT 'Exact moment the rate was locked and used in a settlement transaction.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the rate against internal and external policies.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the applied rate record was inserted into the lakehouse.',
    `currency_pair` STRING COMMENT 'ISO 4217 formatted currency pair (e.g., USD/EUR) for which the rate is applicable.. Valid values are `^[A-Z]{3}/[A-Z]{3}$`',
    `effective_timestamp` TIMESTAMP COMMENT 'Date‑time when the rate started to be valid for settlement calculations.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time after which the rate must no longer be used for settlements.',
    `is_cross_border` BOOLEAN COMMENT 'True when the underlying transaction involves different currency jurisdictions.',
    `rate_precision` STRING COMMENT 'Number of decimal places stored for the rate value.',
    `rate_source` STRING COMMENT 'Origin of the rate, e.g., European Central Bank, Visa, Mastercard, internal pricing engine, or other.. Valid values are `ECB|Visa|Mastercard|Internal|Other`',
    `rate_type` STRING COMMENT 'Category of the rate such as spot, mid‑market, scheme‑provided, or custom.. Valid values are `spot|mid_market|scheme|custom`',
    `rate_value` DECIMAL(18,2) COMMENT 'The actual exchange rate applied, expressed with up to 9 decimal places.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the rate must be reported to regulatory bodies (e.g., FCA, ECB).',
    `source_system` STRING COMMENT 'Technical name of the upstream system providing the rate (e.g., fx_feed_service).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the rate record.',
    CONSTRAINT pk_applied_rate PRIMARY KEY(`applied_rate_id`)
) COMMENT 'FX rate snapshot applied at settlement time for cross-border and multi-currency transactions. Captures rate type (spot, mid-market, scheme rate), currency pair, rate value, rate source (ECB, Visa, Mastercard, internal), effective timestamp, and expiry timestamp. Distinct from the fx domain rate feed — this is the rate-as-applied record locked at settlement for audit and reconciliation purposes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Primary key for adjustment',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Adjustments adjust amounts in a specific currency; reference ensures accurate ledger entries.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Adjustments arising from dispute outcomes need a FK to the dispute case to satisfy audit and compliance requirements.',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement record that is being adjusted.',
    `related_adjustment_id` BIGINT COMMENT 'Identifier of a preceding adjustment that this record reverses or amends.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this adjustment belongs.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch file that contains the original settlement.',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Monetary amount applied by the adjustment (positive for credit, negative for debit).',
    `adjustment_status` STRING COMMENT 'Current processing state of the adjustment.. Valid values are `pending|approved|rejected|reversed`',
    `adjustment_type` STRING COMMENT 'Indicates whether the adjustment adds to (credit) or subtracts from (debit) the settled amount.. Valid values are `debit|credit`',
    `approval_reference` STRING COMMENT 'Internal reference to the approval workflow or ticket that authorized the adjustment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Exact time when the adjustment was approved.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the adjustment has passed all regulatory compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the adjustment becomes effective for accounting and reporting.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Conversion rate applied if the adjustment involves a currency exchange.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee component associated with the adjustment, if any.',
    `fee_currency` STRING COMMENT 'Currency of the fee amount.. Valid values are `^[A-Z]{3}$`',
    `identifier` STRING COMMENT 'Human‑readable unique code assigned to the adjustment (e.g., ADJ‑20230915‑001).',
    `notes` STRING COMMENT 'Free‑form comments or justification for the adjustment.',
    `original_amount` DECIMAL(18,2) COMMENT 'The settled amount before the adjustment was applied.',
    `original_currency` STRING COMMENT 'Currency of the original settled amount.. Valid values are `^[A-Z]{3}$`',
    `reason_code` STRING COMMENT 'Standardized code describing why the adjustment was made.. Valid values are `error_correction|late_presentment|fee_credit|scheme_correction|reversal|other`',
    `reversal_indicator` BOOLEAN COMMENT 'True if this adjustment represents a reversal of a prior adjustment.',
    `risk_score` STRING COMMENT 'Numeric risk rating assigned to the adjustment based on fraud/risk models.',
    `sequence` STRING COMMENT 'Ordinal number of the adjustment within the same settlement batch.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the adjustment (e.g., Transaction Processing Platform).',
    `updated_by` STRING COMMENT 'User identifier of the person or service that last modified the adjustment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjustment record.',
    `created_by` STRING COMMENT 'User identifier of the person or service that created the adjustment.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Record of post-settlement adjustments applied to correct errors, process late presentments, apply fee credits, or handle scheme-mandated corrections. Captures adjustment type (debit, credit), adjustment reason code, original settlement reference, adjusted amount, currency, approval reference, and effective date. Provides full audit trail for settlement corrections.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` (
    `nostro_reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for the nostro reconciliation record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Nostro reconciliation tracks balances per currency; linking standardizes reporting.',
    `net_position_id` BIGINT COMMENT 'Identifier of the net position record used for net settlement calculations.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: REQUIRED: Reconciliation of nostro balances needs a direct link to the specific nostro account to match statements and balances.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this reconciliation belongs.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch associated with the reconciliation.',
    `adjustment_reason` STRING COMMENT 'Explanation for any manual adjustments applied during reconciliation.',
    `aml_check_status` STRING COMMENT 'Result of anti‑money‑laundering screening for the statement entries.. Valid values are `passed|failed|pending`',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance of the nostro account at the end of the statement period.',
    `compliance_status` STRING COMMENT 'Result of compliance checks performed on the reconciliation.. Valid values are `compliant|non_compliant|exception`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the reconciliation record is considered effective for reporting.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied if the statement currency differs from the reporting currency.',
    `exchange_rate_timestamp` TIMESTAMP COMMENT 'Timestamp when the exchange rate was sourced.',
    `expiry_date` DATE COMMENT 'Optional date after which the reconciliation record is archived or superseded.',
    `is_cross_border` BOOLEAN COMMENT 'True if the reconciliation involves cross‑border currency movements.',
    `matched_credit_amount` DECIMAL(18,2) COMMENT 'Total credit amount that successfully matched between internal ledger and statement.',
    `matched_debit_amount` DECIMAL(18,2) COMMENT 'Total debit amount that successfully matched between internal ledger and statement.',
    `matched_entries_count` BIGINT COMMENT 'Number of ledger entries that matched the bank statement.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the reconciliation analyst.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the nostro account at the start of the statement period.',
    `processing_status` STRING COMMENT 'Current processing state of the reconciliation job.. Valid values are `completed|failed|in_progress|queued`',
    `reconciliation_number` STRING COMMENT 'Unique business identifier assigned to each reconciliation run.',
    `reconciliation_status` STRING COMMENT 'Overall outcome of the reconciliation process.. Valid values are `matched|partial|unmatched|error|pending`',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Date‑time when the reconciliation was executed.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation must be included in regulatory filings.',
    `related_statement_file_name` STRING COMMENT 'File name of the imported bank statement (e.g., MT940_20240430.txt).',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk rating assigned to the reconciliation based on AML/CTF rules.',
    `sanction_check_status` STRING COMMENT 'Result of sanctions list screening for the statement entries.. Valid values are `passed|failed|pending`',
    `source_system` STRING COMMENT 'Originating system that supplied the statement data.. Valid values are `gateway|processing|fraud|wallet|compliance`',
    `statement_checksum` STRING COMMENT 'Hash of the statement file to ensure data integrity.',
    `statement_date` DATE COMMENT 'Date of the bank statement used for reconciliation.',
    `statement_reference` STRING COMMENT 'Reference identifier from the bank statement (e.g., MT940 reference).',
    `total_fee_amount` DECIMAL(18,2) COMMENT 'Sum of fees charged on the statement (e.g., interchange, processing fees).',
    `total_transaction_amount` DECIMAL(18,2) COMMENT 'Aggregate gross amount of all transactions represented in the statement.',
    `unmatched_credit_amount` DECIMAL(18,2) COMMENT 'Total credit amount from the statement that could not be matched to internal entries.',
    `unmatched_debit_amount` DECIMAL(18,2) COMMENT 'Total debit amount from the statement that could not be matched to internal entries.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    `version_number` STRING COMMENT 'Sequential version of the reconciliation record for audit trail.',
    CONSTRAINT pk_nostro_reconciliation PRIMARY KEY(`nostro_reconciliation_id`)
) COMMENT 'Reconciliation record matching the platforms nostro account ledger entries against correspondent bank statements (SWIFT MT940/MT950 or camt.053) for each settlement currency. Captures statement date, nostro account reference, opening balance, closing balance, matched entries count, unmatched debit amount, unmatched credit amount, and reconciliation status. Distinct from the general reconciliation_record — this is bank-statement-level nostro reconciliation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Primary key for settlement',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the batch file that contains this settlement.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Core settlement records must reference a currency entity for audit, reporting, and FX.',
    `cycle_id` BIGINT COMMENT 'Reference to the settlement cycle that groups this settlement.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the primary participant (e.g., acquiring bank, issuing bank, or scheme) involved in the settlement.',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: REQUIRED: Settlements apply FX‑related fee schedules; linking enables fee calculation and compliance reporting.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Audit trail linking a settlement record to its corresponding journal entry for reconciliation and audit purposes.',
    `net_position_id` BIGINT COMMENT 'Reference to the net position record used for netting calculations.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: REQUIRED: Settlement records must capture the payment corridor used for cross‑border payments for fee calculation and regulatory reporting.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Aggregated settlement records are produced per payment product for compliance, risk scoring, and product‑level profitability analysis.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: REQUIRED: Settlement may settle in a different currency; the applied FX rate must be stored for accounting and regulatory purposes.',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: Settlement performance reports reference the SLA profile governing gateway latency to ensure contractual compliance.',
    `original_settlement_id` BIGINT COMMENT 'Self-referencing FK on settlement (original_settlement_id)',
    `compliance_flag` BOOLEAN COMMENT 'True if the settlement passed all regulatory compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system.',
    `cycle_timestamp` TIMESTAMP COMMENT 'Timestamp marking the start of the settlement cycle that includes this record.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when converting foreign currency to the settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees deducted from the gross amount.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before fees and adjustments.',
    `instruction_reference` STRING COMMENT 'External reference identifier linking to the original settlement instruction.',
    `is_cross_border` BOOLEAN COMMENT 'True if the settlement involves parties in different countries.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after fees and adjustments, transferred to the participant.',
    `notes` STRING COMMENT 'Additional operational comments or remarks.',
    `processing_mode` STRING COMMENT 'Indicates whether the settlement was processed in batch or real‑time mode.. Valid values are `batch|real_time`',
    `rail_details` STRING COMMENT 'Additional free‑form details about the rail, such as SWIFT message type or RTGS corridor.',
    `rail_type` STRING COMMENT 'Payment rail used for the settlement (e.g., RTGS, RTP, ACH, SWIFT).. Valid values are `rtgs|rtp|ach|swift|internal`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the settlement must be reported to a regulator (e.g., AML, SAR).',
    `risk_score` STRING COMMENT 'Numeric risk rating assigned by the fraud/risk engine.',
    `settlement_date` DATE COMMENT 'Date on which the settlement is booked in the ledger.',
    `settlement_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the settlement.',
    `settlement_method` STRING COMMENT 'Indicates whether the settlement is a debit or credit to the participant.. Valid values are `debit|credit`',
    `settlement_number` STRING COMMENT 'Business identifier assigned to the settlement by the payment network or internal system.',
    `settlement_status` STRING COMMENT 'Current lifecycle state of the settlement.. Valid values are `pending|processed|settled|failed|reversed`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement event occurred in the real world.',
    `settlement_type` STRING COMMENT 'Classification of the settlement (e.g., netting, gross, adjusted).. Valid values are `netting|gross|adjusted`',
    `source_system` STRING COMMENT 'Name of the upstream system that generated the settlement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    `value_date` DATE COMMENT 'Date on which funds become available to the participant.',
    `window` STRING COMMENT 'Time window (e.g., morning, afternoon) during which the settlement is processed.',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Master reference table for settlement. ';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` (
    `issuing_bank_id` BIGINT COMMENT 'Primary key for issuing_bank',
    `parent_issuing_bank_id` BIGINT COMMENT 'Self-referencing FK on issuing_bank (parent_issuing_bank_id)',
    `bank_address` STRING COMMENT 'Street address of the banks main location.',
    `bank_city` STRING COMMENT 'City of the banks primary office.',
    `bank_code` STRING COMMENT 'SWIFT/BIC code uniquely identifying the bank.',
    `bank_country` STRING COMMENT 'Three‑letter ISO country code where the bank is headquartered.',
    `bank_description` STRING COMMENT 'Brief textual description of the banks services and market focus.',
    `bank_last_audit_date` DATE COMMENT 'Date of the most recent compliance audit of the bank.',
    `bank_logo_url` STRING COMMENT 'Link to the banks logo image.',
    `bank_name` STRING COMMENT 'Legal name of the issuing bank.',
    `bank_operating_hours` STRING COMMENT 'Standard operating hours of the banks primary office (e.g., 09:00-17:00).',
    `bank_phone` STRING COMMENT 'Primary telephone number for the bank.',
    `bank_regulatory_code` STRING COMMENT 'Official regulator‑issued identifier for the bank (e.g., licensing number).',
    `bank_risk_rating` STRING COMMENT 'Internal risk rating assigned to the bank.',
    `bank_type` STRING COMMENT 'Classification of the banks role in the payment ecosystem.',
    `bank_website` STRING COMMENT 'Public website URL of the bank.',
    `contact_email` STRING COMMENT 'Primary email address for bank communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank record was first created.',
    `netting_method` STRING COMMENT 'Method used to net multiple transactions during settlement.',
    `reserve_account_currency` STRING COMMENT 'Currency of the reserve account used for settlement.',
    `reserve_account_number` STRING COMMENT 'Account number of the reserve account held for settlement buffering.',
    `settlement_currency` STRING COMMENT 'ISO currency code used for settlements with this bank.',
    `settlement_cycle` STRING COMMENT 'Standard settlement timing (e.g., T+1) for transactions with the bank.',
    `issuing_bank_status` STRING COMMENT 'Current operational status of the issuing bank.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bank record.',
    CONSTRAINT pk_issuing_bank PRIMARY KEY(`issuing_bank_id`)
) COMMENT 'Master reference table for issuing_bank. Referenced by issuing_bank_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`acquirer` (
    `acquirer_id` BIGINT COMMENT 'Primary key for acquirer',
    `parent_acquirer_id` BIGINT COMMENT 'Self-referencing FK on acquirer (parent_acquirer_id)',
    `acquirer_type` STRING COMMENT 'Category of the acquirer (e.g., bank, non‑bank, fintech, processor).',
    `acronym` STRING COMMENT 'Acronym or abbreviation of the acquirer.',
    `address_line1` STRING COMMENT 'First line of the acquirers registered address.',
    `address_line2` STRING COMMENT 'Second line of the address (optional).',
    `city` STRING COMMENT 'City of the acquirers registered address.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of compliance certifications (e.g., PCI‑DSS, ISO27001).',
    `contact_email` STRING COMMENT 'Primary contact email address for the acquirer.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the acquirer.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the acquirer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the acquirer record was first created.',
    `daily_settlement_limit_currency` STRING COMMENT 'Currency of the daily settlement limit.',
    `effective_from` DATE COMMENT 'Date when the acquirer became effective for settlement.',
    `effective_until` DATE COMMENT 'Date when the acquirer ceases to be effective (null if ongoing).',
    `is_preferred` BOOLEAN COMMENT 'Indicates if this acquirer is the preferred partner for routing.',
    `max_daily_settlement_amount` DECIMAL(18,2) COMMENT 'Maximum total settlement amount allowed per day for this acquirer.',
    `acquirer_name` STRING COMMENT 'Legal name of the acquiring institution.',
    `notes` STRING COMMENT 'Free‑text notes regarding the acquirer.',
    `onboarding_date` DATE COMMENT 'Date when the acquirer was onboarded into the system.',
    `postal_code` STRING COMMENT 'Postal code of the acquirers address.',
    `regulatory_status` STRING COMMENT 'Regulatory compliance status of the acquirer.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the acquirer.',
    `settlement_currency` STRING COMMENT 'ISO 4217 currency code used for settlements with this acquirer.',
    `settlement_cutoff_time` STRING COMMENT 'Daily cutoff time (HH:MM) for settlement processing.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle frequency.',
    `settlement_method` STRING COMMENT 'Primary settlement method supported by the acquirer.',
    `short_name` STRING COMMENT 'Commonly used short name or brand for the acquirer.',
    `state_province` STRING COMMENT 'State or province of the acquirers address.',
    `acquirer_status` STRING COMMENT 'Current lifecycle status of the acquirer.',
    `support_contact_email` STRING COMMENT 'Email address of the support contact.',
    `support_contact_name` STRING COMMENT 'Name of the primary support contact person for the acquirer.',
    `support_contact_phone` STRING COMMENT 'Phone number of the support contact.',
    `termination_date` DATE COMMENT 'Date when the relationship with the acquirer was terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the acquirer record.',
    `website_url` STRING COMMENT 'Official website URL of the acquirer.',
    CONSTRAINT pk_acquirer PRIMARY KEY(`acquirer_id`)
) COMMENT 'Master reference table for acquirer. Referenced by originating_acquirer_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_funding_schedule_id` FOREIGN KEY (`funding_schedule_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`funding_schedule`(`funding_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_receiving_party_settlement_participant_id` FOREIGN KEY (`receiving_party_settlement_participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_reversal_of_instruction_id` FOREIGN KEY (`reversal_of_instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_duplicate_of_record_reconciliation_record_id` FOREIGN KEY (`duplicate_of_record_reconciliation_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`reconciliation_record`(`reconciliation_record_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ADD CONSTRAINT `fk_settlement_settlement_reserve_account_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ADD CONSTRAINT `fk_settlement_settlement_reserve_account_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ADD CONSTRAINT `fk_settlement_reserve_movement_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_funding_schedule_id` FOREIGN KEY (`funding_schedule_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`funding_schedule`(`funding_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_issuing_bank_id` FOREIGN KEY (`issuing_bank_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`issuing_bank`(`issuing_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_reversal_of_settlement_interchange_settlement_id` FOREIGN KEY (`reversal_of_settlement_interchange_settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`interchange_settlement`(`interchange_settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_funding_schedule_id` FOREIGN KEY (`funding_schedule_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`funding_schedule`(`funding_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_issuing_bank_id` FOREIGN KEY (`issuing_bank_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`issuing_bank`(`issuing_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ADD CONSTRAINT `fk_settlement_file_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ADD CONSTRAINT `fk_settlement_applied_rate_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_related_adjustment_id` FOREIGN KEY (`related_adjustment_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`adjustment`(`adjustment_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ADD CONSTRAINT `fk_settlement_nostro_reconciliation_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ADD CONSTRAINT `fk_settlement_nostro_reconciliation_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_original_settlement_id` FOREIGN KEY (`original_settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ADD CONSTRAINT `fk_settlement_issuing_bank_parent_issuing_bank_id` FOREIGN KEY (`parent_issuing_bank_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`issuing_bank`(`issuing_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ADD CONSTRAINT `fk_settlement_acquirer_parent_acquirer_id` FOREIGN KEY (`parent_acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`settlement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`settlement` SET TAGS ('dbx_domain' = 'settlement');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `ledger_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `cut_off_time` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Timestamp (COT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Code (SCC)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Status (SCS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'pending|active|closed|suspended');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp (EET)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Indicator (CBI)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `net_position` SET TAGS ('dbx_business_glossary_term' = 'Net Position (NP)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount (NSA)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `processing_mode` SET TAGS ('dbx_business_glossary_term' = 'Processing Mode (PM)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `processing_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required (RRR)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `settlement_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Description (SCD)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `settlement_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Type (SCT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `settlement_cycle_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|ad_hoc');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `settlement_window` SET TAGS ('dbx_business_glossary_term' = 'Settlement Window (SW)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp (EST)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `total_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Amount (TFA)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount (TGA)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `total_transactions` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count (TTC)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date (VD)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Creation User');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `funding_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Acceptance Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `approval_user` SET TAGS ('dbx_business_glossary_term' = 'Batch Approval User');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'open|submitted|accepted|rejected|settled');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Batch Checksum');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `compliance_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `cross_border_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Currency Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `exchange_rate_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Batch File Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `gross_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Credit Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `gross_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Debit Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `net_position_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Position Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `net_position_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Position Currency');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `processing_center_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Center Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Batch Rejection Reason');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `settlement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `settlement_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fee Currency');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `settlement_instructions_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instructions Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Submission Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `total_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `compliance_aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Paying Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `receiving_party_settlement_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `reversal_of_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Instruction Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Paying Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Instruction Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `bic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `bic` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `currency_conversion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Instruction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_number` SET TAGS ('dbx_business_glossary_term' = 'Instruction Number (Unique Business Reference)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Instruction Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|processed|failed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instruction Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Instruction Type (Credit/Debit)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Instruction Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|error');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'netting|gross');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_rail_details` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rail Details');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Instruction Version Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Participant B ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant A ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `gross_credit_total` SET TAGS ('dbx_business_glossary_term' = 'Gross Credit Total (CREDIT_TOTAL)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `gross_debit_total` SET TAGS ('dbx_business_glossary_term' = 'Gross Debit Total (DEBIT_TOTAL)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `is_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_position_number` SET TAGS ('dbx_business_glossary_term' = 'Net Position Number (NP_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_position_number` SET TAGS ('dbx_value_regex' = 'NP-d{8}');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_position_source` SET TAGS ('dbx_business_glossary_term' = 'Net Position Source');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_position_status` SET TAGS ('dbx_business_glossary_term' = 'Net Position Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_position_status` SET TAGS ('dbx_value_regex' = 'pending|posted|confirmed|rejected|adjusted');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `netting_method` SET TAGS ('dbx_business_glossary_term' = 'Netting Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `netting_method` SET TAGS ('dbx_value_regex' = 'bilateral|multilateral');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Net Position Note');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'transaction_netting|interchange|scheme_fee');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `settlement_cycle_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Net Position Version');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` SET TAGS ('dbx_subdomain' = 'funding_distribution');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `funding_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Confirmation ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Bank ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Comments');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Reference Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirming_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Confirming Bank Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirming_bank_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirming_bank_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirming_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Confirming Bank Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (Creator)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `fund_transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Transfer Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `fund_transfer_type` SET TAGS ('dbx_value_regex' = 'RTGS|RTP|ACH|SWIFT');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `funding_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Confirmation Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `funding_confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Processing Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending|exception');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `rtgs_rtp_reference` SET TAGS ('dbx_business_glossary_term' = 'RTGS/RTP Transaction Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `updated_by_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (Updater)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Clearing Record ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Record Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `authorization_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `cleared_amount` SET TAGS ('dbx_business_glossary_term' = 'Cleared Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearing Reference Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'cleared|reversed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `interchange_category` SET TAGS ('dbx_business_glossary_term' = 'Interchange Category');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `interchange_category` SET TAGS ('dbx_value_regex' = 'debit|credit|prepaid|commercial|private|government');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `issuing_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `original_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `processing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('dbx_value_regex' = 'required|optional|exempt');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'duplicate|customer_cancel|merchant_error|fraud|other');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Record ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `account_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Account Reconciliation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `duplicate_of_record_reconciliation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Of Record ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `event_log_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Event Log Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Comment');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `counterpart_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Counterpart Record Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = 'amount_mismatch|missing_record|duplicate|format_error');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `is_exception` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `last_reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `processing_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|semi_automated');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_record_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_record_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending|error');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'batch|instruction|nostro|scheme_file');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for settlement_account');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `merchant_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Identifier (Settlement Account ID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Party Identifier (Owner Party ID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Name (Account Name)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Type (Account Type)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'nostro|vostro|settlement');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance (Available Balance)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City (City)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code (Country Code)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name (Bank Name)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `bic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `bic` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date (Close Date)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created At)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (Credit Limit)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance (Balance)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `daily_funding_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Funding Limit (Funding Limit)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `daily_funding_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Daily Funding Reset Date (Reset Date)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `daily_funding_used` SET TAGS ('dbx_business_glossary_term' = 'Daily Funding Used (Funding Used)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date (Reconciliation Date)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Account Nickname (Nickname)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date (Open Date)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `owner_party_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Party Type (Party Type)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `owner_party_type` SET TAGS ('dbx_value_regex' = 'acquirer|issuer|scheme');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Account Risk Score (Risk Score)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `rtgs_supported` SET TAGS ('dbx_business_glossary_term' = 'RTGS Supported (RTGS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `rtp_supported` SET TAGS ('dbx_business_glossary_term' = 'RTP Supported (RTP)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_account_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Status (Status)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle (Cycle)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|ad_hoc');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Settlement Method (Method)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'RTGS|RTP|ACH|SWIFT|SEPA');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date (Effective Date)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason (Reason)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated At)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `settlement_reserve_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reserve Account ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Reserve Balance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Reserve Balance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `held_amount` SET TAGS ('dbx_business_glossary_term' = 'Held Amount (Monetary)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `last_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Release Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `next_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Release Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_value_regex' = 'required|exempt');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `release_interval` SET TAGS ('dbx_business_glossary_term' = 'Release Interval');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `release_interval` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_name` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reserve Percentage');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `reserve_type` SET TAGS ('dbx_value_regex' = 'rolling|capped|fixed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `settlement_reserve_account_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `settlement_reserve_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` SET TAGS ('dbx_subdomain' = 'funding_distribution');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `reserve_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Movement ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `merchant_reserve_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `merchant_reserve_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `merchant_reserve_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Movement Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Movement Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'hold|release|forfeit|adjustment');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `original_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `reserve_movement_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Description');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `reserve_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Movement Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `reserve_movement_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|failed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `triggering_event` SET TAGS ('dbx_value_regex' = 'chargeback|fraud_loss|scheduled_release|settlement|adjustment');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` SET TAGS ('dbx_subdomain' = 'funding_distribution');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `deduction_sequence` SET TAGS ('dbx_business_glossary_term' = 'Funding Deduction Sequence');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Funding Bank Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Bank Account Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_account_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,11}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_iban` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{15,34}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_bank_iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_method` SET TAGS ('dbx_business_glossary_term' = 'Funding Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_method` SET TAGS ('dbx_value_regex' = 'ach|wire|rtp|sepa');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Description');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `hold_period_days` SET TAGS ('dbx_business_glossary_term' = 'Hold Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Funding Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `last_run_status` SET TAGS ('dbx_business_glossary_term' = 'Last Run Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `last_run_status` SET TAGS ('dbx_value_regex' = 'success|failure|partial');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `minimum_funding_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Funding Threshold');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `next_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Run Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Funding Priority');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Funding Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|t+1|t+2|t+n');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` SET TAGS ('dbx_subdomain' = 'funding_distribution');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `merchant_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Payout ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `funding_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payout Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Pass Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Payout Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `funding_account_number` SET TAGS ('dbx_business_glossary_term' = 'Funding Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `funding_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `funding_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `funding_account_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Account Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `funding_account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|corporate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `interchange_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `mdr_amount` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `merchant_mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `msf_amount` SET TAGS ('dbx_business_glossary_term' = 'Merchant Service Fee (MSF) Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `net_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payout Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payout Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `party_reference` SET TAGS ('dbx_business_glossary_term' = 'Merchant Party Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payout Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `payout_method` SET TAGS ('dbx_business_glossary_term' = 'Payout Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `payout_method` SET TAGS ('dbx_value_regex' = 'ach|wire|rtgs|rtp|internal');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `payout_reference` SET TAGS ('dbx_business_glossary_term' = 'Payout Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'pending|released|on_hold|paid|failed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `payout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payout Initiation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `reserve_hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Hold Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Payout Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `scheme_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `interchange_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `issuing_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `reversal_of_settlement_interchange_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `bin_range` SET TAGS ('dbx_business_glossary_term' = 'BIN Range');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `bin_range` SET TAGS ('dbx_value_regex' = '^d{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `cross_border_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Interchange File Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `interchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Interchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `interchange_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `interchange_settlement_status` SET TAGS ('dbx_value_regex' = 'pending|posted|rejected|reversed|adjusted');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `net_interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `net_position_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Position Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `net_position_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Position Currency');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `net_position_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'processed|failed|queued');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `scheme_code` SET TAGS ('dbx_value_regex' = 'visa|mastercard|discover|amex');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'rtgs|rtp|ach|wire');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'transaction_processing|settlement_system|other');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `total_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `scheme_fee_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `funding_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `issuing_bank_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Due Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_category` SET TAGS ('dbx_value_regex' = 'assessment|network_access|cross_border|other');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_currency_conversion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Conversion Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Invoice Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'fixed|percentage');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|open|closed|reversed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `net_position_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Position Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `net_position_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Position Currency');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `original_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Scheme Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `scheme_code` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|OTHER');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'RTGS|RTP|ACH|SWIFT|OTHER');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `settlement_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Exception ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Settlement Instruction ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `resolved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `resolved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `resolved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Exception Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issue Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'unmatched_record|funding_shortfall|rejected_instruction|reconciliation_variance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Retry Attempts');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `settlement_exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `settlement_exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'transaction_processing|risk_compliance|dispute|digital_wallet|merchant_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `file_id` SET TAGS ('dbx_business_glossary_term' = 'File Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `acknowledgment_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `external_file_reference` SET TAGS ('dbx_business_glossary_term' = 'External File Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `file_category` SET TAGS ('dbx_business_glossary_term' = 'File Category');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `file_category` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `file_description` SET TAGS ('dbx_business_glossary_term' = 'File Description');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `file_type` SET TAGS ('dbx_business_glossary_term' = 'File Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `file_type` SET TAGS ('dbx_value_regex' = 'visa_base2|mastercard_ipm|ach_nacha|swift_mt940|swift_mt950');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'fixed_width|csv|xml|json');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `is_encrypted` SET TAGS ('dbx_business_glossary_term' = 'Is Encrypted');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `originating_system` SET TAGS ('dbx_business_glossary_term' = 'Originating System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'queued|processing|completed|error');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Record Count');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `transmission_status` SET TAGS ('dbx_value_regex' = 'pending|sent|failed|acknowledged|rejected');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'File Version');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` SET TAGS ('dbx_subdomain' = 'participant_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `appetite_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `exposure_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `scheme_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Membership Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `underwriting_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `bic_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `cross_border_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Settlement Enabled');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `is_reserve_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `last_aml_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last AML Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `last_sanction_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sanction Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `netting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Allowed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_name` SET TAGS ('dbx_business_glossary_term' = 'Participant Name (Legal Entity Name)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_status` SET TAGS ('dbx_business_glossary_term' = 'Participant Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_type` SET TAGS ('dbx_business_glossary_term' = 'Participant Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_type` SET TAGS ('dbx_value_regex' = 'acquirer|issuer|card_scheme|psp|payfac');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Participant Reference ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `region_state` SET TAGS ('dbx_business_glossary_term' = 'Region/State');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_account_iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_account_iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_account_iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_cycle_preference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Preference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_cycle_preference` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|ad_hoc');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fee Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_rail_capability` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rail Capability');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_rail_capability` SET TAGS ('dbx_value_regex' = 'rtgs|rtp|ach|swift|sepa');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_window` SET TAGS ('dbx_business_glossary_term' = 'Settlement Window Preference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `settlement_window` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` SET TAGS ('dbx_subdomain' = 'participant_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `applied_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Applied Rate Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `applied_rate_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Description');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `applied_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `applied_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending|archived');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Timestamp (FX)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `currency_pair` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `currency_pair` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}/[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp (FX)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp (FX)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `rate_precision` SET TAGS ('dbx_business_glossary_term' = 'Rate Precision');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source (FX)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'ECB|Visa|Mastercard|Internal|Other');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type (FX)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'spot|mid_market|scheme|custom');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value (FX)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (FX)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `related_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Related Adjustment ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|reversed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `original_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'error_correction|late_presentment|fee_credit|scheme_correction|reversal|other');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Sequence');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` SET TAGS ('dbx_subdomain' = 'participant_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `nostro_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Reconciliation ID (NOSTRO_RECON_ID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position Identifier (NET_POS_ID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier (SETTLE_CYCLE_ID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier (BATCH_ID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (ADJ_REASON)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status (AML_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance (CLOSE_BAL)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exception');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `exchange_rate_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Timestamp (EXCH_RATE_TS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator (IS_CROSS_BORDER)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `matched_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Matched Credit Amount (MATCHED_CREDIT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `matched_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Matched Debit Amount (MATCHED_DEBIT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `matched_entries_count` SET TAGS ('dbx_business_glossary_term' = 'Matched Entries Count (MATCHED_CNT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance (OPEN_BAL)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status (PROC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'completed|failed|in_progress|queued');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number (REC_NUM)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status (REC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|partial|unmatched|error|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp (REC_TS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `related_statement_file_name` SET TAGS ('dbx_business_glossary_term' = 'Related Statement File Name (FILE_NAME)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Status (SANCTION_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|processing|fraud|wallet|compliance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `statement_checksum` SET TAGS ('dbx_business_glossary_term' = 'Statement Checksum (CHECKSUM)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date (STAT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement Reference (STAT_REF)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `total_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Amount (TOTAL_FEE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `total_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Amount (TOTAL_TXN_AMT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `unmatched_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Credit Amount (UNMATCHED_CREDIT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `unmatched_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Debit Amount (UNMATCHED_DEBIT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NO)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` SET TAGS ('dbx_subdomain' = 'settlement_operations');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Participant ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `original_settlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `cycle_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Reference');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `processing_mode` SET TAGS ('dbx_business_glossary_term' = 'Processing Mode');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `processing_mode` SET TAGS ('dbx_value_regex' = 'batch|real_time');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `rail_details` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rail Details');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `rail_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rail Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `rail_type` SET TAGS ('dbx_value_regex' = 'rtgs|rtp|ach|swift|internal');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Settlement Risk Score');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Description');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|processed|settled|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'netting|gross|adjusted');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `window` SET TAGS ('dbx_business_glossary_term' = 'Settlement Window');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` SET TAGS ('dbx_subdomain' = 'participant_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `issuing_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `parent_issuing_bank_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `bank_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `bank_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `bank_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `bank_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`issuing_bank` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` SET TAGS ('dbx_subdomain' = 'participant_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `parent_acquirer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `max_daily_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `max_daily_settlement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
