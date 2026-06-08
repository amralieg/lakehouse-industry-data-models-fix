-- Schema for Domain: ledger | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`ledger` COMMENT 'General ledger and financial accounting system of record covering chart of accounts, journal entries, subledgers, cost centers, intercompany eliminations, AP/AR, financial close, consolidation, and trial balance. Supports SOX financial controls and IFRS/GAAP reporting. Primary system of record aligned with Oracle Financials / SAP S/4HANA.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the general ledger account in the chart of accounts master registry.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Chart of accounts must specify native currency for each account to support multi-currency GL operations, currency-specific reporting, and FX revaluation processes required in global banking operations',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `legal_entity_id` BIGINT COMMENT 'FK to ledger.legal_entity',
    `profit_center_id` BIGINT COMMENT 'FK to ledger.profit_center',
    `account_code` STRING COMMENT 'The unique alphanumeric code identifying the general ledger account. This is the externally-known business identifier used in all journal entries and financial reports. Typically follows a hierarchical numbering scheme (e.g., 1000-1999 for assets, 2000-2999 for liabilities).. Valid values are `^[0-9]{4,10}$`',
    `account_description` STRING COMMENT 'A detailed description of the purpose, usage guidelines, and business rules for this account. Provides additional context beyond the account name for users posting journal entries and for auditors reviewing account activity.',
    `account_level` STRING COMMENT 'The level of this account in the chart of accounts hierarchy (e.g., 1 for top-level summary accounts, 2 for sub-categories, 3 for detail accounts). Used for drill-down reporting and financial statement presentation at different levels of detail.',
    `account_name` STRING COMMENT 'The full descriptive name of the general ledger account (e.g., Cash and Cash Equivalents, Accounts Receivable - Trade, Interest Income on Loans). This is the human-readable label used in financial statements and reports.',
    `account_status` STRING COMMENT 'The current lifecycle status of the general ledger account. Active accounts accept postings; inactive accounts are closed and do not accept new postings; blocked accounts are temporarily suspended; pending closure accounts are in the process of being closed after final reconciliation.. Valid values are `active|inactive|blocked|pending_closure`',
    `account_subtype` STRING COMMENT 'A more granular classification within the account type (e.g., current asset, fixed asset, current liability, long-term liability, operating revenue, non-operating revenue, operating expense, non-operating expense). Used for detailed financial statement presentation and analysis.',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account determining its placement in the financial statements and its normal balance direction. Asset and expense accounts have debit normal balances; liability, equity, and revenue accounts have credit normal balances.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternate_account_code` STRING COMMENT 'An alternate or legacy account code used for cross-reference purposes during system migrations, mergers and acquisitions (M&A), or for mapping to external reporting frameworks. Allows historical data to be linked to the current chart of accounts structure.',
    `consolidation_group` STRING COMMENT 'The consolidation grouping code used for multi-entity financial consolidation and elimination of intercompany transactions. Identifies which legal entities or business units this account applies to and how it should be treated in consolidated financial statements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this account record was first created in the system. Used for audit trail and change tracking.',
    `effective_end_date` DATE COMMENT 'The date on which this account was closed or became inactive. Null for currently active accounts. Once an account is closed, no new postings are allowed, but historical balances and transactions remain accessible for reporting and audit purposes.',
    `effective_start_date` DATE COMMENT 'The date from which this account became active and available for posting in the general ledger. Used for historical analysis and to prevent backdated postings to accounts that did not exist in prior periods.',
    `financial_statement_category` STRING COMMENT 'Identifies the primary financial statement where this account is reported (balance sheet for assets/liabilities/equity, income statement for revenue/expenses, cash flow statement for cash movements, statement of changes in equity for equity movements).. Valid values are `balance_sheet|income_statement|cash_flow_statement|statement_of_changes_in_equity`',
    `financial_statement_line_item` STRING COMMENT 'The specific line item or caption on the financial statement where this account balance is aggregated and presented (e.g., Cash and Cash Equivalents, Property Plant and Equipment, Interest Income, Salaries and Benefits). Maps the detailed GL account to the published financial statement presentation.',
    `functional_area` STRING COMMENT 'The functional area or business process this account supports (e.g., Commercial Lending, Investment Banking, Treasury, Risk Management, Operations, Technology). Used for functional cost allocation and activity-based costing.',
    `ifrs_classification` STRING COMMENT 'The classification of this account under IFRS accounting standards, including specific IAS/IFRS standard references where applicable (e.g., IAS 16 - Property Plant and Equipment, IFRS 9 - Financial Instruments, IFRS 15 - Revenue from Contracts with Customers). Used for international statutory reporting and consolidation.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this account is used for intercompany transactions between legal entities within the consolidated group. Intercompany accounts are subject to elimination entries during financial consolidation to remove intra-group transactions.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this account record. Used for audit trail and accountability in chart of accounts maintenance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this account record was last modified. Used for audit trail and change tracking.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance. Asset and expense accounts have debit normal balances; liability, equity, and revenue accounts have credit normal balances. Used for validation of journal entries and trial balance preparation.. Valid values are `debit|credit`',
    `parent_account_code` STRING COMMENT 'The account code of the parent account in a hierarchical chart of accounts structure. Used for roll-up reporting and financial statement aggregation. Null for top-level accounts.',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether direct manual journal entries are allowed to this account, or whether it is a control/summary account that only receives automated postings from subledgers. Control accounts typically have this flag set to false to prevent manual posting errors.',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Indicates whether this account requires periodic reconciliation to external statements or subledger systems (e.g., bank statements, loan subledger, securities positions). Accounts flagged for reconciliation are subject to monthly close procedures and variance investigation.',
    `regulatory_reporting_category` STRING COMMENT 'The classification of this account for banking regulatory reports such as Call Reports (FFIEC 031/041), FR Y-9C, Basel III capital adequacy reporting, and liquidity coverage ratio (LCR) calculations. Maps GL accounts to regulatory reporting line items.',
    `risk_weighted_asset_category` STRING COMMENT 'The Basel III risk-weighted asset category for this account, used in capital adequacy calculations (e.g., credit risk - corporate exposures, credit risk - retail exposures, market risk, operational risk). Determines the risk weighting applied for Common Equity Tier 1 (CET1) ratio calculations.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to Sarbanes-Oxley Act (SOX) internal control testing and documentation requirements. Accounts flagged as SOX-controlled require additional review, approval workflows, and audit trail documentation for all journal entries.',
    `statistical_account_flag` BOOLEAN COMMENT 'Indicates whether this is a statistical (non-monetary) account used to track quantities, headcount, or other non-financial metrics for management reporting and ratio analysis (e.g., number of employees, number of accounts, transaction volumes). Statistical accounts do not appear in financial statements but support KPI calculations.',
    `tax_line_mapping` STRING COMMENT 'The mapping of this account to specific lines on corporate tax returns (e.g., IRS Form 1120 line references, state tax return schedules). Used for tax provision calculation, deferred tax accounting, and tax compliance reporting.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this account in the chart of accounts master. Used for audit trail and accountability in chart of accounts maintenance.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master registry of all general ledger account codes used across the enterprise, defining the financial reporting structure including account number, account name, account type (asset, liability, equity, revenue, expense), normal balance direction, financial statement mapping (balance sheet, income statement, cash flow), IFRS/GAAP classification, consolidation group, and active status. Sourced from Oracle Financials / SAP S/4HANA Chart of Accounts module. Serves as the foundational reference for all journal entries and financial reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account instance within a specific ledger set and legal entity. Primary key for the GL account operational record.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts template from which this account is instantiated. The COA defines the account structure and hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or responsibility center to which this account is assigned. Enables management accounting, budgeting, and performance analysis by organizational unit.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: GL accounts track balances in specific currencies; this link enables currency-specific balance reporting, revaluation processing, and multi-currency consolidation required for IFRS and US GAAP complia',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity under which this GL account is instantiated. A GL account is specific to a legal entity context for regulatory and consolidation purposes.',
    `parent_account_gl_account_id` BIGINT COMMENT 'Reference to the parent account in the account hierarchy. Enables roll-up reporting and hierarchical financial analysis.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Banks map GL accounts to product types for FINREP and COREP regulatory reporting, enabling automated regulatory template population. A banking regulatory reporting expert would expect GL accounts to b',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for internal profitability analysis. Used for segment reporting and management decision-making.',
    `account_category` STRING COMMENT 'Sub-classification within the account type (e.g., current asset, fixed asset, operating expense, cost of goods sold). Used for financial statement line item grouping and regulatory reporting.',
    `account_code` STRING COMMENT 'The unique alphanumeric code identifying this account within the chart of accounts. Typically structured (e.g., segment-based) to encode account type, department, and classification.',
    `account_description` STRING COMMENT 'Extended description of the account purpose, usage guidelines, and posting rules. Provides detailed context for accounting staff and auditors.',
    `account_hierarchy_level` STRING COMMENT 'The level of this account in the chart of accounts hierarchy (1=top level, increasing for detail accounts). Used for reporting aggregation and drill-down.',
    `account_name` STRING COMMENT 'The descriptive name of the GL account, providing human-readable identification of the account purpose (e.g., Cash and Cash Equivalents, Accounts Receivable - Trade).',
    `account_status` STRING COMMENT 'The current operational status of the GL account. Inactive or closed accounts do not accept new postings but retain historical balances.. Valid values are `active|inactive|suspended|closed`',
    `account_subcategory` STRING COMMENT 'Granular classification within the account category for detailed financial analysis and management reporting (e.g., trade receivables, employee receivables, intercompany receivables).',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account: asset, liability, equity, revenue, or expense. Determines financial statement presentation and normal balance (debit/credit).. Valid values are `asset|liability|equity|revenue|expense`',
    `alternate_account_code` STRING COMMENT 'An alternative account code used for external reporting, regulatory filings, or legacy system integration. Supports cross-reference and mapping requirements.',
    `budget_control_flag` BOOLEAN COMMENT 'Indicates whether postings to this account are subject to budget availability checking. Prevents overspending and enforces fiscal discipline.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was first created in the system. Supports audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'The date on which this GL account becomes inactive and no longer accepts postings. Null for accounts with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this GL account becomes active and available for posting. Supports temporal account management and reorganizations.',
    `financial_statement_line_item` STRING COMMENT 'The financial statement line item to which this account rolls up for external reporting (e.g., Cash and Cash Equivalents, Property Plant and Equipment).',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this account is used for intercompany transactions requiring elimination during consolidation. Critical for group financial reporting.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this GL account record. Critical for change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was last modified. Enables change detection and audit trail reconstruction.',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which variances or adjustments to this account require additional review or approval. Used for risk-based controls and audit scoping.',
    `natural_balance` STRING COMMENT 'The normal balance side for this account: debit for assets and expenses, credit for liabilities, equity, and revenue. Used for balance validation and error detection.. Valid values are `debit|credit`',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether direct journal entries can be posted to this account. Summary or control accounts typically do not allow direct posting.',
    `reconciliation_frequency` STRING COMMENT 'The required frequency for account reconciliation: daily for high-volume transaction accounts, monthly for standard accounts, quarterly for low-activity accounts.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Indicates whether this account requires periodic reconciliation to external statements or subledger detail. Key control for SOX compliance and audit readiness.',
    `revaluation_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to foreign exchange revaluation or fair value remeasurement at period end. Applies to foreign currency accounts and financial instruments.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to SOX internal control testing and documentation requirements. High-risk accounts require enhanced controls and audit trails.',
    `statistical_account_flag` BOOLEAN COMMENT 'Indicates whether this is a statistical (non-monetary) account used for tracking quantities, headcount, or other non-financial metrics for allocation and analysis purposes.',
    `tax_account_flag` BOOLEAN COMMENT 'Indicates whether this account is used for tax-related transactions (VAT, sales tax, withholding tax). Subject to specific tax reporting and compliance requirements.',
    `third_party_control_flag` BOOLEAN COMMENT 'Indicates whether this account is a control account for a subledger (AP, AR, fixed assets). Balance must reconcile to subledger detail.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this GL account record. Part of the audit trail for account master data changes.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Individual general ledger account instance within a specific ledger set and legal entity, representing the operational account used for posting. Captures account code, account description, account category, currency, ledger assignment, cost center linkage, intercompany flag, revaluation flag, reconciliation flag, budget control flag, and effective date range. Distinct from chart_of_accounts (the template) — this is the instantiated account within a specific legal entity and ledger context in Oracle Financials / SAP S/4HANA.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique system identifier for the general ledger journal entry header record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: journal_entry stores accounting_period as STRING but should FK to accounting_period table. Journal entries are posted to specific accounting periods and need referential integrity to the period master',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Journal entries are denominated in transaction currencies; this link is required for FX gain/loss calculation, multi-currency reporting, and currency translation per IAS 21 in banking operations.',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: SOX and IFRS audit trails require journal entries to reference the exact exchange rate record used for multi-currency posting and FX revaluation. A banking auditor would expect this FK to validate tha',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (subsidiary, branch, operating company) to which this journal entry belongs for consolidation and statutory reporting.',
    `reversed_journal_entry_id` BIGINT COMMENT 'Reference to the original journal entry that this entry reverses, establishing the reversal relationship for audit trail. Null if not a reversal.',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: journal_entry has subledger_source_system (STRING) and subledger_transaction_reference (STRING) as text-based audit trail fields. Adding subledger_id FK to the subledger registry establishes a proper ',
    `accounting_date` DATE COMMENT 'The effective accounting date (transaction date) on which the journal entry is recognized in the general ledger for financial reporting purposes.',
    `adjustment_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a period-end or year-end adjustment (true) or a regular operational entry (false), supporting financial close process tracking.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the journal entry: draft (not submitted), pending approval (awaiting review), approved (ready for posting), or rejected (returned to preparer).. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the journal entry was approved by the designated approver, supporting audit trail and SOX compliance.',
    `approver_name` STRING COMMENT 'Full name of the user who approved the journal entry, for audit trail and accountability.',
    `batch_name` STRING COMMENT 'Descriptive name of the batch or import run that created this journal entry, for operational tracking and troubleshooting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the journal entry record was first created in the system, supporting audit trail and data lineage.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to translate entry currency amounts to functional currency, if applicable. Null for entries in functional currency.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the functional currency of the legal entity, used for currency translation and consolidation.. Valid values are `^[A-Z]{3}$`',
    `functional_total_credit_amount` DECIMAL(18,2) COMMENT 'Total credit amount translated into the functional currency of the legal entity using the applicable exchange rate at accounting date.',
    `functional_total_debit_amount` DECIMAL(18,2) COMMENT 'Total debit amount translated into the functional currency of the legal entity using the applicable exchange rate at accounting date.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany transaction requiring elimination during consolidation (true) or is a single-entity transaction (false).',
    `journal_category` STRING COMMENT 'User-defined or system-assigned category for grouping and reporting journal entries (e.g., payroll, depreciation, revenue recognition, tax provision, consolidation).',
    `journal_entry_description` STRING COMMENT 'Free-text narrative description of the business purpose and nature of the journal entry, supporting audit trail and user understanding.',
    `journal_number` STRING COMMENT 'Business-facing unique journal entry number assigned by the GL system or user, used for external reference and audit trail.',
    `journal_source` STRING COMMENT 'Origin or type of journal entry indicating how it was created: manual entry by user, automated posting from subledger (AP/AR/FA), intercompany elimination, period-end accrual, foreign exchange or fair value revaluation, reversal of prior entry, recurring template-based entry, account reclassification, top-side consolidation adjustment, or statistical (non-monetary) entry. [ENUM-REF-CANDIDATE: manual|subledger|intercompany|accrual|revaluation|reversal|recurring|reclassification|top_side_adjustment|statistical — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the journal entry record was last updated, supporting change tracking and audit trail.',
    `posting_status` STRING COMMENT 'Current posting status of the journal entry in the general ledger: unposted (not yet affecting GL balances), posted (committed to GL), reversed (original entry reversed by a subsequent entry), or voided (cancelled before posting).. Valid values are `unposted|posted|reversed|voided`',
    `posting_timestamp` TIMESTAMP COMMENT 'Date and time when the journal entry was posted to the general ledger, marking the point at which it affects account balances and financial statements.',
    `preparer_name` STRING COMMENT 'Full name of the user who prepared the journal entry, for audit trail and accountability.',
    `reversal_date` DATE COMMENT 'The accounting date on which this journal entry will be or was automatically reversed, typically used for accrual entries. Null if not a reversing entry.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a prior entry (true) or an original entry (false).',
    `sox_control_reference` STRING COMMENT 'Reference code or identifier linking this journal entry to the applicable SOX internal control (e.g., control ID for manual journal entry review, approval workflow, or segregation of duties), supporting Section 302 and 404 compliance.',
    `statistical_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is statistical (non-monetary, used for ratio calculations and management reporting) rather than a financial accounting entry.',
    `subledger_source_system` STRING COMMENT 'Name or code of the upstream subledger system (AP, AR, FA, Payroll, etc.) that originated this journal entry, supporting data lineage and reconciliation.',
    `subledger_transaction_reference` STRING COMMENT 'Unique transaction identifier from the source subledger system, enabling drill-back and reconciliation between GL and subledger.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Sum of all credit line amounts in the journal entry, expressed in the entry currency. Must equal total_debit_amount for a balanced entry.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Sum of all debit line amounts in the journal entry, expressed in the entry currency. Must equal total_credit_amount for a balanced entry.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Header record for a general ledger journal entry representing a balanced debit/credit accounting transaction posted to the GL. Captures journal number, source (manual, subledger, intercompany, accrual, revaluation, reversal, recurring, reclassification, top-side adjustment, statistical), category, accounting date, period, ledger, legal entity, currency, total debits/credits, functional currency equivalent, description, preparer, approver, approval status, posting status, reversal indicator, reversal date, batch reference, and SOX control reference. Accruals, FX revaluations, reclassifications, recurring entries, and top-side adjustments are subtypes distinguished by journal source — not separate products. Primary transactional entity of the ledger domain supporting the full GL posting lifecycle including automated posting rules, approval workflows, and audit trail for SOX Section 302/404 compliance.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line. Primary key for atomic GL postings.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: journal_entry_line stores accounting_period as STRING but should FK to accounting_period. While journal_entry_line already FKs to journal_entry (which will FK to accounting_period), line-level period ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: GL entries must track originating channel for regulatory reporting (CTR/SAR filings require channel identification), channel profitability analysis, and transaction source attribution. Standard in ret',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Individual journal lines may be entered in currencies different from header; this link supports multi-currency transaction processing, line-level FX calculation, and detailed currency reporting in ban',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: Each journal entry line in a multi-currency transaction must reference the specific exchange rate record for FX P&L attribution, revaluation audit trails, and regulatory reporting. Banking controllers',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities transactions (purchases, sales, mark-to-market adjustments, coupon accruals) post to GL at line level. IFRS 9, Basel III regulatory capital, and investment accounting require instrument-lev',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Links this line to the batch-level posting event.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Journal entry lines reference the source payment transaction for subledger-to-GL reconciliation, audit trail, and regulatory reporting. Banks need to trace each journal line back to the originating pa',
    `profit_center_id` BIGINT COMMENT 'FK to ledger.profit_center',
    `reversed_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line being reversed. Maintains audit trail for reversing entries.',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: journal_entry_line has subledger_reference_code (STRING) and subledger_type (STRING) as text-based references to the originating subledger. Adding subledger_id FK to the subledger registry normalizes ',
    `adjustment_type` STRING COMMENT 'Type of accounting adjustment represented by this line. Supports financial close analytics and SOX control testing. [ENUM-REF-CANDIDATE: standard|accrual|reclassification|elimination|revaluation|provision|none — 7 candidates stripped; promote to reference product]',
    `business_segment_code` STRING COMMENT 'Business segment or division code for segment reporting. Supports IFRS 8 and regulatory segment disclosures.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was first created in the system. Supports audit trail and data lineage.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Credit amount in functional currency. Represents increases to liability, equity, and revenue accounts or decreases to asset and expense accounts.',
    `debit_amount` DECIMAL(18,2) COMMENT 'Debit amount in functional currency. Represents increases to asset and expense accounts or decreases to liability, equity, and revenue accounts.',
    `effective_date` DATE COMMENT 'Business effective date of the transaction. May differ from posting date for backdated or forward-dated entries.',
    `entered_amount` DECIMAL(18,2) COMMENT 'Transaction amount in the original entered currency before conversion to functional currency. Supports multi-currency operations and FX analysis.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert entered currency to functional currency. Supports FX revaluation and CVA calculations.',
    `exchange_rate_type` STRING COMMENT 'Type of exchange rate used for currency conversion. Supports different rate types for various accounting treatments.. Valid values are `spot|average|historical|budget|custom`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this posting belongs. Supports annual financial reporting and multi-year analysis.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the functional currency of the posting entity. Typically USD for US-based banks.. Valid values are `^[A-Z]{3}$`',
    `intercompany_entity_code` STRING COMMENT 'Legal entity or intercompany counterparty code for consolidation and intercompany eliminations. Critical for group-level IFRS/GAAP consolidation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this journal entry line. Supports change tracking and audit trail requirements.',
    `line_description` STRING COMMENT 'Detailed description of the journal entry line. Provides business context and audit trail for the posting.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Establishes ordering for audit trail and display purposes.',
    `posting_date` DATE COMMENT 'Date on which the journal entry line was posted to the general ledger. Critical for financial reporting cutoff and period assignment.',
    `posting_status` STRING COMMENT 'Current posting status of the journal entry line. Supports financial close workflow and SOX controls.. Valid values are `draft|posted|reversed|voided`',
    `project_code` STRING COMMENT 'Project or initiative code for capital expenditure tracking and project accounting. Supports investment banking deal tracking and infrastructure projects.. Valid values are `^[A-Z0-9]{3,15}$`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this line is a reversal of a prior posting. Supports accrual reversals and error corrections.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system. Examples include T24, MUREX, CALYPSO, SAP, or MANUAL for manual entries.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `statistical_amount` DECIMAL(18,2) COMMENT 'Non-monetary statistical amount for allocation or reporting purposes. Supports headcount, square footage, or other allocation bases.',
    `statistical_unit` STRING COMMENT 'Unit of measure for the statistical amount. Examples include headcount, square meters, or transaction count.',
    `subledger_type` STRING COMMENT 'Type of subledger that originated this posting. Links GL to operational systems such as AP, AR, loan origination, or trading platforms. [ENUM-REF-CANDIDATE: accounts_payable|accounts_receivable|fixed_assets|cash_management|loan|deposit|securities|none — 8 candidates stripped; promote to reference product]',
    `tax_code` STRING COMMENT 'Tax code for VAT, GST, or other tax treatment. Supports tax reporting and compliance with FATCA and CRS requirements.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line within a journal entry, representing the atomic posting to a specific GL account. Captures line number, GL account code, cost center, profit center, segment, project code, intercompany entity, debit amount, credit amount, functional currency amount, entered currency, exchange rate, exchange rate type, description, tax code, and subledger reference. Supports full dimensional analysis for IFRS/GAAP reporting and SOX audit trail requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`accounting_period` (
    `accounting_period_id` BIGINT COMMENT 'Unique identifier for the accounting period record. Primary key.',
    `holiday_calendar_id` BIGINT COMMENT 'Reference to the fiscal calendar definition that governs this accounting period. Supports multiple fiscal calendars for different legal entities or reporting requirements.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this accounting period is defined. Supports multi-entity consolidation and statutory reporting.',
    `accounting_period_description` STRING COMMENT 'Free-text description or notes about the accounting period. May include special instructions, closing notes, or period-specific context.',
    `adjustment_period_flag` BOOLEAN COMMENT 'Indicates whether this is an adjustment period (True) or a standard operating period (False). Adjustment periods (e.g., Period 13, Period 14) are used for year-end closing entries and do not correspond to calendar months.',
    `budget_period_flag` BOOLEAN COMMENT 'Indicates whether this period is used for budgeting and planning (True) or is actuals-only (False). Supports budget vs. actual variance analysis.',
    `close_sequence` STRING COMMENT 'Defines the order in which periods should be closed in a multi-period close process. Lower numbers close first. Supports controlled, sequential period-end closing workflows.',
    `closed_date` DATE COMMENT 'The date on which the accounting period was closed. Null if the period is still open or has never been closed. Supports audit trail and period lifecycle tracking.',
    `consolidation_flag` BOOLEAN COMMENT 'Indicates whether this period is used for consolidation reporting (True) or is a subsidiary-only period (False). Supports multi-entity consolidation workflows.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this accounting period belongs (e.g., 2024, 2025). May differ from calendar year depending on the organizations fiscal calendar.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany eliminations have been processed for this period (True) or not (False). Supports consolidated financial statement preparation.',
    `opened_date` DATE COMMENT 'The date on which the accounting period was opened for posting. Supports audit trail and period lifecycle tracking.',
    `period_end_date` DATE COMMENT 'The last day of the accounting period. Journal entries with accounting dates on or before this date may be posted to this period (subject to period status).',
    `period_name` STRING COMMENT 'Human-readable name of the accounting period, typically in the format MMM-YY (e.g., JAN-24, FEB-24) or Period 1, Period 2. Used for display and reporting purposes.',
    `period_number` STRING COMMENT 'Sequential numeric identifier of the period within the fiscal year (e.g., 1 for January, 2 for February, 13 for year-end adjustment period). Supports ordering and period arithmetic.',
    `period_start_date` DATE COMMENT 'The first day of the accounting period. Journal entries with accounting dates on or after this date may be posted to this period (subject to period status).',
    `period_status` STRING COMMENT 'Current lifecycle status of the accounting period. Controls whether journal entries can be posted. future_enterable allows posting to future periods; open allows normal posting; closed prevents posting but can be reopened; permanently_closed locks the period for SOX compliance; never_opened indicates the period has not yet been activated.. Valid values are `future_enterable|open|closed|permanently_closed|never_opened`',
    `period_type` STRING COMMENT 'Classification of the accounting period. standard for regular monthly periods; adjustment for mid-year or quarterly adjustment periods; year_end for annual closing and adjustment entries; opening for the initial period when opening balances are recorded.. Valid values are `standard|adjustment|year_end|opening`',
    `permanently_closed_date` DATE COMMENT 'The date on which the accounting period was permanently closed and locked for SOX compliance. Once permanently closed, the period cannot be reopened. Null if not permanently closed.',
    `quarter_number` STRING COMMENT 'The fiscal quarter to which this period belongs (1, 2, 3, or 4). Supports quarterly reporting and SEC 10-Q filing requirements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounting period record was first created in the system. Supports audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounting period record was last updated. Supports audit trail and change tracking.',
    `reporting_flag` BOOLEAN COMMENT 'Indicates whether this period is included in external financial reporting (True) or is for internal management purposes only (False). Supports GAAP and IFRS reporting requirements.',
    `sox_certification_date` DATE COMMENT 'The date on which the period was certified for SOX compliance. Null if not yet certified. Supports audit trail and compliance reporting.',
    `sox_certification_flag` BOOLEAN COMMENT 'Indicates whether the period has been certified for SOX compliance (True) or not (False). Supports internal control attestation and audit requirements.',
    `year_end_flag` BOOLEAN COMMENT 'Indicates whether this period is the final period of the fiscal year (True) or not (False). Used to trigger year-end closing processes, retained earnings rollover, and annual financial statement preparation.',
    CONSTRAINT pk_accounting_period PRIMARY KEY(`accounting_period_id`)
) COMMENT 'Definition and status of each financial accounting period within a fiscal calendar, governing when journal entries can be posted. Captures period name, period number, fiscal year, period start date, period end date, period status (open, closed, permanently closed, future enterable), ledger set, legal entity, close sequence, and period type (standard, adjustment, year-end). Controls the financial close process and period-end reporting cycle in Oracle Financials / SAP S/4HANA.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center organizational unit. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Cost center budgets are set in specific currencies; this link enables budget vs. actual reporting in correct currency, budget translation for consolidation, and multi-currency budget management.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Cost centers are located in specific countries for regulatory reporting and transfer pricing; this link enables country-level cost analysis, regulatory reporting, and geographic profitability tracking',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity to which this cost center belongs. Used for statutory reporting and consolidation.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the parent cost center in the organizational hierarchy. Null for top-level units. Enables hierarchical roll-up of costs and revenues.',
    `basel_business_line` STRING COMMENT 'Basel III standardized business line classification for operational risk capital calculation. Maps cost center to one of eight Basel business lines. [ENUM-REF-CANDIDATE: corporate_finance|trading_sales|retail_banking|commercial_banking|payment_settlement|agency_services|asset_management|retail_brokerage — 8 candidates stripped; promote to reference product]',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budgeted amount for this cost center in the reporting currency. Used for variance analysis and performance measurement.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate shared or indirect costs to this cost center. Direct assigns costs directly incurred; step-down cascades from service units; reciprocal accounts for mutual services; activity-based uses cost drivers. [ENUM-REF-CANDIDATE: direct|step_down|reciprocal|activity_based|headcount|square_footage|custom — 7 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the cost center in financial systems and reports. Used in General Ledger (GL) posting and management accounting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_center_description` STRING COMMENT 'Detailed business description of the cost centers purpose, scope, and responsibilities.',
    `cost_center_name` STRING COMMENT 'Full business name of the cost center organizational unit.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active units participate in financial transactions; inactive/closed units are historical.. Valid values are `active|inactive|pending|closed|suspended`',
    `cost_center_type` STRING COMMENT 'Classification of the organizational unit by financial responsibility: cost center (expense only), revenue center (revenue only), profit center (P&L responsibility), investment center (ROI responsibility), shared service (allocated costs), or support unit (overhead).. Valid values are `cost_center|revenue_center|profit_center|investment_center|shared_service|support_unit`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date when this cost center became active and began accepting financial transactions.',
    `effective_to_date` DATE COMMENT 'Date when this cost center ceased operations or was closed. Null for currently active units.',
    `ftp_rate_assignment_method` STRING COMMENT 'Method used to assign FTP rates to this cost center for internal profitability measurement. Matched maturity assigns rates based on asset/liability duration; pooled uses average rates; market-based uses external benchmarks.. Valid values are `matched_maturity|pooled|blended|market_based|cost_of_funds|custom`',
    `ftp_rate_percent` DECIMAL(18,2) COMMENT 'Current FTP rate assigned to this cost center, expressed as an annual percentage. Used to calculate Net Interest Income (NII) and Net Interest Margin (NIM) at the cost center level.',
    `geographic_region` STRING COMMENT 'Geographic region or market where this cost center operates (e.g., North America, EMEA, APAC, LATAM). Used for geographic segment reporting.',
    `gl_account_range_end` STRING COMMENT 'Ending GL account number in the range assigned to this cost center. Used to filter GL transactions by cost center.. Valid values are `^[0-9]{4,10}$`',
    `gl_account_range_start` STRING COMMENT 'Starting GL account number in the range assigned to this cost center. Used to filter GL transactions by cost center.. Valid values are `^[0-9]{4,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level in the organizational hierarchy (e.g., 1=corporate, 2=division, 3=department, 4=team). Used for roll-up reporting and consolidation.',
    `ifrs8_reportable_segment_flag` BOOLEAN COMMENT 'Indicates whether this cost center is part of an IFRS 8 reportable operating segment that must be disclosed in external financial statements.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether transactions involving this cost center require intercompany elimination during financial consolidation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was last updated.',
    `lob` STRING COMMENT 'Primary line of business classification for this cost center. Used for Basel III business line mapping, RAROC reporting, and segment profitability analysis. [ENUM-REF-CANDIDATE: retail_banking|investment_banking|wealth_management|asset_management|treasury|corporate_banking|trade_finance|capital_markets|operations|technology|risk|compliance|finance|human_resources|legal — 15 candidates stripped; promote to reference product]',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for financial reporting and consolidation for this cost center.. Valid values are `^[A-Z]{3}$`',
    `revenue_allocation_method` STRING COMMENT 'Method used to allocate revenues to this cost center. Direct allocation assigns revenues directly generated; activity-based uses cost drivers; headcount uses employee count; revenue driver uses business-specific metrics.. Valid values are `direct|activity_based|headcount|revenue_driver|custom`',
    `sox_control_scope_flag` BOOLEAN COMMENT 'Indicates whether this cost center is in scope for SOX Section 404 internal control testing and documentation.',
    `transfer_pricing_method` STRING COMMENT 'Method used for intercompany or inter-unit transfer pricing when this cost center transacts with other units. Cost-plus adds markup to cost; market price uses external benchmarks; negotiated uses agreed rates.. Valid values are `cost_plus|market_price|negotiated|resale_minus|profit_split|not_applicable`',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational accounting unit used for cost allocation, revenue attribution, profitability measurement, and management accounting within the bank. Represents any discrete area of financial responsibility — functioning as a cost center, revenue center, or profit center (including banking segment, product line, geographic region, or shared service unit). Captures unit code, name, type (cost, revenue, profit, shared service), responsible manager/executive, legal entity, business unit, line of business (LOB), geographic region, hierarchy level, parent unit, FTP rate assignment, revenue allocation method, cost allocation method, transfer pricing method, effective date range, and active status. Supports FTP allocation, RAROC reporting, PnL attribution, IFRS 8 segment reporting, Basel III business line mapping, and management accounting across Oracle Financials / SAP S/4HANA. This product is the single source of truth for all organizational accounting units regardless of whether they are measured on cost, revenue, or profit.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity within the banking group. Primary key for the legal entity master record.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Legal entities are incorporated in specific jurisdictions; this link enables regulatory reporting, legal structure analysis, corporate governance tracking, and jurisdiction-specific compliance in bank',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Every legal entity has a functional currency per IAS 21; this is mandatory for IFRS consolidation, currency translation, and financial statement preparation in multi-entity banking groups.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Legal entities must be linked to jurisdictions for Basel capital reporting, FATCA/CRS compliance, and resolution planning. jurisdiction_of_incorporation is a denormalized text field; a proper FK enabl',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Banks must link their legal entities to the global LEI registry for EMIR, MiFID II, and CFTC regulatory reporting. Regulators require LEI validation for trade reporting and entity identification. A ba',
    `parent_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the immediate parent legal entity within the banking group hierarchy. Null for the ultimate parent entity. Used for consolidation, intercompany eliminations, and organizational reporting.',
    `primary_ultimate_parent_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the top-level parent legal entity (holding company) of the entire banking group. Used for ultimate consolidation and group-level regulatory reporting.',
    `acquisition_date` DATE COMMENT 'Date on which the banking group acquired control of this legal entity through merger, acquisition, or other business combination. Null for entities that were organically established. Used for purchase accounting and goodwill allocation.',
    `ccar_dfast_entity_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this legal entity is included in the scope of Federal Reserve CCAR or DFAST stress testing submissions. True = included in stress testing; False = excluded.',
    `consolidation_method` STRING COMMENT 'Method used to consolidate this legal entity into the group financial statements. FULL = full consolidation (subsidiary), EQUITY = equity method (associate/joint venture), PROPORTIONAL = proportional consolidation (joint operation), NONE = not consolidated (investment held for sale, discontinued operation).. Valid values are `FULL|EQUITY|PROPORTIONAL|NONE`',
    `country_of_domicile` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the legal entity has its principal place of business or tax residence. May differ from country of incorporation for tax planning structures.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system. Used for audit trail and data lineage tracking.',
    `crs_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this legal entity is required to report financial account information under the OECD Common Reporting Standard (CRS) for automatic exchange of information. True = CRS reporting required; False = not a reporting financial institution.',
    `dissolution_date` DATE COMMENT 'Date on which the legal entity was officially dissolved, liquidated, or deregistered. Null for active entities. Used for historical record-keeping and final reporting.',
    `entity_type` STRING COMMENT 'Classification of the legal entity by its primary business function within the banking group. Values include: BANK (deposit-taking institution), BROKER_DEALER (securities trading), INSURANCE (insurance underwriting), ASSET_MANAGER (investment management), SPV (special purpose vehicle), HOLDING_COMPANY (non-operating parent), BRANCH (non-legal entity branch office). [ENUM-REF-CANDIDATE: BANK|BROKER_DEALER|INSURANCE|ASSET_MANAGER|SPV|HOLDING_COMPANY|BRANCH|TRUST_COMPANY|FINANCE_COMPANY|SERVICER|CUSTODIAN — promote to reference product]',
    `external_auditor_name` STRING COMMENT 'Name of the external audit firm responsible for auditing the legal entity statutory financial statements. Used for audit coordination and SOX compliance tracking.',
    `fatca_giin` STRING COMMENT 'Global Intermediary Identification Number (GIIN) assigned by the IRS for FATCA reporting. Format: XXXXXX.XXXXX.XX.XXX. Required for financial institutions reporting under FATCA to identify the legal entity in Form 8966 submissions.. Valid values are `^[A-Z0-9]{6}.[A-Z0-9]{5}.[A-Z]{2}.[0-9]{3}$`',
    `fiscal_year_end_month` STRING COMMENT 'Month (1-12) in which the legal entity closes its fiscal year for statutory financial reporting. Used to align consolidation schedules and regulatory reporting deadlines. Example: 12 = December year-end.',
    `incorporation_date` DATE COMMENT 'Date on which the legal entity was officially incorporated or registered with the jurisdiction. Used for entity age calculations and regulatory reporting.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether intercompany transactions and balances involving this legal entity must be eliminated during group consolidation. True = eliminate intercompany entries; False = no elimination required (e.g., equity method investee).',
    `last_audit_opinion_date` DATE COMMENT 'Date of the most recent external audit opinion issued for the legal entity statutory financial statements. Used to track audit currency and compliance status.',
    `last_audit_opinion_type` STRING COMMENT 'Type of audit opinion issued in the most recent external audit. UNQUALIFIED = clean opinion; QUALIFIED = opinion with exceptions; ADVERSE = financial statements materially misstated; DISCLAIMER = auditor unable to form opinion.. Valid values are `UNQUALIFIED|QUALIFIED|ADVERSE|DISCLAIMER`',
    `legal_entity_code` STRING COMMENT 'Short alphanumeric code used to identify the legal entity in operational systems and reporting. Typically aligned with General Ledger (GL) company code or regulatory reporting entity code.. Valid values are `^[A-Z0-9]{4,20}$`',
    `legal_entity_name` STRING COMMENT 'Full legal name of the entity as registered with the jurisdiction of incorporation. Used for financial statements, regulatory filings, and intercompany agreements.',
    `legal_entity_status` STRING COMMENT 'Current operational status of the legal entity. ACTIVE = operating and transacting; INACTIVE = temporarily not operating but still registered; DORMANT = no activity for extended period; LIQUIDATION = in process of winding down; DISSOLVED = legally terminated.. Valid values are `ACTIVE|INACTIVE|DORMANT|LIQUIDATION|DISSOLVED`',
    `lei_code` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier (LEI) used for global identification in financial transactions and regulatory reporting. Required for CFTC, EMIR, MiFID II, and other cross-border reporting.. Valid values are `^[A-Z0-9]{20}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of voting equity owned by the parent entity or controlling shareholder. Used to determine consolidation method and minority interest calculations. Range 0.00 to 100.00.',
    `primary_regulator` STRING COMMENT 'Name of the primary regulatory authority with supervisory oversight over this legal entity. Examples: Federal Reserve, OCC, FCA, ECB, FINRA, SEC. Used for regulatory reporting routing and compliance tracking.',
    `registered_address_line1` STRING COMMENT 'First line of the legal entity registered office address as filed with the corporate registry. Used for legal correspondence and regulatory filings.',
    `registered_address_line2` STRING COMMENT 'Second line of the legal entity registered office address (suite, floor, building name). Optional field for additional address detail.',
    `registered_city` STRING COMMENT 'City or municipality of the legal entity registered office address.',
    `registered_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the legal entity registered office address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the legal entity registered office address.',
    `registered_state_province` STRING COMMENT 'State, province, or region of the legal entity registered office address. Used for jurisdiction-specific regulatory reporting.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the jurisdiction of incorporation. Examples include EIN (USA), Companies House number (UK), or local business registry number.',
    `regulatory_reporting_entity_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this legal entity is required to file standalone regulatory reports (e.g., Call Reports, FR Y-9C, COREP, FINREP). True = files reports; False = consolidated into parent reporting.',
    `regulatory_status` STRING COMMENT 'Indicates whether the legal entity is subject to prudential regulation and supervision by a banking, securities, or insurance regulator. REGULATED = subject to capital, liquidity, and conduct rules; NON_REGULATED = not subject to financial services regulation; EXEMPT = exempt from certain requirements; PENDING = application for regulatory status in progress.. Valid values are `REGULATED|NON_REGULATED|EXEMPT|PENDING`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for consolidated group reporting and regulatory filings. Typically the parent company functional currency (e.g., USD for US-based banking groups).. Valid values are `^[A-Z]{3}$`',
    `short_name` STRING COMMENT 'Abbreviated or trading name of the legal entity used for internal reporting and operational purposes.',
    `sox_scope_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this legal entity is within the scope of Sarbanes-Oxley Act Section 404 internal controls testing and certification. True = SOX controls apply; False = out of scope.',
    `tax_identification_number` STRING COMMENT 'Tax identification number assigned by the tax authority in the jurisdiction of incorporation. Used for tax filings, withholding, and transfer pricing documentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was last modified. Used for change tracking and audit trail.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record for each legal entity within the banking group that maintains its own set of books and financial statements. Captures legal entity code, legal entity name, registration number, jurisdiction, country of incorporation, functional currency, reporting currency, GAAP standard (IFRS/US GAAP), consolidation method (full, equity, proportional), parent entity, intercompany elimination flag, regulatory reporting entity flag, and active status. Foundational for intercompany eliminations, consolidation, and regulatory reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`subledger` (
    `subledger_id` BIGINT COMMENT 'Unique identifier for the subledger configuration and reconciliation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: subledger currently stores accounting_period as STRING but should FK to accounting_period table to properly link subledger reconciliation records to the formal accounting period definition. Enables pe',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Subledgers (card processing, ATM networks, digital banking platforms) are inherently channel-specific. Reconciliation, GL posting, and operational risk management require channel attribution. Standard',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Subledgers track balances in specific currencies before GL posting; this link enables subledger-to-GL reconciliation in correct currency and supports multi-currency subledger accounting.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities subledgers (trading book, investment portfolio, collateral register) track positions by instrument and reconcile to GL. Required for daily P&L attribution, risk-weighted asset calculations,',
    `legal_entity_id` BIGINT COMMENT 'FK to ledger.legal_entity',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory examiners review subledger reconciliations as a core examination procedure. Linking subledgers to the exam that reviewed them supports examination response tracking, finding remediation, an',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this subledger configuration is currently active (True) or has been decommissioned (False).',
    `approval_date` DATE COMMENT 'Date on which the subledger reconciliation was formally approved by the reviewer.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this reconciliation to external audit work papers or internal audit evidence repository.',
    `auto_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation was performed automatically by the system (True) or required manual intervention (False).',
    `balance_amount` DECIMAL(18,2) COMMENT 'Aggregate balance amount from the subledger module for the reconciliation period, in the reporting currency.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or line of business (LOB) responsible for this subledger.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subledger configuration or reconciliation record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which this subledger configuration was decommissioned or ceased feeding the General Ledger (GL). Null if still active.',
    `effective_start_date` DATE COMMENT 'Date from which this subledger configuration became effective and began feeding the General Ledger (GL).',
    `gl_account_range_end` STRING COMMENT 'Ending General Ledger (GL) account code in the range covered by this subledger reconciliation.. Valid values are `^[0-9]{4,10}$`',
    `gl_account_range_start` STRING COMMENT 'Starting General Ledger (GL) account code in the range covered by this subledger reconciliation.. Valid values are `^[0-9]{4,10}$`',
    `gl_posted_balance_amount` DECIMAL(18,2) COMMENT 'Posted balance amount in the General Ledger (GL) for the corresponding control account and period, in the reporting currency.',
    `gl_transfer_method` STRING COMMENT 'Method by which subledger balances are transferred to the General Ledger (batch, real-time, scheduled, manual).. Valid values are `batch|real_time|scheduled|manual`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this subledger configuration or reconciliation record was last updated.',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold above which a variance is considered material and requires escalation for resolution.',
    `posting_frequency` STRING COMMENT 'Frequency at which subledger transactions are posted to the General Ledger (daily, weekly, monthly, quarterly, on-demand).. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `preparer_name` STRING COMMENT 'Full name of the individual who prepared the subledger reconciliation.',
    `reconciliation_date` DATE COMMENT 'Date on which the subledger-to-General Ledger (GL) reconciliation was executed.',
    `reconciliation_status` STRING COMMENT 'Current status of the subledger-to-General Ledger (GL) reconciliation (reconciled, in-progress, exception, escalated, pending review).. Valid values are `reconciled|in_progress|exception|escalated|pending_review`',
    `resolution_actions` STRING COMMENT 'Documented actions taken to resolve any reconciliation exceptions or variances (e.g., journal entry posted, transaction reclassified, timing difference noted).',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed the subledger reconciliation.',
    `source_system_code` STRING COMMENT 'Technical identifier or instance code of the source system feeding this subledger.',
    `source_system_name` STRING COMMENT 'Name of the operational system of record that generates subledger transactions (e.g., Temenos T24, Murex, ACI Worldwide).',
    `subledger_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the subledger module within the General Ledger (GL) system.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `subledger_name` STRING COMMENT 'Business name of the subledger module (e.g., Accounts Payable, Fixed Assets, Loan Subledger).',
    `subledger_type` STRING COMMENT 'Classification of the subledger module by functional area (e.g., accounts payable, accounts receivable, fixed assets, loans, securities, payroll, derivatives). [ENUM-REF-CANDIDATE: accounts_payable|accounts_receivable|fixed_assets|loans|securities|payroll|derivatives|inventory|cash_management|intercompany — 10 candidates stripped; promote to reference product]',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between subledger balance and General Ledger (GL) posted balance (subledger_balance_amount minus gl_posted_balance_amount).',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the General Ledger (GL) posted balance, used for materiality assessment.',
    `variance_root_cause` STRING COMMENT 'Documented root cause explanation for any variance between subledger and General Ledger (GL) balances (e.g., timing difference, posting error, unrecorded transaction).',
    CONSTRAINT pk_subledger PRIMARY KEY(`subledger_id`)
) COMMENT 'Registry of subledger modules that feed into the general ledger, combined with the operational reconciliation records that verify subledger-to-GL integrity each period. Captures subledger configuration: name, type (accounts payable, accounts receivable, fixed assets, loans, securities, payroll, derivatives), source system, GL transfer method, posting frequency, and control account mapping. Also captures period-end reconciliation execution: reconciliation run ID, accounting period, GL account range, subledger aggregate balance, GL posted balance, variance amount, variance root cause, reconciliation status (reconciled, in-progress, exception, escalated), auto-reconciliation flag, preparer, reviewer, approval date, resolution actions, and SOX control evidence reference. This product is the single source of truth for both subledger configuration and subledger-to-GL reconciliation governance, supporting period-end close compliance for SOX Section 302/404 and external audit requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`trial_balance` (
    `trial_balance_id` BIGINT COMMENT 'Unique identifier for the trial balance record. Primary key for this entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period (month, quarter, year) for which this trial balance snapshot is captured. Supports period-end close and financial reporting cycles.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or business unit dimension for management accounting and internal reporting. May be null for balance sheet accounts not allocated to cost centers.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trial balance reports are currency-specific; this link enables accurate currency-specific balance reporting and supports multi-currency trial balance preparation for financial close.',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: Period-end trial balance revaluation requires linking to the specific approved exchange rate used — mandatory for IFRS/GAAP financial close, external audit sign-off, and regulatory reporting (FINREP).',
    `gl_account_id` BIGINT COMMENT 'Reference to the chart of accounts GL account for which this balance is reported. Links to the account master defining account type, category, and financial statement line item.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Trial balance reporting by instrument supports portfolio valuation, investment performance measurement, and regulatory capital calculations. Required for IFRS 9 expected credit loss modeling, Basel II',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this trial balance is prepared. Critical for consolidation and regulatory reporting under IFRS/GAAP.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: trial_balance currently has cost_center_id and legal_entity_id as dimensional FKs but lacks a profit_center_id. In banking, trial balance snapshots are routinely segmented by profit center (LOB/busine',
    `adjustment_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this trial balance line includes post-close adjustments, reclassifications, or audit adjustments. Supports SOX audit trail requirements.',
    `approval_date` DATE COMMENT 'Date on which the trial balance or account reconciliation was approved. Critical for financial close timeline tracking and SOX audit trail.',
    `approved_by` STRING COMMENT 'User ID or name of the individual who approved the trial balance or account reconciliation. Supports maker-checker controls and SOX compliance.',
    `balance_status` STRING COMMENT 'Current status of the trial balance record in the financial close cycle. Indicates whether the balance is draft (pre-close), preliminary (soft close), final (hard close), audited (external audit complete), or adjusted (post-close adjustment).. Valid values are `draft|preliminary|final|audited|adjusted`',
    `balance_type` STRING COMMENT 'Classification of the trial balance record indicating whether it represents actual posted transactions, budgeted amounts, forecasted amounts, adjusted balances, restated balances for prior period corrections, or pro forma balances for scenario analysis.. Valid values are `actual|budget|forecast|adjusted|restated|pro_forma`',
    `closing_balance_credit` DECIMAL(18,2) COMMENT 'Ending credit balance for this GL account at the end of the accounting period. Calculated as opening balance plus period activity. Forms the basis for financial statement preparation.',
    `closing_balance_debit` DECIMAL(18,2) COMMENT 'Ending debit balance for this GL account at the end of the accounting period. Calculated as opening balance plus period activity. Forms the basis for financial statement preparation.',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this trial balance line has been marked for elimination in the consolidation process. Used to remove intercompany balances and transactions.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert transaction currency amounts to functional currency. May be spot rate, average rate, or historical rate depending on the nature of the GL account per IAS 21.',
    `exchange_rate_type` STRING COMMENT 'Type of exchange rate applied for currency conversion. Spot rate for monetary items, average rate for income statement items, historical rate for non-monetary items, closing rate for balance sheet translation.. Valid values are `spot|average|historical|closing`',
    `extraction_timestamp` TIMESTAMP COMMENT 'Timestamp when this trial balance record was extracted from the source system and loaded into the data lakehouse. Supports data lineage and freshness tracking.',
    `functional_closing_balance_credit` DECIMAL(18,2) COMMENT 'Closing credit balance converted to the functional currency of the legal entity. Used for consolidated financial statements and regulatory reporting.',
    `functional_closing_balance_debit` DECIMAL(18,2) COMMENT 'Closing debit balance converted to the functional currency of the legal entity. Used for consolidated financial statements and regulatory reporting.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency of the legal entity as defined under IAS 21. Used for consolidation and reporting.. Valid values are `^[A-Z]{3}$`',
    `functional_opening_balance_credit` DECIMAL(18,2) COMMENT 'Opening credit balance converted to the functional currency of the legal entity using the appropriate exchange rate. Used for consolidation and group reporting.',
    `functional_opening_balance_debit` DECIMAL(18,2) COMMENT 'Opening debit balance converted to the functional currency of the legal entity using the appropriate exchange rate. Used for consolidation and group reporting.',
    `functional_period_credit_activity` DECIMAL(18,2) COMMENT 'Period credit activity converted to the functional currency of the legal entity. Supports multi-currency consolidation and reporting under IFRS/GAAP.',
    `functional_period_debit_activity` DECIMAL(18,2) COMMENT 'Period debit activity converted to the functional currency of the legal entity. Supports multi-currency consolidation and reporting under IFRS/GAAP.',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this trial balance line includes intercompany transactions that require elimination during consolidation under IFRS 10 / FASB ASC 810.',
    `notes` STRING COMMENT 'Free-text field for capturing explanatory notes, reconciliation comments, or audit observations related to this trial balance line. Supports documentation requirements for financial close and audit.',
    `opening_balance_credit` DECIMAL(18,2) COMMENT 'Credit balance brought forward from the prior accounting period for this GL account. Represents the beginning balance for the current period.',
    `opening_balance_debit` DECIMAL(18,2) COMMENT 'Debit balance brought forward from the prior accounting period for this GL account. Represents the beginning balance for the current period.',
    `period_credit_activity` DECIMAL(18,2) COMMENT 'Total credit transactions posted to this GL account during the current accounting period. Includes journal entries from all subledgers and manual adjustments.',
    `period_debit_activity` DECIMAL(18,2) COMMENT 'Total debit transactions posted to this GL account during the current accounting period. Includes journal entries from all subledgers and manual adjustments.',
    `reconciled_by` STRING COMMENT 'User ID or name of the individual who performed the account reconciliation. Supports segregation of duties and audit trail requirements under SOX.',
    `reconciliation_date` DATE COMMENT 'Date on which the account reconciliation was completed and approved. Critical for SOX compliance and audit trail documentation.',
    `reconciliation_status` STRING COMMENT 'Status of the account reconciliation process for this GL account and period. Tracks whether the balance has been reconciled to subledgers, supporting documentation, and external statements per SOX requirements.. Valid values are `not_started|in_progress|reconciled|exception|approved`',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this trial balance data was extracted (e.g., Oracle Financials, SAP S/4HANA, subledger system). Supports data lineage and audit trail.',
    CONSTRAINT pk_trial_balance PRIMARY KEY(`trial_balance_id`)
) COMMENT 'Period-end trial balance snapshot capturing the debit and credit balances for every active GL account within a ledger and legal entity for a specific accounting period. Captures ledger, legal entity, accounting period, GL account, cost center, currency, opening balance, period debit activity, period credit activity, closing balance, functional currency equivalent, and balance type (actual, budget, forecast). Serves as the foundation for financial statement preparation under IFRS/GAAP.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: intercompany_transaction stores accounting_period as STRING but should FK to accounting_period table. Intercompany transactions are recorded in specific accounting periods and need proper temporal lin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: intercompany_transaction has cost_center_code (STRING) as a text reference to the cost center associated with the transaction. Normalizing this to cost_center_id → cost_center.cost_center_id establish',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the consolidation journal entry that eliminated this intercompany transaction during the financial close process.',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: Intercompany eliminations and transfer pricing documentation require the specific exchange rate used for each cross-currency intercompany transaction. Tax authorities and consolidation auditors requir',
    `matched_transaction_id` BIGINT COMMENT 'Identifier of the corresponding intercompany transaction record in the counterparty legal entity that matches this transaction for reconciliation purposes.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: intercompany_transaction has originating_gl_account_code (STRING) referencing the GL account on the originating entity side of the intercompany transaction. Normalizing to originating_gl_account_id → ',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that initiated or originated the intercompany transaction.',
    `primary_intercompany_counterparty_legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that is the counterparty or receiving entity in the intercompany transaction.',
    `reversed_transaction_intercompany_transaction_id` BIGINT COMMENT 'Identifier of the original intercompany transaction that this record reverses, if applicable.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Intercompany transactions are subject to specific tax jurisdictions for withholding tax and transfer pricing compliance; this link enables accurate tax calculation and regulatory reporting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Transfer pricing documentation and withholding tax calculations require linking intercompany transactions to the specific jurisdictions regulatory framework, netting enforceability rules, and tax tre',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Intercompany transactions occur in specific currencies; this link enables accurate intercompany reconciliation, elimination processing, and transfer pricing documentation in multi-currency banking gro',
    `approval_status` STRING COMMENT 'Current approval status of the intercompany transaction within the internal control and authorization workflow.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was approved by the authorized user.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division within the originating legal entity responsible for the intercompany transaction.',
    `counterparty_gl_account_code` STRING COMMENT 'The general ledger account code in the counterparty legal entity where the intercompany transaction is recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in the system.',
    `elimination_period` STRING COMMENT 'The fiscal period in which the intercompany transaction was or will be eliminated during the consolidation process.',
    `elimination_status` STRING COMMENT 'Current status of the intercompany transaction in the consolidation elimination process.. Valid values are `pending|eliminated|partially_eliminated|not_required|reconciliation_required`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction amount from transaction currency to functional currency.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction converted to the functional currency of the originating legal entity.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency of the originating legal entity for reporting purposes.. Valid values are `^[A-Z]{3}$`',
    `intercompany_transaction_description` STRING COMMENT 'Detailed textual description of the intercompany transaction, including business purpose and context.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last updated or modified.',
    `netting_agreement_reference` STRING COMMENT 'Reference to the intercompany netting or settlement agreement that governs the offsetting of this transaction with other intercompany balances.',
    `product_line_code` STRING COMMENT 'Code identifying the product line or service category associated with the intercompany transaction for profitability analysis.',
    `reconciliation_date` DATE COMMENT 'The date on which the intercompany transaction was reconciled and confirmed between both legal entities.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the intercompany transaction has been successfully reconciled between the originating and counterparty legal entities.. Valid values are `matched|unmatched|disputed|resolved|pending_review`',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this intercompany transaction is a reversal or correction of a previously recorded transaction.',
    `settlement_date` DATE COMMENT 'The date on which the intercompany transaction was or will be settled through cash payment or netting arrangement.',
    `settlement_method` STRING COMMENT 'The method by which the intercompany transaction will be settled between the legal entities.. Valid values are `cash|netting|offset|deferred|other`',
    `source_system_code` STRING COMMENT 'Code identifying the source system or application from which the intercompany transaction originated (e.g., Oracle Financials, SAP S/4HANA).',
    `source_system_transaction_reference` STRING COMMENT 'The unique transaction identifier from the originating source system, used for traceability and reconciliation.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the transaction currency.',
    `transaction_date` DATE COMMENT 'The date on which the intercompany transaction occurred or was executed in the business.',
    `transaction_reference_number` STRING COMMENT 'External business reference number or identifier for the intercompany transaction, used for reconciliation and audit trail purposes.',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the financial activity between legal entities. [ENUM-REF-CANDIDATE: loan|fee|dividend|transfer|recharge|interest|service|royalty|capital_contribution|other — 10 candidates stripped; promote to reference product]',
    `transfer_pricing_documentation_reference` STRING COMMENT 'Reference to the transfer pricing documentation or study that supports the pricing of this intercompany transaction for tax compliance.',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied to determine the arms length price for this intercompany transaction in accordance with tax regulations.. Valid values are `comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin|other`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax applied to the intercompany transaction in accordance with applicable tax treaties and regulations.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The percentage rate of withholding tax applied to the intercompany transaction, expressed as a decimal (e.g., 15.00 for 15%).',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Record of a financial transaction between two legal entities within the banking group requiring intercompany elimination during consolidation. Captures transaction reference, originating legal entity, counterparty legal entity, transaction type (loan, fee, dividend, transfer, recharge), transaction date, accounting period, currency, transaction amount, GL account (originating), GL account (counterparty), elimination status, elimination period, and netting agreement reference. Supports IFRS 10 consolidation and intercompany reconciliation.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for the profit center entity.',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Profit centers operate in functional currencies for P&L tracking; this link enables accurate profitability analysis, management reporting, and multi-currency performance measurement in banking operati',
    `legal_entity_id` BIGINT COMMENT 'FK to ledger.legal_entity',
    `parent_profit_center_id` BIGINT COMMENT 'FK to ledger.profit_center',
    `alternate_profit_center_code` STRING COMMENT 'Secondary or legacy profit center code used for cross-system mapping, migration tracking, or external reporting. Supports integration with legacy systems and external partners.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The annual budgeted profit or loss target for this profit center in the reporting currency. Used for performance measurement and variance analysis.',
    `consolidation_group` STRING COMMENT 'The consolidation group or reporting entity to which this profit centers financial results are consolidated. Used for group-level financial statement preparation and intercompany elimination.',
    `cost_allocation_method` STRING COMMENT 'The methodology used to allocate costs to this profit center. Direct allocation assigns costs directly incurred. Step-down, reciprocal, and activity-based methods distribute shared costs based on cost drivers and allocation keys.. Valid values are `direct|step_down|reciprocal|activity_based|proportional|driver_based`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'The date on which this profit center ceased operations or was closed. Null for currently active profit centers. Used for historical reporting and lifecycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this profit center became active and began accumulating financial results. Used for historical reporting and lifecycle management.',
    `ftp_rate_assignment` STRING COMMENT 'The FTP methodology assigned to this profit center for internal pricing of funds. Matched maturity assigns rates based on asset/liability duration. Pooled and blended methods use average rates. Critical for accurate profitability measurement in banking.. Valid values are `matched_maturity|pooled|blended|market_based|cost_of_funds|custom`',
    `geographic_region` STRING COMMENT 'The primary geographic region or country where this profit center operates, using ISO 3166-1 alpha-3 country code. Used for geographic segment reporting and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `hierarchy_level` STRING COMMENT 'The level of this profit center within the organizational hierarchy. Level 1 represents top-level profit centers, with increasing numbers for deeper levels. Used for hierarchical reporting and aggregation.',
    `ifrs_segment_flag` BOOLEAN COMMENT 'Indicates whether this profit center represents a reportable operating segment under IFRS 8. True for segments that meet the quantitative thresholds or are otherwise disclosed separately in financial statements.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this profit center engages in intercompany transactions that require elimination during consolidation. True for profit centers with significant cross-entity activity.',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who last modified this profit center record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `lob_classification` STRING COMMENT 'The primary line of business classification for this profit center, aligning with the banks strategic business segments and regulatory reporting requirements. [ENUM-REF-CANDIDATE: retail_banking|commercial_banking|investment_banking|wealth_management|treasury|capital_markets|asset_management|corporate_trust|payment_services|other — 10 candidates stripped; promote to reference product]',
    `profit_center_code` STRING COMMENT 'The externally-known unique business identifier for the profit center, used in financial reporting and management accounting. Typically alphanumeric code assigned by the finance organization.. Valid values are `^[A-Z0-9]{4,12}$`',
    `profit_center_description` STRING COMMENT 'Detailed textual description of the profit centers business purpose, scope of operations, and strategic objectives. Provides context for financial analysis and reporting.',
    `profit_center_name` STRING COMMENT 'The full business name or title of the profit center, used for display and reporting purposes.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active profit centers are operational and accumulate PnL. Inactive or closed profit centers are no longer operational but retained for historical reporting.. Valid values are `active|inactive|pending|closed|suspended|merged`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by organizational dimension. Indicates whether the profit center represents a banking segment (retail, commercial, investment banking), product line (loans, deposits, trading), geographic region, business unit, legal entity, or functional area.. Valid values are `banking_segment|product_line|geographic_region|business_unit|legal_entity|functional_area`',
    `raroc_target_rate` DECIMAL(18,2) COMMENT 'The target RAROC rate (expressed as a decimal, e.g., 0.1500 for 15%) set for this profit center. Used to evaluate whether the profit center is generating adequate returns relative to the economic capital allocated to it.',
    `regulatory_reporting_category` STRING COMMENT 'Classification of the profit center for regulatory capital and risk reporting purposes. Banking book includes traditional lending and deposit activities. Trading book includes market-making and proprietary trading.. Valid values are `banking_book|trading_book|off_balance_sheet|other`',
    `reporting_currency` STRING COMMENT 'The currency in which this profit centers results are reported for consolidation and group reporting purposes, using ISO 4217 three-letter currency code. May differ from functional currency for foreign operations.. Valid values are `^[A-Z]{3}$`',
    `responsible_executive` STRING COMMENT 'Name or identifier of the executive or senior manager accountable for the profit centers financial performance and strategic objectives.',
    `revenue_allocation_method` STRING COMMENT 'The methodology used to allocate revenue to this profit center. Direct allocation assigns revenue from transactions directly attributable to the profit center. Proportional, activity-based, and FTP-based methods distribute shared revenue based on defined allocation keys.. Valid values are `direct|proportional|activity_based|ftp_based|market_based|negotiated`',
    `rwa_category` STRING COMMENT 'The primary risk category for RWA calculation and capital allocation. Determines how this profit centers activities contribute to the banks total risk-weighted assets under Basel III.. Valid values are `credit_risk|market_risk|operational_risk|cvr_risk|other`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this profit center is subject to SOX financial controls and requires enhanced documentation, segregation of duties, and audit trails. True for profit centers with material financial impact.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this profit center record in the system. Used for audit trail and accountability.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Management accounting unit representing a discrete business segment or line of business (LOB) that is measured on profitability, enabling PnL attribution and RAROC reporting. Captures profit center code, profit center name, profit center type (banking segment, product line, geographic region), responsible executive, legal entity, LOB classification, FTP rate assignment, revenue allocation method, cost allocation method, parent profit center, hierarchy level, and active status. Supports segment reporting under IFRS 8 and management accounting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ADD CONSTRAINT `fk_ledger_chart_of_accounts_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ADD CONSTRAINT `fk_ledger_chart_of_accounts_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ADD CONSTRAINT `fk_ledger_chart_of_accounts_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `banking_ecm`.`ledger`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_reversed_journal_entry_id` FOREIGN KEY (`reversed_journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_reversed_line_journal_entry_line_id` FOREIGN KEY (`reversed_line_journal_entry_line_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_primary_ultimate_parent_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_matched_transaction_id` FOREIGN KEY (`matched_transaction_id`) REFERENCES `banking_ecm`.`ledger`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_primary_intercompany_counterparty_legal_entity_id` FOREIGN KEY (`primary_intercompany_counterparty_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_reversed_transaction_intercompany_transaction_id` FOREIGN KEY (`reversed_transaction_intercompany_transaction_id`) REFERENCES `banking_ecm`.`ledger`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`ledger` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `banking_ecm`.`ledger` SET TAGS ('dbx_domain' = 'ledger');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'Account Subtype Classification');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type Classification');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `alternate_account_code` SET TAGS ('dbx_business_glossary_term' = 'Alternate Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Category');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow_statement|statement_of_changes_in_equity');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Classification');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `ifrs_classification` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Classification');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Direction');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `parent_account_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Posting Allowed Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `risk_weighted_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Asset (RWA) Category');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `statistical_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `tax_line_mapping` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Line Item Mapping');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `parent_account_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'Account Category');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Account Subcategory');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `alternate_account_code` SET TAGS ('dbx_business_glossary_term' = 'Alternate Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `budget_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `financial_statement_line_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `natural_balance` SET TAGS ('dbx_business_glossary_term' = 'Natural Balance');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `natural_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `revaluation_flag` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `statistical_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `tax_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `third_party_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Control Flag');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `reversed_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `adjustment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `batch_name` SET TAGS ('dbx_business_glossary_term' = 'Batch Name');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `functional_total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Total Credit Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `functional_total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Total Debit Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_category` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Category');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_source` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Source');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'unposted|posted|reversed|voided');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Reference');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `statistical_indicator` SET TAGS ('dbx_business_glossary_term' = 'Statistical Indicator');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `subledger_source_system` SET TAGS ('dbx_business_glossary_term' = 'Subledger Source System');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `subledger_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Subledger Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Banking Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Entered Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `reversed_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Line Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `business_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Business Segment Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `business_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `entered_amount` SET TAGS ('dbx_business_glossary_term' = 'Entered Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|historical|budget|custom');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `intercompany_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Entity Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `intercompany_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|voided');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `statistical_amount` SET TAGS ('dbx_business_glossary_term' = 'Statistical Amount');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `statistical_unit` SET TAGS ('dbx_business_glossary_term' = 'Statistical Unit of Measure');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `subledger_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Type');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` SET TAGS ('dbx_subdomain' = 'entity_structure');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Calendar Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `accounting_period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `adjustment_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Flag');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `budget_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Flag');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `close_sequence` SET TAGS ('dbx_business_glossary_term' = 'Period Close Sequence Number');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Period Closed Date');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Period Flag');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Period Flag');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Period Opened Date');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Name');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'future_enterable|open|closed|permanently_closed|never_opened');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'standard|adjustment|year_end|opening');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `permanently_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Period Permanently Closed Date');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `quarter_number` SET TAGS ('dbx_business_glossary_term' = 'Quarter Number');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Flag');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `sox_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Certification Date');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `sox_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Certification Flag');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `year_end_flag` SET TAGS ('dbx_business_glossary_term' = 'Year-End Period Flag');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `basel_business_line` SET TAGS ('dbx_business_glossary_term' = 'Basel Business Line');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'cost_center|revenue_center|profit_center|investment_center|shared_service|support_unit');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `ftp_rate_assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate Assignment Method');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `ftp_rate_assignment_method` SET TAGS ('dbx_value_regex' = 'matched_maturity|pooled|blended|market_based|cost_of_funds|custom');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `ftp_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate Percentage');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `gl_account_range_end` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range End');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `gl_account_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `gl_account_range_start` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range Start');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `gl_account_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `ifrs8_reportable_segment_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 8 Reportable Segment Flag');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Method');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|headcount|revenue_driver|custom');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `sox_control_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Scope Flag');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|resale_minus|profit_split|not_applicable');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` SET TAGS ('dbx_subdomain' = 'entity_structure');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Of Incorporation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `ccar_dfast_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) / Dodd-Frank Act Stress Testing (DFAST) Entity Flag');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'FULL|EQUITY|PROPORTIONAL|NONE');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `country_of_domicile` SET TAGS ('dbx_business_glossary_term' = 'Country of Domicile');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `country_of_domicile` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `crs_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reporting Flag');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `fatca_giin` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Global Intermediary Identification Number (GIIN)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `fatca_giin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}.[A-Z0-9]{5}.[A-Z]{2}.[0-9]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `last_audit_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Opinion Date');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `last_audit_opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Opinion Type');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `last_audit_opinion_type` SET TAGS ('dbx_value_regex' = 'UNQUALIFIED|QUALIFIED|ADVERSE|DISCLAIMER');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|DORMANT|LIQUIDATION|DISSOLVED');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `primary_regulator` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulator');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_reporting_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Entity Flag');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'REGULATED|NON_REGULATED|EXEMPT|PENDING');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` SET TAGS ('dbx_subdomain' = 'entity_structure');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Banking Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `auto_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Reconciliation Flag');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Subledger Balance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_account_range_end` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range End');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_account_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_account_range_start` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range Start');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_account_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_posted_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posted Balance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_transfer_method` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Transfer Method');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_transfer_method` SET TAGS ('dbx_value_regex' = 'batch|real_time|scheduled|manual');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `posting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Posting Frequency');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `posting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|in_progress|exception|escalated|pending_review');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `resolution_actions` SET TAGS ('dbx_business_glossary_term' = 'Resolution Actions');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_code` SET TAGS ('dbx_business_glossary_term' = 'Subledger Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_name` SET TAGS ('dbx_business_glossary_term' = 'Subledger Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Type');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `variance_root_cause` SET TAGS ('dbx_business_glossary_term' = 'Variance Root Cause');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `trial_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Balance ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|audited|adjusted');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'actual|budget|forecast|adjusted|restated|pro_forma');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `closing_balance_credit` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance Credit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `closing_balance_debit` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance Debit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|historical|closing');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `extraction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Extraction Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_closing_balance_credit` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Closing Balance Credit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_closing_balance_debit` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Closing Balance Debit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_opening_balance_credit` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Opening Balance Credit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_opening_balance_debit` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Opening Balance Debit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_period_credit_activity` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Period Credit Activity');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `functional_period_debit_activity` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Period Debit Activity');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `opening_balance_credit` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Credit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `opening_balance_debit` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Debit');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `period_credit_activity` SET TAGS ('dbx_business_glossary_term' = 'Period Credit Activity');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `period_debit_activity` SET TAGS ('dbx_business_glossary_term' = 'Period Debit Activity');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `reconciled_by` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|reconciled|exception|approved');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'entity_structure');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Elimination Journal Entry ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `matched_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `primary_intercompany_counterparty_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reversed_transaction_intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `counterparty_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `elimination_period` SET TAGS ('dbx_business_glossary_term' = 'Elimination Period');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|partially_eliminated|not_required|reconciliation_required');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `netting_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Reference');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|disputed|resolved|pending_review');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'cash|netting|offset|deferred|other');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `source_system_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Documentation Reference');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin|other');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `alternate_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Alternate Profit Center Code');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|step_down|reciprocal|activity_based|proportional|driver_based');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `ftp_rate_assignment` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate Assignment');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `ftp_rate_assignment` SET TAGS ('dbx_value_regex' = 'matched_maturity|pooled|blended|market_based|cost_of_funds|custom');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `ifrs_segment_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Segment Flag');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `lob_classification` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Classification');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended|merged');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'banking_segment|product_line|geographic_region|business_unit|legal_entity|functional_area');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `raroc_target_rate` SET TAGS ('dbx_business_glossary_term' = 'Risk-Adjusted Return on Capital (RAROC) Target Rate');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_value_regex' = 'banking_book|trading_book|off_balance_sheet|other');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `responsible_executive` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Method');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|activity_based|ftp_based|market_based|negotiated');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `rwa_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Category');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `rwa_category` SET TAGS ('dbx_value_regex' = 'credit_risk|market_risk|operational_risk|cvr_risk|other');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
