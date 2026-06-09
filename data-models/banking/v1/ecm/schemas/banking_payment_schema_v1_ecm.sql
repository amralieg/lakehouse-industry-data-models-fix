-- Schema for Domain: payment | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`payment` COMMENT 'Payment processing and settlement covering ACH, wire transfers, RTGS, SWIFT messaging, FX transactions, card payments, and cross-border payments. Manages payment instructions, clearing, T+1 settlement cycles, payment routing, nostro/vostro reconciliation, and SWIFT message lifecycle. Primary system of record aligned with ACI Worldwide / Volante Payment Hub.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`instruction` (
    `instruction_id` BIGINT COMMENT 'Unique identifier for the payment instruction record. Primary key.',
    `beneficiary_account_id` BIGINT COMMENT 'Identifier of the account to which the payment is being credited (payee account).',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Payment instructions require pre-payment credit risk assessment of beneficiaries for large-value payments, sanctions screening escalations, and credit exposure monitoring. Banking operations perform c',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Beneficiary country drives sanctions screening (OFAC country-based sanctions), cross-border reporting (FFIEC 009), routing decisions (local rails vs correspondent), and AML risk scoring. Country maste',
    `beneficiary_id` BIGINT COMMENT 'Foreign key linking to payment.beneficiary. Business justification: payment_instruction has beneficiary_name, beneficiary_iban, beneficiary_bic which should be normalized to a FK to beneficiary.beneficiary_id. This is a standard N:1 relationship where many payment ins',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Offering settlement instructions for issuer proceeds payment and investor allocation settlements. Required for capital markets offering settlement coordination and securities issuance payment processi',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: Payment instructions settle trade transactions in DVP/RVP operations. Banking operations require linking payment rails to trade settlement for operational control, regulatory reporting (MiFID II trans',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: ISO 20022 purpose codes (SALA for salary, PENS for pension, SUPP for supplier payment) required for SEPA, TARGET2, and cross-border regulatory reporting. Code_list provides code hierarchy and regulato',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Payment processing costs allocated to cost centers for management accounting and profitability analysis. Required for activity-based costing, transfer pricing, and business unit P&L reporting.',
    `ctr_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.ctr_filing. Business justification: Large cash payment instructions trigger Currency Transaction Report filing requirements under Bank Secrecy Act. Links instruction to CTR for regulatory filing evidence, aggregation logic validation, a',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Investment banking deals (M&A, IPO, debt issuance) generate payment instructions for transaction settlements, advisory fee payments, and underwriting proceeds distribution. Core operational link betwe',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the account from which the payment is being debited (payer account).',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Fraud alerts generated during real-time payment screening require linkage to source instruction for analyst review, disposition tracking, and false positive analysis. Core real-time fraud detection pr',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Payment instructions identified as fraudulent are recorded as incidents for loss tracking, trend analysis, and regulatory reporting. Essential for payment fraud incident management and Basel operation',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Payment instructions must post to GL accounts for financial statement preparation and regulatory reporting. Every payment creates debit/credit entries in the general ledger. Essential for financial cl',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Settlement date calculation requires holiday calendar for payment rail and currency (e.g., TARGET2 for EUR, Fedwire for USD). Holiday calendar provides business day convention and partial day handling',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this payment instruction for processing.',
    `instruction_employee_id` BIGINT COMMENT 'Identifier of the user or system that submitted this payment instruction.',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to payment.correspondent_bank. Business justification: payment_instruction has intermediary_bank_bic which should reference correspondent_bank. For cross-border payments, an intermediary correspondent bank is often required. This is a standard N:1 lookup ',
    `investment_syndication_id` BIGINT COMMENT 'Foreign key linking to investment.syndication. Business justification: Syndication commitment funding and lender payment distributions generate payment instructions. Required for syndicated loan settlement processing, agent bank payment coordination, and participant lend',
    `nostro_account_id` BIGINT COMMENT 'Identifier of the nostro account (our account held at another bank) used for settlement of this payment.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Payment instructions originate through specific banking channels (branch, online banking, mobile app, relationship manager). Channel attribution is essential for operational analytics, channel-specifi',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Payment origination tracking requires linking instruction to customer party for AML transaction monitoring, customer payment history reporting, and regulatory audit trails. Originator_name is denormal',
    `payment_channel_id` BIGINT COMMENT 'Foreign key linking to payment.payment_channel. Business justification: payment_instruction has payment_rail_type which should reference payment_channel. payment_channel is the master registry of available payment rails (ACH, Fedwire, RTGS, SWIFT). This is a standard N:1 ',
    `payment_mandate_id` BIGINT COMMENT 'Foreign key linking to payment.payment_mandate. Business justification: For direct debit and recurring payments, the payment_instruction should reference the standing payment_mandate that authorizes it. This is a standard N:1 relationship where many payment instructions a',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Payment instructions classified by product (wire, ACH, RTP, SEPA) for fee calculation, risk weighting (operational risk capital), and regulatory reporting (FFIEC 002 payment volume). Product_type prov',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Every payment instruction undergoes real-time sanctions screening before execution per OFAC requirements. Links instruction to screening event for regulatory audit trail, blocking decisions, and false',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities settlement payments (DVP/RVP) require linking payment instructions to the instrument being settled. Critical for trade settlement, regulatory reporting (MiFID II transaction reporting), and',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Settlement currency validation against ISO 4217 master required for SWIFT message generation, nostro/vostro account selection, regulatory reporting (FFIEC 009, 031). Payment_currency denormalized text',
    `settlement_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.settlement_instruction. Business justification: Payment instructions execute settlement instructions for securities trades in DVP/RVP workflows. Required for matching cash and securities movements, settlement fail management, and CSDR penalty calcu',
    `underwriting_id` BIGINT COMMENT 'Foreign key linking to investment.underwriting. Business justification: Underwriting settlement instructions for proceeds payment to issuer and syndicate member settlements. Required for capital markets offering settlement processing and underwriting commitment cash movem',
    `vostro_account_id` BIGINT COMMENT 'Identifier of the vostro account (their account held at our bank) used for settlement of this payment.',
    `aml_screening_status` STRING COMMENT 'Status of AML screening for this payment instruction (Pending, Cleared, Flagged, Blocked).. Valid values are `PENDING|CLEARED|FLAGGED|BLOCKED`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment instruction was approved for execution.',
    `charge_bearer` STRING COMMENT 'Indicates which party bears the transaction charges: OUR (originator pays all), BEN (beneficiary pays all), SHA (shared).. Valid values are `OUR|BEN|SHA`',
    `clearing_system_reference` STRING COMMENT 'Reference number assigned by the clearing system (e.g., ACH, RTGS) during payment processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment instruction record was first created in the system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged for processing this payment instruction.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied for currency conversion in cross-currency payments.',
    `instruction_status` STRING COMMENT 'Current lifecycle status of the payment instruction (Pending, Validated, Submitted, In Clearing, Settled, Rejected, Cancelled). [ENUM-REF-CANDIDATE: PENDING|VALIDATED|SUBMITTED|IN_CLEARING|SETTLED|REJECTED|CANCELLED — 7 candidates stripped; promote to reference product]',
    `instruction_timestamp` TIMESTAMP COMMENT 'The date and time when the payment instruction was created or initiated by the originator.',
    `intermediary_bank_bic` STRING COMMENT 'Bank Identifier Code of any intermediary or correspondent bank involved in routing this payment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment instruction record was last updated or modified.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Net amount settled after deducting fees and charges from the gross payment amount.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount of the payment instruction before any fees or charges.',
    `payment_priority` STRING COMMENT 'Priority level assigned to the payment instruction for processing sequence (Normal, High, Urgent).. Valid values are `NORMAL|HIGH|URGENT`',
    `payment_rail_type` STRING COMMENT 'The payment rail or network through which this instruction will be executed (ACH, Wire, RTGS, SWIFT, FX, Card, Cross-Border). [ENUM-REF-CANDIDATE: ACH|WIRE|RTGS|SWIFT|FX|CARD|CROSS_BORDER — 7 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this payment instruction for tracking and reconciliation purposes.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this payment instruction requires regulatory reporting (e.g., CTR, FATCA, CRS).',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for rejection if the payment instruction was rejected.',
    `rejection_reason_description` STRING COMMENT 'Detailed textual description of why the payment instruction was rejected.',
    `remittance_information` STRING COMMENT 'Unstructured or structured information provided by the originator to identify the payment to the beneficiary (e.g., invoice number, reference).',
    `routing_code` STRING COMMENT 'Routing or sort code used to direct the payment to the correct financial institution or branch.',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions screening against OFAC and other watchlists for this payment instruction.. Valid values are `PENDING|CLEARED|FLAGGED|BLOCKED`',
    `settlement_date` DATE COMMENT 'The actual date on which the payment was settled and funds transferred between accounts.',
    `settlement_method` STRING COMMENT 'Method used for settling the payment: RTGS (Real-Time Gross Settlement), DNS (Deferred Net Settlement), BATCH (Batch Processing).. Valid values are `RTGS|DNS|BATCH`',
    `swift_message_type` STRING COMMENT 'SWIFT message type code used for this payment instruction (e.g., MT103, MT202, pain.001).',
    `swift_uetr` STRING COMMENT 'Unique end-to-end transaction reference assigned by SWIFT for tracking the payment across the correspondent banking chain.',
    `value_date` DATE COMMENT 'The date on which the payment amount should be credited to the beneficiary account (effective date for settlement).',
    CONSTRAINT pk_instruction PRIMARY KEY(`instruction_id`)
) COMMENT 'Core master record for every payment instruction initiated across all payment rails (ACH, wire, RTGS, SWIFT, FX, card, cross-border). Captures originator, beneficiary, amount, currency, value date, payment type, priority, routing details, IBAN/BIC/SWIFT identifiers, and instruction lifecycle status. Primary entity sourced from ACI Worldwide / Volante Payment Hub. SSOT for payment intent before execution.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`payment_transaction` (
    `payment_transaction_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment transaction entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Transactions must be assigned to accounting periods for financial close, period-end reporting, and revenue recognition. Required for cutoff testing, audit, and SOX compliance.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Transaction testing is core to payment audits. Auditors sample transactions to test control effectiveness, reconciliation accuracy, fraud detection, and regulatory reporting. Real-world audit programs',
    `batch_id` BIGINT COMMENT 'Identifier for the payment batch or file in which this transaction was submitted for processing.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Capital markets offerings (IPO, bond issuance) generate payment transactions for proceeds distribution to issuer and investor allocation settlements. Core settlement link for securities issuance and o',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: Every securities trade generates payment transactions for cash leg settlement. Essential for trade lifecycle management, settlement risk monitoring, and P&L reconciliation between trading and treasury',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Transaction-level purpose code required for sanctions screening (trade finance vs personal remittance), AML monitoring (cash-intensive business codes), and regulatory reporting (FFIEC 009 purpose brea',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Payment transactions create counterparty credit exposure that must be aggregated for credit risk reporting, regulatory capital calculations (SA-CCR), and credit limit monitoring. Real-world banks trac',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Transaction currency drives FX conversion logic, fee calculation, regulatory reporting. Every payment system validates currency codes against reference master for settlement processing and cross-borde',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Securities settlement requires cash movement through payment rails to/from custodian accounts. Treasury operations execute dividend payments, subscription/redemption settlements, and fee debits agains',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Payment transactions initiated through digital/branch sessions require session linkage for fraud detection (device fingerprint, IP analysis), customer journey mapping, channel attribution for pricing/',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Deal settlements, advisory fees, and transaction proceeds flow through payment transactions. Essential for tracking deal-related cash movements, revenue recognition, and reconciliation of investment b',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Transaction monitoring systems generate fraud alerts requiring direct transaction linkage for investigation, disposition, and rule tuning. Essential for transaction monitoring and fraud detection oper',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Payment transactions are primary evidence in fraud investigations. Direct linkage enables loss calculation, recovery tracking, and SAR filing. Essential for fraud case investigation and resolution wor',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Payment transactions confirmed as fraudulent are recorded as incidents for loss calculation, recovery tracking, and fraud analytics. Core fraud incident recording and loss management process.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Payment transactions generate accounting entries to GL accounts for financial reporting. Required for trial balance, financial statements, and audit trail. Distinct from deposit_account FKs which refe',
    `instruction_id` BIGINT COMMENT 'Reference to the originating payment instruction that spawned this transaction. One instruction may produce multiple transactions (e.g., FX legs, split settlements).',
    `investment_syndication_id` BIGINT COMMENT 'Foreign key linking to investment.syndication. Business justification: Syndicated loan drawdowns, repayments, and interest payments flow through payment transactions. Core operational link for syndicated lending settlement, lender payment distribution, and loan servicing',
    `nostro_account_id` BIGINT COMMENT 'Reference to the nostro account (our account held at another bank) used for correspondent banking settlement.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the account from which funds are debited in this transaction.',
    `party_id` BIGINT COMMENT 'Reference to the customer initiating the payment transaction.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Payment transactions settling securities trades must reference the instrument for accurate trade lifecycle tracking, settlement matching, and regulatory reporting. Enables linking cash settlement to s',
    `settlement_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.settlement_instruction. Business justification: Payment transactions fulfill settlement instructions for trade settlements. Enables real-time settlement status tracking, nostro/vostro reconciliation, and settlement fail resolution. Critical for ope',
    `vostro_account_id` BIGINT COMMENT 'Reference to the vostro account (their account held at our bank) used for correspondent banking settlement.',
    `aml_alert_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_alert. Business justification: Transactions are primary detection point for AML alerts in transaction monitoring systems. Links transaction to alert for investigation workflow, SAR filing decisions, and regulatory examination evide',
    `aml_screening_status` STRING COMMENT 'Status of Anti-Money Laundering screening for this payment transaction.. Valid values are `Passed|Failed|Review|Pending`',
    `amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the payment transaction before any fees or adjustments.',
    `clearing_house_reference` STRING COMMENT 'Unique reference number assigned by the clearing house (e.g., ACH operator, SWIFT network) for tracking and reconciliation.',
    `correspondent_bank_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the correspondent bank involved in the payment routing.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment transaction record was first created in the system.',
    `cross_border_flag` BOOLEAN COMMENT 'Boolean indicator of whether this is a cross-border payment transaction involving multiple jurisdictions.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert transaction currency to settlement currency. Null for same-currency transactions.',
    `execution_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment transaction was executed and entered the clearing process.',
    `failure_reason_code` STRING COMMENT 'Standardized code indicating the reason for transaction failure or rejection (e.g., insufficient funds, invalid account, compliance hold).',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged for processing this payment transaction, including clearing house fees, intermediary bank fees, and service charges.',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fee amount.. Valid values are `^[A-Z]{3}$`',
    `intermediary_bank_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of any intermediary bank in the payment chain.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `net_settlement_position` DECIMAL(18,2) COMMENT 'The net position of the transaction after multilateral netting with other transactions in the same settlement batch.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used for this transaction (ACH, Wire, RTGS, SWIFT, Card, FX, Check). [ENUM-REF-CANDIDATE: ACH|Wire|RTGS|SWIFT|Card|FX|Check — 7 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of the payment transaction type: Credit (incoming funds), Debit (outgoing funds), Return, Reversal, or Adjustment.. Valid values are `Credit|Debit|Return|Reversal|Adjustment`',
    `reference_number` STRING COMMENT 'Externally visible unique reference number for this payment transaction, used for reconciliation and customer inquiries.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator of whether this transaction requires regulatory reporting (e.g., CTR, SAR, FATCA, CRS).',
    `remittance_information` STRING COMMENT 'Unstructured or structured information provided by the originator to identify the purpose of the payment to the beneficiary.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for payment return (e.g., account closed, unauthorized, incorrect account number).',
    `routing_priority` STRING COMMENT 'Priority level assigned to the payment transaction for routing and processing (High, Normal, Low).. Valid values are `High|Normal|Low`',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions list screening (OFAC, UN, EU) for this payment transaction.. Valid values are `Passed|Failed|Review|Pending`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The final net amount settled after applying exchange rates, fees, and adjustments.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement amount, which may differ from transaction currency in FX transactions.. Valid values are `^[A-Z]{3}$`',
    `settlement_cycle` STRING COMMENT 'The settlement cycle designation indicating the number of business days between trade date and settlement date (T+0, T+1, T+2, T+3).. Valid values are `T0|T1|T2|T3`',
    `settlement_date` DATE COMMENT 'The date on which the payment transaction is settled and funds are finalized. Typically follows T+1 settlement cycle.',
    `settlement_status` STRING COMMENT 'Final settlement status indicating whether funds have been successfully transferred and reconciled.. Valid values are `Unsettled|Settled|PartiallySettled|SettlementFailed`',
    `settlement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment transaction was fully settled and reconciled.',
    `swift_message_type` STRING COMMENT 'SWIFT message type code (e.g., MT103, MT202) for SWIFT-based payment transactions.. Valid values are `^MT[0-9]{3}$`',
    `swift_uetr` STRING COMMENT 'Universally unique identifier for end-to-end tracking of SWIFT payment transactions across correspondent banks.. Valid values are `^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the payment transaction in the clearing and settlement process.. Valid values are `Pending|Cleared|Settled|Failed|Rejected|Cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payment transaction record was last modified.',
    `value_date` DATE COMMENT 'The date from which funds are available for use by the beneficiary, which may differ from settlement date.',
    CONSTRAINT pk_payment_transaction PRIMARY KEY(`payment_transaction_id`)
) COMMENT 'Transactional record capturing the execution of a payment instruction through the clearing and settlement lifecycle. Records actual debit/credit entries, settlement date, settlement amount, exchange rate applied, net settlement position, T+1 cycle tracking, clearing house reference, and final settlement status. One instruction may produce one or more transactions (e.g., FX legs). SSOT for executed payment events.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`swift_message` (
    `swift_message_id` BIGINT COMMENT 'Unique identifier for the SWIFT message record in the lakehouse. Primary key.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: SWIFT message audits are regulatory requirements for correspondent banking. Auditors review message logs for sanctions screening, settlement timeliness, GPI tracker accuracy, and operational risk cont',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: SWIFT messages are evidence in cross-border payment fraud investigations. Direct linkage enables investigation workflow, correspondent bank notification, and regulatory reporting. Essential for intern',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: SWIFT messages are sent/received by specific legal entities for regulatory reporting, sanctions compliance, and legal liability tracking. Required for entity-level financial reporting and audit.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key reference to the nostro account (the banks account held at a correspondent bank) used for settlement of this transaction. Nullable if not applicable.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: SWIFT messages can be initiated through multiple channels (relationship manager platform, corporate banking portal, branch system). Channel attribution needed for audit trails, compliance reporting, o',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key reference to the internal payment record in the payment processing system that this SWIFT message relates to.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: SWIFT messages screened for sanctioned entities (OFAC, UN, EU lists) before transmission to prevent prohibited transactions. Links message to screening event for blocking decisions, regulatory reporti',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: SWIFT MT54x messages (securities settlement) reference the instrument being settled. Required for automated settlement matching, nostro reconciliation, and securities settlement reporting to regulator',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: SWIFT sender country determines regulatory reporting obligations (EU GDPR for data residency, US OFAC for sanctions), message routing priority, and GPI tracking requirements. Country master provides t',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: SWIFT MT103/202 messages require ISO 4217 currency code validation. Message parsing, sanctions screening, and GPI tracking depend on currency master for minor unit precision and settlement lag calcula',
    `acknowledgement_status` STRING COMMENT 'Indicates whether the message has been acknowledged (ACK) or negatively acknowledged (NACK) by the receiving institution, or if acknowledgement is pending or not required.. Valid values are `ack|nack|pending|not_required`',
    `aml_screening_status` STRING COMMENT 'Status of AML screening performed on the SWIFT message. Indicates whether the message passed screening, was flagged for review, or is pending screening.. Valid values are `passed|flagged|pending|not_screened`',
    `beneficiary_account` STRING COMMENT 'The account number or IBAN of the beneficiary receiving the payment.',
    `beneficiary_bank_bic` STRING COMMENT 'The BIC of the beneficiarys bank where the funds are to be credited.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `beneficiary_name` STRING COMMENT 'The name of the beneficiary or recipient of the payment.',
    `charges_code` STRING COMMENT 'Indicates who bears the transaction charges. OUR: sender pays all charges; BEN: beneficiary pays all charges; SHA: charges are shared.. Valid values are `OUR|BEN|SHA`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SWIFT message record was first created in the lakehouse.',
    `credit_confirmation_timestamp` TIMESTAMP COMMENT 'The timestamp when the beneficiary bank confirmed that funds were credited to the beneficiary account. Part of SWIFT GPI tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied if the transaction involves currency conversion. Nullable if no FX conversion occurred.',
    `gpi_status_code` STRING COMMENT 'The SWIFT GPI status code indicating the current state of the payment in the GPI tracking system. Common codes: g001 (credit to beneficiary), g002 (funds available), g004 (payment completed).. Valid values are `^g[0-9]{3}$`',
    `gpi_tracker_timestamp` TIMESTAMP COMMENT 'The timestamp when the payment status was last updated in the SWIFT GPI tracking system.',
    `intermediary_bank_bic` STRING COMMENT 'The BIC of any intermediary or correspondent bank involved in routing the payment. Nullable if no intermediary is used.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `message_body` STRING COMMENT 'The complete payload of the SWIFT message in its native format (MT or MX/XML). Contains all transaction details, beneficiary information, and payment instructions.',
    `message_direction` STRING COMMENT 'Indicates whether the message was sent by the bank (outbound) or received by the bank (inbound).. Valid values are `inbound|outbound`',
    `message_processed_timestamp` TIMESTAMP COMMENT 'The timestamp when the SWIFT message was processed and posted to internal systems (e.g., core banking, payment hub).',
    `message_received_timestamp` TIMESTAMP COMMENT 'The timestamp when the SWIFT message was received by the destination institution.',
    `message_reference` STRING COMMENT 'The unique reference number assigned to the SWIFT message by the sender. Used for message tracking and reconciliation.',
    `message_sent_timestamp` TIMESTAMP COMMENT 'The timestamp when the SWIFT message was sent by the originating institution.',
    `message_status` STRING COMMENT 'Current processing status of the SWIFT message in its lifecycle. Tracks acknowledgement, delivery confirmation, and any failure states.. Valid values are `pending|acknowledged|delivered|failed|rejected|cancelled`',
    `message_type` STRING COMMENT 'The SWIFT message type identifier. For MT messages: MT103, MT202, MT900, MT910, etc. For MX (ISO 20022) messages: pacs.008, camt.054, pain.001, etc.. Valid values are `^(MT|MX)[0-9]{3}$|^[a-z]{4}.[0-9]{3}.[0-9]{3}.[0-9]{2}$`',
    `ordering_customer_account` STRING COMMENT 'The account number or IBAN of the customer initiating the payment.',
    `ordering_customer_name` STRING COMMENT 'The name of the customer or entity initiating the payment instruction.',
    `priority_code` STRING COMMENT 'Indicates the priority level of the SWIFT message. NORM: normal priority; URGP: urgent priority; HIGH: high priority.. Valid values are `NORM|URGP|HIGH`',
    `receiver_bic` STRING COMMENT 'The BIC (Bank Identifier Code) of the financial institution receiving the SWIFT message. 8 or 11 character ISO 9362 code.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `regulatory_reporting_code` STRING COMMENT 'Code used for regulatory reporting purposes, such as purpose of payment codes required by central banks or tax authorities (e.g., FATCA, CRS reporting codes).',
    `related_reference` STRING COMMENT 'Reference to a related SWIFT message, such as the original message being amended, cancelled, or queried. Nullable if not applicable.',
    `remittance_information` STRING COMMENT 'Free-text field containing payment details, invoice references, or other information provided by the ordering customer for the beneficiary.',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions screening performed on parties and banks involved in the SWIFT message. Indicates whether any sanctions list hits were detected.. Valid values are `cleared|hit|pending|not_screened`',
    `sender_bic` STRING COMMENT 'The BIC (Bank Identifier Code) of the financial institution sending the SWIFT message. 8 or 11 character ISO 9362 code.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `sender_charges_amount` DECIMAL(18,2) COMMENT 'The amount of charges deducted by the sending bank or intermediary banks during message processing.',
    `sender_charges_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the sender charges amount.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'The date on which the payment is settled between correspondent banks or through the clearing system.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the payment or transaction specified in the SWIFT message.',
    `uetr` STRING COMMENT 'The UETR is a universally unique identifier (UUID v4) that enables end-to-end tracking of payment messages across the SWIFT network, particularly for SWIFT GPI transactions.. Valid values are `^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this SWIFT message record was last updated in the lakehouse.',
    `value_date` DATE COMMENT 'The date on which the funds are to be made available to the beneficiary or when the transaction becomes effective.',
    CONSTRAINT pk_swift_message PRIMARY KEY(`swift_message_id`)
) COMMENT 'Full lifecycle record of SWIFT messages exchanged over the SWIFT network, including MT and MX (ISO 20022) message types (MT103, MT202, MT900, MT910, pacs.008, camt.054). Captures message type, sender BIC, receiver BIC, message reference, UETR (Unique End-to-End Transaction Reference), message body, acknowledgement status, processing timestamps, and SWIFT GPI tracking data (GPI status g001/g002/g004, per-hop bank timestamps, per-hop deducted fees, per-hop FX rates, final credit confirmation). Sourced from Volante SWIFT messaging module. Enables real-time cross-border payment tracking per SWIFT GPI standards.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Unique identifier for the payment status event record. Primary key for the immutable event log.',
    `nostro_account_id` BIGINT COMMENT 'Identifier of the nostro account (banks account held at another bank) used for settlement of this payment. Relevant for cross-border and correspondent banking payments. Null for domestic ACH or internal transfers.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Payment status events need channel context for monitoring channel-specific processing performance, SLA compliance by channel, and operational analytics. Enables channel-level performance dashboards an',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Status event reporting and exception dashboards aggregate by currency. SLA breach analysis and liquidity monitoring require currency master for multi-currency position aggregation and regulatory repor',
    `payment_transaction_id` BIGINT COMMENT 'Identifier of the payment transaction to which this status event applies. Links this event to the parent payment instruction.',
    `employee_id` BIGINT COMMENT 'Identifier of the human operator or service account that triggered this event. Null for fully automated STP events. Used for audit trail and accountability.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Status events on securities settlement payments need instrument context for SLA monitoring, client notifications, and settlement fail tracking. Enables securities operations teams to prioritize resolu',
    `swift_message_id` BIGINT COMMENT 'Unique identifier of the payment message (e.g., SWIFT MT103 message ID, ISO 20022 message identification) associated with this event. Used for message-level traceability.',
    `assigned_queue` STRING COMMENT 'Name of the exception handling queue to which this event was routed for manual resolution (e.g., Sanctions Review Queue, Format Validation Queue, High Value Queue). Null for non-exception events or auto-resolved exceptions.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this event to the broader audit trail or compliance log. Used for regulatory audit and forensic investigation.',
    `correspondent_bank_bic` STRING COMMENT 'SWIFT BIC (Bank Identifier Code) of the correspondent or intermediary bank involved in routing this payment. Null for domestic payments not requiring correspondent banking. Format: 8 or 11 alphanumeric characters.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this event record was created and persisted in the payment hub database. Distinct from event_timestamp which represents the business event time. Used for technical audit and data lineage.',
    `event_source_module` STRING COMMENT 'Specific module or component within the payment hub that generated this event (e.g., Payment Validation Engine, Routing Engine, Settlement Engine, Exception Handler, Sanctions Filter). More granular than originating_system.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when this status transition or exception event occurred in the payment processing lifecycle. Recorded in ISO 8601 format with timezone offset.',
    `event_type` STRING COMMENT 'Classification of the event: STATUS_CHANGE (normal lifecycle transition), EXCEPTION (business rule violation or data issue), STP_FAILURE (Straight-Through Processing failure requiring manual intervention), MANUAL_INTERVENTION (operator action), RETRY (automated retry attempt), RESOLUTION (exception resolved).. Valid values are `STATUS_CHANGE|EXCEPTION|STP_FAILURE|MANUAL_INTERVENTION|RETRY|RESOLUTION`',
    `exception_severity` STRING COMMENT 'Severity level of the exception for prioritization and SLA management. CRITICAL (regulatory or high-value payment), HIGH (material impact), MEDIUM (standard exception), LOW (informational). Null for non-exception events.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `exception_type` STRING COMMENT 'Classification of the exception when event_type is EXCEPTION or STP_FAILURE. FORMAT_ERROR (message format or field validation failure), SANCTIONS_HIT (AML/sanctions screening match), DUPLICATE_DETECTION (duplicate payment detected), ROUTING_FAILURE (unable to determine payment route), INSUFFICIENT_FUNDS (payer account balance insufficient), BENEFICIARY_VALIDATION_FAILURE (beneficiary account validation failed). Null for non-exception events.. Valid values are `FORMAT_ERROR|SANCTIONS_HIT|DUPLICATE_DETECTION|ROUTING_FAILURE|INSUFFICIENT_FUNDS|BENEFICIARY_VALIDATION_FAILURE`',
    `max_retry_limit` STRING COMMENT 'Maximum number of automated retries allowed for this payment type before manual intervention is required. Configured per payment channel and exception type.',
    `new_status_code` STRING COMMENT 'The payment status after this event. Uses ISO 20022 external payment status codes. Represents the current state of the payment following this transition. [ENUM-REF-CANDIDATE: INIT|PNDG|ACCP|ACSC|ACSP|ACTC|ACWC|RJCT|CANC|PDNG|PART|ACCC — 12 candidates stripped; promote to reference product]',
    `originating_system` STRING COMMENT 'Name or identifier of the system component that generated this event (e.g., ACI Payment Engine, Volante Routing Module, SWIFT Gateway, Exception Management Module, Sanctions Screening Engine).',
    `payment_amount` DECIMAL(18,2) COMMENT 'The monetary value of the payment transaction associated with this event. Recorded in the payment currency.',
    `payment_channel` STRING COMMENT 'The payment rail or channel through which the payment is being processed: ACH (Automated Clearing House), WIRE (wire transfer), RTGS (Real-Time Gross Settlement), SWIFT (Society for Worldwide Interbank Financial Telecommunication), SEPA (Single Euro Payments Area), FASTER_PAYMENTS (UK Faster Payments), CARD (card payment network), INTERNAL_TRANSFER (intra-bank transfer). [ENUM-REF-CANDIDATE: ACH|WIRE|RTGS|SWIFT|SEPA|FASTER_PAYMENTS|CARD|INTERNAL_TRANSFER — 8 candidates stripped; promote to reference product]',
    `payment_direction` STRING COMMENT 'Direction of the payment flow relative to the bank: OUTBOUND (payment sent from bank to external party), INBOUND (payment received from external party).. Valid values are `OUTBOUND|INBOUND`',
    `prior_status_code` STRING COMMENT 'The payment status immediately before this event. Uses ISO 20022 external payment status codes: INIT (Initiated), PNDG (Pending), ACCP (Accepted Customer Profile), ACSC (Accepted Settlement Completed), ACSP (Accepted Settlement In Process), ACTC (Accepted Technical Validation), ACWC (Accepted With Change), RJCT (Rejected), CANC (Cancelled), PDNG (Pending), PART (Partially Accepted), ACCC (Accepted Settlement Completed Creditor Account). [ENUM-REF-CANDIDATE: INIT|PNDG|ACCP|ACSC|ACSP|ACTC|ACWC|RJCT|CANC|PDNG|PART|ACCC — 12 candidates stripped; promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code explaining why the status transition or exception occurred. Aligns with ISO 20022 reason codes for payment status (e.g., AC01 for incorrect account number, AM05 for duplication, NARR for narrative reason).',
    `reason_description` STRING COMMENT 'Human-readable narrative explaining the reason for the status change or exception. Provides additional context beyond the standardized reason code.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the exception: APPROVED (exception cleared, payment proceeds), REJECTED (payment rejected), CORRECTED (data corrected and resubmitted), ESCALATED (escalated to higher authority), CANCELLED (payment cancelled), RESUBMITTED (resubmitted for processing). Null for unresolved exceptions or non-exception events.. Valid values are `APPROVED|REJECTED|CORRECTED|ESCALATED|CANCELLED|RESUBMITTED`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was resolved. Null for unresolved exceptions or non-exception events. Used to calculate exception handling duration and SLA compliance.',
    `retry_count` STRING COMMENT 'Number of automated retry attempts made for this payment after an STP failure. Zero for first-time processing. Used to track retry logic and prevent infinite loops.',
    `sanctions_screening_result` STRING COMMENT 'Result of AML and sanctions screening for this payment event: CLEAR (no match found), HIT (potential match requiring review), PENDING_REVIEW (screening in progress). Critical for regulatory compliance.. Valid values are `CLEAR|HIT|PENDING_REVIEW`',
    `settlement_date` DATE COMMENT 'The date on which the payment is scheduled to settle or has settled. Follows T+1 or same-day settlement cycles depending on payment channel.',
    `sla_actual_minutes` STRING COMMENT 'The actual time in minutes taken to resolve this event, calculated from event_timestamp to resolution_timestamp. Null for unresolved events. Used for SLA compliance analysis.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this event resulted in a breach of the defined SLA for payment processing or exception resolution. True if SLA was breached, False otherwise. Used for SLA compliance monitoring and reporting.',
    `sla_target_minutes` STRING COMMENT 'The target resolution time in minutes defined by the SLA for this event type and severity. Used to calculate SLA breach status.',
    `transaction_reference` STRING COMMENT 'End-to-end transaction reference provided by the payment originator. Used for reconciliation and customer inquiry. Also known as UETR (Unique End-to-End Transaction Reference) in SWIFT context.',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'Immutable event log capturing every status transition, exception, and STP failure in the payment lifecycle. Records prior status, new status, event timestamp, reason code, originating system, operator identity, and — for exception events — exception type (format error, sanctions hit, duplicate detection, routing failure, insufficient funds), exception severity, assigned queue, handler identity, resolution action taken, resolution timestamp, and SLA breach indicator. Serves as the single source of truth for payment audit trail, STP failure management, exception resolution tracking, and SLA compliance monitoring. Sourced from ACI Worldwide payment hub and exception management module.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`return` (
    `return_id` BIGINT COMMENT 'Unique identifier for the payment return record. Primary key for the payment return entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Return processing requires currency validation for fee calculation, accounting entries, and reconciliation. Return_currency_code denormalized text replaced by FK to currency master for ISO compliance ',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that processed or handled this return transaction.',
    `nostro_account_id` BIGINT COMMENT 'Identifier of the nostro account (our account held at another bank) used for settlement of this return in cross-border or correspondent banking scenarios.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the original payment transaction that is being returned or reversed.',
    `correspondent_bank_id` BIGINT COMMENT 'Identifier of the financial institution that received the original payment and is initiating the return. May be ABA routing number, SWIFT BIC, or internal bank identifier.',
    `return_correspondent_bank_id` BIGINT COMMENT 'Identifier of the financial institution that originated the payment being returned. May be ABA routing number, SWIFT BIC, or internal bank identifier.',
    `addenda_information` STRING COMMENT 'Additional free-form information or notes provided with the return, such as detailed explanation of the return reason or instructions for resubmission.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount being returned to the originator. Typically matches the original payment amount but may differ in partial return scenarios.',
    `beneficiary_account_number` STRING COMMENT 'Account number of the intended beneficiary from which the funds are being returned.',
    `clearing_house_name` STRING COMMENT 'Name of the clearing house or payment network through which the return was processed (e.g., Federal Reserve ACH, The Clearing House, SWIFT, local RTGS system).',
    `clearing_house_reference` STRING COMMENT 'Unique reference number assigned by the clearing house to this return transaction for tracking and reconciliation purposes.',
    `contested_return_flag` BOOLEAN COMMENT 'Indicates whether the return has been contested or disputed by the originating bank.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment return record was first created in the payment processing system.',
    `dishonored_return_flag` BOOLEAN COMMENT 'Indicates whether this is a dishonored return (return of a return), which occurs when the originating bank contests the return.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the receiving bank or clearing house for processing the return transaction.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the return fee amount.. Valid values are `^[A-Z]{3}$`',
    `fraud_indicator_flag` BOOLEAN COMMENT 'Indicates whether the return is associated with suspected fraudulent activity or unauthorized transactions.',
    `notification_date` DATE COMMENT 'Date on which notification of the return was sent to the originator.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of the return has been sent to the payment originator or relevant parties.',
    `original_payment_date` DATE COMMENT 'Business date of the original payment transaction that is being returned.',
    `original_payment_reference` STRING COMMENT 'Business reference number or transaction identifier of the original payment being returned.',
    `originator_account_number` STRING COMMENT 'Account number of the payment originator to which the returned funds will be credited.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the payment return. For ACH: R01-R85 codes (e.g., R01=Insufficient Funds, R02=Account Closed, R03=No Account/Unable to Locate). For SWIFT: return reason codes per MT192/MT196 standards. For RTGS: system-specific reversal codes.',
    `reason_description` STRING COMMENT 'Human-readable description of the return reason providing additional context beyond the standardized code.',
    `reconciliation_status` STRING COMMENT 'Status of nostro/vostro account reconciliation for this return transaction.. Valid values are `unreconciled|reconciled|exception|pending_review`',
    `reference_number` STRING COMMENT 'Unique business reference number assigned to this return transaction by the payment processing system or clearing house.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this return requires regulatory reporting (e.g., for suspicious activity, fraud patterns, or compliance monitoring).',
    `resubmission_count` STRING COMMENT 'Number of times this payment has been resubmitted after previous returns. NACHA rules limit resubmissions to two attempts for certain return codes.',
    `resubmission_eligible_flag` BOOLEAN COMMENT 'Indicates whether the returned payment is eligible for resubmission based on the return reason code. Certain return codes (e.g., R01 NSF) allow resubmission while others (e.g., R02 Account Closed) do not.',
    `return_date` DATE COMMENT 'Business date on which the return was initiated or processed by the receiving bank or clearing house.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return transaction indicating its processing state.. Valid values are `initiated|pending|completed|failed|cancelled|disputed`',
    `return_timestamp` TIMESTAMP COMMENT 'Precise date and time when the return transaction was created or received in the payment processing system.',
    `return_type` STRING COMMENT 'Classification of the return transaction based on the payment rail or system through which it was processed.. Valid values are `ach_return|swift_return|rtgs_reversal|wire_return|card_chargeback|internal_reversal`',
    `settlement_date` DATE COMMENT 'Date on which the return amount is settled and funds are credited back to the originators account. Follows T+1 or same-day settlement cycles depending on payment rail.',
    `source_system_code` STRING COMMENT 'Code identifying the source payment processing system or platform from which this return record originated (e.g., ACI Worldwide, Volante, internal payment hub).',
    `swift_message_type` STRING COMMENT 'SWIFT message type code for returns processed through SWIFT network (e.g., MT192 for request for cancellation, MT196 for answers to requests). Null for non-SWIFT returns.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment return record was last modified or updated.',
    `window_days` STRING COMMENT 'Number of days from the original payment date within which the return was initiated. Different return reason codes have different allowable return windows (e.g., 2 banking days for R01, 60 days for unauthorized debits).',
    CONSTRAINT pk_return PRIMARY KEY(`return_id`)
) COMMENT 'Records payment returns and reversals initiated by the receiving bank or clearing house, including R-transaction codes (NSF, account closed, invalid account), return reason, original payment reference, return amount, return date, and resubmission eligibility. Covers ACH returns (R01–R85), SWIFT returns (MT192/MT196), and RTGS reversals. SSOT for return and reversal lifecycle.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`batch` (
    `batch_id` BIGINT COMMENT 'Unique identifier for the payment batch record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Payment batches processed within specific accounting periods for financial close and period-end reconciliation. Required for ensuring all transactions are captured in correct reporting period.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that created the payment batch record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Batch processing aggregates payments in single currency for clearing house submission. Currency master provides minor unit for amount validation, settlement lag for value dating, and regulatory report',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the payment batch for submission, supporting segregation of duties controls.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified the payment batch record.',
    `legal_entity_id` BIGINT COMMENT 'Bank Identifier Code (BIC) or routing number of the financial institution that originated the payment batch.. Valid values are `^[A-Z0-9]{8,11}$`',
    `nostro_account_id` BIGINT COMMENT 'Identifier of the nostro account (our account held at another bank) used for settlement of this batch in correspondent banking arrangements.',
    `payment_channel_id` BIGINT COMMENT 'Foreign key linking to payment.payment_channel. Business justification: payment_batch has payment_rail which should reference payment_channel. Each batch is submitted via a specific payment channel/rail. This is a standard N:1 relationship. payment_rail can be kept for de',
    `receiving_institution_legal_entity_id` BIGINT COMMENT 'Bank Identifier Code (BIC) or routing number of the financial institution receiving the payment batch for settlement.. Valid values are `^[A-Z0-9]{8,11}$`',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Batch settlement country determines clearing house (e.g., US ACH, UK BACS), holiday calendar for settlement date calculation, and regulatory reporting regime. Country master provides business day conv',
    `vostro_account_id` BIGINT COMMENT 'Identifier of the vostro account (their account held at our bank) used for settlement of this batch in correspondent banking arrangements.',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned by AML screening system indicating the likelihood of money laundering or financial crime, typically on a scale of 0-100.',
    `aml_screening_status` STRING COMMENT 'Result of Anti-Money Laundering screening performed on the batch to detect suspicious activity or sanctioned parties.. Valid values are `NOT_SCREENED|CLEARED|FLAGGED|UNDER_REVIEW`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment batch was approved for submission by an authorized approver, if dual authorization is required.',
    `batch_description` STRING COMMENT 'Free-text description providing additional context about the batch contents or purpose.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the payment batch. DRAFT indicates batch is being assembled, SUBMITTED indicates batch sent to payment hub, PROCESSING indicates batch is being validated and routed, CLEARED indicates batch has passed clearing window, SETTLED indicates funds have been transferred, REJECTED indicates batch failed validation, CANCELLED indicates batch was withdrawn before settlement. [ENUM-REF-CANDIDATE: DRAFT|SUBMITTED|PROCESSING|CLEARED|SETTLED|REJECTED|CANCELLED — 7 candidates stripped; promote to reference product]',
    `batch_type` STRING COMMENT 'Indicates whether the batch contains only credit transfers, only debit transfers, or a mix of both transaction types.. Valid values are `CREDIT|DEBIT|MIXED`',
    `clearing_timestamp` TIMESTAMP COMMENT 'Date and time when the batch successfully passed through the clearing process and was accepted by the receiving institution.',
    `clearing_window` STRING COMMENT 'The designated clearing cycle or time window during which the batch is scheduled to be processed by the payment rail.. Valid values are `MORNING|AFTERNOON|EVENING|OVERNIGHT|REALTIME`',
    `company_entry_description` STRING COMMENT 'Description that will appear on beneficiary bank statements for all payments in this batch, typically identifying the originating company.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment batch record was first created in the system.',
    `discretionary_data` STRING COMMENT 'Optional field for originator-specific information or internal reference data that accompanies the batch through the payment system.',
    `is_test_batch` BOOLEAN COMMENT 'Boolean flag indicating whether this is a test batch used for system validation and not intended for actual fund transfer (True) or a production batch (False).',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Payment batches generate consolidated journal entries for batch settlement accounting. Required for financial close, reconciliation, and audit trail linking operational payment data to financial ledge',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the payment batch record was last updated.',
    `originator_account_number` STRING COMMENT 'Account number or International Bank Account Number (IBAN) from which funds will be debited for credit batches or to which funds will be credited for debit batches.. Valid values are `^[A-Z0-9]{8,34}$`',
    `originator_name` STRING COMMENT 'Legal name of the company or entity that initiated the payment batch.',
    `payment_rail` STRING COMMENT 'The payment network or clearing system through which the batch is processed (ACH for Automated Clearing House, WIRE for wire transfer, RTGS for Real-Time Gross Settlement, SWIFT for Society for Worldwide Interbank Financial Telecommunication, SEPA for Single Euro Payments Area, FEDWIRE for Federal Reserve Wire Network).. Valid values are `ACH|WIRE|RTGS|SWIFT|SEPA|FEDWIRE`',
    `priority` STRING COMMENT 'Processing priority level assigned to the batch, determining the order and speed of processing within the payment hub.. Valid values are `URGENT|HIGH|NORMAL|LOW`',
    `purpose_code` STRING COMMENT 'Business purpose or category of payments contained in the batch (e.g., PAYROLL for employee salary payments, VENDOR for supplier payments, CUSTOMER_REFUND for customer reimbursements). [ENUM-REF-CANDIDATE: PAYROLL|VENDOR|CUSTOMER_REFUND|TAX|DIVIDEND|INTEREST|PENSION|BENEFIT — 8 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'External business identifier for the payment batch used for tracking and reconciliation across systems and with external parties.. Valid values are `^[A-Z0-9]{8,20}$`',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions list screening to ensure no parties in the batch are on OFAC, UN, EU, or other sanctions lists.. Valid values are `NOT_SCREENED|CLEARED|HIT|UNDER_REVIEW`',
    `settlement_date` DATE COMMENT 'The business date on which funds are expected to be transferred and the batch is considered settled. Typically follows T+1 settlement cycle for ACH.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the batch was fully settled and funds were transferred between institutions.',
    `source_system_code` STRING COMMENT 'Identifier of the upstream system that originated the payment batch (e.g., ERP, Treasury Management System, Payroll System).',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the batch was submitted to the payment processing hub for clearing and settlement.',
    `swift_message_type` STRING COMMENT 'SWIFT message type code used for transmitting the batch (MT101 for request for transfer, MT102 for multiple customer credit transfer, MT103 for single customer credit transfer, MT202 for general financial institution transfer, MT940 for customer statement, MT950 for statement message).. Valid values are `MT101|MT102|MT103|MT202|MT940|MT950`',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Sum of all credit transaction amounts in the batch, expressed in the batch currency.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Sum of all debit transaction amounts in the batch, expressed in the batch currency.',
    `total_item_count` STRING COMMENT 'Total number of individual payment instructions included in this batch.',
    `validation_error_code` STRING COMMENT 'Standardized error code indicating the reason for validation failure or rejection, if applicable.',
    `validation_error_message` STRING COMMENT 'Human-readable description of the validation error or rejection reason.',
    `validation_status` STRING COMMENT 'Result of pre-submission validation checks performed on the batch (format validation, balance checks, duplicate detection, AML screening).. Valid values are `PENDING|PASSED|FAILED|WARNING`',
    `value_date` DATE COMMENT 'The date on which funds become available to the beneficiary or are debited from the originator account for interest calculation purposes.',
    CONSTRAINT pk_batch PRIMARY KEY(`batch_id`)
) COMMENT 'Groups individual payment instructions into processing batches for ACH, RTGS, and bulk wire submissions. Captures batch reference number, payment rail, total item count, total debit amount, total credit amount, batch submission timestamp, clearing window, settlement date, and batch-level status. Sourced from ACI Worldwide batch processing module.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`clearing_record` (
    `clearing_record_id` BIGINT COMMENT 'Unique identifier for the clearing record. Primary key for the clearing record entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Clearing settlements must be assigned to accounting periods for financial reporting and liquidity management. Required for period-end cash position reporting and regulatory liquidity ratios (LCR).',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Clearing and settlement audits verify nostro/vostro reconciliation, multilateral netting accuracy, settlement risk exposure, and liquidity reserve compliance. Clearing records are primary evidence for',
    `batch_id` BIGINT COMMENT 'Foreign key linking to payment.payment_batch. Business justification: clearing_record represents the clearing house submission and settlement obligation. Payments are often submitted in batches for clearing. clearing_record should reference the payment_batch it represen',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Clearing house settlement requires currency master for netting calculations, liquidity reserve requirements, and settlement finality rules. Clearing_currency_code denormalized text replaced by FK for ',
    `instruction_id` BIGINT COMMENT 'Reference to the originating payment instruction or batch of payment instructions submitted for clearing.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Clearing settlements create accounting entries for net settlement obligations and nostro/vostro movements. Essential for financial reporting, liquidity management, and regulatory capital calculations.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: DVP clearing records must link to the instrument for securities settlement netting, CCP margin calculation, and settlement finality confirmation. Critical for central counterparty clearing operations.',
    `aml_screening_status` STRING COMMENT 'Status of AML (Anti-Money Laundering) screening performed on this clearing record. Indicates whether the transaction has been cleared, flagged for review, is pending screening, or has been escalated for investigation.. Valid values are `cleared|flagged|pending|escalated`',
    `clearing_confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearing house confirmed acceptance or rejection of the clearing submission. Marks the completion of the clearing validation phase.',
    `clearing_cycle_identifier` STRING COMMENT 'Identifier of the specific clearing cycle or batch window in which this clearing record was processed. Clearing houses typically operate multiple cycles per day.',
    `clearing_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the clearing house for processing this clearing record. May be a flat fee per transaction or a percentage of the cleared amount.',
    `clearing_house_identifier` STRING COMMENT 'Identifier of the clearing house or payment system operator that processed this clearing record. Examples include ACH operator, CHIPS (Clearing House Interbank Payments System), Fedwire, CHAPS (Clearing House Automated Payment System), TARGET2 (Trans-European Automated Real-time Gross Settlement Express Transfer System), CLS (Continuous Linked Settlement), SEPA, BACS. [ENUM-REF-CANDIDATE: ACH|CHIPS|FEDWIRE|CHAPS|TARGET2|CLS|SEPA|BACS|SWIFT|OTHER — 10 candidates stripped; promote to reference product]',
    `clearing_message_type` STRING COMMENT 'Type of clearing message or instruction format used. Examples include SWIFT MT message types (MT103, MT202), ISO 20022 message types (pacs.008, pacs.009), or proprietary clearing formats.',
    `clearing_participant_identifier` STRING COMMENT 'Unique identifier of the financial institution participating in the clearing process. May be a BIC (Bank Identifier Code), ABA routing number, or clearing house member identifier.',
    `clearing_reference_number` STRING COMMENT 'Unique reference number assigned by the clearing house to identify this clearing submission. Business identifier for external reconciliation and inquiry.',
    `clearing_status` STRING COMMENT 'Current lifecycle status of the clearing record. Indicates whether the clearing submission has been accepted, rejected, is pending processing, or has progressed to settlement.. Valid values are `submitted|accepted|rejected|pending|settled|failed`',
    `clearing_submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment instruction or batch was submitted to the clearing house for processing. Represents the business event time of clearing initiation.',
    `collateral_requirement_amount` DECIMAL(18,2) COMMENT 'Amount of collateral required to be posted to the clearing house to cover settlement risk exposure. Common in securities clearing and derivatives clearing.',
    `counterparty_participant_identifier` STRING COMMENT 'Identifier of the counterparty financial institution on the other side of the clearing transaction. Used in bilateral netting and settlement reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clearing record was first created in the system. Audit field for data lineage and compliance tracking.',
    `cross_border_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this clearing record involves cross-border payment flows between different countries or currency zones. Relevant for FATCA (Foreign Account Tax Compliance Act) and CRS (Common Reporting Standard) compliance.',
    `foreign_exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied for cross-currency clearing and settlement, particularly relevant for CLS (Continuous Linked Settlement) FX transactions. Represents the rate at which one currency is converted to another.',
    `funding_account_number` STRING COMMENT 'Account number of the nostro, vostro, or settlement account used to fund the net settlement obligation or receive settlement proceeds. Typically a central bank account or correspondent banking account.',
    `gross_clearing_amount` DECIMAL(18,2) COMMENT 'Total gross amount of all payment instructions included in this clearing record before any netting or offsetting. Represents the sum of all individual payment values submitted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this clearing record was last updated or modified. Audit field for change tracking and data governance.',
    `liquidity_reserve_requirement_amount` DECIMAL(18,2) COMMENT 'Amount of liquidity reserves that must be maintained to cover this clearing obligation. Relevant for regulatory liquidity management and LCR (Liquidity Coverage Ratio) calculations.',
    `multilateral_netting_position` STRING COMMENT 'Indicates whether the institution is a net payer (owes funds), net receiver (receives funds), or neutral (no net obligation) after multilateral netting across all participants in the clearing cycle.. Valid values are `net_payer|net_receiver|neutral`',
    `net_settlement_obligation_amount` DECIMAL(18,2) COMMENT 'Net settlement obligation amount after multilateral or bilateral netting has been applied by the clearing house. This is the actual amount that must be funded or will be received in the settlement phase.',
    `netting_group_identifier` STRING COMMENT 'Identifier of the netting group or pool to which this clearing record belongs. Used in multilateral netting arrangements where participants are grouped for offset calculation.',
    `nostro_vostro_indicator` STRING COMMENT 'Indicates whether the settlement account is a nostro account (our account held at another bank), vostro account (their account held at our bank), or an internal account. Critical for correspondent banking reconciliation.. Valid values are `nostro|vostro|internal`',
    `payment_instruction_count` STRING COMMENT 'Number of individual payment instructions included in this clearing record. Relevant for batch clearing submissions where multiple payments are cleared together.',
    `priority_indicator` STRING COMMENT 'Priority level assigned to this clearing record. High-priority payments may be processed in earlier clearing cycles or given preferential treatment in settlement queues.. Valid values are `high|normal|low`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this clearing record must be included in regulatory reporting submissions such as CCAR (Comprehensive Capital Analysis and Review), DFAST (Dodd-Frank Act Stress Testing), or other supervisory reports.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for clearing rejection if the clearing status is rejected. Examples include insufficient funds, invalid account, format errors, or compliance holds.',
    `rejection_reason_description` STRING COMMENT 'Detailed textual description of the reason for clearing rejection, providing additional context beyond the standardized rejection reason code.',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions screening against OFAC (Office of Foreign Assets Control) and other sanctions lists. Indicates whether the transaction has been cleared, matched a sanctions list (hit), is pending review, or has been manually overridden.. Valid values are `cleared|hit|pending|override`',
    `settlement_confirmation_reference` STRING COMMENT 'Unique reference number provided by the settlement system confirming that final funds movement has been completed. Used for reconciliation and audit trail.',
    `settlement_date` DATE COMMENT 'The date on which final settlement of funds is scheduled to occur. Typically follows T+0, T+1, or T+2 convention depending on the payment system and instrument type.',
    `settlement_method` STRING COMMENT 'Method used for final settlement of the net obligation. RTGS (Real-Time Gross Settlement) settles each transaction individually in real-time. DNS (Deferred Net Settlement) settles net positions at scheduled intervals. Hybrid combines both approaches.. Valid values are `RTGS|DNS|hybrid`',
    `settlement_risk_exposure_amount` DECIMAL(18,2) COMMENT 'Calculated settlement risk exposure amount representing the potential loss if the counterparty fails to settle. Used for credit risk management and regulatory capital calculations.',
    `settlement_status` STRING COMMENT 'Final status of the settlement process. Indicates whether funds have been successfully transferred, settlement failed, or the transaction was reversed or suspended.. Valid values are `pending|completed|failed|reversed|suspended`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Actual timestamp when final settlement of funds was completed and confirmed by the clearing house or settlement system. Marks the irrevocable transfer of funds.',
    `settlement_window_identifier` STRING COMMENT 'Identifier of the specific settlement window or time slot in which final settlement is scheduled. Clearing houses may operate multiple settlement windows throughout the day.',
    `source_system_identifier` STRING COMMENT 'Identifier of the source system that originated this clearing record. Examples include ACI Worldwide, Volante, or internal payment processing platforms. Used for data lineage and reconciliation.',
    CONSTRAINT pk_clearing_record PRIMARY KEY(`clearing_record_id`)
) COMMENT 'Represents the clearing-house submission, netting, and resulting settlement obligation for a payment or batch of payments. Captures clearing house identifier (ACH operator, CHIPS, Fedwire, CHAPS, TARGET2, CLS), clearing cycle, net settlement obligation amount, multilateral netting position, clearing confirmation reference, clearing timestamp, settlement date, funding account, settlement method, settlement confirmation reference, and final settlement status. Bridges payment instructions through clearing to final funds movement. SSOT for the complete clearing-to-settlement lifecycle including CLS for FX settlement.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the payment routing rule. Primary key for the payment routing configuration.',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Payment routing rule configuration is SOX-controlled process for financial statement accuracy and segregation of duties. Links routing rule to control for change management testing, access control val',
    `correspondent_bank_id` BIGINT COMMENT 'FK to payment.correspondent_bank',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Routing rules vary by destination country for cost optimization (local rails vs SWIFT), speed (RTGS availability), and regulatory compliance (sanctions screening, reporting thresholds). Country master',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Routing optimized per currency based on nostro liquidity, correspondent bank relationships, and clearing costs. Currency master provides convertibility status, restrictions, and settlement lag for rou',
    `fallback_routing_rule_routing_id` BIGINT COMMENT 'Identifier of an alternative routing rule to use if this primary routing path fails or is unavailable.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Routing cutoff times adjusted for holidays in destination market. Holiday calendar provides partial day hours for same-day payment eligibility and next business day calculation for value dating and SL',
    `payment_channel_id` BIGINT COMMENT 'Foreign key linking to payment.payment_channel. Business justification: payment_routing has payment_rail_code which should reference payment_channel. Routing rules are defined per payment channel/rail. This is a standard N:1 relationship where multiple routing rules can b',
    `reporting_code_id` BIGINT COMMENT 'Foreign key linking to reference.reporting_code. Business justification: Routing rules map to regulatory reporting requirements (FFIEC 009 cross-border, FinCEN CTR for large cash). Reporting_code provides taxonomy mapping, submission frequency, and data point requirements ',
    `employee_id` BIGINT COMMENT 'User identifier of the approver who authorized this routing rule for production use.',
    `routing_employee_id` BIGINT COMMENT 'User identifier of the person or system that last modified this routing rule, for audit and accountability.',
    `aml_monitoring_level` STRING COMMENT 'Level of AML transaction monitoring applied to payments using this routing path, based on risk assessment.. Valid values are `STANDARD|ENHANCED|HIGH_RISK`',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Payment amount threshold above which manual approval or additional authorization is required before routing.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing rule was approved for production use, supporting maker-checker controls.',
    `cost_basis_points` DECIMAL(18,2) COMMENT 'Cost of using this routing path expressed in basis points (BPS) of the payment amount. Used for cost-optimized routing decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing rule record was first created in the system.',
    `cutoff_time_local` STRING COMMENT 'Daily cut-off time in local time zone (HH:MM:SS format) by which payment instructions must be received to be included in the current settlement cycle.. Valid values are `^([01]d|2[0-3]):([0-5]d):([0-5]d)$`',
    `cutoff_timezone` STRING COMMENT 'Time zone identifier for the cut-off time (e.g., EST, GMT, CET) to ensure accurate cross-border timing.. Valid values are `^[A-Z]{3,4}$`',
    `daily_aggregate_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cumulative amount allowed per day through this routing path. Used for liquidity management and risk control.',
    `effective_from_date` DATE COMMENT 'Date from which this routing rule becomes effective and eligible for use in payment routing decisions.',
    `effective_to_date` DATE COMMENT 'Date until which this routing rule remains effective. Null indicates an open-ended rule with no expiration.',
    `engine_version` STRING COMMENT 'Version identifier of the payment routing engine configuration that created or last modified this rule.',
    `intermediary_bank_bic` STRING COMMENT 'SWIFT BIC of an intermediary bank in the routing chain, if required for multi-hop correspondent banking.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `intermediary_bank_name` STRING COMMENT 'Legal name of the intermediary bank, if applicable, for operational transparency and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing rule record was last updated or modified.',
    `liquidity_reserve_requirement_flag` BOOLEAN COMMENT 'Indicates whether this routing path requires pre-funded liquidity reserves to be maintained for settlement assurance.',
    `nostro_account_number` STRING COMMENT 'Account number of the banks nostro account held at the correspondent bank, used for settlement and reconciliation.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special instructions, or operational guidance for this routing rule.',
    `payment_rail_code` STRING COMMENT 'The payment rail or network through which the payment is routed. Determines the clearing and settlement infrastructure used. [ENUM-REF-CANDIDATE: ACH|WIRE|RTGS|SWIFT|CARD|SEPA|FASTER_PAYMENTS|TARGET2 — 8 candidates stripped; promote to reference product]',
    `priority_rank` STRING COMMENT 'Priority ranking for this routing rule when multiple rules match a payment instruction. Lower numbers indicate higher priority.',
    `rail_settlement_model` STRING COMMENT 'Settlement model used by the payment rail: gross settlement (transaction-by-transaction) or net settlement (batch netting).. Valid values are `GROSS|NET|HYBRID`',
    `rule_code` STRING COMMENT 'Business identifier code for the routing rule used for operational reference and configuration management.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `rule_name` STRING COMMENT 'Human-readable name describing the purpose and scope of the routing rule.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the routing rule. Only ACTIVE rules are used for live payment routing decisions.. Valid values are `ACTIVE|INACTIVE|SUSPENDED|PENDING_APPROVAL|DEPRECATED`',
    `sanctions_screening_required_flag` BOOLEAN COMMENT 'Indicates whether payments routed via this path must undergo OFAC and sanctions screening before execution.',
    `settlement_cycle_code` STRING COMMENT 'Settlement cycle indicating when funds are finalized. T+0 is same-day, T+1 is next business day, real-time is immediate.. Valid values are `T0|T1|T2|INTRADAY|REAL_TIME`',
    `single_transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount allowed for a single payment transaction through this routing path. Enforces per-transaction risk controls.',
    `sla_target_completion_minutes` STRING COMMENT 'Target completion time in minutes as defined in the service level agreement for this routing path.',
    `speed_minutes` STRING COMMENT 'Expected end-to-end processing time in minutes for payments routed via this path, used for speed-optimized routing.',
    `swift_message_type` STRING COMMENT 'SWIFT message type used for this routing path (e.g., MT103 for customer credit transfer, MT202 for financial institution transfer, or ISO 20022 MX messages). [ENUM-REF-CANDIDATE: MT103|MT202|MT202COV|MT103_STP|MT199|MT299|MX_PACS008|MX_PACS009 — 8 candidates stripped; promote to reference product]',
    `velocity_limit_count` STRING COMMENT 'Maximum number of payments allowed through this routing path within the velocity window. Used for risk management and fraud prevention.',
    `velocity_window_minutes` STRING COMMENT 'Time window in minutes over which the velocity limit count is enforced. Supports sliding-window velocity checks.',
    `vostro_account_number` STRING COMMENT 'Account number of the correspondent banks vostro account held at this bank, if applicable for bilateral settlement.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Defines the routing rules and correspondent banking paths used to direct payments to their destination across all supported payment rails. Captures routing rule identifier, payment rail code (ACH/wire/RTGS/SWIFT/card), rail settlement model (gross/net), settlement cycle, cut-off times, destination country/currency, correspondent bank BIC, intermediary bank BIC, routing priority, velocity limits, approval thresholds, effective date range, and rule status. Sourced from SWIFT Reference Data (BIC directory, SSI registry) and Volante payment hub routing engine. Enables dynamic routing decisions based on cost, speed, liquidity position, and regulatory requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`beneficiary` (
    `beneficiary_id` BIGINT COMMENT 'Unique identifier for the payment beneficiary record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Beneficiary bank country drives payment routing (SWIFT vs local rails), sanctions screening (OFAC, EU), correspondent bank selection, and regulatory reporting (FFIEC 009 cross-border). Bank_country_co',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Default purpose code per beneficiary streamlines recurring payment processing (e.g., SUPP for all supplier beneficiaries). Code_list provides regulatory reporting category and AML risk indicator for b',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Beneficiary account currency determines payment routing, FX requirements, and correspondent bank selection. Currency master provides convertibility status, restrictions, and settlement lag for payment',
    `deal_participant_id` BIGINT COMMENT 'Foreign key linking to investment.deal_participant. Business justification: Deal participants (co-advisors, legal counsel, underwriters, agents) are registered as payment beneficiaries for fee and expense payments. Operational link for deal-related payment processing and part',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Beneficiary verification is part of customer due diligence process for payment counterparties, especially high-risk jurisdictions. Links beneficiary to KYC review for sanctions screening, PEP checks, ',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: When beneficiary is existing customer, party link enables streamlined KYC (reuse existing due diligence), enhanced sanctions screening (leverage customer risk rating), and simplified beneficiary regis',
    `account_number` STRING COMMENT 'The account number at the beneficiarys financial institution where funds will be credited. Format varies by country and institution.',
    `address_line1` STRING COMMENT 'Primary address line of the beneficiary (street address, building number). Required for compliance and verification purposes.',
    `address_line2` STRING COMMENT 'Secondary address line of the beneficiary (suite, apartment, additional location details).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this beneficiary was approved for payment processing.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this beneficiary for payment processing. Required for audit trail and compliance.',
    `bank_address_line1` STRING COMMENT 'Primary address line of the beneficiarys bank or branch (street address, building number).',
    `bank_address_line2` STRING COMMENT 'Secondary address line of the beneficiarys bank or branch (suite, floor, additional location details).',
    `bank_branch_name` STRING COMMENT 'Name or identifier of the specific branch where the beneficiary account is held, if applicable.',
    `bank_city` STRING COMMENT 'City where the beneficiarys bank or branch is located.',
    `bank_name` STRING COMMENT 'Full name of the financial institution holding the beneficiarys account.',
    `bank_postal_code` STRING COMMENT 'Postal or ZIP code of the beneficiarys bank or branch location.',
    `bank_state_province` STRING COMMENT 'State, province, or region where the beneficiarys bank or branch is located.',
    `beneficiary_status` STRING COMMENT 'Current lifecycle status of the beneficiary record. Active beneficiaries can receive payments; suspended or blocked beneficiaries cannot.. Valid values are `active|inactive|suspended|blocked|pending_approval`',
    `beneficiary_type` STRING COMMENT 'Classification of the beneficiary entity: individual person, corporate entity, financial institution, government body, non-profit organization, or trust.. Valid values are `individual|corporate|financial_institution|government|non_profit|trust`',
    `bic_swift_code` STRING COMMENT 'BIC/SWIFT code identifying the beneficiarys bank for international wire transfers and SWIFT messaging. 8 or 11 character alphanumeric code.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `city` STRING COMMENT 'City where the beneficiary is located or registered.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the beneficiarys residence or registration.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this beneficiary record was first created in the system.',
    `email_address` STRING COMMENT 'Primary email address for beneficiary communication and payment notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `iban` STRING COMMENT 'International Bank Account Number for beneficiaries in IBAN-participating countries. Standardized format for cross-border payments.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `intermediary_bank_bic` STRING COMMENT 'BIC/SWIFT code of the intermediary (correspondent) bank used to route payments to the beneficiary bank, if required.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `intermediary_bank_name` STRING COMMENT 'Name of the intermediary (correspondent) bank, if required for payment routing.',
    `intermediary_bank_required` BOOLEAN COMMENT 'Indicates whether an intermediary (correspondent) bank is required to route payments to this beneficiary. True for certain cross-border payments.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment successfully sent to this beneficiary.',
    `legal_name` STRING COMMENT 'Full legal name of the beneficiary as registered with their financial institution or government authority. For individuals, includes full given and family names; for entities, the registered business name.',
    `pep_status` STRING COMMENT 'Indicates whether the beneficiary is a Politically Exposed Person (PEP), Relative or Close Associate (RCA) of a PEP, or non-PEP. Used for enhanced due diligence requirements.. Valid values are `pep|non_pep|rca|pending|unknown`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the beneficiary. Used for verification and communication purposes.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the beneficiarys address.',
    `registration_date` DATE COMMENT 'Date when the beneficiary was first registered in the payment system.',
    `routing_code` STRING COMMENT 'Domestic routing code for the beneficiarys bank (e.g., ABA routing number, UK sort code, Australian BSB). Format varies by country.',
    `routing_code_type` STRING COMMENT 'Type of domestic routing code used for the beneficiary bank: ABA (US), Sort Code (UK), BSB (Australia), IFSC (India), CLABE (Mexico), Transit Number (Canada), or other branch code. [ENUM-REF-CANDIDATE: aba|sort_code|bsb|ifsc|clabe|transit|branch_code — 7 candidates stripped; promote to reference product]',
    `sanctions_screening_date` TIMESTAMP COMMENT 'Timestamp of the most recent sanctions screening check for this beneficiary.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions screening against OFAC, UN, EU, and other watchlists. Clear indicates no match; match or potential_match require review.. Valid values are `clear|match|potential_match|pending|error`',
    `state_province` STRING COMMENT 'State, province, or region where the beneficiary is located or registered.',
    `tax_identification_number` STRING COMMENT 'Tax identification number of the beneficiary (e.g., SSN, EIN, VAT number). Required for certain payment types and regulatory reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this beneficiary record was last modified.',
    `verification_date` DATE COMMENT 'Date when the beneficiary account details were last successfully verified.',
    `verification_status` STRING COMMENT 'Status of beneficiary account verification. Indicates whether the account details have been validated through micro-deposits, API verification, or manual review.. Valid values are `verified|pending|failed|not_verified|expired`',
    CONSTRAINT pk_beneficiary PRIMARY KEY(`beneficiary_id`)
) COMMENT 'Master registry of payment beneficiaries (individuals, corporations, and financial institutions) to whom the banks customers direct payments. Captures beneficiary name, account number, IBAN, BIC/SWIFT code, bank name, bank address, country, currency, beneficiary type, verification status, and sanctions screening result. SSOT for beneficiary identity in the payment domain, distinct from the customer domain which owns payer identity.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`payment_mandate` (
    `payment_mandate_id` BIGINT COMMENT 'Unique identifier for the payment mandate record. Primary key.',
    `creditor_account_id` BIGINT COMMENT 'Reference to the creditor account that will receive collected funds. Links to the account master data.',
    `beneficiary_id` BIGINT COMMENT 'Foreign key linking to payment.beneficiary. Business justification: payment_mandate has creditor_name and creditor_account_id. The creditor in a direct debit mandate is a beneficiary in the payment domain. This should be normalized to a FK to beneficiary.beneficiary_i',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: SEPA Direct Debit and BACS mandates specify collection currency. Currency master provides minor unit for maximum amount validation, convertibility status for cross-border mandates, and regulatory repo',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Direct debit mandates require party-level authorization tracking for regulatory compliance (SEPA, NACHA rules), dispute resolution, and customer consent management. Debtor_name is denormalized party d',
    `deposit_account_id` BIGINT COMMENT 'Reference to the customer account from which funds will be debited under this mandate. Links to the account master data.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Direct debit mandates require customer due diligence verification for debtor and creditor identities per payment services regulations. Links mandate to KYC review for authorization validation and frau',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created the mandate record. Used for audit trail and accountability.',
    `amendment_date` DATE COMMENT 'Date of the most recent amendment to the mandate terms. Null if mandate has never been amended.',
    `amendment_indicator` BOOLEAN COMMENT 'Flag indicating whether this mandate has been amended since original signature. True if mandate terms have been modified with debtor consent.',
    `aml_screening_status` STRING COMMENT 'Result of Anti-Money Laundering screening performed on the mandate parties. PASSED indicates cleared, FAILED indicates hit requiring investigation, PENDING indicates screening in progress, REVIEW indicates manual review required, EXEMPT indicates mandate type not subject to AML screening.. Valid values are `PASSED|FAILED|PENDING|REVIEW|EXEMPT`',
    `authorization_method` STRING COMMENT 'Channel through which the debtor authorized the mandate. PAPER for signed physical form, ELECTRONIC for e-signature, ONLINE for web portal, MOBILE for mobile app, TELEPHONE for phone banking, BRANCH for in-person at branch.. Valid values are `PAPER|ELECTRONIC|TELEPHONE|ONLINE|MOBILE|BRANCH`',
    `authorization_reference` STRING COMMENT 'Reference number or identifier for the authorization event or document. Used for audit trail and dispute resolution.',
    `cancellation_date` DATE COMMENT 'Date on which the mandate was cancelled or revoked. Populated when mandate status transitions to CANCELLED or REVOKED.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for mandate cancellation or revocation. Captures debtor request, creditor termination, or regulatory reason.',
    `collection_frequency` STRING COMMENT 'Expected frequency of payment collections under this mandate. ONCE for one-time mandates, ADHOC for variable timing, or regular intervals for recurring mandates. [ENUM-REF-CANDIDATE: ONCE|DAILY|WEEKLY|MONTHLY|QUARTERLY|ANNUALLY|ADHOC — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `creditor_identifier` STRING COMMENT 'Unique identifier assigned to the creditor by the national banking authority or scheme. Used to identify the party authorized to collect payments under this mandate. For SEPA, this is the Creditor Identifier issued by national central banks.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the mandate is currently subject to a dispute or chargeback claim by the debtor. True if active dispute exists.',
    `end_date` DATE COMMENT 'Date on which the mandate expires and can no longer be used for collections. Null indicates open-ended mandate. After this date, mandate status transitions to EXPIRED.',
    `last_collection_date` DATE COMMENT 'Date of the most recent payment collection executed under this mandate. Used to track mandate usage and identify dormant mandates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the mandate record. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mandate_status` STRING COMMENT 'Current lifecycle status of the payment mandate. ACTIVE indicates mandate is valid and can be used for collections. SUSPENDED indicates temporary hold. CANCELLED indicates creditor-initiated termination. EXPIRED indicates mandate passed end date. PENDING indicates awaiting activation. REVOKED indicates debtor-initiated cancellation.. Valid values are `ACTIVE|SUSPENDED|CANCELLED|EXPIRED|PENDING|REVOKED`',
    `mandate_type` STRING COMMENT 'Type of direct debit mandate scheme. SEPA_CORE for consumer direct debits in SEPA zone, SEPA_B2B for business-to-business, ACH_PPD for Prearranged Payment and Deposit Entry, ACH_CCD for Cash Concentration or Disbursement, BACS for UK direct debit, BECS for Australian direct debit, PAD for Canadian Pre-Authorized Debit. [ENUM-REF-CANDIDATE: SEPA_CORE|SEPA_B2B|ACH_PPD|ACH_CCD|BACS|BECS|PAD — 7 candidates stripped; promote to reference product]',
    `maximum_amount` DECIMAL(18,2) COMMENT 'Maximum amount that can be collected in a single transaction under this mandate. Null indicates no limit. Used for debtor protection and validation of collection requests.',
    `next_scheduled_collection_date` DATE COMMENT 'Date of the next planned payment collection under this mandate. Used for recurring mandate scheduling and debtor notification.',
    `reference_number` STRING COMMENT 'Unique mandate reference assigned by the creditor or payment service provider. Used for mandate identification in payment instructions and SEPA direct debit schemes.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this mandate requires special regulatory reporting or monitoring. True for mandates subject to enhanced due diligence or cross-border reporting requirements.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions list screening performed on mandate parties against OFAC, UN, EU, and other watchlists. CLEARED indicates no match, HIT indicates potential match requiring investigation, PENDING indicates screening in progress, REVIEW indicates manual review required.. Valid values are `CLEARED|HIT|PENDING|REVIEW|EXEMPT`',
    `sequence_type` STRING COMMENT 'Indicates the position of the collection in the mandate lifecycle. FIRST for initial collection, RECURRING for subsequent collections, FINAL for last collection, ONEOFF for single-use mandates, REPRESENTMENT for retry after return.. Valid values are `FIRST|RECURRING|FINAL|ONEOFF|REPRESENTMENT`',
    `signature_date` DATE COMMENT 'Date on which the debtor signed or authorized the mandate. Used to determine mandate validity and for dispute resolution. Must precede first collection date.',
    `start_date` DATE COMMENT 'Date from which the mandate becomes effective and collections can be initiated. Cannot be earlier than signature date.',
    CONSTRAINT pk_payment_mandate PRIMARY KEY(`payment_mandate_id`)
) COMMENT 'Standing payment mandate or direct debit authorization granted by a customer to a creditor, enabling recurring or one-time pull payments. Captures mandate reference, mandate type (SEPA Core, SEPA B2B, ACH PPD/CCD), creditor identifier, debtor account, maximum amount, frequency, start date, end date, mandate status, and presentment sequence (first/recurring/final/one-off/re-presentment). Supports mandate amendment, cancellation, and dispute workflows. SSOT for pre-authorized payment agreements and direct debit lifecycle management.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`card_transaction` (
    `card_transaction_id` BIGINT COMMENT 'Unique identifier for the card transaction record. Primary key.',
    `atm_id` BIGINT COMMENT 'Foreign key linking to channel.atm. Business justification: Card transactions at ATMs require direct link to ATM entity for transaction reconciliation, dispute resolution (location verification), ATM cash management, performance analytics, and fraud investigat',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Card networks (Visa, Mastercard, Amex, Discover) are reference data for interchange calculation, routing to acquirer, fraud rule application, and chargeback processing. Code_list provides network-spec',
    `ctr_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.ctr_filing. Business justification: Cash-equivalent card transactions (ATM withdrawals, cash advances) may require CTR filing when exceeding $10,000 threshold. Links transaction to CTR for BSA compliance and aggregation across multiple ',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Card transactions initiated through digital channels (e-commerce, mobile wallet) need session context for fraud detection (device fingerprint, behavioral biometrics), 3D Secure authentication validati',
    `deposit_account_id` BIGINT COMMENT 'Reference to the card account used for this transaction.',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Card transactions trigger fraud alerts during authorization and settlement. Direct linkage enables real-time fraud decisioning, chargeback management, and card fraud analytics. Core card fraud detecti',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Card fraud cases investigate specific card transactions for chargeback processing, loss recovery, and cardholder reimbursement. Essential for card fraud investigation and dispute resolution workflow.',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Card transactions are recorded as fraud incidents when fraud is confirmed. Direct linkage enables incident tracking, loss reporting, and fraud typology analysis. Core fraud incident management process',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Merchant country determines interchange rates, fraud velocity rules, 3DS requirements (PSD2 SCA), and cross-border transaction fees. Country master provides sanctions status, AML risk rating, and regu',
    `merchant_id` BIGINT COMMENT 'Unique identifier assigned to the merchant by the acquirer or card network.',
    `party_id` BIGINT COMMENT 'Reference to the cardholder (customer) who initiated the transaction.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Card transaction currency (merchant currency) drives DCC eligibility, interchange calculation, and fraud scoring. Currency master provides minor unit for amount precision and cross-border indicator fo',
    `acquirer_bic` STRING COMMENT 'SWIFT BIC code of the acquiring bank that processed the merchant transaction.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `authorization_code` STRING COMMENT 'Approval code returned by the card issuer when the transaction is authorized.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction authorization was received from the card issuer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `avs_result_code` STRING COMMENT 'Result code from address verification system comparing billing address with issuer records.',
    `billing_amount` DECIMAL(18,2) COMMENT 'Amount billed to the cardholder in the card account currency after foreign exchange conversion if applicable.',
    `billing_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the billing amount (card account currency).. Valid values are `^[A-Z]{3}$`',
    `card_present_flag` BOOLEAN COMMENT 'Indicates whether the physical card was present at the time of transaction (True) or not present for card-not-present transactions (False).',
    `card_token` STRING COMMENT 'Tokenized representation of the card number used for secure processing without exposing actual PAN.',
    `card_type` STRING COMMENT 'Type of card used for the transaction: debit, credit, prepaid, or charge card.. Valid values are `DEBIT|CREDIT|PREPAID|CHARGE`',
    `cardholder_present_flag` BOOLEAN COMMENT 'Indicates whether the cardholder was physically present at the point of sale (True) or not (False).',
    `channel_type` STRING COMMENT 'Channel through which the transaction was initiated: point of sale, ATM, e-commerce, mobile app, phone, or mail order.. Valid values are `POS|ATM|ECOMMERCE|MOBILE_APP|PHONE|MAIL_ORDER`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction record was first created in the payment processing system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cvv_result_code` STRING COMMENT 'Result of CVV verification: M=Match, N=No Match, P=Not Processed, S=Should be present, U=Unsupported.. Valid values are `M|N|P|S|U`',
    `decline_reason_code` STRING COMMENT 'Code indicating the reason for transaction decline if authorization was not approved (e.g., insufficient funds, invalid card, suspected fraud).',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the transaction was flagged as potentially fraudulent by the fraud detection system (True) or not (False).',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by fraud detection system indicating likelihood of fraudulent activity, typically 0-100 scale.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert transaction currency to billing currency for cross-border transactions.',
    `interchange_fee_amount` DECIMAL(18,2) COMMENT 'Interchange fee charged by the card issuer to the acquirer for processing the transaction.',
    `issuer_bic` STRING COMMENT 'SWIFT BIC code of the card issuing bank.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `masked_pan` STRING COMMENT 'Masked card number showing first 6 and last 4 digits with middle digits obscured for security. Format: 123456******7890.. Valid values are `^[0-9]{6}[*]{6}[0-9]{4}$`',
    `merchant_category_code` STRING COMMENT 'Four-digit code classifying the merchants business type (e.g., 5411 for grocery stores, 5812 for restaurants).. Valid values are `^[0-9]{4}$`',
    `merchant_city` STRING COMMENT 'City where the merchant is located or where the transaction occurred.',
    `merchant_name` STRING COMMENT 'Name of the merchant or business where the transaction occurred.',
    `network_reference_number` STRING COMMENT 'Unique reference number assigned by the card network for tracking and reconciliation across the payment lifecycle.',
    `pos_entry_mode` STRING COMMENT 'Method by which the card data was entered at the point of sale: chip, swipe, contactless, manual entry, e-commerce, or mobile wallet.. Valid values are `CHIP|SWIPE|CONTACTLESS|MANUAL|ECOMMERCE|MOBILE_WALLET`',
    `posting_date` DATE COMMENT 'Date when the transaction was posted to the cardholders account. Format: yyyy-MM-dd.',
    `retrieval_reference_number` STRING COMMENT 'Reference number used to retrieve transaction details from the card network or processor.',
    `settlement_date` DATE COMMENT 'Date when the transaction is scheduled to settle between acquirer and issuer, typically T+1. Format: yyyy-MM-dd.',
    `three_d_secure_flag` BOOLEAN COMMENT 'Indicates whether 3D Secure authentication was used for this transaction (True) or not (False).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Original transaction amount in the transaction currency before any fees or adjustments.',
    `transaction_reference_number` STRING COMMENT 'Unique external reference number assigned by the card network or acquiring system for this transaction.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the card transaction in the processing workflow.. Valid values are `AUTHORIZED|DECLINED|PENDING|SETTLED|REVERSED|DISPUTED`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the card transaction was initiated at the point of sale or online channel. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `transaction_type` STRING COMMENT 'Type of card transaction: purchase, refund, chargeback, reversal, cash advance, or balance inquiry.. Valid values are `PURCHASE|REFUND|CHARGEBACK|REVERSAL|CASH_ADVANCE|BALANCE_INQUIRY`',
    CONSTRAINT pk_card_transaction PRIMARY KEY(`card_transaction_id`)
) COMMENT 'Transactional record for card-based payments including debit, credit, and prepaid card transactions processed through card networks (Visa, Mastercard, Amex). Captures card number (masked PAN), merchant ID, merchant category code (MCC), transaction amount, authorization code, acquirer BIC, network reference, transaction type (purchase/refund/chargeback), and settlement status. Sourced from card processing module of ACI Worldwide.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`sanction_screening` (
    `sanction_screening_id` BIGINT COMMENT 'Unique identifier for the payment sanction screening record.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Positive sanctions screening matches escalate to full AML case investigation when analyst review confirms true positive. Links screening event to case for investigation workflow, SAR filing, and asset',
    `employee_id` BIGINT COMMENT 'User identifier of the AML analyst who reviewed the sanctions screening result and made the final disposition decision.',
    `instruction_id` BIGINT COMMENT 'Reference to the payment instruction that was screened against sanctions watchlists.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Unique identifier of the sanctioned entity on the watchlist (e.g., OFAC SDN number, UN reference number) that was matched.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: AML compliance requires linking screening results to specific customer party for audit trail, regulatory examination, SAR filing decisions, and customer risk rating updates. Critical for OFAC/sanction',
    `analyst_decision` STRING COMMENT 'Final decision made by the AML analyst after reviewing the sanctions alert: approve payment, reject payment, mark as false positive, or escalate to Money Laundering Reporting Officer (MLRO).. Valid values are `APPROVE|REJECT|FALSE_POSITIVE|ESCALATE_TO_MLRO`',
    `analyst_notes` STRING COMMENT 'Free-text notes and rationale documented by the AML analyst explaining their review findings and decision for audit and regulatory purposes.',
    `analyst_review_required_flag` BOOLEAN COMMENT 'Indicates whether the screening result requires manual review by an Anti-Money Laundering (AML) analyst due to potential match or high-risk indicators.',
    `analyst_review_timestamp` TIMESTAMP COMMENT 'Date and time when the AML analyst completed their review of the sanctions screening alert.',
    `auto_decision_flag` BOOLEAN COMMENT 'Indicates whether the screening decision was made automatically by the system (true) or required manual analyst review (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sanctions screening record was first created in the system.',
    `false_positive_reason` STRING COMMENT 'Reason code explaining why a sanctions match was determined to be a false positive: common name, different jurisdiction, different date of birth, different address, whitelist match, or other.. Valid values are `COMMON_NAME|DIFFERENT_JURISDICTION|DIFFERENT_DOB|DIFFERENT_ADDRESS|WHITELIST_MATCH|OTHER`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sanctions screening record was last updated, typically after analyst review or decision change.',
    `match_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0-100) indicating the strength of the match between the payment party and the watchlist entry, with higher scores indicating stronger matches.',
    `match_status` STRING COMMENT 'Overall result of the sanctions screening indicating whether a match was found: no match, potential match requiring review, confirmed match, or false positive after analyst review.. Valid values are `NO_MATCH|POTENTIAL_MATCH|CONFIRMED_MATCH|FALSE_POSITIVE`',
    `match_type` STRING COMMENT 'Type of matching algorithm that identified the potential sanctions hit: exact name match, fuzzy match, partial match, phonetic match, or alias match.. Valid values are `EXACT|FUZZY|PARTIAL|PHONETIC|ALIAS`',
    `matched_entity_name` STRING COMMENT 'Name of the entity on the sanctions watchlist that matched or partially matched the payment party information.',
    `matched_field` STRING COMMENT 'Specific field in the payment instruction that triggered the sanctions match: name, address, identifier, account number, Bank Identifier Code (BIC), or International Bank Account Number (IBAN).. Valid values are `NAME|ADDRESS|IDENTIFIER|ACCOUNT|BIC|IBAN`',
    `matched_party_role` STRING COMMENT 'Role of the payment party that triggered the sanctions match: originator, beneficiary, intermediary bank, or correspondent bank.. Valid values are `ORIGINATOR|BENEFICIARY|INTERMEDIARY_BANK|CORRESPONDENT_BANK`',
    `ofac_blocking_report_reference` STRING COMMENT 'Reference number of the blocking report submitted to Office of Foreign Assets Control (OFAC) for confirmed sanctions matches requiring asset blocking.',
    `ofac_blocking_required_flag` BOOLEAN COMMENT 'Indicates whether the payment must be blocked and reported to Office of Foreign Assets Control (OFAC) due to confirmed match with a sanctioned entity under United States sanctions programs.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this sanctions screening result requires regulatory reporting such as Suspicious Activity Report (SAR) filing to Financial Crimes Enforcement Network (FinCEN) or equivalent authority.',
    `retry_count` STRING COMMENT 'Number of times the sanctions screening was retried due to system errors or timeouts before a final result was obtained.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this sanctions screening result based on match score, watchlist type, party role, and other risk factors.. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `sar_filing_date` DATE COMMENT 'Date when the Suspicious Activity Report (SAR) was filed with the regulatory authority in response to this sanctions screening result.',
    `sar_filing_reference` STRING COMMENT 'Reference number of the Suspicious Activity Report (SAR) filed with Financial Crimes Enforcement Network (FinCEN) or other regulatory authority if this screening triggered a filing obligation.',
    `screening_decision` STRING COMMENT 'Automated or manual decision resulting from the sanctions screening: pass (allow payment), hold (suspend for review), block (reject payment), or escalate (send to compliance officer).. Valid values are `PASS|HOLD|BLOCK|ESCALATE`',
    `screening_duration_ms` BIGINT COMMENT 'Time taken to complete the sanctions screening process measured in milliseconds, used for system performance monitoring and Service Level Agreement (SLA) compliance.',
    `screening_error_code` STRING COMMENT 'Error code returned by the sanctions screening system if the screening process failed or encountered technical issues.',
    `screening_error_message` STRING COMMENT 'Detailed error message describing any technical issues encountered during the sanctions screening process.',
    `screening_reference_number` STRING COMMENT 'External reference number assigned by the sanctions screening system for audit trail and case management.',
    `screening_system_name` STRING COMMENT 'Name of the Anti-Money Laundering (AML) and sanctions screening system that performed the check (e.g., NICE Actimize, Oracle Financial Crime).',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time when the sanctions screening was performed against the payment instruction.',
    `watchlist_type` STRING COMMENT 'Type of sanctions or watchlist screened against: Office of Foreign Assets Control (OFAC) Specially Designated Nationals (SDN), European Union (EU) Consolidated List, United Nations (UN) Sanctions, Politically Exposed Persons (PEP), Her Majestys Treasury (HMT) UK, or Department of Foreign Affairs and Trade (DFAT) Australia.. Valid values are `OFAC_SDN|EU_CONSOLIDATED|UN_SANCTIONS|PEP|HMT_UK|DFAT_AUSTRALIA`',
    `watchlist_version` STRING COMMENT 'Version identifier or effective date of the sanctions watchlist used during screening to ensure audit trail and regulatory compliance.',
    CONSTRAINT pk_sanction_screening PRIMARY KEY(`sanction_screening_id`)
) COMMENT 'Records the OFAC/sanctions screening result for each payment instruction against watchlists (OFAC SDN, EU Consolidated List, UN Sanctions, PEP lists). Captures screening timestamp, list version, match score, match type (exact/fuzzy/partial), matched entity name, screening decision (pass/hold/block), analyst review outcome, and regulatory reporting obligation. Supports BSA/AML compliance for payment processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`fx_transaction` (
    `fx_transaction_id` BIGINT COMMENT 'Unique identifier for the foreign exchange transaction record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: FX transactions booked to accounting periods for financial reporting and hedge accounting. Required for period-end revaluation, P&L recognition, and IFRS 9/ASC 815 compliance.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: FX deal base currency leg requires currency master for minor unit precision, settlement lag (T+0/T+1/T+2), and regulatory reporting (Dodd-Frank Part 45, EMIR). Base_currency_code replaced by FK.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Cross-border offerings require FX conversion for multi-currency proceeds distribution and international investor settlements. Treasury support for global capital markets transactions and offering curr',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: FX transactions executed to support cross-currency trade settlements or as standalone FX trading activity. Required for linking FX hedges to underlying trades, P&L attribution, and regulatory reportin',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Cross-border M&A deals and international transactions require FX conversion for multi-currency deal settlements. Treasury support for deal execution, FX risk management, and transaction currency conve',
    `employee_id` BIGINT COMMENT 'Identifier of the trader or dealer who executed this FX transaction on behalf of the institution.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: FX transactions hedging currency risk on foreign securities positions need instrument linkage for hedge accounting, effectiveness testing, and portfolio risk reporting. Role-prefixed because FX transa',
    `instruction_id` BIGINT COMMENT 'Reference to the payment instruction that triggered or is associated with this FX transaction.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: FX transactions generate journal entries for realized/unrealized gains/losses, affecting P&L and balance sheet. Required for financial reporting, hedge accounting, and IFRS/GAAP compliance.',
    `nostro_account_id` BIGINT COMMENT 'Reference to the nostro account (our account held at another bank) used for settlement of this FX transaction.',
    `party_id` BIGINT COMMENT 'Identifier of the counterparty institution or entity with whom the FX transaction is executed.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: FX transactions classified by product type (spot, forward, swap, NDF) for risk weighting (Basel III market risk), accounting treatment (IAS 39/IFRS 9 hedge accounting), and regulatory capital calculat',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: FX transactions reported to specific jurisdictions (CFTC for US persons, ESMA for EU entities, ASIC for Australian). Jurisdiction master provides reporting taxonomy, submission method, and regulatory ',
    `vostro_account_id` BIGINT COMMENT 'Reference to the vostro account (their account held at our bank) used for settlement of this FX transaction.',
    `reversal_fx_transaction_id` BIGINT COMMENT 'Self-referencing FK on fx_transaction (reversal_fx_transaction_id)',
    `aml_screening_status` STRING COMMENT 'Status of anti-money laundering screening performed on this FX transaction and its counterparties.. Valid values are `pending|cleared|flagged|blocked`',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'The notional amount in the base currency being exchanged in this FX transaction.',
    `base_currency_settlement_account` STRING COMMENT 'Account number or identifier for the nostro/vostro account used to settle the base currency leg of the FX transaction.',
    `booking_entity` STRING COMMENT 'Legal entity or branch of the institution that booked this FX transaction on its balance sheet.',
    `buy_sell_indicator` STRING COMMENT 'Indicates whether the institution is buying or selling the base currency in this FX transaction.. Valid values are `buy|sell`',
    `counterparty_bic` STRING COMMENT 'SWIFT BIC code of the counterparty bank or financial institution.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this FX transaction record was first created in the payment processing system.',
    `currency_pair` STRING COMMENT 'Standard representation of the currency pair being traded (e.g., USD/EUR, GBP/JPY).. Valid values are `^[A-Z]{3}/[A-Z]{3}$`',
    `deal_rate` DECIMAL(18,2) COMMENT 'The agreed exchange rate at which the base currency is converted to the quote currency for this transaction.',
    `deal_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this FX deal by the trading system or counterparty.',
    `deal_timestamp` TIMESTAMP COMMENT 'Date and time when the FX deal was executed or agreed upon between parties.',
    `fixing_date` DATE COMMENT 'The date on which the final exchange rate is determined for non-deliverable forwards (NDF) or other rate-fixing products.',
    `fixing_rate` DECIMAL(18,2) COMMENT 'The official exchange rate determined on the fixing date, used to calculate settlement amounts for NDF transactions.',
    `forward_points` DECIMAL(18,2) COMMENT 'The adjustment in basis points applied to the spot rate to calculate the forward rate for forward or swap transactions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this FX transaction record was last updated or modified.',
    `profit_center` STRING COMMENT 'Profit center or cost center code to which the profit and loss from this FX transaction is attributed.',
    `purpose_code` STRING COMMENT 'Regulatory or business purpose code indicating the reason for the FX transaction (e.g., trade finance, investment, hedging).',
    `quote_currency_amount` DECIMAL(18,2) COMMENT 'The equivalent amount in the quote currency calculated using the deal rate.',
    `quote_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the quote currency in the FX pair (e.g., EUR in USD/EUR).. Valid values are `^[A-Z]{3}$`',
    `quote_currency_settlement_account` STRING COMMENT 'Account number or identifier for the nostro/vostro account used to settle the quote currency leg of the FX transaction.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this FX transaction is subject to regulatory reporting requirements (e.g., EMIR, Dodd-Frank, MiFID II).',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions screening performed against OFAC, UN, EU, and other watchlists for this FX transaction.. Valid values are `pending|cleared|flagged|blocked`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The net cash settlement amount paid or received for non-deliverable forwards, calculated as the difference between deal rate and fixing rate.',
    `settlement_date` DATE COMMENT 'Actual date when the FX transaction settled and currency exchange was completed.',
    `settlement_method` STRING COMMENT 'Method used to settle the FX transaction: gross settlement, multilateral netting, or Continuous Linked Settlement (CLS).. Valid values are `gross|net|cls`',
    `spot_rate_reference` DECIMAL(18,2) COMMENT 'The prevailing spot exchange rate at the time of deal execution, used as reference for forward pricing.',
    `swift_message_type` STRING COMMENT 'SWIFT message type used to communicate this FX transaction (e.g., MT300 for FX confirmation, MT202 for payment).. Valid values are `^MT[0-9]{3}$|^MX[A-Z]{4}.[0-9]{3}.[0-9]{3}.[0-9]{2}$`',
    `swift_uetr` STRING COMMENT 'Unique end-to-end transaction reference assigned by SWIFT for tracking this FX transaction across the payment chain.. Valid values are `^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$`',
    `trade_date` DATE COMMENT 'The date on which the FX transaction was executed in the market.',
    `trading_desk` STRING COMMENT 'Name or code of the trading desk or business unit responsible for executing this FX transaction.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the FX transaction in the payment processing workflow.. Valid values are `pending|confirmed|settled|cancelled|failed|expired`',
    `transaction_type` STRING COMMENT 'Type of FX transaction: spot (immediate settlement), forward (future settlement), swap (simultaneous buy/sell), or non-deliverable forward (NDF).. Valid values are `spot|forward|swap|ndf`',
    `value_date` DATE COMMENT 'The date on which the FX transaction is scheduled to settle and funds are exchanged.',
    CONSTRAINT pk_fx_transaction PRIMARY KEY(`fx_transaction_id`)
) COMMENT 'Foreign exchange transaction record for spot, forward, and swap FX trades executed through the payments function. Captures currency pair, deal rate, value date, settlement instructions, and counterparty.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`exception` (
    `exception_id` BIGINT COMMENT 'Unique identifier for the payment exception record. Primary key.',
    `aml_alert_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_alert. Business justification: Payment exceptions with compliance flags (sanctions hit, AML screening failure) generate AML alerts for investigation. Links exception to alert for root cause analysis and regulatory reporting of syst',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Payment exceptions requiring financial correction generate adjusting journal entries. Role-prefixed to distinguish from original transaction JEs. Required for error correction audit trail and SOX comp',
    `employee_id` BIGINT COMMENT 'Identifier of the operations staff member or analyst currently assigned to resolve this exception.',
    `exception_resolved_by_user_employee_id` BIGINT COMMENT 'Identifier of the operations staff member who completed the resolution of this exception.',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Payment exceptions with fraud indicators trigger fraud alerts for investigation. Direct linkage enables exception-based fraud detection and alert disposition. Core exception monitoring and fraud detec',
    `instruction_id` BIGINT COMMENT 'Reference to the payment instruction that generated this exception.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Payment exceptions require channel attribution for root cause analysis by channel, SLA breach monitoring, operational improvement initiatives, and channel-specific error rate tracking. Essential for c',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Exception reporting and financial impact analysis aggregate by currency. Currency master provides convertibility status for exception resolution routing and regulatory reporting thresholds (SAR filing',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the payment transaction associated with this exception, if applicable.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Exceptions on securities settlement payments require instrument reference for root cause analysis, pattern detection across instrument types, and escalation to securities operations vs. payments opera',
    `parent_payment_exception_id` BIGINT COMMENT 'Self-referencing FK on exception (parent_payment_exception_id)',
    `assigned_queue` STRING COMMENT 'Name or identifier of the operations queue or team to which this exception has been assigned for resolution.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was assigned to a specific user or queue for resolution.',
    `beneficiary_name` STRING COMMENT 'Name of the intended recipient of the payment that encountered the exception.',
    `correspondent_bank_bic` STRING COMMENT 'SWIFT BIC code of the correspondent bank involved in the payment chain where the exception occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was first created in the system for audit trail purposes.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicator of whether the originating customer or beneficiary has been notified about the exception (true = notified, false = not notified).',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer notification was sent regarding the payment exception.',
    `detection_system` STRING COMMENT 'Name or identifier of the system or module that detected and raised the exception (e.g., payment hub, screening engine, settlement system).',
    `error_message` STRING COMMENT 'Technical error message or code returned by the payment processing system at the time of exception occurrence.',
    `escalation_level` STRING COMMENT 'Numeric indicator of how many times this exception has been escalated to higher authority or specialized teams (0 = no escalation).',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent escalation event for this exception.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception indicating its resolution state (e.g., open, assigned, in progress, resolved, closed). [ENUM-REF-CANDIDATE: OPEN|ASSIGNED|IN_PROGRESS|PENDING_REVIEW|ESCALATED|RESOLVED|CLOSED|CANCELLED|RESUBMITTED — 9 candidates stripped; promote to reference product]',
    `exception_timestamp` TIMESTAMP COMMENT 'Date and time when the payment exception was first detected or raised by the payment processing system.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the exception including potential fees, penalties, interest, or opportunity cost.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was most recently updated, supporting audit trail and change tracking.',
    `max_retry_limit` STRING COMMENT 'Maximum number of retry attempts allowed for this exception type before requiring manual intervention or cancellation.',
    `originator_name` STRING COMMENT 'Name of the party initiating the payment that encountered the exception.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the payment instruction that encountered the exception.',
    `payment_rail_type` STRING COMMENT 'Payment rail or network through which the payment was being processed when the exception occurred. [ENUM-REF-CANDIDATE: ACH|WIRE|RTGS|SWIFT|SEPA|FASTER_PAYMENTS|FEDWIRE|CHIPS|TARGET2|BACS|CHAPS|RTP|CARD_NETWORK|INTERNAL_TRANSFER — 14 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for tracking and reporting the exception across systems and with external parties.',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier of any regulatory report filed in connection with this exception (e.g., SAR, CTR reference).',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicator of whether this exception must be reported to regulatory authorities (true = reporting required, false = no reporting required).',
    `resolution_action_code` STRING COMMENT 'Standardized code indicating the corrective action taken or planned to resolve the exception. [ENUM-REF-CANDIDATE: MANUAL_REPAIR|RESUBMIT|CANCEL|RETURN_TO_ORIGINATOR|ROUTE_ALTERNATE|CONTACT_BENEFICIARY|CONTACT_CORRESPONDENT|OVERRIDE_SCREENING|ESCALATE|AWAIT_FUNDS|AMEND_INSTRUCTION|SPLIT_PAYMENT|MERGE_PAYMENT|NO_ACTION_REQUIRED — 14 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, actions taken, and any relevant context for audit and knowledge management.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was successfully resolved and the payment was either completed, cancelled, or otherwise closed.',
    `resubmission_eligible_flag` BOOLEAN COMMENT 'Indicator of whether the payment instruction can be automatically or manually resubmitted after exception resolution (true = eligible, false = not eligible).',
    `retry_count` STRING COMMENT 'Number of automated or manual retry attempts made to process the payment after the initial exception occurred.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the underlying root cause of the exception as determined during investigation.',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings describing why the exception occurred.',
    `severity` STRING COMMENT 'Severity classification of the exception indicating business impact and urgency (critical, high, medium, low).. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `sla_actual_minutes` STRING COMMENT 'Actual elapsed time in minutes from exception detection to resolution, used for SLA compliance measurement.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether the exception resolution exceeded the defined SLA target time (true = breach occurred, false = within SLA).',
    `sla_target_minutes` STRING COMMENT 'Target resolution time in minutes as defined by the applicable service level agreement for this exception type and severity.',
    `swift_message_type` STRING COMMENT 'SWIFT message type code associated with the payment instruction that encountered the exception (e.g., MT103, MT202, MX pacs.008).',
    `type_code` STRING COMMENT 'Categorization code identifying the nature of the payment exception (e.g., validation failure, screening hold, routing error, settlement failure). [ENUM-REF-CANDIDATE: VALIDATION_FAILURE|SCREENING_HOLD|ROUTING_ERROR|SETTLEMENT_FAILURE|NOSTRO_MISMATCH|VOSTRO_MISMATCH|INSUFFICIENT_FUNDS|BENEFICIARY_UNREACHABLE|SWIFT_REJECT|TIMEOUT|DUPLICATE_PAYMENT|REGULATORY_BLOCK|SANCTIONS_HIT|AML_ALERT|FORMAT_ERROR|CUTOFF_BREACH|LIQUIDITY_CONSTRAINT|CORRESPONDENT_REJECT|INTERMEDIARY_REJECT|ACCOUNT_CLOSED|MANDATE_INVALID|FX_RATE_UNAVAILABLE|SYSTEM_ERROR|OTHER — 24 candidates stripped; promote to reference product]',
    CONSTRAINT pk_exception PRIMARY KEY(`exception_id`)
) COMMENT 'Record of payment processing exceptions requiring manual intervention or repair. Captures exception type, root cause, resolution action, SLA target, and resolution timestamp.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`payment_fee` (
    `payment_fee_id` BIGINT COMMENT 'Unique identifier for the payment fee record. Primary key.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: Trade-related fees (brokerage, exchange, clearing, custody) are captured as payment fees and must link to originating trades for accurate P&L attribution, TCA analysis, and client billing. Essential f',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Fees assessed on collateral management services (custody fees, valuation fees, substitution fees, perfection filing fees) need asset reference for accurate billing, fee allocation to clients, and P&L ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Fee income allocated to cost centers for profitability analysis and management reporting. Replaces denormalized cost_center_code string. Required for business unit performance measurement and RAROC ca',
    `creditor_account_id` BIGINT COMMENT 'Reference to the internal general ledger or fee income account to which this fee is credited.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee assessment currency drives GL posting, revenue recognition, and customer billing. Currency master provides minor unit for fee calculation precision and tax reporting attributes for VAT/GST on cros',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Investment banking fees (advisory, underwriting, success fees) are captured as payment fees linked to originating deal. Required for revenue attribution, deal profitability analysis, and fee revenue r',
    `deposit_account_id` BIGINT COMMENT 'Reference to the account from which this fee is debited.',
    `employee_id` BIGINT COMMENT 'User ID of the employee who approved the fee waiver, if applicable.',
    `fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to investment.fee_arrangement. Business justification: Fee arrangements define contractual fee structure; payment_fee records actual fee collection. Links billing to contract terms for revenue recognition, fee reconciliation, and audit trail of fee paymen',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee revenue must post to specific GL accounts for income recognition and financial reporting. Replaces denormalized gl_account_code string with proper FK for referential integrity and financial close ',
    `instruction_id` BIGINT COMMENT 'Reference to the payment instruction for which this fee is charged.',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to investment.mandate. Business justification: Investment banking mandate fees (retainer, success fee) are collected as payment fees linked to engagement mandate. Revenue recognition for advisory services and fee reconciliation against mandate let',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the institution or entity that is charging this fee (own bank, correspondent bank, intermediary).',
    `party_id` BIGINT COMMENT 'Reference to the customer who is being charged this fee, enabling customer-level fee analysis and reporting.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the payment transaction associated with this fee, if applicable.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Fee income allocated to profit centers for business line profitability analysis and RAROC calculations. Required for management reporting, transfer pricing, and regulatory segment reporting (IFRS 8).',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Fee structures, waivers, and charge-bearer practices examined for fair lending and consumer protection compliance. Links fee records to exam for sample selection, testing evidence, and finding remedia',
    `reporting_code_id` BIGINT COMMENT 'Foreign key linking to reference.reporting_code. Business justification: Fee income reported under specific taxonomy codes (FFIEC Call Report Schedule RI for non-interest income, Basel III for operational risk). Reporting_code provides GL account mapping and calculation fo',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities custody fees, settlement fees, and safekeeping charges are assessed per instrument. Essential for client billing, fee reconciliation, and profitability analysis of securities services busin',
    `previous_payment_fee_id` BIGINT COMMENT 'Self-referencing FK on payment_fee (previous_payment_fee_id)',
    `amount` DECIMAL(18,2) COMMENT 'The monetary amount of the fee charged, in the fee currency.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the fee was assessed and applied to the account, in ISO 8601 format. Represents the business event time when the fee became effective.',
    `basis_amount` DECIMAL(18,2) COMMENT 'The transaction amount or notional value on which the fee calculation is based, in the transaction currency.',
    `basis_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the fee_basis_amount.. Valid values are `^[A-Z]{3}$`',
    `billing_amount` DECIMAL(18,2) COMMENT 'The amount billed to the customer after any currency conversion, in the billing currency. May differ from fee_amount if FX conversion is applied.',
    `billing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the customer is billed for this fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `billing_entity_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the institution charging this fee, if applicable.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `billing_entity_name` STRING COMMENT 'Name of the institution or entity that is charging this fee.',
    `calculation_method` STRING COMMENT 'Method used to calculate the fee: FLAT (fixed amount), PERCENTAGE (percentage of transaction amount), TIERED (rate varies by transaction size or volume), NEGOTIATED (custom rate per customer agreement).. Valid values are `FLAT|PERCENTAGE|TIERED|NEGOTIATED`',
    `charge_bearer_code` STRING COMMENT 'Indicates who bears the fee: OUR (originator pays all fees), BEN (beneficiary pays all fees), SHA (shared - each party pays their own banks fees).. Valid values are `OUR|BEN|SHA`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fee record was first created in the system, in ISO 8601 format. Audit trail field.',
    `fee_category` STRING COMMENT 'High-level categorization of the fee: TRANSACTION (per-transaction charge), SERVICE (service-level fee), INTERMEDIARY (third-party bank fee), REGULATORY (compliance or reporting fee), PENALTY (late or exception fee).. Valid values are `TRANSACTION|SERVICE|INTERMEDIARY|REGULATORY|PENALTY`',
    `fee_status` STRING COMMENT 'Current lifecycle status of the fee: PENDING (calculated but not yet applied), ASSESSED (applied to account), BILLED (invoiced to customer), WAIVED (forgiven), REVERSED (cancelled or refunded).. Valid values are `PENDING|ASSESSED|BILLED|WAIVED|REVERSED`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert fee_amount to billing_amount, if currencies differ. Expressed as billing_currency per fee_currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fee record was last updated, in ISO 8601 format. Audit trail field.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this fee charge.',
    `payment_rail_type` STRING COMMENT 'The payment rail or network over which the underlying payment was processed: ACH (Automated Clearing House), WIRE (wire transfer), RTGS (Real-Time Gross Settlement), SWIFT (SWIFT network), SEPA (Single Euro Payments Area), FEDWIRE (Federal Reserve Wire Network), CHIPS (Clearing House Interbank Payments System). [ENUM-REF-CANDIDATE: ACH|WIRE|RTGS|SWIFT|SEPA|FEDWIRE|CHIPS — 7 candidates stripped; promote to reference product]',
    `product_code` STRING COMMENT 'Code identifying the banking product or service to which this fee relates (e.g., commercial payments, retail wire transfers).',
    `rate_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to the transaction amount to calculate the fee, if fee_calculation_method is PERCENTAGE or TIERED. Expressed as a decimal (e.g., 0.015 for 1.5%).',
    `reference_number` STRING COMMENT 'Externally visible unique reference number for this fee charge, used for reconciliation and customer inquiries.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this fee must be included in regulatory reporting (e.g., CFPB fee disclosure, Basel III revenue reporting). True if reporting is required, False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason the fee was reversed, if applicable: ERROR (processing error), DISPUTE (customer dispute), REFUND (refund issued), ADJUSTMENT (accounting adjustment).. Valid values are `ERROR|DISPUTE|REFUND|ADJUSTMENT`',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the fee was reversed, in ISO 8601 format.',
    `settlement_date` DATE COMMENT 'The date on which the fee is settled and posted to the general ledger, in yyyy-MM-dd format.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that originated this fee record (e.g., ACI Worldwide, Volante, core banking system).',
    `tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax charged on this fee, if applicable, in the billing currency.',
    `tax_applicable_flag` BOOLEAN COMMENT 'Indicates whether this fee is subject to taxation (e.g., VAT, GST, sales tax). True if tax applies, False otherwise.',
    `type_code` STRING COMMENT 'Classification code indicating the type of fee charged: WIRE (wire transfer fee), ACH (Automated Clearing House fee), FX (foreign exchange conversion fee), CORRESPONDENT (correspondent bank charge), SWIFT (SWIFT messaging fee), RTGS (Real-Time Gross Settlement fee), PROCESSING (general processing fee). [ENUM-REF-CANDIDATE: WIRE|ACH|FX|CORRESPONDENT|SWIFT|RTGS|PROCESSING — 7 candidates stripped; promote to reference product]',
    `value_date` DATE COMMENT 'The date on which the fee amount is considered effective for interest calculation and accounting purposes, in yyyy-MM-dd format.',
    `waiver_reason_code` STRING COMMENT 'Code indicating the reason the fee was waived, if applicable: RELATIONSHIP (customer relationship), PROMOTION (marketing campaign), ERROR (bank error), GOODWILL (customer service gesture), REGULATORY (regulatory requirement).. Valid values are `RELATIONSHIP|PROMOTION|ERROR|GOODWILL|REGULATORY`',
    `waiver_timestamp` TIMESTAMP COMMENT 'Date and time when the fee waiver was approved and applied, in ISO 8601 format.',
    CONSTRAINT pk_payment_fee PRIMARY KEY(`payment_fee_id`)
) COMMENT 'Fee record for payment processing charges including wire fees, ACH fees, FX conversion fees, and correspondent bank charges. Captures fee type, amount, currency, and billing entity.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`correspondent_bank` (
    `correspondent_bank_id` BIGINT COMMENT 'Unique identifier for the correspondent banking relationship record. Primary key.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Correspondent BIC must validate against SWIFT BIC directory for connectivity status, service profile (payments vs securities), and IBAN support. BIC directory provides institution type, address, and r',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Correspondent bank country determines sanctions screening requirements (OFAC, EU), regulatory approval needs (Fed Reserve approval for US correspondents), and settlement risk limits. Country master pr',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this correspondent bank relationship record.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Correspondent bank operating days determine settlement windows and nostro funding requirements. Holiday calendar provides business day convention for value date calculation and liquidity planning for ',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Correspondent banking relationships require enhanced due diligence reviews per FinCEN guidance and Section 312 requirements. Links correspondent to KYC review for periodic refresh, risk rating updates',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Correspondent banks are legal entities in the banking network. Required for counterparty risk reporting, regulatory capital calculations (CCAR/DFAST), and intercompany elimination in consolidated fina',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Correspondent bank LEI required for regulatory reporting (CFTC Part 45 for FX swaps, EMIR for derivatives clearing, MiFID II transaction reporting). LEI registry provides legal entity hierarchy and ju',
    `parent_correspondent_bank_id` BIGINT COMMENT 'Self-referencing FK on correspondent_bank (parent_correspondent_bank_id)',
    `aml_risk_rating` STRING COMMENT 'Anti-Money Laundering (AML) risk rating assigned to this correspondent bank based on jurisdiction, business model, and compliance history.. Valid values are `low|medium|high|prohibited`',
    `contact_email` STRING COMMENT 'Email address of the primary contact at the correspondent bank for operational communications and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary relationship manager or contact person at the correspondent bank for operational matters.',
    `contact_phone` STRING COMMENT 'Phone number of the primary contact at the correspondent bank for urgent operational matters.',
    `correspondent_city` STRING COMMENT 'City where the correspondent banks primary office or headquarters is located.',
    `correspondent_name` STRING COMMENT 'Full legal name of the correspondent banking institution as registered with regulatory authorities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this correspondent bank relationship record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure limit approved for transactions with this correspondent bank, denominated in primary currency.',
    `cutoff_time_utc` STRING COMMENT 'Daily cutoff time in UTC (HH:MM format) for submitting payment instructions to meet same-day settlement through this correspondent.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount permitted per business day through this correspondent relationship, denominated in primary currency.',
    `fee_structure_code` STRING COMMENT 'Code identifying the fee structure and pricing schedule applicable to transactions processed through this correspondent relationship.',
    `gpi_enabled` BOOLEAN COMMENT 'Indicates whether this correspondent bank supports SWIFT Global Payments Innovation (gpi) for enhanced payment tracking and transparency.',
    `intermediary_bank_required` BOOLEAN COMMENT 'Indicates whether an intermediary bank is typically required for routing payments through this correspondent relationship.',
    `kyc_next_review_date` DATE COMMENT 'Scheduled date for the next periodic KYC due diligence review of this correspondent banking relationship.',
    `kyc_review_date` DATE COMMENT 'Date when the most recent KYC due diligence review was completed for this correspondent relationship.',
    `kyc_status` STRING COMMENT 'Current status of Know Your Customer (KYC) due diligence for this correspondent bank relationship.. Valid values are `compliant|pending|expired|non_compliant`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this correspondent bank relationship record was most recently updated or modified.',
    `nostro_account_iban` STRING COMMENT 'International Bank Account Number (IBAN) of the nostro account held at the correspondent bank, if applicable.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `nostro_account_number` STRING COMMENT 'Account number of our institutions nostro account held at the correspondent bank for settlement purposes.',
    `payment_rail_types` STRING COMMENT 'Comma-separated list of payment rail types supported through this correspondent (e.g., SWIFT, RTGS, ACH, SEPA, TARGET2, CHAPS).',
    `preferred_intermediary_bic` STRING COMMENT 'SWIFT BIC of the preferred intermediary bank to use when routing payments through this correspondent, if applicable.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `primary_currency` STRING COMMENT 'Primary ISO 4217 three-letter currency code used for settlement with this correspondent bank.. Valid values are `^[A-Z]{3}$`',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier for regulatory approval documentation related to this correspondent relationship.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether regulatory approval or notification is required for establishing or maintaining this correspondent relationship.',
    `relationship_end_date` DATE COMMENT 'Date when the correspondent banking relationship was terminated or is scheduled to terminate. Null for active relationships.',
    `relationship_start_date` DATE COMMENT 'Date when the correspondent banking relationship became effective and operational for payment routing.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the correspondent banking relationship indicating operational availability and compliance standing.. Valid values are `active|suspended|terminated|pending_approval|under_review|dormant`',
    `relationship_type` STRING COMMENT 'Type of correspondent banking relationship: nostro (our account with them), vostro (their account with us), bilateral (reciprocal), or unilateral (one-way).. Valid values are `nostro|vostro|bilateral|unilateral`',
    `sanctions_screening_date` DATE COMMENT 'Date when the most recent sanctions screening was performed for this correspondent bank.',
    `sanctions_screening_status` STRING COMMENT 'Current sanctions screening status indicating whether the correspondent bank has been screened against OFAC, UN, EU, and other sanctions lists.. Valid values are `clear|match|pending_review`',
    `service_level_agreement_reference` STRING COMMENT 'Reference identifier for the Service Level Agreement (SLA) governing operational performance and service standards with this correspondent.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle for transactions: T0 (same day), T1 (trade date plus one day), T2 (trade date plus two days).. Valid values are `T0|T1|T2`',
    `settlement_method` STRING COMMENT 'Method used for settling transactions with the correspondent: gross (real-time transaction-by-transaction), net (end-of-day netting), or deferred_net (periodic netting).. Valid values are `gross|net|deferred_net`',
    `supported_currencies` STRING COMMENT 'Comma-separated list of ISO 4217 three-letter currency codes that can be processed through this correspondent relationship (e.g., USD,EUR,GBP,JPY).',
    `swift_message_types` STRING COMMENT 'Comma-separated list of SWIFT message types (MT codes) supported for this correspondent relationship (e.g., MT103, MT202, MT910).',
    `vostro_account_number` STRING COMMENT 'Account number of the correspondent banks vostro account held at our institution for reciprocal settlement.',
    CONSTRAINT pk_correspondent_bank PRIMARY KEY(`correspondent_bank_id`)
) COMMENT 'Master registry of correspondent banking relationships used for cross-border payment routing. Captures correspondent BIC, relationship type, supported currencies, credit limits, and due diligence status.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`payment_channel` (
    `payment_channel_id` BIGINT COMMENT 'Unique identifier for the payment channel. Primary key for the payment channel master record.',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Payment channel configurations are key IT general controls under SOX for system access, change management, and operational effectiveness. Links channel to control for testing evidence and deficiency r',
    `employee_id` BIGINT COMMENT 'The user identifier of the person or system account that last modified this payment channel configuration record.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Payment channel availability tied to market holidays (e.g., CHAPS closed on UK bank holidays, Fedwire closed on US federal holidays). Holiday calendar provides operating hours and partial day schedule',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Payment channels optimized for specific currency (e.g., SEPA for EUR, CHAPS for GBP). Currency master provides settlement cycle, cutoff times, and liquidity requirements for channel capacity planning ',
    `parent_payment_channel_id` BIGINT COMMENT 'Self-referencing FK on payment_channel (parent_payment_channel_id)',
    `aml_screening_required` BOOLEAN COMMENT 'Indicates whether payments through this channel must undergo mandatory Anti-Money Laundering screening before processing.',
    `batch_processing_supported` BOOLEAN COMMENT 'Indicates whether the payment channel supports batch file submission for multiple payment instructions in a single transmission.',
    `channel_code` STRING COMMENT 'Standardized code identifying the payment rail or channel (e.g., ACH, WIRE, SWIFT, SEPA, RTP, FEDNOW, CHIPS, VISA, MASTERCARD).. Valid values are `^[A-Z0-9]{2,10}$`',
    `channel_name` STRING COMMENT 'Full descriptive name of the payment channel or rail (e.g., Automated Clearing House, Fedwire Funds Service, Society for Worldwide Interbank Financial Telecommunication).',
    `channel_status` STRING COMMENT 'Current operational status of the payment channel indicating availability for payment processing.. Valid values are `active|inactive|suspended|maintenance`',
    `channel_type` STRING COMMENT 'Classification of the payment channel based on processing model: batch (ACH), real-time (RTP, FedNow), near real-time (SWIFT gpi), or deferred settlement.. Valid values are `batch|real_time|near_real_time|deferred`',
    `charge_bearer_default` STRING COMMENT 'Default charge bearer code for the channel indicating who pays transaction fees: OUR (originator pays all), BEN (beneficiary pays all), SHA (shared between parties).. Valid values are `OUR|BEN|SHA`',
    `clearing_house_identifier` STRING COMMENT 'Unique identifier for the clearing house or settlement system associated with this payment channel (e.g., FedACH, CHIPS, CLS).. Valid values are `^[A-Z0-9]{2,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment channel record was first created in the system, expressed in ISO 8601 format with timezone.',
    `cross_border_enabled` BOOLEAN COMMENT 'Indicates whether the payment channel supports cross-border international payments (True) or is limited to domestic transactions (False).',
    `cutoff_time` TIMESTAMP COMMENT 'Daily deadline for submitting payments to be included in the current settlement cycle, expressed in HH:MM format in the operating timezone.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'The maximum aggregate payment amount that can be processed through this channel in a single business day, expressed in the primary currency.',
    `effective_from_date` DATE COMMENT 'The date from which this payment channel configuration became active and available for payment processing.',
    `effective_to_date` DATE COMMENT 'The date on which this payment channel configuration will be or was deactivated. Null indicates the channel is currently active with no planned end date.',
    `fee_structure_code` STRING COMMENT 'Code referencing the fee schedule and pricing structure applicable to payments processed through this channel.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `gpi_enabled` BOOLEAN COMMENT 'Indicates whether the channel supports SWIFT Global Payments Innovation (gpi) for enhanced tracking and faster processing of cross-border payments.',
    `intermediary_bank_allowed` BOOLEAN COMMENT 'Indicates whether the payment channel supports routing through intermediary correspondent banks for indirect settlement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment channel record was most recently updated, expressed in ISO 8601 format with timezone.',
    `maximum_transaction_amount` DECIMAL(18,2) COMMENT 'The maximum payment amount that can be processed through this channel in a single transaction, expressed in the primary currency.',
    `minimum_transaction_amount` DECIMAL(18,2) COMMENT 'The minimum payment amount that can be processed through this channel, expressed in the primary currency.',
    `network_operator` STRING COMMENT 'The organization or entity that operates and governs the payment network or rail (e.g., Federal Reserve, SWIFT, The Clearing House, NACHA, Visa, Mastercard).',
    `nostro_account_required` BOOLEAN COMMENT 'Indicates whether payments through this channel require the use of nostro accounts (our account held at correspondent banks) for settlement.',
    `operating_hours_end` STRING COMMENT 'Daily end time when the payment channel closes for transaction submission, expressed in HH:MM format in the channels operating timezone.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Daily start time when the payment channel opens for transaction submission, expressed in HH:MM format in the channels operating timezone.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_timezone` STRING COMMENT 'Timezone in which the payment channel operates and cutoff times are defined (e.g., EST, UTC, CET).. Valid values are `^[A-Z]{3,4}$`',
    `priority_levels_supported` STRING COMMENT 'Comma-separated list of payment priority levels supported by this channel (e.g., normal, urgent, high, express) for expedited processing.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether payments through this channel trigger mandatory regulatory reporting requirements (e.g., Currency Transaction Reports, Suspicious Activity Reports).',
    `return_window_days` STRING COMMENT 'The number of business days within which a payment processed through this channel can be returned or reversed by the receiving institution.',
    `sanctions_screening_required` BOOLEAN COMMENT 'Indicates whether payments through this channel must undergo mandatory sanctions screening against OFAC and other watchlists before processing.',
    `settlement_cycle` STRING COMMENT 'Standard settlement timeframe for the payment channel expressed as trade date plus days (T+0, T+1, T+2) or descriptive terms (same-day, next-day, intraday).. Valid values are `T0|T1|T2|same_day|next_day|intraday`',
    `settlement_model` STRING COMMENT 'Settlement methodology used by the channel: gross settlement (transaction-by-transaction) or net settlement (aggregated positions).. Valid values are `gross|net|multilateral_net|bilateral_net`',
    `sla_target_completion_minutes` STRING COMMENT 'The target time in minutes from payment submission to settlement confirmation as defined in the channels service level agreement.',
    `standard_fee_amount` DECIMAL(18,2) COMMENT 'The standard per-transaction fee charged for processing payments through this channel, expressed in the primary currency.',
    `supported_currencies` STRING COMMENT 'Comma-separated list of ISO 4217 three-letter currency codes that the payment channel supports for transaction processing (e.g., USD, EUR, GBP, JPY).',
    `swift_message_types` STRING COMMENT 'Comma-separated list of SWIFT message type codes supported by this channel (e.g., MT103, MT202, MT900, MT910) for payment instructions and confirmations.',
    `vostro_account_required` BOOLEAN COMMENT 'Indicates whether payments through this channel require the use of vostro accounts (their account held at our bank) for settlement.',
    CONSTRAINT pk_payment_channel PRIMARY KEY(`payment_channel_id`)
) COMMENT 'Master record defining the payment channels and rails available for payment processing — ACH, Fedwire, CHIPS, SWIFT, SEPA, card networks (Visa/Mastercard), real-time payment networks (RTP, FedNow). Captures channel code, channel name, operating hours, cut-off times, settlement cycle, and supported currencies.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Unique identifier for the payment reconciliation record. Primary key for the payment reconciliation entity.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to payment.payment_batch. Business justification: payment_reconciliation reconciles payment batches against external statements. internal_batch_reference should be normalized to payment_batch_id FK. This is a standard N:1 relationship where a reconci',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Reconciliation of collateral-related payments (margin settlements, repo interest, securities lending fees, collateral substitution settlements) requires asset identification for break resolution, nost',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Reconciliation performed per currency for nostro account balancing and clearing house settlement confirmation. Currency master provides minor unit for tolerance threshold calculation and settlement la',
    `nostro_account_id` BIGINT COMMENT 'Identifier for the nostro account (our account held at a correspondent bank) involved in the reconciliation, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or analyst who completed the resolution of reconciliation breaks.',
    `reconciliation_performed_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or analyst who initiated or performed the reconciliation activity.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Reconciling securities settlement payments requires matching cash movements to expected instrument cash flows (coupons, redemptions, trade settlements). Essential for break resolution and operational ',
    `vostro_account_id` BIGINT COMMENT 'Identifier for the vostro account (their account held at our bank) involved in the reconciliation, if applicable.',
    `previous_reconciliation_id` BIGINT COMMENT 'Self-referencing FK on reconciliation (previous_reconciliation_id)',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this reconciliation record to detailed audit logs and supporting documentation for compliance and investigation purposes.',
    `break_item_count` STRING COMMENT 'The total number of reconciliation break items identified, including discrepancies in amounts, dates, or missing transactions.',
    `card_network_name` STRING COMMENT 'The name of the card network providing settlement files for card transaction reconciliation.. Valid values are `VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|JCB`',
    `clearing_house_identifier` STRING COMMENT 'The unique identifier or name of the clearing house providing the external settlement file being reconciled.',
    `correspondent_bank_bic` STRING COMMENT 'The Bank Identifier Code (BIC) or SWIFT code of the correspondent bank whose statement is being reconciled against internal records.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was first created in the system.',
    `exception_count` STRING COMMENT 'The number of exceptions or anomalies identified during the reconciliation process that require investigation or resolution.',
    `external_statement_reference` STRING COMMENT 'The reference number or identifier of the external statement, confirmation file, or settlement report being reconciled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was last updated or modified.',
    `matched_amount` DECIMAL(18,2) COMMENT 'The aggregate monetary value of payments that were successfully matched between internal and external records.',
    `matched_payment_count` STRING COMMENT 'The number of payment transactions that were successfully matched between internal records and external confirmations.',
    `matching_rule_set` STRING COMMENT 'The identifier or name of the rule set or algorithm used to match internal payment records with external confirmations.',
    `notes` STRING COMMENT 'Free-text field for analysts to document observations, resolution actions, root causes of breaks, or other relevant information about the reconciliation activity.',
    `payment_rail_type` STRING COMMENT 'The payment system or network through which the payments being reconciled were processed. [ENUM-REF-CANDIDATE: ACH|WIRE|RTGS|SWIFT|SEPA|FEDWIRE|CHIPS|TARGET2|CARD|FX — 10 candidates stripped; promote to reference product]',
    `reconciliation_date` DATE COMMENT 'The business date on which the reconciliation activity was performed.',
    `reconciliation_method` STRING COMMENT 'The method used to perform the reconciliation, indicating the level of automation versus manual intervention.. Valid values are `automated|manual|semi_automated`',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation activity in its lifecycle, indicating whether the process is ongoing, completed, or encountered issues.. Valid values are `pending|in_progress|completed|failed|partially_reconciled|exception`',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the reconciliation process was executed.',
    `reconciliation_type` STRING COMMENT 'The category of reconciliation being performed, indicating the source of external records being matched against internal payment records.. Valid values are `nostro|vostro|clearing_house|card_network|correspondent_bank|internal`',
    `reference_number` STRING COMMENT 'Business-assigned unique reference number for the reconciliation activity, used for tracking and audit purposes.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation activity or its breaks require reporting to regulatory authorities due to materiality or compliance requirements.',
    `resolution_status` STRING COMMENT 'The current status of resolution efforts for identified reconciliation breaks and exceptions.. Valid values are `unresolved|in_progress|resolved|escalated|waived`',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when all reconciliation breaks were resolved and the reconciliation was closed.',
    `settlement_date` DATE COMMENT 'The date on which the payments being reconciled were settled or are expected to settle.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'The actual number of hours taken to complete the reconciliation process from initiation to resolution.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation process exceeded the defined SLA target time, requiring escalation or management attention.',
    `sla_target_hours` STRING COMMENT 'The target number of hours within which the reconciliation process should be completed according to service level agreements.',
    `system_source` STRING COMMENT 'The name or identifier of the payment processing system or reconciliation platform that generated this reconciliation record.',
    `tolerance_threshold_amount` DECIMAL(18,2) COMMENT 'The maximum acceptable variance in monetary amounts for a match to be considered successful during reconciliation.',
    `total_payment_count` STRING COMMENT 'The total number of payment transactions included in the reconciliation scope.',
    `total_reconciled_amount` DECIMAL(18,2) COMMENT 'The aggregate monetary value of all payments included in the reconciliation scope.',
    `unmatched_amount` DECIMAL(18,2) COMMENT 'The aggregate monetary value of payments that could not be matched, representing the financial exposure of reconciliation breaks.',
    `unmatched_payment_count` STRING COMMENT 'The number of payment transactions that could not be matched between internal records and external confirmations, representing reconciliation breaks.',
    `value_date` DATE COMMENT 'The effective date for interest calculation and availability of funds for the payments being reconciled.',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Operational record of payment reconciliation activities matching internal payment records against external clearing house confirmations, correspondent bank statements, and card network settlement files. Captures reconciliation date, matched/unmatched counts, break items, and resolution status.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`correspondent_currency_service` (
    `correspondent_currency_service_id` BIGINT COMMENT 'Primary key for the correspondent-currency service agreement record',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to the correspondent bank providing the service',
    `currency_id` BIGINT COMMENT 'Foreign key linking to the currency being serviced',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure limit approved for transactions in this currency with this correspondent',
    `cutoff_time_utc` STRING COMMENT 'Daily cutoff time in UTC (HH:MM format) for submitting payment instructions in this currency to meet same-day settlement',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount permitted per business day for this currency through this correspondent',
    `fee_structure_code` STRING COMMENT 'Code identifying the fee structure and pricing schedule applicable to transactions in this currency with this correspondent',
    `nostro_account_iban` STRING COMMENT 'International Bank Account Number (IBAN) of the nostro account for this currency at this correspondent',
    `nostro_account_number` STRING COMMENT 'Account number of our institutions nostro account held at the correspondent bank for this specific currency',
    `relationship_end_date` DATE COMMENT 'Date when currency service through this correspondent was terminated or is scheduled to end',
    `relationship_start_date` DATE COMMENT 'Date when currency service through this correspondent became effective and operational',
    `service_status` STRING COMMENT 'Current operational status of currency service through this correspondent',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle for transactions in this currency: T0 (same day), T1 (trade date plus one day), etc.',
    `vostro_account_number` STRING COMMENT 'Account number of the correspondent banks vostro account held at our institution for this specific currency',
    CONSTRAINT pk_correspondent_currency_service PRIMARY KEY(`correspondent_currency_service_id`)
) COMMENT 'This association product represents the operational service agreement between a correspondent bank and a specific currency. It captures the account details, credit limits, settlement parameters, and operational cutoff times that exist only in the context of servicing a specific currency through a specific correspondent. Each record links one correspondent bank to one currency with attributes that define how that currency is processed through that correspondent relationship.. Existence Justification: In correspondent banking operations, banks maintain multiple correspondent relationships across different currencies for redundancy, cost optimization, and geographic coverage. Each correspondent-currency combination requires distinct operational parameters: separate nostro/vostro account numbers, currency-specific credit limits, settlement cycles that vary by clearing system (CHIPS for USD, TARGET2 for EUR), and cutoff times aligned to different time zones. Payment operations teams actively manage these service agreements, querying which correspondents service EUR? and what are the cutoff times for USD through JPMorgan? This is an operational M:N relationship with substantial relationship-specific data.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`card` (
    `card_id` BIGINT COMMENT 'Primary key for card',
    `deposit_account_id` BIGINT COMMENT 'Reference to the underlying account to which this card is linked for settlement and billing.',
    `party_id` BIGINT COMMENT 'Reference to the customer who owns or is the primary holder of this card.',
    `previous_card_id` BIGINT COMMENT 'Reference to the card that this card replaced, establishing card lineage and history.',
    `replacement_card_id` BIGINT COMMENT 'Reference to the card that replaced this card, if applicable (e.g., due to expiry, loss, or damage).',
    `parent_card_id` BIGINT COMMENT 'Self-referencing FK on card (parent_card_id)',
    `activation_date` DATE COMMENT 'The date when the card was activated by the cardholder and became available for use.',
    `atm_withdrawal_enabled_flag` BOOLEAN COMMENT 'Indicates whether the card is enabled for cash withdrawals at ATMs.',
    `bin_number` STRING COMMENT 'The first six digits of the card number identifying the issuing institution and card type. Also known as Issuer Identification Number (IIN).',
    `cancellation_date` DATE COMMENT 'The date when the card was cancelled or terminated, either by the cardholder or the issuer.',
    `card_brand` STRING COMMENT 'The payment network brand associated with the card, determining routing and acceptance.',
    `card_delivery_address` STRING COMMENT 'The address to which the physical card was delivered or is registered for delivery.',
    `card_delivery_method` STRING COMMENT 'The method by which the physical or digital card was delivered to the cardholder.',
    `card_design_code` STRING COMMENT 'Code identifying the visual design or theme applied to the physical card (e.g., standard, premium, custom image).',
    `card_number` STRING COMMENT 'The 16-digit primary account number (PAN) embossed on the card. Uniquely identifies the card for payment processing.',
    `card_product_code` STRING COMMENT 'Internal product code identifying the specific card program or product offering (e.g., platinum rewards, student card).',
    `card_status` STRING COMMENT 'Current lifecycle status of the card indicating its operational state and usability for transactions.',
    `card_type` STRING COMMENT 'Classification of the card based on its payment mechanism and usage model.',
    `cardholder_name` STRING COMMENT 'The name of the individual or entity to whom the card is issued, as embossed on the card.',
    `chip_enabled_flag` BOOLEAN COMMENT 'Indicates whether the card is equipped with an EMV chip for secure chip-and-PIN or chip-and-signature transactions.',
    `contactless_enabled_flag` BOOLEAN COMMENT 'Indicates whether the card supports contactless (NFC) payment transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this card record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the primary currency in which the card operates.',
    `cvv_hash` STRING COMMENT 'Hashed representation of the card verification value used for card-not-present transactions. Actual CVV is never stored per PCI DSS.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total transaction amount allowed per day for this card.',
    `daily_withdrawal_limit` DECIMAL(18,2) COMMENT 'Maximum cash withdrawal amount allowed per day from ATMs for this card.',
    `embossing_name` STRING COMMENT 'The name physically embossed or printed on the card, which may differ slightly from the legal cardholder name for display purposes.',
    `expiry_date` DATE COMMENT 'The date when the card expires and can no longer be used for transactions.',
    `fraud_alert_flag` BOOLEAN COMMENT 'Indicates whether the card has been flagged for potential fraudulent activity and is under enhanced monitoring.',
    `international_usage_enabled_flag` BOOLEAN COMMENT 'Indicates whether the card is enabled for international transactions outside the issuing country.',
    `issue_date` DATE COMMENT 'The date when the card was issued to the cardholder.',
    `issuing_branch_code` STRING COMMENT 'Code identifying the branch or business unit that issued the card.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent transaction processed using this card.',
    `online_transaction_enabled_flag` BOOLEAN COMMENT 'Indicates whether the card is enabled for online and e-commerce transactions.',
    `pin_set_flag` BOOLEAN COMMENT 'Indicates whether a PIN has been set for this card, enabling ATM and point-of-sale transactions requiring PIN authentication.',
    `pos_transaction_enabled_flag` BOOLEAN COMMENT 'Indicates whether the card is enabled for point-of-sale merchant transactions.',
    `reissue_reason_code` STRING COMMENT 'Code indicating the reason why the card was reissued or replaced.',
    `token_provisioned_flag` BOOLEAN COMMENT 'Indicates whether a payment token has been provisioned for this card for use in digital wallets or tokenized payment systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this card record was last modified in the system.',
    CONSTRAINT pk_card PRIMARY KEY(`card_id`)
) COMMENT 'Master reference table for card. Referenced by card_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`merchant` (
    `merchant_id` BIGINT COMMENT 'Primary key for merchant',
    `correspondent_bank_id` BIGINT COMMENT 'Identifier of the acquiring bank or payment service provider sponsoring this merchant.',
    `merchant_agreement_id` BIGINT COMMENT 'Identifier of the master merchant services agreement governing the relationship.',
    `activation_date` DATE COMMENT 'Date when the merchant account was activated and began processing live transactions.',
    `aml_screening_date` DATE COMMENT 'Date when the merchants AML screening was last performed.',
    `aml_screening_status` STRING COMMENT 'Status of the merchants AML screening against sanctions lists and watchlists.',
    `annual_transaction_volume` DECIMAL(18,2) COMMENT 'Estimated or actual annual transaction volume processed by the merchant in settlement currency.',
    `average_transaction_amount` DECIMAL(18,2) COMMENT 'Average value of individual transactions processed by the merchant in settlement currency.',
    `business_address_line1` STRING COMMENT 'First line of the merchants registered business address.',
    `business_address_line2` STRING COMMENT 'Second line of the merchants registered business address (suite, floor, building).',
    `business_city` STRING COMMENT 'City or municipality of the merchants registered business address.',
    `business_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the merchants registered business address.',
    `business_postal_code` STRING COMMENT 'Postal or ZIP code of the merchants registered business address.',
    `business_state_province` STRING COMMENT 'State, province, or region of the merchants registered business address.',
    `chargeback_threshold_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable chargeback ratio (as percentage of total transactions) before merchant is flagged for review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant record was first created in the system.',
    `doing_business_as_name` STRING COMMENT 'The trade name or DBA name under which the merchant operates, if different from legal name.',
    `is_high_risk` BOOLEAN COMMENT 'Boolean flag indicating whether the merchant is classified as high-risk based on industry, geography, or transaction patterns.',
    `kyc_verification_date` DATE COMMENT 'Date when the merchants KYC verification was last completed or updated.',
    `kyc_verification_status` STRING COMMENT 'Status of the merchants KYC and due diligence verification process.',
    `merchant_category_code` STRING COMMENT 'Four-digit ISO 18245 code classifying the merchants type of business or trade.',
    `merchant_name` STRING COMMENT 'The full legal name of the merchant as registered with regulatory authorities.',
    `merchant_type` STRING COMMENT 'Classification of the merchant based on transaction channel and business model.',
    `onboarding_date` DATE COMMENT 'Date when the merchant was successfully onboarded and approved for payment processing.',
    `pci_attestation_date` DATE COMMENT 'Date of the merchants most recent PCI DSS compliance attestation or validation.',
    `pci_compliance_level` STRING COMMENT 'PCI DSS compliance level assigned to the merchant based on annual transaction volume.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for operational and settlement communications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person for the merchant account.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact for urgent communications and support.',
    `registration_number` STRING COMMENT 'Official business registration or incorporation number issued by the jurisdiction of registration.',
    `risk_rating` STRING COMMENT 'Risk classification assigned to the merchant based on fraud history, chargeback ratio, and business profile.',
    `settlement_account_number` STRING COMMENT 'Bank account number where merchant payment settlements are deposited.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for merchant settlement transactions.',
    `settlement_cycle_days` STRING COMMENT 'Number of business days between transaction authorization and funds settlement to merchant account (e.g., T+1, T+2).',
    `merchant_status` STRING COMMENT 'Current lifecycle status of the merchant in the payment processing system.',
    `supports_cross_border_payments` BOOLEAN COMMENT 'Boolean flag indicating whether the merchant is enabled to accept payments from international customers.',
    `supports_recurring_payments` BOOLEAN COMMENT 'Boolean flag indicating whether the merchant is enabled to process recurring or subscription-based payments.',
    `swift_bic_code` STRING COMMENT 'SWIFT BIC code for the merchants primary settlement bank account, used for international payment routing.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identifier for the merchant entity (e.g., EIN, VAT number).',
    `termination_date` DATE COMMENT 'Date when the merchant relationship was terminated or the account was closed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant record was last modified.',
    `website_url` STRING COMMENT 'Primary website URL where the merchant conducts e-commerce or displays business information.',
    CONSTRAINT pk_merchant PRIMARY KEY(`merchant_id`)
) COMMENT 'Master reference table for merchant. Referenced by merchant_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`payment_processor` (
    `payment_processor_id` BIGINT COMMENT 'Primary key for payment_processor',
    `parent_payment_processor_id` BIGINT COMMENT 'Self-referencing FK on payment_processor (parent_payment_processor_id)',
    `api_endpoint_url` STRING COMMENT 'Base URL for the processors API endpoint used for payment instruction submission and status inquiry.',
    `api_version` STRING COMMENT 'Version of the processor API currently integrated with the payment hub.',
    `authentication_method` STRING COMMENT 'Authentication mechanism used to connect to the processors systems.',
    `clearing_system_code` STRING COMMENT 'Code identifying the clearing system or network the processor participates in (e.g., FEDWIRE, CHIPS, TARGET2).',
    `contact_email` STRING COMMENT 'Email address of the primary business contact at the processor organization.',
    `contact_name` STRING COMMENT 'Name of the primary business contact at the processor organization.',
    `contact_phone` STRING COMMENT 'Phone number of the primary business contact at the processor organization.',
    `contract_renewal_date` DATE COMMENT 'Date when the service agreement with the processor is due for renewal.',
    `country_of_domicile` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the processor is legally domiciled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment processor record was first created in the payment hub system.',
    `cutoff_time` STRING COMMENT 'Daily cutoff time (HH:MM format in processor timezone) for same-day processing.',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount that can be processed through this processor in a single business day.',
    `effective_date` DATE COMMENT 'Date when the processor relationship became active and available for payment routing.',
    `last_audit_date` DATE COMMENT 'Date of the most recent operational or compliance audit performed on this processor relationship.',
    `maximum_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount that can be processed through this processor per single transaction.',
    `message_format` STRING COMMENT 'Standard message format used for communication with this processor.',
    `minimum_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount that can be processed through this processor.',
    `processing_fee_structure` STRING COMMENT 'Type of fee structure applied by this processor for payment processing services.',
    `processor_code` STRING COMMENT 'Unique business identifier code for the payment processor used in payment routing and reconciliation.',
    `processor_name` STRING COMMENT 'Full legal name of the payment processor organization.',
    `processor_type` STRING COMMENT 'Classification of the payment processor by the type of payment processing capability it provides.',
    `reconciliation_frequency` STRING COMMENT 'Frequency at which nostro/vostro account reconciliation is performed with this processor.',
    `regulatory_authority` STRING COMMENT 'Name of the financial regulatory authority that oversees this processor (e.g., Federal Reserve, ECB, FCA).',
    `regulatory_license_number` STRING COMMENT 'License or registration number issued by the relevant financial regulatory authority for this processor.',
    `risk_rating` STRING COMMENT 'Internal risk assessment rating assigned to this processor based on operational, credit, and compliance risk factors.',
    `routing_number` STRING COMMENT 'ABA routing transit number for ACH and domestic wire processing in the United States.',
    `settlement_account_number` STRING COMMENT 'Nostro or vostro account number used for settlement with this processor.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle for payments processed through this processor (T+0, T+1, T+2, real-time, or intraday).',
    `sla_processing_time_minutes` STRING COMMENT 'Target processing time in minutes as defined in the service level agreement with the processor.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed uptime percentage as defined in the service level agreement with the processor.',
    `payment_processor_status` STRING COMMENT 'Current operational status of the payment processor in the payment hub.',
    `supported_currencies` STRING COMMENT 'Comma-separated list of ISO 4217 currency codes that this processor can handle.',
    `supported_payment_methods` STRING COMMENT 'Comma-separated list of payment methods supported by this processor (e.g., CREDIT_TRANSFER, DEBIT_TRANSFER, CARD_PAYMENT).',
    `supports_cross_border` BOOLEAN COMMENT 'Indicates whether this processor supports cross-border international payment processing.',
    `supports_fx_conversion` BOOLEAN COMMENT 'Indicates whether this processor provides foreign exchange conversion services.',
    `swift_bic` STRING COMMENT 'SWIFT BIC code for the processor if applicable for international wire and SWIFT message processing.',
    `termination_date` DATE COMMENT 'Date when the processor relationship was terminated or is scheduled to be terminated. Null for active relationships.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the processors operational timezone (e.g., America/New_York, Europe/London).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment processor record was last modified in the payment hub system.',
    CONSTRAINT pk_payment_processor PRIMARY KEY(`payment_processor_id`)
) COMMENT 'Master reference table for payment_processor. Referenced by processor_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`payment`.`merchant_agreement` (
    `merchant_agreement_id` BIGINT COMMENT 'Primary key for merchant_agreement',
    `previous_merchant_agreement_id` BIGINT COMMENT 'Self-referencing FK on merchant_agreement (previous_merchant_agreement_id)',
    `acquiring_bank_id` BIGINT COMMENT 'Reference to the acquiring bank or financial institution party to this agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the merchant agreement, used in communications and documentation.',
    `agreement_type` STRING COMMENT 'Classification of the merchant agreement based on the payment services provided.',
    `aml_screening_status` STRING COMMENT 'Status of the merchants screening against AML watchlists and sanctions lists.',
    `approval_date` DATE COMMENT 'Date when the merchant agreement was approved by the bank.',
    `approved_by_id` BIGINT COMMENT 'Reference to the bank employee who approved the merchant agreement.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiration.',
    `chargeback_fee` DECIMAL(18,2) COMMENT 'Fee charged to the merchant for each chargeback or dispute processed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant agreement record was first created in the system.',
    `cross_border_enabled` BOOLEAN COMMENT 'Indicates whether the merchant is authorized to accept cross-border international payments.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage fee charged to the merchant per transaction, expressed as a decimal (e.g., 0.02500 for 2.5%).',
    `effective_date` DATE COMMENT 'Date when the merchant agreement becomes legally binding and services commence.',
    `expiration_date` DATE COMMENT 'Date when the merchant agreement terminates. Nullable for open-ended agreements.',
    `fx_conversion_enabled` BOOLEAN COMMENT 'Indicates whether dynamic currency conversion or multi-currency settlement is enabled.',
    `kyc_verification_date` DATE COMMENT 'Date when the merchants KYC verification was last completed successfully.',
    `kyc_verification_status` STRING COMMENT 'Status of the merchants KYC verification process as required by anti-money laundering regulations.',
    `merchant_category_code` STRING COMMENT 'Four-digit ISO 18245 code classifying the merchants type of business for payment processing and interchange determination.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant party who is the counterparty to this agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant agreement record was last modified.',
    `monthly_service_fee` DECIMAL(18,2) COMMENT 'Recurring monthly fee for maintaining the merchant agreement and providing payment services.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to the merchant agreement.',
    `payment_gateway_provider` STRING COMMENT 'Name of the third-party payment gateway or processor used for transaction routing (e.g., ACI Worldwide, Volante).',
    `payment_methods_accepted` STRING COMMENT 'Comma-separated list of payment methods enabled under this agreement (e.g., Visa, Mastercard, ACH, Wire). [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|ach|wire|sepa|swift|rtgs|faster_payments — promote to reference product]',
    `pci_attestation_date` DATE COMMENT 'Date of the most recent PCI DSS compliance attestation or audit.',
    `pci_compliance_level` STRING COMMENT 'PCI DSS compliance level assigned based on annual transaction volume and security assessment.',
    `relationship_manager_id` BIGINT COMMENT 'Reference to the bank employee responsible for managing the merchant relationship.',
    `reserve_hold_period_days` STRING COMMENT 'Number of days that reserve funds are held before release to the merchant.',
    `reserve_requirement_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction volume held in reserve to cover chargebacks and disputes.',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the merchant based on business type, transaction patterns, and compliance history.',
    `settlement_account_id` BIGINT COMMENT 'Reference to the nostro or internal account used for settling funds to the merchant.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which merchant settlements are denominated.',
    `settlement_cycle_days` STRING COMMENT 'Number of business days between transaction capture and settlement (e.g., T+1, T+2).',
    `settlement_frequency` STRING COMMENT 'Frequency at which payment settlements are processed and transferred to the merchant.',
    `signed_date` DATE COMMENT 'Date when the merchant agreement was executed and signed by all parties.',
    `merchant_agreement_status` STRING COMMENT 'Current lifecycle status of the merchant agreement.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for either party to terminate the agreement.',
    `transaction_fee_fixed` DECIMAL(18,2) COMMENT 'Fixed fee amount charged per transaction in the settlement currency, independent of transaction value.',
    `transaction_limit_daily` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction value allowed per day under this agreement.',
    `transaction_limit_monthly` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction value allowed per month under this agreement.',
    `transaction_limit_single` DECIMAL(18,2) COMMENT 'Maximum value allowed for a single transaction under this agreement.',
    CONSTRAINT pk_merchant_agreement PRIMARY KEY(`merchant_agreement_id`)
) COMMENT 'Master reference table for merchant_agreement. Referenced by merchant_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_payment_channel_id` FOREIGN KEY (`payment_channel_id`) REFERENCES `banking_ecm`.`payment`.`payment_channel`(`payment_channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_payment_mandate_id` FOREIGN KEY (`payment_mandate_id`) REFERENCES `banking_ecm`.`payment`.`payment_mandate`(`payment_mandate_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_swift_message_id` FOREIGN KEY (`swift_message_id`) REFERENCES `banking_ecm`.`payment`.`swift_message`(`swift_message_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_return_correspondent_bank_id` FOREIGN KEY (`return_correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_payment_channel_id` FOREIGN KEY (`payment_channel_id`) REFERENCES `banking_ecm`.`payment`.`payment_channel`(`payment_channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_fallback_routing_rule_routing_id` FOREIGN KEY (`fallback_routing_rule_routing_id`) REFERENCES `banking_ecm`.`payment`.`routing`(`routing_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_payment_channel_id` FOREIGN KEY (`payment_channel_id`) REFERENCES `banking_ecm`.`payment`.`payment_channel`(`payment_channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `banking_ecm`.`payment`.`merchant`(`merchant_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_reversal_fx_transaction_id` FOREIGN KEY (`reversal_fx_transaction_id`) REFERENCES `banking_ecm`.`payment`.`fx_transaction`(`fx_transaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_parent_payment_exception_id` FOREIGN KEY (`parent_payment_exception_id`) REFERENCES `banking_ecm`.`payment`.`exception`(`exception_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_previous_payment_fee_id` FOREIGN KEY (`previous_payment_fee_id`) REFERENCES `banking_ecm`.`payment`.`payment_fee`(`payment_fee_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_parent_correspondent_bank_id` FOREIGN KEY (`parent_correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_parent_payment_channel_id` FOREIGN KEY (`parent_payment_channel_id`) REFERENCES `banking_ecm`.`payment`.`payment_channel`(`payment_channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_previous_reconciliation_id` FOREIGN KEY (`previous_reconciliation_id`) REFERENCES `banking_ecm`.`payment`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ADD CONSTRAINT `fk_payment_correspondent_currency_service_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_previous_card_id` FOREIGN KEY (`previous_card_id`) REFERENCES `banking_ecm`.`payment`.`card`(`card_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_replacement_card_id` FOREIGN KEY (`replacement_card_id`) REFERENCES `banking_ecm`.`payment`.`card`(`card_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_parent_card_id` FOREIGN KEY (`parent_card_id`) REFERENCES `banking_ecm`.`payment`.`card`(`card_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_merchant_agreement_id` FOREIGN KEY (`merchant_agreement_id`) REFERENCES `banking_ecm`.`payment`.`merchant_agreement`(`merchant_agreement_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ADD CONSTRAINT `fk_payment_payment_processor_parent_payment_processor_id` FOREIGN KEY (`parent_payment_processor_id`) REFERENCES `banking_ecm`.`payment`.`payment_processor`(`payment_processor_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ADD CONSTRAINT `fk_payment_merchant_agreement_previous_merchant_agreement_id` FOREIGN KEY (`previous_merchant_agreement_id`) REFERENCES `banking_ecm`.`payment`.`merchant_agreement`(`merchant_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`payment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`payment` SET TAGS ('dbx_domain' = 'payment');
ALTER TABLE `banking_ecm`.`payment`.`instruction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`instruction` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction ID');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `beneficiary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account ID');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `ctr_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ctr Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Account ID');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `instruction_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `instruction_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `instruction_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Correspondent Bank Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `investment_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Banking Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `payment_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `payment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `underwriting_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Commitment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `vostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'PENDING|CLEARED|FLAGGED|BLOCKED');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_business_glossary_term' = 'Charge Bearer');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_value_regex' = 'OUR|BEN|SHA');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `clearing_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearing System Reference');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Instruction Status');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `instruction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instruction Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'NORMAL|HIGH|URGENT');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `payment_rail_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Type');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Instruction Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `remittance_information` SET TAGS ('dbx_business_glossary_term' = 'Remittance Information');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `routing_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Code');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'PENDING|CLEARED|FLAGGED|BLOCKED');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'RTGS|DNS|BATCH');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Unique End-to-End Transaction Reference (UETR)');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`instruction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction ID');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `investment_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Debit Account ID');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Customer ID');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `vostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `aml_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'Passed|Failed|Review|Pending');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `clearing_house_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Reference');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `net_settlement_position` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Position');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'Credit|Debit|Return|Reversal|Adjustment');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `remittance_information` SET TAGS ('dbx_business_glossary_term' = 'Remittance Information');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `routing_priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `routing_priority` SET TAGS ('dbx_value_regex' = 'High|Normal|Low');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'Passed|Failed|Review|Pending');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'T0|T1|T2|T3');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'Unsettled|Settled|PartiallySettled|SettlementFailed');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_value_regex' = '^MT[0-9]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Unique End-to-End Transaction Reference (UETR)');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'Pending|Cleared|Settled|Failed|Rejected|Cancelled');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message ID');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Banking Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'ack|nack|pending|not_required');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'passed|flagged|pending|not_screened');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_account` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank BIC');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `charges_code` SET TAGS ('dbx_business_glossary_term' = 'Charges Code');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `charges_code` SET TAGS ('dbx_value_regex' = 'OUR|BEN|SHA');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `credit_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Confirmation Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `gpi_status_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Global Payments Innovation (GPI) Status Code');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `gpi_status_code` SET TAGS ('dbx_value_regex' = '^g[0-9]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `gpi_tracker_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SWIFT GPI Tracker Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank BIC');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_body` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Body');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_body` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_direction` SET TAGS ('dbx_business_glossary_term' = 'Message Direction');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Processed Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Received Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_reference` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Sent Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_status` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Status');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|delivered|failed|rejected|cancelled');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Type');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `message_type` SET TAGS ('dbx_value_regex' = '^(MT|MX)[0-9]{3}$|^[a-z]{4}.[0-9]{3}.[0-9]{3}.[0-9]{2}$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `ordering_customer_account` SET TAGS ('dbx_business_glossary_term' = 'Ordering Customer Account Number');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `ordering_customer_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `ordering_customer_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `ordering_customer_name` SET TAGS ('dbx_business_glossary_term' = 'Ordering Customer Name');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `ordering_customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `ordering_customer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Message Priority Code');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'NORM|URGP|HIGH');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `receiver_bic` SET TAGS ('dbx_business_glossary_term' = 'Receiver Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `receiver_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `related_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `remittance_information` SET TAGS ('dbx_business_glossary_term' = 'Remittance Information');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|hit|pending|not_screened');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sender_bic` SET TAGS ('dbx_business_glossary_term' = 'Sender Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sender_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sender_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Sender Charges Amount');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sender_charges_currency` SET TAGS ('dbx_business_glossary_term' = 'Sender Charges Currency Code');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `sender_charges_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `uetr` SET TAGS ('dbx_business_glossary_term' = 'Unique End-to-End Transaction Reference (UETR)');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `uetr` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`payment`.`status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`status_event` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Status Event ID');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Banking Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_business_glossary_term' = 'Message ID');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `assigned_queue` SET TAGS ('dbx_business_glossary_term' = 'Assigned Queue');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `event_source_module` SET TAGS ('dbx_business_glossary_term' = 'Event Source Module');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'STATUS_CHANGE|EXCEPTION|STP_FAILURE|MANUAL_INTERVENTION|RETRY|RESOLUTION');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'FORMAT_ERROR|SANCTIONS_HIT|DUPLICATE_DETECTION|ROUTING_FAILURE|INSUFFICIENT_FUNDS|BENEFICIARY_VALIDATION_FAILURE');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `max_retry_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Limit');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `new_status_code` SET TAGS ('dbx_business_glossary_term' = 'New Status Code');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `originating_system` SET TAGS ('dbx_business_glossary_term' = 'Originating System');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Payment Direction');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'OUTBOUND|INBOUND');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `prior_status_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'APPROVED|REJECTED|CORRECTED|ESCALATED|CANCELLED|RESUBMITTED');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_value_regex' = 'CLEAR|HIT|PENDING_REVIEW');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Minutes');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `banking_ecm`.`payment`.`status_event` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `banking_ecm`.`payment`.`return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`return` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Return Identifier');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Return Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User Identifier');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Identifier');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Identifier');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Bank Identifier');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Bank Identifier');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `addenda_information` SET TAGS ('dbx_business_glossary_term' = 'Addenda Information');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Return Amount');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `clearing_house_name` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Name');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `clearing_house_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Reference');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `contested_return_flag` SET TAGS ('dbx_business_glossary_term' = 'Contested Return Flag');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `dishonored_return_flag` SET TAGS ('dbx_business_glossary_term' = 'Dishonored Return Flag');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Fee Amount');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Return Fee Currency Code');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `fraud_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Flag');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Return Notification Date');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Notification Sent Flag');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `original_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Date');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `original_payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Reference');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `originator_account_number` SET TAGS ('dbx_business_glossary_term' = 'Originator Account Number');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `originator_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `originator_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|pending_review');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Return Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `resubmission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Eligible Flag');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_status` SET TAGS ('dbx_value_regex' = 'initiated|pending|completed|failed|cancelled|disputed');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'ach_return|swift_return|rtgs_reversal|wire_return|card_chargeback|internal_reversal');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Type');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`return` ALTER COLUMN `window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `banking_ecm`.`payment`.`batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`batch` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Institution Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,11}$');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `payment_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `receiving_institution_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Institution Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `receiving_institution_legal_entity_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,11}$');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `vostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'NOT_SCREENED|CLEARED|FLAGGED|UNDER_REVIEW');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `batch_description` SET TAGS ('dbx_business_glossary_term' = 'Batch Description');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'CREDIT|DEBIT|MIXED');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `clearing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `clearing_window` SET TAGS ('dbx_business_glossary_term' = 'Clearing Window');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `clearing_window` SET TAGS ('dbx_value_regex' = 'MORNING|AFTERNOON|EVENING|OVERNIGHT|REALTIME');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `company_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Company Entry Description');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `discretionary_data` SET TAGS ('dbx_business_glossary_term' = 'Discretionary Data');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `is_test_batch` SET TAGS ('dbx_business_glossary_term' = 'Is Test Batch Flag');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `originator_account_number` SET TAGS ('dbx_business_glossary_term' = 'Originator Account Number');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `originator_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,34}$');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `originator_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `originator_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `originator_name` SET TAGS ('dbx_business_glossary_term' = 'Originator Name');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `payment_rail` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `payment_rail` SET TAGS ('dbx_value_regex' = 'ACH|WIRE|RTGS|SWIFT|SEPA|FEDWIRE');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Batch Priority');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'URGENT|HIGH|NORMAL|LOW');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Batch Purpose Code');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'NOT_SCREENED|CLEARED|HIT|UNDER_REVIEW');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_value_regex' = 'MT101|MT102|MT103|MT202|MT940|MT950');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `validation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Code');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `validation_error_message` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Message');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'PENDING|PASSED|FAILED|WARNING');
ALTER TABLE `banking_ecm`.`payment`.`batch` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Record Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|escalated');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Confirmation Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_cycle_identifier` SET TAGS ('dbx_business_glossary_term' = 'Clearing Cycle Identifier');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Clearing Fee Amount');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_house_identifier` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_message_type` SET TAGS ('dbx_business_glossary_term' = 'Clearing Message Type');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_participant_identifier` SET TAGS ('dbx_business_glossary_term' = 'Clearing Participant Identifier');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|pending|settled|failed');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `clearing_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Submission Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `collateral_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Requirement Amount');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `counterparty_participant_identifier` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Participant Identifier');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `cross_border_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Indicator');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `foreign_exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `funding_account_number` SET TAGS ('dbx_business_glossary_term' = 'Funding Account Number');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `funding_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `gross_clearing_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Clearing Amount');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `liquidity_reserve_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Reserve Requirement Amount');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `multilateral_netting_position` SET TAGS ('dbx_business_glossary_term' = 'Multilateral Netting Position');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `multilateral_netting_position` SET TAGS ('dbx_value_regex' = 'net_payer|net_receiver|neutral');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `net_settlement_obligation_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Obligation Amount');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `netting_group_identifier` SET TAGS ('dbx_business_glossary_term' = 'Netting Group Identifier');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `nostro_vostro_indicator` SET TAGS ('dbx_business_glossary_term' = 'Nostro/Vostro Indicator');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `nostro_vostro_indicator` SET TAGS ('dbx_value_regex' = 'nostro|vostro|internal');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `payment_instruction_count` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Count');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_business_glossary_term' = 'Priority Indicator');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_value_regex' = 'high|normal|low');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|hit|pending|override');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Reference');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'RTGS|DNS|hybrid');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_risk_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Risk Exposure Amount');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reversed|suspended');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `settlement_window_identifier` SET TAGS ('dbx_business_glossary_term' = 'Settlement Window Identifier');
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`payment`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`routing` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Routing Rule Identifier');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `fallback_routing_rule_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Routing Rule Identifier');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `payment_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `routing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `routing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `routing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `aml_monitoring_level` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Monitoring Level');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `aml_monitoring_level` SET TAGS ('dbx_value_regex' = 'STANDARD|ENHANCED|HIGH_RISK');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `cost_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Routing Cost (Basis Points - BPS)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `cost_basis_points` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_business_glossary_term' = 'Cut-Off Time (Local Time Zone)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):([0-5]d):([0-5]d)$');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `cutoff_timezone` SET TAGS ('dbx_business_glossary_term' = 'Cut-Off Time Zone');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `cutoff_timezone` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `daily_aggregate_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Aggregate Limit Amount');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `engine_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Engine Version');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `intermediary_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Name');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `liquidity_reserve_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Reserve Requirement Flag');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Number');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Notes');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `payment_rail_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Code');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority Rank');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `rail_settlement_model` SET TAGS ('dbx_business_glossary_term' = 'Rail Settlement Model');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `rail_settlement_model` SET TAGS ('dbx_value_regex' = 'GROSS|NET|HYBRID');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Code');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Name');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Status');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|SUSPENDED|PENDING_APPROVAL|DEPRECATED');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `sanctions_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `settlement_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Code (T+N)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `settlement_cycle_code` SET TAGS ('dbx_value_regex' = 'T0|T1|T2|INTRADAY|REAL_TIME');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `single_transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Single Transaction Limit Amount');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `sla_target_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion (Minutes)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `speed_minutes` SET TAGS ('dbx_business_glossary_term' = 'Routing Speed (Minutes)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Type');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `velocity_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Velocity Limit Count');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `velocity_window_minutes` SET TAGS ('dbx_business_glossary_term' = 'Velocity Window (Minutes)');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `vostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account Number');
ALTER TABLE `banking_ecm`.`payment`.`routing` ALTER COLUMN `vostro_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` SET TAGS ('dbx_subdomain' = 'partner_services');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `deal_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Registered Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 1');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 2');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 1');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 2');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Name');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Postal Code');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_business_glossary_term' = 'Bank State or Province');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `beneficiary_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Status');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `beneficiary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blocked|pending_approval');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|financial_institution|government|non_profit|trust');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC) / Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary City');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Country Code');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Email Address');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank BIC (Bank Identifier Code)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `intermediary_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `intermediary_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Name');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `intermediary_bank_required` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Legal Name');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `pep_status` SET TAGS ('dbx_value_regex' = 'pep|non_pep|rca|pending|unknown');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Phone Number');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Postal Code');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `routing_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Code');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `routing_code_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Code Type');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|potential_match|pending|error');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary State or Province');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_verified|expired');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `payment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Mandate Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `creditor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Creditor Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Creditor Beneficiary Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Debtor Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Debtor Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'PASSED|FAILED|PENDING|REVIEW|EXEMPT');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `authorization_method` SET TAGS ('dbx_business_glossary_term' = 'Authorization Method');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `authorization_method` SET TAGS ('dbx_value_regex' = 'PAPER|ELECTRONIC|TELEPHONE|ONLINE|MOBILE|BRANCH');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Collection Frequency');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `creditor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Creditor Identifier');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate End Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `last_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_business_glossary_term' = 'Mandate Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|SUSPENDED|CANCELLED|EXPIRED|PENDING|REVOKED');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_business_glossary_term' = 'Mandate Type');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `maximum_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `next_scheduled_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Collection Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Mandate Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'CLEARED|HIT|PENDING|REVIEW|EXEMPT');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `sequence_type` SET TAGS ('dbx_business_glossary_term' = 'Sequence Type');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `sequence_type` SET TAGS ('dbx_value_regex' = 'FIRST|RECURRING|FINAL|ONEOFF|REPRESENTMENT');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Start Date');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `card_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Card Transaction ID');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Atm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Card Network Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `ctr_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ctr Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Card Account ID');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `acquirer_bic` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `acquirer_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Result Code');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `card_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Present Flag');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `card_token` SET TAGS ('dbx_business_glossary_term' = 'Card Token');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `card_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `card_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'DEBIT|CREDIT|PREPAID|CHARGE');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `cardholder_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Present Flag');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'POS|ATM|ECOMMERCE|MOBILE_APP|PHONE|MAIL_ORDER');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Result Code');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_value_regex' = 'M|N|P|S|U');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `interchange_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Amount');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `issuer_bic` SET TAGS ('dbx_business_glossary_term' = 'Issuer Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `issuer_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `masked_pan` SET TAGS ('dbx_business_glossary_term' = 'Masked Primary Account Number (PAN)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `masked_pan` SET TAGS ('dbx_value_regex' = '^[0-9]{6}[*]{6}[0-9]{4}$');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `masked_pan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `masked_pan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `merchant_city` SET TAGS ('dbx_business_glossary_term' = 'Merchant City');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `network_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Network Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `pos_entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Entry Mode');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `pos_entry_mode` SET TAGS ('dbx_value_regex' = 'CHIP|SWIPE|CONTACTLESS|MANUAL|ECOMMERCE|MOBILE_WALLET');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `retrieval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Reference Number (RRN)');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `three_d_secure_flag` SET TAGS ('dbx_business_glossary_term' = '3D Secure (3DS) Flag');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'AUTHORIZED|DECLINED|PENDING|SETTLED|REVERSED|DISPUTED');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'PURCHASE|REFUND|CHARGEBACK|REVERSAL|CASH_ADVANCE|BALANCE_INQUIRY');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `sanction_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Sanction Screening ID');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst User ID');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction ID');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Entity ID');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `analyst_decision` SET TAGS ('dbx_business_glossary_term' = 'Analyst Decision');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `analyst_decision` SET TAGS ('dbx_value_regex' = 'APPROVE|REJECT|FALSE_POSITIVE|ESCALATE_TO_MLRO');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `analyst_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Review Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `analyst_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analyst Review Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `auto_decision_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Decision Flag');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `false_positive_reason` SET TAGS ('dbx_business_glossary_term' = 'False Positive Reason');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `false_positive_reason` SET TAGS ('dbx_value_regex' = 'COMMON_NAME|DIFFERENT_JURISDICTION|DIFFERENT_DOB|DIFFERENT_ADDRESS|WHITELIST_MATCH|OTHER');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'NO_MATCH|POTENTIAL_MATCH|CONFIRMED_MATCH|FALSE_POSITIVE');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'EXACT|FUZZY|PARTIAL|PHONETIC|ALIAS');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `matched_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Entity Name');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `matched_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `matched_field` SET TAGS ('dbx_business_glossary_term' = 'Matched Field');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `matched_field` SET TAGS ('dbx_value_regex' = 'NAME|ADDRESS|IDENTIFIER|ACCOUNT|BIC|IBAN');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `matched_party_role` SET TAGS ('dbx_business_glossary_term' = 'Matched Party Role');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `matched_party_role` SET TAGS ('dbx_value_regex' = 'ORIGINATOR|BENEFICIARY|INTERMEDIARY_BANK|CORRESPONDENT_BANK');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `ofac_blocking_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Blocking Report Reference');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `ofac_blocking_report_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `ofac_blocking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Blocking Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `sar_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Reference');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `sar_filing_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_decision` SET TAGS ('dbx_business_glossary_term' = 'Screening Decision');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_decision` SET TAGS ('dbx_value_regex' = 'PASS|HOLD|BLOCK|ESCALATE');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Screening Duration Milliseconds');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_error_code` SET TAGS ('dbx_business_glossary_term' = 'Screening Error Code');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_error_message` SET TAGS ('dbx_business_glossary_term' = 'Screening Error Message');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_system_name` SET TAGS ('dbx_business_glossary_term' = 'Screening System Name');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `watchlist_type` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Type');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `watchlist_type` SET TAGS ('dbx_value_regex' = 'OFAC_SDN|EU_CONSOLIDATED|UN_SANCTIONS|PEP|HMT_UK|DFAT_AUSTRALIA');
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ALTER COLUMN `watchlist_version` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Version');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `fx_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Transaction ID');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader ID');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedged Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction ID');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `vostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `reversal_fx_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|blocked');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `base_currency_settlement_account` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Settlement Account');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `base_currency_settlement_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `booking_entity` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `buy_sell_indicator` SET TAGS ('dbx_business_glossary_term' = 'Buy Sell Indicator');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `buy_sell_indicator` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `counterparty_bic` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `counterparty_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `currency_pair` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `currency_pair` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}/[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `deal_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Deal Rate');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `deal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Deal Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `deal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Deal Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `fixing_date` SET TAGS ('dbx_business_glossary_term' = 'Fixing Date');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `fixing_rate` SET TAGS ('dbx_business_glossary_term' = 'Fixing Rate');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `forward_points` SET TAGS ('dbx_business_glossary_term' = 'Forward Points');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Purpose Code');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `quote_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Currency Amount');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `quote_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quote Currency Code');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `quote_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `quote_currency_settlement_account` SET TAGS ('dbx_business_glossary_term' = 'Quote Currency Settlement Account');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `quote_currency_settlement_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|blocked');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'gross|net|cls');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `spot_rate_reference` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Reference');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_value_regex' = '^MT[0-9]{3}$|^MX[A-Z]{4}.[0-9]{3}.[0-9]{3}.[0-9]{2}$');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Unique End-to-End Transaction Reference (UETR)');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `swift_uetr` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Trade Date');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `trading_desk` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Transaction Status');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|failed|expired');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Transaction Type');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'spot|forward|swap|ndf');
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Value Date');
ALTER TABLE `banking_ecm`.`payment`.`exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`exception` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `exception_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Exception Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `aml_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Correcting Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `exception_resolved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `exception_resolved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `exception_resolved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Banking Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `parent_payment_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `assigned_queue` SET TAGS ('dbx_business_glossary_term' = 'Assigned Work Queue');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `detection_system` SET TAGS ('dbx_business_glossary_term' = 'Detection System Name');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'System Error Message');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Occurrence Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `max_retry_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Limit');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `originator_name` SET TAGS ('dbx_business_glossary_term' = 'Originator Name');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `payment_rail_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Type');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `resolution_action_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Code');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `resubmission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Eligible Flag');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Attempt Count');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity Level');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Minutes');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`exception` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Type Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `payment_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Fee Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `creditor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Creditor Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Debtor Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `previous_payment_fee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `basis_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis Currency Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `basis_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `billing_entity_bic` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `billing_entity_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Name');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Method');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'FLAT|PERCENTAGE|TIERED|NEGOTIATED');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `charge_bearer_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Bearer Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `charge_bearer_code` SET TAGS ('dbx_value_regex' = 'OUR|BEN|SHA');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `fee_category` SET TAGS ('dbx_value_regex' = 'TRANSACTION|SERVICE|INTERMEDIARY|REGULATORY|PENALTY');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_value_regex' = 'PENDING|ASSESSED|BILLED|WAIVED|REVERSED');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `payment_rail_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Type');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Percentage');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'ERROR|DISPUTE|REFUND|ADJUSTMENT');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `tax_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicable Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Type Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_value_regex' = 'RELATIONSHIP|PROMOTION|ERROR|GOODWILL|REGULATORY');
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ALTER COLUMN `waiver_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` SET TAGS ('dbx_subdomain' = 'partner_services');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `parent_correspondent_bank_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `correspondent_city` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank City');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `correspondent_name` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Legal Name');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Credit Limit Amount');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `cutoff_time_utc` SET TAGS ('dbx_business_glossary_term' = 'Daily Cutoff Time Coordinated Universal Time (UTC)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `cutoff_time_utc` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit Amount');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `fee_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Code');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `fee_structure_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `gpi_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Payments Innovation (gpi) Enabled Flag');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `intermediary_bank_required` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Scheduled Review Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `kyc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Last Review Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Due Diligence Status');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'compliant|pending|expired|non_compliant');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account International Bank Account Number (IBAN)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Number');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `payment_rail_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Rail Types');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `preferred_intermediary_bic` SET TAGS ('dbx_business_glossary_term' = 'Preferred Intermediary Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `preferred_intermediary_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `primary_currency` SET TAGS ('dbx_business_glossary_term' = 'Primary Settlement Currency Code');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `primary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Start Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Relationship Status');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval|under_review|dormant');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Relationship Type');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'nostro|vostro|bilateral|unilateral');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Last Performed Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending_review');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `service_level_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `service_level_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Code');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'T0|T1|T2');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'gross|net|deferred_net');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currency Codes');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `swift_message_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Types');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `swift_message_types` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `swift_message_types` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `vostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account Number');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ALTER COLUMN `vostro_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `payment_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `parent_payment_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `aml_screening_required` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `batch_processing_supported` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Supported Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Name');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Status');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|maintenance');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Type');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'batch|real_time|near_real_time|deferred');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `charge_bearer_default` SET TAGS ('dbx_business_glossary_term' = 'Charge Bearer Default Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `charge_bearer_default` SET TAGS ('dbx_value_regex' = 'OUR|BEN|SHA');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `clearing_house_identifier` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `clearing_house_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,12}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `cross_border_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Payment Enabled Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Payment Cutoff Time');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `fee_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Code');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `fee_structure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `gpi_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Payments Innovation (gpi) Enabled Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `intermediary_bank_allowed` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Allowed Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `maximum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `minimum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `network_operator` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Operator Name');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `nostro_account_required` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `operating_timezone` SET TAGS ('dbx_business_glossary_term' = 'Operating Timezone');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `operating_timezone` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `priority_levels_supported` SET TAGS ('dbx_business_glossary_term' = 'Priority Levels Supported');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Return Window Days');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `sanctions_screening_required` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'T0|T1|T2|same_day|next_day|intraday');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `settlement_model` SET TAGS ('dbx_business_glossary_term' = 'Settlement Model');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `settlement_model` SET TAGS ('dbx_value_regex' = 'gross|net|multilateral_net|bilateral_net');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `sla_target_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Minutes');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `standard_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Fee Amount');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currency Codes');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `swift_message_types` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Types');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `swift_message_types` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `swift_message_types` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ALTER COLUMN `vostro_account_required` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account Required Flag');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Reconciliation ID');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User ID');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_performed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By User ID');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_performed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_performed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `vostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account ID');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `previous_reconciliation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `break_item_count` SET TAGS ('dbx_business_glossary_term' = 'Break Item Count');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `card_network_name` SET TAGS ('dbx_business_glossary_term' = 'Card Network Name');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `card_network_name` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|AMEX|DISCOVER|UNIONPAY|JCB');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `clearing_house_identifier` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `external_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'External Statement Reference');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `matched_amount` SET TAGS ('dbx_business_glossary_term' = 'Matched Amount');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `matched_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Matched Payment Count');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `matching_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Matching Rule Set');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `payment_rail_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Rail Type');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|semi_automated');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|partially_reconciled|exception');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'nostro|vostro|clearing_house|card_network|correspondent_bank|internal');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference Number');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'unresolved|in_progress|resolved|escalated|waived');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `tolerance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Amount');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `total_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Count');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `total_reconciled_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Reconciled Amount');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `unmatched_amount` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Amount');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `unmatched_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Payment Count');
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` SET TAGS ('dbx_subdomain' = 'partner_services');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` SET TAGS ('dbx_association_edges' = 'payment.correspondent_bank,reference.currency');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `correspondent_currency_service_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Currency Service ID');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Currency Service - Correspondent Bank Id');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Currency Service - Currency Id');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `cutoff_time_utc` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Time UTC');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `fee_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Code');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account IBAN');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Number');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `nostro_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `vostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vostro Account Number');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `vostro_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ALTER COLUMN `vostro_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`card` SET TAGS ('dbx_subdomain' = 'partner_services');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `card_id` SET TAGS ('dbx_business_glossary_term' = 'Card Identifier');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `parent_card_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `card_delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `card_delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `cvv_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `cvv_hash` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `embossing_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`card` ALTER COLUMN `embossing_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`merchant` SET TAGS ('dbx_subdomain' = 'partner_services');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `annual_transaction_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `average_transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` SET TAGS ('dbx_subdomain' = 'partner_services');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `payment_processor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Identifier');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `parent_payment_processor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `processing_fee_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`payment_processor` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` SET TAGS ('dbx_subdomain' = 'partner_services');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `merchant_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Agreement Identifier');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `previous_merchant_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `chargeback_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `monthly_service_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `reserve_requirement_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `transaction_fee_fixed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `transaction_limit_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`payment`.`merchant_agreement` ALTER COLUMN `transaction_limit_single` SET TAGS ('dbx_confidential' = 'true');
