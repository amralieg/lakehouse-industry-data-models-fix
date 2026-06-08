-- Schema for Domain: trust | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`trust` COMMENT 'Dedicated domain for client trust account management in strict compliance with IOLTA rules and jurisdiction-specific trust accounting regulations. Owns trust ledger entries, three-way reconciliations, client fund segregation records, disbursement authorizations, and regulatory trust account reporting. Operationally distinct from the billing domain — trust owns fiduciary client funds; billing owns firm revenue.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the client trust account. Primary key for the trust account master record.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Trust accounts operate under firms AML/KYC program with program-level governance (MLRO oversight, risk appetite, screening requirements). Program-level governance link. Enables tracking which program',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Trust accounts may be established for specific service offerings (escrow services, IP prosecution retainers, real estate closing accounts) to track funds designated for particular service types. Enabl',
    `matter_id` BIGINT COMMENT 'Reference to the specific matter or case associated with this trust account. May be null for general client trust accounts not tied to a specific matter.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Trust accounts in legal practice are designated by practice area (litigation, real estate, corporate) for regulatory compliance, segregation of funds, and practice-specific IOLTA reporting. Essential ',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who has primary fiduciary responsibility for this trust account. This attorney is accountable for compliance with trust accounting rules and ethical obligations.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this trust account is maintained. Links to the client master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Trust accounts must comply with jurisdiction-specific regulatory obligations (IOLTA rules, SRA Accounts Rules, client money regulations). Firms track which obligations govern each account for complian',
    `account_name` STRING COMMENT 'The legal name of the trust account as registered with the financial institution. Typically includes firm name, client name, and trust designation.',
    `account_number` STRING COMMENT 'The bank account number assigned by the financial institution for this trust account. Externally-known identifier used for banking transactions and reconciliations.',
    `account_status` STRING COMMENT 'Current lifecycle status of the trust account. Active accounts are operational and accepting transactions; inactive accounts are dormant but not closed; closed accounts have been formally terminated; suspended accounts are temporarily frozen pending investigation or resolution; pending closure accounts are in the process of being wound down.. Valid values are `Active|Inactive|Closed|Suspended|Pending Closure`',
    `account_type` STRING COMMENT 'Classification of the trust account based on regulatory and operational purpose. IOLTA (Interest on Lawyers Trust Accounts) pooled accounts hold commingled client funds with interest benefiting legal aid; individual client trust accounts segregate funds for a single client; escrow accounts hold transaction funds; retainer accounts hold advance fee deposits; settlement accounts hold litigation proceeds; qualified settlement funds hold structured settlement amounts.. Valid values are `IOLTA Pooled|Individual Client Trust|Escrow|Retainer|Settlement|Qualified Settlement Fund`',
    `aml_kyc_status` STRING COMMENT 'Status of Anti-Money Laundering and Know Your Client verification for this trust account. Trust accounts holding client funds must comply with AML regulations and verify client identity.. Valid values are `Verified|Pending|Failed|Expired|Not Required`',
    `aml_risk_rating` STRING COMMENT 'Risk rating assigned to this trust account based on AML assessment factors including client profile, transaction patterns, jurisdiction, and source of funds. High-risk accounts require enhanced due diligence.. Valid values are `Low|Medium|High|Prohibited`',
    `audit_frequency` STRING COMMENT 'Frequency at which this trust account is subject to internal or external audit. High-value or high-risk accounts may require more frequent audits.. Valid values are `Monthly|Quarterly|Annual|On-Demand`',
    `branch_address` STRING COMMENT 'Physical address of the bank branch where the trust account is maintained. Required for regulatory filings and audit documentation.',
    `branch_name` STRING COMMENT 'Name of the specific branch location where the trust account is maintained. May be required for regulatory reporting in some jurisdictions.',
    `closed_date` DATE COMMENT 'Date when the trust account was formally closed. Null for active accounts. Closing a trust account requires zero balance and completion of all regulatory reporting obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trust account record was first created in the system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the trust account. Most trust accounts are maintained in the local jurisdiction currency.. Valid values are `USD|GBP|EUR|CAD|AUD`',
    `current_balance` DECIMAL(18,2) COMMENT 'Current balance of client funds held in the trust account. This is the fiduciary balance owed to the client and must be reconciled monthly against bank statements and client ledgers.',
    `external_reference_number` STRING COMMENT 'External reference number or identifier assigned by the financial institution, regulatory body, or third party. Used for cross-system reconciliation and regulatory reporting.',
    `financial_institution_code` STRING COMMENT 'Routing number, SWIFT code, or other standard identifier for the financial institution holding the trust account. Used for electronic funds transfers and reconciliation.',
    `financial_institution_name` STRING COMMENT 'Name of the bank or financial institution where the trust account is maintained. Must be an approved institution per jurisdiction-specific trust accounting regulations.',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether this trust account earns interest. IOLTA pooled accounts earn interest for legal aid programs; individual client trust accounts may earn interest for the client depending on jurisdiction and account size.',
    `interest_beneficiary` STRING COMMENT 'Entity that receives interest earned on the trust account. For IOLTA accounts, interest goes to the state IOLTA foundation or legal aid programs. For individual client trust accounts, interest typically belongs to the client.. Valid values are `Client|IOLTA Foundation|Legal Aid Society|Firm`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the trust account balance, expressed as a decimal (e.g., 0.0125 for 1.25%). Applicable only for interest-bearing accounts.',
    `iolta_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this trust account is subject to IOLTA reporting requirements. IOLTA accounts must report interest earned and remit it to the designated legal aid foundation.',
    `jurisdiction_code` STRING COMMENT 'State, province, or jurisdiction code governing this trust account. Trust accounting rules vary by jurisdiction and this field determines which regulatory framework applies.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit performed on this trust account. Trust accounts are subject to periodic audits to ensure compliance with fiduciary obligations.',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit. Pass indicates full compliance; pass with observations indicates minor issues noted; fail indicates material deficiencies requiring remediation.. Valid values are `Pass|Pass with Observations|Fail|Not Applicable`',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent three-way reconciliation performed for this trust account. Trust accounts must be reconciled monthly, comparing bank statement balance, trust ledger balance, and client ledger balances.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'Minimum balance that must be maintained in the trust account per bank requirements or firm policy. Some jurisdictions or account types require a minimum balance to remain open.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trust account record was last modified. Updated whenever any attribute of the trust account is changed. Part of audit trail for data lineage and compliance.',
    `next_reconciliation_due_date` DATE COMMENT 'Date by which the next three-way reconciliation must be completed. Typically set to the end of the following month after the last reconciliation.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special instructions, or historical information about the trust account. May include details about account setup, client instructions, or regulatory considerations.',
    `opened_date` DATE COMMENT 'Date when the trust account was opened at the financial institution. Marks the beginning of the accounts operational lifecycle.',
    `purpose_of_account` STRING COMMENT 'Business purpose for which this trust account was established. Examples include holding litigation settlement funds, managing real estate transaction escrow, holding retainer for ongoing legal services, managing estate administration funds.',
    `reconciliation_status` STRING COMMENT 'Current status of trust account reconciliation compliance. Current indicates reconciliation is up to date; overdue indicates a missed reconciliation deadline; in progress indicates reconciliation is underway; discrepancy identified indicates a variance requiring investigation; resolved indicates a prior discrepancy has been corrected.. Valid values are `Current|Overdue|In Progress|Discrepancy Identified|Resolved`',
    `regulatory_classification` STRING COMMENT 'Classification of the trust account for regulatory reporting purposes. Different classifications may have different reporting requirements, audit frequencies, and compliance obligations.. Valid values are `Attorney Trust Account|Client Trust Account|Escrow Account|Settlement Account|Retainer Account`',
    `source_of_funds` STRING COMMENT 'Description of the origin of funds deposited into this trust account. Required for AML compliance and client due diligence. Examples include litigation settlement, real estate transaction proceeds, retainer payment, inheritance.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for each client trust account maintained by the firm in compliance with IOLTA rules and jurisdiction-specific trust accounting regulations. Captures account type (IOLTA pooled, individual client trust, escrow, retainer), account status, designated financial institution, account number, jurisdiction, opening and closing dates, responsible attorney, and regulatory classification. Serves as the SSOT for all fiduciary client fund accounts — operationally distinct from billing accounts which track firm revenue.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`ledger_entry` (
    `ledger_entry_id` BIGINT COMMENT 'Unique identifier for the trust ledger entry. Primary key for the atomic unit of trust accounting.',
    `account_id` BIGINT COMMENT 'Reference to the specific trust bank account in which this transaction occurred. Required for three-way reconciliation.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who authorized this trust transaction. Required for fiduciary responsibility tracking.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust ledger entries frequently relate to specific agreements (retainer agreements, settlement agreements, escrow agreements). Legal operations require linking trust transactions to governing contract',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Trust ledger entries frequently reference the invoice being paid or settled from trust funds. Essential for reconciliation, audit trail, and tracking which trust transactions satisfy billing obligatio',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter for which this trust transaction was recorded. Links trust funds to specific client engagements.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Each trust transaction relates to work under a specific practice area for proper cost allocation, conflict checking, and regulatory reporting. Required for trust activity analysis by practice area and',
    `timekeeper_id` BIGINT COMMENT 'Reference to the system user who created this trust ledger entry. Required for accountability and audit trail.',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns the trust funds. Required for client fund segregation and IOLTA compliance.',
    `reversed_entry_ledger_entry_id` BIGINT COMMENT 'Reference to the original trust ledger entry that this transaction reverses. Null for non-reversal entries.',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.sar_filing. Business justification: When suspicious transactions are identified in trust ledger (unusual patterns, structuring, high-risk jurisdictions), they trigger SAR filings. Direct operational link for AML compliance workflow and ',
    `aml_screening_date` DATE COMMENT 'Date on which AML screening was completed for this transaction. Required for regulatory audit trail.',
    `aml_screening_status` STRING COMMENT 'Outcome of AML screening for this transaction. Required for receipts above jurisdiction-specific thresholds.. Valid values are `not_required|pending|cleared|flagged|escalated`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the trust transaction in the trust account currency. Always positive; direction is indicated by entry_direction field.',
    `authorization_reference` STRING COMMENT 'Client authorization document reference or approval identifier. Required for disbursements and transfers.',
    `bank_statement_date` DATE COMMENT 'Date of the bank statement on which this transaction appeared. Used for three-way reconciliation matching.',
    `counterparty_account_number` STRING COMMENT 'Bank account number of the counterparty. Required for wire transfers and ACH transactions.',
    `counterparty_name` STRING COMMENT 'Name of the third party from whom funds were received or to whom funds were disbursed. Required for AML screening and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this trust ledger entry record was first created. Required for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount. Required for multi-currency trust accounting.. Valid values are `^[A-Z]{3}$`',
    `disbursement_category` STRING COMMENT 'UTBMS expense code or disbursement classification for payments. Used for client billing and matter cost tracking.',
    `entry_direction` STRING COMMENT 'Double-entry accounting direction. Debit increases trust liability to client; credit decreases it.. Valid values are `debit|credit`',
    `gl_posting_date` DATE COMMENT 'Date on which this transaction was posted to the general ledger. Used for period-end reconciliation.',
    `internal_notes` STRING COMMENT 'Confidential internal notes for firm use only. Not disclosed to clients. Used for operational context and issue tracking.',
    `jurisdiction_code` STRING COMMENT 'Legal jurisdiction governing this trust transaction. Determines applicable IOLTA rules and reporting requirements.. Valid values are `^[A-Z]{2,3}$`',
    `ledes_code` STRING COMMENT 'LEDES billing code for trust transactions that will be billed to clients. Enables electronic invoice submission.',
    `ledger_entry_description` STRING COMMENT 'Detailed narrative description of the trust transaction purpose. Required for client reporting and regulatory audit.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this trust ledger entry record was last modified. Required for audit trail and change tracking.',
    `payee_address` STRING COMMENT 'Mailing address of the disbursement recipient. Required for cheque mailing and wire transfer compliance.',
    `payee_name` STRING COMMENT 'Name of the recipient for disbursement transactions. Required for cheque printing and payment audit trail.',
    `payment_method` STRING COMMENT 'Instrument or mechanism used to transfer funds. Required for AML screening and source-of-funds verification. [ENUM-REF-CANDIDATE: wire|cheque|ach|swift|eft|cash|credit_card|debit_card — 8 candidates stripped; promote to reference product]',
    `payment_reference` STRING COMMENT 'External payment identifier such as cheque number, wire confirmation, or ACH trace number. Used for bank reconciliation.',
    `posted_to_gl_flag` BOOLEAN COMMENT 'Indicates whether this trust transaction has been posted to the firm general ledger. Used for financial close process.',
    `reconciliation_date` DATE COMMENT 'Date on which this transaction was reconciled to the bank statement. Required for three-way reconciliation audit trail.',
    `reconciliation_status` STRING COMMENT 'Status of this entry in the three-way reconciliation process. Tracks whether transaction has been matched to bank statement.. Valid values are `unreconciled|reconciled|disputed|pending_review`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this transaction must be included in regulatory trust account reports to bar associations or oversight bodies.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this entry is a reversal of a previous transaction. True for correction entries.',
    `running_balance` DECIMAL(18,2) COMMENT 'Cumulative client trust balance after this transaction. Used for real-time balance verification and overdraft prevention.',
    `source_of_funds` STRING COMMENT 'Classification of the origin of received funds. Required for AML compliance and KYC verification on receipts. [ENUM-REF-CANDIDATE: client_retainer|settlement_proceeds|escrow_deposit|court_ordered|third_party_payment|loan_proceeds|sale_proceeds|inheritance|gift|other — 10 candidates stripped; promote to reference product]',
    `transaction_date` DATE COMMENT 'The business date on which the trust transaction occurred. Used for ledger sequencing and regulatory reporting periods.',
    `transaction_number` STRING COMMENT 'Externally-visible unique transaction reference number for audit trail and client reporting. Sequentially assigned per trust account.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trust transaction was recorded in the system. Used for audit trail and chronological sequencing.',
    `transaction_type` STRING COMMENT 'Classification of the trust transaction. Determines accounting treatment and regulatory reporting category. [ENUM-REF-CANDIDATE: receipt|disbursement|transfer_in|transfer_out|interest_credit|bank_charge|reversal|adjustment — 8 candidates stripped; promote to reference product]',
    `value_date` DATE COMMENT 'The date on which funds became available or were withdrawn from the trust account. May differ from transaction date for wire transfers and cheques.',
    CONSTRAINT pk_ledger_entry PRIMARY KEY(`ledger_entry_id`)
) COMMENT 'Granular double-entry ledger record for every debit and credit movement within a client trust account. The single source of truth (SSOT) for all trust fund transactions — no other product in this domain records financial movements. Covers all transaction types including: receipts (advance retainers, settlement proceeds, escrow deposits, court-ordered funds) with source-of-funds, payment method, client authorization reference, and AML screening attributes; disbursements (third-party payments, fee transfers to operating, settlement distributions, filing fees, expert witness payments) with payee, disbursement category (UTBMS cost code), signatory attorney, and authorization status; transfers between accounts; interest credits; and bank charge reversals. Captures transaction date, value date, transaction type, direction (debit/credit), amount, running balance, matter reference, counterparty identity, payment method (wire, cheque, ACH, SWIFT), authorization reference, and LEDES coding where applicable. Receipt entries include source-of-funds classification and AML screening outcome. Disbursement entries link to disbursement_authorization for approval workflow. The atomic unit of trust accounting — every three-way reconciliation, client balance, and regulatory report is built from these entries.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` (
    `client_trust_balance_id` BIGINT COMMENT 'Unique identifier for the client trust balance record. Primary key for this entity.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney responsible for managing this client trust balance and ensuring compliance with trust accounting rules. Typically the lead attorney on the matter.',
    `matter_id` BIGINT COMMENT 'Identifier of the specific matter for which trust funds are held. Enables matter-level sub-ledger tracking within client trust accounts.',
    `account_id` BIGINT COMMENT 'Identifier of the trust bank account (pooled IOLTA or individual client account) in which the funds are held.',
    `profile_id` BIGINT COMMENT 'Identifier of the client who owns the trust funds. Links to the client master record.',
    `retainer_id` BIGINT COMMENT 'Foreign key linking to billing.retainer. Business justification: Client trust balances often represent retainer funds held in trust. Essential for reconciling retainer balances with trust account balances, regulatory compliance reporting, and ensuring retainer draw',
    `trust_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each client balance record must reference the trust account it represents a position within. Required for pooled IOLTA accounts where multiple client balances exist within one bank account.',
    `audit_findings_notes` STRING COMMENT 'Summary of findings from the last trust account audit for this balance. Documents any discrepancies, corrective actions, or compliance issues identified.',
    `available_balance_amount` DECIMAL(18,2) COMMENT 'Net available balance for immediate disbursement, calculated as current_balance_amount minus held_balance_amount. Represents funds that can be disbursed without restriction.',
    `balance_as_of_date` DATE COMMENT 'Date as of which the current_balance_amount is accurate. Represents the effective date of the balance snapshot.',
    `balance_status` STRING COMMENT 'Current lifecycle status of the trust balance record. Active indicates ongoing trust activity; dormant indicates no recent activity but positive balance; closed indicates zero balance and matter closure; reconciliation_pending indicates awaiting three-way reconciliation; under_review indicates regulatory or internal audit review.. Valid values are `active|dormant|closed|reconciliation_pending|under_review`',
    `client_authorization_on_file_flag` BOOLEAN COMMENT 'Indicator of whether written client authorization for trust fund handling is on file. Required for compliance with engagement letter and trust accounting requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this trust balance record was first created in the system. Represents the inception of trust accounting for this client-matter.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the trust balance (e.g., USD, GBP, EUR). Required for multi-currency trust accounting in international practices.. Valid values are `^[A-Z]{3}$`',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'Current available trust balance for the client-matter combination as of the balance_as_of_date. Represents funds available for authorized disbursements.',
    `dormancy_threshold_days` STRING COMMENT 'Number of days without activity after which the trust balance is considered dormant and subject to escheatment review. Varies by jurisdiction (typically 180-365 days).',
    `escheatment_eligible_flag` BOOLEAN COMMENT 'Indicator of whether the trust balance is eligible for escheatment to the state due to dormancy and inability to locate the client. True triggers escheatment reporting and remittance process.',
    `escheatment_review_date` DATE COMMENT 'Date when the trust balance was last reviewed for escheatment eligibility. Required for compliance with unclaimed property reporting deadlines.',
    `held_balance_amount` DECIMAL(18,2) COMMENT 'Amount of trust funds held pending disbursement authorization or clearance. Represents funds committed but not yet disbursed (e.g., checks issued but not cleared, pending wire transfers).',
    `interest_disbursed_amount` DECIMAL(18,2) COMMENT 'Total interest disbursed to the client from this trust balance. Used to reconcile interest earned vs. interest paid out.',
    `interest_earned_amount` DECIMAL(18,2) COMMENT 'Total interest earned on this client trust balance if held in an individual interest-bearing account (not pooled IOLTA). Interest belongs to the client and must be tracked separately.',
    `jurisdiction_code` STRING COMMENT 'State, province, or country code governing the trust account regulations applicable to this balance. Determines which bar association rules and IOLTA regulations apply.',
    `last_activity_date` DATE COMMENT 'Date of the most recent trust activity (deposit, disbursement, or transfer) for this client-matter. Used to identify dormant accounts subject to escheatment or closure.',
    `last_audit_date` DATE COMMENT 'Date when this trust balance was last audited by internal compliance or external auditors. Used to track audit coverage and schedule future reviews.',
    `last_deposit_date` DATE COMMENT 'Date of the most recent deposit into trust for this client-matter. Used to identify dormant accounts and trigger escheatment reviews.',
    `last_disbursement_date` DATE COMMENT 'Date of the most recent disbursement from trust for this client-matter. Used to identify dormant accounts and assess matter closure readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this trust balance record was last updated. Used for audit trail and change tracking.',
    `last_reconciled_balance_amount` DECIMAL(18,2) COMMENT 'Trust balance amount as of the last completed three-way reconciliation (bank statement, trust ledger, client sub-ledger). Used to detect discrepancies and ensure compliance.',
    `last_reconciliation_date` DATE COMMENT 'Date of the last completed three-way trust account reconciliation for this client-matter balance. Regulatory requirement for monthly reconciliation in most jurisdictions.',
    `minimum_balance_required_amount` DECIMAL(18,2) COMMENT 'Minimum trust balance amount required to be maintained for this client-matter per engagement terms or regulatory requirements. Used to trigger alerts for low balance conditions.',
    `negative_balance_date` DATE COMMENT 'Date when the trust balance first went negative, if applicable. Used for regulatory reporting and disciplinary investigation.',
    `negative_balance_flag` BOOLEAN COMMENT 'Indicator of whether the trust balance has ever gone negative, which is a serious ethical violation. True indicates a historical or current negative balance condition requiring immediate remediation.',
    `opening_balance_amount` DECIMAL(18,2) COMMENT 'Initial trust balance amount when the client-matter trust sub-ledger was established. Represents the first deposit or transfer into trust for this matter.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this trust balance record originated (e.g., Elite 3E, Aderant Expert). Used for data lineage and reconciliation with upstream systems.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicator of whether this trust balance requires special regulatory reporting (e.g., large cash transactions, suspicious activity, cross-border transfers). True triggers compliance review and reporting workflow.',
    `total_deposits_amount` DECIMAL(18,2) COMMENT 'Cumulative total of all deposits into trust for this client-matter since inception. Used for reconciliation and audit trail purposes.',
    `total_disbursements_amount` DECIMAL(18,2) COMMENT 'Cumulative total of all disbursements from trust for this client-matter since inception. Used for reconciliation and audit trail purposes.',
    `trust_account_type` STRING COMMENT 'Type of trust account holding the funds: pooled IOLTA account for multiple clients, individual client trust account, or escrow account for specific transactions.. Valid values are `pooled_iolta|individual_client|escrow`',
    `trust_accounting_notes` STRING COMMENT 'Free-text notes regarding special trust accounting considerations, client instructions, or regulatory exceptions applicable to this balance. Used for audit trail and compliance documentation.',
    CONSTRAINT pk_client_trust_balance PRIMARY KEY(`client_trust_balance_id`)
) COMMENT 'Authoritative per-client, per-matter trust balance record representing the current and historical segregated fund position for each client within a pooled or individual trust account. Tracks available balance, held balance (pending disbursements), matter-level sub-ledger balance, last reconciled balance, and balance as-of date. Enforces client fund segregation requirements mandated by bar association rules and IOLTA regulations.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`receipt` (
    `receipt_id` BIGINT COMMENT 'Unique identifier for the trust receipt record. Primary key.',
    `account_id` BIGINT COMMENT 'Identifier of the trust bank account into which the funds were deposited. Supports multi-account trust management and IOLTA compliance.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Receipt screening (sanctions, PEP, adverse media) is performed under specific AML/KYC program version. Program context for screening decisions and risk ratings. Links receipt to program governing scre',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust receipts often execute specific agreements (retainer deposits per engagement letter, settlement payments per settlement agreement). Real business process: matching incoming trust funds to govern',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Links the receipt transaction to its double-entry accounting representation in the trust ledger. Every receipt of client funds must be recorded in the ledger for IOLTA compliance and three-way reconci',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter for which the funds were received. Links the trust receipt to the specific case or engagement.',
    `profile_id` BIGINT COMMENT 'Identifier of the client who provided the funds. Ensures proper segregation and attribution of client funds.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the supervising attorney or trust accounting manager who approved the receipt for deposit. Required for segregation of duties.',
    `receipt_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this record. Required for audit trail and accountability.',
    `receipt_owner_timekeeper_id` BIGINT COMMENT 'Identifier of the firm user (attorney, paralegal, or accounting staff) who recorded the receipt. Required for accountability and audit trail.',
    `retainer_id` BIGINT COMMENT 'Foreign key linking to billing.retainer. Business justification: Trust receipts frequently replenish retainers. Required for retainer balance tracking, replenishment audit trail, and client billing compliance. Legal-services operations depend on linking receipts to',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Trust receipts from clients require sanctions screening under AML/KYC programs before acceptance. Mandatory compliance workflow to prevent receiving funds from sanctioned entities. Links receipt to sp',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the AML screening system. Higher scores indicate elevated risk requiring additional review.',
    `aml_screening_date` DATE COMMENT 'Date on which the AML screening was completed. Required for regulatory audit trail.',
    `aml_screening_status` STRING COMMENT 'Status of the anti-money laundering screening performed on this receipt. Funds flagged or escalated may require additional due diligence before acceptance.. Valid values are `pending|cleared|flagged|escalated|exempted`',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the funds received. Recorded in the trust accounts base currency.',
    `approval_date` DATE COMMENT 'Date on which the receipt was approved for deposit. Part of the internal control workflow for trust accounting.',
    `bank_statement_line_reference` STRING COMMENT 'Reference to the corresponding line item on the trust account bank statement. Used for three-way reconciliation (firm records, client ledger, bank statement).',
    `cleared_date` DATE COMMENT 'Date on which the deposited funds cleared and became available in the trust account. Critical for three-way reconciliation and disbursement authorization.',
    `client_authorization_reference` STRING COMMENT 'Reference to the clients written authorization or engagement letter permitting the firm to receive and hold these funds in trust. Required for compliance and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trust receipt record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the received funds. Required for multi-currency trust accounting and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `deposit_date` DATE COMMENT 'The date on which the funds were deposited into the trust account. Must comply with jurisdiction-specific prompt deposit rules (typically within 1-3 business days of receipt).',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether the client funds are held in an interest-bearing account with interest accruing to the client (as opposed to IOLTA where interest goes to legal aid programs).',
    `iolta_eligible_flag` BOOLEAN COMMENT 'Indicates whether this receipt is eligible for deposit into an IOLTA account (typically small or short-term client funds where individual interest accounting is impractical).',
    `kyc_verification_status` STRING COMMENT 'Status of the Know Your Client verification for the payor. Required when the payor is not the client or when receiving large sums.. Valid values are `verified|pending|failed|not_required`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trust receipt record was last modified. Any changes to trust records must be logged for regulatory compliance.',
    `notes` STRING COMMENT 'Free-form notes recorded by the receiving user. May include special handling instructions, client communications, or unusual circumstances.',
    `payment_method` STRING COMMENT 'The instrument or mechanism by which the client funds were received. Impacts clearing time and AML screening requirements. [ENUM-REF-CANDIDATE: wire_transfer|cheque|ach|swift|cash|credit_card|electronic_funds_transfer — 7 candidates stripped; promote to reference product]',
    `payor_account_number` STRING COMMENT 'Bank account number or payment instrument identifier from which the funds originated. Masked for security; used for reconciliation and AML screening.',
    `payor_bank_name` STRING COMMENT 'Name of the financial institution from which the funds were sent. Supports AML due diligence and wire transfer verification.',
    `payor_name` STRING COMMENT 'Name of the individual or entity that provided the funds. May differ from the client in third-party payment scenarios.',
    `purpose_description` STRING COMMENT 'Detailed narrative describing the purpose for which the funds were received (e.g., Advance retainer for litigation services in Smith v. Jones, Settlement proceeds from mediation on 2024-01-15).',
    `receipt_date` DATE COMMENT 'The date on which the client funds were received by the firm. Critical for trust accounting reconciliation and interest calculation.',
    `receipt_number` STRING COMMENT 'Externally visible unique receipt number assigned to this trust receipt for audit trail and client communication purposes.. Valid values are `^TR-[0-9]{6,12}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the trust receipt. Tracks the receipt from initial recording through deposit, clearing, and any subsequent reversals.. Valid values are `pending_deposit|deposited|cleared|reversed|rejected|under_review`',
    `receipt_type` STRING COMMENT 'Classification of the trust receipt based on the purpose and source of the funds. Determines handling and disbursement rules.. Valid values are `advance_retainer|settlement_proceeds|escrow_deposit|court_ordered_funds|cost_advance|expert_fee_advance`',
    `reconciliation_date` DATE COMMENT 'Date on which this receipt was successfully reconciled during the monthly trust account reconciliation process.',
    `reconciliation_status` STRING COMMENT 'Status of the three-way reconciliation for this receipt. Discrepancies must be investigated and resolved promptly.. Valid values are `unreconciled|reconciled|discrepancy|pending_review`',
    `reference_number` STRING COMMENT 'External reference number provided by the payor or payment system (e.g., wire confirmation number, cheque number, ACH trace ID). Used for reconciliation.',
    `reversal_date` DATE COMMENT 'Date on which the receipt was reversed (e.g., due to bounced cheque, wire recall, or client request). Nullable; populated only if a reversal occurred.',
    `reversal_reason` STRING COMMENT 'Explanation for why the receipt was reversed. Required for audit trail and client communication when a reversal occurs.',
    `sanctions_screening_status` STRING COMMENT 'Status of screening against international sanctions lists (OFAC, UN, EU). Flagged receipts must be escalated and may require rejection.. Valid values are `cleared|flagged|pending|not_applicable`',
    `source_of_funds` STRING COMMENT 'Description of the origin of the funds (e.g., client personal account, opposing party settlement, insurance company, court registry). Required for AML compliance and conflict checking.',
    `third_party_payment_flag` BOOLEAN COMMENT 'Indicates whether the funds were provided by a third party (not the client). Triggers additional conflict checking and client consent requirements.',
    CONSTRAINT pk_receipt PRIMARY KEY(`receipt_id`)
) COMMENT 'Records the receipt of client funds into a trust account including advance retainers, settlement proceeds, escrow deposits, and court-ordered fund receipts. Captures receipt date, source of funds, payment method (wire, cheque, ACH, SWIFT), amount, matter association, client authorization reference, and anti-money laundering (AML) screening status. Triggers the creation of a corresponding trust_ledger_entry credit record.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` (
    `trust_disbursement_id` BIGINT COMMENT 'Unique identifier for the trust disbursement transaction. Primary key for the trust disbursement record.',
    `account_id` BIGINT COMMENT 'Reference to the client trust account from which funds are being disbursed. Links to the trust account master record.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Disbursement screening is performed under specific AML/KYC program version. Program context for screening decisions and risk ratings. Links disbursement to program governing screening at time of disbu',
    `ar_balance_id` BIGINT COMMENT 'Foreign key to billing.disbursement.disbursement_id',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who authorized the disbursement. Required for fiduciary responsibility and regulatory compliance.',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust disbursements execute obligations under specific agreements (settlement payments, retainer releases per fee agreement terms). Real business process: disbursement authorization workflow requires ',
    `disbursement_authorization_id` BIGINT COMMENT 'Foreign key linking to trust.disbursement_authorization. Business justification: Every disbursement should reference the authorization that approved it. This creates the governance link between the authorization workflow (disbursement_authorization) and the actual payment transact',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: Unauthorized or erroneous disbursements trigger professional indemnity claims. PI claims investigation traces alleged misappropriation or breach to specific disbursement transactions for reserve calcu',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Trust disbursements commonly pay client invoices directly from trust accounts. Critical for payment application tracking, trust-to-billing reconciliation, and regulatory reporting. The existing invoic',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Links the disbursement transaction to its double-entry accounting representation in the trust ledger. Every disbursement must be recorded in the ledger for IOLTA compliance and three-way reconciliatio',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter for which the disbursement is being made. Links to the matter master record.',
    `profile_id` BIGINT COMMENT 'Reference to the client whose trust funds are being disbursed. Links to the client master record.',
    `reversed_by_disbursement_trust_disbursement_id` BIGINT COMMENT 'Reference to the reversing disbursement transaction if this disbursement was reversed. Creates audit trail for corrections.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Disbursements to payees require sanctions screening before processing to prevent payments to sanctioned entities. Standard AML control in legal practice. Links disbursement to specific screening resul',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who processed and executed the disbursement. Used for segregation of duties and audit trail.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of funds disbursed from the trust account. Must match the trust ledger debit entry.',
    `authorization_date` DATE COMMENT 'The date on which the disbursement was authorized by the responsible attorney. Part of the audit trail.',
    `authorization_status` STRING COMMENT 'Current approval and execution status of the disbursement. Tracks the disbursement through its lifecycle from request to completion.. Valid values are `pending|authorized|rejected|cancelled|completed`',
    `bank_account_number` STRING COMMENT 'The trust bank account number from which the disbursement was made. Required for bank reconciliation and regulatory reporting.',
    `bank_name` STRING COMMENT 'The name of the financial institution holding the trust account. Required for regulatory reporting.',
    `bank_routing_number` STRING COMMENT 'The ABA routing number for the trust account bank. Used for electronic funds transfers and wire transfers.',
    `check_number` STRING COMMENT 'The check number if payment method is check. Used for bank reconciliation and audit trail.',
    `cleared_date` DATE COMMENT 'The date on which the disbursement cleared the bank and funds were confirmed as transferred. Used for three-way reconciliation.',
    `court_case_number` STRING COMMENT 'The court case number if the disbursement is related to court filing fees or litigation costs. Used for matter cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the disbursement record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disbursement amount. Required for multi-currency trust accounting.. Valid values are `^[A-Z]{3}$`',
    `disbursement_category` STRING COMMENT 'UTBMS expense code or cost category for the disbursement. Used for matter cost tracking and client billing reconciliation.',
    `disbursement_date` DATE COMMENT 'The date on which the disbursement was executed and funds left the trust account. Core business event timestamp for trust fund outflows.',
    `disbursement_description` STRING COMMENT 'Detailed narrative description of the purpose and nature of the disbursement. Required for client reporting and audit trail.',
    `disbursement_number` STRING COMMENT 'Externally-visible unique business identifier for the disbursement transaction. Used for audit trails and client reporting.',
    `disbursement_type` STRING COMMENT 'Classification of the disbursement purpose. Determines accounting treatment and regulatory reporting category.. Valid values are `client_payment|third_party_payment|fee_transfer|cost_reimbursement|settlement_distribution|court_filing_fee`',
    `is_iolta_reportable` BOOLEAN COMMENT 'Flag indicating whether this disbursement must be included in IOLTA regulatory reporting. Determined by jurisdiction rules.',
    `is_taxable` BOOLEAN COMMENT 'Flag indicating whether the disbursement is subject to tax reporting requirements. Determines 1099 reporting obligations.',
    `is_three_way_reconciled` BOOLEAN COMMENT 'Flag indicating whether this disbursement has been reconciled across trust ledger, bank statement, and client ledger. Required for compliance.',
    `jurisdiction_code` STRING COMMENT 'The legal jurisdiction governing the trust account and disbursement. Determines applicable IOLTA rules and regulatory reporting requirements.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the disbursement record was last updated. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about the disbursement. Used for special instructions or contextual information.',
    `payee_name` STRING COMMENT 'Full legal name of the individual or organization receiving the disbursement. Required for audit trail and regulatory compliance.',
    `payee_type` STRING COMMENT 'Classification of the payee receiving the disbursement. Used for segregation of duties and conflict checking.. Valid values are `client|third_party|court|expert_witness|vendor|firm_operating_account`',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to execute the disbursement. Determines clearing time and reconciliation procedures.. Valid values are `check|wire_transfer|ach|electronic_funds_transfer|credit_card|internal_transfer`',
    `processed_date` DATE COMMENT 'The date on which the disbursement was processed and submitted for payment. May differ from disbursement date due to clearing time.',
    `reconciliation_date` DATE COMMENT 'The date on which the disbursement was successfully reconciled in the three-way reconciliation process.',
    `reversal_reason` STRING COMMENT 'Explanation for why the disbursement was reversed or cancelled. Required for audit trail when disbursements are voided.',
    `tax_treatment_code` STRING COMMENT 'Tax classification code for the disbursement. Used for 1099 reporting and tax compliance when disbursements are made to vendors or experts.',
    `wire_reference_number` STRING COMMENT 'The wire transfer reference or confirmation number if payment method is wire transfer. Used for bank reconciliation.',
    CONSTRAINT pk_trust_disbursement PRIMARY KEY(`trust_disbursement_id`)
) COMMENT 'Records every authorized payment or transfer of client funds out of a trust account including payments to third parties, transfers to firm operating accounts upon fee earning, settlement distributions, court filing fee payments, and expert witness payments. Captures disbursement date, payee, payment method, amount, matter reference, disbursement category (UTBMS cost code), authorization status, and signatory attorney. Core operational record for trust fund outflows.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` (
    `disbursement_authorization_id` BIGINT COMMENT 'Unique identifier for the disbursement authorization record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the specific trust account from which funds will be disbursed. Required for IOLTA compliance and three-way reconciliation.',
    `aml_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_risk_assessment. Business justification: Authorization thresholds and dual signatory requirements are informed by AML risk assessments (high-risk jurisdictions, high-risk clients require enhanced controls). Risk-based control design. Links a',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Disbursement authorization workflows follow documented approval checklists (dual signatory requirements, AML screening steps, client consent verification). Ensures regulatory compliance and risk manag',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Authorization workflows implement specific compliance controls (dual signatory requirements, threshold-based approvals, segregation of duties). Control testing references specific authorizations as ev',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Disbursement authorization workflow requires verifying contractual authority to disburse trust funds. Real business process: dual-signatory approval checks agreement terms (payment schedules, authoriz',
    `ledger_entry_id` BIGINT COMMENT 'FK to trust.trust_ledger_entry.trust_ledger_entry_id — Each authorization governs a specific disbursement transaction recorded in the ledger. Required for audit trail and compliance.',
    `debit_ledger_entry_id` BIGINT COMMENT 'FK to trust.trust_ledger_entry.trust_ledger_entry_id — Each authorization governs a specific disbursement transaction (now a ledger entry of disbursement type). Without this link, authorizations are disconnected from the transactions they approve.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Disbursement authorizations frequently reference the invoice being paid from trust. Critical for approval audit trail, trust compliance, and linking authorization workflow to billing obligations. Lega',
    `matter_id` BIGINT COMMENT 'Reference to the matter for which the trust disbursement is being authorized. Links disbursement to specific legal engagement.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the supervising partner responsible for first-level authorization. Required for dual-control framework.',
    `primary_ledger_entry_id` BIGINT COMMENT 'Reference to the trust ledger entry that this authorization governs. Links to the specific trust transaction requiring authorization.',
    `profile_id` BIGINT COMMENT 'Reference to the client whose trust funds are being disbursed. Required for client fund segregation and audit trail.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper who initiated the disbursement authorization request. Establishes accountability in the authorization chain.',
    `tertiary_disbursement_rejecting_approver_attorney_profile_id` BIGINT COMMENT 'Reference to the timekeeper who rejected the disbursement authorization. Null if not rejected.',
    `aml_screening_date` DATE COMMENT 'Date on which AML screening was completed for this disbursement. Null if screening not required or not yet performed.',
    `aml_screening_status` STRING COMMENT 'Status of AML screening for the disbursement recipient. Required for high-value disbursements per FATF guidelines and firm AML policy.. Valid values are `not_required|pending|cleared|flagged|under_review`',
    `authorization_expiry_date` DATE COMMENT 'Date after which the authorization becomes invalid if disbursement has not been executed. Enforces time-bound authorization controls.',
    `authorization_number` STRING COMMENT 'Unique business identifier for the disbursement authorization. Human-readable reference number used in audit trails and regulatory reporting.. Valid values are `^AUTH-[0-9]{8,12}$`',
    `authorization_status` STRING COMMENT 'Current lifecycle status of the disbursement authorization. Tracks workflow state from initial request through final approval or rejection.. Valid values are `pending|approved|rejected|cancelled|expired|under_review`',
    `client_consent_date` DATE COMMENT 'Date on which client consent was obtained for the disbursement. Null if consent not required or not yet obtained.',
    `client_consent_method` STRING COMMENT 'Method by which client consent was obtained. Required for audit trail and regulatory compliance when consent is mandatory.. Valid values are `written|email|verbal|electronic_signature|not_required`',
    `client_consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether explicit client consent was obtained for the disbursement. Required for certain disbursement types per bar association rules.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this disbursement authorization record was first created in the system. Required for audit trail and data lineage.',
    `digital_signature_reference_1` STRING COMMENT 'Reference identifier or hash of the first digital signature applied to the authorization. Used for non-repudiation and regulatory compliance.',
    `digital_signature_reference_2` STRING COMMENT 'Reference identifier or hash of the second digital signature applied when dual signatory is required. Null if single signature sufficient.',
    `disbursement_amount` DECIMAL(18,2) COMMENT 'The monetary amount being authorized for disbursement from the client trust account. Must not exceed available trust balance.',
    `disbursement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the disbursement amount. Required for multi-currency trust accounting.. Valid values are `^[A-Z]{3}$`',
    `disbursement_purpose` STRING COMMENT 'Detailed business justification and purpose for the trust fund disbursement. Required for regulatory compliance and audit trail.',
    `disbursement_type` STRING COMMENT 'Classification of the disbursement by purpose and recipient type. Used for regulatory reporting and internal controls. [ENUM-REF-CANDIDATE: client_refund|third_party_payment|fee_transfer|expense_reimbursement|settlement_distribution|court_ordered|other — 7 candidates stripped; promote to reference product]',
    `dual_signatory_required_flag` BOOLEAN COMMENT 'Indicates whether dual signatory approval is required for this disbursement based on amount threshold or disbursement type. True if managing partner approval is mandatory.',
    `dual_signatory_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which dual signatory approval is required. Captured at time of authorization for audit purposes.',
    `final_authorization_date` DATE COMMENT 'Date on which the disbursement received final authorization and became executable. Represents completion of approval workflow.',
    `final_authorization_timestamp` TIMESTAMP COMMENT 'Precise date and time when the disbursement authorization workflow was completed and funds became available for disbursement.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code identifying the legal jurisdiction whose trust accounting rules govern this disbursement. Required for multi-jurisdiction firms.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this disbursement authorization record was last updated. Tracks all modifications for audit and compliance purposes.',
    `managing_partner_approval_date` DATE COMMENT 'Date on which the managing partner approved the disbursement. Null if not required, not yet approved, or rejected.',
    `managing_partner_approval_timestamp` TIMESTAMP COMMENT 'Precise date and time of managing partner approval. Required for high-value disbursements exceeding dual-signatory threshold.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the disbursement authorization. Used for internal communication and audit context.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this disbursement authorization must be included in regulatory trust account reporting to bar association or IOLTA authority.',
    `rejection_date` DATE COMMENT 'Date on which the disbursement authorization was rejected. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the rejecting approver for denying the disbursement authorization. Required for audit trail and process improvement.',
    `rejection_reason_code` STRING COMMENT 'Standardized code categorizing the reason for rejection. Used for reporting and trend analysis of authorization failures.. Valid values are `insufficient_funds|invalid_purpose|missing_documentation|unauthorized_request|client_objection|regulatory_concern`',
    `rejection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the disbursement authorization was rejected by an approver in the authorization chain.',
    `request_date` DATE COMMENT 'Date on which the disbursement authorization was initially requested. Used for aging analysis and SLA tracking.',
    `request_timestamp` TIMESTAMP COMMENT 'Precise date and time when the disbursement authorization request was submitted. Required for audit trail and workflow tracking.',
    `supervising_partner_approval_date` DATE COMMENT 'Date on which the supervising partner approved the disbursement. Null if not yet approved or if rejected.',
    `supervising_partner_approval_timestamp` TIMESTAMP COMMENT 'Precise date and time of supervising partner approval. Required for audit trail and regulatory compliance.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier to supporting documentation stored in the document management system. Links authorization to invoices, receipts, or court orders.',
    CONSTRAINT pk_disbursement_authorization PRIMARY KEY(`disbursement_authorization_id`)
) COMMENT 'Workflow and approval record governing the authorization of each disbursement from a client trust account. Captures the requesting timekeeper, authorization chain (supervising partner, managing partner where required), authorization date and time, approval status, rejection reason, dual-signatory requirements for amounts above threshold, and digital signature references. Enforces the firms internal controls and bar association disbursement authorization rules.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` (
    `three_way_reconciliation_id` BIGINT COMMENT 'Unique identifier for the three-way reconciliation record. Primary key for the reconciliation entity.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the partner or designated trust account signatory who provided final approval and sign-off on the reconciliation. Required under most jurisdictions.',
    `bank_statement_id` BIGINT COMMENT 'FK to trust.bank_statement.bank_statement_id — Each reconciliation references the specific bank statement used as the external balance source. Critical for audit trail.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Three-way reconciliation is a key detective control tested under compliance frameworks (SRA, ABA Model Rules). Control testing samples reconciliations for completeness, timeliness, and review evidence',
    `account_id` BIGINT COMMENT 'Reference to the specific trust account being reconciled. Links to the trust account master record.',
    `primary_three_timekeeper_id` BIGINT COMMENT 'Reference to the staff member (typically accounting staff or trust accountant) who performed the reconciliation. Links to workforce.attorney_profile or staff record.',
    `reconciled_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each reconciliation is performed for a specific trust account. Without this FK, reconciliation records cannot be associated with the account they validate.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Three-way reconciliation procedures follow standardized process checklists (bank statement matching, ledger verification, client balance confirmation). Critical for regulatory compliance and audit rea',
    `reviewer_timekeeper_id` BIGINT COMMENT 'Reference to the senior staff member or partner who reviewed the reconciliation for accuracy and completeness. Segregation of duties required.',
    `approval_date` DATE COMMENT 'The date on which the approver provided final sign-off on the reconciliation. Completes the reconciliation lifecycle and establishes regulatory compliance date.',
    `audit_trail_reference` STRING COMMENT 'Reference to supporting documentation (bank statements, ledger reports, reconciliation worksheets) stored in the document management system. Required for regulatory examination.',
    `bank_account_number` STRING COMMENT 'The bank account number for the trust account being reconciled. Masked or encrypted in reporting; full number required for audit trail.',
    `bank_errors_total` DECIMAL(18,2) COMMENT 'Total amount of errors identified on the bank statement (incorrect charges, duplicate transactions, posting errors). Requires bank correction and documentation.',
    `bank_name` STRING COMMENT 'The name of the financial institution holding the trust account (e.g., JPMorgan Chase, HSBC). Required for regulatory reporting.',
    `bank_statement_balance` DECIMAL(18,2) COMMENT 'The ending balance reported on the bank statement for the trust account as of the reconciliation period end date. First leg of the three-way reconciliation.',
    `bank_statement_date` DATE COMMENT 'The statement date printed on the bank statement used for this reconciliation. Typically matches reconciliation_period_end_date but may differ for mid-month reconciliations.',
    `book_balance` DECIMAL(18,2) COMMENT 'The trust ledger balance per the firms accounting system (Elite 3E GL trust account) as of the reconciliation period end date. Second leg of the three-way reconciliation.',
    `client_ledger_total` DECIMAL(18,2) COMMENT 'The sum of all individual client sub-ledger balances as of the reconciliation period end date. Third leg of the three-way reconciliation. Must equal book_balance when no variances exist.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this reconciliation (e.g., USD, GBP, EUR). Trust accounts are typically single-currency.. Valid values are `^[A-Z]{3}$`',
    `deposits_in_transit_total` DECIMAL(18,2) COMMENT 'Total amount of deposits recorded in the trust ledger but not yet reflected on the bank statement as of the reconciliation date. Reconciling item between book and bank balances.',
    `exception_count` STRING COMMENT 'The number of reconciling items (outstanding checks, deposits in transit, errors) identified during this reconciliation. Zero indicates clean reconciliation.',
    `jurisdiction_code` STRING COMMENT 'The legal jurisdiction governing this trust account (e.g., USA state code, GBR for England and Wales). Trust accounting rules vary by jurisdiction.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was last updated. Tracks changes during the reconciliation lifecycle (in_progress to completed).',
    `ledger_errors_total` DECIMAL(18,2) COMMENT 'Total amount of errors identified in the firms trust ledger (posting errors, incorrect amounts, duplicate entries). Requires correcting journal entries and audit trail.',
    `outstanding_checks_total` DECIMAL(18,2) COMMENT 'Total amount of checks issued from the trust account that have not yet cleared the bank as of the reconciliation date. Reconciling item between book and bank balances.',
    `prior_period_unresolved_variance` DECIMAL(18,2) COMMENT 'The unresolved variance amount carried forward from the previous reconciliation period. Should be resolved in current period or escalated.',
    `reconciliation_method` STRING COMMENT 'The method used to perform the reconciliation: manual (spreadsheet-based), semi_automated (system-assisted with manual review), fully_automated (system-generated with exception-only review).. Valid values are `manual|semi_automated|fully_automated`',
    `reconciliation_number` STRING COMMENT 'Business identifier for the reconciliation record, typically formatted as RECON-YYYYMM-NNNN for monthly reconciliations.. Valid values are `^RECON-[0-9]{6,12}$`',
    `reconciliation_performed_date` DATE COMMENT 'The date on which the reconciliation work was completed by the preparer. Must be within regulatory timeframes (typically within 30 days of period end).',
    `reconciliation_period_end_date` DATE COMMENT 'The last day of the period covered by this reconciliation, typically the last day of the month. Mandatory monthly reconciliation under most jurisdictions.',
    `reconciliation_period_start_date` DATE COMMENT 'The first day of the period covered by this reconciliation, typically the first day of the month.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation process: in_progress (reconciliation being performed), completed (reconciliation finished with no exceptions), exception (variances identified requiring resolution), under_review (submitted for partner review), approved (final sign-off completed).. Valid values are `in_progress|completed|exception|under_review|approved`',
    `regulatory_filing_date` DATE COMMENT 'The date on which this reconciliation was submitted to the regulatory authority, if required. Null if no filing is required or filing is pending.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this reconciliation must be submitted to the regulatory authority (e.g., annual IOLTA report, SRA accountants report). True if filing is required.',
    `review_completed_date` DATE COMMENT 'The date on which the reviewer completed their review of the reconciliation. Required for audit trail and regulatory compliance.',
    `timing_differences_total` DECIMAL(18,2) COMMENT 'Total amount of legitimate timing differences between book and bank that will self-resolve in subsequent periods (e.g., end-of-month transactions posted next business day).',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'The net difference between the three reconciliation legs. Calculated as (bank_statement_balance + outstanding_items) - book_balance. Zero indicates perfect reconciliation.',
    `unresolved_exception_count` STRING COMMENT 'The number of reconciling items that remain unresolved as of the current date. Non-zero values require follow-up and escalation.',
    `unresolved_variance_amount` DECIMAL(18,2) COMMENT 'Amount of variance that remains unexplained after all reconciling items have been identified and documented. Non-zero values require escalation and investigation.',
    `variance_resolution_notes` STRING COMMENT 'Detailed narrative explaining identified variances, root cause analysis, corrective actions taken, and resolution status. Required for regulatory examination audit trail.',
    CONSTRAINT pk_three_way_reconciliation PRIMARY KEY(`three_way_reconciliation_id`)
) COMMENT 'Periodic three-way reconciliation record that validates agreement between the firms trust ledger balance, the client sub-ledger total, and the bank statement balance for each trust account. Header captures reconciliation period (monthly mandatory), bank statement balance, book balance, client ledger total, identified variances, variance resolution notes, reconciliation status (in-progress, completed, exception), preparer, reviewer, and sign-off date. Reconciling items (modeled as detail records within this product) capture: item type (outstanding cheque, deposit in transit, bank error, ledger error, timing difference), amount, originating transaction reference, expected clearance date, resolution status, and resolution date. Mandatory under ABA Model Rules and SRA Accounts Rules. Provides the complete audit trail required to clear reconciliation exceptions and satisfy regulatory examination.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`reconciliation_item` (
    `reconciliation_item_id` BIGINT COMMENT 'Unique identifier for the reconciliation item. Primary key for the reconciliation item entity.',
    `account_id` BIGINT COMMENT 'Reference to the specific trust bank account where this reconciliation item was identified. Links to the master trust account register.',
    `ledger_entry_id` BIGINT COMMENT 'Reference to the correcting journal entry or ledger adjustment that resolved this reconciliation item. Null until adjustment is posted. Links to trust ledger entry for full audit trail.',
    `matter_id` BIGINT COMMENT 'Reference to the specific legal matter associated with this reconciliation item. Enables matter-level trust fund tracking and audit trail.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the trust accounting staff member or attorney responsible for investigating and resolving this reconciliation item. Enables workload tracking and accountability.',
    `profile_id` BIGINT COMMENT 'Reference to the client whose funds are affected by this reconciliation item. Required for client sub-ledger reconciliation and regulatory reporting.',
    `three_way_reconciliation_id` BIGINT COMMENT 'Reference to the parent three-way reconciliation process that identified this item. Links this item to the specific reconciliation run.',
    `actual_clearance_date` DATE COMMENT 'Date when this reconciliation item was actually resolved or cleared. Null until item status moves to resolved. Used for reconciliation cycle time analysis.',
    `adjustment_required` BOOLEAN COMMENT 'Indicates whether this reconciliation item requires a correcting journal entry or ledger adjustment. True for ledger errors; false for timing differences that will self-resolve.',
    `aging_days` STRING COMMENT 'Number of days since this reconciliation item was first identified. Calculated as current date minus identified date. Used for aging reports and escalation of overdue items.',
    `bank_statement_date` DATE COMMENT 'Date of the bank statement on which this reconciliation item was identified. Links the item to a specific statement period for audit trail.',
    `cheque_number` STRING COMMENT 'Cheque number for outstanding cheque reconciliation items. Enables tracking of uncleared cheques and matching with bank clearances.',
    `client_notified_date` DATE COMMENT 'Date when the client was notified of this reconciliation item, if notification was required. Null if notification not required or not yet completed. Part of ethical compliance audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this reconciliation item record was first created in the trust accounting system. Part of the audit trail for regulatory examination.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the variance amount. Required for multi-jurisdiction trust accounting.. Valid values are `^[A-Z]{3}$`',
    `deposit_reference` STRING COMMENT 'Reference number or identifier for deposits in transit. Links to deposit slip or wire transfer confirmation for clearance tracking.',
    `error_description` STRING COMMENT 'Detailed narrative description of the reconciliation item, including the nature of the discrepancy, root cause analysis, and any corrective actions required. Critical for audit trail and regulatory examination.',
    `expected_clearance_date` DATE COMMENT 'Anticipated date when this reconciliation item is expected to clear or resolve. Used for aging reports and escalation triggers for overdue items.',
    `identified_date` DATE COMMENT 'Date when this reconciliation item was first identified during the three-way reconciliation process. Critical for aging analysis and regulatory compliance timelines.',
    `item_status` STRING COMMENT 'Current lifecycle status of the reconciliation item. Tracks progression from identification through resolution and regulatory clearance.. Valid values are `identified|under_review|pending_clearance|resolved|escalated|written_off`',
    `item_type` STRING COMMENT 'Classification of the reconciling item that explains the variance between trust ledger, client sub-ledger, or bank statement. Determines the nature of the discrepancy and the required resolution action.. Valid values are `outstanding_cheque|deposit_in_transit|bank_error|ledger_error|timing_difference|unrecorded_bank_charge`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this reconciliation item record was last updated. Tracks all changes to status, resolution notes, and other fields for complete audit trail.',
    `ledger_entry_date` DATE COMMENT 'Date of the corresponding trust ledger entry related to this reconciliation item. Used to calculate timing differences between ledger and bank.',
    `originating_transaction_reference` STRING COMMENT 'Reference number or identifier of the underlying trust transaction that caused this reconciliation item. May reference a cheque number, deposit slip, wire transfer ID, or ledger entry number.',
    `payee_name` STRING COMMENT 'Name of the payee for outstanding cheques or recipient of funds. Used for matching and clearance verification. Business-confidential client transaction data.',
    `priority` STRING COMMENT 'Priority level assigned to this reconciliation item based on materiality, aging, and regulatory risk. Critical items require immediate partner attention and may trigger regulatory reporting.. Valid values are `low|medium|high|critical`',
    `reconciliation_side` STRING COMMENT 'Indicates which side of the three-way reconciliation this item affects. Determines whether the variance is a bank-side or ledger-side adjustment.. Valid values are `bank|ledger|client_sub_ledger`',
    `regulatory_report_date` DATE COMMENT 'Date when this reconciliation item was reported to the regulatory authority, if reporting was required. Null if not reportable or not yet reported. Critical for compliance audit trail.',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this reconciliation item must be reported to the state bar or IOLTA oversight authority. True for material discrepancies, unresolved items exceeding aging thresholds, or suspected misappropriation.',
    `requires_client_notification` BOOLEAN COMMENT 'Indicates whether this reconciliation item requires notification to the affected client under ethical rules or firm policy. True for material discrepancies affecting client funds.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting how this reconciliation item was resolved, including actions taken, approvals obtained, and final disposition. Required for regulatory audit trail.',
    `review_date` DATE COMMENT 'Date when this reconciliation item was reviewed and approved by a supervisor. Part of the required dual-control audit trail for trust account management.',
    `source_system` STRING COMMENT 'System or source from which this reconciliation item originated. Identifies whether the discrepancy was detected in the trust ledger, client sub-ledger, or bank statement comparison.. Valid values are `trust_ledger|client_sub_ledger|bank_statement|manual_entry`',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary value of the discrepancy identified during reconciliation. Positive values indicate amounts on bank statement not yet in ledger; negative values indicate ledger entries not yet cleared by bank.',
    CONSTRAINT pk_reconciliation_item PRIMARY KEY(`reconciliation_item_id`)
) COMMENT 'Individual reconciling item identified during a three-way reconciliation that explains a variance between the trust ledger, client sub-ledger, or bank statement. Captures item type (outstanding cheque, deposit in transit, bank error, ledger error, timing difference), amount, originating transaction reference, expected clearance date, resolution status, and resolution date. Provides the audit trail required to clear reconciliation exceptions and satisfy regulatory examination.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`bank_statement` (
    `bank_statement_id` BIGINT COMMENT 'Unique identifier for the bank statement record. Primary key for the bank statement entity.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this bank statement record. Required for audit trail and compliance.',
    `account_id` BIGINT COMMENT 'Reference to the trust account for which this statement was issued. Links to the trust account master record.',
    `reconciled_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each bank statement belongs to a specific trust account. Required for the external leg of three-way reconciliation.',
    `reconciliation_period_id` BIGINT COMMENT 'Foreign key to trust.reconciliation_period.reconciliation_period_id',
    `regulatory_return_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_return. Business justification: Bank statement data (interest earned, average balances, transaction counts) feeds regulatory returns (IOLTA reports, client money reports). Source data relationship for regulatory reporting. Links sta',
    `statement_owner_timekeeper_id` BIGINT COMMENT 'Reference to the user who performed and approved the reconciliation of this bank statement. Required for audit trail and compliance.',
    `average_daily_balance` DECIMAL(18,2) COMMENT 'The average daily balance for the trust account during the statement period as calculated by the financial institution. Used for interest calculation verification.',
    `branch_code` STRING COMMENT 'The branch or office code of the financial institution where the trust account is held. May be used for multi-branch reconciliation.',
    `closing_balance` DECIMAL(18,2) COMMENT 'The account balance at the end of the statement period as reported by the financial institution. This is the external reference balance for three-way reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts on this statement. Typically USD for US-based IOLTA accounts.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_amount` DECIMAL(18,2) COMMENT 'The net difference between the bank statement closing balance and the trust ledger balance at the end of the statement period. Zero indicates a balanced reconciliation.',
    `financial_institution_name` STRING COMMENT 'The legal name of the bank or financial institution that issued this statement.',
    `import_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement was imported or entered into the trust accounting system.',
    `interest_earned` DECIMAL(18,2) COMMENT 'The total interest earned on the trust account during this statement period. Critical for IOLTA reporting and remittance to state bar foundations.',
    `iolta_reporting_period` STRING COMMENT 'The IOLTA reporting period identifier (e.g., Q1-2024, 2024-01) to which this statement belongs. Used for regulatory reporting aggregation.',
    `is_final_statement` BOOLEAN COMMENT 'Indicates whether this is the final statement for a closed trust account. Used for account closure workflows and compliance reporting.',
    `jurisdiction_code` STRING COMMENT 'The two-letter state or jurisdiction code where this trust account is registered and regulated. Critical for jurisdiction-specific IOLTA compliance.. Valid values are `^[A-Z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement record was last updated. Tracks changes for audit and compliance purposes.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The account balance at the beginning of the statement period as reported by the financial institution.',
    `reconciliation_date` DATE COMMENT 'The date on which this bank statement was successfully reconciled and approved. Null if reconciliation is not yet complete.',
    `reconciliation_status` STRING COMMENT 'The current status of the three-way reconciliation process for this bank statement. Tracks whether the statement has been matched against trust ledger and client balances.. Valid values are `pending|in_progress|reconciled|discrepancy_identified|approved|rejected`',
    `routing_number` STRING COMMENT 'The nine-digit ABA routing number for the financial institution. Used for electronic funds transfer and account identification.. Valid values are `^[0-9]{9}$`',
    `service_charges` DECIMAL(18,2) COMMENT 'The total bank fees and service charges deducted during the statement period. Must be tracked separately for IOLTA compliance.',
    `statement_date` DATE COMMENT 'The official statement date as printed on the bank statement by the financial institution. Typically the same as the statement period end date.',
    `statement_file_hash` STRING COMMENT 'The cryptographic hash (e.g., SHA-256) of the original statement file. Ensures document integrity and detects tampering for compliance purposes.',
    `statement_file_path` STRING COMMENT 'The storage location or document management system path where the original bank statement file is archived. Used for audit retrieval.',
    `statement_format` STRING COMMENT 'The file format or data standard of the original statement document. Used for parsing and validation logic.. Valid values are `pdf|csv|ofx|qbo|bai2|mt940`',
    `statement_notes` STRING COMMENT 'Free-text notes or comments regarding this bank statement. May include reconciliation notes, exception explanations, or special instructions.',
    `statement_number` STRING COMMENT 'The unique statement number or reference assigned by the financial institution for this statement period.',
    `statement_period_end_date` DATE COMMENT 'The last date covered by this bank statement period.',
    `statement_period_start_date` DATE COMMENT 'The first date covered by this bank statement period.',
    `statement_source` STRING COMMENT 'The method by which this bank statement was imported or entered into the system. Indicates data provenance for audit purposes.. Valid values are `electronic_feed|pdf_import|manual_entry|api_integration|csv_upload|ofx_import`',
    `total_credit_count` STRING COMMENT 'The number of credit transactions posted during the statement period.',
    `total_credits` DECIMAL(18,2) COMMENT 'The sum of all credit transactions (deposits, interest, reversals) posted during the statement period.',
    `total_debit_count` STRING COMMENT 'The number of debit transactions posted during the statement period.',
    `total_debits` DECIMAL(18,2) COMMENT 'The sum of all debit transactions (withdrawals, fees, disbursements) posted during the statement period.',
    `unmatched_transaction_count` STRING COMMENT 'The number of bank statement line items that have not been matched to a corresponding trust ledger entry. Used to identify reconciliation exceptions.',
    CONSTRAINT pk_bank_statement PRIMARY KEY(`bank_statement_id`)
) COMMENT 'Imported or manually entered bank statement record for each trust account covering a defined statement period, including header-level summary and all constituent line items. Header captures financial institution name, account number, statement period start and end dates, opening balance, closing balance, total credits, total debits, statement source (electronic feed, PDF import, manual entry), and import timestamp. Line items (modeled as detail records within this product) capture transaction date, posting date, description, debit amount, credit amount, running bank balance, transaction reference number, and matching status to a trust_ledger_entry. Enables automated matching during reconciliation and identification of unmatched bank transactions requiring investigation. Serves as the external reference leg of the three-way reconciliation.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` (
    `bank_statement_line_id` BIGINT COMMENT 'Unique identifier for the bank statement line item. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the trust account to which this bank statement line belongs. Enables filtering and reconciliation by specific IOLTA or client trust account.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this bank statement line record. Supports audit trail and accountability.',
    `bank_reconciled_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who marked this bank statement line as reconciled. Supports audit trail and accountability for trust account reconciliation sign-off.',
    `bank_statement_id` BIGINT COMMENT 'Reference to the parent bank statement document from which this line was imported. Links to the bank_statement header entity.',
    `bank_voided_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who voided this bank statement line. Supports audit trail and accountability.',
    `duplicate_of_line_bank_statement_line_id` BIGINT COMMENT 'Reference to the original bank statement line if this line is marked as a duplicate. Null if not a duplicate. Supports duplicate resolution and audit trail.',
    `line_owner_timekeeper_id` BIGINT COMMENT 'Reference to the user who manually matched or approved the match for this bank statement line. Null for automatic matches. Supports audit trail and accountability.',
    `ledger_entry_id` BIGINT COMMENT 'Reference to the trust ledger entry that has been matched to this bank statement line during reconciliation. Null if unmatched or under review.',
    `reconciliation_period_id` BIGINT COMMENT 'Reference to the reconciliation period (typically monthly) during which this bank statement line was processed. Enables period-based reconciliation reporting and audit.',
    `bank_transaction_code` STRING COMMENT 'The bank-specific transaction type code (e.g., CHK for check, DEP for deposit, FEE for bank fee, INT for interest). Used to classify transaction types during import.',
    `check_number` STRING COMMENT 'The check number if this transaction represents a cleared check. Extracted from transaction description or provided as a separate field by the bank. Used to match against disbursement records.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement line record was first created in the system. Used for audit trail and data lineage.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The amount credited to the trust account for this transaction. Null if the transaction is a debit. Represents inflows such as client deposits, interest, or transfers in.',
    `debit_amount` DECIMAL(18,2) COMMENT 'The amount debited from the trust account for this transaction. Null if the transaction is a credit. Represents outflows such as disbursements, fees, or transfers out.',
    `exception_notes` STRING COMMENT 'Free-text notes documenting the nature of the exception, investigation findings, and resolution actions. Supports audit trail and knowledge transfer.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating why this bank statement line is flagged as an exception or remains unmatched. Used for exception reporting and root cause analysis. [ENUM-REF-CANDIDATE: amount_mismatch|date_mismatch|missing_ledger_entry|duplicate_bank_entry|unidentified_transaction|bank_error|timing_difference — 7 candidates stripped; promote to reference product]',
    `import_batch_reference` STRING COMMENT 'Identifier for the batch import process that loaded this bank statement line. Used for traceability, error investigation, and re-import scenarios.',
    `import_source_file_name` STRING COMMENT 'The name of the source file (e.g., bank statement CSV, BAI2, or OFX file) from which this line was imported. Supports audit trail and source verification.',
    `import_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement line was imported into the system. Used for data lineage and troubleshooting import issues.',
    `is_duplicate` BOOLEAN COMMENT 'Indicates whether this bank statement line has been identified as a duplicate of another line (e.g., due to overlapping statement imports). Used to prevent double-counting in reconciliation.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether this bank statement line has been fully reconciled and approved as part of the three-way reconciliation process. True when reconciliation is complete and signed off.',
    `is_void` BOOLEAN COMMENT 'Indicates whether this bank statement line has been voided (e.g., due to bank error correction or reversal). Voided lines are excluded from reconciliation totals.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement line record was last updated. Used for audit trail and change tracking.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of this line within the parent bank statement. Used to preserve the original bank statement line order for audit and reconciliation purposes.',
    `matched_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement line was matched to a trust ledger entry. Used for reconciliation audit trail and performance metrics.',
    `matching_confidence_score` DECIMAL(18,2) COMMENT 'Automated matching algorithm confidence score (0.00 to 100.00) indicating the likelihood that the matched trust ledger entry is correct. Used to prioritize manual review of low-confidence matches.',
    `matching_method` STRING COMMENT 'The method by which this bank statement line was matched to a trust ledger entry. Supports audit trail and matching algorithm performance analysis.. Valid values are `automatic|manual|rule_based|ml_assisted|imported_matched`',
    `matching_status` STRING COMMENT 'Indicates whether this bank statement line has been successfully matched to a trust ledger entry during reconciliation. Unmatched lines require investigation.. Valid values are `unmatched|matched|partially_matched|exception|under_review`',
    `payee_payor_name` STRING COMMENT 'The name of the party to or from whom the funds were transferred. Extracted from bank transaction description or provided as a structured field. Used in matching and audit trails.',
    `posting_date` DATE COMMENT 'The date on which the bank posted the transaction to the account ledger. Used for reconciliation timing differences and float analysis.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement line was marked as reconciled. Used for compliance reporting and audit trail.',
    `running_balance` DECIMAL(18,2) COMMENT 'The cumulative account balance after this transaction as reported by the bank. Used as a control total during three-way reconciliation to verify that all transactions are captured.',
    `transaction_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for this transaction. Typically matches the trust account base currency but may differ for foreign currency transactions.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The date on which the transaction occurred according to the bank. This is the business event date and may differ from the posting date.',
    `transaction_description` STRING COMMENT 'The narrative description of the transaction as provided by the bank. Contains payee/payor information, check numbers, wire references, and other identifying details used in matching.',
    `transaction_reference_number` STRING COMMENT 'The unique reference or confirmation number assigned by the bank to this transaction. Used for tracing and dispute resolution.',
    `value_date` DATE COMMENT 'The effective date for interest calculation purposes. Relevant for trust accounts where interest accrual timing must be tracked for IOLTA compliance.',
    `void_reason` STRING COMMENT 'Explanation for why this bank statement line was voided. Supports audit trail and compliance documentation.',
    `voided_timestamp` TIMESTAMP COMMENT 'The date and time when this bank statement line was voided. Used for audit trail and compliance reporting.',
    CONSTRAINT pk_bank_statement_line PRIMARY KEY(`bank_statement_line_id`)
) COMMENT 'Individual line item from an imported bank statement for a trust account. Captures transaction date, posting date, description, debit amount, credit amount, running bank balance, transaction reference number, and matching status to a trust_ledger_entry. Enables automated matching during reconciliation and identification of unmatched bank transactions that require investigation.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` (
    `iolta_interest_remittance_id` BIGINT COMMENT 'Unique identifier for the IOLTA interest remittance record. Primary key.',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Links the IOLTA interest remittance to its ledger representation. Interest remittances must be recorded in the trust ledger for regulatory compliance and reconciliation. This FK will be populated when',
    `account_id` BIGINT COMMENT 'Reference to the pooled IOLTA trust account from which interest was earned and remitted.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or staff member who prepared and submitted the remittance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IOLTA interest remittances fulfill specific regulatory obligations in each jurisdiction (state bar IOLTA programs). Direct compliance linkage from remittance to obligation being satisfied. Enables tra',
    `source_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each interest remittance is generated from a specific IOLTA pooled trust account. Required for regulatory reporting.',
    `approval_date` DATE COMMENT 'Date on which the remittance was approved for payment by an authorized partner or compliance officer.',
    `bank_account_number` STRING COMMENT 'Account number of the IOLTA trust account from which the remittance was made.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the IOLTA trust account.',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing number of the financial institution holding the IOLTA trust account.. Valid values are `^[0-9]{9}$`',
    `bank_service_charge_amount` DECIMAL(18,2) COMMENT 'Total bank service charges, fees, or administrative costs deducted from gross interest during the remittance period.',
    `compliance_certification_date` DATE COMMENT 'Date on which compliance certification was completed for this remittance.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether the remittance has been certified as compliant with all applicable IOLTA program rules and ABA Model Rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this remittance record was first created in the trust accounting system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the remittance amounts. Typically USD for US IOLTA programs.. Valid values are `^[A-Z]{3}$`',
    `form_1099_issued_date` DATE COMMENT 'Date on which IRS Form 1099-INT was issued to the recipient organization for this remittance, if applicable.',
    `form_1099_required_flag` BOOLEAN COMMENT 'Indicates whether this remittance requires IRS Form 1099-INT reporting to the recipient organization.',
    `gross_interest_earned_amount` DECIMAL(18,2) COMMENT 'Total interest earned on the pooled IOLTA account during the remittance period before any deductions.',
    `jurisdiction_code` STRING COMMENT 'Two-letter US state or territory code identifying the jurisdiction whose IOLTA program receives this remittance.. Valid values are `^[A-Z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this remittance record was last updated or modified.',
    `net_remittance_amount` DECIMAL(18,2) COMMENT 'Net amount remitted to the IOLTA program after deducting bank service charges from gross interest earned.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the remittance, including special circumstances, adjustments, or correspondence with the IOLTA program.',
    `payment_method` STRING COMMENT 'Method used to remit the funds to the IOLTA program (wire transfer, ACH, check, or electronic funds transfer).. Valid values are `wire_transfer|ach|check|electronic_funds_transfer`',
    `payment_reference_number` STRING COMMENT 'Bank confirmation number, wire transfer reference, check number, or other payment instrument identifier confirming the remittance transaction.',
    `recipient_organization_name` STRING COMMENT 'Full legal name of the state IOLTA program, legal aid foundation, or designated recipient organization receiving the remittance.',
    `recipient_tax_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number of the recipient organization for IRS reporting purposes.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `reconciliation_date` DATE COMMENT 'Date on which the remittance was reconciled against bank statements and IOLTA program records.',
    `reconciliation_notes` STRING COMMENT 'Free-text notes documenting reconciliation findings, discrepancies, or adjustments related to this remittance.',
    `remittance_date` DATE COMMENT 'Date on which the net remittance amount was paid or transferred to the recipient IOLTA program.',
    `remittance_number` STRING COMMENT 'Business identifier for the remittance transaction, typically assigned by the firm or trust accounting system.. Valid values are `^REM-[0-9]{6,12}$`',
    `remittance_period_end_date` DATE COMMENT 'Last day of the period for which interest was earned and is being remitted.',
    `remittance_period_start_date` DATE COMMENT 'First day of the period for which interest was earned and is being remitted.',
    `remittance_status` STRING COMMENT 'Current lifecycle status of the remittance transaction (pending, submitted, confirmed, reconciled, or disputed).. Valid values are `pending|submitted|confirmed|reconciled|disputed`',
    `reporting_quarter` STRING COMMENT 'Calendar quarter (Q1, Q2, Q3, Q4) for which this remittance is reported, if quarterly reporting is required.. Valid values are `Q1|Q2|Q3|Q4`',
    `reporting_year` STRING COMMENT 'Calendar year for which this remittance is reported to the IOLTA program and IRS.',
    CONSTRAINT pk_iolta_interest_remittance PRIMARY KEY(`iolta_interest_remittance_id`)
) COMMENT 'Records the periodic remittance of interest earned on pooled IOLTA trust accounts to the designated state IOLTA program or legal aid foundation. Captures remittance period, gross interest earned, bank service charges deducted, net remittance amount, recipient organization, remittance date, payment method, confirmation reference, and IRS Form 1099 reporting flag. Mandatory compliance record under IOLTA program rules in all US jurisdictions.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`transfer` (
    `transfer_id` BIGINT COMMENT 'Unique identifier for the trust transfer transaction. Primary key.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Trust-to-operating transfers (earned fee transfers) are high-risk and subject to specific controls (invoice verification, client authorization, proper allocation). Key control point for preventing mis',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust-to-operating transfers for earned fees require linking to the fee agreement. Real business process: earned fee transfers must reference the governing fee arrangement/engagement letter to verify ',
    `account_id` BIGINT COMMENT 'Identifier of the trust account or operating account to which funds are being transferred. Links to the account master record.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice for which earned fees are being transferred from trust to operating account. Populated only for trust-to-operating transfers representing earned fee realization.',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter to which this trust transfer relates. All trust movements must be attributable to a specific client matter for fiduciary accountability.',
    `payment_allocation_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Trust-to-operating transfers generate payment records in billing. Essential for tracing payment source, trust compliance audits, and reconciling trust drawdowns with AR applications. Legal firms must ',
    `primary_reversal_of_transfer_id` BIGINT COMMENT 'If this transfer is a reversal or correction of a prior transfer, this field contains the trust_transfer_id of the original transaction being reversed. Null for original transfers.',
    `profile_id` BIGINT COMMENT 'Identifier of the client whose funds are being transferred. Required for client fund segregation and IOLTA (Interest on Lawyers Trust Accounts) compliance.',
    `source_account_id` BIGINT COMMENT 'Identifier of the trust account from which funds are being transferred. Links to the trust account master record.',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Links the trust transfer to the ledger entry representing the debit from the source account. Every transfer generates at least two ledger entries (debit source, credit destination) for double-entry ac',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this trust transfer record. Required for segregation of duties and audit trail.',
    `transfer_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this trust transfer record. Required for audit trail and change tracking.',
    `transfer_owner_timekeeper_id` BIGINT COMMENT 'Identifier of the user (typically a partner or trust account administrator) who authorized this trust transfer. Required for segregation of duties and fiduciary accountability.',
    `transfer_reconciled_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who performed or approved the reconciliation of this transfer. Part of the audit trail for trust account governance.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary amount being transferred between accounts, expressed in the currency of the trust account. Must be positive and non-zero.',
    `authorization_reference` STRING COMMENT 'Reference number or identifier of the authorization document, approval workflow, or partner sign-off that permits this trust transfer. Required for audit trail and compliance verification.',
    `authorized_timestamp` TIMESTAMP COMMENT 'Date and time when the trust transfer was authorized by the responsible user. Part of the audit trail for trust account governance.',
    `bank_reference_number` STRING COMMENT 'The external bank transaction reference, confirmation number, or trace ID provided by the financial institution for this transfer. Used for three-way reconciliation between firm ledger, bank statement, and client ledger.',
    `check_number` STRING COMMENT 'The check number if the transfer was executed via physical or electronic check. Null for non-check payment methods.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this trust transfer record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer amount (e.g., USD, GBP, EUR). Must match the currency of the source trust account.. Valid values are `^[A-Z]{3}$`',
    `earned_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the transfer amount that represents earned legal fees being moved from trust to operating account. Null for non-fee transfers.',
    `iolta_applicable_flag` BOOLEAN COMMENT 'Indicates whether this transfer involves an IOLTA account and is subject to IOLTA reporting and interest allocation rules. True if IOLTA rules apply, false otherwise.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code representing the legal jurisdiction (state, province, or country) whose trust accounting rules govern this transfer. Required because trust account regulations vary by jurisdiction.. Valid values are `^[A-Z]{2,3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this trust transfer record was last modified. Part of the audit trail for data lineage and compliance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the trust transfer. Used for internal documentation and audit trail.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to execute the trust transfer: wire transfer, ACH (Automated Clearing House), check, internal journal entry (for intra-bank movements), or electronic funds transfer.. Valid values are `wire_transfer|ach|check|internal_journal|electronic_funds_transfer`',
    `reason` STRING COMMENT 'Business justification or narrative explanation for the trust transfer, such as Earned fees per invoice INV-2024-001, Client disbursement for settlement, or Inter-trust reallocation per matter closure. Required for audit and client communication.',
    `reconciliation_date` DATE COMMENT 'The date on which this transfer was successfully reconciled across firm ledger, bank statement, and client ledger. Null if not yet reconciled.',
    `reconciliation_status` STRING COMMENT 'Status of this transfer in the three-way reconciliation process (firm ledger, bank statement, client ledger): unreconciled (not yet matched), reconciled (matched across all three), exception (discrepancy identified), or pending_review (awaiting manual verification).. Valid values are `unreconciled|reconciled|exception|pending_review`',
    `transfer_date` DATE COMMENT 'The business date on which the trust transfer was executed or is scheduled to be executed. This is the effective date for trust ledger posting and three-way reconciliation purposes.',
    `transfer_number` STRING COMMENT 'Externally-visible business identifier for the trust transfer, formatted as TT-YYYYMMDD-NNNN for audit trail and reference purposes.. Valid values are `^TT-[0-9]{8}-[0-9]{4}$`',
    `transfer_status` STRING COMMENT 'Current lifecycle state of the trust transfer: draft (being prepared), pending_approval (awaiting authorization), approved (authorized but not yet executed), in_transit (processing), completed (successfully executed), failed (execution error), reversed (unwound), or cancelled (voided before execution). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_transit|completed|failed|reversed|cancelled — 8 candidates stripped; promote to reference product]',
    `transfer_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trust transfer transaction was executed in the system, used for audit trail and chronological sequencing.',
    `transfer_type` STRING COMMENT 'Classification of the trust transfer movement: inter-trust (between client trust accounts), trust-to-operating (earned fees transferred to firm operating account), operating-to-trust (replenishment or correction), trust-to-client (disbursement to client), client-to-trust (initial deposit), or trust-refund (return of unearned funds).. Valid values are `inter_trust|trust_to_operating|operating_to_trust|trust_to_client|client_to_trust|trust_refund`',
    CONSTRAINT pk_transfer PRIMARY KEY(`transfer_id`)
) COMMENT 'Records the movement of client funds between trust accounts or between a trust account and the firms operating account upon fee earning. Captures transfer type (inter-trust, trust-to-operating, operating-to-trust top-up), source account, destination account, transfer amount, matter reference, transfer date, authorization reference, and the earned fee invoice linkage when transferring earned fees to operating. Ensures complete audit trail for all inter-account fund movements.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` (
    `retainer_agreement_id` BIGINT COMMENT 'Unique identifier for the retainer agreement record. Primary key. Role: MASTER_AGREEMENT.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this retainer agreement record.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Retainer agreements are drafted from approved precedent templates (evergreen retainers, matter-specific retainers, security retainers). Ensures consistent terms, regulatory compliance, and risk manage',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner or timekeeper responsible for managing this retainer agreement and authorizing disbursements.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Retainer handling is subject to specific compliance controls (client authorization, replenishment thresholds, interest treatment). Controls test retainer agreements for proper documentation and client',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Retainer agreements ARE contracts/agreements. Real business process: retainer terms are documented in engagement letters (master agreements). This creates a typed relationship where retainer_agreement',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Retainer agreements involve processing client personal data (names, addresses, financial information) requiring GDPR/privacy compliance. Processing activity registration. Links agreement to privacy re',
    `intake_fee_arrangement_id` BIGINT COMMENT 'Reference to the associated fee arrangement or billing guideline that governs how retainer funds are drawn down against work performed.',
    `matter_id` BIGINT COMMENT 'Reference to the matter or engagement scope covered by this retainer agreement. May be null for client-level retainers not tied to a specific matter.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Retainer agreements are inherently tied to the practice area under which services will be delivered (litigation retainer, corporate advisory retainer, IP prosecution retainer). Critical for retainer u',
    `account_id` BIGINT COMMENT 'Reference to the specific trust account (IOLTA or client trust account) in which the retainer funds are held.',
    `profile_id` BIGINT COMMENT 'Reference to the client who entered into this retainer agreement.',
    `retainer_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Retainer agreement governs funds held in a specific trust account. Required for replenishment threshold monitoring.',
    `retainer_last_modified_by_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this retainer agreement record.',
    `agreed_retainer_amount` DECIMAL(18,2) COMMENT 'The total retainer amount agreed upon in the retainer agreement, representing the initial or target balance to be held in trust.',
    `auto_replenishment_enabled` BOOLEAN COMMENT 'Indicates whether automatic replenishment is enabled for this retainer agreement. True for evergreen retainers with automatic replenishment; false otherwise.',
    `client_authorization_reference` STRING COMMENT 'Reference to the client authorization document or engagement letter that governs this retainer arrangement (e.g., LOE number, signed agreement reference).',
    `compliance_review_date` DATE COMMENT 'The date of the most recent compliance review of this retainer agreement against IOLTA rules and jurisdiction-specific trust accounting regulations.',
    `compliance_status` STRING COMMENT 'The compliance status of this retainer agreement as determined by the most recent trust accounting audit or compliance review.. Valid values are `compliant|under_review|non_compliant|remediated`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this retainer agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the retainer amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current available balance of the retainer as of the last trust ledger reconciliation. This is a snapshot value updated by trust accounting processes.',
    `effective_date` DATE COMMENT 'The date on which the retainer agreement becomes binding and the retainer funds are expected to be deposited into the trust account.',
    `expiry_date` DATE COMMENT 'The date on which the retainer agreement expires or terminates. Null for open-ended retainer agreements.',
    `initial_deposit_date` DATE COMMENT 'The date on which the initial retainer deposit was received and posted to the trust account.',
    `interest_bearing` BOOLEAN COMMENT 'Indicates whether the retainer funds are held in an interest-bearing trust account (IOLTA) or a non-interest-bearing account, per jurisdiction-specific trust accounting rules.',
    `jurisdiction_code` STRING COMMENT 'The legal jurisdiction governing this retainer agreement and trust account compliance (e.g., state bar association code, country code).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this retainer agreement record was last modified.',
    `last_replenishment_date` DATE COMMENT 'The date of the most recent retainer replenishment deposit. Null if no replenishments have occurred.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special instructions, client requests, or internal comments related to this retainer agreement.',
    `refund_due_amount` DECIMAL(18,2) COMMENT 'The amount due to be refunded to the client upon termination or conclusion of the retainer agreement, representing unused retainer funds.',
    `refund_processed_date` DATE COMMENT 'The date on which any refund of unused retainer funds was processed and returned to the client. Null if no refund has been processed.',
    `replenishment_amount` DECIMAL(18,2) COMMENT 'The amount to be deposited when the retainer balance falls below the replenishment threshold (applicable to evergreen retainers). Null for non-evergreen retainers.',
    `replenishment_threshold_amount` DECIMAL(18,2) COMMENT 'The minimum balance threshold below which the retainer must be replenished (applicable to evergreen retainers). Null for non-evergreen retainers.',
    `retainer_agreement_status` STRING COMMENT 'Current lifecycle status of the retainer agreement: draft (not yet executed), active (in force and available for draw), suspended (temporarily inactive), depleted (balance exhausted), expired (past end date), terminated (closed by client or firm).. Valid values are `draft|active|suspended|depleted|expired|terminated`',
    `retainer_description` STRING COMMENT 'Detailed description of the retainer agreement, including the scope of work covered, any special terms, and client-specific arrangements.',
    `retainer_type` STRING COMMENT 'Classification of the retainer arrangement: evergreen (automatically replenished), fixed (one-time deposit), security deposit (held until matter conclusion), advance payment (drawn down as work is performed), or engagement-specific (tied to a single matter).. Valid values are `evergreen|fixed|security_deposit|advance_payment|engagement_specific`',
    `termination_date` DATE COMMENT 'The actual date on which the retainer agreement was terminated, either by client request, matter conclusion, or firm decision. Null if still active.',
    `termination_reason` STRING COMMENT 'The reason for termination of the retainer agreement: matter concluded, client request, firm decision, funds depleted, breach of terms, or other.. Valid values are `matter_concluded|client_request|firm_decision|funds_depleted|breach_of_terms|other`',
    `total_deposits` DECIMAL(18,2) COMMENT 'The cumulative total of all deposits made to this retainer agreement since inception, including initial deposit and all replenishments.',
    `total_disbursements` DECIMAL(18,2) COMMENT 'The cumulative total of all disbursements drawn from this retainer agreement since inception, representing work performed and billed against the retainer.',
    CONSTRAINT pk_retainer_agreement PRIMARY KEY(`retainer_agreement_id`)
) COMMENT 'Master record for each client retainer arrangement governing the deposit and replenishment of advance funds held in trust. Captures retainer type (evergreen, fixed, security deposit), agreed retainer amount, replenishment threshold, replenishment amount, matter scope, effective date, expiry date, client authorization reference, and current retainer status. Distinct from the billing domains engagement letter — this record governs the fiduciary fund-holding obligation.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`retainer_replenishment` (
    `retainer_replenishment_id` BIGINT COMMENT 'Unique identifier for the retainer replenishment transaction. Primary key for this product.',
    `matter_id` BIGINT COMMENT 'Reference to the specific matter for which the retainer replenishment is required.',
    `retainer_agreement_id` BIGINT COMMENT 'FK to trust.retainer_agreement.retainer_agreement_id — Each replenishment event is triggered by and governed by a specific retainer agreements threshold rules.',
    `profile_id` BIGINT COMMENT 'Reference to the client whose retainer is being replenished.',
    `receipt_id` BIGINT COMMENT 'Foreign key linking to trust.trust_receipt. Business justification: Links the retainer replenishment request to the actual receipt of funds when the client pays. A replenishment request is a workflow/notification event; the receipt is the actual transaction. Cardinali',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (partner or attorney) responsible for managing the client relationship and retainer replenishment process.',
    `retainer_id` BIGINT COMMENT 'Reference to the parent retainer agreement that this replenishment event is associated with.',
    `to_retainer_agreement_id` BIGINT COMMENT 'FK to trust.retainer_agreement.retainer_agreement_id — Each replenishment event is triggered by and references a specific retainer agreement. Without this link, replenishment records cannot be associated with their governing agreement.',
    `actual_receipt_date` DATE COMMENT 'The date on which the replenishment funds were actually received and posted to the client trust account.',
    `balance_at_trigger` DECIMAL(18,2) COMMENT 'The trust account balance at the moment the replenishment threshold was breached, expressed in the retainer currency.',
    `client_response_date` DATE COMMENT 'The date on which the client acknowledged or responded to the replenishment request.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this replenishment transaction.. Valid values are `^[A-Z]{3}$`',
    `days_overdue` STRING COMMENT 'Number of calendar days the replenishment has been outstanding beyond the expected receipt date.',
    `expected_receipt_date` DATE COMMENT 'The date by which the client committed to provide the replenishment funds, based on client communication or payment terms.',
    `follow_up_count` STRING COMMENT 'Number of follow-up communications sent to the client regarding this replenishment request.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code identifying the legal jurisdiction whose trust accounting rules govern this retainer replenishment.. Valid values are `^[A-Z]{2,3}$`',
    `last_follow_up_date` DATE COMMENT 'The date of the most recent follow-up communication sent to the client regarding this replenishment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment record was most recently updated.',
    `notes` STRING COMMENT 'Free-text field for recording additional context, client communications, special circumstances, or internal notes related to this replenishment event.',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the replenishment request has exceeded the expected receipt date without being fulfilled.',
    `replenishment_request_number` STRING COMMENT 'Business-facing unique identifier for the replenishment request, used in client communications and internal tracking.',
    `replenishment_status` STRING COMMENT 'Current lifecycle status of the replenishment request, tracking progress from initial request through final resolution. [ENUM-REF-CANDIDATE: requested|acknowledged|received|partially_received|overdue|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `replenishment_threshold` DECIMAL(18,2) COMMENT 'The minimum balance threshold defined in the retainer agreement that, when breached, triggers a replenishment request.',
    `request_sent_date` DATE COMMENT 'The date on which the replenishment request was formally communicated to the client.',
    `request_sent_method` STRING COMMENT 'The communication channel used to send the replenishment request to the client.. Valid values are `email|mail|portal|phone|fax|in_person`',
    `required_replenishment_amount` DECIMAL(18,2) COMMENT 'The amount requested from the client to restore the retainer balance to the agreed target level.',
    `target_balance_after_replenishment` DECIMAL(18,2) COMMENT 'The intended trust account balance after the replenishment is received, as defined in the retainer agreement.',
    `trigger_date` DATE COMMENT 'The date on which the retainer balance fell below the replenishment threshold, triggering this replenishment event.',
    `trigger_timestamp` TIMESTAMP COMMENT 'The precise date and time when the retainer balance threshold breach was detected by the system.',
    `trust_account_number` STRING COMMENT 'The specific IOLTA or client trust account number into which the replenishment funds are to be deposited.',
    `waiver_approval_date` DATE COMMENT 'The date on which the replenishment waiver was formally approved by authorized personnel.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the partner or authorized personnel who approved the replenishment waiver.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving the replenishment requirement, documented when the firm decides not to pursue the replenishment.',
    `wip_exposure_at_trigger` DECIMAL(18,2) COMMENT 'The total unbilled work in progress amount for the matter at the time the replenishment was triggered, indicating the firms financial exposure.',
    CONSTRAINT pk_retainer_replenishment PRIMARY KEY(`retainer_replenishment_id`)
) COMMENT 'Transactional record of each request or event triggering a client retainer top-up when the trust balance falls below the agreed replenishment threshold. Captures trigger date, current balance at trigger, required replenishment amount, replenishment request sent date, client response date, receipt date, and status (requested, received, overdue, waived). Supports proactive retainer management and WIP exposure monitoring.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` (
    `escrow_arrangement_id` BIGINT COMMENT 'Unique identifier for the escrow arrangement record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or timekeeper responsible for administering and overseeing this escrow arrangement.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Escrow arrangements require compliance controls for release condition verification, dual authorization, and dispute resolution. High-risk activity subject to control testing. Links arrangement to spec',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Escrow arrangements in legal services are typically tied to specific contracts (M&A escrows, settlement escrows, real estate transaction escrows). This FK links the escrow to the underlying contract. ',
    `account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each escrow arrangement is held within a specific trust account. Required for fund segregation and balance tracking.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or transaction (M&A, SPA, real estate closing) for which this escrow arrangement was established.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Escrow arrangements are practice-specific (real estate closings, M&A transactions, IP licensing, litigation settlements) and require practice area tracking for regulatory compliance, conflict manageme',
    `primary_account_id` BIGINT COMMENT 'Reference to the underlying trust bank account holding the escrowed funds, subject to IOLTA regulations.',
    `profile_id` BIGINT COMMENT 'Reference to the client on whose behalf the escrow arrangement is established.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for all deposits, releases, and balance changes within this escrow arrangement.',
    `beneficiary_party_name` STRING COMMENT 'Name of the party or entity entitled to receive funds upon satisfaction of release conditions (e.g., seller, indemnified party).',
    `beneficiary_party_role` STRING COMMENT 'Role of the beneficiary party in the underlying transaction.. Valid values are `Buyer|Seller|Borrower|Lender|Shareholder|Other`',
    `closure_date` DATE COMMENT 'Date on which the escrow arrangement was formally closed after all funds were released or returned and all obligations satisfied.',
    `closure_reason` STRING COMMENT 'Reason for closing the escrow arrangement, documenting the final disposition of the escrow.. Valid values are `Conditions Satisfied|Agreement Terminated|Funds Fully Released|Dispute Resolved|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this escrow arrangement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the escrowed funds (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Current remaining balance held in escrow after any partial releases or disbursements. Updated with each release event.',
    `depositor_party_name` STRING COMMENT 'Name of the party or entity that deposited funds into escrow (e.g., buyer, seller, borrower).',
    `depositor_party_role` STRING COMMENT 'Role of the depositor party in the underlying transaction.. Valid values are `Buyer|Seller|Borrower|Lender|Shareholder|Other`',
    `dispute_description` STRING COMMENT 'Detailed description of any active dispute affecting the escrow, including parties involved, nature of disagreement, and current resolution status.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the escrow arrangement is currently subject to a dispute regarding release conditions, beneficiary entitlement, or fund allocation.',
    `escrow_agent_name` STRING COMMENT 'Name of the law firm, attorney, or third-party institution acting as escrow agent and fiduciary holder of the funds.',
    `escrow_agreement_reference` STRING COMMENT 'Document reference or identifier for the governing escrow agreement that defines terms, conditions, and release triggers.',
    `escrow_amount` DECIMAL(18,2) COMMENT 'Total monetary amount held in escrow at establishment, representing the initial deposit or holdback amount.',
    `escrow_period_end_date` DATE COMMENT 'Scheduled end date of the escrow holding period, after which remaining funds may be released per agreement terms or extended by mutual consent.',
    `escrow_period_start_date` DATE COMMENT 'Start date of the escrow holding period as defined in the escrow agreement, from which release conditions and timelines are measured.',
    `escrow_purpose` STRING COMMENT 'Detailed description of the business purpose for which the escrow was established (e.g., M&A purchase price holdback, indemnity reserve, real estate deposit, earnout payment reserve).',
    `escrow_status` STRING COMMENT 'Current lifecycle status of the escrow arrangement indicating its operational state and release progress.. Valid values are `Active|Pending Release|Partially Released|Fully Released|Closed|Disputed`',
    `establishment_date` DATE COMMENT 'Date on which the escrow arrangement was formally established and funds were initially deposited into escrow.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the escrow agreement and fund administration (e.g., State of Delaware, England and Wales).',
    `interest_allocation_method` STRING COMMENT 'Method by which accrued interest on escrowed funds is allocated, in compliance with IOLTA regulations and escrow agreement.. Valid values are `To Client|To IOLTA Fund|Pro Rata to Parties|Per Agreement|Not Applicable`',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether the escrow account accrues interest on deposited funds, subject to IOLTA rules and escrow agreement terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this escrow arrangement record was last updated, reflecting the most recent change to any field.',
    `last_release_date` DATE COMMENT 'Date of the most recent release or disbursement event from this escrow arrangement.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special instructions, or administrative details relevant to the escrow arrangement.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this escrow arrangement requires specific regulatory reporting to bar associations, IOLTA authorities, or other governing bodies.',
    `release_conditions` STRING COMMENT 'Detailed description of the conditions, milestones, or events that must be satisfied before funds can be released from escrow (e.g., completion of due diligence, satisfaction of indemnity claims, passage of time).',
    `release_schedule_type` STRING COMMENT 'Classification of the release mechanism governing how and when escrowed funds are disbursed.. Valid values are `Single Release|Milestone-Based|Time-Based|Claim-Driven|Hybrid`',
    `total_released_amount` DECIMAL(18,2) COMMENT 'Cumulative total amount released from escrow to date across all release events. Calculated field maintained for reporting and reconciliation.',
    `transaction_type` STRING COMMENT 'Classification of the underlying transaction for which the escrow was established.. Valid values are `M&A|SPA|Real Estate Closing|Earnout|Indemnity Reserve|Other`',
    CONSTRAINT pk_escrow_arrangement PRIMARY KEY(`escrow_arrangement_id`)
) COMMENT 'Master record for escrow accounts established in connection with corporate transactions (M&A, SPA, real estate closings) where the firm acts as escrow agent holding funds pending satisfaction of conditions. Captures escrow purpose, transaction reference, escrow amount, release conditions, release schedule, escrow period start and end dates, counterparty identities, governing escrow agreement reference, and current escrow status. Release events (modeled as detail records within this product) capture: release date, release amount, beneficiary identity, release condition satisfied (description and evidence reference), authorizing parties, payment method, and residual escrow balance post-release. Operationally distinct from general retainer trust accounts. Provides the complete transactional audit trail for escrow fund deposits and distributions.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`escrow_release` (
    `escrow_release_id` BIGINT COMMENT 'Unique identifier for the escrow release transaction. Primary key for the escrow release record.',
    `escrow_arrangement_id` BIGINT COMMENT 'Reference to the escrow account from which funds are being released. Links to the escrow account master record.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Escrow releases may settle invoices in transaction-based legal matters (M&A, real estate closings). Required for tracking which invoices are paid from escrow, transaction accounting, and client billin',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this escrow release. Typically an M&A transaction, corporate transaction, or litigation settlement matter.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who authorized the escrow release. Must be a qualified signatory per the escrow agreement and trust account rules.',
    `profile_id` BIGINT COMMENT 'Reference to the client on whose behalf the escrow funds are held and released.',
    `trust_disbursement_id` BIGINT COMMENT 'Foreign key linking to trust.trust_disbursement. Business justification: Links the escrow release event (business/legal milestone) to the actual disbursement transaction that executes the payment. An escrow release is a specialized type of disbursement with additional escr',
    `aml_review_date` DATE COMMENT 'The date on which AML compliance review was completed for this escrow release.',
    `aml_review_status` STRING COMMENT 'Status of AML compliance review for this escrow release. Large releases or releases to high-risk jurisdictions require AML clearance.. Valid values are `not_required|pending|cleared|flagged`',
    `approval_date` DATE COMMENT 'The date on which the escrow release was formally approved by the authorizing attorney(s).',
    `beneficiary_account_number` STRING COMMENT 'Bank account number or payment account identifier for the beneficiary receiving the escrow release.',
    `beneficiary_bank_code` STRING COMMENT 'Bank identifier code (BIC/SWIFT code or routing number) for the beneficiary financial institution.',
    `beneficiary_bank_name` STRING COMMENT 'Name of the financial institution where the beneficiary account is held.',
    `beneficiary_name` STRING COMMENT 'Full legal name of the party receiving the escrow release. May be an individual or organization.',
    `beneficiary_type` STRING COMMENT 'Classification of the beneficiary receiving the escrow release (individual, organization, government entity, trust, estate, or other).. Valid values are `individual|organization|government_entity|trust|estate|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the escrow release record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the release amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `escrow_agreement_reference` STRING COMMENT 'Reference to the escrow agreement document governing this release (e.g., document ID in DMS, agreement number).',
    `evidence_reference` STRING COMMENT 'Reference to the document or evidence demonstrating satisfaction of the release condition (e.g., document ID in DMS, closing certificate reference, regulatory approval letter reference).',
    `execution_date` DATE COMMENT 'The date on which the escrow release payment was executed and funds left the escrow account.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code representing the legal jurisdiction governing this escrow release (e.g., US state code, country code). Determines applicable trust accounting rules.. Valid values are `^[A-Z]{2,3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the escrow release record was last modified. Used for audit trail and change tracking.',
    `net_release_amount` DECIMAL(18,2) COMMENT 'Net amount disbursed to the beneficiary after deducting any tax withholding or fees. Equals release_amount minus tax_withholding_amount.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the escrow release, including any special instructions, conditions, or contextual information.',
    `post_release_escrow_balance` DECIMAL(18,2) COMMENT 'The residual balance remaining in the escrow account after this release was executed. Used for three-way reconciliation.',
    `pre_release_escrow_balance` DECIMAL(18,2) COMMENT 'The total balance in the escrow account immediately before this release was executed.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this escrow release must be reported to regulatory authorities (e.g., IOLTA reporting, AML reporting for large transactions).',
    `release_amount` DECIMAL(18,2) COMMENT 'The monetary amount released from escrow to the beneficiary. Represents the gross disbursement before any fees or adjustments.',
    `release_condition_description` STRING COMMENT 'Detailed description of the escrow release condition that was satisfied, triggering the release (e.g., closing of M&A transaction, satisfaction of regulatory approval, completion of due diligence milestone).',
    `release_condition_satisfied_date` DATE COMMENT 'The date on which the escrow release condition was satisfied, making the funds eligible for release.',
    `release_date` DATE COMMENT 'The date on which the escrow funds were released to the beneficiary. Represents the business event date of the release.',
    `release_number` STRING COMMENT 'Business-facing unique identifier for the escrow release transaction. Used in client communications and audit trails.',
    `release_purpose` STRING COMMENT 'Business purpose or reason for the escrow release (e.g., M&A closing payment, indemnity claim settlement, milestone payment, dispute resolution settlement).',
    `release_status` STRING COMMENT 'Current lifecycle status of the escrow release transaction (pending authorization, approved, executed/completed, cancelled, failed, or reversed).. Valid values are `pending|approved|executed|cancelled|failed|reversed`',
    `release_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the escrow release was executed and funds were disbursed. Used for audit trail and reconciliation.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the escrow release for tax purposes, if applicable (e.g., withholding tax on cross-border payments).',
    `tax_withholding_jurisdiction` STRING COMMENT 'Jurisdiction code for the tax authority requiring withholding on this escrow release.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_escrow_release PRIMARY KEY(`escrow_release_id`)
) COMMENT 'Records each release of escrowed funds to a designated beneficiary upon satisfaction of escrow release conditions. Captures release date, release amount, beneficiary identity, release condition satisfied (description and evidence reference), authorizing parties, payment method, and residual escrow balance post-release. Provides the transactional audit trail for escrow fund distributions in M&A and transactional matters.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`regulatory_report` (
    `regulatory_report_id` BIGINT COMMENT 'Unique identifier for the trust regulatory report. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the trust account covered by this regulatory report.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Regulatory reports are reviewed during audit engagements for accuracy, completeness, and timeliness. Audit scope item. Auditors test report preparation controls and data accuracy. Links report to enga',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_asset. Business justification: Regulatory reports (IOLTA filings, bar association reports) are stored as knowledge assets for compliance reference, audit trails, and template reuse across reporting periods. Standard practice in leg',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or compliance officer who prepared the regulatory report.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each regulatory report fulfills a specific obligation (IOLTA annual report, SRA accountants report). Direct compliance mapping from report to obligation being satisfied. Enables tracking of obligatio',
    `regulatory_return_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_return. Business justification: Trust-specific regulatory reports (IOLTA annual reports, SRA accountants reports, client money reports) are types of regulatory returns. Specialization relationship where trust report is a specific i',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or attorney who submitted the report to the regulatory body.',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory body acknowledged receipt of the report.',
    `acknowledgment_reference_number` STRING COMMENT 'Reference number or confirmation code issued by the regulatory body upon receipt or acknowledgment of the report.',
    `audit_report_reference` STRING COMMENT 'Reference number or identifier of the external audit report accompanying this regulatory submission, if applicable.',
    `certification_date` DATE COMMENT 'Date on which the certifying attorney signed and certified the report.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the report includes a formal compliance certification by a responsible attorney or accountant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory report record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the reported trust balances.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discrepancy identified during reconciliation, if applicable.',
    `discrepancy_explanation` STRING COMMENT 'Detailed explanation of any discrepancies or irregularities identified in the trust account reconciliation.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the report must be submitted to remain in compliance.',
    `external_auditor_name` STRING COMMENT 'Name of the external auditor or accounting firm that reviewed or audited the trust account records for this report, if applicable.',
    `iolta_interest_earned` DECIMAL(18,2) COMMENT 'Total interest earned on IOLTA accounts during the reporting period, if applicable.',
    `iolta_interest_remitted` DECIMAL(18,2) COMMENT 'Total interest remitted to the IOLTA program or designated beneficiary during the reporting period.',
    `is_overdue` BOOLEAN COMMENT 'Boolean flag indicating whether the report submission is past its regulatory due date.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or state/province code identifying the jurisdiction under whose rules this report is filed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory report record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the regulatory report.',
    `number_of_client_accounts` STRING COMMENT 'Count of individual client trust accounts included in this regulatory report.',
    `number_of_transactions` STRING COMMENT 'Total count of trust transactions (receipts and disbursements) during the reporting period.',
    `prepared_date` DATE COMMENT 'Date on which the regulatory report was prepared and finalized internally.',
    `query_details` STRING COMMENT 'Details of any queries or follow-up requests issued by the regulatory body in response to this report.',
    `reconciliation_status` STRING COMMENT 'Status of the three-way reconciliation (bank statement, trust ledger, client ledger) as of the report date.. Valid values are `reconciled|unreconciled|discrepancy_identified|pending_review`',
    `regulatory_body_name` STRING COMMENT 'Name of the regulatory authority or oversight body to which this report is submitted (e.g., State Bar Association, Solicitors Regulation Authority, Law Society).',
    `regulatory_query_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the regulatory body has raised queries or requested additional information regarding this report.',
    `report_format` STRING COMMENT 'File format or medium in which the report was prepared and submitted.. Valid values are `pdf|xml|csv|json|paper_form|proprietary_portal_format`',
    `report_number` STRING COMMENT 'Unique business identifier for the regulatory report, often assigned by the firm or regulatory body.',
    `report_status` STRING COMMENT 'Current lifecycle status of the regulatory report in the submission and review workflow. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|under_review|queried|accepted|rejected — 7 candidates stripped; promote to reference product]',
    `report_type` STRING COMMENT 'Classification of the regulatory report type as required by the governing jurisdiction or regulatory body.. Valid values are `annual_trust_account_certificate|sra_accounts_rules_compliance|state_bar_trust_account_registration|iolta_annual_report|quarterly_trust_reconciliation|ad_hoc_regulatory_inquiry`',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this regulatory report.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this regulatory report.',
    `response_due_date` DATE COMMENT 'Deadline by which the firm must respond to regulatory queries or provide additional information.',
    `submission_date` DATE COMMENT 'Date on which the report was officially submitted to the regulatory authority.',
    `submission_method` STRING COMMENT 'Method or channel used to submit the report to the regulatory body.. Valid values are `online_portal|email|postal_mail|electronic_filing_system|fax`',
    `total_trust_balance_reported` DECIMAL(18,2) COMMENT 'Total balance of client trust funds reported for the period, as declared in the regulatory report.',
    CONSTRAINT pk_regulatory_report PRIMARY KEY(`regulatory_report_id`)
) COMMENT 'Periodic regulatory trust account report submitted to bar associations, the SRA, state law societies, or other oversight bodies as required by jurisdiction-specific trust accounting rules. Captures reporting period, jurisdiction, report type (annual trust account certificate, SRA Accounts Rules compliance report, state bar trust account registration), submission date, submitted by, report status (draft, submitted, acknowledged, queried), and regulatory body acknowledgment reference.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`account_audit` (
    `account_audit_id` BIGINT COMMENT 'Unique identifier for the trust account audit record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the trust account being audited. Links to the specific IOLTA or client trust account subject to examination.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner or attorney responsible for overseeing the audit and ensuring remediation completion.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Trust account audits are often part of broader compliance audit engagements covering multiple control domains. Hierarchical relationship where trust audit is a component of overall engagement scope. E',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Audit procedures follow standardized methodologies documented as precedents (audit programs, testing procedures, sampling frameworks). Auditors reference these precedents to ensure consistent, complia',
    `control_framework_id` BIGINT COMMENT 'Foreign key linking to compliance.control_framework. Business justification: Trust audits test controls within specific frameworks (SRA Accounts Rules, ABA Model Rules, state bar rules). Framework scope defines audit procedures and control objectives. Links audit to framework ',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: Audit findings revealing trust account deficiencies may later become PI claims. Linking audit to exposure supports claims defense by documenting when issues were identified and remediation attempts ma',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Audit findings (control deficiencies, material weaknesses) inform indemnity policy risk assessment and premium calculations. Underwriting input. Insurers require audit reports for policy renewal. Link',
    `legal_document_id` BIGINT COMMENT 'Reference to the final audit report document stored in the document management system (DMS). Links to iManage Work or NetDocuments.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Audit findings (material deficiencies, control weaknesses) represent identified risks requiring formal tracking. Audit deficiencies trigger risk register entries per ISO 27001 and SRA compliance requi',
    `timekeeper_id` BIGINT COMMENT 'Reference to the internal compliance officer who coordinated the audit and is responsible for tracking remediation.',
    `audit_cost` DECIMAL(18,2) COMMENT 'Total cost of the audit engagement, including auditor fees, travel expenses, and internal resource costs. Tracked for budgeting and cost management.',
    `audit_methodology` STRING COMMENT 'Primary audit methodology employed: risk-based, substantive testing, controls testing, analytical review, full population review, or sampling approach.. Valid values are `risk_based|substantive_testing|controls_testing|analytical_review|full_population_review|sampling`',
    `audit_number` STRING COMMENT 'Externally-known unique identifier for this audit engagement, assigned by the auditor or compliance department.',
    `audit_period_end_date` DATE COMMENT 'Ending date of the period under audit examination. Defines the temporal scope of transactions and balances reviewed.',
    `audit_period_start_date` DATE COMMENT 'Beginning date of the period under audit examination. Defines the temporal scope of transactions and balances reviewed.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including specific accounts, transaction types, controls, and compliance areas examined. May reference specific IOLTA rules, three-way reconciliation procedures, or segregation requirements.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled, in progress, fieldwork complete, draft report, final report issued, closed, or remediation pending. [ENUM-REF-CANDIDATE: scheduled|in_progress|fieldwork_complete|draft_report|final_report_issued|closed|remediation_pending — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit engagement: bar association spot examination, annual external accountant review (required in many jurisdictions), internal compliance audit, regulatory examination, three-way reconciliation audit, or IOLTA compliance review.. Valid values are `bar_association_spot_examination|annual_external_review|internal_compliance_audit|regulatory_examination|three_way_reconciliation_audit|iolta_compliance_review`',
    `auditor_contact_email` STRING COMMENT 'Primary email address for the lead auditor or audit firm contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `auditor_contact_phone` STRING COMMENT 'Primary phone number for the lead auditor or audit firm contact.',
    `auditor_license_number` STRING COMMENT 'Professional license or registration number of the auditor or audit firm. For CPAs, this is the state board license number.',
    `auditor_name` STRING COMMENT 'Full name of the individual auditor or audit firm conducting the examination. For external audits, this is the CPA firm name; for internal audits, the compliance officer name.',
    `auditor_type` STRING COMMENT 'Classification of the auditor conducting the examination: internal compliance officer, external CPA firm, bar association examiner, regulatory authority, or independent consultant.. Valid values are `internal_compliance_officer|external_cpa_firm|bar_association_examiner|regulatory_authority|independent_consultant`',
    `closure_date` DATE COMMENT 'Date when the audit engagement was formally closed, including completion of all remediation and follow-up activities.',
    `commencement_date` DATE COMMENT 'Actual date when audit fieldwork began. Marks the start of the examination process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system. Audit trail for data governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for audit cost. Typically USD for US-based legal practices.. Valid values are `^[A-Z]{3}$`',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies or exceptions identified during the audit. Includes both material and non-material findings.',
    `fieldwork_completion_date` DATE COMMENT 'Date when on-site or remote audit fieldwork was completed. Marks the end of evidence gathering.',
    `findings_summary` STRING COMMENT 'High-level summary of audit findings, including key observations, deficiencies identified, and areas of non-compliance. Detailed findings are typically stored in a separate findings detail table.',
    `follow_up_audit_date` DATE COMMENT 'Scheduled or actual date of the follow-up audit to verify remediation completion.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify remediation of identified deficiencies. True if re-examination is mandated.',
    `jurisdiction_code` STRING COMMENT 'State or jurisdiction code whose trust account regulations govern this audit. Trust account rules vary significantly by jurisdiction.',
    `material_deficiency_count` STRING COMMENT 'Number of material deficiencies identified that represent significant compliance risks or control weaknesses requiring immediate remediation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last modified. Audit trail for data governance and change tracking.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special circumstances, or follow-up actions related to the audit. May include auditor observations not included in the formal report.',
    `overall_audit_result` STRING COMMENT 'Summary conclusion of the audit: pass, pass with observations, fail, qualified opinion, adverse opinion, or disclaimer. Reflects the auditors overall assessment of trust account compliance.. Valid values are `pass|pass_with_observations|fail|qualified_opinion|adverse_opinion|disclaimer`',
    `regulatory_framework` STRING COMMENT 'Specific regulatory framework or rule set applied during the audit, such as ABA Model Rule 1.15, state-specific IOLTA rules, or bar association trust account guidelines.',
    `regulatory_notification_date` DATE COMMENT 'Date when audit findings were formally reported to the regulatory authority.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether audit findings must be reported to the state bar association or other regulatory authority. True if mandatory reporting is triggered by material deficiencies.',
    `remediation_completion_date` DATE COMMENT 'Date when all required remediation actions were completed and verified by the auditor or compliance officer.',
    `remediation_deadline` DATE COMMENT 'Date by which all remediation actions must be completed. Set by the auditor or regulatory authority based on the severity of findings.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether formal remediation actions are required as a result of audit findings. True if corrective action plan is mandatory.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts: not required, pending, in progress, completed, verified, or overdue.. Valid values are `not_required|pending|in_progress|completed|verified|overdue`',
    `report_issued_date` DATE COMMENT 'Date when the final audit report was formally issued to management or the regulatory body.',
    `sample_size` STRING COMMENT 'Number of transactions or records sampled during the audit. Null if full population review was conducted.',
    `scheduled_date` DATE COMMENT 'Date when the audit was originally scheduled to commence. Used for planning and compliance tracking.',
    CONSTRAINT pk_account_audit PRIMARY KEY(`account_audit_id`)
) COMMENT 'Record of internal or external audits conducted on trust accounts including bar association spot examinations, annual external accountant reviews (required in many jurisdictions), and internal compliance audits. Captures audit type, audit period, auditor identity (internal compliance officer or external CPA firm), audit scope, findings summary, deficiency count, remediation required flag, remediation deadline, and audit closure date. Supports regulatory examination readiness.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`trust_exception` (
    `trust_exception_id` BIGINT COMMENT 'Unique identifier for the trust exception record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Trust exceptions identified during audits (unreconciled items, authorization failures, negative balances) become audit findings requiring management response and remediation. Direct audit trail from e',
    `account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each exception is identified within the context of a specific trust account. Required for exception investigation and resolution tracking.',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Material trust exceptions (misappropriation, unauthorized disbursements, reconciliation failures causing client loss) may trigger professional indemnity claims. Risk escalation path from operational e',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with the exception, if applicable.',
    `previous_exception_trust_exception_id` BIGINT COMMENT 'Reference to the prior trust exception record if this is a recurrence.',
    `primary_account_id` BIGINT COMMENT 'Reference to the trust account where the exception was detected.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the attorney, compliance officer, or trust accountant assigned to investigate and resolve the exception.',
    `profile_id` BIGINT COMMENT 'Reference to the client whose trust funds are affected by the exception.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Trust exceptions (negative balances, AML screening failures, reconciliation discrepancies) are operational risks requiring formal tracking. Quarterly risk reporting aggregates trust exceptions as cont',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Trust exceptions that violate regulatory rules (negative balances, unauthorized disbursements, reconciliation failures) escalate to regulatory breaches requiring notification and remediation. Direct e',
    `ledger_entry_id` BIGINT COMMENT 'Reference to the specific trust ledger entry, receipt, or disbursement that triggered the exception, if applicable.',
    `aml_risk_score` STRING COMMENT 'Numeric risk score assigned by AML screening system, typically 0-100 with higher scores indicating greater risk.',
    `aml_screening_result` STRING COMMENT 'Result of AML screening if the exception involves suspicious activity: clear (no sanctions or PEP match), potential_match (requires manual review), confirmed_match (positive match to sanctions list), not_screened (AML screening not applicable).. Valid values are `clear|potential_match|confirmed_match|not_screened`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the exception (e.g., negative balance amount, unidentified receipt amount, stale disbursement value).',
    `assignment_date` DATE COMMENT 'Date when the exception was assigned to an investigator.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the exception record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the exception amount.. Valid values are `^[A-Z]{3}$`',
    `detection_date` DATE COMMENT 'Date when the exception was first identified by automated controls or manual review.',
    `detection_method` STRING COMMENT 'Method by which the exception was identified: automated_rule (system control triggered), manual_review (discovered during manual inspection), reconciliation_process (found during three-way reconciliation), aml_screening (flagged by AML system), external_audit (identified by external auditor), client_inquiry (raised by client question).. Valid values are `automated_rule|manual_review|reconciliation_process|aml_screening|external_audit|client_inquiry`',
    `detection_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exception was detected, including time zone information.',
    `escalation_date` DATE COMMENT 'Date when the exception was escalated beyond the initial investigator.',
    `escalation_level` STRING COMMENT 'Indicates the highest level to which the exception has been escalated for review or decision-making.. Valid values are `none|supervisor|compliance_officer|general_counsel|external_regulator`',
    `escalation_reason` STRING COMMENT 'Explanation of why the exception required escalation (e.g., high dollar value, potential regulatory breach, client complaint, repeat occurrence).',
    `exception_category` STRING COMMENT 'High-level categorization of the exception for reporting and workflow routing purposes.. Valid values are `operational|compliance|financial|regulatory`',
    `exception_number` STRING COMMENT 'Business-facing unique identifier for the trust exception, formatted as TE-YYYYMMDD sequence.. Valid values are `^TE-[0-9]{8}$`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception: open (newly detected, awaiting assignment), under_investigation (assigned and being investigated), pending_resolution (investigation complete, awaiting corrective action), resolved (corrective action taken), closed (resolved and verified), escalated (elevated to senior management or regulator).. Valid values are `open|under_investigation|pending_resolution|resolved|closed|escalated`',
    `exception_type` STRING COMMENT 'Classification of the trust exception: negative_balance (client balance below zero), unidentified_receipt (receipt without proper client/matter attribution), stale_disbursement (disbursement pending beyond policy threshold), missing_authorization (disbursement lacking attorney approval), reconciliation_failure (three-way reconciliation discrepancy), aml_red_flag (Anti-Money Laundering screening alert).. Valid values are `negative_balance|unidentified_receipt|stale_disbursement|missing_authorization|reconciliation_failure|aml_red_flag`',
    `external_reference_number` STRING COMMENT 'Reference number assigned by an external party (auditor, regulator, insurer) for tracking this exception.',
    `indemnity_notification_date` DATE COMMENT 'Date when the professional indemnity insurer was notified of the exception.',
    `investigation_notes` STRING COMMENT 'Detailed notes documenting the investigation process, findings, and analysis. May contain attorney work product and privileged information.',
    `investigation_start_date` DATE COMMENT 'Date when active investigation of the exception commenced.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code identifying the legal jurisdiction governing the trust account (e.g., US state code, country code).. Valid values are `^[A-Z]{2,3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the exception record was last updated.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the exception, its investigation, or resolution.',
    `professional_indemnity_notified_flag` BOOLEAN COMMENT 'Indicates whether the firms professional indemnity insurer has been notified of this exception due to potential claim risk.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this exception is a repeat occurrence of a previously resolved exception for the same account or matter.',
    `regulatory_report_date` DATE COMMENT 'Date when the exception was reported to the regulatory authority, if applicable.',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier assigned by the regulatory body upon submission of the exception report.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this exception must be reported to a regulatory body (state bar, IOLTA authority, or other governing body).',
    `resolution_action` STRING COMMENT 'Description of the corrective action taken to resolve the exception (e.g., journal entry posted, client contacted for clarification, disbursement voided, authorization obtained).',
    `resolution_date` DATE COMMENT 'Date when the corrective action was completed and the exception was resolved.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exception was marked as resolved.',
    `root_cause` STRING COMMENT 'Identified root cause of the exception after investigation (e.g., data entry error, system configuration issue, process gap, client action).',
    `severity_level` STRING COMMENT 'Risk severity of the exception: critical (immediate regulatory breach risk), high (significant compliance concern), medium (operational issue requiring attention), low (minor anomaly for review).. Valid values are `critical|high|medium|low`',
    `verification_date` DATE COMMENT 'Date when the resolution was verified and the exception was closed.',
    CONSTRAINT pk_trust_exception PRIMARY KEY(`trust_exception_id`)
) COMMENT 'Operational record of any exception, anomaly, or potential violation identified in trust account management including negative client balances, unidentified receipts, stale disbursements, missing authorizations, reconciliation failures, and AML red flags. Captures exception type, detection date, detection method (automated rule, manual review, reconciliation), severity, assigned investigator, investigation status, resolution action, and resolution date. Critical for regulatory compliance and professional indemnity risk management.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` (
    `unclaimed_funds_record_id` BIGINT COMMENT 'Unique identifier for the unclaimed funds record. Primary key for tracking client trust funds subject to escheatment under state abandoned property laws.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney responsible for the matter and trust account oversight. Accountable for escheatment compliance and client outreach.',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Unclaimed funds may be subject to data subject access requests (client requests copy of trust records). Privacy rights. Links unclaimed fund to DSR it was disclosed in for audit trail.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with the unclaimed trust funds. Links to the matter record for case context and closure details.',
    `account_id` BIGINT COMMENT 'Reference to the trust account holding the unclaimed funds. Links to the trust account master record for account details and financial institution information.',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns the unclaimed trust funds. Links to the client master record for identity and contact information.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Escheatment exposure and dormant client funds represent regulatory and reputational risk. Unclaimed funds exceeding jurisdiction thresholds trigger mandatory risk assessment and register entry per sta',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Escheatment of unclaimed funds is a specific regulatory obligation with jurisdiction-specific rules (dormancy periods, filing requirements, remittance deadlines). Direct compliance requirement. Links ',
    `source_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Unclaimed funds are held within a specific trust account and must reference it for escheatment processing.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user (attorney or compliance officer) who reviewed and approved the unclaimed funds determination and escheatment filing.',
    `client_last_known_address` STRING COMMENT 'Last known mailing address for the client. Used for outreach attempts and escheatment filing. May be outdated if client has moved.',
    `client_outreach_attempts` STRING COMMENT 'Number of documented attempts made to contact the client and return the unclaimed funds. Required due diligence before escheatment filing.',
    `client_response_received_flag` BOOLEAN COMMENT 'Indicates whether the client responded to any outreach attempts. True if client contact was successfully established.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the unclaimed funds record was first created in the system. Part of the audit trail for compliance and regulatory reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unclaimed funds amount. Typically USD for domestic trust accounts.. Valid values are `^[A-Z]{3}$`',
    `dormancy_period_days` STRING COMMENT 'Number of days elapsed since the dormancy start date. Used to determine when funds become subject to escheatment under jurisdiction-specific rules.',
    `dormancy_start_date` DATE COMMENT 'Date when the trust funds were first identified as dormant based on last client activity or matter closure. Marks the beginning of the dormancy period calculation.',
    `dormancy_status` STRING COMMENT 'Current lifecycle status of the unclaimed funds record. Tracks progression from identification through escheatment or resolution. [ENUM-REF-CANDIDATE: identified|under_review|outreach_in_progress|escheatment_pending|escheated|resolved|exempted — 7 candidates stripped; promote to reference product]',
    `escheatment_eligible_flag` BOOLEAN COMMENT 'Indicates whether the unclaimed funds have met the jurisdiction-mandated dormancy period and are eligible for escheatment filing. True when dormancy period exceeds threshold.',
    `escheatment_filing_date` DATE COMMENT 'Date when the unclaimed funds were reported to the state unclaimed property authority. Marks the formal escheatment filing submission.',
    `escheatment_filing_reference` STRING COMMENT 'Reference number or confirmation code from the state unclaimed property authority for the escheatment filing. Used for tracking and audit purposes.',
    `escheatment_threshold_days` STRING COMMENT 'Jurisdiction-mandated dormancy period (in days) after which unclaimed funds must be reported and remitted to the state. Varies by jurisdiction, typically 3-5 years.',
    `exemption_date` DATE COMMENT 'Date when the exemption from escheatment was granted or determined. Marks the point when the record was removed from escheatment processing.',
    `exemption_reason` STRING COMMENT 'Explanation for why the unclaimed funds are exempt from escheatment, if applicable. Examples include pending litigation, client contact re-established, or jurisdictional exemption.',
    `first_outreach_date` DATE COMMENT 'Date of the first documented attempt to contact the client regarding the unclaimed funds. Part of the due diligence trail required for escheatment compliance.',
    `iolta_reportable_flag` BOOLEAN COMMENT 'Indicates whether the unclaimed funds originated from an IOLTA account and require special reporting to the state IOLTA program in addition to escheatment filing.',
    `jurisdiction_code` STRING COMMENT 'State or jurisdiction code governing the escheatment rules applicable to these unclaimed funds. Determines dormancy period thresholds and reporting requirements.',
    `last_activity_date` DATE COMMENT 'Date of the last transaction, client contact, or matter activity related to these trust funds. Used to determine dormancy period eligibility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the unclaimed funds record was last updated. Tracks changes to status, outreach attempts, or escheatment filing details.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent attempt to contact the client regarding the unclaimed funds. Demonstrates ongoing due diligence efforts.',
    `outreach_method` STRING COMMENT 'Primary method used to contact the client regarding unclaimed funds. Certified mail is typically required for escheatment due diligence.. Valid values are `certified_mail|email|phone|registered_mail|in_person`',
    `regulatory_notes` STRING COMMENT 'Free-text notes documenting regulatory considerations, special circumstances, or compliance actions related to the unclaimed funds. Used for audit trail and internal reference.',
    `remittance_amount` DECIMAL(18,2) COMMENT 'Actual amount remitted to the state unclaimed property authority. May differ from unclaimed amount if interest accrued or administrative fees were deducted.',
    `remittance_confirmation_number` STRING COMMENT 'Confirmation or transaction reference number for the funds transfer to the state. Provides proof of remittance for audit and compliance purposes.',
    `remittance_date` DATE COMMENT 'Date when the unclaimed funds were physically remitted (transferred) to the state unclaimed property authority. Completes the escheatment process.',
    `resolution_date` DATE COMMENT 'Date when the unclaimed funds were successfully returned to the client or otherwise resolved without escheatment. Closes the unclaimed funds record.',
    `resolution_method` STRING COMMENT 'Method by which the unclaimed funds were resolved. Indicates the final disposition of the funds.. Valid values are `returned_to_client|escheated_to_state|transferred_to_matter|written_off|other`',
    `review_date` DATE COMMENT 'Date when the unclaimed funds record was reviewed and approved for escheatment processing. Part of the internal compliance audit trail.',
    `unclaimed_amount` DECIMAL(18,2) COMMENT 'Total amount of client trust funds that remain unclaimed and are subject to escheatment. Represents the balance at the time of dormancy determination.',
    `unclaimed_funds_number` STRING COMMENT 'Business identifier for the unclaimed funds record. Used for tracking and referencing in escheatment filings and regulatory correspondence.',
    CONSTRAINT pk_unclaimed_funds_record PRIMARY KEY(`unclaimed_funds_record_id`)
) COMMENT 'Tracks client trust funds that have remained unclaimed or dormant beyond the jurisdiction-mandated dormancy period and are subject to escheatment (abandoned property reporting) to state or government authorities. Captures client identity, matter reference, dormancy start date, dormancy period elapsed, amount subject to escheatment, jurisdiction escheatment rules reference, outreach attempts to locate client, escheatment filing date, and remittance confirmation. Mandatory under state unclaimed property laws.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`trust`.`trust_control_test` (
    `trust_control_test_id` BIGINT COMMENT 'Primary key for trust_control_test',
    `account_id` BIGINT COMMENT 'Foreign key linking to the trust account being tested',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to the compliance control being executed',
    `compliance_control_test_id` BIGINT COMMENT 'Unique identifier for this control test execution record. Primary key.',
    `exception_count` STRING COMMENT 'Number of exceptions or control failures identified during testing of this specific trust account. Corresponds to exception_count from detection data.',
    `exception_description` STRING COMMENT 'Detailed narrative of any exceptions or control failures identified during testing of this trust account.',
    `review_date` DATE COMMENT 'Date when the test results for this trust account were reviewed and approved. Corresponds to review_date from detection data.',
    `sample_selection_method` STRING COMMENT 'Method used to select this trust account for testing within the control sample. Corresponds to sample_selection_method from detection data.',
    `test_date` DATE COMMENT 'Date when this specific control was tested against this specific trust account. Corresponds to control_test_date from detection data.',
    `test_evidence_reference` STRING COMMENT 'Reference to supporting documentation or evidence collected during this control test (e.g., document ID, file path, workpaper reference).',
    `test_notes` STRING COMMENT 'Additional notes or observations recorded by the tester during execution of this control test on this trust account.',
    `test_result` STRING COMMENT 'Outcome of the control test execution for this trust account. Corresponds to control_test_result from detection data.',
    `tester_name` STRING COMMENT 'Name of the individual who performed this control test on this trust account. Corresponds to tester_name from detection data.',
    CONSTRAINT pk_trust_control_test PRIMARY KEY(`trust_control_test_id`)
) COMMENT 'This association product represents the testing event between trust_account and compliance_control. It captures the execution of a specific compliance control test against a specific trust account, recording test methodology, results, exceptions, and review evidence. Each record links one trust_account to one compliance_control with attributes that exist only in the context of this testing relationship.. Existence Justification: In legal practice, compliance controls are tested across multiple trust accounts as part of regulatory assurance programs (SOX, SRA, IOLTA compliance). Each control (e.g., three-way reconciliation, dual authorization, segregation of duties) is executed and tested against multiple trust accounts, and each trust account is subject to multiple controls. The business actively manages control testing as a distinct operational activity, recording test-specific evidence, results, exceptions, and remediation for each control-account combination.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`trust`.`reconciliation_period` (
    `reconciliation_period_id` BIGINT COMMENT 'Primary key for reconciliation_period',
    `prior_reconciliation_period_id` BIGINT COMMENT 'Self-referencing FK on reconciliation_period (prior_reconciliation_period_id)',
    `user_id` BIGINT COMMENT 'Identifier of the partner, compliance officer, or authorized user who approved the reconciliation. Required for regulatory audit trail.',
    `reconciliation_prepared_by_user_id` BIGINT COMMENT 'Identifier of the accounting staff member or trust accountant who prepared the reconciliation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the reconciliation was reviewed and approved by a partner or compliance officer. Required for regulatory compliance in most jurisdictions.',
    `bank_adjustments_total` DECIMAL(18,2) COMMENT 'Total amount of bank-initiated adjustments (fees, interest, corrections, NSF charges) identified during reconciliation that require corresponding trust ledger entries.',
    `bank_statement_date` DATE COMMENT 'The statement date of the bank statement used for this reconciliation period. Typically matches the period end date but may differ if statements are received on non-standard cycles.',
    `bank_statement_ending_balance` DECIMAL(18,2) COMMENT 'The ending balance reported on the bank statement for the trust account as of the statement date. First component of the three-way reconciliation.',
    `book_adjustments_total` DECIMAL(18,2) COMMENT 'Total amount of book-side adjustments (posting errors, reclassifications, corrections) identified during reconciliation that require trust ledger corrections.',
    `client_ledger_total_balance` DECIMAL(18,2) COMMENT 'The sum of all individual client subsidiary ledger balances as of the period end date. Third component of the three-way reconciliation. Must equal bank and trust ledger balances when reconciled.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when the reconciliation period was formally closed and locked from further modifications.',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when the three-way reconciliation was completed and all discrepancies resolved. Nullable until reconciliation is finalized.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation period record was first created in the system. Part of standard audit trail.',
    `due_date` DATE COMMENT 'The regulatory or firm-mandated deadline by which the three-way reconciliation must be completed and approved. Typically 10-30 days after period end depending on jurisdiction.',
    `end_date` DATE COMMENT 'The last date (inclusive) covered by this reconciliation period. Defines the end of the transaction window for three-way reconciliation.',
    `fiscal_month` STRING COMMENT 'The fiscal month (1-12) to which this reconciliation period belongs, used for monthly reconciliation cycles.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this reconciliation period belongs, used for quarterly regulatory reporting where required.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this reconciliation period belongs, used for annual reporting and compliance aggregation.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this reconciliation period is currently active and available for selection in operational workflows. Inactive periods are retained for historical reference but not displayed in active dropdowns.',
    `is_balanced` BOOLEAN COMMENT 'Boolean flag indicating whether the three-way reconciliation is balanced (all three components agree after adjustments). True when reconciliation_variance equals zero.',
    `jurisdiction_code` STRING COMMENT 'The legal jurisdiction (state, province, or country code) whose trust account rules govern this reconciliation period. Critical for multi-jurisdiction firms with varying IOLTA requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation period record was last modified. Updated whenever any field changes. Part of standard audit trail.',
    `notes` STRING COMMENT 'Free-text notes documenting unusual circumstances, discrepancies investigated, adjustments made, or other relevant information about this reconciliation period. Used for audit trail and knowledge transfer.',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when the reconciliation period was opened and made available for reconciliation work.',
    `outstanding_checks_total` DECIMAL(18,2) COMMENT 'Total amount of checks or disbursements recorded in the trust ledger but not yet cleared the bank as of the reconciliation date. Reconciling item between book and bank balances.',
    `outstanding_deposits_total` DECIMAL(18,2) COMMENT 'Total amount of deposits recorded in the trust ledger but not yet reflected on the bank statement as of the reconciliation date. Reconciling item between book and bank balances.',
    `period_code` STRING COMMENT 'Business identifier code for the reconciliation period, typically formatted as YYYY-MM or YYYY-QN for monthly or quarterly periods.',
    `period_name` STRING COMMENT 'Human-readable name for the reconciliation period (e.g., January 2024, Q1 2024).',
    `period_type` STRING COMMENT 'Classification of the reconciliation period frequency: monthly for standard monthly reconciliations, quarterly for jurisdictions requiring quarterly cycles, annual for year-end reconciliations, ad_hoc for unscheduled reconciliations triggered by events, or special for regulatory audits.',
    `reconciliation_method` STRING COMMENT 'The reconciliation methodology applied: three_way (bank statement to trust ledger to client subsidiary ledgers - gold standard), bank_to_book (bank to trust ledger only), client_ledger_only (internal client ledger verification without bank statement).',
    `reconciliation_variance` DECIMAL(18,2) COMMENT 'The net variance (if any) between the three reconciliation components after adjustments. Must be zero for a completed reconciliation. Non-zero values indicate unresolved discrepancies requiring investigation.',
    `regulatory_filing_date` DATE COMMENT 'The date on which the required regulatory trust account report was filed with the governing body. Nullable if no filing is required or if not yet filed.',
    `regulatory_filing_reference` STRING COMMENT 'The confirmation or reference number assigned by the regulatory body upon submission of the trust account reconciliation report.',
    `requires_regulatory_filing` BOOLEAN COMMENT 'Boolean flag indicating whether this reconciliation period requires submission of a regulatory report to the state bar, IOLTA program, or other governing body. Typically true for annual or quarterly periods in certain jurisdictions.',
    `start_date` DATE COMMENT 'The first date (inclusive) covered by this reconciliation period. Defines the beginning of the transaction window for three-way reconciliation.',
    `reconciliation_period_status` STRING COMMENT 'Current lifecycle status of the reconciliation period: draft (period defined but not started), open (available for reconciliation entries), in_progress (reconciliation work underway), pending_review (awaiting partner or compliance review), completed (three-way reconciliation balanced and approved), closed (finalized and locked), archived (moved to long-term storage per retention policy).',
    `trust_ledger_ending_balance` DECIMAL(18,2) COMMENT 'The ending balance in the firms trust ledger (general ledger trust account) as of the period end date. Second component of the three-way reconciliation.',
    CONSTRAINT pk_reconciliation_period PRIMARY KEY(`reconciliation_period_id`)
) COMMENT 'Master reference table for reconciliation_period. Referenced by reconciliation_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_reversed_entry_ledger_entry_id` FOREIGN KEY (`reversed_entry_ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_disbursement_authorization_id` FOREIGN KEY (`disbursement_authorization_id`) REFERENCES `legal_ecm_v1`.`trust`.`disbursement_authorization`(`disbursement_authorization_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_reversed_by_disbursement_trust_disbursement_id` FOREIGN KEY (`reversed_by_disbursement_trust_disbursement_id`) REFERENCES `legal_ecm_v1`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_debit_ledger_entry_id` FOREIGN KEY (`debit_ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_primary_ledger_entry_id` FOREIGN KEY (`primary_ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_bank_statement_id` FOREIGN KEY (`bank_statement_id`) REFERENCES `legal_ecm_v1`.`trust`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_reconciled_account_id` FOREIGN KEY (`reconciled_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_three_way_reconciliation_id` FOREIGN KEY (`three_way_reconciliation_id`) REFERENCES `legal_ecm_v1`.`trust`.`three_way_reconciliation`(`three_way_reconciliation_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_reconciled_account_id` FOREIGN KEY (`reconciled_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_reconciliation_period_id` FOREIGN KEY (`reconciliation_period_id`) REFERENCES `legal_ecm_v1`.`trust`.`reconciliation_period`(`reconciliation_period_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_bank_statement_id` FOREIGN KEY (`bank_statement_id`) REFERENCES `legal_ecm_v1`.`trust`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_duplicate_of_line_bank_statement_line_id` FOREIGN KEY (`duplicate_of_line_bank_statement_line_id`) REFERENCES `legal_ecm_v1`.`trust`.`bank_statement_line`(`bank_statement_line_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_reconciliation_period_id` FOREIGN KEY (`reconciliation_period_id`) REFERENCES `legal_ecm_v1`.`trust`.`reconciliation_period`(`reconciliation_period_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ADD CONSTRAINT `fk_trust_iolta_interest_remittance_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ADD CONSTRAINT `fk_trust_iolta_interest_remittance_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ADD CONSTRAINT `fk_trust_iolta_interest_remittance_source_account_id` FOREIGN KEY (`source_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_primary_reversal_of_transfer_id` FOREIGN KEY (`primary_reversal_of_transfer_id`) REFERENCES `legal_ecm_v1`.`trust`.`transfer`(`transfer_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_source_account_id` FOREIGN KEY (`source_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_retainer_account_id` FOREIGN KEY (`retainer_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm_v1`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `legal_ecm_v1`.`trust`.`receipt`(`receipt_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_to_retainer_agreement_id` FOREIGN KEY (`to_retainer_agreement_id`) REFERENCES `legal_ecm_v1`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm_v1`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm_v1`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_previous_exception_trust_exception_id` FOREIGN KEY (`previous_exception_trust_exception_id`) REFERENCES `legal_ecm_v1`.`trust`.`trust_exception`(`trust_exception_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_source_account_id` FOREIGN KEY (`source_account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ADD CONSTRAINT `fk_trust_trust_control_test_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ADD CONSTRAINT `fk_trust_reconciliation_period_prior_reconciliation_period_id` FOREIGN KEY (`prior_reconciliation_period_id`) REFERENCES `legal_ecm_v1`.`trust`.`reconciliation_period`(`reconciliation_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`trust` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `legal_ecm_v1`.`trust` SET TAGS ('dbx_domain' = 'trust');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Closed|Suspended|Pending Closure');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'IOLTA Pooled|Individual Client Trust|Escrow|Retainer|Settlement|Qualified Settlement Fund');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_business_glossary_term' = 'AML (Anti-Money Laundering) KYC (Know Your Client) Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending|Failed|Expired|Not Required');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'AML (Anti-Money Laundering) Risk Rating');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Prohibited');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Annual|On-Demand');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `branch_address` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `branch_address` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|GBP|EUR|CAD|AUD');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Trust Account Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `financial_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `financial_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `interest_beneficiary` SET TAGS ('dbx_business_glossary_term' = 'Interest Beneficiary');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `interest_beneficiary` SET TAGS ('dbx_value_regex' = 'Client|IOLTA Foundation|Legal Aid Society|Firm');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `iolta_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'IOLTA (Interest on Lawyers Trust Accounts) Reporting Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'Pass|Pass with Observations|Fail|Not Applicable');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `minimum_balance_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `next_reconciliation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reconciliation Due Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `purpose_of_account` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Current|Overdue|In Progress|Discrepancy Identified|Resolved');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'Attorney Trust Account|Client Trust Account|Escrow Account|Settlement Account|Retainer Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Attorney ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `reversed_entry_ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Entry ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|flagged|escalated');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `disbursement_category` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Category');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `entry_direction` SET TAGS ('dbx_business_glossary_term' = 'Entry Direction');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `entry_direction` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `ledes_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `ledger_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `payee_address` SET TAGS ('dbx_business_glossary_term' = 'Payee Address');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `payee_address` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `payee_address` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `payee_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `posted_to_gl_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to General Ledger (GL) Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|disputed|pending_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `running_balance` SET TAGS ('dbx_business_glossary_term' = 'Running Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `client_trust_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Client Trust Balance ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `audit_findings_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `available_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Balance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `balance_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|dormant|closed|reconciliation_pending|under_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `client_authorization_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Authorization On File Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `dormancy_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Threshold Days');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `escheatment_review_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Review Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `held_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Held Balance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `interest_disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Disbursed Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `interest_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Earned Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `last_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deposit Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `last_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disbursement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `last_reconciled_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Balance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `minimum_balance_required_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `negative_balance_date` SET TAGS ('dbx_business_glossary_term' = 'Negative Balance Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `negative_balance_flag` SET TAGS ('dbx_business_glossary_term' = 'Negative Balance Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `opening_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `total_deposits_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deposits Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `total_disbursements_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Disbursements Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `trust_account_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `trust_account_type` SET TAGS ('dbx_value_regex' = 'pooled_iolta|individual_client|escrow');
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ALTER COLUMN `trust_accounting_notes` SET TAGS ('dbx_business_glossary_term' = 'Trust Accounting Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Receipt ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|escalated|exempted');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Receipt Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `bank_statement_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Line Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `client_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Client Authorization Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `iolta_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Verification Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `payor_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payor Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `payor_account_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `payor_account_number` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `payor_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Payor Bank Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `payor_name` SET TAGS ('dbx_business_glossary_term' = 'Payor Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `payor_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Purpose Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Receipt Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^TR-[0-9]{6,12}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'pending_deposit|deposited|cleared|reversed|rejected|under_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'advance_retainer|settlement_proceeds|escrow_deposit|court_ordered_funds|cost_advance|expert_fee_advance');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|discrepancy|pending_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_applicable');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ALTER COLUMN `third_party_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Payment Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Disbursement ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Attorney ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorization Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `reversed_by_disbursement_trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By Disbursement ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|rejected|cancelled|completed');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_category` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Category');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_description` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_value_regex' = 'client_payment|third_party_payment|fee_transfer|cost_reimbursement|settlement_distribution|court_filing_fee');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `is_iolta_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is IOLTA (Interest on Lawyers Trust Accounts) Reportable');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `is_three_way_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Three-Way Reconciled');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `payee_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'client|third_party|court|expert_witness|vendor|firm_operating_account');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|electronic_funds_transfer|credit_card|internal_transfer');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `processed_date` SET TAGS ('dbx_business_glossary_term' = 'Processed Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorization ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `aml_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Risk Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Ledger Entry');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `debit_ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'To Ledger Entry');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `primary_ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `tertiary_disbursement_rejecting_approver_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Rejecting Approver ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|flagged|under_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_value_regex' = '^AUTH-[0-9]{8,12}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|expired|under_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_method` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_method` SET TAGS ('dbx_value_regex' = 'written|email|verbal|electronic_signature|not_required');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Obtained Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `digital_signature_reference_1` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference 1');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `digital_signature_reference_2` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference 2');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Currency');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Purpose');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `dual_signatory_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Signatory Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `dual_signatory_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Dual Signatory Threshold Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `final_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Final Authorization Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `final_authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Final Authorization Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `managing_partner_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Managing Partner Approval Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `managing_partner_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Managing Partner Approval Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'insufficient_funds|invalid_purpose|missing_documentation|unauthorized_request|client_objection|regulatory_concern');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `supervising_partner_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Approval Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `supervising_partner_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Approval Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `three_way_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Reconciliation ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `primary_three_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciled_account_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reviewer_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('dbx_business_glossary_term' = 'Bank Errors Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `book_balance` SET TAGS ('dbx_business_glossary_term' = 'Book Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `client_ledger_total` SET TAGS ('dbx_business_glossary_term' = 'Client Ledger Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `deposits_in_transit_total` SET TAGS ('dbx_business_glossary_term' = 'Deposits in Transit Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `ledger_errors_total` SET TAGS ('dbx_business_glossary_term' = 'Ledger Errors Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `outstanding_checks_total` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Checks Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `prior_period_unresolved_variance` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Unresolved Variance');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_value_regex' = '^RECON-[0-9]{6,12}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Performed Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|exception|under_review|approved');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `timing_differences_total` SET TAGS ('dbx_business_glossary_term' = 'Timing Differences Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `unresolved_exception_count` SET TAGS ('dbx_business_glossary_term' = 'Unresolved Exception Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `unresolved_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Unresolved Variance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ALTER COLUMN `variance_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Resolution Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `reconciliation_item_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Item Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Entry Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `three_way_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `actual_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Clearance Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `adjustment_required` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `cheque_number` SET TAGS ('dbx_business_glossary_term' = 'Cheque Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `client_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notified Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `deposit_reference` SET TAGS ('dbx_business_glossary_term' = 'Deposit Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `expected_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Clearance Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Item Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'identified|under_review|pending_clearance|resolved|escalated|written_off');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Item Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `item_type` SET TAGS ('dbx_value_regex' = 'outstanding_cheque|deposit_in_transit|bank_error|ledger_error|timing_difference|unrecorded_bank_charge');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `ledger_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Ledger Entry Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `originating_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Originating Transaction Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `payee_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `reconciliation_side` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Side');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `reconciliation_side` SET TAGS ('dbx_value_regex' = 'bank|ledger|client_sub_ledger');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `requires_client_notification` SET TAGS ('dbx_business_glossary_term' = 'Requires Client Notification Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'trust_ledger|client_sub_ledger|bank_statement|manual_entry');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `reconciled_account_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `average_daily_balance` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `financial_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Import Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `interest_earned` SET TAGS ('dbx_business_glossary_term' = 'Interest Earned');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `iolta_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Reporting Period');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `is_final_statement` SET TAGS ('dbx_business_glossary_term' = 'Is Final Statement Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|reconciled|discrepancy_identified|approved|rejected');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `routing_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `service_charges` SET TAGS ('dbx_business_glossary_term' = 'Service Charges');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_file_hash` SET TAGS ('dbx_business_glossary_term' = 'Statement File Hash');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_file_path` SET TAGS ('dbx_business_glossary_term' = 'Statement File Path');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_business_glossary_term' = 'Statement Format');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_value_regex' = 'pdf|csv|ofx|qbo|bai2|mt940');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_source` SET TAGS ('dbx_business_glossary_term' = 'Statement Source');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `statement_source` SET TAGS ('dbx_value_regex' = 'electronic_feed|pdf_import|manual_entry|api_integration|csv_upload|ofx_import');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `total_credit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Transaction Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `total_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Credits');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `total_debit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Transaction Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `total_debits` SET TAGS ('dbx_business_glossary_term' = 'Total Debits');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ALTER COLUMN `unmatched_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Transaction Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Line ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_reconciled_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_reconciled_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_reconciled_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_voided_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Voided By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_voided_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_voided_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `duplicate_of_line_bank_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Of Line ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `line_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Matched By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `line_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `line_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Trust Ledger Entry ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `reconciliation_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `bank_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `import_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Import Batch ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `import_source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Import Source File Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Import Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Reconciled Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `is_void` SET TAGS ('dbx_business_glossary_term' = 'Is Void Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `matched_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Matched Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `matching_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Matching Confidence Score');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `matching_method` SET TAGS ('dbx_business_glossary_term' = 'Matching Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `matching_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|rule_based|ml_assisted|imported_matched');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `matching_status` SET TAGS ('dbx_business_glossary_term' = 'Matching Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `matching_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|partially_matched|exception|under_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `payee_payor_name` SET TAGS ('dbx_business_glossary_term' = 'Payee or Payor Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `payee_payor_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `running_balance` SET TAGS ('dbx_business_glossary_term' = 'Running Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `iolta_interest_remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Interest Remittance ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `source_account_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `bank_service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Service Charge Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `form_1099_issued_date` SET TAGS ('dbx_business_glossary_term' = 'IRS Form 1099 Issued Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `form_1099_required_flag` SET TAGS ('dbx_business_glossary_term' = 'IRS Form 1099 Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `gross_interest_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Interest Earned Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `net_remittance_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Remittance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Remittance Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|electronic_funds_transfer');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `recipient_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `recipient_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Tax Identification Number (TIN)');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `recipient_tax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `recipient_tax_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `remittance_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `remittance_number` SET TAGS ('dbx_value_regex' = '^REM-[0-9]{6,12}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `remittance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Period End Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `remittance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Period Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|confirmed|reconciled|disputed');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `primary_reversal_of_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal of Trust Transfer ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `source_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Source Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_reconciled_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_reconciled_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_reconciled_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `authorized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `check_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `earned_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Earned Fee Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `earned_fee_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `iolta_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|internal_journal|electronic_funds_transfer');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|pending_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^TT-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'inter_trust|trust_to_operating|operating_to_trust|trust_to_client|client_to_trust|trust_refund');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `intake_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Arrangement ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_account_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_last_modified_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `agreed_retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Retainer Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `auto_replenishment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Replenishment Enabled');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `client_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Client Authorization Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|under_review|non_compliant|remediated');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Retainer Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `initial_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Deposit Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `interest_bearing` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `refund_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Due Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `refund_processed_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `replenishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `replenishment_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Threshold Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|depleted|expired|terminated');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_description` SET TAGS ('dbx_business_glossary_term' = 'Retainer Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_type` SET TAGS ('dbx_business_glossary_term' = 'Retainer Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_type` SET TAGS ('dbx_value_regex' = 'evergreen|fixed|security_deposit|advance_payment|engagement_specific');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'matter_concluded|client_request|firm_decision|funds_depleted|breach_of_terms|other');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `total_deposits` SET TAGS ('dbx_business_glossary_term' = 'Total Deposits');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ALTER COLUMN `total_disbursements` SET TAGS ('dbx_business_glossary_term' = 'Total Disbursements');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `retainer_replenishment_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Replenishment ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Retainer Agreement Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Receipt Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `to_retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'To Retainer Agreement Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `balance_at_trigger` SET TAGS ('dbx_business_glossary_term' = 'Balance at Trigger');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `client_response_date` SET TAGS ('dbx_business_glossary_term' = 'Client Response Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `follow_up_count` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `last_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-up Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `replenishment_request_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Request Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `replenishment_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `replenishment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Threshold');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `request_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Request Sent Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `request_sent_method` SET TAGS ('dbx_business_glossary_term' = 'Request Sent Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `request_sent_method` SET TAGS ('dbx_value_regex' = 'email|mail|portal|phone|fax|in_person');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `required_replenishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Required Replenishment Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `target_balance_after_replenishment` SET TAGS ('dbx_business_glossary_term' = 'Target Balance After Replenishment');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Trigger Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `trigger_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trigger Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `trust_account_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `trust_account_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ALTER COLUMN `wip_exposure_at_trigger` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Exposure at Trigger');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `primary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_role` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Role');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_role` SET TAGS ('dbx_value_regex' = 'Buyer|Seller|Borrower|Lender|Shareholder|Other');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'Conditions Satisfied|Agreement Terminated|Funds Fully Released|Dispute Resolved|Other');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `depositor_party_name` SET TAGS ('dbx_business_glossary_term' = 'Depositor Party Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `depositor_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `depositor_party_role` SET TAGS ('dbx_business_glossary_term' = 'Depositor Party Role');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `depositor_party_role` SET TAGS ('dbx_value_regex' = 'Buyer|Seller|Borrower|Lender|Shareholder|Other');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Escrow Agent Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Escrow Agreement Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_amount` SET TAGS ('dbx_business_glossary_term' = 'Escrow Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Escrow Period End Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Escrow Period Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_purpose` SET TAGS ('dbx_business_glossary_term' = 'Escrow Purpose');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_status` SET TAGS ('dbx_business_glossary_term' = 'Escrow Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_status` SET TAGS ('dbx_value_regex' = 'Active|Pending Release|Partially Released|Fully Released|Closed|Disputed');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Establishment Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `interest_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Allocation Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `interest_allocation_method` SET TAGS ('dbx_value_regex' = 'To Client|To IOLTA Fund|Pro Rata to Parties|Per Agreement|Not Applicable');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `release_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `release_schedule_type` SET TAGS ('dbx_value_regex' = 'Single Release|Milestone-Based|Time-Based|Claim-Driven|Hybrid');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `total_released_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Released Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'M&A|SPA|Real Estate Closing|Earnout|Indemnity Reserve|Other');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `escrow_release_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Release ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Attorney ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Disbursement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `aml_review_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `aml_review_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `aml_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|flagged');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_value_regex' = 'individual|organization|government_entity|trust|estate|other');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `escrow_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Escrow Agreement Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `net_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Release Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `post_release_escrow_balance` SET TAGS ('dbx_business_glossary_term' = 'Post-Release Escrow Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `pre_release_escrow_balance` SET TAGS ('dbx_business_glossary_term' = 'Pre-Release Escrow Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_amount` SET TAGS ('dbx_business_glossary_term' = 'Release Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Release Condition Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_condition_satisfied_date` SET TAGS ('dbx_business_glossary_term' = 'Release Condition Satisfied Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Escrow Release Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_purpose` SET TAGS ('dbx_business_glossary_term' = 'Release Purpose');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'pending|approved|executed|cancelled|failed|reversed');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `tax_withholding_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ALTER COLUMN `tax_withholding_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_report_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Regulatory Report ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Attorney ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `acknowledgment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `discrepancy_explanation` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Explanation');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `iolta_interest_earned` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Interest Earned');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `iolta_interest_remitted` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Interest Remitted');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Is Overdue Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `number_of_client_accounts` SET TAGS ('dbx_business_glossary_term' = 'Number of Client Accounts');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `number_of_transactions` SET TAGS ('dbx_business_glossary_term' = 'Number of Transactions');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `prepared_date` SET TAGS ('dbx_business_glossary_term' = 'Prepared Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `query_details` SET TAGS ('dbx_business_glossary_term' = 'Query Details');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|discrepancy_identified|pending_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Query Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'pdf|xml|csv|json|paper_form|proprietary_portal_format');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'annual_trust_account_certificate|sra_accounts_rules_compliance|state_bar_trust_account_registration|iolta_annual_report|quarterly_trust_reconciliation|ad_hoc_regulatory_inquiry');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|postal_mail|electronic_filing_system|fax');
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ALTER COLUMN `total_trust_balance_reported` SET TAGS ('dbx_business_glossary_term' = 'Total Trust Balance Reported');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `account_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Audit ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_cost` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_value_regex' = 'risk_based|substantive_testing|controls_testing|analytical_review|full_population_review|sampling');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'bar_association_spot_examination|annual_external_review|internal_compliance_audit|regulatory_examination|three_way_reconciliation_audit|iolta_compliance_review');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Auditor Contact Email');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Auditor Contact Phone');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Auditor License Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_license_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_type` SET TAGS ('dbx_business_glossary_term' = 'Auditor Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `auditor_type` SET TAGS ('dbx_value_regex' = 'internal_compliance_officer|external_cpa_firm|bar_association_examiner|regulatory_authority|independent_consultant');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Commencement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `fieldwork_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Completion Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `material_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Material Deficiency Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `overall_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Result');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `overall_audit_result` SET TAGS ('dbx_value_regex' = 'pass|pass_with_observations|fail|qualified_opinion|adverse_opinion|disclaimer');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|verified|overdue');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Audit Sample Size');
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Scheduled Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `trust_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Exception ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `previous_exception_trust_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Exception ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `primary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Result');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match|not_screened');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Exception Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_rule|manual_review|reconciliation_process|aml_screening|external_audit|client_inquiry');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|compliance_officer|general_counsel|external_regulator');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_business_glossary_term' = 'Exception Category');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_value_regex' = 'operational|compliance|financial|regulatory');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^TE-[0-9]{8}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_resolution|resolved|closed|escalated');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'negative_balance|unidentified_receipt|stale_disbursement|missing_authorization|reconciliation_failure|aml_red_flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `indemnity_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Notification Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `professional_indemnity_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Notified Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `unclaimed_funds_record_id` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Funds Record Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `source_account_id` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Funds To Trust Account');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `client_last_known_address` SET TAGS ('dbx_business_glossary_term' = 'Client Last Known Address');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `client_last_known_address` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `client_last_known_address` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `client_outreach_attempts` SET TAGS ('dbx_business_glossary_term' = 'Client Outreach Attempts Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `client_response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Response Received Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `dormancy_period_days` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Period in Days');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `dormancy_start_date` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `dormancy_status` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `escheatment_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Filing Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `escheatment_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Filing Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `escheatment_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Threshold in Days');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `exemption_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `first_outreach_date` SET TAGS ('dbx_business_glossary_term' = 'First Outreach Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `iolta_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Reportable Flag');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `last_outreach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `outreach_method` SET TAGS ('dbx_business_glossary_term' = 'Outreach Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `outreach_method` SET TAGS ('dbx_value_regex' = 'certified_mail|email|phone|registered_mail|in_person');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `regulatory_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `remittance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remittance Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `remittance_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Confirmation Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'returned_to_client|escheated_to_state|transferred_to_matter|written_off|other');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `unclaimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Amount');
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ALTER COLUMN `unclaimed_funds_number` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Funds Reference Number');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `trust_control_test_id` SET TAGS ('dbx_business_glossary_term' = 'trust_control_test Identifier');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Control Test - Trust Account Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Test - Compliance Control Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `compliance_control_test_id` SET TAGS ('dbx_business_glossary_term' = 'Control Test ID');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `sample_selection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Selection Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Control Test Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `test_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Evidence Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Control Test Result');
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ALTER COLUMN `tester_name` SET TAGS ('dbx_business_glossary_term' = 'Tester Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Identifier');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_period_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `prior_reconciliation_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Reconciliation Period Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `prior_reconciliation_period_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_prepared_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User Id');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_prepared_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_prepared_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `bank_adjustments_total` SET TAGS ('dbx_business_glossary_term' = 'Bank Adjustments Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `bank_statement_ending_balance` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Ending Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `book_adjustments_total` SET TAGS ('dbx_business_glossary_term' = 'Book Adjustments Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `client_ledger_total_balance` SET TAGS ('dbx_business_glossary_term' = 'Client Ledger Total Balance');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `is_balanced` SET TAGS ('dbx_business_glossary_term' = 'Is Balanced');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `outstanding_checks_total` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Checks Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `outstanding_deposits_total` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Deposits Total');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_variance` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `requires_regulatory_filing` SET TAGS ('dbx_business_glossary_term' = 'Requires Regulatory Filing');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `reconciliation_period_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ALTER COLUMN `trust_ledger_ending_balance` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Ending Balance');
