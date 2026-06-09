-- Schema for Domain: settlement | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`settlement` COMMENT 'Manages the end-to-end clearing and settlement lifecycle including batch file generation, net settlement positions, RTGS and RTP rail instructions, fund movements, reconciliation records, and funding confirmations between acquiring banks, issuing banks, and card schemes. SSOT for settlement obligations, funding schedules, reserve accounts, and settlement cycles.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Primary key for cycle',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Settlement cycles align with accounting periods; cycle net settlement amounts feed into period closing balances. Finance teams require cycle-to-period attribution for period-end close, net settlement ',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Settlement cycles are jurisdiction-specific — cut-off times, value dates, and cross-border netting rules vary by jurisdiction. The cycle has `is_cross_border` but no FK to jurisdiction_profile. Multi-',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Settlement cycles are governed by a specific payment scheme (Visa, Mastercard, ACH) which defines cut-off times, settlement windows, and processing modes. Scheme-level cycle configuration and regulato',
    `sla_id` BIGINT COMMENT 'Foreign key linking to network.sla. Business justification: Settlement cycles are bound by scheme SLA commitments (T+1 settlement window, batch processing deadlines). Linking cycle to the governing SLA enables SLA breach monitoring and regulatory reporting on ',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Settlement batches must be attributed to an accounting period for period-end close, P&L reporting, and regulatory filings. Payments fintechs require batch-to-period attribution for financial statement',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Settlement batches are executed under specific partner agreements governing settlement method, cycle days, MDR rates, and fee structures. Compliance and contract-performance reporting requires linking',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Cross-border settlement batches (`is_cross_border=true`) must comply with jurisdiction-specific transaction limits and reporting rules. The batch has `cross_border_currency_code` but no FK to jurisdic',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: Settlement batches are submitted to a specific network endpoint (e.g., Visa NET, Mastercard Connect). This link enables endpoint health correlation with batch failures, connectivity monitoring, and SL',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Cross-border settlement batches must comply with corridor-specific transaction limits, supported rails, and regulatory restrictions. Payments ops teams enforce corridor SLAs and limits at the batch le',
    `scheme_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to network.scheme_fee_schedule. Business justification: Settlement batches incur scheme fees per the applicable fee schedule. Linking batch to scheme_fee_schedule enables automated validation of settlement_fee_amount against the contracted fee schedule — a',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Settlement batches are reconciled against scheme invoices for interchange and scheme fee settlement. Batch-level scheme invoice reconciliation is a mandatory monthly financial close process in card ne',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this batch belongs.',
    `participant_id` BIGINT COMMENT 'Identifier of the acquiring bank that originated the batch.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to network.sla. Business justification: Settlement batches must complete within scheme-mandated SLA windows. This link enables automated SLA breach detection, operational escalation, and scheme compliance reporting on batch processing timel',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: Settlement batches operate under contractual SLA commitments for processing completion time. Linking to gateway.sla_profile enables automated SLA breach detection, regulatory reporting on batch proces',
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
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: Fund movement instructions are originated by an acquiring bank. Linking instruction to acquirer enables acquirer-level instruction tracking, settlement limit enforcement, and regulatory reporting by a',
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: AML screening is performed per instruction; linking the result enables SAR filing and regulatory reporting.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: REQUIRED: Each settlement instruction for a cross‑border payment uses a specific currency pair; needed for FX rate selection and audit.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal identifier of the party that receives the funds (e.g., issuing bank or settlement participant).',
    `participant_id` BIGINT COMMENT 'Internal identifier of the party that funds the instruction (e.g., acquiring bank or merchant).',
    `net_position_id` BIGINT COMMENT 'Link to the net settlement position that aggregates multiple instructions.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Settlement instruction processing requires the payment product to calculate fees and generate regulatory reports; linking to payment_product provides the product type (card, ACH, BNPL) used for the tr',
    `receiving_party_settlement_participant_id` BIGINT COMMENT 'Internal identifier of the party that receives the funds (e.g., issuing bank or settlement participant).',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Audit trail linking each settlement instruction to its originating gateway request for compliance and dispute resolution.',
    `reversal_of_instruction_id` BIGINT COMMENT 'If this is a reversal, points to the original instruction being reversed.',
    `risk_profile_id` BIGINT COMMENT 'Internal identifier of the party that funds the instruction (e.g., acquiring bank or merchant).',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: Settlement instructions are routed via network routing tables that determine processing rail, endpoint, and scheme. The routing_table governs settlement_rail_details on instruction. Routing audit trai',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Regulatory requirement: each settlement instruction must be linked to its sanctions screening result for audit and transaction blocking.',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Fund movement instructions are generated within a settlement batch context. Linking instruction to settlement_batch enables batch-level instruction tracking, status aggregation, and audit trail for al',
    `cycle_id` BIGINT COMMENT 'Reference to the settlement cycle (e.g., daily, hourly) that this instruction belongs to.',
    `aml_check_status` STRING COMMENT 'Result of anti‑money‑laundering screening for the instruction.. Valid values are `passed|failed|pending`',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount to be transferred.',
    `compliance_flag` STRING COMMENT 'Indicator of any compliance‑related condition attached to the instruction.. Valid values are `none|low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the instruction record was first created in the system.',
    `currency_conversion_indicator` BOOLEAN COMMENT 'True if the instruction required currency conversion.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee charged for processing the instruction.',
    `fee_currency` STRING COMMENT 'Currency of the fee amount.',
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
    `settlement_status` STRING COMMENT 'Current settlement outcome of the instruction.. Valid values are `pending|settled|failed|reversed`',
    `source_system` STRING COMMENT 'Name of the upstream system that generated the instruction (e.g., Transaction Processing Platform).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the instruction record.',
    `value_date` DATE COMMENT 'Date on which the funds are considered to be settled.',
    `version` STRING COMMENT 'Version of the instruction record for audit‑trail purposes.',
    CONSTRAINT pk_instruction PRIMARY KEY(`instruction_id`)
) COMMENT 'Individual fund movement instruction generated for a settlement obligation — specifying the paying party, receiving party, amount, currency, value date, payment rail (RTGS, RTP, ACH, SWIFT), IBAN/BIC routing details, and instruction status. Each instruction maps to a net settlement position and drives the actual fund transfer. Sourced from the Transaction Processing Platform settlement module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`net_position` (
    `net_position_id` BIGINT COMMENT 'Unique identifier for the net settlement position record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the second participant (e.g., issuing bank or scheme) in the settlement pair.',
    `exposure_limit_id` BIGINT COMMENT 'Foreign key linking to risk.exposure_limit. Business justification: Net positions represent actual participant credit/debit exposure in a settlement cycle. Monitoring net_amount against exposure_limit.limit_amount is a core intraday risk management process — breach de',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Net positions in multilateral netting generate journal entries (debit/credit per participant net position) posted to the GL. Finance teams trace net position calculations to GL entries for netting dis',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Net positions for cross-border settlement are computed per payment corridor for liquidity management and corridor-level exposure reporting. Treasury and settlement ops teams require corridor-level net',
    `participant_id` BIGINT COMMENT 'Identifier of the first participant (e.g., acquiring bank) in the settlement pair.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Cross-border net positions are calculated using a specific FX rate; regulatory reporting and end-of-day reconciliation require the exact rate used for netting. exchange_rate on net_position is a denor',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Net positions are calculated per scheme — multilateral netting is scheme-governed with scheme-specific netting_method rules. Scheme-level exposure reporting and netting compliance verification require',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Net positions are computed per settlement batch. The batch_number STRING is a denormalized reference; replacing with settlement_batch_id FK normalizes the relationship and enables batch-level net posi',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this net position belongs.',
    `adjustment_reason` STRING COMMENT 'Reason for any adjustment applied to the net position.',
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
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the bank that provided the funding confirmation.',
    `net_position_id` BIGINT COMMENT 'Foreign key linking to settlement.net_position. Business justification: Funding confirmations confirm the settlement of a net position between participants. Linking to net_position enables tracking of which net positions have been confirmed as funded, supporting settlemen',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: Cross-border funding confirmations are matched against nostro account movements for treasury reconciliation; RTGS/RTP funding confirmations (rtgs_rtp_reference present) must be traceable to the specif',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Funding confirmations are issued by or for a specific settlement participant (acquirer, issuer, or scheme). Linking to participant enables participant-level funding status tracking and reporting.',
    `settlement_account_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_account. Business justification: funding_confirmation.confirming_bank_account and confirming_bank_name are denormalized attributes of the settlement account that confirmed the funds. Replacing with settlement_account_id FK normalizes',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Funding confirmations confirm fund receipt for instructions within a settlement batch. The batch_number STRING is a denormalized reference; replacing with settlement_batch_id FK normalizes the relatio',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle (e.g., daily, hourly) associated with this confirmation.',
    `instruction_id` BIGINT COMMENT 'Identifier of the settlement instruction that this confirmation relates to.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to audit trail entry for this confirmation.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the confirmation.',
    `confirmation_reference` STRING COMMENT 'Reference number assigned by the confirming bank for the fund transfer.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the confirmation was received from the confirming bank.',
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
    `bin_interchange_rule_id` BIGINT COMMENT 'Foreign key linking to interchange.bin_interchange_rule. Business justification: BIN-based interchange rules determine which interchange rate applies during clearing based on card BIN. Clearing systems must reference the applicable BIN rule for rate determination and audit trail —',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: Clearing records must map each transaction to its card program to allocate scheme fees correctly and satisfy scheme‑specific reporting requirements.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank that processed the transaction.',
    `irf_table_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_table. Business justification: Clearing processing applies the specific IRF table entry to compute interchange fees on each cleared transaction. Interchange rate application during clearing is a core daily operational process; doma',
    `net_position_id` BIGINT COMMENT 'Foreign key linking to settlement.net_position. Business justification: Each cleared transaction contributes to a net settlement position. Linking clearing_record to net_position enables aggregation and traceability from individual cleared transactions to the computed net',
    `participant_id` BIGINT COMMENT 'Identifier of the acquiring bank that processed the transaction.',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: Interchange programs (e.g., commercial card, rewards, debit) determine which interchange rules apply during clearing. Clearing records must reference the applicable program for correct rate applicatio',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Cross-border clearing records apply a specific FX rate for currency conversion during clearing; interchange fee calculations and scheme compliance reporting require the exact rate used. exchange_rate ',
    `scheme_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to network.scheme_fee_schedule. Business justification: Clearing records carry fee_amount computed from the scheme fee schedule. This link enables automated interchange fee validation and scheme fee audit — required for scheme compliance and dispute resolu',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Clearing records are produced within a settlement batch. The batch_number STRING column is a denormalized reference to the parent batch; replacing it with a proper FK settlement_batch_id normalizes th',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to settlement.cycle. Business justification: clearing_record.settlement_cycle is a STRING denormalization of the settlement cycle. Replacing it with a proper FK settlement_cycle_id → cycle.cycle_id normalizes the relationship and enables reliabl',
    `transaction_id` BIGINT COMMENT 'Reference to the original authorization transaction that is being cleared.',
    `authorization_reference_number` STRING COMMENT 'Unique identifier assigned by the acquiring network for the original authorization.',
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
    `is_reversal` BOOLEAN COMMENT 'Indicates whether the clearing record represents a reversal transaction.',
    `issuing_bank_code` BIGINT COMMENT 'Identifier of the issuing bank that issued the payment instrument.',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount to be settled after deducting fees.',
    `original_authorization_code` STRING COMMENT 'Code returned by the issuer approving the original transaction.',
    `processing_country_code` STRING COMMENT 'Three‑letter country code where the clearing event was processed. [ENUM-REF-CANDIDATE: many values — promote to reference product]',
    `regulatory_reporting_indicator` STRING COMMENT 'Indicates the reporting requirement status for this clearing record.. Valid values are `required|optional|exempt`',
    `reversal_reason_code` STRING COMMENT 'Code describing why the transaction was reversed.. Valid values are `duplicate|customer_cancel|merchant_error|fraud|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the risk engine at clearing time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the clearing record.',
    CONSTRAINT pk_clearing_record PRIMARY KEY(`clearing_record_id`)
) COMMENT 'Individual cleared transaction record produced during the clearing phase — the post-authorization, pre-settlement representation of a payment transaction. Stores ARN (Acquirer Reference Number), original authorization code, MID, card scheme, interchange category, cleared amount, currency, clearing date, and clearing status. Bridges the transaction domain and the settlement domain. Sourced from the Transaction Processing Platform clearing module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` (
    `reconciliation_record_id` BIGINT COMMENT 'System-generated unique identifier for the reconciliation record.',
    `billing_id` BIGINT COMMENT 'Foreign key linking to interchange.billing. Business justification: Reconciliation records are matched against interchange billing records as part of the interchange reconciliation process. This is a mandatory financial close and regulatory reporting requirement in ca',
    `clearing_record_id` BIGINT COMMENT 'Foreign key linking to settlement.clearing_record. Business justification: Reconciliation records reconcile cleared transaction records against external counterparts. A direct FK to clearing_record enables matching reconciliation entries to the specific cleared transactions ',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: Reconciliation records with `aml_check_status`, `kyc_status`, or `is_exception=true` are escalated to compliance cases. The record has these flags but no FK to compliance_case. Compliance teams invest',
    `downgrade_id` BIGINT COMMENT 'Foreign key linking to interchange.downgrade. Business justification: Interchange downgrades are a primary source of settlement variances captured in reconciliation records. Linking reconciliation records to downgrades enables downgrade-driven variance analysis — a stan',
    `duplicate_of_record_reconciliation_record_id` BIGINT COMMENT 'Reference to the original reconciliation record when this record is a duplicate.',
    `funding_confirmation_id` BIGINT COMMENT 'Foreign key linking to settlement.funding_confirmation. Business justification: Reconciliation records match internal records against external funding confirmations. A direct FK to funding_confirmation enables reconciliation of confirmed fund receipts against expected settlement ',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to settlement.instruction. Business justification: Reconciliation records match internal settlement records against external counterparts. Linking to the instruction being reconciled provides direct traceability from the reconciliation entry to the fu',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Reconciliation records identifying variances trigger corrective journal entries. Finance and audit teams trace reconciliation exceptions to GL corrections for SOX compliance, variance resolution repor',
    `merchant_payout_id` BIGINT COMMENT 'Foreign key linking to settlement.merchant_payout. Business justification: Reconciliation records validate merchant payout disbursements. Linking to merchant_payout enables reconciliation of actual payout amounts against expected net settlement values for merchants.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Reconciliation processes, exception thresholds, and variance tolerances are product-specific. Operations teams run product-level break analysis reports and regulatory reconciliation submissions segmen',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to interchange.qualification. Business justification: Reconciliation records identify variances between expected and actual settlement; interchange qualification outcomes are a primary source of variance. Direct qualification reference enables exception-',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Reconciliation records must be matched against scheme-specific transaction files. Scheme identity is essential for scheme-level reconciliation reporting, exception handling, and regulatory submissions',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Reconciliation records reconcile scheme invoice amounts against settlement records. Scheme invoice reconciliation is a mandatory monthly financial close process; direct FK enables period-level scheme ',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Reconciliation records are produced per settlement batch. Linking to settlement_batch enables batch-level reconciliation reporting and exception tracking across all records in a batch.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle (e.g., daily, hourly) for this reconciliation.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Reconciliation records validate settlement outcomes. Linking to the master settlement record enables reconciliation status to be tracked at the settlement level and supports settlement finalization wo',
    `participant_id` BIGINT COMMENT 'Identifier of the external party (e.g., acquiring bank, issuing bank, scheme) involved in the reconciliation.',
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
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the party (acquirer, issuer, or scheme) that owns the settlement account.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Each settlement account must be linked to a GL account for journal entry creation; essential for financial statements.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Settlement accounts are owned by legal entities for regulatory reporting, entity-level liquidity management, and financial statement consolidation. Payments fintechs must attribute settlement account ',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: Settlement accounts used for cross-border settlement are backed by nostro accounts at correspondent banks; treasury liquidity management and intraday funding reconciliation require direct linkage betw',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Settlement accounts are owned and operated by settlement participants (acquirers, issuers, schemes). Linking settlement_account to participant establishes ownership and enables participant-level accou',
    `partner_settlement_account_id` BIGINT COMMENT 'Foreign key linking to partner.partner_settlement_account. Business justification: Operational settlement accounts must be mapped to the partners designated external bank account for fund routing and reconciliation. This link is essential for the funding reconciliation process and ',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Settlement account risk profiling governs daily_funding_limit, credit_limit, and compliance monitoring. Account-level risk profile is a core operational need for AML/KYC account reviews and regulatory',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` (
    `reserve_account_id` BIGINT COMMENT 'Unique system-generated identifier for the reserve account record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Reserve account terms — reserve percentage, release conditions, and hold periods — are contractually defined in partner agreements. Compliance reporting and reserve release authorization require linki',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring bank or entity linked to the reserve.',
    `funding_schedule_id` BIGINT COMMENT 'Foreign key linking to settlement.funding_schedule. Business justification: Reserve accounts are governed by a funding schedule that defines release intervals, conditions, and timing. Linking settlement_reserve_account to funding_schedule enables automated reserve release pro',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant to which the reserve is attached.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Reserve account requirements are mandated by specific regulations (PSD2 safeguarding requirements, EMI regulations, payment institution capital requirements). The reserve account has `regulatory_repor',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Reserve account parameters (reserve_percentage, reserve_cap_amount, release_conditions) are directly governed by the merchant/participant risk profile. aml_check_status and sanction_check_status on re',
    `settlement_account_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_account. Business justification: A settlement reserve account is a specialized form of settlement account (rolling reserve or security deposit). Linking to settlement_account establishes the parent account relationship, enabling rese',
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
    `sanction_check_status` STRING COMMENT 'Result of sanctions screening for the reserve account.. Valid values are `passed|failed|pending`',
    `settlement_reserve_account_status` STRING COMMENT 'Current lifecycle status of the reserve account.. Valid values are `active|inactive|closed|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reserve account record.',
    CONSTRAINT pk_reserve_account PRIMARY KEY(`reserve_account_id`)
) COMMENT 'Rolling reserve or security deposit account held against a merchant or acquirer to cover potential chargebacks, fraud losses, or settlement shortfalls. Captures reserve type (rolling, capped, fixed), reserve percentage, held amount, currency, release schedule, release conditions, and current balance. SSOT for reserve obligations and release tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` (
    `funding_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the funding schedule record.',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: Funding schedules are administered by acquiring banks on behalf of their merchants. Linking funding_schedule to acquirer identifies the sponsoring acquirer, enabling acquirer-level funding schedule ov',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Funding schedules are created as part of partner onboarding agreements that specify hold periods, minimum thresholds, and funding methods. Linking funding_schedule to its governing agreement is requir',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Funding schedules debit/credit specific GL accounts; linking ensures correct posting of funding transactions.',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: Funding schedules for merchants incorporate MDR deductions governed by mdr_config. The funding schedule determines net funding amounts after MDR; linking to mdr_config enables correct net funding calc',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant (or sub‑acquirer) that receives the funding.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Funding schedules define when and how participants (merchants, sub-acquirers, PayFacs) are funded. Linking to participant establishes which settlement participant the schedule governs, enabling partic',
    `partner_settlement_account_id` BIGINT COMMENT 'Foreign key linking to partner.partner_settlement_account. Business justification: Funding schedules specify which external bank account receives disbursed funds. Linking funding_schedule to the partners designated bank account is required for automated fund routing and funding rec',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Cross-border funding schedules (is_cross_border flag present) must comply with corridor-specific settlement time windows, minimum/maximum amounts, and supported payment rails. Payments domain experts ',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Funding schedules govern hold periods and funding methods that differ by payment product — BNPL has longer hold periods than card-present; A2A has different minimum thresholds. Treasury teams configur',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Funding schedule parameters (hold_period_days, minimum_funding_threshold, priority) are governed by risk policy. Risk policy defines transaction_limit_amount and daily_exposure_limit that directly det',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Funding schedules are scheme-specific — different schemes mandate different funding windows and hold_period_days requirements. Linking funding_schedule to scheme enables scheme-specific funding config',
    `settlement_account_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_account. Business justification: funding_schedule contains funding_bank_account, funding_bank_account_name, funding_bank_bic, and funding_bank_iban — all denormalized attributes of the target settlement account. Replacing with settle',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this funding schedule is linked.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the settlement batch that generated the funding instruction.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the schedule complies with all applicable regulatory checks (true = compliant).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `deduction_sequence` STRING COMMENT 'Ordered list of deductions applied to the gross amount (e.g., MDR, interchange, chargebacks, reserves).',
    `effective_end_date` DATE COMMENT 'Date on which the schedule expires or is retired (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the schedule becomes effective.',
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
    `schedule_code` STRING COMMENT 'Business-visible code used to reference the funding schedule in external systems and reports.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the purpose or configuration of the schedule.',
    `schedule_type` STRING COMMENT 'Classification of the schedule frequency or timing rule (e.g., daily, weekly, T+1).. Valid values are `daily|weekly|monthly|t+1|t+2|t+n`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule record.',
    CONSTRAINT pk_funding_schedule PRIMARY KEY(`funding_schedule_id`)
) COMMENT 'Master schedule defining when and how merchants, sub-acquirers, or PayFacs are funded from settled proceeds. Stores funding frequency (daily, weekly, T+1, T+2, T+n), funding method (ACH, wire, RTP, SEPA), funding bank account reference, minimum funding threshold, hold period, deduction sequence (MDR, interchange, scheme fees, chargebacks, reserves), and schedule status. SSOT for merchant funding timing, payout configuration, and settlement-to-payout waterfall rules.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` (
    `merchant_payout_id` BIGINT COMMENT 'System-generated unique identifier for the merchant payout record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Merchant payouts must be attributed to accounting periods for fee income reporting, revenue recognition, and period-end close. Payments fintechs report payout volumes and fee income by period for fina',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: BNPL merchant payouts are computed against specific plan terms (installment count, interest rate, late fees). Finance teams reconcile BNPL payout amounts (net_payout_amount, refund_amount, chargeback_',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: Merchant payouts can be held or clawed back due to compliance investigations (AML, fraud, sanctions). The payout has `compliance_flag` but no FK to compliance_case. Compliance teams managing payout ho',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to settlement.instruction. Business justification: Merchant payouts are executed via fund movement instructions. Linking merchant_payout to instruction provides traceability from the payout record to the specific instruction that transferred the funds',
    `merchant_id` BIGINT COMMENT 'FK to merchant.merchant.merchant_id — MUST-HAVE: Enables tracing merchant payouts to the merchant entity — essential for merchant settlement reporting and funding reconciliation.',
    `msf_schedule_id` BIGINT COMMENT 'Foreign key linking to interchange.msf_schedule. Business justification: MSF deductions in merchant payouts are governed by the applicable msf_schedule. Payout calculation and merchant fee reconciliation require linking to the MSF schedule — a standard merchant acquiring s',
    `net_position_id` BIGINT COMMENT 'Foreign key linking to settlement.net_position. Business justification: Merchant payouts are derived from the net settlement position computed for the merchants acquirer. Linking merchant_payout to net_position provides traceability from the payout disbursement back to t',
    `partner_settlement_account_id` BIGINT COMMENT 'Foreign key linking to partner.partner_settlement_account. Business justification: Merchant payouts must be directed to the partners designated bank account. Payout routing, reconciliation reporting, and audit trails require linking each merchant_payout to the specific partner_sett',
    `pricing_exception_id` BIGINT COMMENT 'Foreign key linking to interchange.pricing_exception. Business justification: Pricing exceptions grant merchants non-standard interchange rates that directly affect net payout amounts. Payout processing must reference the applicable pricing exception for correct fee computation',
    `product_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to product.product_fee_schedule. Business justification: Merchant payout fee deductions (MDR, MSF, scheme fees) are computed from a product_fee_schedule. Linking the schedule used at payout time provides an immutable audit trail for fee calculation disputes',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Cross-border merchant payouts apply a specific FX rate for currency conversion; merchant dispute resolution, regulatory reporting, and payout audit trails require traceability to the exact rate used. ',
    `reserve_account_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_reserve_account. Business justification: merchant_payout.reserve_hold_amount indicates funds withheld in a reserve account. Linking to settlement_reserve_account identifies which reserve account holds the withheld funds, enabling reserve bal',
    `scheme_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to network.scheme_fee_schedule. Business justification: Merchant payout scheme_fee_amount and mdr_amount are computed from the scheme fee schedule. This link enables automated fee deduction validation and merchant billing transparency required by scheme op',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Merchant payouts are calculated using scheme-specific MDR, interchange, and scheme fee structures. scheme_fee_amount and mdr_amount on merchant_payout are scheme-driven. Scheme-level payout reporting ',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Merchant payouts are generated from settled batches. Linking merchant_payout to settlement_batch enables batch-level payout tracking, reconciliation, and audit trail for all payouts generated from a s',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle associated with this payout.',
    `underwriting_decision_id` BIGINT COMMENT 'Foreign key linking to risk.underwriting_decision. Business justification: Merchant payout eligibility, reserve_hold_amount, and net_payout_amount are directly determined by the underwriting decision (max_transaction_amount, reserve_rate, tpv_cap). Payments operations requir',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Total chargeback adjustments deducted.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the payout passed all compliance checks.',
    `external_reference` STRING COMMENT 'Reference identifier from external payment network or partner.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` (
    `settlement_exception_id` BIGINT COMMENT 'Unique system-generated identifier for the settlement exception record.',
    `instruction_id` BIGINT COMMENT 'Identifier of the specific settlement instruction linked to the exception.',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to dispute.chargeback. Business justification: Chargeback-driven settlement exceptions are a named operational category. Exception resolution workflows must trace the exception to the triggering chargeback for root cause analysis, regulatory repor',
    `clearing_record_id` BIGINT COMMENT 'Foreign key linking to settlement.clearing_record. Business justification: Settlement exceptions can arise from clearing record failures or discrepancies. Linking settlement_exception to clearing_record identifies the specific cleared transaction that caused the exception, e',
    `downgrade_id` BIGINT COMMENT 'Foreign key linking to interchange.downgrade. Business justification: Interchange downgrades cause settlement exceptions when downgraded rates affect settlement amounts. Exception handling and SLA management require tracing which downgrade triggered the exception — a st',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: Settlement exceptions are directly triggered by fraud detection events (e.g., mid-settlement fraud flag causing a payment hold). A direct FK enables fraud-driven exception dashboards, SLA breach track',
    `funding_confirmation_id` BIGINT COMMENT 'Foreign key linking to settlement.funding_confirmation. Business justification: Settlement exceptions can arise from funding confirmation failures (e.g., RTGS rejection, bank acknowledgment failure). Linking settlement_exception to funding_confirmation identifies the specific con',
    `merchant_payout_id` BIGINT COMMENT 'Foreign key linking to settlement.merchant_payout. Business justification: Settlement exceptions can arise from merchant payout failures (e.g., invalid account, insufficient funds). Linking settlement_exception to merchant_payout identifies the specific payout that triggered',
    `net_position_id` BIGINT COMMENT 'Reference to the net position record impacted by the exception.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Settlement exceptions affect specific participants in the settlement network. Linking settlement_exception to participant identifies which participant is impacted, enabling participant-level exception',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Settlement exception SLA targets, root cause codes, and resolution workflows are product-specific — BNPL exceptions follow different paths than card or A2A. Operations triage and SLA breach reporting ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Settlement exceptions may be triggered by regulatory obligation breaches (e.g., settlement finality deadline missed under PSD2, RTGS cut-off violations). The exception has `regulatory_flag` and `sla_b',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch where the exception originated.',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle during which the exception occurred.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement. Business justification: Settlement exceptions arise within the context of a master settlement record. Linking settlement_exception to settlement enables settlement-level exception tracking and supports settlement finalizatio',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`participant` (
    `participant_id` BIGINT COMMENT 'Primary key for participant',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Settlement participants submit and receive settlement messages via specific gateway acquirer endpoints. This link enables settlement operations to identify the exact gateway channel used per participa',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: The participant registry includes acquiring banks as a participant type. Linking participant to acquirer connects the settlement participant record to the acquirer master record, enabling acquirer-spe',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Settlement participants operate under specific partner agreements defining netting eligibility, settlement obligations, fee rates, and regulatory reporting requirements. Regulatory compliance and part',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to fx.correspondent_bank. Business justification: REQUIRED: Participants (banks) maintain correspondent banking relationships for cross‑border routing; needed for compliance and settlement routing decisions.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Required for partner-level settlement reporting and revenue sharing; each settlement participant represents a partner entity.',
    `exposure_limit_id` BIGINT COMMENT 'Foreign key linking to risk.exposure_limit. Business justification: Exposure limits per participant are tracked to enforce credit and concentration caps during settlement.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Settlement participants operate under specific jurisdiction profiles governing their settlement obligations, reporting requirements, and transaction limits. The participant has `country_code` and `cro',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Settlement participants (banks, PSPs, acquirers) are legal entities. Linking participant to legal_entity enables entity-level financial consolidation, regulatory reporting (PSD2, Basel III), and AML/K',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Participant risk profiling is fundamental to settlement operations: risk_profile governs settlement_fee_rate, netting_allowed_flag, and cross_border_settlement_flag. risk_score on participant is a den',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Primary key for adjustment',
    `clearing_record_id` BIGINT COMMENT 'Foreign key linking to settlement.clearing_record. Business justification: Adjustments often correct errors in cleared transactions (late presentments, fee corrections). Linking adjustment to clearing_record provides traceability from the corrective adjustment to the specifi',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: Adjustments can be triggered by compliance investigations (AML-related clawbacks, regulatory-mandated corrections, sanctions-related reversals). The adjustment has `compliance_flag` but no FK to compl',
    `downgrade_id` BIGINT COMMENT 'Foreign key linking to interchange.downgrade. Business justification: Interchange downgrades trigger settlement adjustments to recover incremental interchange costs. The adjustment process requires referencing the specific downgrade that caused it — a well-established i',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to settlement.instruction. Business justification: Adjustments correct errors in fund movement instructions. Linking adjustment to instruction provides direct traceability from the corrective adjustment to the original instruction being corrected, sup',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Settlement adjustments (chargebacks, FX corrections, fee adjustments) require corresponding GL journal entries for correction or reversal. SOX compliance mandates traceability from each financial adju',
    `net_position_id` BIGINT COMMENT 'Foreign key linking to settlement.net_position. Business justification: Adjustments modify net settlement positions. Linking adjustment to net_position identifies which net position is being corrected, enabling accurate recalculation of net amounts after adjustments are a',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement record that is being adjusted.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Adjustments affect specific settlement participants (acquirers, issuers, schemes). Linking adjustment to participant identifies which participants settlement position is being adjusted, enabling part',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Settlement adjustments (interchange corrections, chargeback adjustments, fee reversals) are governed by payment product rules. Regulatory reporting of adjustments and finance P&L attribution require p',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Settlement adjustments above certain thresholds require risk policy approval (approval_required_flag, transaction_limit_amount in risk_policy). Adjustment approval workflows and compliance_flag valida',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Cross-border settlement adjustments (FX adjustments, cross-border chargebacks) apply a specific FX rate; regulatory audit trails and dispute resolution require traceability to the exact rate used. exc',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Certain adjustments are mandated by specific regulatory obligations (EU IFR interchange fee caps, PSD2 surcharging rules, scheme fee regulatory caps). The adjustment has `compliance_flag` but no FK to',
    `settlement_batch_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_batch. Business justification: Post-settlement adjustments are applied within a settlement batch context. Linking adjustment to settlement_batch enables batch-level adjustment tracking and ensures adjustments are correctly attribut',
    `cycle_id` BIGINT COMMENT 'Identifier of the settlement cycle to which this adjustment belongs.',
    `settlement_exception_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_exception. Business justification: Adjustments are frequently created to resolve settlement exceptions. Linking adjustment to settlement_exception provides traceability from the corrective action to the exception that triggered it, sup',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Monetary amount applied by the adjustment (positive for credit, negative for debit).',
    `adjustment_status` STRING COMMENT 'Current processing state of the adjustment.. Valid values are `pending|approved|rejected|reversed`',
    `adjustment_type` STRING COMMENT 'Indicates whether the adjustment adds to (credit) or subtracts from (debit) the settled amount.. Valid values are `debit|credit`',
    `approval_reference` STRING COMMENT 'Internal reference to the approval workflow or ticket that authorized the adjustment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Exact time when the adjustment was approved.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the adjustment has passed all regulatory compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the adjustment becomes effective for accounting and reporting.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee component associated with the adjustment, if any.',
    `fee_currency` STRING COMMENT 'Currency of the fee amount.. Valid values are `^[A-Z]{3}$`',
    `identifier` STRING COMMENT 'Human‑readable unique code assigned to the adjustment (e.g., ADJ‑20230915‑001).',
    `notes` STRING COMMENT 'Free‑form comments or justification for the adjustment.',
    `original_amount` DECIMAL(18,2) COMMENT 'The settled amount before the adjustment was applied.',
    `original_currency` STRING COMMENT 'Currency of the original settled amount.. Valid values are `^[A-Z]{3}$`',
    `reason_code` STRING COMMENT 'Standardized code describing why the adjustment was made.. Valid values are `error_correction|late_presentment|fee_credit|scheme_correction|reversal|other`',
    `reversal_indicator` BOOLEAN COMMENT 'True if this adjustment represents a reversal of a prior adjustment.',
    `sequence` STRING COMMENT 'Ordinal number of the adjustment within the same settlement batch.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the adjustment (e.g., Transaction Processing Platform).',
    `updated_by` STRING COMMENT 'User identifier of the person or service that last modified the adjustment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjustment record.',
    `created_by` STRING COMMENT 'User identifier of the person or service that created the adjustment.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Record of post-settlement adjustments applied to correct errors, process late presentments, apply fee credits, or handle scheme-mandated corrections. Captures adjustment type (debit, credit), adjustment reason code, original settlement reference, adjusted amount, currency, approval reference, and effective date. Provides full audit trail for settlement corrections.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Primary key for settlement',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: Settlements are originated by acquiring banks. Linking settlement to acquirer enables acquirer-level settlement tracking, daily limit enforcement, and regulatory reporting by acquiring institution.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Each settlement event is governed by a partner agreement specifying settlement terms, fee rates, and regulatory obligations. Contract compliance reporting and fee validation require direct linkage fro',
    `cycle_id` BIGINT COMMENT 'Reference to the settlement cycle that groups this settlement.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the primary participant (e.g., acquiring bank, issuing bank, or scheme) involved in the settlement.',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: REQUIRED: Settlements apply FX‑related fee schedules; linking enables fee calculation and compliance reporting.',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to settlement.instruction. Business justification: settlement.instruction_reference is a STRING denormalization of the instruction that executes the settlement. Replacing with instruction_id FK normalizes the relationship and enables direct joins to i',
    `net_position_id` BIGINT COMMENT 'Reference to the net position record used for netting calculations.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: Settlements are transmitted over a specific network endpoint. This link supports endpoint-level settlement volume analysis, network connectivity reporting, and incident root-cause analysis for settlem',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: Cross-border settlement fund movements are executed via nostro accounts; treasury operations and regulatory liquidity reporting require direct linkage between settlement records and the nostro account',
    `original_settlement_id` BIGINT COMMENT 'Self-referencing FK on settlement (original_settlement_id)',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: A settlement record represents the settlement obligation between participants. Linking settlement to participant identifies the primary participant (acquirer, issuer, or scheme) for the settlement, en',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: Settlements are processed under specific interchange programs (commercial card, debit, rewards) that determine settlement rules and rates. Program-level settlement reporting and program-specific settl',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: Settlements are executed over a specific network rail determined by routing rules. rail_details and rail_type on settlement are routing-table-driven. Rail performance analysis and routing optimization',
    `scheme_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to network.scheme_fee_schedule. Business justification: Settlement fee_amount is governed by the scheme fee schedule. This link enables scheme fee reconciliation reports and scheme billing validation — a mandatory requirement in Visa/Mastercard settlement ',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Each settlement is executed under a specific schemes rules governing settlement method, currency, and regulatory reporting. Scheme-level settlement volume analytics and scheme billing reconciliation ',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Settlements are reconciled against scheme invoices for scheme fee and interchange reimbursement settlement. Settlement-level scheme invoice reconciliation is a mandatory process in card network operat',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the batch file that contains this settlement.',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: Settlement performance reports reference the SLA profile governing gateway latency to ensure contractual compliance.',
    `compliance_flag` BOOLEAN COMMENT 'True if the settlement passed all regulatory compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system.',
    `cycle_timestamp` TIMESTAMP COMMENT 'Timestamp marking the start of the settlement cycle that includes this record.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when converting foreign currency to the settlement currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees deducted from the gross amount.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before fees and adjustments.',
    `is_cross_border` BOOLEAN COMMENT 'True if the settlement involves parties in different countries.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after fees and adjustments, transferred to the participant.',
    `notes` STRING COMMENT 'Additional operational comments or remarks.',
    `processing_mode` STRING COMMENT 'Indicates whether the settlement was processed in batch or real‑time mode.. Valid values are `batch|real_time`',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`settlement`.`acquirer` (
    `acquirer_id` BIGINT COMMENT 'Primary key for acquirer',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Acquirers operating cross-border are subject to acquirer-specific FX fee schedules governing conversion fees charged on cross-border settlement; pricing configuration and acquirer contract management ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Acquirers are legal entities subject to financial reporting, regulatory filings, and entity-level P&L consolidation. Payments fintechs require acquirer-to-legal-entity mapping for scheme compliance re',
    `parent_acquirer_id` BIGINT COMMENT 'Self-referencing FK on acquirer (parent_acquirer_id)',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Acquirer risk profiling drives max_daily_settlement_amount, settlement_currency eligibility, and regulatory_status decisions. risk_rating on acquirer is a denormalization of risk_profile.risk_tier. Do',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Acquirers are certified and operate under specific payment schemes. The scheme governs the acquirers settlement currency, method, and compliance_certifications. Scheme-level acquirer reporting and ce',
    `acquirer_name` STRING COMMENT 'Legal name of the acquiring institution.',
    `acquirer_status` STRING COMMENT 'Current lifecycle status of the acquirer.',
    `acquirer_type` STRING COMMENT 'Category of the acquirer (e.g., bank, non‑bank, fintech, processor).',
    `acronym` STRING COMMENT 'Acronym or abbreviation of the acquirer.',
    `address_line1` STRING COMMENT 'First line of the acquirers registered address.',
    `address_line2` STRING COMMENT 'Second line of the address (optional).',
    `city` STRING COMMENT 'City of the acquirers registered address.',
    `contact_email` STRING COMMENT 'Primary contact email address for the acquirer.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the acquirer.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the acquirer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the acquirer record was first created.',
    `daily_settlement_limit_currency` STRING COMMENT 'Currency of the daily settlement limit.',
    `effective_from` DATE COMMENT 'Date when the acquirer became effective for settlement.',
    `effective_until` DATE COMMENT 'Date when the acquirer ceases to be effective (null if ongoing).',
    `is_preferred` BOOLEAN COMMENT 'Indicates if this acquirer is the preferred partner for routing.',
    `max_daily_settlement_amount` DECIMAL(18,2) COMMENT 'Maximum total settlement amount allowed per day for this acquirer.',
    `notes` STRING COMMENT 'Free‑text notes regarding the acquirer.',
    `onboarding_date` DATE COMMENT 'Date when the acquirer was onboarded into the system.',
    `postal_code` STRING COMMENT 'Postal code of the acquirers address.',
    `regulatory_status` STRING COMMENT 'Regulatory compliance status of the acquirer.',
    `settlement_currency` STRING COMMENT 'ISO 4217 currency code used for settlements with this acquirer.',
    `settlement_cutoff_time` TIMESTAMP COMMENT 'Daily cutoff time (HH:MM) for settlement processing.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle frequency.',
    `settlement_method` STRING COMMENT 'Primary settlement method supported by the acquirer.',
    `short_name` STRING COMMENT 'Commonly used short name or brand for the acquirer.',
    `state_province` STRING COMMENT 'State or province of the acquirers address.',
    `support_contact_email` STRING COMMENT 'Email address of the support contact.',
    `support_contact_name` STRING COMMENT 'Name of the primary support contact person for the acquirer.',
    `support_contact_phone` STRING COMMENT 'Phone number of the support contact.',
    `termination_date` DATE COMMENT 'Date when the relationship with the acquirer was terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the acquirer record.',
    `website_url` STRING COMMENT 'Official website URL of the acquirer.',
    CONSTRAINT pk_acquirer PRIMARY KEY(`acquirer_id`)
) COMMENT 'Master reference table for acquirer. Referenced by originating_acquirer_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_receiving_party_settlement_participant_id` FOREIGN KEY (`receiving_party_settlement_participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_reversal_of_instruction_id` FOREIGN KEY (`reversal_of_instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_settlement_account_id` FOREIGN KEY (`settlement_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_account`(`settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_clearing_record_id` FOREIGN KEY (`clearing_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`clearing_record`(`clearing_record_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_duplicate_of_record_reconciliation_record_id` FOREIGN KEY (`duplicate_of_record_reconciliation_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`reconciliation_record`(`reconciliation_record_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_funding_confirmation_id` FOREIGN KEY (`funding_confirmation_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`funding_confirmation`(`funding_confirmation_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_merchant_payout_id` FOREIGN KEY (`merchant_payout_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`merchant_payout`(`merchant_payout_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_funding_schedule_id` FOREIGN KEY (`funding_schedule_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`funding_schedule`(`funding_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_settlement_account_id` FOREIGN KEY (`settlement_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_account`(`settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_settlement_account_id` FOREIGN KEY (`settlement_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_account`(`settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_reserve_account_id` FOREIGN KEY (`reserve_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`reserve_account`(`reserve_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_clearing_record_id` FOREIGN KEY (`clearing_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`clearing_record`(`clearing_record_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_funding_confirmation_id` FOREIGN KEY (`funding_confirmation_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`funding_confirmation`(`funding_confirmation_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_merchant_payout_id` FOREIGN KEY (`merchant_payout_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`merchant_payout`(`merchant_payout_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_clearing_record_id` FOREIGN KEY (`clearing_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`clearing_record`(`clearing_record_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_settlement_exception_id` FOREIGN KEY (`settlement_exception_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_exception`(`settlement_exception_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_net_position_id` FOREIGN KEY (`net_position_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`net_position`(`net_position_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_original_settlement_id` FOREIGN KEY (`original_settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ADD CONSTRAINT `fk_settlement_acquirer_parent_acquirer_id` FOREIGN KEY (`parent_acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`settlement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`settlement` SET TAGS ('dbx_domain' = 'settlement');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Paying Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `receiving_party_settlement_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `reversal_of_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Instruction Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Paying Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Instruction Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `currency_conversion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Instruction Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code (ISO 4217)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Instruction Version Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Participant B ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `exposure_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant A ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` SET TAGS ('dbx_subdomain' = 'funding_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `funding_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Confirmation ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Bank ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Comments');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Reference Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Clearing Record ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `clearing_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Record Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `bin_interchange_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Interchange Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `authorization_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` SET TAGS ('dbx_subdomain' = 'reconciliation_control');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `reconciliation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Record ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `clearing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `downgrade_id` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `duplicate_of_record_reconciliation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Of Record ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `funding_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Confirmation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `merchant_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Payout Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` SET TAGS ('dbx_subdomain' = 'funding_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for settlement_account');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Party Identifier (Owner Party ID)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `partner_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` SET TAGS ('dbx_subdomain' = 'funding_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reserve Account ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `funding_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'AML Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Reserve Balance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Reserve Balance');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `held_amount` SET TAGS ('dbx_business_glossary_term' = 'Held Amount (Monetary)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `last_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Release Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `next_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Release Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_value_regex' = 'required|exempt');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `release_interval` SET TAGS ('dbx_business_glossary_term' = 'Release Interval');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `release_interval` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Number');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_name` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reserve Percentage');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `reserve_type` SET TAGS ('dbx_value_regex' = 'rolling|capped|fixed');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `settlement_reserve_account_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Account Status');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `settlement_reserve_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` SET TAGS ('dbx_subdomain' = 'funding_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `funding_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `partner_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `deduction_sequence` SET TAGS ('dbx_business_glossary_term' = 'Funding Deduction Sequence');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Code');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Name');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Type');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|t+1|t+2|t+n');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` SET TAGS ('dbx_subdomain' = 'funding_management');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `merchant_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Payout ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `msf_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Msf Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `partner_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `pricing_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Exception Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `reserve_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reserve Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `underwriting_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Pass Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Payout Reference');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` SET TAGS ('dbx_subdomain' = 'reconciliation_control');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `settlement_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Exception ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Settlement Instruction ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `clearing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `downgrade_id` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `funding_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Confirmation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `merchant_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Payout Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `exposure_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` SET TAGS ('dbx_subdomain' = 'reconciliation_control');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `clearing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `downgrade_id` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `settlement_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Exception Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Sequence');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Participant ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `net_position_id` SET TAGS ('dbx_business_glossary_term' = 'Net Position ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `original_settlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `cycle_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Timestamp');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `processing_mode` SET TAGS ('dbx_business_glossary_term' = 'Processing Mode');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ALTER COLUMN `processing_mode` SET TAGS ('dbx_value_regex' = 'batch|real_time');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `parent_acquirer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
