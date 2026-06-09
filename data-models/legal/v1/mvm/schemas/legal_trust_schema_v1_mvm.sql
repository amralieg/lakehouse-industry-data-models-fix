-- Schema for Domain: trust | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`trust` COMMENT 'Dedicated domain for client trust account management in strict compliance with IOLTA rules and jurisdiction-specific trust accounting regulations. Owns trust ledger entries, three-way reconciliations, client fund segregation records, disbursement authorizations, and regulatory trust account reporting. Operationally distinct from the billing domain — trust owns fiduciary client funds; billing owns firm revenue.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the client trust account. Primary key for the trust account master record.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Trust accounts operate under firms AML/KYC program with program-level governance (MLRO oversight, risk appetite, screening requirements). Program-level governance link. Enables tracking which program',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Trust accounts may be established for specific service offerings (escrow services, IP prosecution retainers, real estate closing accounts) to track funds designated for particular service types. Enabl',
    `matter_id` BIGINT COMMENT 'Reference to the specific matter or case associated with this trust account. May be null for general client trust accounts not tied to a specific matter.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Trust accounts are governed by firm-level compliance policies (e.g., client money policy, IOLTA policy). Account setup and ongoing compliance review requires knowing which policy governs the account t',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Trust accounts in legal practice are designated by practice area (litigation, real estate, corporate) for regulatory compliance, segregation of funds, and practice-specific IOLTA reporting. Essential ',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`ledger_entry` (
    `ledger_entry_id` BIGINT COMMENT 'Unique identifier for the trust ledger entry. Primary key for the atomic unit of trust accounting.',
    `account_id` BIGINT COMMENT 'Reference to the specific trust bank account in which this transaction occurred. Required for three-way reconciliation.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust ledger entries frequently relate to specific agreements (retainer agreements, settlement agreements, escrow agreements). Legal operations require linking trust transactions to governing contract',
    `intake_party_id` BIGINT COMMENT 'Foreign key linking to intake.intake_party. Business justification: Ledger entry counterparties are intake parties with KYC/AML screening records. Replacing denormalized counterparty_name with a FK to intake_party enforces 3NF and supports AML transaction monitoring, ',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: Ledger entries recording escrow deposits, interest accruals, or escrow releases must be traceable to the specific escrow arrangement they relate to. This FK enables reconciliation of the escrow_arrang',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Trust ledger entries frequently reference the invoice being paid or settled from trust funds. Essential for reconciliation, audit trail, and tracking which trust transactions satisfy billing obligatio',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Trust ledger entries record financial movements tied to specific legal services rendered. Service-level ledger reporting and LEDES billing code alignment require this link. Legal operations teams repo',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter for which this trust transaction was recorded. Links trust funds to specific client engagements.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Each trust transaction relates to work under a specific practice area for proper cost allocation, conflict checking, and regulatory reporting. Required for trust activity analysis by practice area and',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns the trust funds. Required for client fund segregation and IOLTA compliance.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Suspicious or anomalous ledger entries (large cash receipts, structuring patterns) trigger risk register entries under AML and financial crime risk frameworks. Legal compliance teams link specific tra',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: ledger_entry carries regulatory_reporting_flag but no FK to the obligation driving it. Regulatory transaction reporting (IOLTA, AML thresholds) requires each flagged entry to be traceable to the speci',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: A ledger entry recording a retainer deposit, replenishment, or draw-down is directly tied to the governing retainer agreement. Adding retainer_agreement_id to ledger_entry enables traceability from in',
    `reversed_entry_ledger_entry_id` BIGINT COMMENT 'Reference to the original trust ledger entry that this transaction reverses. Null for non-reversal entries.',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.sar_filing. Business justification: When suspicious transactions are identified in trust ledger (unusual patterns, structuring, high-risk jurisdictions), they trigger SAR filings. Direct operational link for AML compliance workflow and ',
    `aml_screening_date` DATE COMMENT 'Date on which AML screening was completed for this transaction. Required for regulatory audit trail.',
    `aml_screening_status` STRING COMMENT 'Outcome of AML screening for this transaction. Required for receipts above jurisdiction-specific thresholds.. Valid values are `not_required|pending|cleared|flagged|escalated`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the trust transaction in the trust account currency. Always positive; direction is indicated by entry_direction field.',
    `authorization_reference` STRING COMMENT 'Client authorization document reference or approval identifier. Required for disbursements and transfers.',
    `bank_statement_date` DATE COMMENT 'Date of the bank statement on which this transaction appeared. Used for three-way reconciliation matching.',
    `counterparty_account_number` STRING COMMENT 'Bank account number of the counterparty. Required for wire transfers and ACH transactions.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`client_trust_balance` (
    `client_trust_balance_id` BIGINT COMMENT 'Unique identifier for the client trust balance record. Primary key for this entity.',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: When a client trust balance represents funds held under an escrow arrangement (e.g., M&A transaction escrow), the balance record must reference the governing escrow_arrangement to enforce release cond',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Client trust balances are maintained per legal service engagement (e.g., litigation retainer vs. M&A escrow). Service-level trust balance reporting is required for IOLTA compliance and client billing ',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Client trust balances are maintained per the retainer terms defined in the LOE. Linking client_trust_balance to the governing LOE supports retainer replenishment threshold enforcement, IOLTA complianc',
    `matter_id` BIGINT COMMENT 'Identifier of the specific matter for which trust funds are held. Enables matter-level sub-ledger tracking within client trust accounts.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Client trust balances are held against specific contractual obligations (e.g., retainer replenishment obligations, escrow hold requirements, settlement reserves). Obligation-level balance monitoring i',
    `account_id` BIGINT COMMENT 'Identifier of the trust bank account (pooled IOLTA or individual client account) in which the funds are held.',
    `profile_id` BIGINT COMMENT 'Identifier of the client who owns the trust funds. Links to the client master record.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Dormant balances, escheatment-eligible accounts, and negative balance situations are flagged in the risk register. Legal trust accountants link client trust balances to risk register entries during do',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: client_trust_balance has regulatory_reporting_required_flag and escheatment_eligible_flag but no FK to the obligation. Escheatment reporting and IOLTA balance reporting requires knowing which regulato',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: The client trust balance for a matter is often governed by a specific retainer agreement that defines the minimum balance, replenishment threshold, and agreed retainer amount. Linking client_trust_bal',
    `retainer_id` BIGINT COMMENT 'Foreign key linking to billing.retainer. Business justification: Client trust balances often represent retainer funds held in trust. Essential for reconciling retainer balances with trust account balances, regulatory compliance reporting, and ensuring retainer draw',
    `three_way_reconciliation_id` BIGINT COMMENT 'Foreign key linking to trust.three_way_reconciliation. Business justification: The client_trust_balance has last_reconciliation_date and last_reconciled_balance_amount fields that are populated during the three-way reconciliation process. Adding a FK to the most recent three_way',
    `to_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each client balance record must reference the trust account it represents a position within. Required for pooled IOLTA accounts where multiple client balances exist within one bank account.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`receipt` (
    `receipt_id` BIGINT COMMENT 'Unique identifier for the trust receipt record. Primary key.',
    `account_id` BIGINT COMMENT 'Identifier of the trust bank account into which the funds were deposited. Supports multi-account trust management and IOLTA compliance.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust receipts often execute specific agreements (retainer deposits per engagement letter, settlement payments per settlement agreement). Real business process: matching incoming trust funds to govern',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Receipt screening (sanctions, PEP, adverse media) is performed under specific AML/KYC program version. Program context for screening decisions and risk ratings. Links receipt to program governing scre',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Incoming trust funds are subject to compliance controls (source-of-funds verification, AML acceptance controls). Compliance audit of receipts requires linking each receipt to the control governing acc',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: A receipt recording an escrow deposit (e.g., buyer depositing funds into an M&A escrow account) must reference the governing escrow_arrangement. This FK enables the system to update escrow_arrangement',
    `kyc_screening_id` BIGINT COMMENT 'Foreign key linking to intake.kyc_screening. Business justification: Receipt of trust funds requires KYC/AML screening of the payor per AML regulations. Linking receipt to the payors kyc_screening record supports IOLTA compliance, source-of-funds verification, and SAR',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Links the receipt transaction to its double-entry accounting representation in the trust ledger. Every receipt of client funds must be recorded in the ledger for IOLTA compliance and three-way reconci',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Trust receipts (incoming funds) are associated with specific legal services (e.g., retainer receipt for litigation, escrow deposit for M&A). Service-level receipt tracking is required for IOLTA report',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Trust receipts (retainer deposits) are made pursuant to an LOE that specifies the retainer amount and terms. Linking receipt to the governing LOE supports retainer reconciliation, IOLTA reporting, and',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter for which the funds were received. Links the trust receipt to the specific case or engagement.',
    `intake_party_id` BIGINT COMMENT 'Foreign key linking to intake.intake_party. Business justification: The receipt payor is an intake party with KYC/AML screening records. Replacing denormalized payor_name with a FK to intake_party enforces 3NF and links incoming trust funds to the screened party recor',
    `profile_id` BIGINT COMMENT 'Identifier of the client who provided the funds. Ensures proper segregation and attribution of client funds.',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: A receipt recording an advance retainer deposit or replenishment payment is directly governed by a retainer agreement. Linking receipt to retainer_agreement enables automatic updating of retainer_agre',
    `retainer_id` BIGINT COMMENT 'Foreign key linking to billing.retainer. Business justification: Trust receipts frequently replenish retainers. Required for retainer balance tracking, replenishment audit trail, and client billing compliance. Legal-services operations depend on linking receipts to',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`trust_disbursement` (
    `trust_disbursement_id` BIGINT COMMENT 'Unique identifier for the trust disbursement transaction. Primary key for the trust disbursement record.',
    `account_id` BIGINT COMMENT 'Reference to the client trust account from which funds are being disbursed. Links to the trust account master record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust disbursements execute obligations under specific agreements (settlement payments, retainer releases per fee agreement terms). Real business process: disbursement authorization workflow requires ',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Disbursement screening is performed under specific AML/KYC program version. Program context for screening decisions and risk ratings. Links disbursement to program governing screening at time of disbu',
    `disbursement_authorization_id` BIGINT COMMENT 'Foreign key linking to trust.disbursement_authorization. Business justification: Every disbursement should reference the authorization that approved it. This creates the governance link between the authorization workflow (disbursement_authorization) and the actual payment transact',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: A disbursement representing an escrow release (e.g., releasing funds to the seller upon satisfaction of closing conditions) must reference the governing escrow_arrangement. This FK enables enforcement',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Trust disbursements commonly pay client invoices directly from trust accounts. Critical for payment application tracking, trust-to-billing reconciliation, and regulatory reporting. The existing invoic',
    `kyc_screening_id` BIGINT COMMENT 'Foreign key linking to intake.kyc_screening. Business justification: AML regulations require payee KYC/sanctions screening before trust funds are disbursed. Linking trust_disbursement to the payees kyc_screening record supports AML compliance reporting, SAR filing dec',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Links the disbursement transaction to its double-entry accounting representation in the trust ledger. Every disbursement must be recorded in the ledger for IOLTA compliance and three-way reconciliatio',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Trust disbursements are made in connection with specific legal services (e.g., court fee payments for litigation, settlement disbursements for dispute resolution). Service-level disbursement reporting',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Trust disbursements must be traceable to the LOE that authorized the engagement and fee terms. This link supports IOLTA compliance reporting, client billing reconciliation, and regulatory audits verif',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter for which the disbursement is being made. Links to the matter master record.',
    `intake_party_id` BIGINT COMMENT 'Foreign key linking to intake.intake_party. Business justification: The disbursement payee is an intake party with KYC/AML screening records. Replacing denormalized payee_name with a FK to intake_party enforces 3NF and links disbursements to the screened party record ',
    `profile_id` BIGINT COMMENT 'Reference to the client whose trust funds are being disbursed. Links to the client master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: trust_disbursement has is_iolta_reportable and tax_treatment_code but no FK to the regulatory obligation. IOLTA disbursement reporting and AML regulatory compliance require each reportable disbursemen',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: A disbursement drawing down a client retainer (e.g., applying earned fees against the retainer balance) must reference the governing retainer agreement to enforce the agreed disbursement terms, update',
    `reversed_by_disbursement_trust_disbursement_id` BIGINT COMMENT 'Reference to the reversing disbursement transaction if this disbursement was reversed. Creates audit trail for corrections.',
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
    `payee_type` STRING COMMENT 'Classification of the payee receiving the disbursement. Used for segregation of duties and conflict checking.. Valid values are `client|third_party|court|expert_witness|vendor|firm_operating_account`',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to execute the disbursement. Determines clearing time and reconciliation procedures.. Valid values are `check|wire_transfer|ach|electronic_funds_transfer|credit_card|internal_transfer`',
    `processed_date` DATE COMMENT 'The date on which the disbursement was processed and submitted for payment. May differ from disbursement date due to clearing time.',
    `reconciliation_date` DATE COMMENT 'The date on which the disbursement was successfully reconciled in the three-way reconciliation process.',
    `reversal_reason` STRING COMMENT 'Explanation for why the disbursement was reversed or cancelled. Required for audit trail when disbursements are voided.',
    `tax_treatment_code` STRING COMMENT 'Tax classification code for the disbursement. Used for 1099 reporting and tax compliance when disbursements are made to vendors or experts.',
    `wire_reference_number` STRING COMMENT 'The wire transfer reference or confirmation number if payment method is wire transfer. Used for bank reconciliation.',
    CONSTRAINT pk_trust_disbursement PRIMARY KEY(`trust_disbursement_id`)
) COMMENT 'Records every authorized payment or transfer of client funds out of a trust account including payments to third parties, transfers to firm operating accounts upon fee earning, settlement distributions, court filing fee payments, and expert witness payments. Captures disbursement date, payee, payment method, amount, matter reference, disbursement category (UTBMS cost code), authorization status, and signatory attorney. Core operational record for trust fund outflows.';

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`disbursement_authorization` (
    `disbursement_authorization_id` BIGINT COMMENT 'Unique identifier for the disbursement authorization record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the specific trust account from which funds will be disbursed. Required for IOLTA compliance and three-way reconciliation.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Disbursement authorization workflow requires verifying contractual authority to disburse trust funds. Real business process: dual-signatory approval checks agreement terms (payment schedules, authoriz',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Authorization workflows implement specific compliance controls (dual signatory requirements, threshold-based approvals, segregation of duties). Control testing references specific authorizations as ev',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: SRA Accounts Rules compliance: disbursements require documented client authority from a specific authorized contact. disbursement_authorization tracks client_consent_obtained_flag but has no FK to the',
    `ledger_entry_id` BIGINT COMMENT 'FK to trust.trust_ledger_entry.trust_ledger_entry_id — Each authorization governs a specific disbursement transaction recorded in the ledger. Required for audit trail and compliance.',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: An authorization for an escrow release disbursement must reference the governing escrow_arrangement to validate that the release conditions have been met, that the disbursement_amount does not exceed ',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Disbursement authorizations frequently reference the invoice being paid from trust. Critical for approval audit trail, trust compliance, and linking authorization workflow to billing obligations. Lega',
    `kyc_screening_id` BIGINT COMMENT 'Foreign key linking to intake.kyc_screening. Business justification: AML regulations require payee KYC screening before disbursement authorization is granted. Linking disbursement_authorization to the payees kyc_screening record supports AML compliance sign-off, dual-',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Disbursement authorizations must be validated against the scope and fee terms in the LOE. Linking disbursement_authorization to the governing LOE supports dual-signatory approval workflows and ensures',
    `matter_id` BIGINT COMMENT 'Reference to the matter for which the trust disbursement is being authorized. Links disbursement to specific legal engagement.',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Foreign key linking to client.outside_counsel_guideline. Business justification: Disbursement compliance process: OCG defines budget approval thresholds and dual-signatory requirements that govern disbursement_authorization. The disbursement_authorization already stores dual_signa',
    `primary_disbursement_ledger_entry_id` BIGINT COMMENT 'Reference to the trust ledger entry that this authorization governs. Links to the specific trust transaction requiring authorization.',
    `profile_id` BIGINT COMMENT 'Reference to the client whose trust funds are being disbursed. Required for client fund segregation and audit trail.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: disbursement_authorization has regulatory_reporting_flag and dual_signatory_required_flag but no FK to the obligation mandating these requirements. Authorization workflow compliance requires knowing w',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: A disbursement authorization for drawing down a client retainer must reference the governing retainer agreement to validate that the disbursement is within the agreed terms, that client consent is on ',
    `to_ledger_entry_id` BIGINT COMMENT 'FK to trust.trust_ledger_entry.trust_ledger_entry_id — Each authorization governs a specific disbursement transaction (now a ledger entry of disbursement type). Without this link, authorizations are disconnected from the transactions they approve.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`three_way_reconciliation` (
    `three_way_reconciliation_id` BIGINT COMMENT 'Unique identifier for the three-way reconciliation record. Primary key for the reconciliation entity.',
    `bank_statement_id` BIGINT COMMENT 'FK to trust.bank_statement.bank_statement_id — Each reconciliation references the specific bank statement used as the external balance source. Critical for audit trail.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Three-way reconciliation is a key detective control tested under compliance frameworks (SRA, ABA Model Rules). Control testing samples reconciliations for completeness, timeliness, and review evidence',
    `account_id` BIGINT COMMENT 'Reference to the specific trust account being reconciled. Links to the trust account master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: three_way_reconciliation has regulatory_filing_required and regulatory_filing_date but no FK to the obligation mandating the filing. Bar association and regulatory body reconciliation filing requireme',
    `to_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each reconciliation is performed for a specific trust account. Without this FK, reconciliation records cannot be associated with the account they validate.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`bank_statement` (
    `bank_statement_id` BIGINT COMMENT 'Unique identifier for the bank statement record. Primary key for the bank statement entity.',
    `account_id` BIGINT COMMENT 'Reference to the trust account for which this statement was issued. Links to the trust account master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: bank_statement has iolta_reporting_period and reconciliation_status but no FK to the regulatory obligation. IOLTA and regulatory reporting requires bank statements to be traceable to the obligation ma',
    `to_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each bank statement belongs to a specific trust account. Required for the external leg of three-way reconciliation.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`transfer` (
    `transfer_id` BIGINT COMMENT 'Unique identifier for the trust transfer transaction. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Trust-to-operating transfers for earned fees require linking to the fee agreement. Real business process: earned fee transfers must reference the governing fee arrangement/engagement letter to verify ',
    `billing_payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Trust-to-operating transfers generate payment records in billing. Essential for tracing payment source, trust compliance audits, and reconciling trust drawdowns with AR applications. Legal firms must ',
    `account_id` BIGINT COMMENT 'Identifier of the trust account or operating account to which funds are being transferred. Links to the account master record.',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: A transfer may represent an escrow deposit (moving client funds into an escrow account) or an escrow release transfer (moving released escrow funds to the beneficiary account). Linking transfer to esc',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice for which earned fees are being transferred from trust to operating account. Populated only for trust-to-operating transfers representing earned fee realization.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Trust-to-operating transfers (earned fee transfers) are associated with specific legal services. Service-level earned fee reporting and IOLTA compliance tracking require this link. Legal finance teams',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Trust-to-operating account transfers (earned fee transfers) must be authorized within the LOE fee arrangement terms. Linking transfer to the governing LOE supports earned fee transfer validation, IOLT',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter to which this trust transfer relates. All trust movements must be attributable to a specific client matter for fiduciary accountability.',
    `primary_reversal_of_transfer_id` BIGINT COMMENT 'If this transfer is a reversal or correction of a prior transfer, this field contains the trust_transfer_id of the original transaction being reversed. Null for original transfers.',
    `profile_id` BIGINT COMMENT 'Identifier of the client whose funds are being transferred. Required for client fund segregation and IOLTA (Interest on Lawyers Trust Accounts) compliance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: transfer has iolta_applicable_flag but no FK to the regulatory obligation. Inter-account transfer regulatory reporting (IOLTA, AML) requires knowing which obligation mandates reporting of the transfer',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: A transfer between trust accounts may represent a retainer replenishment (moving funds from a general trust account to a matter-specific retainer account) or a retainer refund transfer. Linking transf',
    `source_account_id` BIGINT COMMENT 'Identifier of the trust account from which funds are being transferred. Links to the trust account master record.',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Links the trust transfer to the ledger entry representing the debit from the source account. Every transfer generates at least two ledger entries (debit source, credit destination) for double-entry ac',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`retainer_agreement` (
    `retainer_agreement_id` BIGINT COMMENT 'Unique identifier for the retainer agreement record. Primary key. Role: MASTER_AGREEMENT.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Retainer handling is subject to specific compliance controls (client authorization, replenishment thresholds, interest treatment). Controls test retainer agreements for proper documentation and client',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Retainer execution process: retainer agreements require a designated authorized client contact as signatory. client_authorization_reference is a denormalized string; replacing with FK to client_contac',
    `fee_arrangement_id` BIGINT COMMENT 'Reference to the associated fee arrangement or billing guideline that governs how retainer funds are drawn down against work performed.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: A retainer agreement is established for a specific legal service (e.g., ongoing corporate advisory, litigation retainer). Service-level retainer tracking, renewal management, and compliance reporting ',
    `matter_id` BIGINT COMMENT 'Reference to the matter or engagement scope covered by this retainer agreement. May be null for client-level retainers not tied to a specific matter.',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Foreign key linking to client.outside_counsel_guideline. Business justification: Retainer structuring process: retainer terms (rate caps, payment terms, billing format) must comply with the clients OCG. Billing partners validate retainer agreements against the applicable OCG befo',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Retainer agreements are inherently tied to the practice area under which services will be delivered (litigation retainer, corporate advisory retainer, IP prosecution retainer). Critical for retainer u',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: A retainer agreement is directly governed by a pricing model (e.g., fixed retainer, hourly draw-down, AFA). The pricing model determines agreed retainer amounts, replenishment terms, and billing incre',
    `account_id` BIGINT COMMENT 'Reference to the specific trust account (IOLTA or client trust account) in which the retainer funds are held.',
    `profile_id` BIGINT COMMENT 'Reference to the client who entered into this retainer agreement.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Retainer agreements with AML-flagged clients, conflict-of-interest concerns, or unusual fee structures are entered into the risk register. Legal compliance teams link retainer agreements to risk regis',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: retainer_agreement has compliance_status and compliance_review_date but no FK to the regulatory obligation. Retainer compliance review must reference the specific obligation (e.g., SRA client money ru',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Retainer agreement terms (replenishment thresholds, minimum balances, compliance review frequency) are governed by the clients service tier. Tier determines the level of retainer service and associat',
    `to_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Retainer agreement governs funds held in a specific trust account. Required for replenishment threshold monitoring.',
    `agreed_retainer_amount` DECIMAL(18,2) COMMENT 'The total retainer amount agreed upon in the retainer agreement, representing the initial or target balance to be held in trust.',
    `auto_replenishment_enabled` BOOLEAN COMMENT 'Indicates whether automatic replenishment is enabled for this retainer agreement. True for evergreen retainers with automatic replenishment; false otherwise.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`escrow_arrangement` (
    `escrow_arrangement_id` BIGINT COMMENT 'Unique identifier for the escrow arrangement record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Escrow arrangements in legal services are typically tied to specific contracts (M&A escrows, settlement escrows, real estate transaction escrows). This FK links the escrow to the underlying contract. ',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Escrow arrangements require AML/KYC screening of depositor and beneficiary parties. Escrow setup compliance requires linking to the governing AML/KYC program — mandatory under FATF guidance and legal ',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Escrow arrangements require compliance controls for release condition verification, dual authorization, and dispute resolution. High-risk activity subject to control testing. Links arrangement to spec',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Escrow arrangements process party personal data (depositor, beneficiary names, addresses, financial information) requiring privacy compliance. Processing activity registration. Links arrangement to pr',
    `intake_party_id` BIGINT COMMENT 'Foreign key linking to intake.intake_party. Business justification: The escrow depositor is an intake party with KYC/AML screening records. Replacing denormalized depositor_party_name/role with a FK to intake_party enforces 3NF and links escrow funds to the screened p',
    `kyc_screening_id` BIGINT COMMENT 'Foreign key linking to intake.kyc_screening. Business justification: Escrow parties must be KYC-screened before funds are held per AML regulations. Linking escrow_arrangement to the controlling kyc_screening record supports AML compliance, regulatory reporting, and esc',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Escrow arrangements are established in connection with specific legal services (e.g., M&A transaction escrow, real estate closing escrow). Service-level escrow reporting and regulatory compliance trac',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or transaction (M&A, SPA, real estate closing) for which this escrow arrangement was established.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Escrow release conditions are directly tied to specific contractual obligations (e.g., milestone completion, regulatory clearance, performance delivery). Legal operations require tracking which obliga',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Escrow arrangements are practice-specific (real estate closings, M&A transactions, IP licensing, litigation settlements) and require practice area tracking for regulatory compliance, conflict manageme',
    `account_id` BIGINT COMMENT 'Reference to the underlying trust bank account holding the escrowed funds, subject to IOLTA regulations.',
    `profile_id` BIGINT COMMENT 'Reference to the client on whose behalf the escrow arrangement is established.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Disputed escrow arrangements (dispute_flag on escrow_arrangement) and those with regulatory_reporting_flag generate risk register entries. Legal risk teams track escrow-related risks — counterparty de',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: escrow_arrangement has regulatory_reporting_flag but no FK to the obligation. Escrow regulatory reporting and compliance review requires knowing which obligation (e.g., real estate escrow regulations,',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.request. Business justification: Escrow arrangements for transactional matters originate from an intake request. Linking escrow_arrangement to the originating intake request provides the full audit trail from client request through e',
    `to_account_id` BIGINT COMMENT 'FK to trust.trust_account.trust_account_id — Each escrow arrangement is held within a specific trust account. Required for fund segregation and balance tracking.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for all deposits, releases, and balance changes within this escrow arrangement.',
    `beneficiary_party_name` STRING COMMENT 'Name of the party or entity entitled to receive funds upon satisfaction of release conditions (e.g., seller, indemnified party).',
    `beneficiary_party_role` STRING COMMENT 'Role of the beneficiary party in the underlying transaction.. Valid values are `Buyer|Seller|Borrower|Lender|Shareholder|Other`',
    `closure_date` DATE COMMENT 'Date on which the escrow arrangement was formally closed after all funds were released or returned and all obligations satisfied.',
    `closure_reason` STRING COMMENT 'Reason for closing the escrow arrangement, documenting the final disposition of the escrow.. Valid values are `Conditions Satisfied|Agreement Terminated|Funds Fully Released|Dispute Resolved|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this escrow arrangement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the escrowed funds (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Current remaining balance held in escrow after any partial releases or disbursements. Updated with each release event.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`trust`.`regulatory_report` (
    `regulatory_report_id` BIGINT COMMENT 'Unique identifier for the trust regulatory report. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the trust account covered by this regulatory report.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Some regulatory reports are AML-specific (SAR summary reports, AML program effectiveness reports). AML regulatory reporting requires linking the report to the AML/KYC program being reported on — requi',
    `bank_statement_id` BIGINT COMMENT 'Foreign key linking to trust.bank_statement. Business justification: A regulatory trust account report covers a specific reporting period and must reference the bank statement for that period as the primary source of the reported bank balance. The regulatory_report alr',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: regulatory_report has compliance_certification_flag and audit_report_reference but no FK to the compliance control. Regulatory reporting compliance requires knowing which control mandates or governs t',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Regulatory reporting discrepancies and overdue filings are compliance risks. Overdue IOLTA reports or discrepancies escalate to risk committee and require formal risk register entry per regulatory fra',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each regulatory report fulfills a specific obligation (IOLTA annual report, SRA accountants report). Direct compliance mapping from report to obligation being satisfied. Enables tracking of obligatio',
    `three_way_reconciliation_id` BIGINT COMMENT 'Foreign key linking to trust.three_way_reconciliation. Business justification: A regulatory trust account report submitted to bar associations or the SRA must reference the three-way reconciliation that validates the reported balances. The regulatory_report.reconciliation_status',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_reversed_entry_ledger_entry_id` FOREIGN KEY (`reversed_entry_ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_three_way_reconciliation_id` FOREIGN KEY (`three_way_reconciliation_id`) REFERENCES `legal_ecm`.`trust`.`three_way_reconciliation`(`three_way_reconciliation_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_to_account_id` FOREIGN KEY (`to_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_disbursement_authorization_id` FOREIGN KEY (`disbursement_authorization_id`) REFERENCES `legal_ecm`.`trust`.`disbursement_authorization`(`disbursement_authorization_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_reversed_by_disbursement_trust_disbursement_id` FOREIGN KEY (`reversed_by_disbursement_trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_primary_disbursement_ledger_entry_id` FOREIGN KEY (`primary_disbursement_ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_to_ledger_entry_id` FOREIGN KEY (`to_ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_bank_statement_id` FOREIGN KEY (`bank_statement_id`) REFERENCES `legal_ecm`.`trust`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_to_account_id` FOREIGN KEY (`to_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_to_account_id` FOREIGN KEY (`to_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_primary_reversal_of_transfer_id` FOREIGN KEY (`primary_reversal_of_transfer_id`) REFERENCES `legal_ecm`.`trust`.`transfer`(`transfer_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_source_account_id` FOREIGN KEY (`source_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_to_account_id` FOREIGN KEY (`to_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_to_account_id` FOREIGN KEY (`to_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_bank_statement_id` FOREIGN KEY (`bank_statement_id`) REFERENCES `legal_ecm`.`trust`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_three_way_reconciliation_id` FOREIGN KEY (`three_way_reconciliation_id`) REFERENCES `legal_ecm`.`trust`.`three_way_reconciliation`(`three_way_reconciliation_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`trust` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `legal_ecm`.`trust` SET TAGS ('dbx_domain' = 'trust');
ALTER TABLE `legal_ecm`.`trust`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`trust`.`account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Name');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Number');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Status');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Closed|Suspended|Pending Closure');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Type');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'IOLTA Pooled|Individual Client Trust|Escrow|Retainer|Settlement|Qualified Settlement Fund');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_business_glossary_term' = 'AML (Anti-Money Laundering) KYC (Know Your Client) Status');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending|Failed|Expired|Not Required');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'AML (Anti-Money Laundering) Risk Rating');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Prohibited');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Annual|On-Demand');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|GBP|EUR|CAD|AUD');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Trust Account Balance');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `financial_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Code');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `financial_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Name');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `interest_beneficiary` SET TAGS ('dbx_business_glossary_term' = 'Interest Beneficiary');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `interest_beneficiary` SET TAGS ('dbx_value_regex' = 'Client|IOLTA Foundation|Legal Aid Society|Firm');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `iolta_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'IOLTA (Interest on Lawyers Trust Accounts) Reporting Required Flag');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'Pass|Pass with Observations|Fail|Not Applicable');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `minimum_balance_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `next_reconciliation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reconciliation Due Date');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Notes');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `purpose_of_account` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Account');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Current|Overdue|In Progress|Discrepancy Identified|Resolved');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'Attorney Trust Account|Client Trust Account|Escrow Account|Settlement Account|Retainer Account');
ALTER TABLE `legal_ecm`.`trust`.`account` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry ID');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Intake Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `reversed_entry_ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Entry ID');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|flagged|escalated');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `disbursement_category` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Category');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `entry_direction` SET TAGS ('dbx_business_glossary_term' = 'Entry Direction');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `entry_direction` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `ledes_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Code');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `ledger_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `payee_address` SET TAGS ('dbx_business_glossary_term' = 'Payee Address');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `payee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `payee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `posted_to_gl_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to General Ledger (GL) Flag');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|disputed|pending_review');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `running_balance` SET TAGS ('dbx_business_glossary_term' = 'Running Balance');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `client_trust_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Client Trust Balance ID');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `three_way_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Three Way Reconciliation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `audit_findings_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Notes');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `available_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Balance Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `balance_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|dormant|closed|reconciliation_pending|under_review');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `client_authorization_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Authorization On File Flag');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `dormancy_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Threshold Days');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `escheatment_review_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Review Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `held_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Held Balance Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `interest_disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Disbursed Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `interest_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Earned Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `last_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deposit Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `last_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disbursement Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `last_reconciled_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Balance Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `minimum_balance_required_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `negative_balance_date` SET TAGS ('dbx_business_glossary_term' = 'Negative Balance Date');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `negative_balance_flag` SET TAGS ('dbx_business_glossary_term' = 'Negative Balance Flag');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `opening_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `total_deposits_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deposits Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `total_disbursements_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Disbursements Amount');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `trust_account_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Type');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `trust_account_type` SET TAGS ('dbx_value_regex' = 'pooled_iolta|individual_client|escrow');
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ALTER COLUMN `trust_accounting_notes` SET TAGS ('dbx_business_glossary_term' = 'Trust Accounting Notes');
ALTER TABLE `legal_ecm`.`trust`.`receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`receipt` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Receipt ID');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `kyc_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Screening Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Payor Intake Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|escalated|exempted');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Receipt Amount');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `bank_statement_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Line Reference');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `client_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Client Authorization Reference');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `iolta_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Eligible Flag');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Verification Status');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `payor_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payor Account Number');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `payor_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `payor_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `payor_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Payor Bank Name');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Purpose Description');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Receipt Number');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^TR-[0-9]{6,12}$');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'pending_deposit|deposited|cleared|reversed|rejected|under_review');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'advance_retainer|settlement_proceeds|escrow_deposit|court_ordered_funds|cost_advance|expert_fee_advance');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|discrepancy|pending_review');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_applicable');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `legal_ecm`.`trust`.`receipt` ALTER COLUMN `third_party_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Payment Flag');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Disbursement ID');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorization Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `kyc_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Screening Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Intake Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `reversed_by_disbursement_trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By Disbursement ID');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|rejected|cancelled|completed');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_category` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Category');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_description` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Description');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Number');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_value_regex' = 'client_payment|third_party_payment|fee_transfer|cost_reimbursement|settlement_distribution|court_filing_fee');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `is_iolta_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is IOLTA (Interest on Lawyers Trust Accounts) Reportable');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `is_three_way_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Three-Way Reconciled');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'client|third_party|court|expert_witness|vendor|firm_operating_account');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|electronic_funds_transfer|credit_card|internal_transfer');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `processed_date` SET TAGS ('dbx_business_glossary_term' = 'Processed Date');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Reference Number');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorization ID');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `kyc_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Screening Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `primary_disbursement_ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry ID');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|flagged|under_review');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_value_regex' = '^AUTH-[0-9]{8,12}$');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|expired|under_review');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_method` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Method');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_method` SET TAGS ('dbx_value_regex' = 'written|email|verbal|electronic_signature|not_required');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `client_consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Obtained Flag');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `digital_signature_reference_1` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference 1');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `digital_signature_reference_2` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference 2');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Currency');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Purpose');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `dual_signatory_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Signatory Required Flag');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `dual_signatory_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Dual Signatory Threshold Amount');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `final_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Final Authorization Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `final_authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Final Authorization Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `managing_partner_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Managing Partner Approval Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `managing_partner_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Managing Partner Approval Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'insufficient_funds|invalid_purpose|missing_documentation|unauthorized_request|client_objection|regulatory_concern');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `supervising_partner_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Approval Date');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `supervising_partner_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Approval Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `three_way_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Reconciliation ID');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('dbx_business_glossary_term' = 'Bank Errors Total');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Balance');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `book_balance` SET TAGS ('dbx_business_glossary_term' = 'Book Balance');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `client_ledger_total` SET TAGS ('dbx_business_glossary_term' = 'Client Ledger Total');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `deposits_in_transit_total` SET TAGS ('dbx_business_glossary_term' = 'Deposits in Transit Total');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `ledger_errors_total` SET TAGS ('dbx_business_glossary_term' = 'Ledger Errors Total');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `outstanding_checks_total` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Checks Total');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `prior_period_unresolved_variance` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Unresolved Variance');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_value_regex' = '^RECON-[0-9]{6,12}$');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Performed Date');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|exception|under_review|approved');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `timing_differences_total` SET TAGS ('dbx_business_glossary_term' = 'Timing Differences Total');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `unresolved_exception_count` SET TAGS ('dbx_business_glossary_term' = 'Unresolved Exception Count');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `unresolved_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Unresolved Variance Amount');
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ALTER COLUMN `variance_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Resolution Notes');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement ID');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `average_daily_balance` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Balance');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Amount');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `financial_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Name');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Import Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `interest_earned` SET TAGS ('dbx_business_glossary_term' = 'Interest Earned');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `iolta_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Reporting Period');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `is_final_statement` SET TAGS ('dbx_business_glossary_term' = 'Is Final Statement Flag');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|reconciled|discrepancy_identified|approved|rejected');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `service_charges` SET TAGS ('dbx_business_glossary_term' = 'Service Charges');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_file_hash` SET TAGS ('dbx_business_glossary_term' = 'Statement File Hash');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_file_path` SET TAGS ('dbx_business_glossary_term' = 'Statement File Path');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_business_glossary_term' = 'Statement Format');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_value_regex' = 'pdf|csv|ofx|qbo|bai2|mt940');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Number');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_source` SET TAGS ('dbx_business_glossary_term' = 'Statement Source');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `statement_source` SET TAGS ('dbx_value_regex' = 'electronic_feed|pdf_import|manual_entry|api_integration|csv_upload|ofx_import');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `total_credit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Transaction Count');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `total_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Credits');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `total_debit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Transaction Count');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `total_debits` SET TAGS ('dbx_business_glossary_term' = 'Total Debits');
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ALTER COLUMN `unmatched_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Transaction Count');
ALTER TABLE `legal_ecm`.`trust`.`transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`transfer` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer ID');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `billing_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `primary_reversal_of_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal of Trust Transfer ID');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `source_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Source Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Amount');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `authorized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `check_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `earned_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Earned Fee Amount');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `earned_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `iolta_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Applicable Flag');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Notes');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|internal_journal|electronic_funds_transfer');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Reason');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|pending_review');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Date');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Number');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^TT-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Status');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Transfer Type');
ALTER TABLE `legal_ecm`.`trust`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'inter_trust|trust_to_operating|operating_to_trust|trust_to_client|client_to_trust|trust_refund');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement ID');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Arrangement ID');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `agreed_retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Retainer Amount');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `auto_replenishment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Replenishment Enabled');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|under_review|non_compliant|remediated');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Retainer Balance');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `initial_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Deposit Date');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `interest_bearing` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Notes');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `refund_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Due Amount');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `refund_processed_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Date');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `replenishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Amount');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `replenishment_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Threshold Amount');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Status');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|depleted|expired|terminated');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_description` SET TAGS ('dbx_business_glossary_term' = 'Retainer Description');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_type` SET TAGS ('dbx_business_glossary_term' = 'Retainer Type');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `retainer_type` SET TAGS ('dbx_value_regex' = 'evergreen|fixed|security_deposit|advance_payment|engagement_specific');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'matter_concluded|client_request|firm_decision|funds_depleted|breach_of_terms|other');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `total_deposits` SET TAGS ('dbx_business_glossary_term' = 'Total Deposits');
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ALTER COLUMN `total_disbursements` SET TAGS ('dbx_business_glossary_term' = 'Total Disbursements');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement ID');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Depositor Intake Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `kyc_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Screening Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Name');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_role` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Role');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `beneficiary_party_role` SET TAGS ('dbx_value_regex' = 'Buyer|Seller|Borrower|Lender|Shareholder|Other');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'Conditions Satisfied|Agreement Terminated|Funds Fully Released|Dispute Resolved|Other');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Escrow Agent Name');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Escrow Agreement Reference');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_amount` SET TAGS ('dbx_business_glossary_term' = 'Escrow Amount');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Escrow Period End Date');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Escrow Period Start Date');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_purpose` SET TAGS ('dbx_business_glossary_term' = 'Escrow Purpose');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_status` SET TAGS ('dbx_business_glossary_term' = 'Escrow Status');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `escrow_status` SET TAGS ('dbx_value_regex' = 'Active|Pending Release|Partially Released|Fully Released|Closed|Disputed');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Establishment Date');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `interest_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Allocation Method');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `interest_allocation_method` SET TAGS ('dbx_value_regex' = 'To Client|To IOLTA Fund|Pro Rata to Parties|Per Agreement|Not Applicable');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Date');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `release_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Type');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `release_schedule_type` SET TAGS ('dbx_value_regex' = 'Single Release|Milestone-Based|Time-Based|Claim-Driven|Hybrid');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `total_released_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Released Amount');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'M&A|SPA|Real Estate Closing|Earnout|Indemnity Reserve|Other');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_report_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Regulatory Report ID');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `three_way_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Three Way Reconciliation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `acknowledgment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Amount');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `discrepancy_explanation` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Explanation');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `iolta_interest_earned` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Interest Earned');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `iolta_interest_remitted` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Interest Remitted');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Is Overdue Flag');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `number_of_client_accounts` SET TAGS ('dbx_business_glossary_term' = 'Number of Client Accounts');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `number_of_transactions` SET TAGS ('dbx_business_glossary_term' = 'Number of Transactions');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `prepared_date` SET TAGS ('dbx_business_glossary_term' = 'Prepared Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `query_details` SET TAGS ('dbx_business_glossary_term' = 'Query Details');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|discrepancy_identified|pending_review');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `regulatory_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Query Flag');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'pdf|xml|csv|json|paper_form|proprietary_portal_format');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'annual_trust_account_certificate|sra_accounts_rules_compliance|state_bar_trust_account_registration|iolta_annual_report|quarterly_trust_reconciliation|ad_hoc_regulatory_inquiry');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|postal_mail|electronic_filing_system|fax');
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ALTER COLUMN `total_trust_balance_reported` SET TAGS ('dbx_business_glossary_term' = 'Total Trust Balance Reported');
